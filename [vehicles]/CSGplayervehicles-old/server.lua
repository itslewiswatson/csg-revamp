-- Tables
local playerVehicle = {}
local activeVehicleID = {}
local attachedblip = {}

local spawnTimer = {}
local hideTimer = {}
local freezeTimer = {}
local healthTimer = {}


local vehicleRecoverPoints = { 
["LV"]={-1501.27, 742.38, 7.18},
["SF"]={1890.61, 2135.61, 10.82},
["LS"]={1702.1, -1510.71, 13.38}
} 

local boatRecoverPoints = { 
["LV"]={-2960.75, 501.55, -0.56},
["SF"]={2294.92, 510.33, -0.56},
["LS"]={722.46, -1700.26, -0.56}
} 

local planeRecoverPoints = { 
["LV"]={1335.9,1324.43,10.5},
["SF"]={-1667.83,-251.19,13.82},
["LS"]={1864.26,-2447.5,13.82}
}

-- Get a JSON string from the upgrades
local function getVehicleUpgradesJSON( theVehicle )
	local upgrades = { }
	local hasCarUpgrades = false
	for i = 0, 16 do
		local upgrade = getVehicleUpgradeOnSlot ( theVehicle, i )
		if ( upgrade ) then
			upgrades[i] = upgrade
			hasCarUpgrades = true
		end
	end
	if ( hasCarUpgrades ) then
		return toJSON( upgrades )
	else
		return "NULL"
	end
end

-- Save vehicle upgrades
function onVehicleSaveUpgrades ( theVehicle, vehicleID )
    local updateUpgrades = exports.DENmysql:exec( "UPDATE vehicles SET vehiclemods = ? WHERE uniqueid = ?", getVehicleUpgradesJSON ( theVehicle ), vehicleID)
	if ( updateUpgrades ) then
		return true
	else
		return false
	end
end

-- Hex to RGB
function hex2rgb(hex)
  hex = hex:gsub("#","")
  return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

-- When player buys a vehicle, hide the one thats already spawned
function onPlayerBoughtVehicle ( thePlayer, vehicleID, x, y, z, rotation, uniqueID, color1, color2 )
	if isElement(playerVehicle[thePlayer]) and activeVehicleID[thePlayer] then
		if (getElementData(thePlayer, "isPlayerJailed") or getElementData(thePlayer, "isPlayerArrested")) then
			return false
		end
		hideTheVehicle (activeVehicleID[thePlayer], thePlayer)
		playerVehicle[thePlayer] = createVehicle ( vehicleID, x, y, z, 0, 0, rotation )
		setPremiumVehicleFaster ( thePlayer, playerVehicle[thePlayer] )
		activeVehicleID[thePlayer] = uniqueID
		setElementData(playerVehicle[thePlayer], "vehicleOwner", thePlayer)
		setElementData(playerVehicle[thePlayer], "vehicleType", "playerVehicle")
		warpPedIntoVehicle(thePlayer, playerVehicle[thePlayer])
		local R1, G1, B1 = hex2rgb(color1)
		local R2, G2, B2 = hex2rgb(color2)
		setVehicleColor ( playerVehicle[thePlayer], R1, G1, B1, R2, G2, B2 )
		exports.DENhelp:createNewHelpMessageForPlayer(thePlayer, "You bought a ".. getVehicleName(playerVehicle[thePlayer]) .."!", 0, 255, 0)
		updateVehicleTable ( thePlayer )
	else
		playerVehicle[thePlayer] = createVehicle ( vehicleID, x, y, z, 0, 0, rotation )
		setPremiumVehicleFaster ( thePlayer, playerVehicle[thePlayer] )
		activeVehicleID[thePlayer] = uniqueID
		setElementData(playerVehicle[thePlayer], "vehicleOwner", thePlayer)
		setElementData(playerVehicle[thePlayer], "vehicleType", "playerVehicle")
		warpPedIntoVehicle(thePlayer, playerVehicle[thePlayer])
		local R1, G1, B1 = hex2rgb(color1)
		local R2, G2, B2 = hex2rgb(color2)
		setVehicleColor ( playerVehicle[thePlayer], R1, G1, B1, R2, G2, B2 )
		exports.DENhelp:createNewHelpMessageForPlayer(thePlayer, "You bought a ".. getVehicleName(playerVehicle[thePlayer]) .."!", 0, 255, 0)
		updateVehicleTable ( thePlayer )
	end
