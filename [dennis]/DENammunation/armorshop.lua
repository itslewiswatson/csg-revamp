armorWindow = guiCreateWindow(498,513,243,147,"CSG ~ Buy Armor",false)
armorWindowLabel = guiCreateLabel(66,27,120,16,"Buy here your armor!",false,armorWindow)
guiLabelSetColor(armorWindowLabel,0,225,0)
guiSetFont(armorWindowLabel,"default-bold-small")
armorWindowButton1 = guiCreateButton(9,52,225,22,"Buy 100% armor",false,armorWindow)
armorWindowButton2 = guiCreateButton(9,80,225,22,"Buy 50% armor",false,armorWindow)
armorWindowButton3 = guiCreateButton(9,115,225,22,"Close window",false,armorWindow)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(armorWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(armorWindow,x,y,false)

guiWindowSetMovable (armorWindow, true)
guiWindowSetSizable (armorWindow, false)
guiSetVisible (armorWindow, false)

addEventHandler("onClientGUIClick", armorWindowButton3, function() guiSetVisible(armorWindow, false) showCursor(false) end, false)
addEventHandler("onClientGUIClick", armorWindowButton2, function() triggerServerEvent("onClientPlayerBoughtArmour", localPlayer, 50) end, false)
addEventHandler("onClientGUIClick", armorWindowButton1, function() triggerServerEvent("onClientPlayerBoughtArmour", localPlayer, 100) end, false)

pickupTable = {
	{309.55, -131.43, 999.6, 7, 1},
	{296.42, -77.16, 1001.51, 4, 1},
	{296.42, -77.16, 1001.51, 4, 2},
	{296.42, -77.16, 1001.51, 4, 3},
	{296.42, -77.16, 1001.51, 4, 4},
	{296.42, -77.16, 1001.51, 4, 5},
	{296.42, -77.16, 1001.51, 4, 6},
	{296.42, -77.16, 1001.51, 4, 7},
	{297.8, -107.61, 1001.51, 6, 1},
	{297.8, -107.61, 1001.51, 6, 2},
	{297.8, -107.61, 1001.51, 6, 3},
	{297.8, -107.61, 1001.51, 6, 4},
	{297.8, -107.61, 1001.51, 6, 5},
	{297.8, -107.61, 1001.51, 6, 6},
	{297.8, -107.61, 1001.51, 6, 7},
}

function onArmourPickUpHit ( hitElement, matchingDimension )
	if ( hitElement == localPlayer ) then
		guiSetVisible (armorWindow, true)
		guiSetText(armorWindowButton1, "Buy 100% armor ($"..getArmorPrice( 100 )..")")
		guiSetText(armorWindowButton2, "Buy 50% armor ($"..getArmorPrice( 50 )..")")
		showCursor(true)
	end
end

for i=1,#pickupTable do
	local x, y, z, int, dim = pickupTable[i][1], pickupTable[i][2], pickupTable[i][3], pickupTable[i][4], pickupTable[i][5]
	local thePickup = createPickup ( x, y, z, 3, 1242, 0, 0 )
	local theCol = createColTube ( x, y, z -1, 0.5, 2)
	addEventHandler ( "onClientColShapeHit", theCol, onArmourPickUpHit )
	setElementInterior ( thePickup, int )
	setElementDimension( thePickup, dim )
end

function getArmorPrice ( armourType )
	if ( exports.server:isPlayerPremium( localPlayer ) ) then
		if ( tonumber(armourType) == 50 ) then
			return 250
		else
			return 500
		end
	else
		if ( tonumber(armourType) == 50 ) then
			return 500
		else
			return 1000
		end
	end
end