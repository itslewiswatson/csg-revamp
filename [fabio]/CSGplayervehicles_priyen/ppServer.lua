aeh = addEventHandler
ae = addEvent
tce = triggerClientEvent
connection=exports.DENmysql:getConnection()
local allVehs = {}
local vehData = {}
local idToVeh = {}
local vehToID = {}
local playerToVeh = {}
local vehCol = {}
ae("onPlayerLogin",true)
aeh("onPlayerLogin",root,function()

dbQuery(loginCallBack,{source},connection,"SELECT * FROM vehicles WHERE ownerid=?", exports.server:getPlayerAccountID(source))
end)

hexToRGB = function(l_19_0)
l_19_0 = l_19_0:gsub("#", "")
return tonumber("0x" .. l_19_0:sub(1, 2)), tonumber("0x" .. l_19_0:sub(3, 4)), tonumber("0x" .. l_19_0:sub(5, 6))
end

function getPlayerVehicles(p)
	local t = exports.DENmysql:query("SELECT * FROM vehicles WHERE ownerid=?", exports.server:getPlayerAccountID(p))
	return #t
end

ae("onPlayerSellVehicle", true)
aeh("onPlayerSellVehicle", root, function(id,price)

local l_6_1 = exports.DENmysql:querySingle("SELECT * FROM vehicles WHERE uniqueid=?", id)
local name = getVehicleNameFromModel(l_6_1.vehicleid)
if l_6_1.vehicleid == 401 then name = "Ferrari" end
if l_6_1.vehicleid == 503 then name = "Lamborghini" end
exports.DENdxmsg:createNewDxMessage(source, "You sold your " .. name .. " for $" .. price.."", 0, 255, 0)
exports.CSGaccounts:addPlayerMoney(source, price)
local veh = idToVeh[id]
if veh ~= nil then
	if isElement(vehCol[veh]) then destroyElement(vehCol[veh]) end
	destroyElement(idToVeh[id])
	for k,v in pairs(allVehs) do
		if v == veh then
			table.remove(allVehs,k)
			break
		end
	end
	for k,v in pairs(playerToVeh[source]) do
		if v == veh then
			table.remove(playerToVeh[source],k)
			break
		end
	end
end
exports.DENmysql:exec("DELETE FROM vehicles WHERE uniqueid=?", id)
dbQuery(sendVehsCallBack,{source},connection,"SELECT * FROM vehicles WHERE ownerid=?", exports.server:getPlayerAccountID(source))

end
)

function sendVehsCallBack(qh,source)
	local myVehs = dbPoll(qh,0)
	triggerClientEvent(source, "recVehs", source, myVehs)
end

function spawnVehicle(vehID,player,veh,bought)
	if (veh) then else veh=nil end
	if (bought) then else bought=nil end
	dbQuery(spawnCallBack,{vehID,player,veh,bought},connection,"SELECT * FROM vehicles WHERE uniqueid=?", vehID)
end