end

-- When player disconnect then remove the vehicle
addEventHandler("onPlayerQuit",root,
function()
	if isElement(playerVehicle[source]) then 
		if activeVehicleID[source] then
			local vehicleID = activeVehicleID[source]	
			local x,y,z = getElementPosition(playerVehicle[source])
			local rotationX,rotationY,rotationZ = getElementRotation(playerVehicle[source])
			local vehicleHealth = getElementHealth( playerVehicle[source] )
			local vehiclePaintjob = getVehiclePaintjob ( playerVehicle[source] )
			local r1, g1, b1, r2, g2, b2 = getVehicleColor ( playerVehicle[source], true )
			local color1 = exports.server:convertRGBToHEX(r1, g1, b1)
			local color2 = exports.server:convertRGBToHEX(r2, g2, b2)
			local w1, w2, w3, w4 = getVehicleWheelStates ( playerVehicle[source] )
			local wheelStates = w1..","..w2..","..w3..","..w4
			local theFuel = math.floor ( getElementData( playerVehicle[source], "vehicleFuel" ) ) or 100
			local updateVehicle = exports.DENmysql:exec( "UPDATE vehicles SET x=?, y=?, z=?, rotation=?, vehiclehealth=?, paintjob=?, color1=?, color2=?, wheelstates=?, fuel=? WHERE uniqueid = '" .. tonumber(vehicleID) .. "'"
				,x
				,y
				,z
				,rotationZ
				,vehicleHealth
				,vehiclePaintjob
				,color1
				,color2
				,wheelStates
				,theFuel
			)
					
			if ( updateVehicle ) then
				updateVehicleTable ( source )
				onVehicleSaveUpgrades(playerVehicle[source], activeVehicleID[source])
				destroyElement(playerVehicle[source])
				playerVehicle[source] = nil
				activeVehicleID[source] = nil
				triggerClientEvent ( source, "setRowColor", source, false )
			end
			
			if isElement(attachedblip[source]) then 
				destroyElement(attachedblip[source])
				attachedblip[source] = nil
			end
		end
	end
end)

-- Load all vehicles of the player when he request the gui
addEvent("updateVehicleTable", true)
function updateVehicleTable ( thePlayer )
	local source = source or thePlayer
	local playerID = exports.server:playerID( source )
	local getAllVehicles = exports.DENmysql:query( "SELECT * FROM vehicles WHERE ownerid = '" .. playerID .. "'" )
	
	-- Update the vehicle table
	triggerClientEvent(source, "updateVehicleTable", source, getAllVehicles )	
end
addEventHandler("updateVehicleTable", root, updateVehicleTable )

-- Check for active vehicle
addEvent("loadActiveVehicle", true)
function loadActiveVehicle ()
	if activeVehicleID[source] then activeVehicleNumber = activeVehicleID[source] activeVehicle = playerVehicle[source] else activeVehicleNumber = nil activeVehicle = nil end
	triggerClientEvent(source, "insertVehicles", source, activeVehicleNumber, activeVehicle)	
end
addEventHandler("loadActiveVehicle", root, loadActiveVehicle )

