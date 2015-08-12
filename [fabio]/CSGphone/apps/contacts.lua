local contactsGUI = {}
local checkCombo

function isPlayerFriend(fTable, player) 

	local pName = getPlayerName(player)

		for i=1, #fTable do
			if pName == fTable[i] then
				return true
			end
		end

	return false

end

function isPlayerBlacklisted(bTable, player) 

	local pName = getPlayerName(player)

		for i=1, #bTable do
			if pName == bTable[i] then
				return true
			end
		end

	return false

end

function openContactsApp()

	if not contactsGUI[1] then contactsGUI[1] = guiCreateGridList ( BGX, BGY, 0.99770569801331*BGWidth, 0.4*BGHeight, false ) end
	if not contactsGUI[2] then contactsGUI[2] = guiGridListAddColumn ( contactsGUI[1], "  Friends In-Game", 0.9 ) end	
	if not contactsGUI[3] then contactsGUI[3] = guiCreateGridList ( BGX, BGY+(0.475*BGHeight), 0.99770569801331*BGWidth, 0.450*BGHeight, false ) end
	if not contactsGUI[4] then contactsGUI[4] = guiGridListAddColumn ( contactsGUI[3], "  Players", 0.6 ) end
	if not contactsGUI[5] then contactsGUI[5] = guiGridListAddColumn ( contactsGUI[3], "Blacklisted", 0.3 ) end
	if not contactsGUI[6] then contactsGUI[6] = guiCreateEdit ( BGX, BGY+(0.4*BGHeight), BGWidth, 0.075*BGHeight, "", false ) end
	if not contactsGUI[7] then contactsGUI[7] = guiCreateComboBox ( BGX, BGY+(0.930*BGHeight), (BGWidth*0.65), 0.25*BGHeight, "Select a player", false ) end
	if not contactsGUI[8] then contactsGUI[8] = guiCreateButton ( BGX+(BGWidth*0.65), BGY+(0.930*BGHeight), 0.35*BGWidth, 0.068*BGHeight, "Apply", false ) end

	for i=1, #contactsGUI do
		if i ~= 2 and i ~= 4 and i ~= 5  then
			guiSetVisible ( contactsGUI[i], true )
			guiSetProperty ( contactsGUI[i], "AlwaysOnTop", "True" )
		end
	end
	guiGridListSetSelectedItem ( contactsGUI[1], 0, 0 )
	guiGridListSetSelectedItem ( contactsGUI[3], 0, 0 )	
	fillContactGrids()
	addEventHandler ( "onClientGUIChanged", contactsGUI[6], onChangeContactsSearchBox, false )
	addEventHandler ( "onClientPlayerJoin", root, onContactsPlayerJoin )
	addEventHandler ( "onClientPlayerQuit", root, onContactsPlayerQuit )
	addEventHandler ( "onClientGUIClick", root, onContactsClick )
	apps[5][7] = true
	
end

function closeContactsApp()

	removeEventHandler ( "onClientPlayerJoin", root, onContactsPlayerJoin )
	removeEventHandler ( "onClientPlayerQuit", root, onContactsPlayerQuit )
	removeEventHandler ( "onClientGUIChanged", contactsGUI[6], onChangeContactsSearchBox, false )
	removeEventHandler ( "onClientGUIClick", root, onContactsClick )
	for i=1, #contactsGUI do
		if i ~= 2 and i ~= 4 and i ~= 5 then
			guiSetVisible ( contactsGUI[i], false )
			guiSetProperty ( contactsGUI[i], "AlwaysOnTop", "False" )
		end
	end
	apps[5][7] = false
	
end
apps[5][7] = false
apps[5][8] = openContactsApp
apps[5][9] = closeContactsApp

