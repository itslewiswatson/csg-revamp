------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  firejob_s.lua (server-side)
--  Firefighter Job
--  Priyen Patel
------------------------------------------------------------------------------------

--[[
fireFighterVehs = {
	[407] = {"Fire Truck",1,1,1,1},
	[544] = {"Fire Truck (Ladder)",1,1,1,1}
}
 --LV
 { "Firefighter", "Civillian Workers",  1740.94, 2077.73, 10.82, 255, 255, 0, 42, {277,278,279}, 3, false, "Work as a Fire Fighter to protect the streets of SA from blazing disasters!", 180 }
 {1750.16, 2077.73, 10.82, 255, 255, 0, fireFighterVehs, "Civillian Workers", "Firefighter", 180}
 {1756.69, 2077.73, 10.82, 255, 255, 0, fireFighterVehs, "Civillian Workers", "Firefighter", 180}
 {1763.08, 2077.73, 10.82, 255, 255, 0, fireFighterVehs, "Civillian Workers", "Firefighter", 180}
 {1770.16, 2077.73, 10.82, 255, 255, 0, fireFighterVehs, "Civillian Workers", "Firefighter", 180}
 --SF
 { "Firefighter", "Civillian Workers",  -2024.38, 63.33, 28.4, 255, 255, 0, 42, {277,278,279}, 3, false, "Work as a Fire Fighter to protect the streets of SA from blazing disasters!", 275 }
 { -2024.38, 75.04, 28.4, 255, 255, 0, fireFighterVehs, "Civillian Workers", "Firefighter", 275}
 { -2024.38, 83.94, 28.4, 255, 255, 0, fireFighterVehs, "Civillian Workers", "Firefighter", 275}
 { -2024.38, 92.93, 28.4, 255, 255, 0, fireFighterVehs, "Civillian Workers", "Firefighter", 275}
 --LS
 { "Firefighter", "Firefighters",    1112.38, -1203.06, 17.77, 255, 255, 0, 42, {277,278,279}, 3, false, "Work as a Fire Fighter to protect the streets of SA from blazing disasters!", 180 }
 {  1104.01, -1206.79, 17.8, 255, 255, 0, fireFighterVehs, "Firefighters", "Firefighter", 180}
 {  1095.53, -1206.79, 17.8, 255, 255, 0, fireFighterVehs, "Firefighters", "Firefighter", 180}
 {  1086.96, -1206.79, 17.8, 255, 255, 0, fireFighterVehs, "Firefighters", "Firefighter", 180}

 --]]
local firePlaces = {
    {1201.576171875,-1281.021484375,13.3828125},
    {1453.1513671875,-1440.6044921875,13.390609741211},
    {796.775390625,-1401.515625,13.41735458374},
    {798.1220703125,-1149.09375,24.008243560791},
    {939.5380859375,-970.1240234375,38.376724243164},
    {1371.1552734375,-940.0966796875,34.1875},
    {1589.67578125,-1027.1318359375,23.90625},
    {1480.73828125,-1613.6376953125,14.039297103882},
    {2056.896484375,1273.109375,10.679658889771},
    {2410.2060546875,1646.4619140625,10.8203125},
    {2347.3095703125,2023.2138671875,10.705165863037},
    {2323.19140625,2389.318359375,10.8203125},
    {1921.9287109375,2421.0556640625,10.8203125},
    {1514.958984375,2273.9326171875,10.812744140625},
    {1077.4541015625,1763.064453125,10.8203125},
    {1496.7509765625,1580.9765625,10.8125},
    {1380.8740234375,754.6337890625,10.8203125},
    {-1527.6357421875,-404.1904296875,7.078125},
    {-1738.0205078125,103.244140625,3.5546875},
    {-1984.5517578125,368.8173828125,35.231113433838},
    {-2527.19921875,567.8203125,14.4609375},
    {-2656.09765625,608.9365234375,14.453125},
    {-2821.255859375,1304.837890625,7.1015625},
	{623.74, -1217.42, 18.1},
	{632.62, -1586.04, 15.52},
	{919.77, -1663.02, 13.39},
	{1269.63, -1823.19, 13.38},
	{1962.4, -1752.71, 13.39},
	{2492.47, -1667.47, 13.34},
	{2648.99, -1075.44, 69.45},
	{-1817.96, 142.17, 15.1},
	{-2885.11, 460.5, 4.91},
	{-1985.94, 369.42, 35.21},
	{-1756.07, 931.96, 24.74},
	{-1575.65, 1207.31, 7.19},
	{-1552.45, 386.15, 7.18},

}

local fires = {}
local cols = {}
local peds = {}
local activeFires = {}
local blips = {}
local fireAreaCols = {}
local alreadyEnteredPlayers = {}
local fireAmount = {}
local fireToIndexID = {}
local fireFighters = {}
local count = 1

while count <= #firePlaces do
    local t = {}
    table.insert(alreadyEnteredPlayers,t)
    count = count + 1