-- Function triggerd when player spawn his vehicle
function spawnTheVehicle (vehicleID, thePlayer)
local source = source or thePlayer
local getVehicle = exports.DENmysql:querySingle( "SELECT * FROM vehicles WHERE uniqueid = '" .. tonumber(vehicleID) .. "'" )
	if getVehicle then
		if isElement(playerVehicle[source]) then 
			outputChatBox("You can have only one vehicle active at one time, hide your other vehicle first!", source, 225, 0, 0)
		else
			playerVehicle[source] = createVehicle ( getVehicle.vehicleid, getVehicle.x, getVehicle.y, getVehicle.z, 0, 0, getVehicle.rotation )
			setPremiumVehicleFaster ( source, playerVehicle[source] )
			activeVehicleID[source] = getVehicle.uniqueid
			setElementData(playerVehicle[source], "vehicleOwner", source)
			setElementData(playerVehicle[source], "vehicleType", "playerVehicle")
			setElementData(playerVehicle[source], "vehicleFuel", getVehicle.fuel)
			
			local wheels = exports.server:stringExplode(getVehicle.wheelstates, ",")
			setVehicleWheelStates( playerVehicle[source], wheels[1], wheels[2], wheels[3], wheels[4] )
			
			-- Get the upgrades of the vehicle
			local upgrades = fromJSON( getVehicle.vehiclemods )
			if ( upgrades ) then
				for upgrdint, upgrd in pairs( upgrades ) do
					addVehicleUpgrade ( playerVehicle[source], upgrd )
				end
			end
			
			-- If the vehicle does have a paint job set that
			if ( getVehicle.paintjob < 3 ) then
				setVehiclePaintjob ( playerVehicle[source], getVehicle.paintjob )
			end
			
			-- If the vehicle is damaged too much make him broken
			if ( tonumber(getVehicle.vehiclehealth) < 250 ) then
				setElementHealth(playerVehicle[source], 250)
				setVehicleEngineState ( playerVehicle[source], false )
				setVehicleDamageProof ( playerVehicle[source], true )
			else
				setElementHealth(playerVehicle[source], getVehicle.vehiclehealth)
			end
			
			local R1, G1, B1 = hex2rgb(getVehicle.color1)
			local R2, G2, B2 = hex2rgb(getVehicle.color2)
			setVehicleColor ( playerVehicle[source], R1, G1, B1, R2, G2, B2 )
			triggerClientEvent ( source, "setRowColor", source, true )
		end
	end
end
addEvent("spawnTheVehicle", true)
addEventHandler("spawnTheVehicle", root, spawnTheVehicle )

-- Function triggerd when the player hide his vehicle
function hideTheVehicle (vehicleID, thePlayer)
	local source = source or thePlayer
	if activeVehicleID[source] == vehicleID then
		if isElement(playerVehicle[source]) then 
			local x,y,z = getElementPosition(playerVehicle[source])
			local rotationX,rotationY,rotationZ = getElementRotation(playerVehicle[source])
			local vehicleHealth = getElementHealth( playerVehicle[source] )
			local vehiclePaintjob = getVehiclePaintjob ( playerVehicle[source] )
			local r1, g1, b1, r2, g2, b2 = getVehicleColor ( playerVehicle[source], true )
			local color1 = exports.server:convertRGBToHEX(r1, g1, b1)
			local color2 = exports.server:convertRGBToHEX(r2, g2, b2)
			local w1, w2, w3, w4 = getVehicleWheelStates ( playerVehicle[source] )
			local wheelStates = w1..","..w2..","..w3..","..w4
			local theFuel = math.floor ( getElementData( playerVehicle[source], "vehicleFuel" ) ) or 100
			local updateVehicle = exports.DENmysql:exec( "UPDATE vehicles SET x=?, y=?, z=?, rotation=?, vehiclehealth=?, paintjob=?, color1=?, color2=?, wheelstates=?, fuel=? WHERE uniqueid = '" .. tonumber(vehicleID) .. "'"
				,x
				,y
				,z
				,rotationZ
				,vehicleHealth
				,vehiclePaintjob
				,color1
				,color2
				,wheelStates
				,theFuel
			)
					
			if ( updateVehicle ) then
				updateVehicleTable ( source )
				onVehicleSaveUpgrades(playerVehicle[source], activeVehicleID[source])
				destroyElement(playerVehicle[source])
				playerVehicle[source] = nil
				activeVehicleID[source] = nil
				triggerClientEvent ( source, "setRowColor", source, false )
			end
			
			if isElement(attachedblip[source]) then 
				destroyElement(attachedblip[source])
				attachedblip[source] = nil
			end
		end
	end
