----------------------------------
-- Coder: Sathler
-- To: CSG
-- Thanks to: Priyen & Dev Team
-- File: provides a GUI when press F5
----------------------------------

local pRanks = {
				{"[1] Assistant of Photography", 30, 15},
				{"[2] Photographer", 70, 20},
				{"[3] Editor", 120, 25},
				{"[4] Reporter", 170, 30},
				{"[5] Photo Editor", 240, 35},
				{"[6] Head Editor", 320, 40},
				{"[7] Final Redator", 410, 50}
			} --syntax: string rank_name, int pics_needed, int bonus

-----------------------------------------------------------------------------------------------
------------------------------ MAIN WINDOW ----------------------------------------------------
-----------------------------------------------------------------------------------------------		
function createMainWindow()
	local sWidth, sHeight = guiGetScreenSize()
	local mWidth, mHeight = 700, 600 --Window Width/Height
	NR_Window = guiCreateWindow(sWidth/2 - mWidth/2, sHeight/2 - mHeight/2, mWidth, mHeight, "News Reporter ~ CSG", false)
	
	-- Rank Button
	NR_RankButton = guiCreateButton(mWidth-190, 30, 180, 25, "View ranks", false, NR_Window)
	
	-- GridList
	NR_GridList = guiCreateGridList(10, 65, mWidth-20, mHeight-200, false, NR_Window)
				  NR_GridListColumnPlayers = guiGridListAddColumn(NR_GridList, "Players", 0.4)
				  NR_GridListColumnTransport = guiGridListAddColumn(NR_GridList, "Transport", 0.2)
				  NR_GridListColumnLocation = guiGridListAddColumn(NR_GridList, "Location", 0.25)
				  NR_GridListColumnCity = guiGridListAddColumn(NR_GridList, "City", 0.1)
	
	-- Buttons
	NR_BtnMarkAllPlayers 	   = guiCreateButton(10, 475, 165, 25, "Mark all players", false, NR_Window)
	NR_BtnUnmarkAllPlayers 	   = guiCreateButton(185, 475, 165, 25, "Unmark all players", false, NR_Window)
	NR_BtnMarkSelectedPlayer   = guiCreateButton(360, 475, 165, 25, "Mark selected player", false, NR_Window)
	NR_BtnUnmarkSelectedPlayer = guiCreateButton(535, 475, 165, 25, "Unmark selected player", false, NR_Window)
	NR_BtnRefreshList          = guiCreateButton(10, 510, 165, 25, "Refresh list", false, NR_Window)
	NR_BtnCloseMainWindow      = guiCreateButton(185, 510, 340, 25, "Close the window", false, NR_Window)
	
	guiSetVisible(NR_Window, false)
	
end
addEventHandler("onClientResourceStart", getRootElement(), createMainWindow)


function setMainWindowVisible(command, state)
	if state == "close" then state = false
	elseif state == "open" then state = true end
	guiSetVisible(NR_Window, state)
	showCursor(state)
	setButtonTextColor()
	
	guiGridListClear(NR_GridList) --Clear the GridList when the window is opened
	
	for i, player in ipairs(getElementsByType("player")) do
		if(getPlayerWantedLevel(player) ~= 0) then
			outputChatBox(getPlayerWantedLevel(player), 200, 25, 25)
			local row = guiGridListAddRow(NR_GridList)
						guiGridListSetItemText(NR_GridList, row, NR_GridListColumnPlayers, getPlayerName(player), false, false) --Add his name on list
						if(isPedInVehicle(player)) then
							guiGridListSetItemText(NR_GridList, row, NR_GridListColumnTransport, getVehicleName(getPedOccupiedVehicle(player)), false, false) --Add his vehicle on list
						else
							guiGridListSetItemText(NR_GridList, row, NR_GridListColumnTransport, "On Foot", false, false) --Or add "on foot"
						end
						local px, py, pz = getElementPosition(player)
						guiGridListSetItemText(NR_GridList, row, NR_GridListColumnLocation, getZoneName(px, py, pz, false), false, false) --Add his zonename on list
						guiGridListSetItemText(NR_GridList, row, NR_GridListColumnCity, getZoneName(px, py, pz, true), false, false) --Add his city
		end
	end
	
	addEventHandler("onClientGUIClick", NR_RankButton, setRankWindowVisible) -- RankButton Function
	addEventHandler("onClientGUIClick", NR_BtnCloseMainWindow, function (button) -- CloseButton Function
		if(source == NR_BtnCloseMainWindow) and (button == "left") then
			guiSetVisible(NR_Window, false)
			showCursor(false)
		end
	end)
	addEventHandler("onClientGUIClick", NR_BtnMarkAllPlayers, function (button) --MarkAllPlayers Function
		if(source == NR_BtnMarkAllPlayers) and (button == "left") then
			for i, player in ipairs(getElementsByType("player")) do
				if(getPlayerWantedLevel(player) > 0) then
					pBlip = createBlipAttachedTo(player, 41)
				end
			end
		end
	end)
	addEventHandler("onClientGUIClick", NR_BtnUnmarkAllPlayers, function (button) --UnmarkAllPlayers Function
		if(source == NR_BtnUnmarkAllPlayers) and (button == "left") then
			for i, player in ipairs(getElementsByType("player")) do
				if(getPlayerWantedLevel(player) > 0) then
					destroyElement(pBlip)
				end
			end
		end
	end)
	addEventHandler("onClientGUIClick", NR_BtnMarkSelectedPlayer, function (button) --MarkSelectedPlayer Function
		if(source == NR_BtnMarkSelectedPlayer) and (button == "left") then
			pRow, pColumn = guiGridListGetSelectedItem(NR_GridList)
			playerName   = guiGridListGetItemText(NR_GridList, pRow, pColumn)	
			playerFinal  = getPlayerFromName(playerName)
			
			if(playerFinal) then
				pBlip = createBlipAttachedTo(playerFinal, 41)
			end
		end
	end)
	addEventHandler("onClientGUIClick", NR_BtnUnmarkSelectedPlayer, function (button) --UnmarkSelectedPlayer Function
		if(source == NR_BtnUnmarkSelectedPlayer) and (button == "left") then
			pRow, pColumn = guiGridListGetSelectedItem(NR_GridList)
			pRow, pColumn = guiGridListGetSelectedItem(NR_GridList)
			playerName   = guiGridListGetItemText(NR_GridList, pRow, pColumn)	
			playerFinal  = getPlayerFromName(playerName)
			
			if(playerFinal) then
				destroyElement(pBlip)
			end
		end
	end)
	addEventHandler("onClientGUIClick", NR_BtnRefreshList, function (button) --RefreshList Function
		if(source == NR_BtnRefreshList) and (button == "left") then
			guiGridListClear(NR_GridList) --Clear the GridList when the window is opened
	
			setTimer(function ()
				for i, player in ipairs(getElementsByType("player")) do
					if(getPlayerWantedLevel(player) ~= 0) then
						outputChatBox(getPlayerWantedLevel(player), 200, 25, 25)
						local row = guiGridListAddRow(NR_GridList)
									guiGridListSetItemText(NR_GridList, row, NR_GridListColumnPlayers, getPlayerName(player), false, false) --Add his name on list
									if(isPedInVehicle(player)) then
										guiGridListSetItemText(NR_GridList, row, NR_GridListColumnTransport, getVehicleName(getPedOccupiedVehicle(player)), false, false) --Add his vehicle on list
									else
										guiGridListSetItemText(NR_GridList, row, NR_GridListColumnTransport, "On Foot", false, false) --Or add "on foot"
									end
									local px, py, pz = getElementPosition(player)
									guiGridListSetItemText(NR_GridList, row, NR_GridListColumnLocation, getZoneName(px, py, pz, false), false, false) --Add his zonename on list
									guiGridListSetItemText(NR_GridList, row, NR_GridListColumnCity, getZoneName(px, py, pz, true), false, false) --Add his city
					end
				end
			end, 500, 1)
		end
	end)
	
