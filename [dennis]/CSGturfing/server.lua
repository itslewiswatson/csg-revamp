local turfRadarArea = {}
local turfColArea = {}
local turfingTimersStart = {}
local turfingTimersAttack = {}
local turfProvocationTimer = {}
local turfAttackGroup = {}
local turfGroups = {}

-- Create the turfs when the resource gets started
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
function ()
    local CSGTurfs = exports.DENmysql:query( "SELECT * FROM turfing" )
    if ( CSGTurfs ) and ( #CSGTurfs > 0 ) then
        for i=1,#CSGTurfs do
			turfRadarArea[i] = createRadarArea ( CSGTurfs[i].leftx, CSGTurfs[i].bottomy, CSGTurfs[i].sizex, CSGTurfs[i].sizey, CSGTurfs[i].r, CSGTurfs[i].g, CSGTurfs[i].b, 180 )
			turfColArea[i] = createColRectangle ( CSGTurfs[i].leftx, CSGTurfs[i].bottomy, CSGTurfs[i].sizex, CSGTurfs[i].sizey )
			setElementData( turfColArea[i], "turfID", i )

			addEventHandler ( "onColShapeHit", turfColArea[i], onHitTurfZone )
			addEventHandler ( "onColShapeLeave", turfColArea[i], onLeaveTurfZone )
		end
	end
	CSGTurfingTable = CSGTurfs
end
)

-- When a turfer dies spawn him at a turf owned by the group
addEventHandler( "onPlayerWasted", root,
function ()
	if ( getElementData ( source, "isPlayerInLvCol" ) ) then
		triggerClientEvent( source, "onClientTurferDied", source, CSGTurfingTable, turfAttackGroup )
	end
end
)

function onHitTurfZone ( hitElement, matchingDimension )
	local turfNumber = getElementData ( source, "turfID" )

    if ( canElementTurf ( hitElement ) ) then
		local thePlayerGroup = getElementData ( hitElement, "Group" )
		if turfGroups[turfNumber] then
			table.insert ( turfGroups[turfNumber], thePlayerGroup )
		else
			turfGroups[turfNumber] = { thePlayerGroup }
		end

        if not ( turfAttackGroup[turfNumber] ) and CSGTurfingTable[turfNumber].turfowner ~= thePlayerGroup then
			turfProvocationTimer[turfNumber] = setTimer ( startTurfWar, 10000, 1, turfNumber, thePlayerGroup, hitElement ) -- Timer voor dat voorbereiding begint is dit (10sec)
		end
		setElementData ( hitElement, "turfID", turfNumber )
	end

	if getElementType ( hitElement ) == "player" then
		local gangName = CSGTurfingTable[turfNumber].turfowner
		local message = "You entered the turf of " .. gangName .. "."
		if not gangName or gangName == "" then
			message = "You entered a unoccupied turf."
		elseif gangName == getElementData ( hitElement, "Group" ) then
			message = "You entered a turf owned by your group: " .. gangName .. "."
		end
		exports.DENdxmsg:createNewDxMessage(hitElement, message, 0, 230, 0)
	end
end

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


addEventHandler( "onPlayerQuit", root,
function ()
	local turfID = getElementData ( source, "turfID" )
	if ( getPlayerTeam(source) ) and (getTeamName(getPlayerTeam(source)) == "Criminals") and (getElementData(source, "Group")) and turfID then
		local thePlayerGroup = getElementData ( source, "Group" )
		if getGroupWithHighestCount(turfID) then
			if ( getGroupWithHighestCount(turfID) == turfAttackGroup[turfID] ) then
				stopTurfAttack(turfID)
			elseif not ( getGroupWithHighestCount(turfID) == CSGTurfingTable[turfID].turfowner ) then
				setGroupAttacking (turfID, getGroupWithHighestCount(turfID) )
			end
		else
			stopTurfAttack(turfID)
		end
	end
end
)