function onContactsClick()
local row1,column1 = guiGridListGetSelectedItem ( contactsGUI[1] )
local row3,column3 = guiGridListGetSelectedItem ( contactsGUI[3] )

	if source == contactsGUI[1] then
	
		guiGridListSetSelectedItem ( contactsGUI[3], 0, 0 )
		if guiGridListGetSelectedItem ( contactsGUI[1] ) then
			local row, column = guiGridListGetSelectedItem ( contactsGUI[1] )
			if getPlayerFromName(guiGridListGetItemText ( contactsGUI[1], row, column )) then
				local player = getPlayerFromName(guiGridListGetItemText ( contactsGUI[1], row, column ))
				contactsFillComboBox(player)
				
			end
			
		end
		
	elseif source == contactsGUI[3] then

		guiGridListSetSelectedItem ( contactsGUI[1], 0, 0 )
		
		if guiGridListGetSelectedItem ( contactsGUI[3] ) then
		
			local row, column = guiGridListGetSelectedItem ( contactsGUI[3] )
			if getPlayerFromName(guiGridListGetItemText ( contactsGUI[3], row, column )) then
				local player = getPlayerFromName(guiGridListGetItemText ( contactsGUI[3], row, column ))
				contactsFillComboBox(player)
				
			end
			
		end
		
	elseif source == contactsGUI[8] then

		onContactsComboAccept()
		
	end

end

function onContactsComboAccept()

	local friendTable = exports.DENsettings:getPlayerFriends()
	local blackTable = exports.DENsettings:getBlacklistedPlayers()
	local row1,column1 = guiGridListGetSelectedItem ( contactsGUI[1] )
	local row3,column3 = guiGridListGetSelectedItem ( contactsGUI[3] )

		if ( row1 and column1 and row1 >=0 and column1 >=0 ) or ( row3 and column3 and row3 >=0 and column3 >=0 ) then
			local playerName 
			if row1 and column1 and row1 >=0 and column1 >=0 then
				playerName = guiGridListGetItemText(contactsGUI[1],row1,contactsGUI[2])
			elseif row3 and column3 and row3 >=0 and column3 >=0 then
				playerName = guiGridListGetItemText(contactsGUI[3],row3,contactsGUI[4])
			end
			local player = getPlayerFromName(playerName)
			if player then
				local option = guiComboBoxGetItemText(contactsGUI[7],guiComboBoxGetSelected( contactsGUI[7]))
				local friendTable = exports.densettings:getPlayerFriends()
				local blackTable = exports.densettings:getBlacklistedPlayers()
				if option == "Add Friend" and not isPlayerFriend ( friendTable, player ) then
					
					if not isPlayerBlacklisted(blackTable, player ) then
				
						exports.densettings:addPlayerFriend( player )
						guiGridListRemoveRow(contactsGUI[3],row3)
						local fRow = guiGridListAddRow(contactsGUI[1])
						guiGridListSetItemText ( contactsGUI[1], fRow, contactsGUI[2], playerName, false, false )
						
					end
			
				elseif option == "Remove Friend" and isPlayerFriend ( friendTable, player ) then 
				
					exports.densettings:removePlayerFriend( player )
					guiGridListRemoveRow(contactsGUI[1],row1)
					local pRow = guiGridListAddRow(contactsGUI[3])
					guiGridListSetItemText ( contactsGUI[3], pRow, contactsGUI[4], playerName, false, false )
					local blacklisted = "No"
					if isPlayerBlacklisted(blackTable, player ) then blacklisted = "Yes" end
					guiGridListSetItemText ( contactsGUI[3], pRow, contactsGUI[5], blacklisted, false, false )			
						
				elseif option == "Blacklist" and not isPlayerBlacklisted(blackTable, player ) then
					exports.densettings:addPlayerBlacklisted ( player )
					pRow = row3
					if isPlayerFriend( friendTable, player ) then
						guiGridListRemoveRow(contactsGUI[1],row1)
						pRow = guiGridListAddRow(contactsGUI[3])
					end
					guiGridListSetItemText ( contactsGUI[3], pRow, contactsGUI[4], playerName, false, false )
					guiGridListSetItemText ( contactsGUI[3], pRow, contactsGUI[5], "Yes", false, false )	
					exports.densettings:removePlayerFriend( player )
					
				elseif option == "Remove From Blacklist" and isPlayerBlacklisted(blackTable, player ) then
				
					exports.densettings:removePlayerBlacklisted ( player )
					guiGridListSetItemText ( contactsGUI[3], row3, contactsGUI[5], "No", false, false )	
					
				end
				contactsFillComboBox(player)
			end
			
		end	

end