end
addEvent("hideTheVehicle", true)
addEventHandler("hideTheVehicle", root, hideTheVehicle )

-- Function that place a blip on the vehicle for the player
function markTheVehicles (vehicleID)
	if activeVehicleID[source] == vehicleID then
		if isElement(playerVehicle[source]) then 
			if isElement(attachedblip[source]) then 
				destroyElement(attachedblip[source])
				attachedblip[source] = nil
			else
				attachedblip[source] = createBlipAttachedTo ( playerVehicle[source], 41, 0, 0, 0, 0, 0, 0, 10000000, source )
			end
		end
	end
end
addEvent("markTheVehicles", true)
addEventHandler("markTheVehicles", root, markTheVehicles )

-- Function that sells the vehicle
function sellTheVehicle (vehicleID, selectedRow)
local playerID = exports.server:playerID( source )
	if activeVehicleID[source] == vehicleID then
		if isElement(playerVehicle[source]) then 
			local vehicleInfo = exports.DENmysql:querySingle( "SELECT * FROM vehicles WHERE uniqueid = '" .. tonumber(vehicleID) .. "'" )
			if vehicleInfo then
				local deleteVehicle = exports.DENmysql:exec("DELETE FROM vehicles WHERE uniqueid = '" .. vehicleID .. "' and ownerid = '" .. playerID .. "'")
				if deleteVehicle then
					local sellPrice = getVehicleSellPrice ( source, vehicleInfo.boughtprice )
					givePlayerMoney(source, tonumber(sellPrice))
					exports.DENhelp:createNewHelpMessageForPlayer(source, "You sold your ".. getVehicleName(playerVehicle[source]) .." for $".. sellPrice .."", 0, 255, 0)
					destroyElement(playerVehicle[source])
					playerVehicle[source] = nil
					activeVehicleID[source] = nil
					triggerClientEvent(source, "deleteRow", source, selectedRow)
					updateVehicleTable ( source )
					if isElement(attachedblip[source]) then 
						destroyElement(attachedblip[source])
						attachedblip[source] = nil
					end
				end
			end
		end
	end
end
addEvent("sellTheVehicle", true)
addEventHandler("sellTheVehicle", root, sellTheVehicle )

function getVehicleSellPrice ( thePlayer, boughtPrice )
	if ( getElementData(thePlayer, "isPlayerPremium") ) then
		return boughtPrice
	else
		local thePrice = ( tonumber(boughtPrice) / 100 * 95 )
		return thePrice
	end
end

function recoverTheVehicle (vehicleID)
local playerID = exports.server:playerID( source )
	if activeVehicleID[source] == vehicleID then
		if isElement(playerVehicle[source]) then 
			local vehicleType = getVehicleType ( playerVehicle[source] )
			local x, y, z = getElementPosition( playerVehicle[source] )
			if vehicleType == "Plane" or vehicleType == "Helicopter" then
			
			for ID in pairs(planeRecoverPoints) do
				if ID == currentZone(source) then
					local x,y,z = unpack( planeRecoverPoints[currentZone(source)] )
					setElementPosition(playerVehicle[source], x, y, z +1)
					if isPedInVehicle ( source ) then
					removePedFromVehicle ( source ) 
					end 
					exports.DENhelp:createNewHelpMessageForPlayer(source, "Your plane is recoverd at " .. currentZone(source) .." airport.", 0, 200, 0)
				end
			end
			
			elseif vehicleType == "Boat" then
			
			for ID in pairs(boatRecoverPoints) do
				if ID == currentZone(source) then
					local x,y,z = unpack( boatRecoverPoints[currentZone(source)] )
					setElementPosition(playerVehicle[source], x, y, z +1)
					if isPedInVehicle ( source ) then
						removePedFromVehicle ( source ) 
					end
					exports.DENhelp:createNewHelpMessageForPlayer(source, "Your boat is recoverd, mark the boat to see the location.", 0, 200, 0)
				end
			end
			
			else
			
			for ID in pairs(vehicleRecoverPoints) do
				if ID == currentZone(source) then
					local x,y,z = unpack( vehicleRecoverPoints[currentZone(source)] )
					setElementPosition(playerVehicle[source], x, y, z +1)
					if isPedInVehicle ( source ) then
						removePedFromVehicle ( source ) 
					end
					exports.DENhelp:createNewHelpMessageForPlayer(source, "Your vehicle is recoverd, mark the vehicle to see the location.", 0, 200, 0)
				end
			end
			
			end
		end
	end
