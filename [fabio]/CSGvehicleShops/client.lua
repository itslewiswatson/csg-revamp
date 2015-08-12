local markers =
{
{1947.56, 2068.66, 9.82 , "LVBIKE"},
{701.72, -519.34, 15.33 ,"COUNTRYBIKE"},
{-2071.6599121094, -92.908683776855, 34.2,"SFBIKE"},
{-20.02, -1653.76, 1.2,"LSBOAT"},
{2359.3896484375, 525.70703125, 0.7,"LVBOAT"},
{-2188.49, 2413.02, 4.15,"SFBOAT"},
{-1479.18, -632.18, 13.14,"SFAIR"},
{1305.26, 1623.03, 9.82,"LVAIR"},
{2091.9, -2413.37, 12.54,"LSAIR"},
{566.71, -1289.59, 16.24,"LSFAST"},
{1393.92, 401.13, 18.82,"LSLVFAST"},
{2200.72, 1393.8, 9.82,"LVFAST"},
{-1656.6567382813, 1210.9990234375, 6.3,"SFFAST"},
{1671.13, 1814.56, 9.82,"LVSLOW"},
{2131.75, -1149.34, 23,"LSSLOW"},
{-1967.91, 300.25, 34.2,"SFSLOW"},
{591.77, 1638.58, 6,"LVIND"},
{2282.3, -2363.94, 12.7,"LSIND"},
{-1959.3, -2480.63, 29.62,"SFIND"},
{ 2219.94, 2455.75, -8.46,"copShop"},
{1559.54, -1693.53, 4.89,"copShop"},
}

local blips =
{
{true,1947.56, 2068.66, 50, 50, "bike.png", 300},
{true,701.73, -520.89, 50, 50, "bike.png", 300},
{true,-2083.79, -91.17, 50, 50, "bike.png", 300},
{nil,-20.02, -1653.76, 2.2, 9 },
{nil,2359.3896484375, 525.70703125, 1.7, 9 },
{nil,-2188.49, 2413.02, 5.15, 9 },
{nil,2091.9, -2413.37, 13.54, 5},
{nil,1305.26, 1623.03, 10.82, 5},
{nil,-1479.18, -632.18, 13.14, 5},
{nil,566.71, -1289.59, 17.24, 55},
{nil,1393.92, 401.13, 19.82, 55},
{nil,2200.72, 1393.8, 10.82, 55},
{nil,-1656.6567382813, 1210.9990234375, 6.3, 55},
{nil,1671.13, 1814.56, 10.82, 55},
{nil,2131.75, -1149.34, 23, 55},
{nil,-1967.91, 300.25, 34.2, 55},
{nil,591.77, 1638.58, 6.99, 11},
{nil,2282.3, -2363.94, 13.54, 11},
{nil,-1959.3, -2480.63, 30.62, 11},
{nil, 2219.94, 2455.75, -8.46,55},
{nil,1568.07, -1702.13, 5.89,55},

}

addEventHandler('onClientResourceStart', resourceRoot,
function ()

	for i=1, #markers do

		local marker = createMarker( markers[i][1], markers[i][2], markers[i][3], 'cylinder', 1.5, 247, 176, 10, 200 )
		setElementData(marker, 'vehicleShopCity', markers[i][4] )
		addEventHandler ( "onClientMarkerHit", marker, showRoomMarkerHit )
		markers[i] = marker

	end

	for i=1, #blips do

		if blips[i][1] then

			local _,x,y,_,_,img,_ = unpack(blips[i])
			exports.customblips:createCustomBlip( x,y,10,10,img,300 )

		else

			local blipInfo = blips[i]
			local x,y,z,ID = blipInfo[2],blipInfo[3],blipInfo[4],blipInfo[5]
			createBlip( x,y,z,ID, 0, 0, 0, 0, 255, 0, 300 )

		end

	end

end )

