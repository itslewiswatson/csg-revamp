--variables

local allPlayerVehicles = {}
local playerVehicles = {}
local idToVehicle = {}
local vehicleToID = {}
local vehiclesBrokenDown = {}
-- utility functions

function updateClientInfo(player,id,keyValueTable)
	if not isElement(player) then return false end
	triggerClientEvent(player,"CSGplayerVehicles:client.updateVehicleInfo",player,id,keyValueTable)
end

function getVehicleID(vehicle)
	return vehicleToID[vehicle]
end
function getVehicleFromID(id)
	return idToVehicle[id]
end

function getVehicleName(model)
	local name = getVehicleNameFromModel(model)
	return name
end

function getPlayerVehicleSlots(player)
	if not exports.server:isPlayerPremium(player) then
		return 10
	else
		return 15
	end
end

function getPlayerVehicles(player)
	local vehicles = exports.DENmysql:query("SELECT * FROM vehicles WHERE ownerid=?", exports.server:getPlayerAccountID(player))
	return vehicles
end

function hexToRGB(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

function applyVehicleSpecials(vehicle)
	local vehID = getElementModel(vehicle)
	if vehID == 401 or vehID == 503 then
		setVehicleHandling(vehicle, "mass", 1400)
		setVehicleHandling(vehicle, "turnMass", 3000)
		setVehicleHandling(vehicle, "dragCoeff", 2)
		setVehicleHandling(vehicle, "centerOfMass", { 0, -0.3, 0 } )
		setVehicleHandling(vehicle, "percentSubmerged", 70)
		setVehicleHandling(vehicle, "tractionMultiplier", 0.75)
		setVehicleHandling(vehicle, "tractionLoss", 0.85)
		setVehicleHandling(vehicle, "tractionBias", 0.45)
		setVehicleHandling(vehicle, "numberOfGears", 5)
		setVehicleHandling(vehicle, "maxVelocity", 340)
		setVehicleHandling(vehicle, "engineAcceleration", 56)
		setVehicleHandling(vehicle, "engineInertia", 100)
		setVehicleHandling(vehicle, "driveType", "awd")
		setVehicleHandling(vehicle, "engineType", "diesel")
		setVehicleHandling(vehicle, "brakeDeceleration", 17)
		setVehicleHandling(vehicle, "brakeBias", 0.51)
	elseif vehID == 526 then
		setElementData(vehicle, "vehicleType", "PremiumCar")
		local handlingTable = getVehicleHandling ( vehicle )
		local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 40 ) )
		setVehicleHandling ( vehicle, "numberOfGears", 5 )
		setVehicleHandling ( vehicle, "driveType", 'awd' )
		setVehicleHandling ( vehicle, "maxVelocity", newVelocity )
		setVehicleHandling ( vehicle, "engineAcceleration", handlingTable["engineAcceleration"] +8 )
	end
end

-- interacting with client's gui

--- recover vehicles

local recoverPlaces = { -- vehicleType = {x,y,z,rotation} ( General for vehicles which are not listed )
	General = 
		{ 
			{ 1679.09, -1054.18, 23.89, 110 },
			{ -1987.51, 250.96, 35.17, 355 },
			{ 1952.97, 2167.12, 10.82, 133 },			
		},		
	Plane = {
			{ 2021.44, -2619.91, 14.54, 47 },
			{ -1687.54, -254.3, 15.14, 320},
			{1556.43, 1320.08, 11.87, 83},			
		},		
	Helicopter = {
			{2007.4, -2444.05, 14, 180 },
			{ -1186.83, 25.94, 15, 220},
			{ 1534.27, 1735.64, 11.5, 82 },
		},		
	Boat = {
			{ 2307.51, -2419.45, 0, 140 },
			{ 2268.76, 530.92, 0, 180 },
			{ -1636.08, 160.86, 0, 35 },
		},
}