function spawnCallBack(qh,vehID,player,veh,bought)
	if isElement(player) == false then return end
	local queryReturnT=dbPoll(qh,0)
	if queryReturnT then
		queryReturnT=queryReturnT[1]
		if playerToVeh[player] and #playerToVeh[player] >= 2 then
			exports.DENdxmsg:createNewDxMessage(player, "You can only spawn 2 vehicles at the same time!", 225, 0, 0)
		elseif idToVeh[vehID] then
			exports.DENdxmsg:createNewDxMessage(player, "You already spawned this vehicle!", 225, 0, 0)
		else
			local plate="CSG"
			if queryReturnT.licenseplate ~= nil and tostring(queryReturnT.licenseplate) ~= "" and tostring(queryReturnT.licenseplate) ~= "nil" then
				plate=queryReturnT.licenseplate
			end
			local newVeh = createVehicle(queryReturnT.vehicleid, queryReturnT.x, queryReturnT.y, queryReturnT.z, 0, 0, queryReturnT.rotation,plate)
			vehCol[newVeh] = createColCircle(1,1,30)
			if queryReturnT.vehicleid == 401 or queryReturnT.vehicleid == 503 then
				setVehicleHandling(newVeh, "mass", 1400)
				setVehicleHandling(newVeh, "turnMass", 3000)
				setVehicleHandling(newVeh, "dragCoeff", 2)
				setVehicleHandling(newVeh, "centerOfMass", { 0, -0.3, 0 } )
				setVehicleHandling(newVeh, "percentSubmerged", 70)
				setVehicleHandling(newVeh, "tractionMultiplier", 0.75)
				setVehicleHandling(newVeh, "tractionLoss", 0.85)
				setVehicleHandling(newVeh, "tractionBias", 0.45)
				setVehicleHandling(newVeh, "numberOfGears", 5)
				setVehicleHandling(newVeh, "maxVelocity", 340)
				setVehicleHandling(newVeh, "engineAcceleration", 56)
				setVehicleHandling(newVeh, "engineInertia", 100)
				setVehicleHandling(newVeh, "driveType", "awd")
				setVehicleHandling(newVeh, "engineType", "diesel")
				setVehicleHandling(newVeh, "brakeDeceleration", 17)
				setVehicleHandling(newVeh, "brakeBias", 0.51)
			end
			if queryReturnT.vehicleid == 526 then
				warpPedIntoVehicle(thePlayer, newVeh)
				setElementData(newVeh, "vehicleType", "PremiumCar")
				setElementData(newVeh, "vehicleOwner", thePlayer)
				local handlingTable = getVehicleHandling ( newVeh )
				local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 40 ) )
				setVehicleHandling ( newVeh, "numberOfGears", 5 )
				setVehicleHandling ( newVeh, "driveType", 'awd' )
				setVehicleHandling ( newVeh, "maxVelocity", newVelocity )
				setVehicleHandling ( newVeh, "engineAcceleration", handlingTable["engineAcceleration"] +8 )
			end
			attachElements(vehCol[newVeh],newVeh)
			if playerToVeh[player] == nil then playerToVeh[player]={} end
			table.insert(playerToVeh[player], newVeh)
			vehToID[newVeh] = queryReturnT.uniqueid
			idToVeh[queryReturnT.uniqueid] = newVeh
			table.insert(allVehs,newVeh)
			setElementData(newVeh, "vehicleOwner", player)
			setElementData(newVeh, "vehicleType", "playerVehicle")
			setElementData(newVeh, "vehicleFuel", queryReturnT.fuel)
			setElementData(newVeh, "vehicleID", queryReturnT.uniqueid)
			local l_14_5 = split(queryReturnT.wheelstates, ",")
			setVehicleWheelStates(newVeh, l_14_5[1], l_14_5[2], l_14_5[3], l_14_5[4])
			local l_14_6 = fromJSON(queryReturnT.vehiclemods)
			if l_14_6 then
				for player0,player1 in pairs(l_14_6) do
					addVehicleUpgrade(newVeh, player1)
				end
			end
			if queryReturnT.paintjob < 3 then
				setVehiclePaintjob(newVeh, queryReturnT.paintjob)
			end
			if tonumber(queryReturnT.vehiclehealth) < 250 then
				setElementHealth(newVeh, 250)
				setVehicleEngineState(newVeh, false)
				setVehicleDamageProof(newVeh, true)
				setElementFrozen(newVeh,true)
			else
				setElementHealth(newVeh, queryReturnT.vehiclehealth)
			end
			if veh then
				warpPedIntoVehicle(player, newVeh)
			end
			if queryReturnT.locked == 1 then
				setVehicleLocked(newVeh,true)
			end

			local player2, player3, player4 = hexToRGB(queryReturnT.color1)
			local player5, player6, player7 = hexToRGB(queryReturnT.color2)
			setVehicleColor(newVeh, player2, player3, player4, player5, player6, player7)
			tce(player,"spawnedID",player,vehID,1,newVeh,bought)
			exports.DENmysql:exec("UPDATE vehicles SET spawned=? WHERE uniqueid=?",1,vehID)
			return newVeh
		end
	end
end

