local shopMakers = {
[1] = {-26.98, -89.59, 1003.54, 18, 1, 180.29113769531},
[2] = {-26.98, -89.59, 1003.54, 18, 2, 180.29113769531},
[3] = {-26.98, -89.59, 1003.54, 18, 3, 180.29113769531},
[4] = {-26.98, -89.59, 1003.54, 18, 4, 180.29113769531},
[5] = {-26.98, -89.59, 1003.54, 18, 5, 180.29113769531},
[6] = {-23.41, -55.07, 1003.54, 6, 1, 183.04325866699},
[7] = {-23.41, -55.07, 1003.54, 6, 2, 183.04325866699},
[8] = {-23.41, -55.07, 1003.54, 6, 3, 183.04325866699},
[9] = {-23.41, -55.07, 1003.54, 6, 4, 183.04325866699},
[10] = {-23.41, -55.07, 1003.54, 6, 5, 183.04325866699},
[11] = {-23.41, -55.07, 1003.54, 6, 6, 183.04325866699},
[12] = {-23.41, -55.07, 1003.54, 6, 7, 183.04325866699},
[13] = {-23.41, -55.07, 1003.54, 6, 8, 183.04325866699},
[14] = {-23.41, -55.07, 1003.54, 6, 9, 183.04325866699},
[15] = {-23.41, -55.07, 1003.54, 6, 10, 183.04325866699},
[16] = {-23.41, -55.07, 1003.54, 6, 11, 183.04325866699},
[17] = {-23.41, -55.07, 1003.54, 6, 12, 183.04325866699},
[18] = {-23.41, -55.07, 1003.54, 6, 13, 183.04325866699}
}

local shopBlips = {
[1] = {1354.17, -1759.24, 13.5}, -- X, Y, Z
[2] = {1315.51, -899.15, 39.57},
--[3] = {1832.04, -1842.84, 13.57},
[4] = {998.72, -920.38, 42.17},
[5] = {-2442.93, 753.06, 35.17},
[6] = {-182.24, 1034.87, 19.74},
[7] = {1936.01, 2307.2, 10.82},
[8] = {2097.75, 2224.19, 11.02},
[9] = {2194.37, 1991.01, 12.29},
[10] = {2452.46, 2064.75, 10.82},
[11] = {2546.7, 1972.27, 10.82},
[12] = {-2442.65, 752.88, 35.17},
[13] = {-1562.63, -2732.98, 48.74},
[14] = {1352.3, -1758.3, 13.5},
[15] = {1833.54, -1843.38, 13.57},
[15] = {2884.83, 2453.27, 11.06}
}

-- Window
shopWindow = guiCreateWindow(437,249,477,527,"CSG ~ 24/7 shop",false)
brassImage = guiCreateStaticImage(19,28,72,71,"images/BRASSKNUCKLES.png",false,shopWindow)
brassButton = guiCreateButton(9,102,97,36,"Brass Knuckles ($750)",false,shopWindow)
cameraImage = guiCreateStaticImage(139,28,70,67,"images/CAMERA.png",false,shopWindow)
cameraButton = guiCreateButton(127,102,97,36,"Camera ($500)",false,shopWindow)
caneImage = guiCreateStaticImage(253,30,66,64,"images/CANE.png",false,shopWindow)
caneButton = guiCreateButton(241,102,97,36,"Cane ($500)",false,shopWindow)
poolImage = guiCreateStaticImage(373,30,65,64,"images/POOLCUE.png",false,shopWindow)
poolButton = guiCreateButton(361,102,97,36,"Poolcue ($500)",false,shopWindow)
shovelImage = guiCreateStaticImage(20,152,70,69,"images/SHOVEL.png",false,shopWindow)
shovelButton = guiCreateButton(9,228,97,36,"Shovel ($600)",false,shopWindow)
batImage = guiCreateStaticImage(139,153,68,67,"images/BAT.png",false,shopWindow)
batButton = guiCreateButton(127,228,97,36,"Baseball Bat ($700)",false,shopWindow)
golfImage = guiCreateStaticImage(254,153,66,67,"images/GOLF.png",false,shopWindow)
golfButton = guiCreateButton(245,228,97,36,"Golf Club ($600)",false,shopWindow)
knifeImage = guiCreateStaticImage(372,154,66,67,"images/KNIFE.png",false,shopWindow)
knifeButton = guiCreateButton(358,228,97,36,"Knife ($600)",false,shopWindow)
irgoggleImage = guiCreateStaticImage(21,271,68,67,"images/IRGOGGLES.png",false,shopWindow)
irgoggleButton = guiCreateButton(9,346,97,36,"Infrared Goggles ($1000)",false,shopWindow)
nightgoggleImage = guiCreateStaticImage(137,271,70,74,"images/NVGOGGLES.png",false,shopWindow)
nightgoggleButton = guiCreateButton(125,346,97,36,"Night Goggles ($1000)",false,shopWindow)
flowersImage = guiCreateStaticImage(255,274,67,69,"images/FLOWERS.png",false,shopWindow)
flowersButton = guiCreateButton(242,346,97,36,"Flowers ($300)",false,shopWindow)
fireImage = guiCreateStaticImage(373,275,66,66,"images/FIREEXT.png",false,shopWindow)
fireButton = guiCreateButton(362,346,97,36,"Fire Extinguisher ($1500)",false,shopWindow)
parashuteImage = guiCreateStaticImage(19,385,69,66,"images/PARACHUTE.png",false,shopWindow)
parashuteButton = guiCreateButton(9,453,97,36,"Parachute ($1000)",false,shopWindow)
dildoImage = guiCreateStaticImage(136,388,68,60,"images/DILDO1.png",false,shopWindow)
dildoButton = guiCreateButton(123,453,97,36,"Dildo ($500)",false,shopWindow)
viberatorImage = guiCreateStaticImage(253,387,70,61,"images/VIBE1.png",false,shopWindow)
viberatorButton = guiCreateButton(242,453,97,36,"Vibrator ($600)",false,shopWindow)
spraycanImage = guiCreateStaticImage(369,388,72,60,"images/SPRAYCAN.png",false,shopWindow)
spraycanButton = guiCreateButton(358,453,97,36,"Spraycan ($1000)",false,shopWindow)
closeScreen = guiCreateButton(162,500,148,18,"Close Shop Window",false,shopWindow)

