local turfRadarArea = {}
local turfColArea = {}
local turfingTimersStart = {}
local turfingTimersAttack = {}
local turfProvocationTimer = {}
local turfAttackGroup = {}
local turfGroups = {}
local turfData = {}
-- Create the turfs when the resource gets started
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
function ()
    local CSGTurfs = exports.DENmysql:query( "SELECT * FROM turfing" )
    if ( CSGTurfs ) and ( #CSGTurfs > 0 ) then
        for i=1,#CSGTurfs do
			turfRadarArea[i] = createRadarArea ( CSGTurfs[i].leftx, CSGTurfs[i].bottomy, CSGTurfs[i].sizex, CSGTurfs[i].sizey, CSGTurfs[i].r, CSGTurfs[i].g, CSGTurfs[i].b, 180 )
			turfColArea[i] = createColRectangle ( CSGTurfs[i].leftx, CSGTurfs[i].bottomy, CSGTurfs[i].sizex, CSGTurfs[i].sizey )
			setElementData( turfColArea[i], "turfID", i )
			turfData[i] = {}
			if CSGTurfs[i].turfowner ~= "Unoccupied" then
			turfData[i].health=100
			turfData[i].mode="Owned"
			else
			turfData[i].health=15
			turfData[i].mode="Unoccupied"
			end
			turfData[i].owner=CSGTurfs[i].turfowner
			turfData[i].attackinggroup="None"
			turfData[i].col=turfColArea[i]
			turfData[i].influences = {}
			addEventHandler ( "onColShapeHit", turfColArea[i], onHitTurfZone )
			addEventHandler ( "onColShapeLeave", turfColArea[i], onLeaveTurfZone )
		end
	end
	CSGTurfingTable = CSGTurfs
end
)
local LVcol = createColRectangle(866,656,2100,2300)
-- When a turfer dies spawn him at a turf owned by the group
addEventHandler( "onPlayerWasted", root,
function ()
	if isElementWithinColShape(source,LVcol) == true then
		if getTeamName( getPlayerTeam( source ) ) ~= "Criminals" then return end
		local spawnTable = {}
		local myGroup = getElementData(source,"Group")
		for k,v in pairs(turfData) do
			if v.owner == myGroup and v.health > 55 then
				local x,y = getElementPosition(v.col)
				local z = 10
				table.insert(spawnTable,{x,y,z,k})
				outputDebugString("ff")
			end
		end
		triggerClientEvent( source, "onClientTurferDied", source, spawnTable )
	end
end
)


function onHitTurfZone ( hitElement, matchingDimension )
	local turfNumber = getElementData ( source, "turfID" )

	if getElementType ( hitElement ) == "player" then
		if canElementTurf(hitElement) == false then return end
		local gangName = turfData[turfNumber].owner
		local message = "You entered the turf of " .. gangName .. "."
		if not gangName or gangName == "" then
			message = "You entered a unoccupied turf."
		elseif gangName == getElementData ( hitElement, "Group" ) then
			message = "You entered a turf owned by your group: " .. gangName .. "."
		end
		exports.DENdxmsg:createNewDxMessage(hitElement, message, 0, 230, 0)
	end

end

--[[
function startTurfWar (turf, group, player)
	if getPlayersFromGroupInTurf ( group, turf ) >= 1 then
		setGroupAttacking ( turf, group )
		local gangName = CSGTurfingTable[turf].turfowner
		local message = "You started a attack on a turf from " .. gangName .. "."
		if not gangName or gangName == "" then
			message = "You started a attack on a unoccupied turf."
		end
		exports.DENdxmsg:createNewDxMessage(player, message, 0, 230, 0)
	end
end
--]]


