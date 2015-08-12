-- Gym script Social Gaming Network
-- Scripted by Dennis (UniOn)
-- All rights reserved / Alle rechten voorbehouden
-- Dont use this script without permission from the original developer

local gymMarkers = { 
{759.4,-60.25,999.80, 7,0}, -- Gym in LV ID 1
{756.94,-47.69,999.78, 6,0}, -- Gym in SF ID 2
{772.92,5.38,999.76, 5,0} -- Gym in LS ID 3
} 

-- Creating the GUI
gymWindow = guiCreateWindow(423,243,312,179,"SGN ~ Fighting style shop",false)
gymLabel1 = guiCreateLabel(60,27,196,18,"Welcome to the San Andreas gym!",false,gymWindow)
gymLabel2 = guiCreateLabel(55,43,227,16,"Buying new fighting style cost 1000$.",false,gymWindow)
gymRadio1 = guiCreateRadioButton(9,71,84,19,"Standard",false,gymWindow)
guiRadioButtonSetSelected(gymRadio1,true)
gymRadio2 = guiCreateRadioButton(119,71,84,19,"Boxing",false,gymWindow)
gymRadio3 = guiCreateRadioButton(220,71,83,19,"Kung Fu",false,gymWindow)
gymRadio4 = guiCreateRadioButton(9,102,84,19,"Knee Head",false,gymWindow)
gymRadio5 = guiCreateRadioButton(119,103,84,19,"Grab Kick",false,gymWindow)
gymRadio6 = guiCreateRadioButton(220,104,83,19,"Elbows",false,gymWindow)
gymButton1 = guiCreateButton(25,140,126,28,"Buy Fighting Style",false,gymWindow)
gymButton2 = guiCreateButton(161,140,126,28,"Close screen",false,gymWindow)

addEventHandler("onClientGUIClick", gymButton2, function() guiSetVisible(gymWindow, false) showCursor(false) end, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(gymWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(gymWindow,x,y,false)

guiWindowSetMovable (gymWindow, true)
guiWindowSetSizable (gymWindow, false)
guiSetVisible (gymWindow, false)

-- Show the gui when player hit the marker
function gymMarkerHit (hitElement, matchingdimension) 
	if matchingdimension then
		if hitElement == localPlayer then
			guiSetVisible(gymWindow,true)
			showCursor(true,true)
		end
	end
end

for i=1,#gymMarkers do

local x, y, z = gymMarkers[i][1], gymMarkers[i][2], gymMarkers[i][3] 
local interior, dimension = gymMarkers[i][4], gymMarkers[i][5] 
local gymShopMarkers = createMarker(x,y,z,"cylinder",2,0,205,102,150) 
setElementInterior(gymShopMarkers, interior)
setElementDimension(gymShopMarkers, dimension)

addEventHandler("onClientMarkerHit", gymShopMarkers, gymMarkerHit)

end

-- Check what style is selected and set style serverside
function setStyle()
	local localPlayer = getLocalPlayer ( )
	if (guiRadioButtonGetSelected(gymRadio1)) then
		style = 4
	elseif (guiRadioButtonGetSelected(gymRadio2)) then
		style = 5
	elseif (guiRadioButtonGetSelected(gymRadio3)) then
		style = 6
	elseif (guiRadioButtonGetSelected(gymRadio4)) then
		style = 7
	elseif (guiRadioButtonGetSelected(gymRadio5)) then
		style = 15
	elseif (guiRadioButtonGetSelected(gymRadio6)) then
		style = 16
	end
	guiSetVisible(gymWindow, false)
	showCursor(false)
	triggerServerEvent("buyFightingStyle", localPlayer, style)
end
addEventHandler("onClientGUIClick", gymButton1, setStyle, false)