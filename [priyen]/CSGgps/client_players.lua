

function openPlayersGUI()

	if not gps_players then

		gps_players = guiCreateWindow(352,177,397,459,"CSG ~ GPS System - Players",false)
		--gps_players_grid = guiCreateGridList(9,26,374,369,false,gps_players)
		fillPlayerGrid()
		gps_players_label_name = guiCreateLabel(96,410,209,35,"Click a player",false,gps_players)
		guiLabelSetVerticalAlign ( gps_players_label_name, "center" )
		guiLabelSetHorizontalAlign ( gps_players_label_name, "center" )
		gps_players_button_cancel = guiCreateButton(22,412,60,34,"Cancel",false,gps_players)
		gps_players_button_ok = guiCreateButton(316,412,60,34,"OK",false,gps_players)
		showCursor(true)
		centerWindow( gps_players )
		addEventHandler ( "onClientGUIClick", root, playersButtons )
		
	else

		if guiGetVisible ( gps_players ) then
		
			centerWindow( gps_players )
			showCursor(true)

		else

			guiSetVisible ( gps_players, true )
			showCursor(true)
			addEventHandler ( "onClientGUIClick", root, playersButtons )
			fillPlayerGrid()
			
		end

	end	

end

function fillPlayerGrid()
if isElement ( gps_players_grid ) then destroyElement( gps_players_grid ) end
gps_players_grid = guiCreateGridList(9,26,374,369,false,gps_players)
guiGridListSetSelectionMode(gps_players_grid,2)
local players = getElementsByType ( "player" )
playerColumn = guiGridListAddColumn ( gps_players_grid, "Players", 0.45 )
statusColumn = guiGridListAddColumn ( gps_players_grid, "Status", 0.45 )
 	for i, player in ipairs(players) do
	
		if player ~= localPlayer then
		
			local row = guiGridListAddRow ( gps_players_grid )
			guiGridListSetItemText ( gps_players_grid, row, playerColumn, getPlayerName(player), false, false )
			if not isPedDead ( player ) then
				
				if getElementInterior(player) ~= 0 then
				
					guiGridListSetItemText ( gps_players_grid, row, statusColumn, "In Interior", false, false )
					
				else

					guiGridListSetItemText ( gps_players_grid, row, statusColumn, "Outside", false, false )				
					
				end

			else

				guiGridListSetItemText ( gps_players_grid, row, statusColumn, "Dead", false, false )
				
			end	
			
		end
		
	end

end

function closePlayersGUI()

	if isElement ( gps_players ) then
		guiSetVisible ( gps_players, false )
	end	
	showCursor(false)
	removeEventHandler ( "onClientGUIClick", root, playersButtons )

end

function playersButtons()

	if source == gps_players_button_cancel then
	
		closePlayersGUI()
		return
		
	elseif source == gps_players_button_ok then

		pickPlayer()
		return
		
	elseif source == gps_players_grid then

		if guiGridListGetSelectedItem( gps_players_grid ) then
	
			local row, column = guiGridListGetSelectedItem( gps_players_grid )
		
			if getPlayerFromName ( guiGridListGetItemText ( gps_players_grid, row, column ) ) then
			
				guiSetText ( gps_players_label_name, guiGridListGetItemText ( gps_players_grid, row, column ) )
				
			end

		end	
		
	end	

end

function pickPlayer()

	if getPlayerFromName ( guiGetText ( gps_players_label_name ) ) then
	
		if getPlayerGridPosition (guiGetText ( gps_players_label_name )) then
		
			local playerPos = getPlayerGridPosition (guiGetText ( gps_players_label_name ))
			local playerStatus = guiGridListGetItemText ( gps_players_grid, playerPos, statusColumn )
		
			if playerStatus == "Outside" then
				
				local player = getPlayerFromName ( guiGetText ( gps_players_label_name ) )
		
				local x,y,z = getElementPosition ( player )
			
				setDestination ( x, y, z, guiGetText ( gps_players_label_name ) )
			
				setElementData ( localPlayer, "GPS_playerTarget", player )
				closePlayersGUI()
				return
				
			else
				
				local message = nil
				if playerStatus == "Dead" then
				
					message = "This player is dead!"
					
				elseif playerStatus == "In Interior" then
				
					message = "This player is in a interior!"
					
				end

				exports.DENhelp:createNewHelpMessage(message, 255, 0, 0)
			
				return
			
			end
			
		end	
		
	else
		
		local message = "Please select a player!" 
		
		exports.DENhelp:createNewHelpMessage(message, 255, 0, 0)
			
	end

end

function getPlayerGridPosition (thePlayerName)

	local rowCount = guiGridListGetRowCount ( gps_players_grid )
	
		for i=0, rowCount do
		
			if guiGridListGetItemText ( gps_players_grid, i, playerColumn )
			and guiGridListGetItemText ( gps_players_grid, i, playerColumn ) == thePlayerName then
			
				return i
				
			end

		end	

end

function isPedDead ( ped ) 

	if not ({ped=true,player=true})[getElementType(ped)] then
	
		error ( "use ped element u bastid", 2 ) 
		
	end 
	
	return getElementHealth ( ped ) == 0 
 
 end