-- price table
local vehiclePriceTable = {
["copShop"] = {
	[596] = 250000,
	[597] = 250000,
	[599] = 250000,
	[598] = 250000,
	[523] = 250000,
	[426] = 250000,
},
["FAST"]={
[429] = 100000, -- Banshee
[541] = 120000, -- Bullet
[559] = 130000, -- Jester
[415] = 150000, -- cheetah
[561] = 80000, -- Stratum
[480] = 120000, -- Comet
[562] = 90000, -- Elegy
[506] = 180000, -- Super GT
[565] = 80000, -- Flash
[411] = 260000, -- Infernus
[451] = 250000, -- Turismo
[434] = 100000, -- Hotknife
[558] = 76000, -- Uranus
[494] = 130000, -- Hotring Racer
[555] = 60000, -- Windsor
[502] = 130000, -- Hotring Racer 2
[477] = 160000, -- ZR-350
[503] = 130000, -- Hotring Racer 3
[424] = 70000, -- BF Injection
[504] = 90000, -- Bloodring Banger
[579] = 60000, -- Huntley
[402] = 95000, -- Buffalo
[542] = 60000, -- Clover
[603] = 120000, -- Phoenix
[475] = 90000, -- Sabre
[560] = 55000, -- Sultan
[401] = 45000, -- Bravura
},
["AIR"]={
[553] = 300000, -- Nevada
[488] = 100000, -- News Chopper
[511] = 60000, -- Beagle
[548] = 160000, -- Cargobob
[563] = 140000, -- Raindance
[512] = 90000, -- Cropduster
[476] = 2000000, -- Rustler
--[447] = 2000000, -- Seasparrow
[593] = 40000, -- Dodo
[519] = 150000, -- Shamal
[417] = 140000, -- Leviathan
[469] = 75000, -- Sparrow
[487] = 100000, -- Maverick
[513] = 85000 -- Stuntplane
},
["BIKE"]={
[581] = 14000, --BF-400
[510] = 1000, -- Mountain Bike
[509] = 800, -- Bike
[522] = 99000, -- NRG-500
[481] = 1000, -- BMX
[461] = 18000, -- PCJ-600
[462] = 5000, -- Faggio
[448] = 5000, -- Pizza Boy
[521] = 22000, -- FCR-900
[468] = 11000, -- Sanchez
[463] = 12000, -- Freeway
[586] = 9499, -- Wayfarer
[471] = 6800, -- Quadbike
[571] = 5499 -- Kart
},
["BOAT"]={
[472] = 80000, -- Coastguard
[473] = 40000, -- Dinghy
[493] = 120000, -- Jetmax
[595] = 300000, -- Launch
[484] = 100000, -- Marquis
[453] = 70000, -- Reefer
[460] = 200000, -- Skimmer
[452] = 110000, -- Speeder
[446] = 110000, -- Squalo
[454] = 90000, -- Tropic
[539] = 100000 -- Vortex
},
["IND"]={
[499] = 15000, -- Benson
[495] = 80000, -- Benson
[588] = 35000, -- Hotdog
[609] = 30000, -- Black Boxville
[403] = 90000, -- Linerunner (NOTE: is from tank commander)
[498] = 30000, -- Boxville
[514] = 90000, -- Linerunner
[524] = 70000, -- Cement Truck
[422] = 24000, -- Bobcat
[423] = 40000, -- Mr. Whoopee
[420] = 23000, -- Taxi
[532] = 100000, -- Combine Harvester
[414] = 39000, -- Mule
[578] = 60000, -- DFT-30
[443] = 99000, -- Packer
[486] = 110000, -- Dozer
[515] = 89000, -- Roadtrain
[531] = 20000, -- Tractor
[573] = 79000, -- Dune
[456] = 36000, -- Yankee
[455] = 60000, -- Flatbed
[530] = 14000, -- Forklift
[444] = 150000, -- Monster
[556] = 150000, -- Monster 2
[557] = 150000, -- Monster 3
[568] = 34000, -- Bandito
[508] = 45000, -- journey
[552] = 29000, -- Utility Van
[431] = 89000, -- Bus
[438] = 20000, -- Cabbie
[525] = 30000, -- Towtruck
[437] = 89000, -- Coach
[418] = 16000, -- Moonbeam
[572] = 4000, -- Mower
[582] = 37000, -- News Van
[482] = 35000, -- Burrito
[413] = 31000, -- Pony
[440] = 31000, -- Rumpo
[459] = 31000, -- Berkley's RC Van
[400] = 40000, -- Landstalker
[404] = 17000, -- Perennial
[479] = 18000, -- Regina
[442] = 30000 -- Romero
},
["SLOW"]={
[458] = 30000, -- Solair
[438] = 40000, -- camper
[489] = 35000, -- Rancher
[445] = 28000, -- Admiral
[467] = 35000, -- Oceanic
[426] = 35000, -- Premier
[507] = 32000, -- Elegant
[547] = 26000, -- Primo
[585] = 30000, -- Emperor
[405] = 35000, -- Sentinel
[587] = 38000, -- Euros
[409] = 66000, -- Stretch
[466] = 26000, -- Glendale
[550] = 27000, -- Sunrise
[492] = 26000, -- Greenwood
[566] = 24000, -- Tahoma
[546] = 23000, -- Intruder
[540] = 36000, -- Vincent
[551] = 34900, -- Merit
[421] = 32000, -- Washington
[516] = 24900, -- Nebula
[529] = 27900, -- Willard
[602] = 38900, -- Alpha
[478] = 20000, -- Walton
[545] = 39000, -- Hustler
[496] = 38000, -- Blista Compact
[517] = 24900, -- Majestic
--[401] = 21000, -- Bravura
[410] = 22000, -- Manana
[518] = 38000, -- Buccaneer
[600] = 28000, -- Picador
[527] = 29000, -- Cadrona
[436] = 22000, -- Previon
[589] = 30000, -- Club
[580] = 25900, -- Stafford
[500] = 25000, -- Mesa
[419] = 25000, -- Esperanto
[439] = 35000, -- Stallion
[533] = 29000, -- Feltzer
[549] = 23900, -- Tampa
[491] = 22000, -- Virgo
[474] = 40000, -- Hermes
[536] = 31000, -- Blade
[575] = 32000, -- Broadway
[534] = 33000, -- Remington
[567] = 34000, -- Savanna
[535] = 41000, -- Slamvan
[576] = 32000, -- Tornado
[412] = 31000 -- Voodoo
}
}

