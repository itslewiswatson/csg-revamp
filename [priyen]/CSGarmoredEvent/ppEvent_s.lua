------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  ppEvent_s.lua (server-side)
--  Armored Truck Event
--  Priyen Patel
------------------------------------------------------------------------------------

local truckMaxSpeed = 55 --kmh
local lawNeeded = 2
local timeWaitTillStart = 5 --seconds
local minBags = 2
local maxBags = 2
local perBagMin = 5000
local perBagMax = 7000
local copAmountTimes = 1 -- bags amount times this for law
local baseHealth = 5000
--local healthPerCrimOnline = 5000 --FORMULA: 5000+(2500*2(crims/law))
local truck = ""
local fromMarker = ""
local inProgress = ""
local toMarker = ""
local truckCol = ""
local healthBeforeBreakdown = 100
local globalTimeTillClean = 0
local currentHealth = 50000
local minTimeBetweenEvents =  1800 --seconds (seconds = minutes * 60)
local maxTimeBetweenEvents =  2700
local timeTillEvent = 5 -- starts on resource start -- 2 == 1 second after
local truckBlip = ""
local colRadius = 35
local lawInFromMarker = {}
local bagRadius = 0.4 -- x 2, so 2.5 = 5 radius
local alreadyCollectedBag = {}
local backOfTruckMarker = ""
local autoEndTime = 15 --minutes
local winning = ""
local waitingForResult = false
local waterCheckResult = false
local inWater = false
local bags = {}

local fromPos = {
	--[1] = {2310.3205566406,1647.8489990234,9.8203125,["name"]="Caligula's Casino"}
	[1] = {599.32220458984,-1305.9846191406,12.305281448364,291.01634521484,["name"]="LS Bank"},
	[2] = {-1840.7551269531,1043.302734375,44.387707519531,89.075595092773,["name"]="SF Bank"},
	[3] = {-2813.5786132813,375.2692565918,2.8082426071167,99.055331420898,["name"]="Whitehouse"},
	[4] = {165.93356323242,-22.509349822998,0.278125,264.04078369141,["name"]="Blueberry Federal Depot"}
}
local toPos = {
	[1] = {599.32220458984,-1305.9846191406,13.005281448364,["name"]="LS Bank"},
 	[2] = {-1840.7551269531,1043.302734375,45.087707519531,["name"]="SF Bank"},
	[3] = {-2813.5786132813,375.2692565918,3.5082426071167,["name"]="Whitehouse"},
	[4] = {165.93356323242,-22.509349822998,0.578125,["name"]="Blueberry Federal Depot"},
	[5] = {1904.693359375,990.34851074219,9.8203125,["name"]="The Four Dragons Hotel & Casino"},
	[6] = {2310.3205566406,1647.8489990234,9.8203125,["name"]="Caligula's Casino"}
}
local lawTeams = {
	"Military Forces",
	"SWAT",
	"Police",
	"Government Agency"
}

local eventActive = false

