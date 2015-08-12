local marker1 = createMarker (1571.17, -1337.09, 17.48, "arrow", 2, 255, 0, 0)
local marker2 = createMarker (1548.63, -1364.68, 327.21, "arrow", 2, 255, 0, 0)
local marker3 = createMarker (1554.02, -1367.24, 328.45, "cylinder", 2, 255, 0, 0)

function enter(p)
	if p ~= localPlayer then return end
    if not ( getPedOccupiedVehicle (localPlayer) ) then
	        triggerServerEvent ("warpIn", getLocalPlayer())

    end
end
addEventHandler ("onClientMarkerHit", marker1, enter)

function out(p)
	if p ~= localPlayer then return end
    if not ( getPedOccupiedVehicle (localPlayer) ) then
	        triggerServerEvent ("warpOut", getLocalPlayer())

    end
end
addEventHandler ("onClientMarkerHit", marker2, out)

window = guiCreateWindow(343,261,347,178,"CSG ~ Parachute",false)
buyBtn = guiCreateButton(11,71,156,91,"Buy ($500)",false,window)
closeBtn = guiCreateButton(179,71,156,91,"Close",false,window)
info = guiCreateLabel(9,31,332,21,"Buy a parachute and have some fun by jumping off the roof",false,window)

guiSetVisible (window, false)
guiWindowSetSizable (window, false)

function close()
    guiSetVisible (window, false)
	showCursor (false, false)
end
addEventHandler ("onClientGUIClick", closeBtn, close, false)

function show(p)
	if p ~= localPlayer then return end
    guiSetVisible (window, true)
	showCursor (true, true)
end
addEventHandler ("onClientMarkerHit", marker3, show, false)

function buy()
local cash = getPlayerMoney (localPlayer)
    if cash < 500 then
	    outputChatBox ("You need more money to buy a parachute", 255, 0, 0)
	else
	    triggerServerEvent ("buyPara", getLocalPlayer())
            guiSetVisible (window, false)
            showCursor (false, false)
	end
end
addEventHandler ("onClientGUIClick", buyBtn, buy, false)
