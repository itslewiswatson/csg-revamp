
addEventHandler("onClientResourceStart",resourceRoot,

   function()
        Passenger_window = guiCreateWindow(382, 245, 283, 264, "CSG~Taxi computer", false)
        guiWindowSetSizable(Passenger_window, false)
        guiSetAlpha(Passenger_window, 1.00)
        ride = guiCreateButton(91, 154, 95, 47, "Taxi", false, Passenger_window)
		guiSetFont(ride, "sa-header")
        guiSetProperty(ride, "NormalTextColour", "FFE4CE18")
		close = guiCreateButton(91, 207, 95, 47, "Cancel", false, Passenger_window)
		guiSetFont(close, "default-bold-small")
        guiSetProperty(close, "NormalTextColour", "FFFC0000")
		Taxiimg = guiCreateStaticImage(0.150,0.0909,0.6635,0.3329,"taxi.png",true,Passenger_window)
		guiSetVisible(Passenger_window, false)
    end
)




    function openwindow (playerSource)
		if getElementModel (localPlayer) == 20 and getElementData(localPlayer,"Occupation") == "Taxi Driver" and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
			guiSetVisible(Passenger_window, true)
			showCursor(true)
		end
	end
	bindKey("F5", "down", openwindow)
	--addCommandHandler("taxihbk",openwindow)

function ride (state)
 if state == "left" then
  if source == ride then
   guiSetVisible(Passenger_window, false)
   thePlayer = getLocalPlayer()
   showCursor(false)
    triggerServerEvent("ride", localPlayer)
  end
 end
end
addEventHandler("onClientGUIClick", getRootElement(), ride)

function close (state)
 if state == "left" then
  if source == close then
   guiSetVisible(Passenger_window, false)
   thePlayer = getLocalPlayer()
   showCursor(false)
    triggerServerEvent("close", localPlayer)
  end
 end
end
addEventHandler("onClientGUIClick", getRootElement(), close)

local screenWidth, screenHeight = guiGetScreenSize()
serviceLightOn=false
serviceStatus="Off"
function createText()
	--if serviceLightOn==true then

			exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Service: #33FF33"..serviceStatus.."", screenWidth*0.09, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )
			exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Service: #33FF33"..serviceStatus.."", screenWidth*0.09, screenHeight*0.95, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )

	--end
end

function togLight(state)
	serviceLightOn=state
	if state==true then
		serviceStatus="On"
	else
		serviceStatus="Off"
	end
end
addEvent("CSGtaxi.togLight",true)
addEventHandler("CSGtaxi.togLight",localPlayer,togLight)

addEventHandler("onClientVehicleEnter",root,function(p)
	if p ~= localPlayer then return end
	local v = source
	if getElementModel(v) == 420 or getElementModel(v) == 438 then
		if getVehicleController(v) == localPlayer then
			--if serviceLightOn==true then
				addEventHandler("onClientRender",root,createText)
			--end
		end
	end
end)

addEventHandler("onClientVehicleExit",root,function(p)
	if p ~= localPlayer then return end
	serviceLightOn=false
	removeEventHandler("onClientRender",root,createText)
end)
