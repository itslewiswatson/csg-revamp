local donutMarkers = {
[1]={379.21, -190.64, 999.65, 17, 1},
--[2]={377.14, -67.83, 1000.51, 17, 2},
--[3]={377.14, -67.83, 1000.51, 17, 3}
}

local localPlayer = getLocalPlayer()

function createdonutWindow ()

donutWindow = guiCreateWindow(572,210,297,384,"Community of Social Gaming ~ Donut store",false)
donutImage = guiCreateStaticImage(28,26,243,264,"images/donut.png",false,donutWindow)
donutBuy = guiCreateButton(26,294,244,25,"Buy a donut ($20) (10HP)",false,donutWindow)
donutSprunk = guiCreateButton(26,322,244,25,"Buy a sprunk ($7) (3HP)",false,donutWindow)
donutClose = guiCreateButton(26,351,244,24,"Close window",false,donutWindow)


local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(donutWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(donutWindow,x,y,false)

guiWindowSetMovable (donutWindow, true)
guiWindowSetSizable (donutWindow, false)
guiSetVisible (donutWindow, false)

addEventHandler ( "onClientGUIClick", donutBuy, buyDonut, false )
addEventHandler ( "onClientGUIClick", donutSprunk, donutSprunkBuy, false )

addEventHandler("onClientGUIClick", donutClose, function() guiSetVisible(donutWindow, false) showCursor(false,false) end, false)

end

function buyDonut ()
local playerMoney = getPlayerMoney ( localPlayer )
local playerHealth = getElementHealth (localPlayer)
if playerHealth > 199 then
outputChatBox ("You have already full health!", 225, 0,0)
elseif playerMoney < 20 then
outputChatBox ("You don't have enough money to buy this.", 225, 0,0)
else
	triggerServerEvent("buyDonut", getLocalPlayer())
end
end

function donutSprunkBuy ()
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
		createdonutWindow()
	end
)

function donutMarkerHit( hitElement, matchingDimension )
	if matchingDimension then
		if hitElement == localPlayer then
			guiSetVisible(donutWindow,true)
			showCursor(true,true)
		end
	end
end

for ID in pairs(donutMarkers) do

local x, y, z = donutMarkers[ID][1], donutMarkers[ID][2], donutMarkers[ID][3]
local interior = donutMarkers[ID][4]
local dimension = donutMarkers[ID][5]

local donutWalk = createMarker(x,y,z,"cylinder",1.4, 156, 102, 31, 225)

setElementInterior(donutWalk , interior)
setElementDimension (donutWalk , dimension)


addEventHandler("onClientMarkerHit", donutWalk, donutMarkerHit)

end
