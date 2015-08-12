------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  ppBusdriver_s.lua (server-side)
--  Bus Driver Job
--  Priyen Patel
------------------------------------------------------------------------------------

local routes = {
[1] = { 
	["name"] = "#4A - LS -> East SA -> LV",
    [1] = {1444.467,-1040.944,23,"LS North"},
    [2] = {1023,-947,42,"Fuel Station"},
    [3] = {1025,-1046,31,"Transfender / Pay N Spray"},
    [4] = {1207,-928,42,"BurgerShot"},
    [5] = {1536,-1658,13,"LSPD"},
    [6] = {1828,-1884,13,"South East LS"},
    [7] = {1941,-2172,13,"LS Airport"},
    [8] = {2268,48,26,"East SA"},
    [9] = {1243,158,19,"East SA"},
    [10] = {1706,1416,10,"LV"}
    },
[2] = {
	["name"] = "#4B - Core LS",
    {1155.6630859375, -1698.1650390625, 13.005454063416,"Bobs Clothing Store"},
    {1292.146484375, -1667.2138671875, 12.602264404297,"SWAT Base"},
    {1359.9541015625, -1738.1416015625, 12.59783744812,"Roboi's Food Mart"},
    {1531.6064453125, -1738.0498046875, 12.608879089355,"LSPD"},
    { 1767.1728515625, -1860.23828125, 12.63715171814,"Unity Station"},
    {1827.1708984375, -1843.841796875, 12.641595840454,"69c Store"},
    {1826.822265625, -1683.3037109375, 12.59435653686,"Alhambra Place"},
    {1994.3125, -1471.642578125, 12.615921974182,"Jefferson Hospital"},
    {2241.3974609375, -1295.248046875, 23.046747207642,"LS Church"},
    {2091.7021484375, -1226.7958984375, 23.086851119995,"Discount Warehouse"}
    },
[3] = {
	["name"] = "#4C - Round LS",
    {1152.6716308594,-1746.7940673828,12.5703125,"Conference-Center"},
    {1082.7672119141,-1705.6179199219,12.546875,"Paper-Cuts"},
    {879.86083984375,-1568.7951660156,12.539081573486,"Big-Liquor&Dell"},
    {818.26007080078,-1626.1544189453,12.546875,"BurgerShot"},
    {701.77514648438,-1742.6643066406,12.802894592285,"Ocean-LS-River"},
    {452.54336547852,-1735.6057128906,8.6251792907715,"LS Beach"},
    {154.12236022949,-1731.0521240234,4.1827816963196,"LS-Beach-Lighthouse"},
    {372.89801025391,-1379.7884521484,13.639019966125,"Optimetric-Motel"},
    {610.42224121094,-1228.6127929688,17.375513076782,"Richman-Complex"},
    {843.70330810547,-1042.248046875,24.46764755249,"NewsStand"},
    {1023.5825805664,-1046.3170166016,30.617599487305,"Transfender-Pay&Spray"}
    }
}
local veh = { }

--[[
function jobVehSpawned(client, veh, id, x, y, z)
    if exports.server:getPlayerOccupation(client) ~= "Bus Driver" then return end
    if id == 431 or id == 437 then    
        triggerClientEvent(client, "CSGbusDriverjobVehSpawned", client)
        exports.CSGhelp:setBottomTextServer(client,"Press [F5] to access the Bus Driver Control Panel.",0,255,0)
    end
end
addEvent("CSGjobvehicles.spawnedVehicle", true)
addEventHandler("CSGjobvehicles.spawnedVehicle", root, jobVehSpawned)
--]]
function newJob(player)
    exports.DENhelp:createNewHelpMessageForPlayer(player,"Press [F5] to access the Bus Driver Control Panel.",0,255,0)
end

function quitJob(player)
    triggerClientEvent(player, "quitBusDriver", player)
end

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if oldJob == "Bus Driver" then
		quitJob(source)
	elseif nJob == "Bus Driver" then
		newJob(source)
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)

function payBusDriver(pay)
    givePlayerMoney(source, pay)
    exports.DENhelp:createNewHelpMessageForPlayer(source,"Successfully finished the route. You have been paid $"..pay.." for your service.", 0,255,0)
end
addEvent("payBusDriver", true)
addEventHandler("payBusDriver", getRootElement(), payBusDriver)
--[[
function giveWantedStars(p, pts)
	exports.server:givePlayerWantedPoints(p, pts)
end
addEvent("giveWantedStars", true)
addEventHandler("giveWantedStars", root, giveWantedStars)
--]]
--[[
function setStatBusdriver(stat, change)
    local new = exports.CSGaccounts:getAccountInfo(source, stat)+change
    exports.CSGaccounts:setAccountInfo(source,stat,new)
end
addEvent("setStatBusdriver", true)
addEventHandler("setStatBusdriver", getRootElement(), setStatBusdriver)
--]]
--[[
function sendStatsTable()
local t1 = {
["Stops Arrived To"] = exports.CSGaccounts:getAccountInfo(source, "busdriverStopsArrivedTo"),
["Routes (Attempt)"] = exports.CSGaccounts:getAccountInfo(source, "busdriverRoutesAttempted"),
["Routes (Success)"] = exports.CSGaccounts:getAccountInfo(source, "busdriverRoutesCompleted"),
["Real Passengers"] = exports.CSGaccounts:getAccountInfo(source, "busdriverRealPassengers"),
["Died On Job"] = exports.CSGaccounts:getAccountInfo(source, "busdriverDiedOnJob"),
["Buses Spawned"] = exports.CSGaccounts:getAccountInfo(source, "busdriverBusesSpawned")
}

triggerClientEvent(source, "receiveStatsBusdriver", source, t1)
end
addEvent("sendStatsTableBusdriver", true)
addEventHandler("sendStatsTableBusdriver", getRootElement(), sendStatsTable)
--]]