-------------

local sw, sh = guiGetScreenSize()

-- Marker functions
local buyingVehicle = false
local vehicleSelectGUI = {}
local editGUI = {}
local vehicleRotationZ = 105
local vehicleRotationX = 0

local rotationKeys = {"arrow_l","arrow_r","arrow_u","arrow_d"}
local shopType
local originalWeather
local originalClouds
local originalRadar
local markerPos = {}
local testDriveTimer

function showRoomMarkerHit ( hitElement, matchingDimensions )

local mx, my, mz = getElementPosition ( source )
local px, py, pz = getElementPosition ( localPlayer )

	if hitElement == localPlayer and matchingDimensions then

		if not ( getPedOccupiedVehicle( localPlayer ) ) then

			if ( pz + 3 ) > mz and ( pz - 3 ) < mz then --

				if not buyingVehicle then

					markerPos = { mx, my, mz }
					buyingVehicle = true
					setElementData(localPlayer, 'vehShop_location',getElementData(source,'vehicleShopCity'))
					fadeCamera(false,1.5)
					setElementFrozen(localPlayer,true)
					setTimer(addGUI, 1500, 1)
					setTimer(fadeCamera, 1500, 1, true, 2)

				end

			end

		end

	end

end

function getSellPrice(buyPrice)
	if getResourceFromName("CSGplayervehicles") and getResourceDynamicElementRoot(getResourceFromName("CSGplayervehicles")) then
		return exports.CSGplayervehicles:getVehicleSellPrice(buyPrice,localPlayer)
	else
		return ( buyPrice - buyPrice / 100 * 5 )
	end
end

-- GUI things

function checkLicense ( vehType, vehID )

	if vehType == "Plane" and getElementData ( localPlayer, "planeLicence" ) then

		return true

	elseif vehType == "Helicopter" and getElementData( localPlayer, "chopperLicence" ) then

		return true

	elseif ( vehType == "Automobile" or vehType == "Monster Truck" ) and getElementData( localPlayer, "carLicence" ) then

		return true

	elseif ( vehType == "Bike" or vehType == "Quad" ) and getElementData( localPlayer, "bikeLicence" ) then

		return true

	elseif vehType == "BMX" then

		return true

	elseif vehType == "Boat" and getElementData ( localPlayer, "boatLicence" ) then

		return true

	end

return false

end