end
addCommandHandler("nr", setMainWindowVisible, state)

-----------------------------------------------------------------------------------------------
------------------------------ RANK WINDOW ----------------------------------------------------
-----------------------------------------------------------------------------------------------
function createRankWindow()
	local sWidth, sHeight = guiGetScreenSize()
	local rWidth, rHeight = 550, 260
	R_Window = guiCreateWindow(sWidth/2-rWidth/2, sHeight/2-rHeight/2, rWidth, rHeight, "News Reporter - Ranks", false)
			   guiSetProperty(R_Window, "AlwaysOnTop", "True")
			   
	-- Labels
	R_LblCurrentRank = guiCreateLabel(10, 30, 110, 20, "Your current rank:", false, R_Window)
					   guiSetFont(R_LblCurrentRank, "default-bold-small")
	R_LblPlayerRank  = guiCreateLabel(115, 30, 200, 20, "Amateur", false, R_Window)
					   guiSetFont(R_LblPlayerRank, "default-bold-small")
	R_LblPicsTaken 	 = guiCreateLabel(10, 50, 110, 20, "Pictures taken:", false, R_Window)
					   guiSetFont(R_LblPicsTaken, "default-bold-small")
	R_LblPlayerPics  = guiCreateLabel(115, 50, 100, 20, "20", false, R_Window)
					   guiSetFont(R_LblPlayerPics, "default-bold-small")
					   
	-- GridList
	R_GridList    = guiCreateGridList(10, 70, rWidth-20, rHeight-105, false, R_Window)
					R_GridListColumnRank  = guiGridListAddColumn(R_GridList, "Rank", 0.7)
					R_GridListColumnPics  = guiGridListAddColumn(R_GridList, "Pics needed", 0.15)
					R_GridListColumnBonus = guiGridListAddColumn(R_GridList, "Bonus", 0.1)
					
	for i, v in ipairs(pRanks) do
		local row = guiGridListAddRow(R_GridList)
					guiGridListSetItemText(R_GridList, row, R_GridListColumnRank, pRanks[i][1], false, false)
					guiGridListSetItemText(R_GridList, row, R_GridListColumnPics, tostring(pRanks[i][2]), false, false)
					guiGridListSetItemText(R_GridList, row, R_GridListColumnBonus, tostring(pRanks[i][3]), false, false)
	end
	
	-- Buttons
	R_BtnCloseWindow = guiCreateButton(10, rHeight-30, rWidth-20, 25, "Close the window", false, R_Window)
	addEventHandler("onClientGUIClick", R_BtnCloseWindow, function (button)
		if(button == "left") and (source == R_BtnCloseWindow) then
			guiSetVisible(R_Window, false)
		end
	end)
	
	guiSetVisible(R_Window, false)
end
addEventHandler("onClientResourceStart", getRootElement(), createRankWindow)


function setRankWindowVisible(button, state)
	if (source == NR_RankButton) and (button == "left") then
		guiSetVisible(R_Window, true)
	end
end

-----------------------------------------------------------------------------------------------
------------------------------ IMPROVE DESIGN -------------------------------------------------
-----------------------------------------------------------------------------------------------
function setButtonTextColor()
	for i, v in ipairs(getElementsByType("gui-button")) do
		guiSetProperty(v, "HoverTextColour", "FFFF9900")
	end
end