ae("spawnVeh",true)
aeh("spawnVeh",root,function(id)
	spawnVehicle(id,source)
end)
--[[
local enginemanage = {}
addCommandHandler("engine",function(ps)
	if isPedInVehicle(ps) then
		if getPedOccupiedVehicleSeat(ps) == 0 then
			local v = getPedOccupiedVehicle(ps)
			local e = not(getVehicleEngineState(v))
			enginemanage[v]=e
		end
	end
end)

addEventHandler("onVehicleEnter",root,function()
	if (enginemanage[source]) then
		if getVehicleEngineState(source) ~= enginemanage[source] then
			setVehicleEngineState(source,enginemanage[source])
		end
	end
end)

addEventHandler("onElementDestroy",root,function()
	if enginemanage[source] then enginemanage[source]=nil end
end)
--]]
--[[
addEventHandler("onVehicleEnter",root,function()
	if isVehicleLocked(source) then cancelEvent() end
end)
--]]
ae("CSGveh.toggleLock",true)
aeh("CSGveh.toggleLock",root,function(id)
local veh = idToVeh[id]
if veh == nil then return end
if isElement(veh) == true then
	if getElementType(veh) == "vehicle" then

	else
		return
	end
else
	return
end
local name = getVehicleName(veh)
if getElementModel(veh) == 401 then name="Ferrari" end
if getElementModel(veh) == 503 then name = "Lamborghini" end
if isVehicleLocked(veh) then
	setVehicleLocked(veh,false)
	exports.DENmysql:exec("UPDATE vehicles SET locked=? WHERE uniqueid=?",0,id)
	exports.dendxmsg:createNewDxMessage(source,"You have unlocked your "..name.."",0,255,0)
else
	setVehicleLocked(veh,true)
	exports.DENmysql:exec("UPDATE vehicles SET locked=? WHERE uniqueid=?",1,id)
	exports.dendxmsg:createNewDxMessage(source,"You have locked your "..name.."",0,255,0)
end
local x,y,z = getElementPosition(veh)
for k,v in pairs(getElementsWithinColShape(vehCol[veh],"player")) do
	tce(v,"playLocked",v,x,y,z)
end
local state = isVehicleLocked(veh)
if state == true then state=1 else state=0 end
tce(source,"vehLockStatus",source,id,state)
end)


getVehicleUpgradesJSON = function(veh)
local l_11_1 = {}
local l_11_2 = false
for l_11_6 = 0, 16 do
	local l_11_7 = getVehicleUpgradeOnSlot(veh, l_11_6)
	if l_11_7 then
		l_11_1[l_11_6] = l_11_7
		l_11_2 = true
	end
end
if l_11_2 then
	return toJSON(l_11_1)
else
	return "NULL"
end
end


onSaveVehicleUpgrades = function(veh, id)
if exports.DENmysql:exec("UPDATE vehicles SET vehiclemods=? WHERE uniqueid=?", getVehicleUpgradesJSON(veh), id) then
	return true
else
	return false
end
end

function cpvCallBack(qh,p)
	local l_18_12 = dbPoll(qh,0)
	if l_18_12 then
		l_18_12 = l_18_12[1]
		if playerToVeh[p] and #playerToVeh[p] == 2 then
			unspawnVeh(vehToID[playerToVeh[p][1]],nil,p,true)
		end
		local veh = spawnVehicle(l_18_12.uniqueid, p,nil,true)
		return veh
	end
end


createPlayerVehicle = function(p, l_18_1, l_18_2, l_18_3, l_18_4, l_18_5, l_18_6, l_18_7, l_18_8, l_18_9, l_18_10,plate)
if p and l_18_1 and l_18_2 and l_18_3 and l_18_4 and l_18_5 and l_18_7 and l_18_8 and l_18_9 and l_18_10 then
	local l_18_11 = exports.DENmysql:exec("INSERT INTO vehicles SET vehicleid=?, ownerid=?, vehiclehealth=?, boughtprice=?, color1=?, color2=?, x=?, y=?, z=?, rotation=?, licenseplate=?, spawned=?, locked=?", l_18_1, l_18_2, l_18_3, l_18_4, l_18_5, l_18_6, l_18_7, l_18_8, l_18_9, l_18_10,plate,1,0)
	if l_18_11 then
		dbQuery(sendVehsCallBack,{p},connection,"SELECT * FROM vehicles WHERE ownerid=?", exports.server:getPlayerAccountID(p))
	else
		return
	end
	dbQuery(cpvCallBack,{p},exports.DENmysql:getConnection(),"SELECT * FROM vehicles WHERE color1=? AND color2=? AND ownerid=?", l_18_5, l_18_6, l_18_2)
end
end



aeh("onVehicleDamage",root,function(loss)
if getElementData(source,"vehicleID") ~= false then
	if getElementHealth(source)-loss <= 251 then
		for k,v in pairs(getVehicleOccupants(source)) do
			exports.dendxmsg:createNewDxMessage(v,"This vehicle is too damaged. Engine shutting down..",255,255,0)
		end
	end
end
end)