function onFilterChanged()

	local text = guiGetText(source)
	createTheGrid()
	for ID,price in pairs(vehiclePriceTable[getVehicleShopType()]) do

		local name = getVehicleNameFromModel(ID)
		if #text < 1 or string.find(name:lower(),text:lower()) then

			local row = guiGridListAddRow(vehicleSelectGUI.gridlist)
			guiGridListSetItemText(vehicleSelectGUI.gridlist, row, vehicleSelectGUI.gridlistNameColumn, name,false, false)
			guiGridListSetItemText(vehicleSelectGUI.gridlist, row, vehicleSelectGUI.gridlistPriceColumn, "$"..exports.server:convertNumber(price),false, false)

		end

	end

end

function onRenderDrawTestDriveTimeLeft()

	if isTimer(testDriveTimer) then

		local timeLeft = getTimerDetails(testDriveTimer)
		dxDrawRectangle(0,sh-20,sw,20,tocolor(0,0,0,170) )
		dxDrawText(math.floor(timeLeft/1000).." seconds left. Use /canceltestdrive to cancel now.", 0, sh-20, sw, sh, tocolor(255,255,255,255), 1.2,"default",'center','center' )

	end

end

function startTestDrive()

	local wantedPoints = getElementData(localPlayer,'wantedPoints')
	if wantedPoints < 1 then

		if isElement(selectedVehicle) then

			local vehicleID = getElementModel(selectedVehicle)

			unbindKey("mouse_wheel_up", 'down', changeCameraMatrix)
			unbindKey("=", 'down', changeCameraMatrix)
			unbindKey("mouse_wheel_down", 'down', changeCameraMatrix)
			unbindKey("-", 'down', changeCameraMatrix)
			removeEventHandler( 'onClientGUIClick', root, onPlayerClickGUI )
			removeEventHandler( 'onClientGUIChanged', vehicleSelectGUI.filterGridlistEdit, onFilterChanged,false )
			showCursor(false)
			fadeCamera(false,1)
			triggerServerEvent('vehicleShop_startTestDrive', localPlayer, vehicleID)
			fadeOut = true
			--stopShopping()
			testDriving = true

		end

	else

		exports.DENdxmsg:createNewDxMessage( "You can't test drive while wanted!", 255,0,0)

	end

end

addEvent("onVehicleSpawnedForTestDrive", true)
function onVehicleSpawnedForTestDrive(info)

	setTimer(
		function ()
			local dimension, interior, px,py,pz,prz = unpack(info)

			setElementInterior(localPlayer, interior, px,py,pz)
			setElementRotation(localPlayer, 0,0, prz)
			triggerServerEvent("vehicleShop_getServerTime", localPlayer)
			guiSetVisible(vehicleSelectGUI.window, false )
			guiSetVisible(vehicleSelectGUI.vehLookInfoLabel, false )
			guiSetVisible(editGUI.window, false )
			setCameraInterior(interior)
			setCameraTarget(localPlayer)
			setElementFrozen(localPlayer,false)
			showPlayerHudComponent("radar",originalRadar)
			removeEventHandler("onClientRender",root,onRender)
			setCloudsEnabled(originalClouds)
			setElementDimension(localPlayer,dimension)
			fadeCamera(true,1)
			testDriveTimer = setTimer(stopTestDrive, 120000, 1, true )
			addEventHandler('onClientRender', root, onRenderDrawTestDriveTimeLeft )
			addCommandHandler('cancelTestDrive', stopTestDriveCommand, false )
		end, 1000, 1 )

end
addEventHandler("onVehicleSpawnedForTestDrive", root, onVehicleSpawnedForTestDrive)

function stopTestDriveCommand() stopTestDrive(true) end
function stopShoppingOnWasted() if testDriving then stopTestDrive(false, true) else stopShopping() end end