addEvent("CSGplayerVehicles.recover",true)
addEventHandler("CSGplayerVehicles.recover",root,
	function (id,model)
		local px,py,_ = getElementPosition(source)
		local vehType = getVehicleType(model)
		if not recoverPlaces[vehType] then
			vehType = "General"
		end
		local vehicle = idToVehicle[id]	
	
		local x,y,z,rotation
		local dist
		for i=1,#recoverPlaces[vehType] do
			local rx,ry,rz,rRotation = unpack(recoverPlaces[vehType][i])
			local distance = getDistanceBetweenPoints2D(px,py,rx,ry)
			if not dist or distance < dist then
				dist = distance
				if isElement(vehicle) and not isElementFrozen(vehicle) then
					x,y,z,rotation = rx+math.random(-2,2),ry+math.random(-2,2),rz+math.random(0,4),rRotation -- +random for the ugly way of preventing vehicles getting stuck
				else
					x,y,z,rotation = rx+math.random(-2,2),ry+math.random(-2,2),rz,rRotation -- +random for the ugly way of preventing vehicles getting stuck
				end
			end
		end
		local name = getVehicleName(model)
		if isElement(vehicle) then
			local occupants = getVehicleOccupants(vehicle)
			for seat, occupant in pairs(occupants) do
				removePedFromVehicle(occupant) -- remove occupants
				if getElementType(occupant) == 'player' then
					exports.dendxmsg:createNewDxMessage(occupant,"You were removed from your vehicle because it was recovered.",255,200,0)
				end
			end
		
			setVehicleDamageProof(vehicle,true)
			setTimer(function (veh) if isElement(veh) and getElementHealth(veh) > 250 then setVehicleDamageProof(veh,false) end end, 5000, 1,vehicle)
			setElementPosition(vehicle,x,y,z)
			setElementRotation(vehicle,0,0,rotation)
			exports.dendxmsg:createNewDxMessage(source,"Your " .. name .. " has been recovered to "..getZoneName(x,y,z),0,255,0)
		else
			exports.denmysql:exec("UPDATE vehicles SET x=?,y=?,z=?,rotation=? WHERE uniqueid=?",x,y,z,rotation,id)
			exports.dendxmsg:createNewDxMessage(source,"Your " .. name .. " has been recovered to "..getZoneName(x,y,z).." but is not spawned yet.",255,255,0)
		end
	end
)

addEvent("CSGplayerVehicles.sellVeh", true)
addEventHandler("CSGplayerVehicles.sellVeh", root, 
	function(id,model,sellPrice)
		local name = getVehicleName(model)
		exports.DENdxmsg:createNewDxMessage(source, "You sold your " .. name .. " for $" .. sellPrice, 0, 255, 0)
		exports.CSGaccounts:addPlayerMoney(source, sellPrice)
		local veh = idToVehicle[id]
		if isElement(veh) then
			destroyElement(veh)
			for i=1,#allPlayerVehicles do
				if allPlayerVehicles[i] == veh then
					table.remove(allPlayerVehicles,i)
					break
				end
			end
			for i=1,#playerVehicles[source] do
				if playerVehicles[source][i] == veh then
					table.remove(playerVehicles[source],i)
					break
				end
			end
		end
		exports.DENmysql:exec("DELETE FROM vehicles WHERE uniqueid=?", id)
		updateClientInfo(source,id,false)
	end
)

addEvent("CSGplayerVehicles.spawnVeh",true)
addEventHandler("CSGplayerVehicles.spawnVeh",root,
	function(id)
		local info = exports.denmysql:querySingle("SELECT * FROM vehicles WHERE uniqueid=?",id)
		if info.ownerid == exports.server:getPlayerAccountID(source) then
			spawnPlayerVehicle(source,info,true)
		end
	end
)

addEvent("CSGplayerVehicles.despawnVeh",true)
addEventHandler("CSGplayerVehicles.despawnVeh",root,
	function(id)
		despawnPlayerVehicle(source,id,true)
	end
)

