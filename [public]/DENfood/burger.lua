local burgerMarkers = {
[1]={377.14, -67.83, 1000.51, 10, 0},
[2]={377.14, -67.83, 1000.51, 10, 1},
[3]={377.14, -67.83, 1000.51, 10, 2},
[4]={377.14, -67.83, 1000.51, 10, 3},
[5]={377.14, -67.83, 1000.51, 10, 4},
[6]={377.14, -67.83, 1000.51, 10, 5},
[7]={377.14, -67.83, 1000.51, 10, 6},
[8]={377.14, -67.83, 1000.51, 10, 7},
[9]={377.14, -67.83, 1000.51, 10, 8},
[10]={377.14, -67.83, 1000.51, 10, 9},
[12]={377.14, -67.83, 1000.51, 10, 10},
[13]={377.14, -67.83, 1000.51, 10, 11},
[14]={377.14, -67.83, 1000.51, 10, 12}
}

local localPlayer = getLocalPlayer()

function createburgerWindow ()

burgerWindow = guiCreateWindow(565,216,312,467,"CSG ~ Burger Shot",false)
image1 = guiCreateStaticImage(24,28,98,92,"images/bs1.png",false,burgerWindow)
image2 = guiCreateStaticImage(24,115,101,108,"images/bs2.png",false,burgerWindow)
image3 = guiCreateStaticImage(24,217,104,117,"images/bs3.png",false,burgerWindow)
image4 = guiCreateStaticImage(35,339,75,79,"images/sprunk.png",false,burgerWindow)
buySmall = guiCreateButton(156,70,127,34,"Small Menu ($ 10)",false,burgerWindow)
buySprunk = guiCreateButton(156,373,127,34,"Sprunk ($ 7)",false,burgerWindow)
buyBig = guiCreateButton(156,268,127,34,"Big Menu ($ 30)",false,burgerWindow)
buyMedium = guiCreateButton(156,162,127,34,"Medium Menu ($ 20)",false,burgerWindow)
closeWindow = guiCreateButton(24,425,264,34,"Close window",false,burgerWindow)


local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(burgerWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(burgerWindow,x,y,false)

guiWindowSetMovable (burgerWindow, true)
guiWindowSetSizable (burgerWindow, false)
guiSetVisible (burgerWindow, false)

addEventHandler("onClientGUIClick", closeWindow, function() guiSetVisible(burgerWindow, false) showCursor(false,false) end, false)

addEventHandler ( "onClientGUIClick", buySmall, burgerSmall, false )
addEventHandler ( "onClientGUIClick", buyMedium, burgerMedium, false )
addEventHandler ( "onClientGUIClick", buyBig, burgerBig, false )
addEventHandler ( "onClientGUIClick", buySprunk, burgerSprunk, false )

end

function burgerHide()
	if guiGetVisible(burgerWindow) then
		guiSetVisible(burgerWindow, false) showCursor(false,false)
	end
end

function burgerSmall ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(burgerWindow, false) return end
local playerMoney = getPlayerMoney ( localPlayer )
local playerHealth = getElementHealth (localPlayer)
if playerHealth > 199 then
outputChatBox ("You have already full health!", 225, 0,0)
elseif playerMoney < 10 then
outputChatBox ("You don't have enough money to buy this.", 225, 0,0)
else
	triggerServerEvent("buySmallMenu", getLocalPlayer())
end
end

function burgerMedium ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(burgerWindow, false) return end
local playerMoney = getPlayerMoney ( localPlayer )
local playerHealth = getElementHealth (localPlayer)
if playerHealth > 199 then
outputChatBox ("You have already full health!", 225, 0,0)
elseif playerMoney < 20 then
outputChatBox ("You don't have enough money to buy this.", 225, 0,0)
else
	triggerServerEvent("buyMediumMenu", getLocalPlayer())
end
end

function burgerBig ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(burgerWindow, false) return end
local playerMoney = getPlayerMoney ( localPlayer )
local playerHealth = getElementHealth (localPlayer)
if playerHealth > 199 then
outputChatBox ("You have already full health!", 225, 0,0)
elseif playerMoney < 30 then
outputChatBox ("You don't have enough money to buy this.", 225, 0,0)
else
	triggerServerEvent("buyBigMenu", getLocalPlayer())
end
end

function burgerSprunk ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(burgerWindow, false) return end
local playerMoney = getPlayerMoney ( localPlayer )
local playerHealth = getElementHealth (localPlayer)
if playerHealth > 199 then
outputChatBox ("You have already full health!", 225, 0,0)
elseif playerMoney < 7 then
outputChatBox ("You don't have enough money to buy this.", 225, 0,0)
else
	triggerServerEvent("buySprunkDrink", getLocalPlayer())
end
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function ()
		createburgerWindow()
	end
)

function burgerMarkerHit( hitElement, matchingDimension )
	if matchingDimension then
		if hitElement == localPlayer then
			guiSetVisible(burgerWindow,true)
			showCursor(true,true)
		end
	end
end

for ID in pairs(burgerMarkers) do

local x, y, z = burgerMarkers[ID][1], burgerMarkers[ID][2], burgerMarkers[ID][3]
local interior = burgerMarkers[ID][4]
local dimension = burgerMarkers[ID][5]

local burgerWalk = createMarker(x,y,z,"cylinder",1.4, 156, 102, 31, 225)

setElementInterior(burgerWalk , interior)
setElementDimension (burgerWalk , dimension)


addEventHandler("onClientMarkerHit", burgerWalk, burgerMarkerHit)

end