function stopTestDrive(goBackToMenu, onWasted)

	triggerServerEvent("vehicleShop_destroyPlayerTestVehicle", localPlayer)

	if goBackToMenu == true then

		fadeCamera(false,2)
		setTimer( function ()
			setCameraInterior(0)
			setCameraTarget(localPlayer)
			setElementDimension(localPlayer,0)
			setElementInterior(localPlayer, 0 )
			setElementPosition(localPlayer, markerPos[1], markerPos[2], markerPos[3]+1)
			setElementFrozen(localPlayer,true)

		end, 2000, 1 )
		setTimer( function ()

			addGUI()
			fadeCamera(true,2)

		end, 3000, 1 )

	else -- also clean up general shop

		setCameraInterior(0)
		setCameraTarget(localPlayer)
		setElementInterior(localPlayer, 0 )
		setElementPosition(localPlayer, markerPos[1], markerPos[2], markerPos[3]+1)
		setElementDimension(localPlayer,0)
		removeEventHandler( 'onClientPlayerWasted', localPlayer, stopShoppingOnWasted, false )

		fadeCamera(true)
		showPlayerHudComponent("radar",originalRadar)
		buyingVehicle = false

	end
	if isTimer(testDriveTimer) then killTimer(testDriveTimer) end
	testDriving = false
	removeEventHandler('onClientRender', root, onRenderDrawTestDriveTimeLeft )
	removeCommandHandler('cancelTestDrive', stopTestDriveCommand )

end

function onPlayerClickGUI()

	if source == vehicleSelectGUI.gridlist then

		local row,_ = guiGridListGetSelectedItem(vehicleSelectGUI.gridlist)
		if row and row ~= -1 then

			local vehicleName = guiGridListGetItemText(vehicleSelectGUI.gridlist, row, vehicleSelectGUI.gridlistNameColumn)

			local ID = getVehicleModelFromName(vehicleName)
			local price = getVehiclePrice(ID)
			if price then
				local convertedPrice = exports.server:convertNumber(price)
				local sellPrice = getSellPrice(price)
				guiSetText(editGUI.vehInfoLabel, vehicleName.."\n$"..convertedPrice.." | Sells for $"..exports.server:convertNumber(sellPrice))
				local wantedPoints = getElementData(localPlayer,'wantedPoints')
				if wantedPoints > 0 then
					guiSetEnabled(editGUI.testVehicleButton,false)
				else
					guiSetEnabled(editGUI.testVehicleButton,true)
				end
				guiSetEnabled(editGUI.pickColor,true)
				if isElement(selectedVehicle) then

					setElementModel(selectedVehicle, ID)
					vehicleRotationZ = 105
					vehicleRotationX = 0
					setElementRotation(selectedVehicle,0,0,105)

				else

					selectedVehicle = createVehicle( ID, 5, 5, 5, 0, 0, 105 )
					setElementFrozen(selectedVehicle,true)
					setElementInterior(selectedVehicle, 1)
					setVehicleOverrideLights(selectedVehicle,2)

				end
				if isElement(editGUI.licensePlateEdit) then
				local vehType = getVehicleType(selectedVehicle)
					if vehType ~= "Automobile" then
						guiSetEnabled( editGUI.licensePlateEdit,false)
						guiSetText(editGUI.licensePlateEdit, '')
					else
						guiSetEnabled( editGUI.licensePlateEdit,true)
					end
				end

			end

		else

			guiSetText(editGUI.vehInfoLabel, 'Pick a vehicle from the gridlist.')

		end

	elseif source == editGUI.buyVehicleButton then

		local r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4 = getVehicleColor(selectedVehicle,true)

		local ID = getElementModel ( selectedVehicle )

		local price = getVehiclePrice ( ID )

		local licensePlate = guiGetText(editGUI.licensePlateEdit)

		triggerServerEvent ( "vehShop_spawnBuyedVehicle", localPlayer, ID, r1, g1, b1, r2, g2, b2, price, licensePlate )

	elseif source == editGUI.testVehicleButton then

		startTestDrive()

	elseif source == editGUI.pickColor then

		if cpicker ~= true then

			cpicker = true
			openColorPicker()

		end

	elseif source == vehicleSelectGUI.cancelShoppingButton then

		stopShopping ()

	end

end

