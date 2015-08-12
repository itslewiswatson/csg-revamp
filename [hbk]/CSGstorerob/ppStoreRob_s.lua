
local markers = {}
local colshapes = {}
t = {
}

local burgerShotByStandersPos = {
	{361.59603881836,-66.979476928711,1001.5078125,273.15},
	{368.74624633789,-64.888481140137,1001.5078125,160},
}

function updateTimes()
    for k,v in pairs(t) do
        if v["timeUntilRob"] > 0 then
        v["timeUntilRob"] = v["timeUntilRob"] - 1
        end
        if v["robInProgress"] == 1 then
            if v["timeUntilRob"] == 0 then
                endRobbery(v)
            end
        end
    end
end
--update times timer
setTimer(updateTimes, 1000, 0)

function monitorRobber()
    for k,v in pairs(t) do
        if t[k]["robInProgress"] == 1 then
            local thePlayer = t[k]["theRobber"]
			if isElement(thePlayer) == false then endRobbery(k) return end
            if t[k]["theRobber"] ~= 0 then
                if getElementType(thePlayer) == "player" then
					if getElementInterior(thePlayer) == 0 then
						if isElement(t[k].moneyBag) == true then
							setElementInterior(t[k].moneyBag,0)
							setElementDimension(t[k].moneyBag,0)
						end
					end
                    if isArrested == 1 then
						local store = k
						triggerClientEvent(t[store]["theRobber"],"CSGstoreRobberiesShowRobberyDialog",root,0,true,"fail")
						exports.DENdxmsg:createNewDxMessage(t[store]["theRobber"],"Store Robbery : Failed!",255,0,0)
						endRobbery(k)
                    end
                    if getElementHealth(thePlayer) <= 0 then
						local store = k
						triggerClientEvent(t[store]["theRobber"],"CSGstoreRobberiesShowRobberyDialog",root,0,true,"fail")
						exports.DENdxmsg:createNewDxMessage(t[store]["theRobber"],"Store Robbery : Failed!",255,0,0)
						endRobbery(k)
                    end
                else
                endRobbery(k)
                end
            end
        end
    end
end
--monitor the robber
setTimer(monitorRobber, 1000, 0)

function isArrested()
	local p=source
    for k,v in pairs(t) do
        if p == t[k]["theRobber"] then
			local store = k
			triggerClientEvent(t[store]["theRobber"],"CSGstoreRobberiesShowRobberyDialog",root,0,true,"fail")
			exports.DENdxmsg:createNewDxMessage(t[store]["theRobber"],"Store Robbery : Failed!",255,0,0)
            endRobbery(k)
            return
        end
    end
end
addEvent("onPlayerArrest",true)
addEventHandler("onPlayerArrest",root,isArrested)

function endRobbery(store)
	if t[store] == nil then
		if markers[store] == nil then return end
		store = markers[store]
	end
    if t[store]["robInProgress"] == nil then
		t[store]["robInProgress"] = 0
    end
	setMarkerColor(markers[store],255,0,0,0)
	if isElement(t[store].moneyBag) then
		destroyElement(t[store].moneyBag)
	end
	if isElement(t[store].showModelPed) then
		setPedAnimation(t[store].showModelPed,false)
	end
	if isTimer(t[store]["bagSizeTimer"]) then
		killTimer(t[store]["bagSizeTimer"])
	end
    t[store]["robInProgress"] = 0
    t[store]["theRobber"] = 0
    t[store]["robbedMoney"] = 0
    t[store]["robberInCheckPoint"] = 0
    t[store]["randomRob"] = 0
end

function holdup1(thePlayer)
    if getElementDimension(thePlayer) == getElementDimension(source) then
        if isLaw(thePlayer) == false then
			exports.DENdxmsg:createNewDxMessage(thePlayer,"Type /holdup or /robstore to attempt a robbery.",255,0,0)
        end
    end
end

local lawTeams = {
	"Military Forces",
	"SWAT",
	"Police"
}

function warnCriminals(msg)
	local list = getPlayersInTeam(getTeamFromName("Criminals"))
	for k,v in pairs(list) do
		 exports.DENdxmsg:createNewDxMessage(v,msg,255,0,0)
	end
end

function isLaw(e)
	if getElementType(e) == "player" then else return false end
	local team = getTeamName(getPlayerTeam(e))
	for k,v in pairs(lawTeams) do if v == team then return true end end
	return false
end

