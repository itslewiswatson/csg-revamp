
local tire = 0
local tireMarker1 = createMarker(2068.611328125, -1883.1304931641, 12.5, "cylinder", 1.5, 60, 60, 60, 255)
local tireMarker2 = createMarker(1016, -1029.5, 30.9, "cylinder", 1.5, 60, 60, 60, 255)
local tireMarker3 = createMarker(1964, 2150.8, 9.8, "cylinder", 1.5, 60, 60, 60, 255)
local tireMarker4 = createMarker(-1910.4847412109, 286.6, 40, "cylinder", 1.5, 60, 60, 60, 255)
local tireob1 = createObject(1096, 2068.611328125, -1883.1304931641, 13.5, 0, 0, 50)
local tireob2 = createObject(1096, 1016, -1029.5, 32, 0, 0, 260)
local tireob3 = createObject(1096, 1964, 2150.8, 11, 0, 0, 180)
local tireob4 = createObject(1096, -1910.4847412109, 286.6, 41, 0, 0, 180)



function tires()
tirewin = guiCreateWindow(400, 350, 360, 110, "CSG~tireWheels", false)
guiWindowSetSizable(tirewin, false)
guiSetAlpha(tirewin, 0.70)
guiSetVisible( tirewin, false )
button6689 = guiCreateButton(45, 79, 49, 42, "Buy", false, tirewin)
button7789 = guiCreateButton(245, 79, 49, 42, "Close", false, tirewin)
txt = guiCreateLabel(0.1300,0.2500,0.9000,0.20,"You can buy 4 tires for 30$ per 1 tire",true,tirewin)
txt2 = guiCreateLabel(0.1300,0.4500,0.9000,0.20,"You can use /tire to change your car tires if your near it",true,tirewin)
guiSetFont(button6689, "default-bold-small")
guiSetProperty(button6689, "NormalTextColour", "FF1727BB")

   end
addEventHandler("onClientResourceStart", resourceRoot, tires)


addEventHandler ( "onClientGUIClick", root,
	function ( )

		player=localPlayer
		if ( source == button6689 ) then
                if (tire >= 0) and (tire < 4) then
				local tiresmoney = getPlayerMoney(player)
               	if (tiresmoney > 30) then
				triggerServerEvent("givetiremoney", player)
			    tire = tire + 1
				guiSetText(txt2,"Type /tire to use it. You have "..tire.." tire")
				exports.dendxmsg:createNewDxMessage("You bought 1 tire", 0, 255, 0)
				else
				exports.dendxmsg:createNewDxMessage("You don't have enough money to buy more tires", 255, 0, 0)
				end
				if (tire == 4) then
					exports.dendxmsg:createNewDxMessage("You have 4 tire for wheels. /tire to change tires", 255, 255, 0)
					guiSetVisible( tirewin, false )
	                showCursor ( false )

end
		end
		end

		end )

addEventHandler ( "onClientGUIClick", root,
	function ()
		if ( source == button7789 ) then
					guiSetVisible( tirewin, false )
	                showCursor ( false )
		end


		end )

function tiress(p)
if p ~= localPlayer then return end
  local mx,my,mz = getElementPosition(source) -- marker
        local hx,hy,hz = getElementPosition(p) -- hitelement ( player/vehicle etc. )
        if hz < mz+2 then 
guiSetVisible( tirewin, true )
	showCursor ( true )
	guiSetText(txt2,"Type /tire to change wheels tire. You have "..tire.." tires")
end
end
addEventHandler("onClientMarkerHit", tireMarker1, tiress)
addEventHandler("onClientMarkerHit", tireMarker2, tiress)
addEventHandler("onClientMarkerHit", tireMarker3, tiress)
addEventHandler("onClientMarkerHit", tireMarker4, tiress)



function usetire(player)
player = getLocalPlayer()
if (tire > 0) then
	if getPlayerWantedLevel() > 0 then
		exports.dendxmsg:createNewDxMessage("You can't use a tire while wanted", 255, 0, 0)

		return
	end
if isPedInVehicle(localPlayer) then
	exports.dendxmsg:createNewDxMessage("You can't use a tire while inside a vehicle, go outside and stand near it.", 255, 100, 0)

	return
end
tire = tire - 1
exports.dendxmsg:createNewDxMessage("Used a tire, "..tire.." Wheels tire left ", 255, 100, 0)
triggerServerEvent("usedTW",localPlayer)
triggerServerEvent("tireN",localPlayer)
elseif (tire == 0) then
tire = 0
exports.dendxmsg:createNewDxMessage("You don't have more tires", 90, 0, 200)
end
end
addCommandHandler("tire", usetire)

addEvent("recTW",true)
addEventHandler("recTW",localPlayer,function(k)
	tire=k
	if tire < 0 then tire = 0 end
end)