function unspawnVeh(id,updateSpawnedStatus,p,bought)
	if (p) then source=p end
	local theVeh = idToVeh[id]
	local temp = theVeh
	if isElement(source) then
		triggerEvent("CSGplayervehicles.despawned",source,theVeh)
	end
	local l_13_7, l_13_8, l_13_9 = getElementPosition(theVeh)
	local l_13_10, l_13_11, l_13_12 = getElementRotation(theVeh)
	local l_13_13 = getElementHealth(theVeh)
	local l_13_14 = getVehiclePaintjob(theVeh)
	local l_13_15, l_13_16, l_13_17, l_13_18, l_13_19, l_13_20 = getVehicleColor(theVeh, true)
	local l_13_21 = exports.server:convertRGBToHEX(l_13_15, l_13_16, l_13_17)
	local l_13_22 = exports.server:convertRGBToHEX(l_13_18, l_13_19, l_13_20)
	local l_13_23, l_13_24, l_13_25, l_13_26 = getVehicleWheelStates(theVeh)
	local l_13_27 = l_13_23 .. "," .. l_13_24 .. "," .. l_13_25 .. "," .. l_13_26
	local fuel = math.floor(getElementData(theVeh, "vehicleFuel")) or 100
	local l_13_29 = false
	l_13_29 = exports.DENmysql:exec("UPDATE vehicles SET x=?, y=?, z=?, rotation=?, vehiclehealth=?, paintjob=?, color1=?, color2=?, wheelstates=?, fuel=? WHERE uniqueid=?", l_13_7, l_13_8, l_13_9, l_13_12, l_13_13, l_13_14, l_13_21, l_13_22, l_13_27, fuel,l_13_0)
	if (updateSpawnedStatus) then
		if updateSpawnedStatus == false then
		else
			exports.DENmysql:exec("UPDATE vehicles SET spawned=? WHERE uniqueid=?",0,id)
		end
	else
		exports.DENmysql:exec("UPDATE vehicles SET spawned=? WHERE uniqueid=?",0,id)
	end
	if l_13_29 then
		idToVeh[id]=nil
		vehToID[theVeh]=nil
		onSaveVehicleUpgrades(theVeh, l_13_0)
		if isElement(vehCol[theVeh]) then destroyElement(vehCol[theVeh]) end
		destroyElement(theVeh)
	end
	if isElement(idToVeh[id]) then
		if isElement(vehCol[idToVeh[id]]) then destroyElement(vehCol[idToVeh[id]]) end
		destroyElement(idToVeh[theVeh])
		idToVeh[id] = false
	end
	for k,v in pairs(allVehs) do
		if v == temp then
			table.remove(allVehs,k)
			break
		end
	end
	if isElement(source) then
		for k,v in pairs(playerToVeh[source]) do
			if v == temp then
				table.remove(playerToVeh[source],k)
			end
		end
		tce(source,"spawnedID",source,id,0,nil,bought)
	end
end
ae("unspawnVeh",true)
aeh("unspawnVeh",root,unspawnVeh)

aeh("onPlayerQuit",root,function()
if playerToVeh[source] == nil then return end
for k,v in pairs(playerToVeh[source]) do
	for _,player in pairs(getVehicleOccupants(v)) do
		exports.dendxmsg:createNewDxMessage(player,"The owner of this vehicle has logged off. The vehicle will be despawned in 10 seconds.",255,255,0)
	end
	setTimer(function()
	local id = vehToID[v]
	local updateSpawnedStatus = false
	unspawnVeh(id,updateSpawnedStatus)
	end,10000,1)
end
vehData[source]=nil
end)

setTimer(function()
for k,source in pairs(getElementsByType("player")) do
	if exports.server:isPlayerLoggedIn(source) then
		dbQuery(loginCallBack,{source},connection,"SELECT * FROM vehicles WHERE ownerid=?", exports.server:getPlayerAccountID(source))
	end
end
end,5000,1)

function loginCallBack(qh,source)
	if isElement(source) == false then return end
	playerToVeh[source]={}
	vehData[source]=dbPoll(qh,0)

	if vehData[source] == nil then return end
	tce(source,"recVehs",source,vehData[source])
	for k,v in pairs(vehData[source]) do
		if v.spawned == 1 then
			spawnVehicle(v.uniqueid,source)
		end
	end
end

function regSave()
	for k,theVeh in pairs(allVehs) do
		if theVeh ~= nil then
			if isElement(theVeh) then
				local id = getElementData(theVeh,"vehicleID")
				onSaveVehicleUpgrades(theVeh,id)
				local l_13_0 = id
				local l_13_7, l_13_8, l_13_9 = getElementPosition(theVeh)
				local l_13_10, l_13_11, l_13_12 = getElementRotation(theVeh)
				local l_13_13 = getElementHealth(theVeh)
				local l_13_14 = getVehiclePaintjob(theVeh)
				local l_13_15, l_13_16, l_13_17, l_13_18, l_13_19, l_13_20 = getVehicleColor(theVeh, true)
				local l_13_21 = exports.server:convertRGBToHEX(l_13_15, l_13_16, l_13_17)
				local l_13_22 = exports.server:convertRGBToHEX(l_13_18, l_13_19, l_13_20)
				local l_13_23, l_13_24, l_13_25, l_13_26 = getVehicleWheelStates(theVeh)
				local l_13_27 = l_13_23 .. "," .. l_13_24 .. "," .. l_13_25 .. "," .. l_13_26
				local fuel = math.floor(getElementData(theVeh, "vehicleFuel")) or 100
				local l_13_29 = false
				l_13_29 = exports.DENmysql:exec("UPDATE vehicles SET x=?, y=?, z=?, rotation=?, vehiclehealth=?, paintjob=?, color1=?, color2=?, wheelstates=?, fuel=? WHERE uniqueid=?", l_13_7, l_13_8, l_13_9, l_13_12, l_13_13, l_13_14, l_13_21, l_13_22, l_13_27, fuel,l_13_0)
			end
		end
	end
