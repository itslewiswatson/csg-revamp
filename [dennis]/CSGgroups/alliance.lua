--[[ todo:
DONE *Set alliance founder
DONE *Delete Alliance
DONE *Disable leave alliance
DONE *Show invited groups in invites tab
DONE *Update GUI after any action which requires it.
DONE *Make alliance data save(?)
DONE *Alliance chat
DONE *Banking buttons
DONE *Save alliance settings server-side, onGUIClose only if changed.
DONE *Alliance blips (?) < use settings, let alliance setting override player's setting
--]]

local alliances = {}
function createNewAlliance()
	if getElementData(localPlayer,"Group") == false then
		exports.dendxmsg:createNewDxMessage("Your not in a group!",255,0,0)
		return
	end
	local allianceName = guiGetText(allianceGUI.tabs.main.createNewAllianceEdit)
	for i=1,#alliances do
		if string.lower(alliances[i].name) == string.lower(allianceName) then
			exports.dendxmsg:createNewDxMessage("Alliance name already in use!",255,0,0)
			return false
		end
	end
	if not allianceName:match( '^[%w%s]*%w[%w%s]*$' ) then
		exports.dendxmsg:createNewDxMessage("Alliance name invalid!",255,0,0)
		return false
	elseif myAlliance then
		exports.dendxmsg:createNewDxMessage("Your group already is an alliance!",255,0,0)
		return false
	elseif getElementData(localPlayer,"GroupRank") == "Group founder" then
		if alliance_antiSpam('createAlliance',"creating an alliance") then
			triggerServerEvent("alliances_createNewAlliance",localPlayer,allianceName)
			alliance_setAntiSpam('createAlliance',20000)
			return true
		end
	else
		exports.dendxmsg:createNewDxMessage("Your are not group founder!",255,0,0)
		return false
	end
end

--
local confirmGUI = {}
function alliance_confirmActionGUI(funcToTrigger,labelText,windowTitle, authenticate)
	if not isElement(confirmGUI.window) then
		confirmGUI.authenticate = authenticate
		confirmGUI.funcToTrigger = funcToTrigger
		if authenticate then
			confirmGUI.window = guiCreateWindow(530,328,239,166,windowTitle,false)
			guiCreateLabel(87,25,62,17,"Username:",false,confirmGUI.window)
			local username = guiCreateEdit(10,45,220,20,tostring(exports.server:getPlayerAccountName(localPlayer)),false,confirmGUI.window)
			guiSetEnabled(username,false)
			guiCreateLabel(87,72,62,17,"Password:",false,confirmGUI.window)
			confirmGUI.password = guiCreateEdit(10,91,220,20,"",false,confirmGUI.window)
			guiEditSetMasked( confirmGUI.password, true )
			confirmGUI.confirm = guiCreateButton(11,115,218,19,"Yes",false,confirmGUI.window)
			confirmGUI.cancel = guiCreateButton(11,138,218,19,"No",false,confirmGUI.window)
		else
			confirmGUI.window = guiCreateWindow(622,413,255,112,windowTitle,false)
			confirmGUI.label = guiCreateLabel(36,28,190,17,labelText,false,confirmGUI.window)
			confirmGUI.confirm = guiCreateButton(9,56,237,21,"Yes",false,confirmGUI.window)
			confirmGUI.cancel = guiCreateButton(9,80,237,21,"No",false,confirmGUI.window)
		end
		addEventHandler("onClientGUIClick",confirmGUI.confirm,alliance_confirmAction,false)
		addEventHandler("onClientGUIClick",confirmGUI.cancel,alliance_closeConfirmGUI,false)
		centerWindow(confirmGUI.window)
	else
		alliance_closeConfirmGUI()
	end
end

