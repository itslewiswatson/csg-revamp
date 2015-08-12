----------------------------------
-- Coder: Sathler
-- To: CSG
-- Thanks to: Priyen & Dev Team
-- File: provides a GUI when press F5
----------------------------------


function setJob(hitElement, matchingDimension)
	if (getElementType(hitElement) == "player") and (matchingDimension) then
		RReporterJobChange("became")
	end
end
--addEventHandler("onClientMarkerHit", jobMarker, setJob)
-- *****************************************************************************************************************************
blipped = {}
players = {}
blips = {}

function RReporterReport(p,arg2)
    if type(p) == "string" then
        if p == "pu" then
            players = arg2
            updateBlips()
        end
    end
end
addEvent("RReporterReport",true)
addEventHandler("RReporterReport",localPlayer,RReporterReport)

function updateBlips()
    for k,v in pairs(blips) do
		--if not(blipped[k]) or not(players[k]) then
			destroyElement(v)
		--end
    end
	blips = {}
end

function takePic(weapon, ammo, clip, hitX, hitY, hitZ, hitElement)

    if weapon ~= 43 then return end
	if getElementData(localPlayer,"Occupation") ~= "News Reporter" then return end
		if getTeamName(getPlayerTeam(localPlayer)) ~= "Civilan Workers" then return end
    if (hitElement) then

        if getElementType(hitElement) == "player" then
            if players[hitElement] then
				triggerServerEvent("RReporterTookPic",localPlayer,hitElement)
                return
            end
            exports.DENdxmsg:createNewDxMessage("This person is not on your list of players to take photo's of!",255,255,0)
        else
           exports.DENdxmsg:createNewDxMessage("You have to take a photo of a person only!",255,255,0)
        end
    else
       exports.DENdxmsg:createNewDxMessage("The picture is too blury, try zooming in!",255,255,0)
    end
end
addEventHandler("onClientPlayerWeaponFire",localPlayer,takePic)

function RReporterJobChange(change)
    if change == "quit" then
    players = nil
    players = {}
	blipped = {}
    updateBlips()
   -- removeEventHandler("onClientPlayerWeaponFire", localPlayer, takePic)

    elseif change == "became" then
   -- addEventHandler("onClientPlayerWeaponFire", localPlayer, takePic)
		exports.DENdxmsg:createNewDxMessage("Press F5 to access the News Reporter Control Panel",0,255,0)
    end
end
addEvent("RReporterJobChange",true)
addEventHandler("RReporterJobChange",localPlayer,RReporterJobChange)


local pRanks = {
				{"News Reporter in Training",0,0},
				{"Assistant of Photography", 30, 15},
				{"Photographer", 70, 20},
				{"Editor", 120, 25},
				{"Reporter", 170, 30},
				{"Photo Editor", 240, 35},
				{"Head Editor", 320, 40},
				{"Final Redator", 410, 50}
			} --syntax: string rank_name, int pics_needed, int bonus