end

for k,v in pairs(firePlaces) do
    local gz = v[3]-1
    firePlaces[k][3] = gz
    local col = createColCircle(v[1],v[2],20)
    fireAreaCols[k] = col
    fireAmount[k] = 0
end

local alternateCity = 1
local activeCity = {
	[1] = false,
	[2] = false
}
function startFire(resourceJustStarted)

	for k,v in pairs(activeCity) do
		if v == false then
			alternateCity = k
			break
		end
	end

    local i = math.random(1,#firePlaces)
    local x,y,z = firePlaces[i][1],firePlaces[i][2],firePlaces[i][3]
    while (isWithinCityBoundary(alternateCity,x,y,z) == false) do
        i = math.random(1,#firePlaces)
        x,y,z = firePlaces[i][1],firePlaces[i][2],firePlaces[i][3]
    end
    activeFires[i] = true
	activeCity[alternateCity] = i
    local zoneName = getZoneName(x,y,z)
    makeFire(i)
    for k,v in pairs(getElementsByType("player")) do
        if isInFireFighterMode(v) then
			triggerClientEvent(v,"CSGfireStarted",v,x,y,z)
             exports.DENdxmsg:createNewDxMessage(v,"A Fire has broke loose at "..zoneName.."! Requesting nearby Fire Fighters!",255,255,0)
        else
            triggerClientEvent(v,"CSGfireSetCollisions",v,peds,false)
        end

    end
end

function isInFireFighterMode(p)
	local team = getPlayerTeam(p)
	if team == false then return false end
	if ((getTeamName(team)) == "Firefighters" and exports.server:getPlayerOccupation(p) == "Firefighter") then
		return true
	else
		return false
	end
end

setTimer(startFire,5000,1,true)
setTimer(startFire,10000,1,true)

function playerLogin()
	triggerClientEvent(source,"CSGfireSetCollisions",source,peds,false)
end
addEventHandler("onPlayerLogin",root,playerLogin)

function newJob(player)
	if isElement(source) then if getElementType(source) == "player" then player = source end end
    triggerClientEvent(player,"CSGfireSetCollisions",player,peds,true)
    local message = "You are now a Fire Figther, Extinguish fires and save lives!"
    local aa = 250
    local rr = 0
    local gg = 250
    local bb = 0
	giveWeapon(player,42,9000,true)
	triggerClientEvent(player,"CSGfireShiftUpdate",player,true)
     exports.DENdxmsg:createNewDxMessage(player,message,0,255,0)
        for k,v in pairs(activeFires) do
            if v == true then
                local x,y,z = firePlaces[k][1],firePlaces[k][2],firePlaces[k][3]
                local zoneName = getZoneName(x,y,z)
                triggerClientEvent(player,"CSGfireStarted",player,x,y,z)
                 exports.DENdxmsg:createNewDxMessage(player,"Hurry, a Fire is in progress at "..zoneName.."!",255,255,0)
            end
        end
end
addEvent("CSGfireBackOnShift",true)
addEventHandler("CSGfireBackOnShift",root,newJob)

function quitJob(player)
	if isElement(source) then if getElementType(source) == "player" then player = source end end
    triggerClientEvent(player,"CSGfireSetCollisions",player,peds,false)
	triggerClientEvent(player,"CSGfireEnded",player,"all")
	triggerClientEvent(player,"CSGfireShiftUpdate",player,false)
	takeWeapon(player,42)
    --local message = "You are no longer a Fire Fighter"
    -- exports.DENdxmsg:createNewDxMessage(player,message,255,255,0)
end
addEvent("CSGfireQuitJob",true)
addEventHandler("CSGfireQuitJob",root,quitJob)

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if nJob == "Firefighter" then
		newJob(source)
	else
		if oldJob == "Firefighter" then
		quitJob(source)
		else
			local team = getTeamName(getPlayerTeam(source))
			if team ~= "Firefighter" then
				quitJob(source)
			end
		end
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)

function CSGfireHitFire(fire)
    givePlayerMoney(source,math.random(5,15))
	if fires[fire] == nil then return end
    fires[fire] = fires[fire] - 20
end
addEvent("CSGfireHitFire",true)
addEventHandler("CSGfireHitFire",root,CSGfireHitFire)

function CSGfireHitFireByTruck(ped)
    for k,v in pairs(peds) do
        if k == ped then
            fires[v] = fires[v] - 40
            givePlayerMoney(source,math.random(10,30))
            return
        end
    end
end
addEvent("CSGfireHitFireByTruck",true)
addEventHandler("CSGfireHitFireByTruck",root,CSGfireHitFireByTruck)

function enterFire(e)
	local x,y,z = getElementPosition(e)
	local cx,cy,cz = getElementPosition(cols[source])
	local dist = getDistanceBetweenPoints3D(x,y,z,cx,cy,cz)
	if dist > 7 then return end
    if getElementType(e) == "player" then
        --setPedOnFire(e,true)
    elseif getElementType(e) == "vehicle" then
        --setElementHealth(e,math.random(20,100))
    end
end

function makeFire(id)
    local count = 0
    while count <= 20 do
    local firex,firey,firez = firePlaces[id][1],firePlaces[id][2],firePlaces[id][3]
    local posneg = math.random(1,2)
        -- 1 = positive
        -- 2 = negative
    if posneg == 1 then
         x1,y1,z1 = firex+math.random(1,17),firey+math.random(1,17),firez+0.5
    else
         x1,y1,z1 = firex-math.random(1,17),firey-math.random(1,17),firez+0.5
    end
    local size = math.random(2022,2024)
    if size > 2022 then size = 2024 end
    local fire1 = createObject(size,x1,y1,z1)
    fires[fire1] = 100
    local col1 = createColCircle(x1,y1,1)
    cols[col1] = fire1
    addEventHandler("onColShapeHit",col1,enterFire)
    local ped1 = createPed(59,x1,y1,z1)
    setElementFrozen(ped1,true)
    setElementAlpha(ped1,0)
    peds[ped1] = fire1
    count = count + 1
    fireAmount[id] = fireAmount[id] + 1
    fireToIndexID[fire1] = id
    end
end

function healthManage()
    for k,v in pairs(fires) do
        if k ~= nil then
            if isElement(k) then
                if (v < 5) or (fireAmount[fireToIndexID[k]] < 2) then
                    destroyElement(k)
                    fireAmount[fireToIndexID[k]] = fireAmount[fireToIndexID[k]] - 1
                    fireToIndexID[k] = nil
                    fires[k] = nil
                    for k2,v2 in pairs(cols) do
                        if v2 == k then
                        destroyElement(k2)
                        cols[k2] = nil
                        break
                        end
                    end
                    for k3,v3 in pairs(peds) do
                        if v3 == k then
                        destroyElement(k3)
                        peds[k3] = nil
                        break
                        end
                    end
                else
                   fires[k] = fires[k] - 0.25
                end
            end
        end
    end
end
setTimer(healthManage,1000,0)

function healthManage2()
    for k,v in pairs(fireAreaCols) do
        if fireAmount[k] < 2 then
            if activeFires[k] == true then
				local x,y,z = firePlaces[k][1],firePlaces[k][2],firePlaces[k][3]
                local zoneName = getZoneName(x,y,z)
                setTimer(startFire,10000,1)
                activeFires[k] = false
				for city,fireID in pairs(activeCity) do
					if fireID == k then
						activeCity[city] = false
					end
				end
                for k3,v3 in pairs(getElementsByType("player")) do
                    if isInFireFighterMode(v3) then
						 exports.DENdxmsg:createNewDxMessage(v3,"The fire at "..zoneName.." has been put out!",0,255,0)
                        triggerClientEvent(v3,"CSGfireEnded",v3,firePlaces[k][1])
                    end
                end
            end

        end
    end
end
setTimer(healthManage2,2000,0)

function droppedWater()
	local x,y,z = getElementPosition(getPedOccupiedVehicle(source))
	local obj = createObject(2070,x,y,z-3.5)
	setElementRotation(obj,0,180,0)
	setObjectScale(obj,3)
	setTimer(destroyElement,2000,1,obj)
end
addEvent("CSGfire.DropWater",true)
addEventHandler("CSGfire.DropWater",root,droppedWater)

local cityBoundary = 1600
local cities = {
[1] = "LS",
[2] = "SF",
[3] = "LV"
}
local cityNames = {
[1] = "Los Santos",
[2] = "San Fierro",
[3] = "Las Venturas"
}
local cityCenters = {
[1] = {1622.94140625, -1548.486328125, 13.671937942505},
[2] = {-2259.66015625, 543.3671875, 35.11096572876},
[3] = {2181.0390625, 1773.41015625, 10.671875}
}

function isWithinCityBoundary(cityID,x1,y1,z1)
    if cityID ~= 0 then
    else
    cityID = city
    end
    local dist = getDistanceBetweenPoints2D(x1,y1,cityCenters[cityID][1],cityCenters[cityID][2])
    if dist <= cityBoundary then
    return true
    else
    return false
    end
end

-------------
--[[

function circle(r,s,cx,cy)
	xVals = {}
	yVals = {}
	for i=1,s-1 do
		xVals[i] = (cx+r*math.cos(math.pi*i/s*2-math.pi/2))
		yVals[i] = (cy+r*math.sin(math.pi*i/s*2-math.pi/2))
		--outputChatBox('('..xVals[i]..','..yVals[i]..')')
	end
end
circle(60,100,1223.72,-1331.12)
size = #xVals

for k,v in pairs(xVals) do
	local x = v
	local y = yVals[k]
	local z = 15
	exports.slothbot:spawnBot(x,y,z,50,50,0,0,getTeamFromName("Criminals"),38,"guarding")
end
--]]