end
setTimer(regSave,5000,0)

local recoverPlaces = {
{1584.91, -1019.05, 23.9},
{1956.64, 2164.12, 10.82},
{-1730.2, -78.31, 3.55},
}

ae("recoverVeh",true)
aeh("recoverVeh",root,function(id,rID)
setElementPosition(idToVeh[id],recoverPlaces[rID][1],recoverPlaces[rID][2],recoverPlaces[rID][3]+(math.random(3,50)))
end)

function getPlayerVehicleSlots(p)
	return 10
end

local givenstars = {}
local copids = {
	[596] = true,
	[597] = true,
	[599] = true,
	[598] = true,
	[523] = true,
	[426] = true,
	[415] = true,
	[427] = true,
	[433] = true,
	[490] = true,
	[528] = true,
	[579] = true
}

setTimer(function()
	for k,v in pairs(givenstars) do
		if getTickCount() - v >= 300000 then
			givenstars[k] = nil
		end
	end
end,5000,0)
local lawTeams = {
	"Military Forces",
	"SWAT",
	"Police",
	"Government Agency"
}

function isLaw(e)
	local team = getTeamName(getPlayerTeam(e))
	for k,v in pairs(lawTeams) do if v == team then return true end end
	return false
end

aeh("onVehicleExit",root,function(p)
	local model = getElementModel(source)
	if (copids[model]) then
		local unit = false
		for k,v in pairs(getVehicleOccupants(source)) do
			if getElementData(v,"skill") == "High Speed Unit" then
				unit=true
				break
			end
		end
		if unit == false then
			setVehicleHandling(source,"maxVelocity",200)
			setVehicleHandling(source,"engineAcceleration",10)
		end
	end
end)

aeh("onVehicleEnter",root,function(p,seat)
local model = getElementModel(source)
if seat==0 and getElementData(source,"vehicleOccupation") ~= false and (getElementData(source,"vehicleOccupation")=="Military Forces" or getElementData(source,"vehicleOccupation")=="SWAT Team" or getElementData(source,"vehicleOccupation") == "Federal Agent") then

	if isLaw(p)==true then
		if getElementData(p,"skill") == "High Speed Unit" then
			if getVehicleType(source) == "Automobile" then
				setVehicleHandling(source,"maxVelocity",200)
				setVehicleHandling(source,"engineAcceleration",15)
			end
		end
	elseif getElementData(source,"vehicleOccupation") ~= "Criminal" then
		if (givenstars[exports.server:getPlayerAccountName(p)]) then return end
		givenstars[exports.server:getPlayerAccountName(p)] = getTickCount()
		exports.CSGwanted:addWanted(p,38,getRandomPlayer())
	end
end
if (math.floor(getElementHealth(source)/10) <= 25) then
	exports.dendxmsg:createNewDxMessage(p,"This vehicle is broken and/or out of fuel",255,255,0)
	setVehicleEngineState(source,false)
	return
end
local fuel = getElementData(source,"vehicleFuel")
if fuel == false or fuel == nil then

elseif fuel <= 0 then
	exports.dendxmsg:createNewDxMessage(p,"This vehicle is broken and/or out of fuel",255,255,0)
	setVehicleEngineState(source,false)
	return
end
end)

addEventHandler("onVehicleExplode",root,function()
	local veh = source
	local id = getElementData(source,"vehicleID")
	local owner = getElementData(source,"vehicleOwner")
	if (id) then
		local x,y,z = getElementPosition(source)
		local _,_,rz = getElementRotation(source)
		exports.DENmysql:exec("UPDATE vehicles SET vehiclehealth=?, x=?,y=?,z=?,rotation=? WHERE uniqueid=?",0,x,y,z,rz,id)
		unspawnVeh(id,false,owner)
		setTimer(function() if not isElement(owner) then return end spawnVehicle(id,owner) end,6000,1)
	end
end)