addEvent("CSGplayerVehicles.toggleLock",true)
addEventHandler("CSGplayerVehicles.toggleLock",root,
	function (id,vehicleModel, oldLockState, silent)
		local veh = idToVehicle[id]
		local newState = 1
		local name = getVehicleName(vehicleModel)
		if isElement(veh) then
			if isVehicleLocked(veh) then
				setVehicleLocked(veh,false)
				newState = 0 -- vehicle gets unlocked
			else
				setVehicleLocked(veh,true)
			end
		else
			if oldLockState == 1 then newState = 0 end
		end
		exports.denmysql:exec("UPDATE vehicles SET locked=? WHERE uniqueid=?",newState,id)
		if not silent then
			if newState == 1 then
				exports.dendxmsg:createNewDxMessage(source,"You have locked your "..name,0,255,0)
			else
				exports.dendxmsg:createNewDxMessage(source,"You have unlocked your "..name,0,255,0)
			end
		end
		updateClientInfo(source,id,{ locked = newState })
	end
)


-- system

function spawnPlayerVehicle(player, vehicleInfo, output)
	if not vehicleInfo then outputDebugString("spawnPlayerVehicle:1") return false end
	if isElement(idToVehicle[vehicleInfo.uniqueid]) then outputDebugString("spawnPlayerVehicle:2") return false end -- already spawned
	if not isElement(player) then outputDebugString("spawnPlayerVehicle:3") return false end -- no owner
	if not playerVehicles[player] then playerVehicles[player] = {} end
	
	if #playerVehicles[player] >= 2 then
		if output then
			exports.DENdxmsg:createNewDxMessage(player, "You can only spawn 2 vehicles at the same time!", 225, 0, 0)
		end
		return false;
	end
	
	local vehElement = createVehicle(vehicleInfo.vehicleid, vehicleInfo.x, vehicleInfo.y, vehicleInfo.z, 0, 0, vehicleInfo.rotation,vehicleInfo.licenseplate or "  CSG ")
	table.insert(playerVehicles[player],vehElement)
	table.insert(allPlayerVehicles,vehElement)
	vehicleToID[vehElement] = vehicleInfo.uniqueid
	idToVehicle[vehicleInfo.uniqueid] = vehElement
	setElementData(vehElement, "vehicleOwner", player)
	setElementData(vehElement, "vehicleType", "playerVehicle")
	setElementData(vehElement, "vehicleFuel", vehicleInfo.fuel)
	setElementData(vehElement, "vehicleID", vehicleInfo.uniqueid)
	
	applyVehicleSpecials(vehElement)
	local color1r,color1g,color1b = hexToRGB(vehicleInfo.color1)
	local color2r,color2g,color2b = hexToRGB(vehicleInfo.color2)
	setVehicleColor(vehElement,color1r,color1g,color1b,color2r,color2g,color2b)
	if vehicleInfo.wheelstates then
		local wheelStates = split(vehicleInfo.wheelstates, ",")
		setVehicleWheelStates(vehElement, unpack(wheelStates))
	end
	if vehicleInfo.vehiclemods then
		local upgrades = fromJSON(vehicleInfo.vehiclemods)
		if upgrades then
			for _,upgrade in pairs(upgrades) do
				addVehicleUpgrade(vehElement, upgrade)
			end
		end
	end
	if type( vehicleInfo.paintjob ) == 'number' and vehicleInfo.paintjob < 3 then
		setVehiclePaintjob(vehElement, vehicleInfo.paintjob)
	end
	if vehicleInfo.vehiclehealth and tonumber(vehicleInfo.vehiclehealth) <= 251 then
		setElementHealth(vehElement, 251)
		setVehicleEngineState(vehElement, false)
		setVehicleDamageProof(vehElement, true)
		setElementFrozen(vehElement,true)
		vehiclesBrokenDown[vehElement] = true
	else
		setElementHealth(vehElement, vehicleInfo.vehiclehealth)
	end
	if vehicleInfo.locked and vehicleInfo.locked == 1 then
		setVehicleLocked(vehElement,true)
	end
	
	exports.DENmysql:exec("UPDATE vehicles SET spawned=? WHERE uniqueid=?",1,vehicleInfo.uniqueid)
	if output then
		local name = getVehicleName(vehicleInfo.vehicleid)
		exports.dendxmsg:createNewDxMessage(player,"Your "..name.." has been spawned!",0,255,0)
	end
	updateClientInfo(player,vehicleInfo.uniqueid,{ element = vehElement })
	
	return vehElement
end

