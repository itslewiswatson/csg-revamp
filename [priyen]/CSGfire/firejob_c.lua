------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  firejob_c.luac (client-side)
--  Firefighter Job
--  Priyen Patel
------------------------------------------------------------------------------------
local shift = false
local cd = false
function resetCD()
    cd = false
end

function shiftUpdate(shif)
	shift=shif
end
addEvent("CSGfireShiftUpdate",true)
addEventHandler("CSGfireShiftUpdate",localPlayer,shiftUpdate)

function attackFire(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
    if (hitElement) == false then return end
    if isElement(hitElement) == false then return end
    if weapon == 42 then
        local model = getElementModel(hitElement)
        if model < 2022 or model > 2024  then return end
        if (isInFireFighterMode(localPlayer)) then
            if cd == false then
                cd = true
                triggerServerEvent("CSGfireHitFire",localPlayer,hitElement)
                setTimer(resetCD,1000,1)
            end
        end
    end

end
addEventHandler("onClientPlayerWeaponFire",localPlayer,attackFire)

function isInFireFighterMode(p)
	if ((getTeamName(getPlayerTeam(p))) == "Firefighters" and exports.server:getPlayerOccupation(p) == "Firefighter") then
		return true
	else
		return false
	end
end

function attackFireByTruck(ped)
    if isInFireFighterMode(localPlayer) == false then return end

    if getPedOccupiedVehicle(localPlayer) ~= source then return end
    if cd == false then
        cd = true
        triggerServerEvent("CSGfireHitFireByTruck",localPlayer,ped)
        setTimer(resetCD,1000,1)
    end
end
addEventHandler("onClientPedHitByWaterCannon",root,attackFireByTruck)

function attackByTruck2(el)
	if getElementModel(source) == 407 then cancelEvent() return end
	if getElementType(el) == "ped" then cancelEvent() end
end
addEventHandler("onClientPlayerHitByWaterCannon",root,attackByTruck2)
firedff = engineLoadDFF("FireModel.dff", 2022)
firedff2 = engineLoadDFF("FireModel2.dff", 2024)
engineReplaceModel(firedff,2022)
engineReplaceModel(firedff2,2024)

local blips = {}
function CSGfireStarted(x,y,z)
    if isElement(blips[x]) then return end
    blips[x] = createBlip(x,y,z,20)
end
addEvent("CSGfireStarted",true)
addEventHandler("CSGfireStarted",localPlayer,CSGfireStarted)

function CSGfireEnded(x)
	if x == "all" then
		for k,v in pairs(blips) do
			if isElement(v) then
				destroyElement(v)
			end
		end
	else
	    if isElement(blips[x]) then
			destroyElement(blips[x])
		end
	end

end
addEvent("CSGfireEnded",true)
addEventHandler("CSGfireEnded",localPlayer,CSGfireEnded)

addEvent("onPlayerJobChange",true)

function jobChange(nJob,oldJob)
	if nJob == "Firefighter" then
		triggerServerEvent("CSGfireBackOnShift",localPlayer)
	elseif oldJob == "Firefighter" then
		triggerServerEvent("CSGfireQuitJob",localPlayer)
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)

function CSGfireSetCollisions(t,boole)
	for k,v in pairs(t) do
        setElementCollisionsEnabled(k,boole)
        setElementCollisionsEnabled(v,boole)
    end
end
addEvent("CSGfireSetCollisions",true)
addEventHandler("CSGfireSetCollisions",localPlayer,CSGfireSetCollisions)

function cmd1(cmd,arg)
	outputChatBox(tostring(getElementData(localPlayer,arg)))
end
addCommandHandler("ed",cmd1)

function monitorShift()
	if shift == true then return end
	local s = getElementModel(localPlayer)
	if s == 277 or s == 278 or s == 279	then
		local team = getPlayerTeam(localPlayer)
		if team == false then return end
		if getTeamName(team) == "Firefighters" then
			triggerServerEvent("CSGfireBackOnShift",localPlayer)
		end
	end
end
setTimer(monitorShift,1000,0)

-----------------------Updated Nov 26th 2012

local waterDrops = {}
function doDrop()
	triggerServerEvent("CSGfire.DropWater",localPlayer)
	local x,y,z = getElementPosition(getPedOccupiedVehicle(localPlayer))
	local obj = createObject(2070,x,y,z-3.5)
	setElementRotation(obj,0,180,0)
	setObjectScale(obj,3)
	setTimer(destroyElement,2000,1,obj)

end

function checkWaterDrop()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh == false then return end
	if getElementModel(veh) == 417 then
		doDrop()
	end
end

addCommandHandler("bindfiredrop",function()
	bindKey("space","down",checkWaterDrop)
end)

if fileExists("firejob_c.lua") == true then
	fileDelete("firejob_c.lua")
end