function contactsFillComboBox(player)
	guiComboBoxClear(contactsGUI[7])
	if player then
		local friendTable = exports.densettings:getPlayerFriends()
		local blackTable = exports.densettings:getBlacklistedPlayers()
		if isPlayerFriend(friendTable, player) then
	
			guiComboBoxAddItem ( contactsGUI[7], "Remove Friend" )
			
		elseif not isPlayerBlacklisted(blackTable, player) then

			guiComboBoxAddItem ( contactsGUI[7], "Add Friend" )
			
		end
	
		if isPlayerBlacklisted(blackTable, player) then
	
			guiComboBoxAddItem ( contactsGUI[7], "Remove From Blacklist" )
			
		else

			guiComboBoxAddItem ( contactsGUI[7], "Blacklist" )
			
		end
		
	end

end


function fillContactGrids()
guiGridListClear(contactsGUI[1])
guiGridListClear(contactsGUI[3])
local players = getElementsByType('player')
local friendTable = exports.DENsettings:getPlayerFriends()
local blackTable = exports.DENsettings:getBlacklistedPlayers()

	for i=1, #players do
	
		if players[i] ~= localPlayer then
	
			if isPlayerFriend(friendTable, players[i]) then
		
				local fRow = guiGridListAddRow(contactsGUI[1])
				guiGridListSetItemText(contactsGUI[1], fRow, contactsGUI[2], getPlayerName(players[i]), false, false )
			
			else
		
				local pRow = guiGridListAddRow(contactsGUI[3])
				guiGridListSetItemText(contactsGUI[3], pRow, contactsGUI[4], getPlayerName(players[i]), false, false )
				local blacklisted = "No"
				if isPlayerBlacklisted(blackTable, players[i] ) then blacklisted = "Yes" end
				guiGridListSetItemText ( contactsGUI[3], pRow, contactsGUI[5], blacklisted, false, false )	

			end
		
		end

	end
	
end


function onChangeContactsSearchBox()
local friendTable = exports.DENsettings:getPlayerFriends()
guiGridListClear(contactsGUI[1])
guiGridListClear(contactsGUI[3])
	if guiGetText ( contactsGUI[6] ) ~= "" then
		local players = getElementsByType('player')
			for i=1, #players do
				if players[i] ~= localPlayer then
				
					if string.find(string.lower(getPlayerName(players[i])), string.lower(guiGetText ( contactsGUI[6] ))) then
					
						if isPlayerFriend(friendTable, players[i]) then
		
							local pRow = guiGridListAddRow ( contactsGUI[1] )
							guiGridListSetItemText ( contactsGUI[1], pRow, contactsGUI[2], getPlayerName(players[i]), false, false )

						else
						
							local pRow = guiGridListAddRow ( contactsGUI[3] )
							guiGridListSetItemText ( contactsGUI[3], pRow, contactsGUI[4], getPlayerName(players[i]), false, false )
							local blacklisted = "No"
							if isPlayerBlacklisted(blackTable, players[i] ) then blacklisted = "Yes" end
							guiGridListSetItemText ( contactsGUI[3], pRow, contactsGUI[5], blacklisted, false, false )	
						end
						
					end
			
				end

			end
		
	else
		fillContactGrids()
	end

end

function onContactsPlayerJoin()
local friendTable = exports.DENsettings:getPlayerFriends()
	if isPlayerFriend(friendTable, source) then
	
		local fRow = guiGridListAddRow ( contactsGUI[1] )
		guiGridListSetItemText ( contactsGUI[1], fRow, contactsGUI[2], getPlayerName(source), false, false )
		
	else
	
		local pRow = guiGridListAddRow ( contactsGUI[3] )
		guiGridListSetItemText ( contactsGUI[3], pRow, contactsGUI[4], getPlayerName(source), false, false )	
		local blacklisted = "No"
		if isPlayerBlacklisted(blackTable, source ) then blacklisted = "Yes" end
		guiGridListSetItemText ( contactsGUI[3], pRow, contactsGUI[5], blacklisted, false, false )	
	end

end

function onContactsPlayerQuit()

	for i=1,guiGridListGetRowCount(contactsGUI[1]) do
	
		if guiGridListGetItemText ( contactsGUI[1], i, contactsGUI[2] ) == getPlayerName(source) then
		
			guiGridListRemoveRow ( contactsGUI[1], i )
			
		end

	end
	
	for i=1,guiGridListGetRowCount(contactsGUI[3]) do
	
		if guiGridListGetItemText ( contactsGUI[3], i, contactsGUI[4] ) == getPlayerName(source) then
			guiGridListRemoveRow ( contactsGUI[3], i )
			
		end

	end
	
end



