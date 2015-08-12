local cluckinMarkers = {
[1]={369.38, -6.32, 1000.85, 9, 0},
[2]={369.38, -6.32, 1000.85, 9, 1},
[3]={369.38, -6.32, 1000.85, 9, 2},
[4]={369.38, -6.32, 1000.85, 9, 3},
[5]={369.38, -6.32, 1000.85, 9, 4},
[6]={369.38, -6.32, 1000.85, 9, 5},
[7]={369.38, -6.32, 1000.85, 9, 6},
[8]={369.38, -6.32, 1000.85, 9, 7},
[9]={369.38, -6.32, 1000.85, 9, 8},
[10]={369.38, -6.32, 1000.85, 9, 9},
[12]={369.38, -6.32, 1000.85, 9, 10},
[13]={369.38, -6.32, 1000.85, 9, 11},
[14]={369.38, -6.32, 1000.85, 9, 12}
}

local localPlayer = getLocalPlayer()

function createcluckinWindow ()

cluckinWindow = guiCreateWindow(565,216,312,467,"CSG ~ Cluckin' Bell",false)
image1 = guiCreateStaticImage(24,28,98,92,"images/cluckin1.png",false,cluckinWindow)
image2 = guiCreateStaticImage(24,115,101,108,"images/cluckin2.png",false,cluckinWindow)
image3 = guiCreateStaticImage(24,217,104,117,"images/cluckin3.png",false,cluckinWindow)
image4 = guiCreateStaticImage(35,339,75,79,"images/sprunk.png",false,cluckinWindow)
buySmall = guiCreateButton(156,70,127,34,"Small Menu ($ 10)",false,cluckinWindow)
buySprunk = guiCreateButton(156,373,127,34,"Sprunk ($ 7)",false,cluckinWindow)
buyBig = guiCreateButton(156,268,127,34,"Big Menu ($ 30)",false,cluckinWindow)
buyMedium = guiCreateButton(156,162,127,34,"Medium Menu ($ 20)",false,cluckinWindow)
closeWindow = guiCreateButton(24,425,264,34,"Close window",false,cluckinWindow)


local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(cluckinWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(cluckinWindow,x,y,false)

guiWindowSetMovable (cluckinWindow, true)
guiWindowSetSizable (cluckinWindow, false)
guiSetVisible (cluckinWindow, false)

addEventHandler("onClientGUIClick", closeWindow, function() guiSetVisible(cluckinWindow, false) showCursor(false,false) end, false)

addEventHandler ( "onClientGUIClick", buySmall, cluckinSmall, false )
addEventHandler ( "onClientGUIClick", buyMedium, cluckinMedium, false )
addEventHandler ( "onClientGUIClick", buyBig, cluckinBig, false )
addEventHandler ( "onClientGUIClick", buySprunk, cluckinSprunk, false )

end

function cluckinHide()
	if guiGetVisible(cluckinWindow) then
		guiSetVisible(cluckinWindow, false) showCursor(false,false)
	end
end

function cluckinSmall ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(cluckinWindow, false) return end
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

function cluckinMedium ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(cluckinWindow, false) return end
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

function cluckinBig ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(cluckinWindow, false) return end
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

function cluckinSprunk ()
 if getElementDimension(localPlayer) == 0 and not isPedInVehicle(localPlayer) then guiSetVisible(cluckinWindow, false) return end
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
		createcluckinWindow()
	end
)

function cluckinMarkerHit( hitElement, matchingDimension )
	if matchingDimension then
		if hitElement == localPlayer then
			guiSetVisible(cluckinWindow,true)
			showCursor(true,true)
		end
	end
end


for ID in pairs(cluckinMarkers) do

local x, y, z = cluckinMarkers[ID][1], cluckinMarkers[ID][2], cluckinMarkers[ID][3]

local interior = cluckinMarkers[ID][4]
local dimension = cluckinMarkers[ID][5]

local cluckinWalk = createMarker(x,y,z,"cylinder",1.5, 255, 193, 37, 170)

setElementInterior(cluckinWalk , interior)
setElementDimension (cluckinWalk , dimension )

addEventHandler("onClientMarkerHit", cluckinWalk, cluckinMarkerHit)

end