function turferDied ()
	local thePlayerGroup = getElementData ( source, "Group" )
	local playerTurf = getPlayerTurf(source)
	if ( getPlayerTeam(source) ) and (getTeamName(getPlayerTeam(source)) == "Criminals") and (getElementData(source, "Group")) then
		if playerTurf and thePlayerGroup and turfAttackGroup[playerTurf] == thePlayerGroup then
			if getPlayersFromGroupInTurf ( thePlayerGroup, playerTurf ) <= 0 then
				if getGroupWithHighestCount(playerTurf) and getGroupWithHighestCount(playerTurf) ~= CSGTurfingTable[playerTurf].turfowner then
					setGroupAttacking(getGroupWithHighestCount(playerTurf))
				else
					stopTurfAttack(playerTurf)
				end
			end
		end
	end
	setElementData ( source, "turfID", nil )
end
addEventHandler ( "onPlayerWasted", root, turferDied )

function getPlayerTurf ( player )
	if getElementData ( player, "turfID" ) then
		return getElementData ( player, "turfID" )
	end
	return false
end

function getGroupWithHighestCount( turfID )
	local groupCount = 0
	local highestGroup = false
	if turfGroups[turfID] then
		for i,group in ipairs(turfGroups[turfID]) do
			if getPlayersFromGroupInTurf ( group, turfID ) > groupCount then
				highestGroup = group
			end
		end
	end
	return highestGroup
end

function getPlayersFromGroupInTurf ( group, turfID )
	local turf = turfColArea[turfID]
	local playerCount = 0
    for i, player in ipairs(getElementsByType("player")) do
        if getElementData ( player, "Group" ) == group and canElementTurf ( player ) and (getTeamName(getPlayerTeam(player)) == "Criminals") then
			if not isPedDead(player) then
				if isElementWithinColShape ( player, turf ) then
					playerCount = playerCount+1
				end
			end
		end
	end
    return playerCount
end

function onStartTurfAttack (turfID, group)
	local oldGroup = CSGTurfingTable[turfID].turfowner
	local newGroup = turfAttackGroup[turfID]

	triggerEvent( "onStartTurfAttack", root, oldGroup, newGroup, turfID )
	local col = turfColArea[turfID]
	local t = getElementsWithinColShape(col,"player")
	local faster=false
	local rank = false
	for k,v in pairs(t) do
		if getElementData(v,"Rank") == "Don of LV" or getElementData(v,"Rank") == "Capo" then
			if getElementData( v, "Group" ) == group then
				faster=true
				rank=getElementData(v,"Rank")
				break
			end
		end
	end
	if faster == true then
		if rank == "Don of LV" then
			turfingTimersAttack[turfID] = setTimer ( onTurfTakenOver, 130000, 1, turfID )
		else
			turfingTimersAttack[turfID] = setTimer ( onTurfTakenOver, 150000, 1, turfID )
		end
	else
		turfingTimersAttack[turfID] = setTimer ( onTurfTakenOver, 180000, 1, turfID ) -- de attack, na voorbereiding (3min)
	end
	local radarArea = turfRadarArea[turfID]

	setRadarAreaFlashing( radarArea, true )
	local newGroupName = newGroup
	local attackerMSG = "Your group is attacking a turf from " .. oldGroup .. ", go help them!"
	if not oldGroup or oldGroup == "" then
	attackerMSG = "Your group is attacking a unoccupied turf, go help them!"
	end

	for i, player in ipairs(getElementsByType("player")) do
		if oldGroup and ( getElementData( player, "Group" ) == oldGroup ) then
			exports.DENdxmsg:createNewDxMessage (player, "Your turf is being attacked by " .. newGroupName .. ", go defend it!", 255, 0, 0 )
		elseif ( getElementData( player, "Group" ) == newGroup ) and newGroup ~= oldGroup then
			exports.DENdxmsg:createNewDxMessage (player, attackerMSG, 255, 0, 0 )
		end
	end
end

