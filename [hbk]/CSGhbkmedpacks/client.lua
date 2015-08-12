
local kit = 0
local kitMarker1 = createMarker(1182, -1331.1304931641, 12.5, "cylinder", 1.5, 90, 0, 200)
local kitMarker2 = createMarker(2040, -1425.4390869141, 16, "cylinder", 1.5, 90, 0, 200)
local kitMarker3 = createMarker(1591.66015625, 1818, 9.5, "cylinder", 1.5, 90, 0, 200)
local kitMarker4 = createMarker(1259.9964599609, 327, 18.5, "cylinder", 1.5, 90, 0, 200)
local kitMarker5 = createMarker(-325.95867919922, 1052, 19, "cylinder", 1.5, 90, 0, 200)
local kitMarker6 = createMarker(-2675.2497558594, 631, 13.3, "cylinder", 1.5, 90, 0, 200)
local kitMarker7 = createMarker(-2193, -2306.4069824219, 29.3, "cylinder", 1.5, 90, 0, 200)
local antiSpamTimer

function Kit()
medwin = guiCreateWindow(400, 250, 350, 250, "CSG~MedicKit", false)
guiWindowSetSizable(medwin, false)
guiSetAlpha(medwin, 0.700)
guiSetVisible( medwin, false )
button66 = guiCreateButton(45, 150, 49, 42, "Buy", false, medwin)
button77 = guiCreateButton(245, 150, 49, 42, "Close", false, medwin)
txt = guiCreateLabel(0.1300,0.2500,0.9000,0.20,"You can buy 10 medic kits.",true,medwin)
guiLabelSetColor(txt, 255, 255, 0)
txt3 = guiCreateLabel(0.1300,0.3500,0.9000,0.20,"Medic kits Cost $850 Each .",true,medwin)
guiLabelSetColor(txt3, 255, 0, 0)
txt2 = guiCreateLabel(0.1300,0.4500,0.9000,0.20,"to use medic kits /medkit",true,medwin)
guiLabelSetColor(txt2, 0, 255, 0)
guiSetFont(button66, "default-bold-small")
guiSetProperty(button66, "NormalTextColour", "FF1727BB")

   end
addEventHandler("onClientResourceStart", resourceRoot, Kit)


addEventHandler ( "onClientGUIClick", root,
	function ( )
		if isTimer(antiSpamTimer) then return false end
		player=localPlayer
		if ( source == button66 ) then
			if (kit >= 0) and (kit < 10) then
				local kitsmoney = getPlayerMoney(player)                                -- get the amount of money from the player who entered the command
				if (kitsmoney > 850) then
					antiSpamTimer = setTimer(function() end, 100,1)
					triggerServerEvent("givekitsmoney", player)
				else
					exports.dendxmsg:createNewDxMessage("You don't have enough money to buy more kits", 255, 0, 0)
				end
				if (kit == 10) then
					exports.dendxmsg:createNewDxMessage("You have 10 medic kits. /medkit to use kit", 255, 255, 0)
					guiSetVisible( medwin, false )
					showCursor ( false )
				end
			else
				exports.dendxmsg:createNewDxMessage("You can only carry 10 medkits, type /medkit to use a kit", 255, 255, 0)
			end
		end
	end
)

		addEvent("CSGmedkitsbought",true)
		addEventHandler("CSGmedkitsbought",localPlayer,function()
			 kit = kit + 1
			guiSetText(txt2,"Type /medkit to use it. You have "..kit.." kits")
			exports.dendxmsg:createNewDxMessage("You bought 1 Medic kit .Cost $850", 0, 255, 0)
		end)

addEventHandler ( "onClientGUIClick", root,
	function ()
		if ( source == button77 ) then
					guiSetVisible( medwin, false )
	                showCursor ( false )
		end


		end )

function medkit(p)
if p ~= localPlayer then return end
  local mx,my,mz = getElementPosition(source) -- marker
        local hx,hy,hz = getElementPosition(p) -- hitelement ( player/vehicle etc. )
        if hz < mz+2 then
guiSetVisible( medwin, true )
	showCursor ( true )
	guiSetText(txt2,"Type /medkit to use it. You have "..kit.." kits")
end
end
addEventHandler("onClientMarkerHit", kitMarker1, medkit)
addEventHandler("onClientMarkerHit", kitMarker2, medkit)
addEventHandler("onClientMarkerHit", kitMarker3, medkit)
addEventHandler("onClientMarkerHit", kitMarker4, medkit)
addEventHandler("onClientMarkerHit", kitMarker5, medkit)
addEventHandler("onClientMarkerHit", kitMarker6, medkit)
addEventHandler("onClientMarkerHit", kitMarker7, medkit)

function usemed(player)
player = getLocalPlayer()
if (kit > 0) then
kit = kit - 1
exports.dendxmsg:createNewDxMessage("Used a kit, "..kit.." Medic kits left ", 255, 100, 0)
triggerServerEvent("usedMK",localPlayer)
triggerServerEvent("usedFM",localPlayer)
setTimer ( function()
setElementHealth ( player, getElementHealth(player) + 25 )

end, 5000, 1 )
elseif (kit == 0) then
kit = 0
exports.dendxmsg:createNewDxMessage("You don't have more medic kits", 90, 0, 200)
end
end


addCommandHandler("medkit", usemed)

addEvent("recMK",true)
addEventHandler("recMK",localPlayer,function(k)
	kit=k
	if kit < 0 then kit = 0 end
end)