end
addEvent("recoverTheVehicle", true)
addEventHandler("recoverTheVehicle", root, recoverTheVehicle )

function currentZone(player)
	local x, y, z = getElementPosition(player)
	if x < -920 then
		return "SF"
	elseif y < 420 then
		return "LS"
	else
		return "LV"
	end
end

-- Vehicle lock function
function isPlayerInRangeOfPoint(vehicleX, vehicleY, playerX, playerY)
	return getDistanceBetweenPoints2D ( vehicleX, vehicleY, playerX, playerY )
end

-- Lock it
addCommandHandler ( "lock",
	function (thePlayer)
		if thePlayer and isElement(playerVehicle[thePlayer]) then
			local vehicleX, vehicleY, vehicleZ = getElementPosition ( playerVehicle[thePlayer] )
			local playerX, playerY, playerZ = getElementPosition ( thePlayer )
			-- check the range distance
			if getElementData(playerVehicle[thePlayer], "vehicleOwner") == thePlayer and isPlayerInRangeOfPoint(vehicleX, vehicleY, playerX, playerY) < 30 then
				if isVehicleLocked ( playerVehicle[thePlayer] ) then
					setVehicleLocked ( playerVehicle[thePlayer], false )
					exports.DENhelp:createNewHelpMessageForPlayer(thePlayer, "You unlocked your vehicle!", 0, 200, 0)
					setElementData(playerVehicle[thePlayer], "vehicleLocked", false)
				else
					setVehicleLocked ( playerVehicle[thePlayer], true )
					exports.DENhelp:createNewHelpMessageForPlayer(thePlayer, "You locked your vehicle!", 0, 200, 0)
					setElementData(playerVehicle[thePlayer], "vehicleLocked", true)
				end
			end
		end
	end
)

-- Action when user locks it with the button
addEvent( "lockVehicleButton", true )
addEventHandler( "lockVehicleButton", root,
	function ()
		executeCommandHandler ( "lock", source )
	end
)

function getPlayerVehicleSlots ( thePlayer )
	if ( getElementData(thePlayer, "isPlayerPremium") ) then
		return 20
	else
		return 10
	end
end

-- Make premium cars faster
function setPremiumVehicleFaster ( thePlayer, theVehicle )
	if not ( isGuestAccount ( getPlayerAccount ( thePlayer ) ) ) then
		if ( getElementData(thePlayer, "isPlayerPremium") ) then
			if ( isElement ( thePlayer) ) and ( isElement ( theVehicle) ) then
				if ( getVehicleType ( theVehicle ) == "Automobile" ) or ( getVehicleType ( theVehicle ) == "Bike" ) or ( getVehicleType ( theVehicle ) == "Monster Truck" ) then
					local handlingTable = getVehicleHandling ( theVehicle )
					local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 15 ) )
					setVehicleHandling ( theVehicle, "maxVelocity", newVelocity )
					setVehicleHandling ( theVehicle, "engineAcceleration", handlingTable["engineAcceleration"] +5 )
				end
			end
		end
	end
end