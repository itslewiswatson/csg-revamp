addEvent ( "vehShop_spawnBuyedVehicle", true ) -- rip english

local positions = {
{"COUNTRYBIKE",698.9921875, -527.6708984375, 16.1875, 271.32525634766},
{"LVBIKE",1940.55, 2067.77, 11, 0.},
{"SFBIKE",-2064.37, -82.31, 35.16, 181	},
{"LSBOAT",-27.7, -1646.37, 0.5, 185},
{"LVBOAT",2361.27, 511.45, 1, 269.66375732422},
{"SFBOAT",-2220.82, 2409.88, 1, 52.54611206055},
{"SFAIR",-1492.5205078125, -606.2412109375, 15.5, 285},
{"LVAIR",1340.93, 1601.03, 10.82, 272},
{"LSAIR",2111.74, -2426.32, 14.46, 180},
{"LSFAST",535.43, -1284.91, 17.24, 296},
{"LSLVFAST",1403.92, 402.17, 19.75, 338},
{"LVFAST",2186.66, 1391.9, 10.82, 91},
{"SFFAST",-1634.0780029297, 1211.2263183594, 7.0390625, 223.66842651367},
{"LVSLOW",1662.65, 1797.82, 11, 91.306419372559},
{"LSSLOW",2125.84, -1128.14, 25.51, 348},
{"SFSLOW",-1974.86, 302.4, 34.9, 181},
{"LVIND",595.02, 1659.72, 8, 64},
{"LSIND",2283.18, -2330.75, 13.54, 315},
{"SFIND",-1967.8, -2478.75, 30.62, 103},
{"copShop", 2228.82, 2457.29, -5.46,279},
{"copShop",1568.07, -1702.13, 7.89 ,269},
}
setGarageOpen ( 40, true )
setGarageOpen ( 30, true )

function getBuyVehiclePosition (player, ID)
	local data = getElementData ( player, "vehShop_location" )
	for i=1,#positions do
		if positions[i][1] == data then
			return positions[i][2],  positions[i][3],  positions[i][4],  positions[i][5]
		end
	end
end

function spawnTheVehicle ( ID, r1, g1, b1, r2, g2, b2, price, licensePlate )
local maxSlots = exports.CSGplayervehicles:getPlayerVehicleSlots( source )
	if getPlayerMoney ( source ) >= price and ID then
		if ( not exports.server:getPlayerVehicles ( source ) or #exports.server:getPlayerVehicles ( source ) < maxSlots ) then
			local posX, posY, posZ, rotZ = getBuyVehiclePosition ( source,ID )
			local playerX, playerY, playerZ = getElementPosition(source)
			local color1 = exports.server:convertRGBToHEX( r1, g1, b1 )
			local color2 = exports.server:convertRGBToHEX( r2, g2, b2 )
			local ownerID = exports.server:getPlayerAccountID(source)
			removePedJetPack ( source )
			local licenseLength = #licensePlate
			if #string.gsub(licensePlate," ","") >= 1 then
				local withoutNumbers,_ = string.gsub(licensePlate,"%d","")
				if #withoutNumbers < 1 then
					if licenseLength < 7 then
						licensePlate = "A"..licensePlate
					else
						licensePlate = string.sub(licensePlate,0,6).."A"
					end
				end
			else
				licensePlate = "  CSG "
			end

			local playerVeh = exports.CSGplayervehicles:createPlayerVehicle ( source, ID, ownerID, 1000, price, color1, color2, posX, posY, posZ, rotZ, licensePlate )
			if isElement(playerVeh) then
				setVehicleDamageProof( playerVeh, true )
				setElementFrozen(playerVeh,true)
				setTimer ( function(vehicle)if isElement(vehicle) then setVehicleDamageProof( vehicle, false ) end end, 5000, 1, playerVeh )
				setTimer ( function(vehicle)if isElement(vehicle) then setElementFrozen( vehicle, false ) end end, 5000, 1, playerVeh )
				exports.DENdxmsg:createNewDxMessage(source, "Your vehicle is being prepared.", 0, 255, 0 )
				warpPedIntoVehicle(source,playerVeh)
			end
			triggerClientEvent ( source, "closeGUIS", source )
		else
			exports.DENdxmsg:createNewDxMessage(source, "You can only have "..tostring(maxSlots).." vehicles!", 255, 0, 0)
			exports.DENdxmsg:createNewDxMessage(source, "Sell one or upgrade your amount of max slots.", 255, 0, 0)
		end
	else
		exports.DENdxmsg:createNewDxMessage(source, "You need at least $" .. tostring(price) .. " to buy this vehicle.", 255, 0, 0)
	end
end

addEventHandler ( "vehShop_spawnBuyedVehicle", root, spawnTheVehicle )

addEvent("vehicleShop_startTestDrive", true)

local testDriveVehicles = {}

function startTestDrive(ID)
	if not isElement(testDriveVehicles[source]) then
		local vehicleType = getVehicleType(ID)
		local interior = 14
		local x,y,z,rz = -1370.09, 1581.59, 1052.53, 96
		local px,py,pz,prz = -1368.99, 1575, 1052.53, 10
		if vehicleType == "Plane" or vehicleType == "Helicopter" then
			interior = 0
			x,y,z, rz = -1647.65, -155.21, 14.14, 315
			px,py,pz, prz = -1623.93, -155.7, 14.14, 47
		elseif vehicleType == "Boat" then
			interior = 0
			x,y,z, rz = -1449.07, 98.3, -0.56, 315
			px,py,pz, prz = -1442.59, 94.95, 1.96, 53
		end
		testDriveVehicles[source] = createVehicle(ID, x,y,z,0,0,rz )
		setElementData(testDriveVehicles[source], "vehicleFuel", 100)
		setElementInterior(testDriveVehicles[source], interior)
		local dimension = #testDriveVehicles + 1
		setElementDimension(testDriveVehicles[source],dimension)
		setVehicleDamageProof(testDriveVehicles[source],true)
		triggerClientEvent(source,"onVehicleSpawnedForTestDrive",testDriveVehicles[source], { dimension, interior, px,py,pz,prz } )
	end
end

addEventHandler ( "vehicleShop_startTestDrive", root, startTestDrive )

addEvent("vehicleShop_getServerTime", true)
function getServerTime()
	local timeH, timeM = getTime()
	triggerClientEvent(source,"vehicleShop_onReceiveServerTime", source,timeH,timeM)
end
addEventHandler("vehicleShop_getServerTime",root,getServerTime)

addEvent("vehicleShop_destroyPlayerTestVehicle", true)
function destroyPlayerTestVehicle()
	if isElement(testDriveVehicles[source]) then
		destroyElement(testDriveVehicles[source])
		testDriveVehicles[source] = nil
	end
end

addEventHandler("vehicleShop_destroyPlayerTestVehicle", root, destroyPlayerTestVehicle)
addEventHandler("onPlayerQuit", root, destroyPlayerTestVehicle)