-----------------------------------------------------------------------------------------------
------------------------------ MAIN WINDOW ----------------------------------------------------
-----------------------------------------------------------------------------------------------
function createMainWindow()
	local sWidth, sHeight = guiGetScreenSize()
	local mWidth, mHeight = 700, 550 --Window Width/Height
	NR_Window = guiCreateWindow(sWidth/2 - mWidth/2, sHeight/2 - mHeight/2, mWidth, mHeight, "News Reporter ~ CSG", false)

	-- Rank Button
	NR_RankButton = guiCreateButton(mWidth-190, 30, 180, 25, "View ranks", false, NR_Window)

	-- GridList
	list = guiCreateGridList(10, 65, mWidth-20, mHeight-200, false, NR_Window)
				  listColumnPlayers = guiGridListAddColumn(list, "Players", 0.2)
				  listColumnTransport = guiGridListAddColumn(list, "Transport", 0.2)
				  listColumnLocation = guiGridListAddColumn(list, "Location", 0.25)
				  listColumnCity = guiGridListAddColumn(list, "Reason", 0.5)

	-- Buttons
	NR_BtnMarkAllPlayers 	   = guiCreateButton(10, 475, 165, 25, "Mark all players", false, NR_Window)
	NR_BtnUnmarkAllPlayers 	   = guiCreateButton(185, 475, 165, 25, "Unmark all players", false, NR_Window)
	NR_BtnMarkSelectedPlayer   = guiCreateButton(360, 475, 165, 25, "Mark selected player", false, NR_Window)
	NR_BtnUnmarkSelectedPlayer = guiCreateButton(535, 475, 165, 25, "Unmark selected player", false, NR_Window)
	NR_BtnRefreshList          = guiCreateButton(10, 510, 165, 25, "Refresh list", false, NR_Window)
	NR_BtnCloseMainWindow      = guiCreateButton(185, 510, 340, 25, "Close the window", false, NR_Window)
		addEventHandler("onClientGUIClick", NR_RankButton, setRankWindowVisible) -- RankButton Function
		addEventHandler("onClientGUIClick", NR_BtnCloseMainWindow, function (button) -- CloseButton Function
			if(source == NR_BtnCloseMainWindow) and (button == "left") then
				guiSetVisible(NR_Window, false)
				showCursor(false)
			end
		end)
		addEventHandler("onClientGUIClick", NR_BtnMarkAllPlayers, function (button) --MarkAllPlayers Function
			if(source == NR_BtnMarkAllPlayers) and (button == "left") then
				for player,_ in pairs(players) do
					if not blipped[player] then
						blipped[player] = true
						blips[player] = createBlipAttachedTo(player,23)
					end
				end
				exports.DENdxmsg:createNewDxMessage("Marked all players on the map",0,255,0)
				refresh()
			end
		end)
		addEventHandler("onClientGUIClick", NR_BtnUnmarkAllPlayers, function (button) --UnmarkAllPlayers Function
			if(source == NR_BtnUnmarkAllPlayers) and (button == "left") then
				for player,_ in pairs(players) do
					if blipped[player] then
						blipped[player] = false
						destroyElement(blips[player])
					end
				end
				exports.DENdxmsg:createNewDxMessage("Un-marked all players from the map",0,255,0)
				refresh()
			end
		end)
		addEventHandler("onClientGUIClick", NR_BtnMarkSelectedPlayer, function (button) --MarkSelectedPlayer Function
			if(source == NR_BtnMarkSelectedPlayer) and (button == "left") then
				local row = guiGridListGetSelectedItem(list)
				if (row) then
					local p = guiGridListGetItemData(list,row,1)
					if (p) and isElement(p) then
						if blipped[p] then
							exports.DENdxmsg:createNewDxMessage("This player is already marked on your map",255,0,0)
						else
							exports.DENdxmsg:createNewDxMessage("Marked "..getPlayerName(p).." on the map",0,255,0)
							blipped[p] = true
							blips[p] = createBlipAttachedTo(p,23)
						end
					else
						refresh()
					end
				else
					exports.DENdxmsg:createNewDxMessage("You didn't select a player",255,0,0)
				end
			end
		end)
		addEventHandler("onClientGUIClick", NR_BtnUnmarkSelectedPlayer, function (button) --UnmarkSelectedPlayer Function
			if(source == NR_BtnUnmarkSelectedPlayer) and (button == "left") then
				local row = guiGridListGetSelectedItem(list)
				if (row) then
					local p = guiGridListGetItemData(list,row,1)
					if (p) and isElement(p) then
						if not blipped[p] then
							exports.DENdxmsg:createNewDxMessage("This player is not marked on your map",255,0,0)
						else
							exports.DENdxmsg:createNewDxMessage("Un-marked "..getPlayerName(p).." from the map",0,255,0)
							blipped[p] = false
							destroyElement(blips[p])
							refresh()
						end
					else
						refresh()
					end
				else
					exports.DENdxmsg:createNewDxMessage("You didn't select a player",255,0,0)
				end
			end
		end)
		addEventHandler("onClientGUIClick", NR_BtnRefreshList, function (button) --RefreshList Function
			if(source == NR_BtnRefreshList) and (button == "left") then
				guiGridListClear(list)
				if players == nil then
					exports.DENdxmsg:createNewDxMessage("No players to report on at the moment",255,0,0)
					return
				end
				refresh()
			end
		end)
	guiSetVisible(NR_Window, false)

end
addEventHandler("onClientResourceStart", getRootElement(), createMainWindow)

function refresh()
	guiGridListClear(list)
	if players ~= nil then
		for k,v in pairs(players) do
			local row = guiGridListAddRow(list)
			guiGridListSetItemText(list,row,1,getPlayerName(k),false,false)
			guiGridListSetItemData(list,row,1,k)
			local trans
			if isPedInVehicle(k) then trans = getVehicleName(getPedOccupiedVehicle(k)) end
			if not trans then trans = "On Foot" end
			guiGridListSetItemText(list,row,2,trans,false,false)
			if blipped[k] then
				guiGridListSetItemColor(list,row,1,0,255,0)
			else
				guiGridListSetItemColor(list,row,1,255,0,0)
			end
			local x,y,z = getElementPosition(k)
			guiGridListSetItemText(list,row,3,getZoneName(x,y,z),false,false)
			guiGridListSetItemText(list,row,4,v,false,false)
		end
	end
	local mypts = exports.DENstats:getPlayerAccountData(localPlayer,"newsreporter")
	local rank
	for k,v in pairs(pRanks) do
		if mypts >= v[2] then rank = v[1] end
	end
	guiSetText(lblRank,rank)
	guiSetText(lblPics,mypts)

end

function toggle()
	if (guiGetVisible(NR_Window) == false) then
		if not(getElementData(localPlayer,"Occupation") == "News Reporter") then return end
		guiSetVisible(NR_Window, true)
		showCursor(true)
		setButtonTextColor()
		refresh()
	elseif (guiGetVisible(NR_Window) == true) then
		guiSetVisible(NR_Window, false)
		if not guiGetVisible(R_Window) then
			showCursor(false)
		end
	end
end

bindKey("F5", "down", toggle)
--addCommandHandler("nr", setMainWindowVisible, state)

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
	lblRank  = guiCreateLabel(125, 30, 200, 20, "Amateur", false, R_Window)
					   guiSetFont(lblRank, "default-bold-small")
	R_LblPicsTaken 	 = guiCreateLabel(10, 50, 110, 20, "Pictures taken:", false, R_Window)
					   guiSetFont(R_LblPicsTaken, "default-bold-small")
	lblPics  = guiCreateLabel(115, 50, 100, 20, "20", false, R_Window)
					   guiSetFont(lblPics, "default-bold-small")

	-- GridList
	R_GridList    = guiCreateGridList(10, 70, rWidth-20, rHeight-105, false, R_Window)
					R_GridListColumnRank  = guiGridListAddColumn(R_GridList, "Rank", 0.6)
					R_GridListColumnPics  = guiGridListAddColumn(R_GridList, "Pics needed", 0.15)
					R_GridListColumnBonus = guiGridListAddColumn(R_GridList, "Bonus Salary %", 0.2)

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