function onRender()

	for i=1,#rotationKeys do

		if getKeyState(rotationKeys[i]) then

			changeCameraMatrix(rotationKeys[i])

		end

	end

	-- fade in GUI
	local windowAlpha = guiGetAlpha(vehicleSelectGUI.window)
	local editAlpha = guiGetAlpha(editGUI.window)
	local vehAlpha
	if isElement(selectedVehicle) then
		vehAlpha = getElementAlpha(selectedVehicle)
	end

	if fadeIn then

		local done = 0
		if windowAlpha < 1 then guiSetAlpha(vehicleSelectGUI.window, windowAlpha+0.01) else done = done + 1 end
		if editAlpha < 1 then guiSetAlpha(editGUI.window, editAlpha+0.01) else done = done + 1 end
		if vehAlpha and vehAlpha < 255 then setElementAlpha(selectedVehicle, vehAlpha+2) else done = done + 1 end
		if done == 3 then fadeIn = false end

	elseif fadeOut then

		local done = 0
		if windowAlpha > 0 then guiSetAlpha(vehicleSelectGUI.window, windowAlpha-0.01) else done = done + 1 end
		if editAlpha > 0 then guiSetAlpha(editGUI.window, editAlpha-0.01) else done = done + 1 end
		if vehAlpha and vehAlpha > 0 then setElementAlpha(selectedVehicle,math.max(vehAlpha-2,0)) else done = done + 1 end
		if done == 3 then fadeOut = false end

	end
	setTime(12,0)

end

function changeCameraMatrix(key)

	local oldX,oldY,oldZ,oldLx,oldLy,oldLz,oldZoom = unpack(cameraInfo)

	if isElement(selectedVehicle) then

		local cursorX, cursorY = getCursorPosition(false)

		if ( key == 'mouse_wheel_up' or key == '=' ) and oldZoom < 0.8 and cursorX*sw > getGridXEnd() then

			cameraInfo[7] = cameraInfo[7] + 0.025

		elseif ( key == 'mouse_wheel_down' or key == '-' ) and oldZoom > 0 and cursorX*sw > getGridXEnd() then

			cameraInfo[7] = cameraInfo[7] - 0.025

		elseif key == 'arrow_r' then

			vehicleRotationZ = vehicleRotationZ + 1
			if vehicleRotationZ >= 360 then vehicleRotationZ = 0 end

		elseif key == 'arrow_l' then

			vehicleRotationZ = vehicleRotationZ - 1
			if vehicleRotationZ <= 0 then vehicleRotationZ = 360 end

		elseif key == 'arrow_u' then

			vehicleRotationX = vehicleRotationX - 1
			if vehicleRotationX <= 0 then vehicleRotationX = 360 end

		elseif key == 'arrow_d' then

			vehicleRotationX = vehicleRotationX + 1
			if vehicleRotationX >= 360 then vehicleRotationX = 0 end

		end
		setElementRotation(selectedVehicle,vehicleRotationX, 0,vehicleRotationZ)
		local x,y,z,lx,ly,lz,zoom = unpack(cameraInfo)
		if x ~= oldX or y ~= oldY or z ~= oldZ or lx ~= oldLx or ly ~= oldLy or lz ~= oldLz or zoom ~= oldZoom then
			x,y,z = interpolateBetween(cameraInfo[1],cameraInfo[2],cameraInfo[3],cameraInfo[4], cameraInfo[5], cameraInfo[6], cameraInfo[7], "Linear")
			setCameraMatrix(x,y,z,lx,ly,lz )
		end

	end

end

-- Create the GUI

function getGridXEnd()

	if sh <= 800 then return 350 else return 390 end

end

function createTheGrid()

	if isElement(vehicleSelectGUI.gridlist) then destroyElement(vehicleSelectGUI.gridlist) end

	vehicleSelectGUI.gridlist = guiCreateGridList(0.02, 0.04, 0.94, 0.88, true, vehicleSelectGUI.window)
	vehicleSelectGUI.gridlistNameColumn = guiGridListAddColumn(vehicleSelectGUI.gridlist, "Name", 0.45 )
	vehicleSelectGUI.gridlistPriceColumn = guiGridListAddColumn(vehicleSelectGUI.gridlist, "Price", 0.45 )
	guiGridListSetSelectionMode(vehicleSelectGUI.gridlist,0)

end