guiSetEnabled( spraycanButton, false )

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(shopWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(shopWindow,x,y,false)

guiWindowSetMovable (shopWindow, true)
guiWindowSetSizable (shopWindow, false)
guiSetVisible (shopWindow, false)

addEventHandler("onClientGUIClick", closeScreen, function() guiSetVisible(shopWindow, false) showCursor(false,false) end, false)

function shopMarkerHit ( hitPlayer, matchingDimension )
if matchingDimension then
	if hitPlayer == getLocalPlayer() then
		local vehicle = getPedOccupiedVehicle (localPlayer)
			if not vehicle then
			guiSetVisible(shopWindow,true)
			showCursor(true,true)
			end
		end
	end
end

for ID in pairs(shopMakers) do
	local x, y, z = shopMakers[ID][1], shopMakers[ID][2], shopMakers[ID][3]
	local interior = shopMakers[ID][4]
	local dimension = shopMakers[ID][5]
	local shopMarker = createMarker(x,y,z -1,"cylinder",1.0, 225, 225, 225 ,170)
	setElementInterior(shopMarker, interior)
	setElementDimension ( shopMarker, dimension )
	addEventHandler("onClientMarkerHit", shopMarker, shopMarkerHit)
end

for ID in pairs(shopBlips) do
local x, y, z = shopBlips[ID][1], shopBlips[ID][2], shopBlips[ID][3]
--local theBlip = createBlip ( x, y, z, 44, 0, 0, 0, 0, 0, 0, 100 )
exports.customblips:createCustomBlip ( x,y, 16, 16, "blip.png", 100 )
end

addEventHandler("onClientGUIClick", brassButton, function() triggerServerEvent("buyShopItem", localPlayer, "1", "1", "750" ) end, false)
addEventHandler("onClientGUIClick", cameraButton, function() triggerServerEvent("buyShopItem", localPlayer, "43", "1", "1000" ) end, false)
addEventHandler("onClientGUIClick", caneButton, function() triggerServerEvent("buyShopItem", localPlayer, "15", "36", "500" ) end, false)
addEventHandler("onClientGUIClick", poolButton, function() triggerServerEvent("buyShopItem", localPlayer, "7", "1", "500" ) end, false)

addEventHandler("onClientGUIClick", shovelButton, function() triggerServerEvent("buyShopItem", localPlayer, "6", "1", "600" ) end, false)
addEventHandler("onClientGUIClick", batButton, function() triggerServerEvent("buyShopItem", localPlayer, "5", "1", "700" ) end, false)
addEventHandler("onClientGUIClick", golfButton, function() triggerServerEvent("buyShopItem", localPlayer, "2", "1", "600" ) end, false)
addEventHandler("onClientGUIClick", knifeButton, function() triggerServerEvent("buyShopItem", localPlayer, "4", "1", "600" ) end, false)

addEventHandler("onClientGUIClick", irgoggleButton, function() triggerServerEvent("buyShopItem", localPlayer, "45", "1", "1000" ) end, false)
addEventHandler("onClientGUIClick", nightgoggleButton, function() triggerServerEvent("buyShopItem", localPlayer, "44", "1", "1000" ) end, false)
addEventHandler("onClientGUIClick", flowersButton, function()	triggerServerEvent("buyShopItem", localPlayer, "14", "1", "300" ) end, false)
addEventHandler("onClientGUIClick", fireButton, function() triggerServerEvent("buyShopItem", localPlayer, "42", "500", "1500" ) end, false)

addEventHandler("onClientGUIClick", parashuteButton, function() triggerServerEvent("buyShopItem", localPlayer, "46", "1", "1000" ) end, false)
addEventHandler("onClientGUIClick", dildoButton, function() triggerServerEvent("buyShopItem", localPlayer, "10", "1", "500" ) end, false)
addEventHandler("onClientGUIClick", viberatorButton, function() triggerServerEvent("buyShopItem", localPlayer, "12", "1", "600" ) end, false)
addEventHandler("onClientGUIClick", spraycanButton, function() triggerServerEvent("buyShopItem", localPlayer, "41", "500", "1000" ) end, false)