function getPlayerVehicleInfo(vehicleElement)

	local x,y,z = getElementPosition(vehicleElement)
	local _,_,rz = getElementRotation(vehicleElement)
	local health = math.max(251,getElementHealth(vehicleElement))
	local paintjob = getVehiclePaintjob(vehicleElement)
	local r1,g1,b1,r2,g2,b2 = getVehicleColor(vehicleElement, true)
	local color1 = exports.server:convertRGBToHEX(r1,g1,b1)
	local color2 = exports.server:convertRGBToHEX(r2,g2,b2)
	local ws1, ws2, ws3, ws4 = getVehicleWheelStates(vehicleElement)
	local wheelStates = table.concat({ws1,ws2,ws3,ws4},",")
	local fuel = math.floor(getElementData(vehicleElement, "vehicleFuel")) or 100
	local upgrades = toJSON(getVehicleUpgrades(vehicleElement))
	local locked = isVehicleLocked(vehicleElement)
	if ( locked ) then
		locked = 1
	else 
		locked = 0
	end
	
	return {x = x,y = y,z = z,rotation = rz,health = health,paintjob = paintjob,color1 = color1,color2 = color2,wheelstates = wheelStates,fuel = fuel, upgrades = upgrades,locked = locked}
end

function despawnPlayerVehicle(player,id, output)
	local vehicleElement = idToVehicle[id]
	if not isElement(vehicleElement) then return false end
	if isElement(player) then triggerEvent("CSGplayervehicles.despawned",player,vehicleElement) end
	-- get info to save into database
	local info = getPlayerVehicleInfo(vehicleElement)
	
	local update = exports.DENmysql:exec(
	"UPDATE vehicles SET x=?, y=?, z=?, rotation=?, vehiclehealth=?, paintjob=?, color1=?, color2=?, wheelstates=?, fuel=?,vehiclemods=?, locked=?, spawned=? WHERE uniqueid=?", 
	info.x, info.y, info.z, info.rotation, info.health, info.paintjob, info.color1, info.color2, info.wheelstates, info.fuel,info.upgrades,info.locked,0,id)
	idToVehicle[id] = nil
	for i=1,#allPlayerVehicles do
		if allPlayerVehicles[i] == vehicleElement then
			table.remove(allPlayerVehicles,i)
			break
		end
	end
	if isElement(player) and playerVehicles[player] then
		for i=1,#playerVehicles[player] do
			if playerVehicles[player][i] == vehicleElement then
				table.remove(playerVehicles[player],i)
				break
			end
		end
	else
		playerVehicles[player] = nil
	end
	vehicleToID[vehicleElement] = nil

	updateClientInfo(player,id,{ element = false })
	if output then
		local name = getVehicleName(getElementModel(vehicleElement))
		exports.dendxmsg:createNewDxMessage(player,"Your "..name.." has been despawned!",0,255,0)
	end
	
	
	destroyElement(vehicleElement)
end
hidePlayerVehicle = despawnPlayerVehicle -- exports

function createPlayerVehicle(player, vehicleModel, playerID, health, price, color1, color2, posX, posY, posZ, rotZ, licensePlate)

	-- add vehicle
	exports.CSGaccounts:removePlayerMoney(player,price)
	local insert = exports.DENmysql:exec(
	"INSERT INTO vehicles SET vehicleid=?, ownerid=?, vehiclehealth=?, boughtprice=?, color1=?, color2=?, x=?, y=?, z=?, rotation=?, licenseplate=?, spawned=?, locked=?", 
	vehicleModel, playerID, health, price, color1, color2, posX, posY, posZ, rotZ, licensePlate,0,0) 
	local insertInfo = exports.DENmysql:querySingle("SELECT MAX(uniqueid) AS id FROM vehicles") -- get inserted ID
	local vehicleID
	if insertInfo and insertInfo.id then
		vehicleID = insertInfo.id
	else
		exports.dendxmsg:createNewDxMessage(player,"Something went wrong with getting your vehicle id, please report this to admin.",255,0,0)
		exports.dendxmsg:createNewDxMessage(player,"To use your new vehicle please reconnect.",255,255,0)
		outputDebugString("CSGplayervehicles-purchase-wrong: "..tostring(insertInfo).." - "..tostring((insertInfo or {}).id))
		return false
	end
	-- initiate vehicle info, to spawn vehicle with.
	local sellPrice = getVehicleSellPrice(price,player)
	local info = {
		uniqueid = vehicleID,
		vehicleid = vehicleModel,
		x = posX,
		y = posY,
		z = posZ,
		sellPrice = sellPrice,
		rotation = rotZ,
		licenseplate = licensePlate,
		vehiclehealth = health,
		color1 = color1,
		color2 = color2,
		locked = 0,
	}
	local veh = spawnPlayerVehicle(player, info, false)
	outputDebugString("CSGplayervehicles:boughtElement:"..tostring(veh))
	local name = getVehicleName(vehicleModel)
	if isElement(veh) then
		exports.dendxmsg:createNewDxMessage(player,"Your newly bought "..name.." has been spawned!",0,255,0)
		warpPedIntoVehicle(player,veh)
		updateClientInfo(player,vehicleID,info)
	end

	return veh -- return vehicle to shop, so it can mess with it