function preStart()
	local validToI = false
	toI = math.random(1,#toPos)
	fromI = math.random(1,#fromPos)
	while(validToI==false) do
		local x,y,z = fromPos[fromI][1],fromPos[fromI][2],fromPos[fromI][3]
		local x2,y2,z2 = toPos[toI][1],toPos[toI][2],toPos[toI][3]
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 50 then
			toI=math.random(1,#toPos)
		else
			validToI=true
		end
	end

	warnLaw("The "..fromPos[fromI].name.." is requesting a armored truck transport to "..toPos[toI].name..".")
	warnLaw("Arrive Promptly!")
	inProgress = false
	truck = createVehicle(428,fromPos[fromI][1],fromPos[fromI][2],fromPos[fromI][3]+2)


	triggerClientEvent(root,"CSGarmoredEventMakeBlip",root,fromPos[fromI][1],fromPos[fromI][2],fromPos[fromI][3],51,lawTeams)
	announceTimer = setTimer(announceNotifs,600000,0)
	setTimer(function()setElementFrozen(truck,true) end,2000,1)
	local rx,ry = getElementRotation(truck)
	local rz = fromPos[fromI][4]
	triggerClientEvent(root,"CSGarmoredEventRecTruck",root,truck)
	setElementRotation(truck,rx,ry,rz)
	--setElementHealth(truck,1000)
	setVehicleDamageProof(truck,true)
	fromMarker = createMarker(fromPos[fromI][1],fromPos[fromI][2],fromPos[fromI][3]-1,"cylinder",15,255,255,0,15)
	addEventHandler("onMarkerHit",fromMarker,hitMarker)
	addEventHandler("onMarkerLeave",fromMarker,leaveMarker)
end

addEventHandler("onVehicleExplode",root,function()
	if source == truck then
		cancelEvent()
	end
end)

function announceNotifs()
	warnLaw("The "..fromPos[fromI].name.." is requesting a armored truck transport to "..toPos[toI].name..".")
	warnLaw("Arrive Promptly!")
end

function hitMarker(e)
	if source == fromMarker then
		if getElementType(e) == "player" then
			if isLaw(e) == true then
				table.insert(lawInFromMarker,e)
				if #lawInFromMarker < lawNeeded then

				else	--6 law in marker

				end
			end
		end
	elseif source == toMarker then
		--if getElementType(e) ~= "vehicle" then return end
		if e == truck then
			warnLaw("The armored truck has been successfully delivered to "..toPos[toI].name.."")
			warnLaw("Please collect your cash within 1 minute near the truck to claim your reward")
			winning="law"
			prepareForMoneybags()
			setVehicleEngineState(e,false)
			warnCriminals("The armored truck has been successfully delivered to "..toPos[toI].name.."!")
			warnCriminals("Mission Failed!")
		end
	end
end

function hitTruck()
	if isLaw(source) == false then
		exports.server:givePlayerWantedPoints(source,30)
	end
end
addEvent("CSGarmoredEventHitTruck",true)
addEventHandler("CSGarmoredEventHitTruck",root,hitTruck)

function leaveMarker(e)
	if source == fromMarker then
		if getElementType(e) == "player" then
			if isLaw(e) == true then
				for k,v in pairs(lawInFromMarker) do if v == e then table.remove(lawInFromMarker,k) break end end
			end
		end
	elseif source == toMarker then

	end
end

function vehEnter(e,seat)
	if inProgress == true then return end
	if timeTillEvent > 0 then return end
	if seat ~= 0 then return end
	if source == truck then
		if isLaw(e) == true then
			local team = getTeamName(getPlayerTeam(e))
			--if team == "Military Forces" or team == "SWAT" or team == "Government Agency" then
			--else
			--	 exports.DENdxmsg:createNewDxMessage(e,"Sorry, only SWAT or Military Forces have the authority to drive this truck!",255,255,0)
			--	return
			--end
			if #lawInFromMarker < lawNeeded then
				 exports.DENdxmsg:createNewDxMessage(e,"Armored Transport Mission: You need "..lawNeeded.." law in the marker to begin!",255,0,0)
			else
				 exports.DENdxmsg:createNewDxMessage(e,"Armored Transport Mission: Remain in the vehicle! Starting in "..timeWaitTillStart.." seconds!",255,0,0)
				startTimer = setTimer(start,timeWaitTillStart*1000,1)
			end
		end
	end
end
addEventHandler("onVehicleEnter",root,vehEnter)

function vehExit(p,seat)
	if source == truck then if seat == 0 then if isTimer(startTimer) then killTimer(startTimer) end end end
end
addEventHandler("onVehicleExit",root,vehExit)

function start()
	if isTimer(announceTimer) then killTimer(announceTimer) end
	setVehicleDamageProof(truck,false)
	local laws = getLawTable()
	local crims = getPlayersInTeam(getTeamFromName("Criminals"))
	currentHealth = baseHealth+(2500*2*(#crims/#laws))
	setElementFrozen(truck,false)
	inProgress = true
	for k,v in pairs(getLawTable()) do
		triggerClientEvent(v,"CSGarmoredEventDestroyBlip",v,fromPos[fromI][1],fromPos[fromI][2],fromPos[fromI][3],51)
	end
	truckBlip = createBlipAttachedTo(truck,51)
	triggerClientEvent(root,"CSGarmoredEventMakeBlip",root,toPos[toI][1],toPos[toI][2],toPos[toI][3],19,lawTeams)
	monitorTruckTimer = setTimer(monitorTruck,1000,0)
	warnLaw("The armored truck headed towards "..toPos[toI].name.." has just left "..fromPos[fromI].name.."!")
	warnLaw("You have "..autoEndTime.." minutes to deliver it! Protect it all the way for a large reward!")
	warnCriminals("A armored truck headed towards "..toPos[toI].name.." has just left "..fromPos[fromI].name.."!")
	warnCriminals("Destroy the truck and steal the money!")
	toMarker = createMarker(toPos[toI][1],toPos[toI][2],toPos[toI][3],"cylinder",15,255,255,0,15)
	addEventHandler("onMarkerHit",toMarker,hitMarker)
	setTimer(doEnd,autoEndTime*60*1000,1)
end

function monitorTruck()
	if isElement(truck) then
		--outputChatBox(currentHealth)
		local limit = truckMaxSpeed
		if stopTheTruck == true then limit = 0 end
		local speedx, speedy, speedz = getElementVelocity ( truck )
		local kmh = ((speedx^2 + speedy^2 + speedz^2)^(0.5))*180
		if kmh > limit then
			--setVehicleEngineState(truck,false)
			local diff = limit/kmh
			setElementVelocity(truck,speedx*diff,speedy*diff,speedz)
		else
			--if getVehicleEngineState(truck) == false then setVehicleEngineState(truck,true) end

		end
		if waitingForResult == false then
			if type(waterCheckResult) ~= "boolean" then
				local x,y,z = getElementPosition(truck)
				if z-waterCheckResult <= 1 then
				--outputChatBox("truck in water!")
				winning="crim"
				killTimer(monitorTruckTimer)
				inWater = true
				prepareForMoneybags()
				return
				end
			end
			local pl = getRandomPlayer()
			x,y,z = getElementPosition(truck)
			waitingForResult = true
			triggerClientEvent(pl,"CSGarmoredEventDoWaterCheck",pl,x,y,z)
		end
	end
end

function warnCriminals(msg)
	local list = getPlayersInTeam(getTeamFromName("Criminals"))
	for k,v in pairs(list) do
		 exports.DENdxmsg:createNewDxMessage(v,msg,255,0,0)
	end
end

function crimWinning()
	warnCriminals("The armored truck has been broken down! Hurry!")
	warnCriminals("Kill the cops near the truck! You have 5 minutes do the job!")
	warnLaw("The armored truck has been broken down! You have failed the mission and the "..fromPos[fromI].name.."!")
	warnLaw("Protect it from potential criminals for 5 minutes!")

end

function lawWinning()
	warnLaw("Clear out any remaining criminals near the truck!")
	warnCriminals()
end

function prepareForMoneybags()
	setTimer(function()
	setElementFrozen(truck,true)
	if isTimer(monitorTruckTimer) then killTimer(monitorTruckTimer) end
	local x,y = getElementPosition(truck)
	truckCol = createColCircle(x,y,colRadius)
	monitorTruckColTimer = setTimer(monitorTruckCol,1000,0)
	if winning == "crim" then
	crimWinning()
	elseif winning == "law" then
	lawWinning()
	end
	setTimer(function()
		for k,v in pairs(getElementsWithinColShape(truckCol)) do
			if getElementType(v) == "player" and isLaw(v) then
				exports.DENdxmsg:createNewDxMessage(v,"Paid $2000 for defending the truck. +2 Score",0,255,0)
				givePlayerMoney(v,2000)
				exports.CSGscore:givePlayerScore(v,2)
			end
		end
	end,290000,1)
	setTimer(doEnd,300000,1)
	backOfTruckMarker = createMarker(fromPos[fromI][1],fromPos[fromI][2],fromPos[fromI][3],"cylinder",2,255,255,0,60)
	attachElements(backOfTruckMarker,truck,0,-3.5,-1)
	end,5000,1)
	destroyElement(truckBlip)
	removeEventHandler("onMarkerHit",toMarker,hitMarker)
	removeEventHandler("onMarkerHit",fromMarker,hitMarker)
	removeEventHandler("onMarkerLeave",fromMarker,leaveMarker)
	destroyElement(fromMarker)
	destroyElement(toMarker)
	setVehicleDamageProof(truck,true)
end

function vehDamage(loss)
	if isElement(truck) == false then return end
	if source == truck then
		--outputChatBox("loss: "..loss.."")
		--if stopTheTruck == true then cancelEvent() return end

		currentHealth=currentHealth-loss*5
		if currentHealth < healthBeforeBreakdown then setVehicleDamageProof(source,true) setElementHealth(source,249) else setElementHealth(source,999)  return end
			setVehicleEngineState(source,false)
			cancelEvent()
			setElementHealth(source,249)
			if stopTheTruck ~= true then
			stopTheTruck = true
			winning="crim"
			prepareForMoneybags()
			end

	end
end
addEventHandler("onVehicleDamage",root,vehDamage)

function explode()
	if source == truck then cancelEvent() end
end
addEventHandler("onVehicleExplode",root,explode)

function monitorTruckCol()
	if isElement(truckCol) then
		local t = getElementsWithinColShape(truckCol,"player")
		local isTypeNear = false
		for k,v in pairs(t) do
			if isTypeNear == true then break end
			if winning == "crim" then
			for k2,v2 in pairs(lawTeams) do
				if v2 == getTeamName(getPlayerTeam(v)) then
					isTypeNear = true
					break
				end
			end
			elseif winning == "law" then
				if getTeamName(getPlayerTeam(v)) == "Criminals" then isTypeNear = true break end
			end
		end
		if inWater == true then isTypeNear = false end
		--outputChatBox(getPlayerFromName("[CSG]Priyen"),"Truck in water: "..tostring(inWater).."")
		if isTypeNear == false then
			local x,y,z = getElementPosition(backOfTruckMarker)
			globalTimeTillClean=60000
			setTimer(function() globalTimeTillClean=globalTimeTillClean-1000 end,1000,(globalTimeTillClean/1000)+1)
			setTimer(doEnd,60000,1)
			mainZ = z
			if inWater == true then
				waterCheckResult = false
				doWaterLevelTimer = setTimer(doWaterStuff,1000,0)
				if isTimer(monitorTruckColTimer) then
					killTimer(monitorTruckColTimer)
				end
				return
			end
			makeMoneyBags(x,y,mainZ)
			setVehicleDoorState(truck,4,2)
			setVehicleDoorState(truck,5,4)
			destroyElement(truckCol)
			if isTimer(monitorTruckColTimer) then
				killTimer(monitorTruckColTimer)
			end
		end
	end
end

function doWaterStuff()
	local x,y,z = getElementPosition(truck)
	if z == nil then
		killTimer(doWaterLevelTimer)
		doEnd()
	return
	end
	z=z+0.25
	setElementPosition(truck,x,y,z)
	if waitingForResult == false then
		if type(waterCheckResult) ~= "boolean" then
		killTimer(doWaterLevelTimer)
		local rx,ry,rz = getElementRotation(truck)
		setElementRotation(truck,0,ry,rz)
		z=z+2
		setElementPosition(truck,x,y,z)
		x,y,z = getElementPosition(truck)
		x,y,z = getElementPosition(backOfTruckMarker)
		makeMoneyBags(x,y,z+1.00)
		setVehicleDoorState(truck,4,2)
		setVehicleDoorState(truck,5,4)
		if isElement(truckCol) then
			destroyElement(truckCol)
		end
		else
		local pl = getRandomPlayer()
		waitingForResult = true
		triggerClientEvent(pl,"CSGarmoredEventDoWaterCheck",pl,x,y,z)
		end
	else

	end

end

function makeMoneyBags(x,y,z)

	for k,v in pairs(getLawTable()) do
		triggerClientEvent(v,"CSGarmoredEventDestroyBlip",v,toPos[toI][1],toPos[toI][2],toPos[toI][3],19)
	end
	if isTimer(monitorTruckTimer) then killTimer(monitorTruckTimer) end
	bags = {}
	local bagsAm = math.random(minBags,maxBags)
	for i=1,bagsAm do
		local x2 = math.random(x-bagRadius,x+bagRadius)
		local y2 = math.random(y-bagRadius,y+bagRadius)
		--z2 = getGroundPosition(x2,y2,z)
		z2=z+0.75
		local m = createMarker(x2,y2,z2,"cylinder",1,255,255,0,0)
		addEventHandler("onMarkerHit",m,hitMoneyBag)
		local money = math.random(perBagMin,perBagMax)
		if winning == "law" then money=money*copAmountTimes end
		local obj = createObject(1550,x2,y2,z2)
		bags[i] = {obj,m,money}
	end
	if winning == "crim" then
	warnLaw("The Criminals have broken into the armored truck!")
	warnCriminals("Hurry! The armored truck's doors are open. Get the money!")
	elseif winning == "law" then
	warnLaw("Congratulations! "..fromPos[fromI].name.." has decided to pay you for your service!")
    warnLaw("Hurry! Pickup your stash of the money near the truck!")
	end
	setTimer(cleanUpBags,globalTimeTillClean,1)
	triggerClientEvent(root,"CSGarmoredEventRecBags",root,bags,globalTimeTillClean,inWater)
end

function playerLogin()
	if timeTillEvent == 0 then
		if isElement(truck) == false then return end
		if fromPos[fromI][1] == nil or fromPos[fromI][1] == 0 then return end
		triggerClientEvent(source,"CSGarmoredEventRecTruck",source,truck)
		triggerClientEvent(source,"CSGarmoredEventMakeBlip",source,fromPos[fromI][1],fromPos[fromI][2],fromPos[fromI][3],51,lawTeams)
		triggerClientEvent(source,"CSGarmoredEventMakeBlip",source,toPos[toI][1],toPos[toI][2],toPos[toI][3],19,lawTeams)
	end
	if globalTimeTillClean > 2 then
		triggerClientEvent(source,"CSGarmoredEventRecBags",source,bags,globalTimeTillClean)
	end
end
addEventHandler("onPlayerLogin",root,playerLogin)

function hitMoneyBag(e)
	if getElementType(e) == "player" then
		if winning == "law" then if isLaw(e) == false then return end end
		if winning == "crim" then if getTeamName(getPlayerTeam(e)) ~= "Criminals" then return end end

			local i = 0
			for k,v in pairs(bags) do
				if v[2] == source then i = k break end
			end
			if i == 0 then return end
			local t = alreadyCollectedBag[exports.server:getPlayerAccountName(e)]
			if t == nil then
			if winning == "crim" then
				exports.server:givePlayerWantedPoints(e, 60)
			end
			alreadyCollectedBag[exports.server:getPlayerAccountName(e)] = {}
			t = {}
			end
			for k,v in pairs(t) do if v == i then return end end
			setPedAnimation(e,"MISC","pickup_box",1000,false)
			setTimer(function() setPedAnimation(e,false) end,1000,1)
			table.insert(alreadyCollectedBag[exports.server:getPlayerAccountName(e)],i)
			givePlayerMoney(e,bags[i][3])
			exports.CSGscore:givePlayerScore(e,5)
			exports.DENstats:setPlayerAccountData(e,"armoredtrucks",exports.DENstats:getPlayerAccountData(e,"armoredtrucks")+0.5)
			 exports.DENdxmsg:createNewDxMessage(e,"Picked up $"..bags[i][3]..". Earned +5 Score",0,255,0)
	end
end

function cleanUpBags()

	for k,v in pairs(bags) do
		destroyElement(v[1])
		removeEventHandler("onMarkerHit",v[2],hitMoneyBag)
		destroyElement(v[2])
	end
	bags = {}
	alreadyCollectedBag = {}
end

function showData(ps)

	if inProgress == true then
		outputChatBox("Truck Health: "..currentHealth..". "..fromPos[fromI].name..". To "..toPos[toI].name.."",ps,0,255,0)
	else
		if timeTillEvent <= 0 then
			outputChatBox("Time Till Event: "..timeTillEvent.." Seconds. Ready At: "..fromPos[fromI].name..". To: "..toPos[toI].name.."",ps,0,255,0)
		else
			outputChatBox("Time Till Event: "..timeTillEvent.." Seconds",ps,0,255,0)
		end
	end
end
addCommandHandler("armoreventdata",showData)

function tim(ps)
	if timeTillEvent <= 0 then
		exports.DENdxmsg:createNewDxMessage(ps,"Armored Transport is ready to go",0,255,0)
	else
		if inProgress == true then
			exports.DENdxmsg:createNewDxMessage(ps,"Armored Transport is currently in progress",0,255,0)
		else
			exports.DENdxmsg:createNewDxMessage(ps,""..timeTillEvent.." Seconds until Armored Transport is Ready",0,255,0)
		end
	end
end
addCommandHandler("armortime",tim)

function doEnd()
	if inProgress == true then
	cleanUpBags()
	winning=""
	if isTimer(doWaterLevelTimer) then killTimer(doWaterLevelTimer) end
	if isTimer (monitorTruckColTimer) then killTimer(monitorTruckColTimer) end
	if isElement(truckCol) then destroyElement(truckCol) end
	if isElement(backOfTruckMarker) then destroyElement(backOfTruckMarker) end
	--blowVehicle(truck)
	setTimer(function() if isElement(truck) then destroyElement(truck) end stopTheTruck = false end,5000,1)
	triggerClientEvent(root,"CSGarmoredEventEnd",root)
	inProgress = false
	waterCheckResult = false
	inWater = false
	waitingForResult = false
	timeTillEvent = math.random(minTimeBetweenEvents,maxTimeBetweenEvents)
	triggerClientEvent(root,"CSGarmoredEventRecTime",root,timeTillEvent)
	end
end

addEventHandler("onPlayerLogin",root, function () triggerClientEvent(source,"CSGarmoredEventRecTime",source,timeTillEvent) end)

function manageTimeLeft()
	if timeTillEvent <= 0 then
		if isElement(truck) == false then preStart() end
		timeTillEvent = 0
	else
		timeTillEvent = timeTillEvent-1
	end
end
setTimer(manageTimeLeft,1000,0)

function getTimeUntilEvent()
	return timeTillEvent*1000
end

function isLaw(e)
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
manageTimeLeft()

function CSGarmoredEventRecWaterCheckResult(result)
	waitingForResult = false
	waterCheckResult = result
end
addEvent("CSGarmoredEventRecWaterCheckResult",true)
addEventHandler("CSGarmoredEventRecWaterCheckResult",root,CSGarmoredEventRecWaterCheckResult)

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