function getLawTable()
	local law = {}
	for k,v in pairs (lawTeams) do
		local list = getPlayersInTeam(getTeamFromName(v))
		for k,v in pairs(list) do
			table.insert(law,v)
		end
	end
	return law
end

function warnLaw(msg)
	local law = getLawTable()
	for k,v in pairs(law) do
		-- exports.DENdxmsg:createNewDxMessage(v,"---Notice---",0,255,0)
		 exports.DENdxmsg:createNewDxMessage(v,msg,0,255,0)
	end
end

function holdup2(thePlayer)
	--if getPlayerName(thePlayer) ~= "[CSG]Priyen[TSF]" then return end
	local theMarker = ""
	local store = 0;
    for k,v in pairs(markers) do
        if isElement(v) ~= false then
            if isElementWithinMarker(thePlayer, v) then
                if getElementDimension(v) == getElementDimension(thePlayer) then
					store = markers[k]
					theMarker = v
                break
                end
            end
        end

    end
    if store ~= 0 then
        if t[markers[store]]["robInProgress"] == 0 then
            if t[markers[store]]["timeUntilRob"] == 0 then
                   local chance = math.random(0,100)
                    if chance > t[markers[store]]["chanceToRob"] then
						local lawTable = getLawTable()
						t[markers[store]]["robMaxPerSec"] = 75
						if #lawTable > 2 then
							t[markers[store]]["robMaxPerSec"] = 100
						end
						if #lawTable > 4 then
							t[markers[store]]["robMaxPerSec"] = 125
						end
						if #lawTable > 6 then
							t[markers[store]]["robMaxPerSec"] = 175
						end
                        t[markers[store]]["robInProgress"] = 1
                        t[markers[store]]["theRobber"] = thePlayer
                        t[markers[store]]["timeUntilRob"] = t[markers[store]]["robTimeWhenSuccess"]
                        t[markers[store]]["randomRob"] = math.random(t[markers[store]]["minRob"],t[markers[store]]["maxRob"])
                        exports.CSGwanted:addWanted(thePlayer, 24,"",t[markers[store]].enterX,t[markers[store]].enterY,t[markers[store]].enterZ)
						warnLaw("Attention all Personnel: Robbery in Progress at: "..t[markers[store]]["name"].." "..t[markers[store]]["geoLocation"]..", Suspect: "..getPlayerName(t[markers[store]]["theRobber"]).." ")
                        exports.DENdxmsg:createNewDxMessage(thePlayer,"Starting Robbing the store!", 0, 255, 0)
                        exports.DENdxmsg:createNewDxMessage(thePlayer,"Remain in the checkpoint to get the money", 0, 255, 0)
                        t[markers[store]]["robberInCheckPoint"] = 1
						setMarkerColor(theMarker,255,0,0,100)
							local x,y,z = getElementPosition(thePlayer)
							local col = createColCircle(x,y,20)
							local t2 = getElementsWithinColShape(col,"ped")
							local dim = getElementDimension(thePlayer)
							local int = getElementInterior(thePlayer)
							local ped = t[markers[store]]["showModelPed"]
							setPedAnimation(ped,"SHOP","SHP_Rob_GiveCash")
						setPedAnimation(thePlayer,"SHOP","ROB_Shifty",5000,false,true,true,false)
						local obj = createObject(1550, t[markers[store]]["bagX"], t[markers[store]]["bagY"], t[markers[store]]["bagZ"])
						t[markers[store]]["moneyBag"] = obj
						setObjectScale(obj,0.5)
						setElementInterior(obj,int)
						setElementDimension(obj,dim)
						local timer = setTimer(function() end,1000,0)
						t[markers[store]]["bagSizeTimer"] = timer

                    else
                        exports.CSGwanted:addWanted(thePlayer, 24,"",t[markers[store]].enterX,t[markers[store]].enterY,t[markers[store]].enterZ)
                        t[markers[store]]["timeUntilRob"] = t[markers[store]]["robTimeWhenFail"]
                        t[markers[store]]["theRobber"] = thePlayer
                        exports.DENdxmsg:createNewDxMessage(thePlayer,"Failed to start Store Robbery!", 255, 0, 0)
                        warnLaw("Attention all Personnel: Attempted Robbery at: "..t[markers[store]]["name"].." "..t[markers[store]]["geoLocation"]..", Suspect: "..getPlayerName(t[markers[store]]["theRobber"]).." ")
                        local chance2 = math.random(0,100)
                        if chance2 < t[markers[store]]["chanceToDieDuringAttempt"] then

                        end
						triggerClientEvent(t[markers[store]]["theRobber"],"CSGstoreRobberiesShowRobberyDialog",root,0,true,"fail")
						exports.DENdxmsg:createNewDxMessage(t[markers[store]]["theRobber"],"Store Robbery : Failed!",255,0,0)
						endRobbery(store)
                    end
            else
            exports.DENdxmsg:createNewDxMessage(thePlayer,""..t[markers[store]]["name"].. " was recently robbed. Please try again later, in "..t[markers[store]]["timeUntilRob"].." seconds.",255,255,0)
            end
        else
            if t[markers[store]]["theRobber"] == thePlayer then
				exports.DENdxmsg:createNewDxMessage(thePlayer,"You have already started robbing this store.",255,255,0)
            else
				exports.DENdxmsg:createNewDxMessage(thePlayer,"This store is currently being robbed.",255,0,0)
            end
        end
    end