function onTurfTakenOver ( turfID )

	local oldGroup = CSGTurfingTable[turfID].turfowner
	local newGroup = turfAttackGroup[turfID]
	CSGTurfingTable[turfID].turfowner = newGroup
	local radarArea = turfRadarArea[turfID]
	setRadarAreaFlashing ( radarArea, false )

	triggerEvent( "onTurfCaptured", root, oldGroup, newGroup, turfID )

	local turfColorString = exports.server:getGroupColor(newGroup)
	local turfColorTable = exports.server:stringExplode(turfColorString, ",")
	local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
	setRadarAreaColor ( radarArea, tonumber(r), tonumber(g), tonumber(b), 180 )

	exports.DENmysql:exec( "UPDATE turfing SET turfowner=?, r=?, g=?, b=?  WHERE turfid=?"
                ,newGroup
                ,r
                ,g
                ,b
				,turfID
        )

	local newGroupName = newGroup or "Unoccupied"
	local oldGroupName = oldGroup or "Unoccupied"
	for i, player in ipairs(getElementsByType("player")) do
		local attackerMSG = "Your group has captured a turf from " .. oldGroupName .. "!"
		if not oldGroup or oldGroup == "" then
			attackerMSG = "Your group has captured a unoccupied turf!"
		end

		if oldGroup and ( getElementData( player, "Group" ) == oldGroup ) then
			exports.DENdxmsg:createNewDxMessage (player, "Your turf has been captured by " .. newGroupName .. "!", 255, 0, 0 )
		elseif ( getElementData( player, "Group" ) == newGroup ) and newGroup ~= oldGroup then
			exports.DENdxmsg:createNewDxMessage (player, attackerMSG, 255, 0, 0 )
		end

		if ( turfColArea[turfID] ) and ( newGroup ) and ( isElementWithinColShape ( player, turfColArea[turfID] ) ) and ( getElementData( player, "Group" ) == newGroup ) and (getTeamName(getPlayerTeam(player)) == "Criminals") then
			givePlayerMoney(player, 3000)
			exports.CSGscore:givePlayerScore(player,1)
		end
	end
	stopTurfAttack(turfID)
end

function setGroupAttacking ( turfID, group )
	if isTimer ( turfingTimersStart[turfID] ) then killTimer ( turfingTimersStart[turfID] ) end
	if isTimer ( turfingTimersAttack[turfID] ) then killTimer ( turfingTimersAttack[turfID] ) end

	turfingTimersStart[turfID] = setTimer( onStartTurfAttack, 120000, 1, turfID, group ) -- voorbereiding is dit dus 2 min
	turfAttackGroup[turfID] = group
end

function onLeaveTurfZone ( leaveElement, matchingDimension )
	local turfID = getPlayerTurf(leaveElement)
	if canElementTurf ( leaveElement ) and turfID then
		local thePlayerGroup = getElementData ( leaveElement, "Group" )
		if getGroupWithHighestCount(turfID) and  getGroupWithHighestCount(turfID) ~= CSGTurfingTable[turfID].turfowner then
			if ( getGroupWithHighestCount(turfID) ~= turfAttackGroup[turfID] ) then
				setGroupAttacking (turfID, getGroupWithHighestCount(turfID) )
			elseif getGroupWithHighestCount(turfID) and getGroupWithHighestCount(turfID) == CSGTurfingTable[turfID].turfowner then
				stopTurfAttack(turfID)
			end
		else
			stopTurfAttack(turfID)
		end
	end
	setElementData ( leaveElement, "turfID", nil )
end

function stopTurfAttack(turfID)
	if turfID then
		if isTimer ( turfingTimersStart[turfID] ) then killTimer ( turfingTimersStart[turfID] ) end
		if isTimer ( turfingTimersAttack[turfID] ) then killTimer ( turfingTimersAttack[turfID] ) end
		if isTimer(turfProvocationTimer[turfID]) then killTimer(turfProvocationTimer[turfID]) end
		turfAttackGroup[turfID] = nil
		turfGroups[turfID] = nil
		local radarArea = turfRadarArea[turfID]
		setRadarAreaFlashing( radarArea, false )
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
	for i=1,#CSGTurfingTable do
		if CSGTurfingTable[i].turfowner and CSGTurfingTable[i].turfowner ~= "" then
			if CSGTurfingTable[i].turfowner == group then
				setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 180 )
				CSGTurfingTable[i].r = r
				CSGTurfingTable[i].g = g
				CSGTurfingTable[i].b = b
			end
		end
	end
end
addEventHandler ( "onGroupChangeColor", root, setNewTurfColor )
