local pizzaMarkers = {
[1]={375.22, -119.66, 1000.49, 5, 13},
[2]={375.22, -119.66, 1000.49, 5, 1},
[3]={375.22, -119.66, 1000.49, 5, 2},
[4]={375.22, -119.66, 1000.49, 5, 3},
[5]={375.22, -119.66, 1000.49, 5, 4},
[6]={375.22, -119.66, 1000.49, 5, 5},
[7]={375.22, -119.66, 1000.49, 5, 6},
[8]={375.22, -119.66, 1000.49, 5, 7},
[9]={375.22, -119.66, 1000.49, 5, 8},
[10]={375.22, -119.66, 1000.49, 5, 9},
[12]={375.22, -119.66, 1000.49, 5, 10},
[13]={375.22, -119.66, 1000.49, 5, 11},
[14]={375.22, -119.66, 1000.49, 5, 12}
}

local localPlayer = getLocalPlayer()

function createPizzaWindow ()

pizzaWindow = guiCreateWindow(565,216,312,467,"CSG ~ The Well Stacked Pizza Co.",false)
image1 = guiCreateStaticImage(24,28,98,92,"images/pizza1.png",false,pizzaWindow)
image2 = guiCreateStaticImage(24,115,101,108,"images/pizza2.png",false,pizzaWindow)
image3 = guiCreateStaticImage(24,217,104,117,"images/pizza3.png",false,pizzaWindow)
image4 = guiCreateStaticImage(35,339,75,79,"images/sprunk.png",false,pizzaWindow)
buySmall = guiCreateButton(156,70,127,34,"Small Menu ($ 10)",false,pizzaWindow)
buySprunk = guiCreateButton(156,373,127,34,"Sprunk ($ 7)",false,pizzaWindow)
buyBig = guiCreateButton(156,268,127,34,"Big Menu ($ 30)",false,pizzaWindow)
buyMedium = guiCreateButton(156,162,127,34,"Medium Menu ($ 20)",false,pizzaWindow)
closeWindow = guiCreateButton(24,425,264,34,"Close window",false,pizzaWindow)


local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(pizzaWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(pizzaWindow,x,y,false)

guiWindowSetMovable (pizzaWindow, true)
guiWindowSetSizable (pizzaWindow, false)
guiSetVisible (pizzaWindow, false)

addEventHandler("onClientGUIClick", closeWindow, function() guiSetVisible(pizzaWindow, false) showCursor(false,false) end, false)

addEventHandler ( "onClientGUIClick", buySmall, pizzaSmall, false )
addEventHandler ( "onClientGUIClick", buyMedium, pizzaMedium, false )
addEventHandler ( "onClientGUIClick", buyBig, pizzaBig, false )
addEventHandler ( "onClientGUIClick", buySprunk, pizzaSprunk, false )

end

function pizzaHide()
	if guiGetVisible(pizzaWindow) then
		guiSetVisible(pizzaWindow, false) showCursor(false,false)
	end
end

function pizzaSmall ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(pizzaWindow, false) return end
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

function pizzaMedium ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(pizzaWindow, false) return end
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

function pizzaBig ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(pizzaWindow, false) return end
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

function pizzaSprunk ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(pizzaWindow, false) return end
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
		createPizzaWindow()
	end
)

function pizzaMarkerHit( hitElement, matchingDimension, drive )
	if hitElement == localPlayer then
		if matchingDimension then
			guiSetVisible(pizzaWindow,true)
			showCursor(true,true)
			if drive == nil then
				guiSetText(pizzaWindow,"CSG ~ The Well Stacked Pizza Co.")
			else
				guiSetText(pizzaWindow,"CSG ~ The Well Stacked Pizza Co.")
			end
		end
	end
end

for ID in pairs(pizzaMarkers) do

local x, y, z = pizzaMarkers[ID][1], pizzaMarkers[ID][2], pizzaMarkers[ID][3]

local interior = pizzaMarkers[ID][4]
local dimension = pizzaMarkers[ID][5]

local pizzaWalk = createMarker(x,y,z,"cylinder",1.5, 255, 69, 0, 170)

setElementInterior(pizzaWalk , interior)
setElementDimension (pizzaWalk , dimension )

addEventHandler("onClientMarkerHit", pizzaWalk, pizzaMarkerHit)

end
