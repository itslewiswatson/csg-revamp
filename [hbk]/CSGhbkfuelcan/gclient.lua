
local gscc = 0
local gsccMarker1 = createMarker(1930.9294433594, -1776.9, 12.5, "cylinder", 1.5, 255, 100, 0, 255)
local gsccMarker2 = createMarker(1006, -930.46, 41, "cylinder", 1.5, 255, 100, 0, 255)
local gsccMarker3 = createMarker(661, -569, 15, "cylinder", 1.5, 255, 100, 0, 255)
local gsccMarker4 = createMarker(1385.8944091797, 463, 19, "cylinder", 1.5, 255, 100, 0, 255)
local gsccMarker5 = createMarker(2120.95, 898.49, 10, "cylinder", 1.5, 255, 100, 0, 255)
local gsccMarker6 = createMarker(2188.84, 2468.9, 10, "cylinder", 1.5, 255, 100, 0, 255)
local gsccMarker7 = createMarker(60.339897155762, 1214, 18, "cylinder", 1.5, 255, 100, 0, 255)
local gsccMarker8 = createMarker(-1458.1853027344, 1872.67, 31.5, "cylinder", 1.5, 255, 100, 0, 255)
local gsccMarker9 = createMarker(-2419.2963867188, 970, 44, "cylinder", 1.5, 255, 100, 0, 255)
local gsccMarker10 = createMarker(-1694, 413, 6, "cylinder", 1.5, 255, 100, 0, 255)




local gsccob1 = createObject(1010, 1930.9294433594, -1776.9, 13, 0, 90, 0)
local gsccob2 = createObject(1010, 1006, -930.46, 42, 0, 90, 0)
local gsccob3 = createObject(1010, 661, -569, 16, 0, 90, 0)
local gsccob4 = createObject(1010, 1385.8944091797, 463, 20, 0, 90, 0)
local gsccob5 = createObject(1010, 2120.95, 898.49, 11, 0, 90, 0)
local gsccob6 = createObject(1010, 2188.84, 2468.9, 11, 0, 90, 0)
local gsccob7 = createObject(1010, 60.339897155762, 1214, 19, 0, 90, 0)
local gsccob8 = createObject(1010, -1458.1853027344, 1872.67, 32.5, 0, 90, 0)
local gsccob9 = createObject(1010, -2419.2963867188, 970, 45, 0, 90, 0)
local gsccob10 = createObject(1010, -1694, 413, 7, 0, 90, 0)



function gsccs()
gsccwin = guiCreateWindow(400, 350, 380, 110, "CSG~Fuel canisters", false)
guiWindowSetSizable(gsccwin, false)
guiSetAlpha(gsccwin, 0.70)
guiSetVisible( gsccwin, false )
button66689 = guiCreateButton(45, 79, 49, 42, "Buy", false, gsccwin)
button77789 = guiCreateButton(245, 79, 49, 42, "Close", false, gsccwin)
txt = guiCreateLabel(0.1300,0.2500,0.9000,0.20,"You can buy 3 Fuel canisters for 100$ per 1 Fuel canisters",true,gsccwin)
txt2 = guiCreateLabel(0.1300,0.4500,0.9000,0.20,"You can use /gsc to refuel your car if your near it",true,gsccwin)
guiSetFont(button66689, "default-bold-small")
guiSetProperty(button66689, "NormalTextColour", "FF1727BB")

   end
addEventHandler("onClientResourceStart", resourceRoot, gsccs)


addEventHandler ( "onClientGUIClick", root,
	function ( )

		player=localPlayer
		if ( source == button66689 ) then
                if (gscc >= 0) and (gscc < 3) then
				local fuelcmoney = getPlayerMoney(player)
               	if (fuelcmoney > 100) then
				triggerServerEvent("givegasconsmoney", player)
			    gscc = gscc + 1
				guiSetText(txt2,"Type /gsc to use it. You have "..gscc.." Fuel canisters")
				exports.dendxmsg:createNewDxMessage("You bought 1 Fuel canisters", 0, 255, 0)
				else
				exports.dendxmsg:createNewDxMessage("You don't have enough money to buy more Fuel canisters", 255, 0, 0)
				end
				if (gscc ==3) then
					exports.dendxmsg:createNewDxMessage("You have 3 Fuel canisters. /gsc to use Fuel canisters", 255, 255, 0)
					guiSetVisible( gsccwin, false )
	                showCursor ( false )

end
		end
		end

		end )

addEventHandler ( "onClientGUIClick", root,
	function ()
		if ( source == button77789 ) then
					guiSetVisible( gsccwin, false )
	                showCursor ( false )
		end


		end )

function gsccss(p)
if p ~= localPlayer then return end
  local mx,my,mz = getElementPosition(source) -- marker
        local hx,hy,hz = getElementPosition(p) -- hitelement ( player/vehicle etc. )
        if hz < mz+2 then 
guiSetVisible( gsccwin, true )
	showCursor ( true )
	guiSetText(txt2,"Type /gsc to use Fuel canisters. You have "..gscc.." Fuel canisters")
end
end
addEventHandler("onClientMarkerHit", gsccMarker1, gsccss)
addEventHandler("onClientMarkerHit", gsccMarker2, gsccss)
addEventHandler("onClientMarkerHit", gsccMarker3, gsccss)
addEventHandler("onClientMarkerHit", gsccMarker4, gsccss)
addEventHandler("onClientMarkerHit", gsccMarker5, gsccss)
addEventHandler("onClientMarkerHit", gsccMarker6, gsccss)
addEventHandler("onClientMarkerHit", gsccMarker7, gsccss)
addEventHandler("onClientMarkerHit", gsccMarker8, gsccss)
addEventHandler("onClientMarkerHit", gsccMarker9, gsccss)
addEventHandler("onClientMarkerHit", gsccMarker10, gsccss)



function usegscc(player)

player = getLocalPlayer()
if (gscc > 0) then
if isPedInVehicle(localPlayer) then
	exports.dendxmsg:createNewDxMessage("You can't use a fuel can while inside a vehicle, go outside and stand near it.", 255, 100, 0)

	return
end
gscc = gscc - 1

exports.dendxmsg:createNewDxMessage("Used Fuel canisters, "..gscc.." Fuel canisters left ", 255, 100, 0)
triggerServerEvent("usedgsc",localPlayer)
triggerServerEvent("gasconsN",localPlayer)
elseif (gscc == 0) then
gscc = 0
exports.dendxmsg:createNewDxMessage("You don't have more Fuel canisters", 90, 0, 200)
end
end
addCommandHandler("gsc", usegscc)

addEvent("recgsc",true)
addEventHandler("recgsc",localPlayer,function(k)
	gscc=k
	if gscc < 0 then gscc = 0 end
end)