function alliance_confirmAction()
	if isElement(confirmGUI.window) then
		local pass
		if confirmGUI.authenticate then
			pass = guiGetText(confirmGUI.password)
			if ( pass:match( "^%s*$" ) ) then exports.DENdxmsg:createNewDxMessage( "You didn't enter a password!", 225, 0, 0 ) return false end
		end
		confirmGUI.funcToTrigger(pass)
		alliance_closeConfirmGUI()
	end
end

function alliance_closeConfirmGUI()
	if isElement(confirmGUI.window) then
		destroyElement(confirmGUI.window)
	end
end

--

function leaveAlliance()
	triggerServerEvent("alliances_leaveAlliance",localPlayer,myAlliance)
end

function deleteAlliance(password)
	triggerServerEvent("alliances_deleteAlliance",localPlayer,myAlliance,tostring(exports.server:getPlayerAccountName(localPlayer)),password)
end

function setAllianceFounder(password)
	local selected = getSelectedGroupInMaintenanceTab()
	if selected then
		triggerServerEvent("alliances_setNewFounder",localPlayer,myAlliance,selected,tostring(exports.server:getPlayerAccountName(localPlayer)),password)
	end
end

function updateInformation()
	local newText = guiGetText(allianceGUI.tabs.info.memo)
	if newText ~= alliances[myAlliance].info then
		if alliance_antiSpam('updateInfo',"updating alliance information") then
			triggerServerEvent("alliances_updateInfo",localPlayer,myAlliance,newText)
			alliance_setAntiSpam('updateInfo',5000)
			alliances[myAlliance].info = newText
			exports.dendxmsg:createNewDxMessage("Alliance information succesfully updated!",0,255,0)
		end
	else
		exports.dendxmsg:createNewDxMessage("This text is already stored!",255,0,0)
	end
end
getNoteTextGUI = {}
local antiNoteSpam
function getNoteText(funcToTrigger,toWho)
	if not isElement(getNoteTextGUI.window) then
		getNoteTextGUI.funcToTrigger = funcToTrigger
		getNoteTextGUI.window = guiCreateWindow(314,366,364,98,"Send a note to "..tostring(toWho),false)
		centerWindow(getNoteTextGUI.window)
		getNoteTextGUI.edit = guiCreateEdit(9,24,346,32,"",false,getNoteTextGUI.window)
		getNoteTextGUI.send = guiCreateButton(10,58,176,30,"Send Message",false,getNoteTextGUI.window)
		getNoteTextGUI.cancel = guiCreateButton(190,58,165,30,"Close Window",false,getNoteTextGUI.window)
		addEventHandler("onClientGUIClick",getNoteTextGUI.cancel,getNoteText_close,false)
		addEventHandler("onClientGUIClick",getNoteTextGUI.send,getNoteText_send,false)
	else
		getNoteText_close()
	end
end

function getNoteText_close()
	if isElement(getNoteTextGUI.window) then
		destroyElement(getNoteTextGUI.window)
	end
end