doTurf = function()
for i,data in pairs(turfData) do
	local col = data.col
	local t = getElementsWithinColShape(col,"player")
	local groups = {}
	local biggestInfluenceGroup=""
	local biggestInfluence=0
	local first = {}
	local counted = {}
	local oldHealth = data.health
	for k,v in pairs(t) do
		local gr = getElementData(v,"Group")
		if gr ~= false then
			if groups[gr] == nil then groups[gr]=0 end
			if canElementTurf(v) == true and getTeamName(getPlayerTeam(v)) == "Criminals" then
				if first[gr] == nil then
					if counted[v] == nil then
					groups[gr] = groups[gr]+2
					counted[v]=true
					first[gr] = false
					end
				else
					if counted[v] == nil then
						groups[gr] = groups[gr]+1
						counted[v]=true
					end
				end
			end
		end
	end
	if data.mode == "Unoccupied" then
		if turfData[i].health <= 20 then
			for k,v in pairs(groups) do
				if v > biggestInfluence then
					biggestInfluenceGroup=k
					biggestInfluence=v
				end
			end
			data.attackinggroup=biggestInfluenceGroup
			turfData[i].attackinggroup=biggestInfluenceGroup
			--new attacking turf
		end
	end

	for k,v in pairs(groups) do
		if k ~= data.owner and k ~= data.attackinggroup then
			groups[k] = groups[k]*-1
		end
	end

	local isDiff=false
	if #groups > 1 then
		for k,v in pairs(groups) do
			for k2,v2 in pairs(groups) do
				if v2 ~= v then isDiff=true end
			end
		end
	end


	for k,v in pairs(groups) do
		turfData[i].health = turfData[i].health+v
	end
	if oldHealth == turfData[i].health or (#groups > 1 and isDiff==false) then
		data.attackinggroup="None"
		turfData[i].attackinggroup="None"
	end
	turfData[i].influences = groups
	if turfData[i].health > 100 then turfData[i].health=100 end
	if turfData[i].health < 0 then turfData[i].health=0 end

	if data.mode == "Owned" then
		if turfData[i].health <= 20 then
			turfData[i].mode="Unoccupied"
			turfData[i].oldRealGroup=turfData[i].owner
			turfData[i].owner="Unoccupied"
			turfData[i].attackinggroup="None"
			for k,v in pairs(getElementsByType("player")) do
				if getElementData(v,"Group") == turfData[i].oldRealGroup then
					local x,y = getElementPosition(turfData[i].col)
					local zoneName=getZoneName(x,y,10)
					exports.dendxmsg:createNewDxMessage(v,"Your turf at "..zoneName.." was under attack and has been lost!",255,0,0)
				end
			end
			exports.DENmysql:exec( "UPDATE turfing SET turfowner=?, r=?, g=?, b=?  WHERE turfid=?"
                ,turfData[i].owner
                ,255
                ,255
                ,255
				,i
			)
			--turf lost
		elseif oldHealth > 55 and turfData[i].health <= 55 then
			for k,v in pairs(getElementsByType("player")) do
				if getElementData(v,"Group") == turfData[i].owner then
					local x,y = getElementPosition(turfData[i].col)
					local zoneName=getZoneName(x,y,10)
					exports.dendxmsg:createNewDxMessage(v,"Your turf at "..zoneName.." is in danger of being lost, go defend it!",255,0,0)
				end
			end
		end
	elseif data.mode == "Unoccupied" then
		if turfData[i].health > 20 then
			data.mode="Attack in Progress"
			turfData[i].mode="Attack in Progress"
			for k,v in pairs(getElementsByType("player")) do
				if getElementData(v,"Group") == turfData[i].attackinggroup then
					local x,y = getElementPosition(turfData[i].col)
					local zoneName=getZoneName(x,y,10)
					exports.dendxmsg:createNewDxMessage(v,"Your group is attacking a turf at "..zoneName..", go help them!",255,0,0)
				end
			end
		end
	elseif turfData[i].mode == "Attack in Progress" then
		if turfData[i].health >= 55 then
			turfData[i].mode="Owned"
			turfData[i].owner=data.attackinggroup
			turfData[i].attackinggroup="None"
			--new turf owner
			local turfColorString = exports.server:getGroupColor(turfData[i].owner)
			local turfColorTable = exports.server:stringExplode(turfColorString, ",")
			local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
			setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 180 )
			exports.DENmysql:exec( "UPDATE turfing SET turfowner=?, r=?, g=?, b=?  WHERE turfid=?"
                ,turfData[i].owner
                ,r
                ,g
                ,b
				,i
			)
			for index, player in ipairs(getElementsByType("player")) do
				local oldGroup=turfData[i].oldRealGroup
				local attackerMSG = "Your group has captured a turf which was previously owned by " .. oldGroup .. "!"

				if oldGroup and ( getElementData( player, "Group" ) == oldGroup ) then
					--exports.DENdxmsg:createNewDxMessage (player, "Your turf has been captured by " .. newGroupName .. "!", 255, 0, 0 )
				elseif ( getElementData( player, "Group" ) == turfData[i].owner ) and turfData[i].owner ~= oldGroup then
					exports.DENdxmsg:createNewDxMessage (player, attackerMSG, 0, 255, 0 )
				end

				if ( turfColArea[i] ) and ( turfData[i].owner ) and ( isElementWithinColShape ( player, turfColArea[i] ) ) and ( getElementData( player, "Group" ) == turfData[i].owner ) then
					givePlayerMoney(player, 3000)
					exports.CSGscore:givePlayerScore(player,1)
				end
			end
		end
	end

	local toSend = turfData[i]
	toSend.oldHealth=oldHealth
	toSend.text=toSend.mode
	toSend.barText = ""
	toSend.colors = {}
	for k,v in pairs(groups) do
		local turfColorString = exports.server:getGroupColor(k)
		local turfColorTable = exports.server:stringExplode(turfColorString, ",")
		local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
		toSend.colors[k]={r,g,b}
	end
	if turfData[i].owner ~= "Unoccupied" then
		local turfColorString = exports.server:getGroupColor(turfData[i].owner)
		local turfColorTable = exports.server:stringExplode(turfColorString, ",")
		if type(turfColorTable) ~= "boolean" then
			local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
			toSend.colors[turfData[i].owner]= {r,g,b}
		end
	end
	if turfData[i].attackinggroup ~= "None" then
		toSend.barText="Attack in Progress by "..turfData[i].attackinggroup
		if turfData[i].health > 20 then
		setRadarAreaFlashing(turfRadarArea[i],true)
		--local r,g,b = toSend.colors[turfData[i].attackinggroup][1],toSend.colors[turfData[i].attackinggroup][2],toSend.colors[turfData[i].attackinggroup][3]
		setRadarAreaColor ( turfRadarArea[i], 255,255,255, 180 )
		end
	else
		toSend.barText=""..turfData[i].owner.." Turf"
		setRadarAreaFlashing(turfRadarArea[i],false)
		local r,g,b = 255,255,255
		if turfData[i].owner ~= "Unoccupied" then
			r,g,b = toSend.colors[turfData[i].owner][1],toSend.colors[turfData[i].owner][2],toSend.colors[turfData[i].owner][3]
		end
		setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 180 )
	end
	if turfData[i].health > 20 and turfData[i].health < 55 and turfData[i].mode=="Owned" then
		toSend.barText=""..turfData[i].owner.." Turf (In Danger)"
		setRadarAreaFlashing(turfRadarArea[i],true)
	end
	for k,v in pairs(t) do
		if canElementTurf(v) then
			triggerClientEvent(v,"recTurfData",v,toSend)
		end
	end
