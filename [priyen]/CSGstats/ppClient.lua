local gui = {}
	gui._placeHolders = {}

	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 516, 531
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	window = guiCreateWindow(left, top, windowWidth, windowHeight, "Community of Social Gaming ~ Stats", false)
	guiWindowSetSizable(window, false)

	gui["label"] = guiCreateLabel(50, 25, 46, 13, "Player", false, window)
	guiLabelSetHorizontalAlign(gui["label"], "left", false)
	guiLabelSetVerticalAlign(gui["label"], "center")

	listplayers = guiCreateGridList(0, 75, 131, 411, false, window)
	guiGridListSetSortingEnabled(listplayers, false)
	guiGridListAddColumn( listplayers, "Player", 0.85 )
	local tableWidget_row = nil

	listcat = guiCreateGridList(145, 45, 366, 102, false, window)
	guiGridListSetSortingEnabled(listcat, false)
	guiGridListAddColumn( listcat, "Category", 0.85 )

	guiGridListSetItemText(listcat, guiGridListAddRow ( listcat ), 1, "All Stats (shows everything)", false, false)
	guiGridListSetItemData(listcat,0,1,"all")
	guiGridListSetItemText(listcat, guiGridListAddRow ( listcat ), 1, "General (stats relating to gameplay)", false, false)
	guiGridListSetItemData(listcat,1,1,"General")
	guiGridListSetItemText(listcat, guiGridListAddRow ( listcat ), 1, "Civilian (stats relating to civilians) ", false, false)
	guiGridListSetItemData(listcat,2,1,"Civilian")
	guiGridListSetItemText(listcat, guiGridListAddRow ( listcat ), 1, "Law Enforcement (stats relating to law)", false, false)
	guiGridListSetItemData(listcat,3,1,"Law")
	guiGridListSetItemText(listcat, guiGridListAddRow ( listcat ), 1, "Criminal (stats relating to criminals)", false, false)
	guiGridListSetItemData(listcat,4,1,"Criminal")
	guiGridListSetItemText(listcat, guiGridListAddRow ( listcat ), 1, "Events (stats relating to CnR and Admin events)", false, false)
	guiGridListSetItemData(listcat,5,1,"Events")
	guiGridListSetItemText(listcat, guiGridListAddRow ( listcat ), 1, "Groups (stats relating to group history)", false, false)
	guiGridListSetItemData(listcat,6,1,"Groups")
	guiGridListSetItemText(listcat, guiGridListAddRow ( listcat ), 1, "Ranking (stats relating to player ranking)", false, false)
	guiGridListSetItemData(listcat,7,1,"Ranking")
	guiGridListSetSelectedItem(listcat,0,1)
	local tableWidget_2_row = nil

	liststats = guiCreateGridList(145, 156, 366, 331, false, window)
	guiGridListSetSortingEnabled(liststats, false)
	guiGridListAddColumn( liststats, "Stat", 0.4 )
	guiGridListAddColumn( liststats, "Value", 0.45 )
	local tableWidget_3_row = nil

	gui["label_2"] = guiCreateLabel(310, 25, 111, 16, "Stats", false, window)
	guiLabelSetHorizontalAlign(gui["label_2"], "left", false)
	guiLabelSetVerticalAlign(gui["label_2"], "center")

	btnClose= guiCreateButton(0, 495, 511, 31, "Exit", false, window)

	txtfilter = guiCreateEdit(0, 45, 131, 21, "", false, window)
	guiEditSetMaxLength(txtfilter, 32767)
	guiSetVisible(window,false)

workingEle=false
data={}



function update()
	triggerServerEvent("CSGstats.get",localPlayer,workingEle)
end

function rec(data)
	local row = guiGridListGetSelectedItem(listcat)
	local typ = guiGridListGetItemData(listcat,row,1)
	guiGridListClear(liststats)
	for k,v in pairs(data) do
		if typ=="all" or typ==v[1] then
			for k2,v2 in pairs(v) do
				if k2==1 then
					local catRow = guiGridListAddRow( liststats )
					guiGridListSetItemText( liststats, catRow, 1, v2, true, false )
				else
					local row = guiGridListAddRow ( liststats )
					guiGridListSetItemText(liststats, row, 1, v2[1], false, false)
					--if getPlayerName(localPlayer) ~= "[CSG]Priyen[MF]" and getPlayerName(localPlayer) ~= "[CSG]Smith" and getPlayerName(localPlayer) ~= "[CSG]iMaster" then v2[2] = "Completed and Ready for v2" end
					guiGridListSetItemText(liststats, row, 2, v2[2], false, false)
				end
			end
		end
	end
end
addEvent("CSGstats.rec",true)
addEventHandler("CSGstats.rec",localPlayer,rec)

function filter()
	guiGridListClear(listplayers)
	local name = guiGetText(txtfilter)
	for id, player in ipairs(getElementsByType("player")) do
        if string.find(getPlayerName(player):lower(), name:lower()) then
			local playerTeam = getPlayerTeam( player )
			if ( playerTeam ) then
				local r, g, b = getTeamColor ( playerTeam )
				local row = guiGridListAddRow ( listplayers )
				guiGridListSetItemText(listplayers, row, 1, getPlayerName(player), false, false)
				guiGridListSetItemColor ( listplayers, row, 1, r, g, b )
			end
		end
	end
end
addEventHandler	("onClientGUIChanged", txtfilter, filter, false)

function click()
	if source==btnClose then hide() return end
	if source==listplayers or source==listcat then
		local row = guiGridListGetSelectedItem(listplayers)
		if row ~= nil and row ~= -1 and row ~= false then
			workingEle=getPlayerFromName(guiGridListGetItemText(listplayers,row,1))
			if getPlayerTeam(workingEle) == false then
				exports.dendxmsg:createNewDxMessage(""..getPlayerName(workingEle).." is not logged in. You cannot view their stats.",255,255,0)
				return
			else
				update()
			end
		end
	end
end
addEventHandler("onClientGUIClick",root,click)

function updatePlayers()
	filter()
end

function show()
	updatePlayers()
	guiSetVisible(window,true)
	showCursor(true)
end

function hide()
	guiSetVisible(window,false)
	showCursor(false)
end
addCommandHandler("stats",function() if guiGetVisible(window) then hide() else show() end end)