function addGUI ()

	if vehicleSelectGUI.window and guiGetVisible(vehicleSelectGUI.window) then return false end
	cameraInfo = { -25,-25,10,5,5,5, 0.7 }

	if not vehicleSelectGUI.window then

		local windowHeight = 650
		local windowWidth = 383
		if sh <=800 then windowHeight,windowWidth = 500,340 end
		vehicleSelectGUI.window = guiCreateWindow(0, sh-650, windowWidth, windowHeight, "", false)
		guiWindowSetSizable(vehicleSelectGUI.window, false)

		createTheGrid()
		vehicleSelectGUI.filterGridlistLabel = guiCreateLabel(0.02, 0.93, 0.35, 0.05, "Filter:", true, vehicleSelectGUI.window)
		vehicleSelectGUI.filterGridlistEdit = guiCreateEdit(0.38, 0.93, 0.35, 0.05, "", true, vehicleSelectGUI.window)
		guiLabelSetVerticalAlign(vehicleSelectGUI.filterGridlistLabel,'center')
		guiLabelSetHorizontalAlign(vehicleSelectGUI.filterGridlistLabel,'center')
		vehicleSelectGUI.cancelShoppingButton = guiCreateButton(0.75, 0.93, 0.23, 0.05, "Cancel", true, vehicleSelectGUI.window)
		vehicleSelectGUI.vehLookInfoLabel = guiCreateLabel( 0, 0, sw, 40, "Use scroll or +/- to zoom in/out.\nUse arrow keys to rotate.", false )
		guiLabelSetColor ( vehicleSelectGUI.vehLookInfoLabel, 0,0,0 )
		guiLabelSetVerticalAlign(vehicleSelectGUI.vehLookInfoLabel,'center')
		guiLabelSetHorizontalAlign(vehicleSelectGUI.vehLookInfoLabel,'center')

	else

		guiSetVisible(vehicleSelectGUI.window,true)
		guiSetVisible(vehicleSelectGUI.vehLookInfoLabel,true)
		guiSetText(vehicleSelectGUI.filterGridlistEdit, "")
		createTheGrid()

	end

	guiSetAlpha(vehicleSelectGUI.window, 0)
	addEventHandler( 'onClientGUIClick', root, onPlayerClickGUI )
	addEventHandler( 'onClientGUIChanged', vehicleSelectGUI.filterGridlistEdit, onFilterChanged,false )
	addEventHandler( 'onClientPlayerWasted', localPlayer, stopShoppingOnWasted, false )
	showCursor(true)
	addEditGUI ()
	setCameraInterior(1)
	local x,y,z,lx,ly,lz, zoom = unpack(cameraInfo)

	x,y,z = interpolateBetween(x,y,z,lx,ly,lz, zoom, "Linear")
	setCameraMatrix(x,y,z,lx,ly,lz )
	bindKey("mouse_wheel_up", 'down', changeCameraMatrix)
	bindKey("=", 'down', changeCameraMatrix)
	bindKey("mouse_wheel_down", 'down', changeCameraMatrix)
	bindKey("-", 'down', changeCameraMatrix)
	fadeOut = false
	fadeIn = true
	addEventHandler("onClientRender",root,onRender)
	--originalWeather = getWeather()
	originalClouds = getCloudsEnabled()
	originalRadar = isPlayerHudComponentVisible("radar")
	showPlayerHudComponent("radar",false)
	--setWeather(44)
	for ID,price in pairs(vehiclePriceTable[getVehicleShopType()]) do
		local name = getVehicleNameFromModel(ID)
		local row = guiGridListAddRow(vehicleSelectGUI.gridlist)
		guiGridListSetItemText(vehicleSelectGUI.gridlist, row, vehicleSelectGUI.gridlistNameColumn, name,false, false)
		guiGridListSetItemText(vehicleSelectGUI.gridlist, row, vehicleSelectGUI.gridlistPriceColumn, "$"..exports.server:convertNumber(price),false, false)

	end
end


-- stop shopping
addEvent ( "closeGUIS", true )