end
end
setTimer(doTurf,5000,0)

addEvent("CSGturfing.reqDefendingMoney",true)
addEventHandler("CSGturfing.reqDefendingMoney",root,function()
	givePlayerMoney(source,30)
	exports.CSGscore:givePlayerScore(source,0.0208333)
end)

function turferDied ()
	for k,v in pairs(turfData) do
		if isElementWithinColShape(source,v.col) then
			triggerClientEvent(source,"recTurfData",source,nil)
			return
		end
	end
end
addEventHandler ( "onPlayerWasted", root, turferDied )

function onLeaveTurfZone ( leaveElement, matchingDimension )
	if getElementType(leaveElement) == "player" then
		triggerClientEvent(leaveElement,"recTurfData",leaveElement,nil)
	end
end

function canElementTurf ( theElement )
	if getElementType ( theElement ) == "player" and (getTeamName(getPlayerTeam(theElement)) == "Criminals") and (getElementData(theElement, "Group")) then
		if getElementHealth ( theElement ) ~= 0 then
			if getPedOccupiedVehicle( theElement ) then
                local theVehicle = getPedOccupiedVehicle( theElement )
                if ( isElement(theVehicle) ) and getElementModel ( theVehicle ) == 509 or getElementModel ( theVehicle ) == 481 or getElementModel ( theVehicle ) == 510 then
                    return false
                else
                    return true
                end
            else
                return true
			end
		else
			return false
        end
	else
		return false
	end
end

addEvent( "onGroupChangeColor", true )
function setNewTurfColor (group, colorString)
	local turfColorTable = exports.server:stringExplode(colorString, ",")
	local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
	for i,v in pairs(turfData) do
		if v.owner == group then
				setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 180 )
		end
	end
end
addEventHandler ( "onGroupChangeColor", root, setNewTurfColor )