end
addCommandHandler("holdup", holdup2)
addCommandHandler("robstore", holdup2)


function Enter(thePlayer)
outputChatBox("Welcome to " .. t[markers[source]]["name"] .. "!", thePlayer,0,255,0)
end

function Leave(thePlayer)
    if getElementDimension(thePlayer) == t[markers[source]]["dimension"] then
    outputChatBox("Thank You for visiting " .. t[markers[source]]["name"] .. "!", thePlayer,0,255,0)
    end
end

function robberyRangeLeavePre1(thePlayer)
    setTimer(robberyRangeLeavePre2,2500,1,thePlayer,source)
end

function robberyRangeLeavePre2(thePlayer,marker)
   if getElementDimension(thePlayer) ~= getElementDimension(marker) or getElementInterior(thePlayer) ~= getElementInterior(marker) then
   return
   else
   robberyRangeLeave(thePlayer)
   end
end

function robberyRangeLeave(thePlayer)
   local store = 0
    for k,v in pairs(t) do
    if thePlayer == t[k]["theRobber"] then
		if getElementDimension(thePlayer) == 0 and getElementInterior(thePlayer) == 0 and isElementWithinColShape(thePlayer,colshapes[k]) == false then
        local arrested = 0
        -- if arrested code here..
        if arrested == 0 then
            if t[k]["robInProgress"] == 1 then
        -- give player money code here
        local robbedMoney = t[k]["robbedMoney"]
        local storeName = t[k]["name"]
        local reason = "Robbed Store: "..t[k]["code"]..""
        exports.CSGaccounts:addPlayerMoney(thePlayer, robbedMoney)
		local score=0.1
		exports.CSGscore:givePlayerScore(thePlayer,0.1)
		if robbedMoney > 1000 then
			score=score+0.5
		end
		if robbedMoney > 2000 then
			score=score+1
		end
		exports.DENdxmsg:createNewDxMessage(thePlayer,"Earned +"..score.." for a successfull store robbery!",0,255,0)
		exports.CSGscore:givePlayerScore(thePlayer,score)
        exports.DENdxmsg:createNewDxMessage(thePlayer,"Store Robbery : Success! Stolen $"..robbedMoney.."",0,255,0)
        triggerClientEvent(t[k]["theRobber"],"CSGstoreRobberiesShowRobberyDialog",root,robbedMoney,true,true)
        exports.CSGwanted:addWanted(thePlayer, 25)

		endRobbery(k)
        return
            end
        end
		end
    end
  end
end

function giveMoney()
    for k,v in pairs(t) do
        if t[k]["robInProgress"] == 1 then
            if t[k]["robberInCheckPoint"] == 1 then
                if t[k]["robbedMoney"] <= t[k]["randomRob"] then
                    if getElementType(t[k]["theRobber"]) == "player" then
                    t[k]["robbedMoney"] = t[k]["robbedMoney"] + math.random(t[k]["robMinPerSec"], t[k]["robMaxPerSec"])
                    triggerClientEvent(t[k]["theRobber"],"CSGstoreRobberiesShowRobberyDialog",root,t[k]["robbedMoney"])
                         if t[k]["robbedMoney"] > t[k]["randomRob"] then
							if isElement(t[k]["theRobber"]) then
								triggerClientEvent(t[k]["theRobber"],"CSGstoreRobberiesShowRobberyDialog",root,t[k]["robbedMoney"],true)
								setElementDoubleSided(t[k].moneyBag, true)
								exports.bone_attach:attachElementToBone(t[k].moneyBag,t[k]["theRobber"],3,0,-0.2,0,0,0,180)
								--attachElements(t[k].moneyBag,t[k]["theRobber"],-0.7,0.75)
								exports.DENdxmsg:createNewDxMessage(t[k]["theRobber"],"Robbery Complete. Leave the building and run far away to get the money!",255,255,0)
							if isElement(t[k].moneyBag) then setObjectScale(t[k].moneyBag,1) end
							end
						end
                    end
                end
            end

        end
    end