function stopShopping (onResourceStop)

	if buyingVehicle then

		buyingVehicle = false
		fadeOut = true
		unbindKey("mouse_wheel_up", 'down', changeCameraMatrix)
		unbindKey("=", 'down', changeCameraMatrix)
		unbindKey("mouse_wheel_down", 'down', changeCameraMatrix)
		unbindKey("-", 'down', changeCameraMatrix)
		removeEventHandler( 'onClientGUIClick', root, onPlayerClickGUI )
		removeEventHandler( 'onClientGUIChanged', vehicleSelectGUI.filterGridlistEdit, onFilterChanged,false )
		showCursor(false)
		fadeCamera(false,2)
		removeEventHandler( 'onClientPlayerWasted', localPlayer, stopShoppingOnWasted, false )

		if not onResourceStop then

		setTimer(
			function ()
			triggerServerEvent("vehicleShop_getServerTime", localPlayer)
			guiSetVisible(vehicleSelectGUI.window, false )
			guiSetVisible(vehicleSelectGUI.vehLookInfoLabel, false )
			guiSetVisible(editGUI.window, false )
			setCameraInterior(0)
			setCameraTarget(localPlayer)
			setElementFrozen(localPlayer,false)
			showPlayerHudComponent("radar",originalRadar)
			removeEventHandler("onClientRender",root,onRender)
			setCloudsEnabled(originalClouds)
			if isElement(selectedVehicle) then destroyElement(selectedVehicle) end

			fadeCamera(true,2)
		end, 2000, 1 )

		else

			guiSetVisible(vehicleSelectGUI.window, false )
			guiSetVisible(vehicleSelectGUI.vehLookInfoLabel, false )
			guiSetVisible(editGUI.window, false )
			setCameraInterior(0)
			setCameraTarget(localPlayer)
			setElementFrozen(localPlayer,false)
			showPlayerHudComponent("radar",originalRadar)
			removeEventHandler("onClientRender",root,onRender)
			setCloudsEnabled(originalClouds)
			if isElement(selectedVehicle) then destroyElement(selectedVehicle) end

			fadeCamera(true,2)

		end

	end

end

addEvent("vehicleShop_onReceiveServerTime", true)
addEventHandler("vehicleShop_onReceiveServerTime", root,
function ( hours, minutes)

	setTime(hours,minutes)
end)


addEventHandler ( "closeGUIS", root, stopShopping )
addEventHandler ( "onClientResourceStop", resourceRoot,
function ()

	if testDriving then

		stopTestDrive(false)

	elseif buyingVehicle then

		stopShopping(true)

	end

end)

function addEditGUI ()

	if not editGUI.window then

		editGUI.window = guiCreateWindow(sw-277, sh-205, 277, 180, "Edit vehicle", false)
		guiWindowSetSizable(editGUI.window, false)
		editGUI.vehInfoLabel = guiCreateLabel(6, 24, 264, 38, "Pick a vehicle from the gridlist.", false, editGUI.window)
		guiLabelSetVerticalAlign(editGUI.vehInfoLabel,'center')
		guiLabelSetHorizontalAlign(editGUI.vehInfoLabel,'center')
		editGUI.pickColor = guiCreateButton(20, 106, 108, 32, "Pick color", false, editGUI.window)
		editGUI.licensePlateLabel = guiCreateLabel(10, 68, 138, 28, "License plate:", false, editGUI.window)
		guiLabelSetVerticalAlign(editGUI.licensePlateLabel,'center')
		guiLabelSetHorizontalAlign(editGUI.licensePlateLabel,'center')
		editGUI.licensePlateEdit = guiCreateEdit(150, 68, 117, 31, "", false, editGUI.window)
		editGUI.buyVehicleButton = guiCreateButton(159, 106, 108, 32, "Buy vehicle", false, editGUI.window)
		guiEditSetMaxLength(editGUI.licensePlateEdit,7)
		editGUI.testVehicleButton = guiCreateButton(159, 143, 108, 29, "Test drive", false, editGUI.window)
	else

		guiSetText(editGUI.vehInfoLabel, "Pick a vehicle from the gridlist.")
		guiSetText(editGUI.licensePlateEdit, "")
		guiSetVisible( editGUI.window, true )

	end

	guiSetEnabled(editGUI.pickColor,false)
	guiSetEnabled(editGUI.testVehicleButton,false)
	local wantedPoints = getElementData(localPlayer,'wantedPoints')
	if wantedPoints > 0 then
		exports.DENdxmsg:createNewDxMessage("Test drive feature is disabled when wanted.", 255, 0, 0 )
	end
	guiSetAlpha(editGUI.window, 0)

end

-- buying it + color picker

local types =
{"BIKE","FAST","SLOW","AIR","BOAT","IND"}

function getVehicleShopType()

	local city = getElementData(localPlayer, "vehShop_location")
	if city == "copShop" then return "copShop" end
	for i=1,#types do

		if string.find(city,types[i]) then

			return types[i]

		end

	end

	return "NIL"

end

function getVehiclePrice(ID)

	local shopType = getVehicleShopType()

	if vehiclePriceTable[shopType][ID] then

		return vehiclePriceTable[shopType][ID]

	else

		return 99999999

	end

end
