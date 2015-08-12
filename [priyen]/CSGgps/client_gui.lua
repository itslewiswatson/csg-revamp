function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

function GPSGUI()

	if gps_window then

		if guiGetVisible ( gps_window ) then

			guiSetVisible ( gps_window, false )

			showCursor(false)

			closeMap()

			removeEventHandler ( "onClientGUIClick", root, gpsButtons )

		else

			guiSetVisible ( gps_window, true )

			showCursor(true)

			addEventHandler ( "onClientGUIClick", root, gpsButtons )

			centerWindow( gps_window )

			local message = "None"
			if hasDestination == true then
				local x,y,z,desc = getDestination()
				message = desc
			end

			guiSetText(gps_label_destination, "Destination: " .. message )

		end

	else

		gps_window = guiCreateWindow(411,265,245,290,"CSG ~ GPS System",false)
		local message = "None"
			if hasDestination == true then
				local x,y,z,desc = getDestination()
				message = desc
			end
		cbHUD = guiCreateCheckBox(13,169,200,34,"Show GPS HUD",true,false,gps_window)
		cbVehArrow = guiCreateCheckBox(13,194,200,34,"Show Vehicle Arrow",true,false,gps_window)
		cbRoadArrows = guiCreateCheckBox(13,219,200,34,"Show Road Arrows",true,false,gps_window)
		cbVoice = guiCreateCheckBox(13,244,200,34,"Voice Guidance (w/ Turns)",true,false,gps_window)
		gps_label_destination = guiCreateLabel(9,21,227,34,"Destination: " .. message,false,gps_window)
		guiLabelSetVerticalAlign ( gps_label_destination, "center" )
		guiLabelSetHorizontalAlign ( gps_label_destination, "center" )
		gps_button_reset = guiCreateButton(13,63,68,36,"Reset",false,gps_window)
		gps_button_map = guiCreateButton(157,63,68,36,"Map",false,gps_window)
		gps_button_players = guiCreateButton(158,121,68,36,"Players",false,gps_window)
		gps_button_close = guiCreateButton(13,121,68,36,"Close",false,gps_window)
		addEventHandler ( "onClientGUIClick", root, gpsButtons )
		showCursor(true)
		centerWindow( gps_window )

	end

end

addCommandHandler ( 'gps', GPSGUI )

function gpsButtons ()

	if source == gps_button_close then

		GPSGUI()

	elseif source == gps_button_reset then

		resetDestination()

	elseif source == gps_button_map then

		GPSGUI()

		showMap()

	elseif source == gps_button_players then

		GPSGUI()

		openPlayersGUI()
	elseif source == cbRoadArrows then
		if hasDestination == true then
			if guiCheckBoxGetSelected(cbRoadArrows) == true then
				sendGpsReq("",dx,dy,dz)
			else
				endGps()
			end
		end
	elseif source == cbVehArrow then
		if hasDestination == true then
			if guiCheckBoxGetSelected(cbVehArrow) == true then
				toDrawVehArrow = true
			else
				toDrawVehArrow = false
			end
		end
	end

end


GPSGUI()
GPSGUI()