end
setTimer(giveMoney, 1500, 0)

function holdup1MarkerLeave(leftElement)
    if getElementDimension(source) ~= getElementDimension(leftElement) then return end
    for k,v in pairs(t) do
        if leftElement == t[k]["theRobber"] then
            if t[k]["robInProgress"] == 1 then
				if isElement(t[k]["theRobber"]) then
					triggerClientEvent(t[k]["theRobber"],"CSGstoreRobberiesShowRobberyDialog",root,t[k]["robbedMoney"],true)
					exports.DENdxmsg:createNewDxMessage(leftElement,"Leave the building and run far away to get the money!", 0,255,0)
					setElementDoubleSided(t[k].moneyBag, true)
					exports.bone_attach:attachElementToBone(t[k].moneyBag,t[k]["theRobber"],3,0,-0.2,0,0,0,180)
				end
				--attachElements(t[k].moneyBag,t[k]["theRobber"],-0.7,0.75)
				t[k]["robberInCheckPoint"] = 0
				if isTimer(t[k]["bagSizeTimer"]) then
					killTimer(t[k]["bagSizeTimer"])
				end
                break
            end
        end
    end

end
--[[
--make the enter markers
for k,v in pairs(t) do
   local x,y,z = t[k]["enterX"],t[k]["enterY"],t[k]["enterZ"]
   local entermarker = createMarker(x,y,z, "arrow", 2, 0, 255, 0,0)
   markers[entermarker] = k
   markers[k] = entermarker
   addEventHandler("onMarkerHit", entermarker, Enter)
end
--make the exit markers
for k,v in pairs(t) do
    local dim,int = t[k]["dimension"],t[k]["interior"]
   local x,y,z = t[k]["enterX"],t[k]["enterY"],t[k]["enterZ"]
   local leavemarker = createMarker(x,y,z, "arrow", 2, 0, 255, 0,0)
   setElementDimension(leavemarker, dim)
    setElementInterior(leavemarker, int)

   markers[leavemarker] = k
   markers[k] = leavemarker
   addEventHandler("onMarkerHit", leavemarker, Leave)
end
--]]
--make holdup markers
local interiors = { }
function onResourceStart(res)

   local interiorEntries = getElementsByType ( "interior", getResourceRootElement(res) )

	for k,v in ipairs(interiorEntries) do

		local num = #interiors+1
		interiors[num] = { }
		interiors[num].Name = getElementData( v, "id" )
		interiors[num].GoTo = getElementData( v, "goto" )

		interiors[num].holdupX = tonumber( getElementData( v, "hposX" ) )
		interiors[num].holdupY = tonumber( getElementData( v, "hposY" ) )
		interiors[num].holdupZ = tonumber( getElementData( v, "hposZ" ) )
        interiors[num].PosX = tonumber( getElementData( v, "posX" ) )
		interiors[num].PosY = tonumber( getElementData( v, "posY" ) )
		interiors[num].PosZ = (tonumber( getElementData( v, "posZ" ) ) + 1.5)
		interiors[num].Rotation = tonumber( getElementData( v, "rotation" ) )
		interiors[num].Interior = tonumber( getElementData( v, "interior" ) ) --this is the goto interior
		interiors[num].Dimension = tonumber( getElementData( v, "todimension" ) )
		interiors[num].Marker = tonumber(  getElementData( v, "marker" ) )

		interiors[num].gPosX = tonumber( getElementData( v, "gposX" ) )
		interiors[num].gPosY = tonumber( getElementData( v, "gposY" ) )
		interiors[num].gPosZ = (tonumber( getElementData( v, "gposZ" ) ) + 1.5)
		interiors[num].blip = tonumber( getElementData( v, "blip" ) )
		interiors[num].tbagX = tonumber( getElementData( v, "bagX" ) )
		interiors[num].tbagY = tonumber( getElementData( v, "bagY" ) )
		interiors[num].tbagZ = tonumber( getElementData( v, "bagZ" ) )

		if( not interiors[num].Interior ) then interiors[num].Interior = 0 end
		if( not interiors[num].Dimension ) then interiors[num].Dimension = -1 end
		if( not interiors[num].ToDimension ) then interiors[num].ToDimension = -1 end
     -- "[bsLS1"] = {code="bsLS1", name="BurgerShot", enterX=811, enterY=-1616, enterZ=12, exitX=363, exitY=-75, exitZ=1001, holdupX=376, holdupY=-68, holdupZ=1001, escapeRange=100, dimension=1, interior=10, robTimeWhenSuccess=600, geoLocation="LS South", robTimeWhenFail=300, chanceToRob=50, chanceToDieDuringAttempt=50, minRob=2000,  maxRob=4000, theRobber=0, robInProgress=0, timeUntilRob=0, robbedMoney=0, robberInCheckPoint=0, randomRob=0, robMinPerSec=0, robMaxPerSec=300},
        local store = {code="store", name=interiors[num].Name, enterX=interiors[num].PosX,enterY=interiors[num].PosY,enterZ=interiors[num].PosZ,exitX=interiors[num].gPosX,exitY=interiors[num].gPosY,exitZ=interiors[num].gPosZ,holdupX=interiors[num].holdupX,holdupY=interiors[num].holdupY,holdupZ=interiors[num].holdupZ,escapeRange=100,dimension=interiors[num].Dimension,interior=interiors[num].Interior, robTimeWhenSuccess=600,geoLocation="", robTimeWhenFail=300, chanceToRob=20, chanceToDieDuringAttempt=50, minRob=3000,  maxRob=6000, theRobber=0, robInProgress=0, timeUntilRob=0, robbedMoney=0, robberInCheckPoint=0, randomRob=0, robMinPerSec=0, robMaxPerSec=300, moneyBag="",bagX=interiors[num].tbagX,bagY=interiors[num].tbagY,bagZ=interiors[num].tbagZ}

        table.insert(t,store)


    end

    for k,v in pairs(t) do
		local dim,int = t[k]["dimension"],t[k]["interior"]
		local x,y,z = t[k]["holdupX"],t[k]["holdupY"], t[k]["holdupZ"]
		t[k]["geoLocation"] = getZoneName(t[k]["enterX"],t[k]["enterY"],t[k]["enterZ"])
		local holdupmarker = createMarker(x,y,z-0.5, "cylinder", 2, 255 ,0 ,0,0)
		markers[holdupmarker] = k
		markers[k] = holdupmarker
		setElementDimension(holdupmarker, dim)
		setElementInterior(holdupmarker, int)
		addEventHandler("onMarkerHit", holdupmarker, holdup1)
		addEventHandler("onMarkerLeave", holdupmarker, holdup1MarkerLeave)
    end
	--make the robbery range colshapes
    for k,v in pairs(t) do
		local x,y,range = t[k]["enterX"],t[k]["enterY"], t[k]["escapeRange"]
		local robberyRangeColShape = createColCircle(x,y,range)
		colshapes[robberyRangeColShape] = k
		colshapes[k] = robberyRangeColShape
		addEventHandler("onColShapeLeave", robberyRangeColShape, robberyRangeLeavePre1)
    end
	for k,v in pairs(t) do
		t[k]["showModelPed"] = exports.DENpeds:getShowModelPed(v.dimension,v.interior)
		local pedsE = {}
		local tableToUse = {}
		if v.name == "BurgerShot" then tableToUse = burgerShotByStandersPos end
		for k2,v2 in pairs(tableToUse) do
			local ped = ""
			ped = createPed(1,v2[1],v2[2],v2[3],v2[4],true)
			table.insert(pedsE,ped)
			setElementDimension(ped,v.dimension)
			setElementInterior(ped,v.interior)
		end
		t[k]["peds"] = pedsE
	end
end
addEventHandler( "onResourceStart", getResourceRootElement(getThisResource()), onResourceStart)

function tuFindNearestElement(to,elementType,maxDistance)
    local x,y,z = getElementPosition(to)
    local bestD = maxDistance + 1
    local bv = nil

    for _,av in pairs(getElementsByType(elementType)) do
        if av ~= to then
            local vx,vy,vz = getElementPosition(av)
            local d = getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)
            if d < bestD then
                bestD = d
                bv = av
            end
        end
    end

    return bv,bestD
end
