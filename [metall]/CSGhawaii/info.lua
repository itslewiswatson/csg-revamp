
local infomarker = createMarker(0, 0, 0, "cylinder", 1.5, 30, 230, 10, 150)

window = guiCreateWindow(170, 60, 496, 456, "Hawaii info", false)
memo = guiCreateMemo(14, 22, 467, 407, "Updated soon.", false, window)
button = guiCreateButton(14, 433, 471, 14, "Close", false, window)

guiWindowSetSizable(window, false)
guiSetVisible(window, false)
guiMemoSetReadOnly(memo, true)

function close()
	guiSetVisible(window, false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", button, close)

function open( hitElement, player ) 
    if getElementType(hitElement) == "player" and (hitElement == localPlayer) then
    if not guiGetVisible(window) then	
        guiSetVisible( window, true )
		showCursor( true, true )	
        end
    end
end
addEventHandler("onClientMarkerHit", infomarker, open)

-- The peds for Fatal's party.

--[[local ped1 = createPed(85, 2734.1, -1747.42, 44.32)
setPedAnimation(ped1, "STRIP", "strip_D")

local ped2 = createPed(85, 2737.36, -1751.39, 44.32)
setPedAnimation(ped2, "STRIP", "strip_A")

local ped3 = createPed(85, 2740.22, -1744.55, 44.23)
setPedAnimation(ped3, "STRIP", "strip_C")--]]