function sendRoutes()
    triggerClientEvent(source,"recRoutes", source, routes)
end
addEvent("sendRoutes", true)
addEventHandler("sendRoutes", root, sendRoutes)

function announceToAllPassengers(msg,t,r,g,b)
    for k,v in pairs(t) do
		exports.DENhelp:createNewHelpMessageForPlayer(v,msg,r,g,b)
    end
end
addEvent("announceToAllPassengers", true)
addEventHandler("announceToAllPassengers", root, announceToAllPassengers)

--[[
function checkThenCharge(passenger,fare,driver)
    if isPedInVehicle(passenger) then
        if getPedOccupiedVehicle(passenger) == getPedOccupiedVehicle(driver) then
            if getElementModel(getPedOccupiedVehicle(driver)) == 431 or getElementModel(getPedOccupiedVehicle(driver)) == 437 then
                if getPlayerMoney(passenger) < fare then
                exports.CSGpolice:addWanted(passenger,17)
                end
                exports.CSGaccounts:accTakeCash(passenger,fare,"bus driver real person passenger payment.")
                exports.CSGaccounts:accGiveCash(driver,fare,"bus driver real person passenger payment.")
                outputChatBox("Paid Bus fare of $"..fare.." to Bus Driver "..getPlayerName(driver).."",passenger,255,255,0,true)
                outputChatBox("Recieved Bus fare of $"..fare.." from Passenger "..getPlayerName(passenger).."",driver,0,255,0,true)
            end
        end
    end
end
--]]
--[[
function busEnterNotice(p,fare)
    outputChatBox("You have entered "..getPlayerName(source).."'s bus. The fare is $"..fare..". If you cannot afford this, please get off before you are charged (10s).",p,255,255,0,true)
    setTimer(checkThenCharge,10000,1,p,fare,source)
end
addEvent("busEnterNotice", true)
addEventHandler("busEnterNotice", root, busEnterNotice)
--]]

function isBusDriverVeh(veh)
    local model = getElementModel(veh)
    if model == 431 or model == 437 then return true else return false end
end

local busdriversFare = {}
function CSGbusdriverNewFare(fare)
    busdriversFare[source] = fare
    local veh = getPedOccupiedVehicle(source)
    local pName = getPlayerName(source) 
    if veh ~= false then
		if getPedOccupiedVehicleSeat(source) == 0 then
			if isBusDriverVeh(veh) == true then
				local t = getVehicleOccupants(veh)
				for k,p in pairs(t) do
					exports.DENhelp:createNewHelpMessageForPlayer(p,"Bus Driver "..pName.." Has changed the fare to $"..fare.."",255,255,0)
				end
			end
		end
    end
end
addEvent("CSGbusdriverNewFare",true)
addEventHandler("CSGbusdriverNewFare",root,CSGbusdriverNewFare)


function enterVeh(veh,seat,jacked)
    if seat == 0 then return end   
    if isBusDriverVeh(veh) == true then
        local driver = getVehicleController(veh)
        if exports.server:getPlayerOccupation(driver) == "Bus Driver" then
            local fare = busdriversFare[driver]
            if fare == nil then
            fare = 100
            busdriversFare[driver] = 100
            end
            exports.DENhelp:createNewHelpMessageForPlayer(source,""..getPlayerName(driver).."'s vehicle, Fare: $"..fare.. "Paying within 10 seconds.",255,255,0)
            exports.DENhelp:createNewHelpMessageForPlayer(driver,"New Passenger: "..getPlayerName(source).. ". Expecting fare in 10 seconds.",0,255,0)
            setTimer(step2,10000,1,driver,source,veh,fare)
        end
    else
        return
    end
end
addEventHandler("onPlayerVehicleEnter",root,enterVeh)

function step2(driver,player,veh,fare)
    local playerVeh = getPedOccupiedVehicle(player)
    local passName = getPlayerName(player)
    if playerVeh == veh then
        if getPedOccupiedVehicle(driver) == veh then
            local playerMoney = getPlayerMoney(player)
            if playerMoney >= tonumber(fare) then
                exports.DENhelp:createNewHelpMessageForPlayer(player,"Paid Bus Driver "..getPlayerName(driver).. "Full $"..fare.."","Fare.",0,255,0)
                exports.DENhelp:createNewHelpMessageForPlayer(driver,"Received Full Fare of $"..fare.." From  Passenger "..passName.."",0,255,0)
            else
                fare = playerMoney
                exports.DENhelp:createNewHelpMessageForPlayer(player,"Paid Bus Driver "..getPlayerName(driver).." Partial $"..fare.. "Fare.",255,255,0)
                exports.DENhelp:createNewHelpMessageForPlayer(driver,"Received Partial Fare of $"..fare.." from Passenger "..passName.."",255,255,0)
                exports.server:givePlayerWantedPoints(player, 10)
            end
			takePlayerMoney(player,fare)
			givePlayerMoney(driver,fare)
        end
    end
end

--[[
function announceBusDriverOnDuty(fare)
    for k,v in pairs(getElementsByType("player")) do
        exports.CSGhelp:setBottomTextServer("#003366Bus Driver "..getPlayerName(source).." #FFFFFFis on #006666duty#FFFFFF with a fare of #336600$"..fare.."",255,255,255,255,v)
    end
end
addEvent("announceBusDriverOnDuty",true)
addEventHandler("announceBusDriverOnDuty",root,announceBusDriverOnDuty)
--]]