end

-- manage events, save vehicles
function sendPlayerVehicleInfo(player)
	local accountID = exports.server:getPlayerAccountID(player)
	local vehicles = exports.denmysql:query("SELECT * FROM vehicles WHERE ownerid=?",accountID)
	if #vehicles > 0 then
		local elements = {}
		for i=1,#vehicles do
			if vehicles[i].spawned == 1 then
				elements[i] = spawnPlayerVehicle(player,vehicles[i],false)
			end
			vehicles[i].sellPrice = getVehicleSellPrice(vehicles[i].boughtprice,player)
			vehicles[i].boughtprice = false
		end
		triggerClientEvent(player,"CSGplayerVehicles:client.receiveVehicles",player,vehicles,elements)
	end
end

addEventHandler("onPlayerLogin",root,
	function () 
		if not playerVehicles[source] then
			playerVehicles[source] = {}
			sendPlayerVehicleInfo(source)
		end
	end
)
addEventHandler("onResourceStart",resourceRoot,
	function ()
		local players = getElementsByType("player")
		for i=1,#players do
			setTimer(sendPlayerVehicleInfo,i*1500,1,players[i])
		end
	end
)

addEventHandler("onResourceStop",resourceRoot,
	function ()
		for i=1,#allPlayerVehicles do
			local info = getPlayerVehicleInfo(allPlayerVehicles[i])
			local id = vehicleToID[allPlayerVehicles[i]]
			local update = exports.DENmysql:exec(
			"UPDATE vehicles SET x=?, y=?, z=?, rotation=?, vehiclehealth=?, paintjob=?, color1=?, color2=?, wheelstates=?, fuel=?,vehiclemods=?, locked=?, spawned=? WHERE uniqueid=?", 
			info.x, info.y, info.z, info.rotation, info.health, info.paintjob, info.color1, info.color2, info.wheelstates, info.fuel,info.upgrades,info.locked,1,id)
			destroyElement(allPlayerVehicles[i])
		end
	end
)

addEventHandler("onVehicleDamage",root,
	function(loss)
	if getElementData(source,"vehicleID") then
		if getElementHealth(source)-loss <= 251 and not isVehicleDamageProof(source) then
			local occupants = getVehicleOccupants(source)
			for i=0,#occupants do
				exports.dendxmsg:createNewDxMessage(occupants[i],"This vehicle is too damaged. Engine shutting down.",255,255,0)
			end
			setVehicleDamageProof(source,true)
			setElementFrozen(source,true)
			setElementHealth(source,251)
			setVehicleEngineState(source, false)
			cancelEvent()
			vehiclesBrokenDown[source] = true
		end
	end
end)

addEventHandler("onVehicleExplode",root,
	function()
		local veh = source
		local id = getElementData(source,"vehicleID")
		local owner = getElementData(source,"vehicleOwner")
		if (id) then
			local x,y,z = getElementPosition(source)
			local _,_,rz = getElementRotation(source)
			--exports.DENmysql:exec("UPDATE vehicles SET vehiclehealth=?, x=?,y=?,z=?,rotation=? WHERE uniqueid=?",0,x,y,z,rz,id)
			setElementHealth(veh,251)
			despawnPlayerVehicle(owner,id, false)
			local info = exports.denmysl:querySingle("SELECT * FROM vehicles WHERE uniqueid=?",id)
			setTimer(function(owner) if isElement(owner) then spawnPlayerVehicle(owner,info,false) end end,6000,1,owner)
		end
	end
)

