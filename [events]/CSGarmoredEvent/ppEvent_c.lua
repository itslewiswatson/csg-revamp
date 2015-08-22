------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  ppEvent_c.luac (client-side)
--  Armored Truck Event
--  Priyen Patel
------------------------------------------------------------------------------------
local blips = {}
local truck = ""
local sentWanted = false
local bags = ""
local monitorBlipVisibilityTimer = ""
function rec(t,s,water)
	inWater=water
	bags = t
	for k,v in pairs(t) do
		setElementCollisionsEnabled(v[1],false)
		rx,ry,rz = getElementRotation(v[1])
		if inWater == true then ry = 45 end
			setElementRotation(v[1],rx,ry,rz)
	end
	addEventHandler("onClientRender",root,rotateBags)
	setTimer(function() sentWanted = false removeEventHandler("onClientRender",root,rotateBags) inWater=false end,s,1)
end
addEvent("CSGarmoredEventRecBags",true)
addEventHandler("CSGarmoredEventRecBags",localPlayer,rec)

function rotateBags()
	for k,v in pairs(bags) do
		if isElement(v[1]) == false then return end
		local rx,ry,rz = getElementRotation(v[1])
		rz=rz+1
		if rz > 360 then rz = rz-360 end

		setElementRotation(v[1],rx,ry,rz)
	end
end

function makeBlip(x,y,z,id,teams)
	if x == 0 then return end
	if isTimer(monitorBlipVisibilityTimer) == false then monitorBlipVisibilityTimer = setTimer(monitorBlipVisibility,1000,0) end
	local blip = ""
	local team = getPlayerTeam(localPlayer)
	local myTeam = ""
	if team == false then
		myTeam = "notLaw"
	else
	    myTeam = getTeamName(team)
	end
--[[	for k,v in pairs(teams) do
		if v == myTeam then blip=createBlip(x,y,z,id) break end
	end --]]
	table.insert(blips,{blip,teams,x,y,z,id})
end
addEvent("CSGarmoredEventMakeBlip",true)
addEventHandler("CSGarmoredEventMakeBlip",localPlayer,makeBlip)

function monitorBlipVisibility()
	local myTeam = getTeamName(getPlayerTeam(localPlayer))
	for k,v in pairs(blips) do
		for k2,v2 in pairs(v[2]) do
			if v2 == myTeam then
				if v[1] == "" then
					blip=createBlip(v[3],v[4],v[5],v[6]) blips[k][1] = blip
					return
				else
					return
				end
			end
		end
		if isElement(v[1]) then	destroyElement(v[1]) blips[k][1] = "" end
	end
end

function destroyBlip(x,y,z)
	for k,v in pairs(blips) do
		local x2,y2,z2 = getElementPosition(v[1])
		if x == x2 and y == y2 and z == z2 then
			destroyElement(v[1])
			table.remove(blips,k)
		end
	end
end
addEvent("CSGarmoredEventDestroyBlip",true)
addEventHandler("CSGarmoredEventDestroyBlip",localPlayer,destroyBlip)

function endEvent()
	if isTimer(monitorBlipVisibilityTimer) == true then killTimer(monitorBlipVisibilityTimer) end
end
addEvent("CSGarmoredEventEnd",true)
addEventHandler("CSGarmoredEventEnd",localPlayer,endEvent)

timeUntilEvent = 1
function recTime(tim)
	timeUntilEvent = tim
end
addEvent("CSGarmoredEventRecTime",true)
addEventHandler("CSGarmoredEventRecTime",localPlayer,recTime)

function decrease()
	if timeUntilEvent > 0 then
		timeUntilEvent = timeUntilEvent-1
	end
end
setTimer(decrease,1000,0)

function getTimeUntilEvent()
	return timeUntilEvent*1000
end

function waterCheck(x,y,z)
	local result = getWaterLevel(x,y,z)
	triggerServerEvent("CSGarmoredEventRecWaterCheckResult",localPlayer,result)
end
addEvent("CSGarmoredEventDoWaterCheck",true)
addEventHandler("CSGarmoredEventDoWaterCheck",localPlayer,waterCheck)

function rect(truckE)
	truck = truckE
end
addEvent("CSGarmoredEventRecTruck",true)
addEventHandler("CSGarmoredEventRecTruck",localPlayer,rect)

function fire(wep,am,clip,x,y,z,el)
	if source ~= localPlayer then return end
	if el == truck then
		if sentWanted == false then
			sentWanted = true
			triggerServerEvent("CSGarmoredEventHitTruck",localPlayer)
		end
	end
end

