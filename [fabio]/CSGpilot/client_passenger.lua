addEvent ( "airport_c_buyTicket", true )
function ticketGUI ()

	if not airport_window_ticket then

		showCursor(true)
		createTicketGUI()
		addEventHandler ( "onClientGUIClick", root, airportButtons )

	elseif airport_window_ticket then

		if guiGetVisible(airport_window_ticket) then
	
			showCursor(false)

			destroyElement ( airport_window_ticket )
			
			airport_window_ticket = nil
			
			removeEventHandler ( "onClientGUIClick", root, airportButtons )

		end

	end	

end

addEventHandler ( "airport_c_buyTicket", root, ticketGUI )

addCommandHandler ( "testPilotGUI", ticketGUI )

function airportButtons (btn, state, screenX, screenY)

	if source == airport_button_buy_ticket then
	
		if destinationCoords then
			
			local px, py, pz = getElementPosition ( localPlayer )
			local price = math.floor( 50+ ( getDistanceBetweenPoints2D ( px, py, destinationCoords[1], destinationCoords[2] ) / 4 ) )
			
			triggerServerEvent ( "airport_s_buyTicket", localPlayer, true, price, destinationCoords )
		
		end			
		
	elseif source == airport_button_close_screen then
	
		ticketGUI()
		
	elseif source == airport_map or ( isElement ( mapDestinationBlip ) and source == mapDestinationBlip ) then
	
		local windowStartX, windowStartY = guiGetPosition ( airport_window_ticket, false )
		local mapStartX, mapStartY = guiGetPosition ( airport_map, false )
		local mapSizeWidth, mapSizeHeight = guiGetSize ( airport_map, false )
		
		
		local mapStartX, mapStartY = windowStartX + mapStartX, windowStartY + mapStartY
		local mapEndX, mapEndY = mapStartX + mapSizeWidth, mapStartY + mapSizeHeight
		
		local relX, relY = (screenX-mapStartX)/mapSizeWidth, (screenY-mapStartY)/mapSizeHeight
		local worldX, worldY = (relX*6000)-3000, 3000-(relY*6000)
		
		if worldX > -3000 and worldX < 3000 and worldY > -3000 and worldY < 6000 then
		
			destinationCoords = { worldX, worldY }
			guiSetEnabled ( airport_button_buy_ticket, true )
			local px, py, pz = getElementPosition ( localPlayer )
			local price = math.floor( 50+ ( getDistanceBetweenPoints2D ( px, py, destinationCoords[1], destinationCoords[2] ) / 4 ) )
			guiSetText ( airport_button_buy_ticket, "Buy Ticket \n $".. price )
			local blipX, blipY = (relX+0.015)*mapSizeWidth, (relY+0.06)*mapSizeHeight
			
			if isElement ( mapDestinationBlip ) then 
			
				destroyElement ( mapDestinationBlip )
			
			end
			
			mapDestinationBlip = guiCreateStaticImage ( blipX-10,blipY-10, 20, 20, "targetBlip.png", false, airport_window_ticket )

		end
		
	end	

end

function createTicketGUI()
	
	airport_window_ticket = guiCreateWindow(0.2676,0.1992,0.6631,0.7526,"CSG ~ Buy ticket",true)
	
	airport_button_buy_ticket = guiCreateButton(0.0412,0.9187,0.1797,0.0606,"Buy Ticket",true,airport_window_ticket)
	guiSetEnabled ( airport_button_buy_ticket, false )
	
	airport_map = guiCreateStaticImage(0.01,0.05,0.97,0.85,"map.png",true,airport_window_ticket)
	
	airport_button_close_screen = guiCreateButton(0.2415,0.9187,0.1797,0.0606,"Close",true,airport_window_ticket)
	
	airport_label_help = guiCreateLabel(0.4315,0.9204,0.5508,0.0536,"Click on the map to show where you want to go.",true,airport_window_ticket)
	guiLabelSetVerticalAlign ( airport_label_help, "center" )
	guiLabelSetHorizontalAlign ( airport_label_help, "center", true )

end

addEvent ( "airport_c_onStartFlight", true )

function onStartFlight( plane )

	local pilot = source
	currentPlane = plane
	local planeID = getElementModel ( plane )
	local planeType = getVehicleType ( plane )
	if planeID ~= 511 and planeType ~= "Helicopter" then
	
		unbindKey ( "enter_exit", "down", exitPlaneInterior )
		
	else

		addEventHandler ( "onClientVehicleExit", plane, onExitPlane, false )
		
	end
	addCommandHandler ( "air", airChat )

end

addEventHandler ( "airport_c_onStartFlight", root, onStartFlight )

addEvent ( "airport_c_exitTransporter", true )

function exitCurrentTransporter ()

	local planeID = getElementModel ( currentPlane )
	local planeType = getVehicleType ( currentPlane )
	if planeID ~= 511 and planeType ~= "Helicopter" then
	
		exitPlaneInterior()
		
	else

		onExitPlane(thePlayer)
		
	end

end

addEventHandler ( "airport_c_exitTransporter", root, exitCurrentTransporter )

function exitPlaneInterior()

	unbindKey ( "enter_exit", "down", exitPlaneInterior )
	setElementInterior ( localPlayer, 0 )
	local pilot = getElementData ( localPlayer, "airport_pilot" )
	local pilotX, pilotY, pilotZ = getElementPosition ( pilot )
	setElementPosition ( localPlayer, pilotX, pilotY, pilotZ - 3 )
	onExitPlane(thePlayer)
	
end

function onExitPlane(thePlayer)

	if thePlayer == localPlayer then
	
		removeEventHandler ( "onClientVehicleExit", currentPlane, onExitPlane, false )
	
	end
	
	currentPlane = nil
	removeCommandHandler ( "air", airChat )

end


function airChat(commandName, ...)

local arg = {...}
local allMessages = tostring( table.concat( arg, " " ) )

	if allMessages then
	
		if getElementData(localPlayer, "airport_destination" ) ~= nil then
		
			local veh = getElementData ( localPlayer, "planeToEnter" )
			local pilot = nil
			local passengers = nil
				if getVehicleOccupant ( veh, 0 ) then
					pilot = getVehicleOccupant ( veh, 0 )
					passengers = getElementData ( pilot, "airport_pilot_passengers" )
					
						if passengers then

							triggerServerEvent ( "airport_s_chat", localPlayer, allMessages, pilot, passengers )
							
						end

				end

		end

	end	

end
