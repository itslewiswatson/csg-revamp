allianceGUI = { tabs = {} }
function centerWindow(window)
	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(window,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(window,x,y,false)
end
function table.copy(tab)
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") then ret[key] = table.copy(value)
        else ret[key] = value end
    end
    return ret
end


function createAllianceGUI()

    allianceGUI.window = guiCreateWindow(408, 183, 550, 402, "Community of Social Gaming ~ Alliance Management", false)
    guiWindowSetSizable( allianceGUI.window, false)
	centerWindow(allianceGUI.window)

    allianceGUI.tabpanel = guiCreateTabPanel(9, 25, 532, 368, false,  allianceGUI.window)

    allianceGUI.tabs.main = { guiCreateTab("Main", allianceGUI.tabpanel) }

		allianceGUI.tabs.main.createNewAlliance = guiCreateButton(7, 12, 151, 29, "Create new alliance", false, allianceGUI.tabs.main[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.main.createNewAlliance,createNewAlliance,false)
		allianceGUI.tabs.main.createNewAllianceEdit = guiCreateEdit(162, 11, 363, 30, "", false, allianceGUI.tabs.main[1])

			guiLabelSetColor(guiCreateLabel(9, 44, 519, 11, string.rep("-",128), false, allianceGUI.tabs.main[1]), 230, 86, 8)
		-- info labels
		guiSetFont(guiCreateLabel(9, 64, 130, 16, "Your current alliance:", false, allianceGUI.tabs.main[1]),"default-bold-small")
			allianceGUI.tabs.main.currentAlliance = guiCreateLabel(137, 64, 382, 16, "RYTUIJOK", false, allianceGUI.tabs.main[1])
		guiSetFont(guiCreateLabel(9, 91, 130, 16, "Alliance members:", false, allianceGUI.tabs.main[1]), "default-bold-small")
			allianceGUI.tabs.main.currentAllianceMembers = guiCreateLabel(137, 90, 385, 16, "1", false, allianceGUI.tabs.main[1])
		guiSetFont(guiCreateLabel(9, 119, 130, 16, "Alliance founder:", false, allianceGUI.tabs.main[1]), "default-bold-small")
			allianceGUI.tabs.main.currentAllianceFounder = guiCreateLabel(137, 118, 381, 16, "bibou", false, allianceGUI.tabs.main[1])
		guiSetFont(guiCreateLabel(9, 148, 130, 16, "Date created:", false, allianceGUI.tabs.main[1]), "default-bold-small")
			allianceGUI.tabs.main.currentAllianceCreated = guiCreateLabel(137, 147, 382, 16, "2013-02-17 17:39:36", false, allianceGUI.tabs.main[1])
		guiSetFont(guiCreateLabel(9, 177, 130, 16, "Last group joined at:", false, allianceGUI.tabs.main[1]), "default-bold-small")
			allianceGUI.tabs.main.currentAllianceLastJoinDate = guiCreateLabel(137, 176, 377, 16, "2013-02-17 17:39:36", false, allianceGUI.tabs.main[1])
		guiSetFont(guiCreateLabel(9, 207, 130, 16, "Alliance bank balance:", false, allianceGUI.tabs.main[1]),"default-bold-small")
			allianceGUI.tabs.main.currentAllianceBankBalance = guiCreateLabel(137, 207, 384, 16, "$0", false, allianceGUI.tabs.main[1])
		guiSetFont(guiCreateLabel(9, 236, 130, 16, "Your group:", false, allianceGUI.tabs.main[1]), "default-bold-small")
			allianceGUI.tabs.main.currentAllianceMyGroup = guiCreateLabel(137, 236, 383, 16, "Group founder", false, allianceGUI.tabs.main[1])
		allianceGUI.tabs.main.backToGroups = guiCreateButton(450, 236, 70, 30, "Groups", false, allianceGUI.tabs.main[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.main.backToGroups,backToGroups,false)
		guiSetFont(guiCreateLabel(9, 268, 130, 16, "Alliance groups: ", false, allianceGUI.tabs.main[1]), "default-bold-small")

			allianceGUI.tabs.main.currentAllianceGroups = guiCreateLabel(137, 269, 382, 16, "The Cobras, The Smurfs, the blablablablablabalabla Family", false, allianceGUI.tabs.main[1])

			guiLabelSetColor(guiCreateLabel(9, 283, 519, 11, string.rep("-",128), false, allianceGUI.tabs.main[1]), 230, 86, 8)

		-- options

		allianceGUI.tabs.main.leaveAlliance = guiCreateButton(7, 304, 151, 29, "Leave alliance", false, allianceGUI.tabs.main[1])
			guiSetProperty(allianceGUI.tabs.main.leaveAlliance, "NormalTextColour", "FFE10000")
			addEventHandler("onClientGUIClick",allianceGUI.tabs.main.leaveAlliance,leaveAlliance,false)

		allianceGUI.tabs.main.enableAllianceBlips = guiCreateCheckBox(167, 304, 213, 29, "Enable alliance members blips", true, false, allianceGUI.tabs.main[1])
			guiSetFont(allianceGUI.tabs.main.enableAllianceBlips, "default-bold-small")
			addEventHandler("onClientGUIClick",allianceGUI.tabs.main.enableAllianceBlips,onPlayerAllianceSettingChanged,false)
			exports.DENsettings:addPlayerSetting("allianceblips","true")

    allianceGUI.tabs.groups = { guiCreateTab("Groups", allianceGUI.tabpanel) }

		guiSetFont(guiCreateLabel(6, 6, 517, 15, "Alliance groups:", false,  allianceGUI.tabs.groups[1]), "default-bold-small")
		allianceGUI.tabs.groups.groupGrid = guiCreateGridList(6, 26, 519, 311, false,  allianceGUI.tabs.groups[1])
			guiGridListAddColumn(allianceGUI.tabs.groups.groupGrid,"Name",0.65)
			guiGridListAddColumn(allianceGUI.tabs.groups.groupGrid,"Founder",0.25)

	allianceGUI.tabs.info = { guiCreateTab("Information", allianceGUI.tabpanel) }

		guiSetFont(guiCreateLabel(6, 6, 115, 16, "Alliance information:", false, allianceGUI.tabs.info[1]),"default-bold-small")
		allianceGUI.tabs.info.memo = guiCreateMemo(3, 22, 526, 293, "", false, allianceGUI.tabs.info[1])
		allianceGUI.tabs.info.update = guiCreateButton(3, 317, 526, 22, "Update alliance information", false, allianceGUI.tabs.info[1])
		addEventHandler("onClientGUIClick",allianceGUI.tabs.info.update,updateInformation,false)

    allianceGUI.tabs.maintenance = { guiCreateTab("Maintenance", allianceGUI.tabpanel) }

		guiSetFont(guiCreateLabel(6, 6, 185, 14, "Group and member maintenance:", false,  allianceGUI.tabs.maintenance[1]), "default-bold-small")

		allianceGUI.tabs.maintenance.gridlist = guiCreateGridList(5, 20, 345, 285, false,  allianceGUI.tabs.maintenance[1])
			guiGridListAddColumn(allianceGUI.tabs.maintenance.gridlist, "Name", 0.55)
			guiGridListAddColumn(allianceGUI.tabs.maintenance.gridlist, "Leader", 0.35)
		-- right
		allianceGUI.tabs.maintenance.noteAllMembers = guiCreateButton(366, 9, 155, 36, "Note to all groups", false,  allianceGUI.tabs.maintenance[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.maintenance.noteAllMembers,function () getNoteText(noteAllMembers,"all groups.") end,false )
		allianceGUI.tabs.maintenance.noteGroup = guiCreateButton(366, 51, 155, 36, "Note to selected group", false,  allianceGUI.tabs.maintenance[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.maintenance.noteGroup,function () getNoteText(noteGroup, "selected group.") end,false )
		allianceGUI.tabs.maintenance.inviteGroup = guiCreateButton(366, 90, 155, 36, "Invite groups", false,  allianceGUI.tabs.maintenance[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.maintenance.inviteGroup,inviteGroups,false )
		allianceGUI.tabs.maintenance.kickGroup = guiCreateButton(366, 130, 155, 36, "Kick group", false,  allianceGUI.tabs.maintenance[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.maintenance.kickGroup,kickGroup,false )
		allianceGUI.tabs.maintenance.pickColor = guiCreateButton(366, 170, 155, 36, "Pick Turf Color", false,  allianceGUI.tabs.maintenance[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.maintenance.pickColor,pickColor,false )
			allianceGUI.tabs.maintenance.shareGates = guiCreateCheckBox(5,295,90,40,"Share gates.",true,false,allianceGUI.tabs.maintenance[1])
			allianceGUI.tabs.maintenance.shareSpawners = guiCreateCheckBox(125,295,145,40,"Share spawners.",true,false,allianceGUI.tabs.maintenance[1])
			allianceGUI.tabs.maintenance.shareArmor = guiCreateCheckBox(265,295,125,40,"Share armor.",true,false,allianceGUI.tabs.maintenance[1])
			allianceGUI.tabs.maintenance.forceBlips = guiCreateCheckBox(405,295,125,40,"Force alliance blips.",true,false,allianceGUI.tabs.maintenance[1])
			allianceGUI.tabs.maintenance.canDefend = guiCreateCheckBox(5,310,145,40,"Can defend turfs.",true,false,allianceGUI.tabs.maintenance[1])
			allianceGUI.tabs.maintenance.splitMoney = guiCreateCheckBox(125,310,145,40,"Split defend money.",true,false,allianceGUI.tabs.maintenance[1])
			allianceGUI.tabs.maintenance.ignore = guiCreateCheckBox(265,310,125,40,"FuturePur",true,false,allianceGUI.tabs.maintenance[1])
			allianceGUI.tabs.maintenance.turfAsAlliance = guiCreateCheckBox(405,310,125,40,"Turf as Alliance.",true,false,allianceGUI.tabs.maintenance[1])
		allianceGUI.tabs.maintenance.setAllianceFounder = guiCreateButton(366, 216, 155, 36, "Set new alliance founder", false,  allianceGUI.tabs.maintenance[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.maintenance.setAllianceFounder,
				function ()
					local selected = getSelectedGroupInMaintenanceTab()
					if selected then
						alliance_confirmActionGUI(setAllianceFounder,"","Set new founder?", true)
					end
				end
			, false)		allianceGUI.tabs.maintenance.deleteAlliance = guiCreateButton(366, 258, 155, 36, "Delete alliance", false,  allianceGUI.tabs.maintenance[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.maintenance.deleteAlliance,
				function ()
					alliance_confirmActionGUI(deleteAlliance,"","Delete alliance?", true)
				end
			, false)
			guiSetProperty(allianceGUI.tabs.maintenance.deleteAlliance, "NormalTextColour", "FFC50000")
	allianceGUI.tabs.bank = { guiCreateTab("Banking", allianceGUI.tabpanel) }

		allianceGUI.tabs.bank.balance = guiCreateLabel(7, 8, 377, 18, "Last bank transactions: (Current balance: $0)", false, allianceGUI.tabs.bank[1])
		guiSetFont(allianceGUI.tabs.bank.balance, "default-bold-small")
		allianceGUI.tabs.bank.gridlist = guiCreateGridList(4, 25, 525, 282, false, allianceGUI.tabs.bank[1])
			guiGridListAddColumn(allianceGUI.tabs.bank.gridlist, "Group", 0.435)
			guiGridListAddColumn(allianceGUI.tabs.bank.gridlist, "Action", 0.18)
			guiGridListAddColumn(allianceGUI.tabs.bank.gridlist, "", 0.01)
			guiGridListAddColumn(allianceGUI.tabs.bank.gridlist, "Amount", 0.31)
		allianceGUI.tabs.bank.withdraw = guiCreateButton(383, 309, 145, 30, "Withdraw", false, allianceGUI.tabs.bank[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.bank.withdraw,alliance_withdrawFromBank,false)
		allianceGUI.tabs.bank.deposit = guiCreateButton(232, 309, 147, 30, "Deposit", false, allianceGUI.tabs.bank[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.bank.deposit,alliance_depositToBank,false)
		allianceGUI.tabs.bank.amount = guiCreateEdit(4, 310, 226, 29, "", false, allianceGUI.tabs.bank[1])

    allianceGUI.tabs.invites = { guiCreateTab("Alliance invites", allianceGUI.tabpanel) }

		allianceGUI.tabs.invites.headerLabel = guiCreateLabel(7, 7, 394, 16, "Alliance invites:", false, allianceGUI.tabs.invites[1])
		guiSetFont(allianceGUI.tabs.invites.headerLabel, "default-bold-small")
		allianceGUI.tabs.invites.gridlist = guiCreateGridList(4, 24, 523, 278, false, allianceGUI.tabs.invites[1])
		allianceGUI.tabs.invites.acceptInvite = guiCreateButton(4, 305, 260, 34, "Accept alliance invitation", false, allianceGUI.tabs.invites[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.invites.acceptInvite,alliance_acceptInvitation,false)
		allianceGUI.tabs.invites.rejectInvite = guiCreateButton(267, 305, 260, 34, "Reject alliance invitation", false, allianceGUI.tabs.invites[1])
			addEventHandler("onClientGUIClick",allianceGUI.tabs.invites.rejectInvite,alliance_rejectInvitation,false)

    allianceGUI.tabs.alliances = { guiCreateTab("Alliance(s)", allianceGUI.tabpanel) }

		guiSetFont(guiCreateLabel(8, 6, 351, 19, "All alliances:", false, allianceGUI.tabs.alliances[1]), "default-bold-small")
		allianceGUI.tabs.alliances.gridlist = guiCreateGridList(8, 29, 513, 309, false, allianceGUI.tabs.alliances[1])
			guiGridListAddColumn(allianceGUI.tabs.alliances.gridlist, "Name", 0.4)
			guiGridListAddColumn(allianceGUI.tabs.alliances.gridlist, "Founder", 0.35)
			guiGridListAddColumn(allianceGUI.tabs.alliances.gridlist, "Number of groups", 0.2)


end

function onPlayerAllianceSettingChanged()
	if source == allianceGUI.tabs.main.enableAllianceBlips then
		exports.DENsettings:setPlayerSetting( "allianceblips", tostring( guiCheckBoxGetSelected( source ) ) )
	else
		--
	end
end
local allianceSettings = {}
local configuredSettings = {}

function onAllianceSettingChanged()
	if myAlliance then

		alliances[myAlliance].shareGates = guiCheckBoxGetSelected(allianceGUI.tabs.maintenance.shareGates)
		alliances[myAlliance].shareSpawners = guiCheckBoxGetSelected(allianceGUI.tabs.maintenance.shareSpawners)
		alliances[myAlliance].shareArmor = guiCheckBoxGetSelected(allianceGUI.tabs.maintenance.shareArmor)
		alliances[myAlliance].forceBlips = guiCheckBoxGetSelected(allianceGUI.tabs.maintenance.forceBlips)
		alliances[myAlliance].canDefend = guiCheckBoxGetSelected(allianceGUI.tabs.maintenance.canDefend)
		alliances[myAlliance].splitMoney = guiCheckBoxGetSelected(allianceGUI.tabs.maintenance.splitMoney)
		alliances[myAlliance].ignore = guiCheckBoxGetSelected(allianceGUI.tabs.maintenance.ignore)
		alliances[myAlliance].turfAsAlliance = guiCheckBoxGetSelected(allianceGUI.tabs.maintenance.turfAsAlliance)
	end
end
groupInfoByID = {}

function pickColor()
	req()
end

function req()
	exports.cpicker:openPicker("alliance",false,"CSG ~ Pick a Alliance Turf Color")
end

function cpick(id,hex,r,g,b)
	if id == "alliance" then
		triggerServerEvent("CSGalliance.newcolor",localPlayer,myAlliance,r,g,b)
	end
end
addEvent("onColorPickerOK",true)
addEventHandler("onColorPickerOK",root,cpick)

function getGroupInfoByID(groupID)
	if groupID then
		if groupInfoByID[groupID] then
			return groupInfoByID[groupID]
		end
	end
end
addEvent("alliances_client_updateAllianceInfo",true)
function updateAllianceInfo(allianceToEditID,index,newValue,newPlayerAlliance)
	if ( not index ) then
		alliances[allianceToEditID] = newValue
		if allianceToEditID == myAlliance and newValue == nil then
			guiSetSelectedTab(allianceGUI.tabpanel,allianceGUI.tabs.main[1])
		end
	elseif ( type(index) == "string" ) and newValue then
		alliances[allianceToEditID][index] = newValue
	end
	if newPlayerAlliance then
		myAlliance = newPlayerAlliance
	elseif allianceToEditID == myAlliance and not alliances[allianceToEditID] then
		myAlliance = nil
	end
	updateAllianceGUI(alliances,myAlliance)
end
addEventHandler("alliances_client_updateAllianceInfo",root,updateAllianceInfo)

function updateAllianceGUI(alliances,myAllianceID,settingsAvailable)
	local aclList = getAliancesACL ()
	local originalAlliances = table.copy(alliances)
	originalAlliances["empty"] = nil
	local myLevel = 0
	if exports.server:getPlayerGroupID(localPlayer) and getElementData(localPlayer,"GroupRank") == "Group founder" then
		myLevel = 1
	end
	if myAllianceID then
		myLevel = 2
	end
	if myAllianceID and getElementData(localPlayer,"GroupRank") == "Group founder" then
		myLevel = 3
	end
	if myAllianceID and getElementData(localPlayer,"GroupRank") == "Group founder" and alliances[myAllianceID].founderGroup == exports.server:getPlayerGroupID(localPlayer) then
		myLevel = 4
	end
	for i=1,#aclList do
		local element,startLevel,endLevel = unpack(aclList[i])
		if element and startLevel then
			if myLevel >= startLevel and ( ( endLevel and myLevel <= endLevel ) or not endLevel ) then
				guiSetEnabled(element,true)
			else
				guiSetEnabled(element,false)
			end
		end
	end

	configuredSettings = {}
	for setting,_ in pairs(allianceSettings) do
 		configuredSettings[setting] = (alliances[myAllianceID] or {})[setting]

		guiCheckBoxSetSelected(allianceGUI.tabs.maintenance[setting],configuredSettings[setting] == true)
	end
	guiCheckBoxSetSelected(allianceGUI.tabs.main.enableAllianceBlips,(exports.DENsettings:getPlayerSetting("allianceblips")) )
	if not myAllianceID then myAllianceID = "empty" alliances[myAllianceID] = { groups = {} } end -- make empty table
	local founderGroupInfo = getGroupInfoByID(alliances[myAllianceID].founderGroup) or { }
	guiSetText(allianceGUI.tabs.main.createNewAllianceEdit,alliances[myAllianceID].name or "")
	guiSetText(allianceGUI.tabs.main.currentAlliance,alliances[myAllianceID].name or "None")
	local t = fromJSON(alliances[myAllianceID].rgb)
	if type(t) ~= "table" then t = {255,0,0} end
	local r,g,b = unpack(t)
	guiLabelSetColor(allianceGUI.tabs.main.currentAlliance,r,g,b)
	guiSetText(allianceGUI.tabs.main.currentAllianceMembers,alliances[myAllianceID].memberCount or "")
	guiSetText(allianceGUI.tabs.main.currentAllianceFounder,founderGroupInfo.groupname or "")
	guiSetText(allianceGUI.tabs.main.currentAllianceCreated,alliances[myAllianceID].dateCreated or "")
	guiSetText(allianceGUI.tabs.main.currentAllianceLastJoinDate,alliances[myAllianceID].dateLastJoin or "")

	if #alliances[myAllianceID].groups <= 1 then
		guiSetText(allianceGUI.tabs.main.leaveAlliance,"Delete ( leave ) alliance")
	else
		guiSetText(allianceGUI.tabs.main.leaveAlliance,"Leave alliance")
	end
	local balance = ""
	if alliances[myAllianceID].balance then balance = "$"..alliances[myAllianceID].balance end
	guiSetText(allianceGUI.tabs.main.currentAllianceBankBalance,balance)
		local myGroup = exports.server:getPlayerGroupID( localPlayer )
		local myGroupName = exports.server:getPlayerGroupName( localPlayer )
		guiSetText(allianceGUI.tabs.main.currentAllianceMyGroup,myGroupName or "")
		local groupNames = {}
		if alliances[myAllianceID].groups then
			for i=1,#alliances[myAllianceID].groups do
				table.insert(groupNames,getGroupInfoByID(alliances[myAllianceID].groups[i]).groupname)
			end
		end
	guiSetText(allianceGUI.tabs.main.currentAllianceGroups,table.concat(groupNames,", "))

	if myLevel >= 4 then
		guiSetEnabled(allianceGUI.tabs.maintenance.pickColor,true)
	else
		guiSetEnabled(allianceGUI.tabs.maintenance.pickColor,false)
		guiSetEnabled(allianceGUI.tabs.maintenance.kickGroup,false)
	end

	if myLevel >= 3 then
			guiSetEnabled(allianceGUI.tabs.maintenance.shareGates,true)
			guiSetEnabled(allianceGUI.tabs.maintenance.shareSpawners,true)
			guiSetEnabled(allianceGUI.tabs.maintenance.shareArmor,true)
			guiSetEnabled(allianceGUI.tabs.maintenance.forceBlips,true)
			guiSetEnabled(allianceGUI.tabs.maintenance.canDefend,true)
			guiSetEnabled(allianceGUI.tabs.maintenance.splitMoney,true)
			guiSetEnabled(allianceGUI.tabs.maintenance.ignore,true)
			guiSetEnabled(allianceGUI.tabs.maintenance.turfAsAlliance,true)
			guiSetEnabled(allianceGUI.tabs.bank.withdraw,true)

	else
			guiSetEnabled(allianceGUI.tabs.bank.withdraw,false)
			guiSetEnabled(allianceGUI.tabs.maintenance.shareGates,false)
			guiSetEnabled(allianceGUI.tabs.maintenance.shareSpawners,false)
			guiSetEnabled(allianceGUI.tabs.maintenance.shareArmor,false)
			guiSetEnabled(allianceGUI.tabs.maintenance.forceBlips,false)
			guiSetEnabled(allianceGUI.tabs.maintenance.canDefend,false)
			guiSetEnabled(allianceGUI.tabs.maintenance.splitMoney,false)
			guiSetEnabled(allianceGUI.tabs.maintenance.ignore,false)
			guiSetEnabled(allianceGUI.tabs.maintenance.turfAsAlliance,false)
	end

	-- groups tab
	guiGridListClear(allianceGUI.tabs.groups.groupGrid)
	for i=1,#alliances[myAllianceID].groups do
		local row = guiGridListAddRow(allianceGUI.tabs.groups.groupGrid)
		guiGridListSetItemText(allianceGUI.tabs.groups.groupGrid,row,1,getGroupInfoByID(alliances[myAllianceID].groups[i]).groupname,false,false)
		guiGridListSetItemText(allianceGUI.tabs.groups.groupGrid,row,2,getGroupInfoByID(alliances[myAllianceID].groups[i]).groupleader,false,false)
	end
	-- information tab
	guiSetText(allianceGUI.tabs.info.memo,alliances[myAllianceID].info or "")
	-- maintenance tab
	local allianceGroups = alliances[myAllianceID].groups or {}
	guiGridListClear(allianceGUI.tabs.maintenance.gridlist)
	for i=1,#allianceGroups do
		local row = guiGridListAddRow(allianceGUI.tabs.maintenance.gridlist)
		guiGridListSetItemText(allianceGUI.tabs.maintenance.gridlist,row,1,getGroupInfoByID(allianceGroups[i]).groupname,false,false)
		guiGridListSetItemData(allianceGUI.tabs.maintenance.gridlist,row,1,getGroupInfoByID(allianceGroups[i]).groupid)
		guiGridListSetItemText(allianceGUI.tabs.maintenance.gridlist,row,2,getGroupInfoByID(allianceGroups[i]).groupleader,false,false)
	end
	-- banking tab
	local balance = alliances[myAllianceID].balance or 0
	guiSetText(allianceGUI.tabs.bank.balance,"Last bank transactions: ( Current balance: $"..balance.." )")
	local transactions = alliances[myAllianceID].transactions or {}
	guiGridListClear(allianceGUI.tabs.bank.gridlist)
	for i=1,#transactions do
		local group = transactions[i][1]
		local groupInfo = getGroupInfoByID(group) or {groupname = tostring(group)}
		local amount = transactions[i][2]
		local transactionType = transactions[i][3]
		local transaction = guiGridListAddRow(allianceGUI.tabs.bank.gridlist)
		guiGridListSetItemText(allianceGUI.tabs.bank.gridlist,transaction,1,groupInfo.groupname,false,false)
		guiGridListSetItemText(allianceGUI.tabs.bank.gridlist,transaction,2,transactionType,false,false)
		guiGridListSetItemText(allianceGUI.tabs.bank.gridlist,transaction,3,"$",false,false)
		guiGridListSetItemText(allianceGUI.tabs.bank.gridlist,transaction,4,amount,false,true)
	end
	-- invites + alliances tab
	local invites = {}
	local inAlliance
	guiGridListRemoveColumn(allianceGUI.tabs.invites.gridlist,2)
	guiGridListRemoveColumn(allianceGUI.tabs.invites.gridlist,1)
	if alliances[myAllianceID].invites then
		invites = alliances[myAllianceID].invites
		inAlliance = true
		guiSetText(allianceGUI.tabs.invites.headerLabel,"Groups invited by your alliance:")
		guiGridListAddColumn(allianceGUI.tabs.invites.gridlist, "Group", 0.45)
		guiGridListAddColumn(allianceGUI.tabs.invites.gridlist, "Invited by", 0.45)
		guiSetText(allianceGUI.tabs.invites.rejectInvite,"Revoke invitation")
	else
		guiGridListAddColumn(allianceGUI.tabs.invites.gridlist, "Alliance", 0.45)
		guiGridListAddColumn(allianceGUI.tabs.invites.gridlist, "Invited by", 0.45)
		guiSetText(allianceGUI.tabs.invites.headerLabel,"Alliance invites:")
		guiSetText(allianceGUI.tabs.invites.rejectInvite,"Reject alliance invitation")
	end
	guiGridListClear(allianceGUI.tabs.invites.gridlist)
	guiGridListClear(allianceGUI.tabs.alliances.gridlist)

	for ID,allianceInfo in pairs(originalAlliances) do
		if allianceInfo then
			if not inAlliance then
				local invitedGroups = allianceInfo.invites or {}
				for i=1,#invitedGroups do
					if invitedGroups[i][1] == myGroup then
						table.insert(invites,{ ID,unpack(invitedGroups[i])})
					end
				end
			end
			-- alliances tab
			local allianceRow = guiGridListAddRow(allianceGUI.tabs.alliances.gridlist)
			guiGridListSetItemText(allianceGUI.tabs.alliances.gridlist,allianceRow,1,allianceInfo.name,false,false)
			if getGroupInfoByID(allianceInfo.founderGroup) ~= nil then
				guiGridListSetItemText(allianceGUI.tabs.alliances.gridlist,allianceRow,2,getGroupInfoByID(allianceInfo.founderGroup).groupname,false,false)
			else
				guiGridListSetItemText(allianceGUI.tabs.alliances.gridlist,allianceRow,2,"Not Available",false,false)

			end

			guiGridListSetItemText(allianceGUI.tabs.alliances.gridlist,allianceRow,3,#allianceInfo.groups,false,true)
		end
	end
	for i=1,#invites do
		local inviteRow = guiGridListAddRow(allianceGUI.tabs.invites.gridlist)
		local allianceID = invites[i][1]
		local groupID
		local invitedBy = invites[i][3]
		local data = allianceID
		if inAlliance then
			allianceID = myAllianceID
			groupID = invites[i][1]
			data = groupID
			invitedBy = invites[i][2]
		end
		local name = alliances[allianceID].name
		if inAlliance then
			name = getGroupInfoByID(groupID).groupname
		end
		local groupInfo = getGroupInfoByID(invitedBy) or {}
		guiGridListSetItemText(allianceGUI.tabs.invites.gridlist,inviteRow,1,name or "",false,false)
		guiGridListSetItemData(allianceGUI.tabs.invites.gridlist,inviteRow,1,data,false,false)
		guiGridListSetItemText(allianceGUI.tabs.invites.gridlist,inviteRow,2,groupInfo.groupname or "",false,false)
	end
end

function onClientHideAllianceGUI()

	showCursor(false)
	allianceGUIVisible = false
	guiSetVisible(allianceGUI.window,false)
	getNoteText_close()
	closeInviteGroupsGUI()
	alliance_closeConfirmGUI()
	-- manage alliance settings
	local changed = false
	local newValues = {}
	for setting,_ in pairs(allianceSettings) do
		if configuredSettings[setting] ~= guiCheckBoxGetSelected(allianceGUI.tabs.maintenance[setting]) then
			newValues[setting] = guiCheckBoxGetSelected(allianceGUI.tabs.maintenance[setting])
			changed = true
		end
	end
	if changed and myAlliance then
		triggerServerEvent("alliances_settingsAdjusted",localPlayer,myAlliance,newValues)
	end

end

function backToGroups()

	onClientHideAllianceGUI()
	setGroupWindowVisable ( unpack(groupInfo) )

end

function onClientOpenAllianceGUI()

	if requestingData then return false end
	triggerServerEvent("requestAllianceData",localPlayer)

end

addEvent("onRequestAllianceDataCallBack",true)
addEventHandler("onRequestAllianceDataCallBack",root,
	function (allianceInfo,myAllianceID,settingsAvailable)
		alliances = allianceInfo
		myAlliance = myAllianceID
		setGroupsWindowDisabled () -- hide F6
		if not isElement( allianceGUI.window ) then
			createAllianceGUI()
		else
			guiSetVisible(allianceGUI.window,true)
		end
		allianceSettings = settingsAvailable or allianceSettings
		updateAllianceGUI(allianceInfo,myAlliance)
		showCursor(true)
		allianceGUIVisible = true
	end
)