addEventHandler("onVehicleEnter",root,
	function(player,seat)
	local id = getElementData(source,"vehicleID")
	if id then
		local pTeam = getPlayerTeam(player)
		local fuel = getElementData(source,"vehicleFuel") or 100
		if ( math.floor( getElementHealth(source) /10 ) <= 25 ) or ( fuel and fuel <= 0) then
			exports.dendxmsg:createNewDxMessage(player,"This vehicle is broken and/or out of fuel",255,255,0)
			setVehicleDamageProof(source,true)
			setElementFrozen(source,true)
			setElementHealth(source,251)
			setVehicleEngineState(source, false)
			vehiclesBrokenDown[source] = true
		elseif ( vehiclesBrokenDown[source] ) then
			setVehicleDamageProof(source,false)
			setElementFrozen(source,false)
			vehiclesBrokenDown[source] = false
		end
	end
end)

addEventHandler("onPlayerQuit",root,
	function ()
		local vehs = playerVehicles[source]
		if vehs then
			for i=1,#vehs do
				local occupants = getVehicleOccupants(vehs[i])
				for seat=0, #occupants do
					exports.dendxmsg:createNewDxMessage(occupants[seat],"The owner of this vehicle has logged off. The vehicle will be despawned in 10 seconds.",255,255,0)
				end
				setTimer(despawnPlayerVehicle, 10000, 1, false,vehicleToID[vehs[i]]) -- despawn vehicle in 10 seconds, supply no player and give the vehicle id.
			end
		end
	end
)

-- law cars

local givenstars = {}
local copCarIDs = {
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

local lawTeams = {
	"Military Forces",
	"SWAT",
	"Police",
	"Government Agency"
}

function isLaw(player)
	if getPlayerTeam( player ) then
		local team = getTeamName(getPlayerTeam(player))
		for _,tName in ipairs(lawTeams) do 
			if team == tName then 
				return true 
			end 
		end
	end
	return false
end

addEventHandler("onVehicleEnter",root,
	function(player,seat)
	local vehOccupation = getElementData(source,"vehicleOccupation")
	if seat == 0 and vehOccupation and (vehOccupation == "Military Forces" or vehOccupation == "SWAT Team" or vehOccupation == "Federal Agent" or vehOccupation == "Police Officer") then
		if isLaw(player) then
			if getElementData(player,"skill") == "High Speed Unit" then
				if getVehicleType(source) == "Automobile" then
					setVehicleHandling(source,"maxVelocity",200)
					setVehicleHandling(source,"engineAcceleration",15)
				end
			end
		elseif getElementData(source,"vehicleOccupation") ~= "Criminal" and ( not givenstars[source] or getTickCount()-givenstars[source] > 30000 ) then
			givenstars[source] = getTickCount()
			exports.CSGwanted:addWanted(player,38,getRandomPlayer())
		end
	end
end
)

addEventHandler("onVehicleExit",root,
	function(player)
		local model = getElementModel(source)
		if (copCarIDs[model]) then
			local unit = false
			for _,occupant in ipairs(getVehicleOccupants(source)) do
				if getElementData(occupant,"skill") == "High Speed Unit" then
					unit = true
					break
				end
			end
			if not unit then
				setVehicleHandling(source,"maxVelocity",200)
				setVehicleHandling(source,"engineAcceleration",10)
			end
		end
	end
)

-- more useless exports

getVehicleUpgradesJSON = function(veh)
local upgrades = {}
local anyUpgrade = false
	for slot = 0, 16 do
		local upgrade = getVehicleUpgradeOnSlot(veh, slot)
		if upgrade then
			upgrades[slot] = upgrade
			anyUpgrade = true
		end
	end
	if anyUpgrade then
		return toJSON(upgrades)
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