function getNoteText_send()
	if isElement(getNoteTextGUI.window) then
		local text = guiGetText(getNoteTextGUI.edit)
		if ( text:match( "^%s*$" ) ) or ( #text < 1 ) then
			exports.dendxmsg:createNewDxMessage("You didn't enter a valid message!", 225, 0, 0 )
		elseif alliance_antiSpam('note',"sending another note") then
			getNoteTextGUI.funcToTrigger(text)
			alliance_setAntiSpam('note',10000)
			getNoteText_close()
		end
	end
end

function noteAllMembers(text)
	local groups = {}
	for i=1,#alliances[myAlliance].groups do
		table.insert(groups,getGroupInfoByID(alliances[myAlliance].groups[i]).groupname)
	end
	triggerServerEvent("alliances_noteGroup",localPlayer,groups,text)
end

function getSelectedGroupInMaintenanceTab()
	local row,_ = guiGridListGetSelectedItem(allianceGUI.tabs.maintenance.gridlist)
	if ( row ) and ( row > -1 ) then
		local groupID = guiGridListGetItemData(allianceGUI.tabs.maintenance.gridlist,row,1)
		return groupID
	else
		exports.dendxmsg:createNewDxMessage("You didn't select a group!", 225, 0, 0 )
	end
end

function noteGroup(text)
	local selected = getSelectedGroupInMaintenanceTab()
	if selected then
		triggerServerEvent("alliances_noteGroup",localPlayer,getGroupInfoByID(selected).groupname,text)
	end
end

local inviteGroupGUI = {}
function inviteGroups()
	if not isElement(inviteGroupGUI.window) then
		inviteGroupGUI.window = guiCreateWindow(340,333,291,434,"Invite a new group",false)
		centerWindow ( inviteGroupGUI.window )
		inviteGroupGUI.edit = guiCreateEdit(9,24,273,24,"",false,inviteGroupGUI.window)
		inviteGroupGUI.grid = guiCreateGridList(9,49,272,348,false,inviteGroupGUI.window)
			guiGridListAddColumn(inviteGroupGUI.grid,"Name",0.7)
			guiGridListAddColumn(inviteGroupGUI.grid,"Members",0.2)
		inviteGroupGUI.invite = guiCreateButton(9,401,134,24,"Invite group",false,inviteGroupGUI.window)
		inviteGroupGUI.close = guiCreateButton(146,401,134,24,"Close window",false,inviteGroupGUI.window)
		fillInviteGroupGrid(nil)

		addEventHandler("onClientGUIClick",inviteGroupGUI.invite,inviteSelectedGroup,false)
		addEventHandler("onClientGUIClick",inviteGroupGUI.close,closeInviteGroupsGUI,false)
		addEventHandler("onClientGUIChanged",inviteGroupGUI.edit,function () fillInviteGroupGrid(guiGetText(source)) end,false)
	else
		closeInviteGroupsGUI()
	end
end

function fillInviteGroupGrid(filter)
	if isElement(inviteGroupGUI.grid) then
		guiGridListClear(inviteGroupGUI.grid)
		local allianceGroups = {}
		if ( alliances[myAlliance] ) then
			allianceGroups = alliances[myAlliance].groups
		end
		local ignoredGroups = {}
		if (alliances[myAlliance]) then
		for i=1,#allianceGroups do
			ignoredGroups[allianceGroups[i]] = true
		end
		for i=1,#alliances[myAlliance].invites do
			ignoredGroups[alliances[myAlliance].invites[i][1]] = true
		end
		end
		for i=1,#groupInfo[1] do
			if not ignoredGroups[groupInfo[1][i].groupid] and ( not filter or string.find(groupInfo[1][i].groupname:lower(),filter:lower()) ) then
				if groupInfo[1][i].groupname ~= getElementData(localPlayer,"Group") then
					local row = guiGridListAddRow(inviteGroupGUI.grid)
					guiGridListSetItemText(inviteGroupGUI.grid,row,1,groupInfo[1][i].groupname,false,false)
					guiGridListSetItemData(inviteGroupGUI.grid,row,1,groupInfo[1][i].groupid)
					guiGridListSetItemText(inviteGroupGUI.grid,row,2,groupInfo[1][i].membercount,false,true)
				end
			end
		end
	end
end

function inviteSelectedGroup()
	local selectedRow,_ = guiGridListGetSelectedItem(inviteGroupGUI.grid)
	if ( selectedRow ) and ( selectedRow > -1 ) then
		if alliance_antiSpam('invite',"inviting another group") then
			triggerServerEvent("alliances_inviteGroup",localPlayer,myAlliance,guiGridListGetItemData(inviteGroupGUI.grid,selectedRow,1))
			alliance_setAntiSpam('invite',10000)
			closeInviteGroupsGUI()
		end
	end
end

function closeInviteGroupsGUI()
	if isElement(inviteGroupGUI.window) then
		destroyElement(inviteGroupGUI.window)
	end
end

local antiSpamTimers = {}
function alliance_antiSpam(id,action)
	if isTimer(antiSpamTimers[id]) then
		local timeLeft,_,_ = getTimerDetails(antiSpamTimers[id])
		exports.dendxmsg:createNewDxMessage("Please wait "..math.ceil((timeLeft or 1000)/1000).." seconds before "..action.."!", 225, 0, 0 )
		return false
	else
		return true
	end
end
function alliance_setAntiSpam(id,theTime)
	if isTimer(antiSpamTimers[id]) then killTimer(antiSpamTimers[id]) end
	antiSpamTimers[id] = setTimer(function () end, theTime, 1 )
end

function kickGroup()
	local selected = getSelectedGroupInMaintenanceTab()
	if selected then
		if selected ~= exports.server:getPlayerGroupID(localPlayer) then
			triggerServerEvent("alliances_kickGroup",localPlayer,myAlliance,selected)
		else
			exports.dendxmsg:createNewDxMessage("You can't kick your own group, use the leave alliance button instead.", 225, 0, 0 )
		end
	end
end

function alliance_getSelectedInvitation()
	local row,_ = guiGridListGetSelectedItem(allianceGUI.tabs.invites.gridlist)
	if ( row ) and ( row > -1 ) then
		local allianceID = guiGridListGetItemData(allianceGUI.tabs.invites.gridlist,row,1)
		return allianceID
	else
		exports.dendxmsg:createNewDxMessage("You didn't select an invitation!", 225, 0, 0 )
	end
end

function alliance_acceptInvitation()
	local invitation = alliance_getSelectedInvitation()
	if invitation then
		triggerServerEvent("alliances_acceptInvite",localPlayer,invitation,exports.server:getPlayerGroupID(localPlayer))
	end
end

function alliance_rejectInvitation()
	local invitation = alliance_getSelectedInvitation()
	if invitation then
		if alliances[myAlliance].invites then
			triggerServerEvent("alliances_removeInvite",localPlayer,myAlliance,invitation,false,"Invitation revoked!")
		else
			triggerServerEvent("alliances_removeInvite",localPlayer,invitation,exports.server:getPlayerGroupID(localPlayer),false,"Invitation rejected!")
		end
	end
end

function alliance_bankGetAmount()
	local theMoney = guiGetText(allianceGUI.tabs.bank.amount)
	theMoney:gsub(" ","")
	if ( not tonumber( theMoney ) ) then
		exports.DENdxmsg:createNewDxMessage( "You didn't enter a valid amount!", 200, 0, 0 )
	elseif tonumber(theMoney) <= 0 then
		exports.DENdxmsg:createNewDxMessage( "The amount must be more than $0!", 200, 0, 0 )
	elseif ( getPlayerMoney() - tonumber( theMoney ) < 0 ) then
		exports.DENdxmsg:createNewDxMessage( "You don't have enough money to deposit on the groupbank!", 200, 0, 0 )
	elseif not ( string.match( theMoney, '^%d+$' ) ) then
		exports.DENdxmsg:createNewDxMessage( "You didn't enter a valid amount!", 200, 0, 0 )
	elseif ( alliance_antiSpam('bank','making another transaction') ) then
		guiSetText( allianceGUI.tabs.bank.amount, "" )
		alliance_setAntiSpam('bank',10000)
		return tonumber(theMoney)
	end
end

function alliance_withdrawFromBank()
	local amount = alliance_bankGetAmount()
	if type(amount) == "number" then
		triggerServerEvent( "alliances_bank", localPlayer, myAlliance,'withdraw',amount )
	end
end

function alliance_depositToBank()
	local amount = alliance_bankGetAmount()
	if type(amount) == "number" then
		triggerServerEvent( "alliances_bank", localPlayer, myAlliance,'deposit',amount )
	end
end

-- get info

function alliances_getAllianceSettings(allianceID)
	triggerServerEvent("alliances_getAllianceSettings",localPlayer,allianceID)
end

addEvent("alliances_receiveAllianceSettings",true)
