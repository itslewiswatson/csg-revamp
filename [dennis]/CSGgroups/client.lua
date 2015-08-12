
groupInfo = {}

-- The bind to open the groups window
bindKey( "F6", "down",
	function ()
		if ( exports.server:isPlayerLoggedIn( localPlayer ) ) and not requestingData then
			if ( allianceGUIVisible ) then
				onClientHideAllianceGUI()
			elseif ( getGroupWindowVisable () ) then
				setGroupsWindowDisabled ()
			else
				clearAllGroupGrids ()
				onRequestGroupsData ()
				guiSetInputMode("no_binds_when_editing")
			end
		end
	end
)

addCommandHandler("groupsmenu",	function ()
		if ( exports.server:isPlayerLoggedIn( localPlayer ) ) and not requestingData then
			if ( allianceGUIVisible ) then
				onClientHideAllianceGUI()
			elseif ( getGroupWindowVisable () ) then
				setGroupsWindowDisabled ()
			else
				clearAllGroupGrids ()
				onRequestGroupsData ()
				guiSetInputMode("no_binds_when_editing")
			end
		end
	end
)

-- Request all the group data
function onRequestGroupsData ()
	requestingData = true
	triggerServerEvent( "requestGroupsData", localPlayer )
	exports.dendxmsg:createNewDxMessage("Group panel loading...",0,255,0)
end

-- Callback from the quest function
addEvent( "onRequestGroupDataCallback", true )
addEventHandler( "onRequestGroupDataCallback", root,
	function ( ... )
		groupInfo = {...}
		groupInfoByID = {}
		local groupsTable, invitesTable, memberTable, bankingTable, membersTable, groupID = unpack(groupInfo)
		setGroupWindowVisable ( groupsTable, invitesTable, memberTable, bankingTable, membersTable, groupID )
		requestingData = false
		for i=1,#groupInfo[1] do
			groupInfoByID[groupInfo[1][i].groupid] = groupInfo[1][i]
		end
	end
)

-- Compare the timestamp for the memberlist
function compareTimestampDays ( timeStamp )
	local theStamp = ( getRealTime().timestamp - timeStamp )
	if ( theStamp <= 86400 ) then
		local hours = math.floor( ( theStamp / 3600  ) )
		if ( hours == 1 ) then
			return hours.." hour ago"
		elseif ( hours == -1 ) then
			return "0 hours ago"
		else
			return hours.." hours ago"
		end
	else
		local days = math.floor( ( theStamp / 86400 ) )
		if ( timeStamp == 99999 ) then
			return "Unknown"
		elseif ( days == 1 ) then
			return days.." day ago"
		else
			return days.." days ago"
		end
	end
end

-- Convert a time stamp
function timestampConvert ( timeStamp )
	local time = getRealTime( timeStamp )
	local year = time.year + 1900
	local month = time.month + 1
	local day = time.monthday
	local hour = time.hour
	local minute = time.minute
	local second = time.second

	return "" .. year .."-" .. month .."-" .. day .." " .. hour ..":" .. minute ..":" .. second ..""
end

-- Event when the client wants to make a new group
function onClientCreateNewGroup ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local groupName = guiGetText( CSGGroupsGUI[5] )
	if ( getElementData( localPlayer, "Group" ) ) then
		exports.DENdxmsg:createNewDxMessage( "You're already in a group, leave this group first before creating a new group!", 200, 0, 0 )
	elseif ( groupName:match( '^[%w%s]*%w[%w%s]*$' ) ) then
		triggerServerEvent( "onServerCreateNewGroup", localPlayer, groupName )
		guiSetText( CSGGroupsGUI[5], "" )
	else
		exports.DENdxmsg:createNewDxMessage( "Group name contains illegal characters.", 200, 0, 0 )
	end
end

-- When a player wants to leave the group
function onClientLeaveGroup ()
	triggerServerEvent( "onServerLeaveGroup", localPlayer )
end

-- Event to update the group information
local groupInfoSpam = false

function onClientUpdateGroupInformation ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local groupInformation = guiGetText( CSGGroupsGUI[33] )
	if ( groupInfoSpam ) and ( getTickCount()-groupInfoSpam < 6000 ) then
		exports.DENdxmsg:createNewDxMessage( "Due preventing spam you need to wait a few seconds to do this!", 200, 0, 0 )
	else
		triggerServerEvent( "onServerUpdateGroupInformation", localPlayer, groupInformation )
		groupInfoSpam = getTickCount()
	end
end

-- Event to deposite money to the bank of the group
local groupDepositSpam = false

function onClientGroupBankingDeposit ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local theMoney = guiGetText( CSGGroupsGUI[55] )
	if ( groupDepositSpam ) and ( getTickCount()-groupDepositSpam < 6000 ) then
		exports.DENdxmsg:createNewDxMessage( "Due to anti spam you need to wait a few seconds to do this!", 200, 0, 0 )
	elseif ( getPlayerMoney() - tonumber( theMoney ) < 0 ) then
		exports.DENdxmsg:createNewDxMessage( "You don't have enough money to deposit on the groupbank!", 200, 0, 0 )
	elseif ( string.match( theMoney, '^%d+$' ) ) then
		if tonumber(theMoney) <= 0 then
			exports.DENdxmsg:createNewDxMessage( "You can't deposit $0 or less!", 200, 0, 0 )
			return
		end
		triggerServerEvent( "onServerGroupBankingDeposit", localPlayer, theMoney )
		guiSetText( CSGGroupsGUI[55], "" )
		groupDepositSpam = getTickCount()
	else
		exports.DENdxmsg:createNewDxMessage( "You didn't enter a valid amount of money!", 200, 0, 0 )
	end
end

-- Event to withdraw money from the bank
local groupWithdrawSpam = false

function onClientGroupBankingWithdraw ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local theMoney = guiGetText( CSGGroupsGUI[55] )
	if ( groupWithdrawSpam ) and ( getTickCount()-groupWithdrawSpam < 6000 ) then
		exports.DENdxmsg:createNewDxMessage( "Due to anti spam you need to wait a few seconds to do this!", 200, 0, 0 )
	elseif ( string.match( theMoney, '^%d+$' ) ) then

		triggerServerEvent( "onServerGroupBankingWithdrawn", localPlayer, theMoney )
		guiSetText( CSGGroupsGUI[55], "" )
		groupWithdrawSpam = getTickCount()
	else
		exports.DENdxmsg:createNewDxMessage( "You didn't enter a valid amount of money!", 200, 0, 0 )
	end
end

-- Event that get triggerd after the player did a transaction
addEvent( "onClientUpdateGroupBalance", true )
addEventHandler( "onClientUpdateGroupBalance", root,
	function ( theMoney, amount, rowType, thePlayer )
		local CSGGroupsGUI = getGroupsTableGUI ()
		if ( CSGGroupsGUI ) then guiSetText( CSGGroupsGUI[25], "$"..exports.server:convertNumber( theMoney ) ) end
		if ( CSGGroupsGUI ) then guiSetText( CSGGroupsGUI[51], "Last bank transactions: (Current balance: $"..exports.server:convertNumber( theMoney )..")" ) end

		local row = guiGridListInsertRowAfter ( CSGGroupsGUI[52], -1 )
		guiGridListSetItemText( CSGGroupsGUI[52], row, 1, timestampConvert ( getRealTime().timestamp ), false, false )
		guiGridListSetItemText( CSGGroupsGUI[52], row, 2, getPlayerName( thePlayer ).." " .. rowType .. " $"..amount, false, false )
	end
)

-- Event when a player accepts a group invite
function onClientAcceptGroupInvite ()
	local theGroup = getElementData( localPlayer, "Group" )
	if ( theGroup ) then
		exports.DENdxmsg:createNewDxMessage( "You are already in a group, you can't join more then one group!", 200, 0, 0 )
	else
		local CSGGroupsGUI = getGroupsTableGUI ()
		local row, column = guiGridListGetSelectedItem ( CSGGroupsGUI[58] )
		if ( tostring( row ) ~= "-1" ) and ( tostring( column ) ~= "-1" ) then
			local groupID = guiGridListGetItemData( CSGGroupsGUI[58], row, 1 )
			triggerServerEvent( "onServerAcceptGroupInvite", localPlayer, groupID )
			guiGridListClear ( CSGGroupsGUI[58] )
		else
			exports.DENdxmsg:createNewDxMessage( "You didn't select a invite from the list!", 200, 0, 0 )
		end
	end
end

-- Event when a player deletes a group invite
function onClientDeleteGroupInvite ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local row, column = guiGridListGetSelectedItem ( CSGGroupsGUI[58] )
	if ( tostring( row ) ~= "-1" ) and ( tostring( column ) ~= "-1" ) then
		local groupID = guiGridListGetItemData( CSGGroupsGUI[58], row, 1 )
		triggerServerEvent( "onServerDeleteGroupInvite", localPlayer, groupID )
		guiGridListRemoveRow ( CSGGroupsGUI[58], row )
	else
		exports.DENdxmsg:createNewDxMessage( "You didn't select a invite from the list!", 200, 0, 0 )
	end
end

-- Function when the player cancels the leave
function onClientCancelLeave ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[82], false )
	guiBringToFront( CSGGroupsGUI[1] )
end

-- Fuction to show the leave window popup
function onClientShowLeavePopup ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[82], true )
	guiBringToFront( CSGGroupsGUI[82] )
	guiSetProperty( CSGGroupsGUI[82], "AlwaysOnTop", "True" )
end

-- Send notes functions
function onClientNoteToPlayer ()
	local theReciever = getSelectedMaintenanceTabPlayer ()
	if ( theReciever ) then
		local CSGGroupsGUI = getGroupsTableGUI ()
		guiSetVisible( CSGGroupsGUI[78], true )
		guiBringToFront( CSGGroupsGUI[78] )
		guiSetProperty( CSGGroupsGUI[78], "AlwaysOnTop", "True" )
	else
		exports.DENdxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
	end
end

function onClientNoteToAllPlayers ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[74], true )
	guiBringToFront( CSGGroupsGUI[74] )
	guiSetProperty( CSGGroupsGUI[74], "AlwaysOnTop", "True" )
end

function onClientCancelNoteToPlayer ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[78], false )
	guiSetText( CSGGroupsGUI[79], "" )
end

function onClientCancelNoteToAllPlayers ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[74], false )
	guiSetText( CSGGroupsGUI[75], "" )
end

local noteToPlayerSpam = false

function onClientSendNoteToPlayer ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local theMessage = guiGetText( CSGGroupsGUI[79] )
	if ( noteToPlayerSpam ) and ( getTickCount()-noteToPlayerSpam < 6000 ) then
		exports.DENdxmsg:createNewDxMessage( "Due preventing spam you need to wait a few seconds to do this!", 200, 0, 0 )
	elseif ( theMessage:match( "^%s*$" ) ) then
		exports.DENdxmsg:createNewDxMessage( "You didn't enter a message!", 225, 0, 0 )
	else
		local theReciever = getSelectedMaintenanceTabPlayer ()
		if ( theReciever ) then
			triggerServerEvent( "onServerSendNoteToPlayer", localPlayer, theReciever, theMessage )
			guiSetVisible( CSGGroupsGUI[78], false )
			guiSetText( CSGGroupsGUI[79], "" )
			noteToPlayerSpam = getTickCount()
		else
			guiSetVisible( CSGGroupsGUI[78], false )
			guiSetText( CSGGroupsGUI[79], "" )
		end
	end
end

local noteToAllPlayersSpam = false

function onClientSendNoteToAllPlayers ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local theMessage = guiGetText ( CSGGroupsGUI[75] )
	if ( noteToAllPlayersSpam ) and ( getTickCount()-noteToAllPlayersSpam < 6000 ) then
		exports.DENdxmsg:createNewDxMessage( "Due preventing spam you need to wait a few seconds to do this!", 200, 0, 0 )
	elseif ( theMessage:match( "^%s*$" ) ) then
		exports.DENdxmsg:createNewDxMessage( "You didn't enter a message!", 225, 0, 0 )
	else
		triggerServerEvent( "onServerSendNoteToAllPlayers", localPlayer, theMessage )
		guiSetVisible( CSGGroupsGUI[74], false )
		guiSetText( CSGGroupsGUI[75], "" )
		noteToAllPlayersSpam = getTickCount()
	end
end

-- Show the invite window
function onClientGroupInviteWindow ()
	local CSGGroupsGUI = getGroupsTableGUI ()

	guiGridListClear( CSGGroupsGUI[66] )
	for k, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if ( exports.server:getPlayerAccountID( thePlayer ) ) and not ( exports.server:getPlayerGroupID( thePlayer ) ) and not ( thePlayer == localPlayer ) then
			local thePlayTime = math.floor( ( exports.server:getPlayerPlayTime ( thePlayer ) / 60 ) )
			local row = guiGridListAddRow ( CSGGroupsGUI[66] )
			guiGridListSetItemText( CSGGroupsGUI[66], row, 1, getPlayerName( thePlayer ), false, false )
			guiGridListSetItemText( CSGGroupsGUI[66], row, 2, thePlayTime.." Hours", false, false )
		end
	end

	guiSetVisible( CSGGroupsGUI[64], true )
	guiBringToFront( CSGGroupsGUI[64] )
	guiSetProperty( CSGGroupsGUI[64], "AlwaysOnTop", "True" )
end

-- Event when the player searches a player from invites grid
function onClientGroupInviteSearch()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiGridListClear( CSGGroupsGUI[66] )
	local theName = guiGetText( CSGGroupsGUI[65] )
	for k, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if ( exports.server:getPlayerAccountID( thePlayer ) ) and not ( exports.server:getPlayerGroupID( thePlayer ) ) and not ( thePlayer == localPlayer ) then
			if ( string.find( getPlayerName( thePlayer ):lower(), theName:lower() ) ) then
				local thePlayTime = math.floor( ( exports.server:getPlayerPlayTime ( thePlayer ) / 60 ) )
				local row = guiGridListAddRow ( CSGGroupsGUI[66] )
				guiGridListSetItemText( CSGGroupsGUI[66], row, 1, getPlayerName( thePlayer ), false, false )
				guiGridListSetItemText( CSGGroupsGUI[66], row, 2, thePlayTime.." Hours", false, false )
			end
		end
	end
end

-- Event to cancel the invite
function onClientGroupInviteCancel ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[64], false )
	guiSetText( CSGGroupsGUI[65], "" )
end

-- Event to invite a player
local invitePlayerSpam = false

function onClientGroupInviteSend ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local thePlayer = getSelectedInviteTabPlayer ()
	if ( invitePlayerSpam ) and ( getTickCount()-invitePlayerSpam < 6000 ) then
		exports.DENdxmsg:createNewDxMessage( "Due preventing spam you need to wait a few seconds to do this!", 200, 0, 0 )
	else
		if ( thePlayer ) then
			triggerServerEvent( "onServerGroupInvitePlayer", localPlayer, thePlayer )
			guiSetVisible( CSGGroupsGUI[64], false )
			invitePlayerSpam = getTickCount()
		else
			exports.DENdxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
		end
	end
end

-- Event for kicking a player
local kickPlayerSpam = false

function onClientGroupKickPlayer ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local groupRanks = getGroupRankACL ()
	local thePlayer, accountName = getSelectedMaintenanceTabPlayer ()
	local row, column = guiGridListGetSelectedItem ( CSGGroupsGUI[37] )
	if ( tostring( row ) == "-1" ) and ( tostring( column ) == "-1" ) then
		exports.DENdxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
	elseif ( kickPlayerSpam ) and ( getTickCount()-kickPlayerSpam < 6000 ) then
		exports.DENdxmsg:createNewDxMessage( "Due preventing spam you need to wait a few seconds to do this!", 200, 0, 0 )
	elseif ( accountName ) and ( accountName == exports.server:getPlayerAccountName( localPlayer ) ) then
		exports.DENdxmsg:createNewDxMessage( "You can't kick yourself!", 225, 0, 0 )
	else
		local playerRank = guiGridListGetItemData( CSGGroupsGUI[37], row, 1 )
		local clientRank = getElementData( localPlayer, "GroupRank" )
		if ( playerRank ) and ( clientRank ) then
			if ( groupRanks ) and ( groupRanks[clientRank] > groupRanks[playerRank] ) then
				if ( thePlayer ) and ( isElement( thePlayer ) ) then
					triggerServerEvent( "onServerGroupPlayerKicked", localPlayer, accountName, thePlayer )
					guiGridListRemoveRow( CSGGroupsGUI[37], row )
				else
					triggerServerEvent( "onServerGroupPlayerKicked", localPlayer, accountName, false )
					guiGridListRemoveRow( CSGGroupsGUI[37], row )
				end
				kickPlayerSpam = getTickCount()
			else
				exports.DENdxmsg:createNewDxMessage( "You can't kick this player!", 225, 0, 0 )
			end
		else
			exports.DENdxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
		end
	end
end

-- Change group turf color
function onClientGroupChangeTurfColor ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[100], true )
	guiBringToFront( CSGGroupsGUI[100] )
	guiSetProperty( CSGGroupsGUI[100], "AlwaysOnTop", "True" )
end

function onClientGroupCancelTurfColor ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[100], false )
end

function onClientGroupApplyTurfColor ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local R, G, B = guiGetText( CSGGroupsGUI[101] ), guiGetText( CSGGroupsGUI[104] ), guiGetText( CSGGroupsGUI[106] )
	if ( string.match( R,'^%d+$' ) ) and ( string.match( G,'^%d+$' ) ) and ( string.match( B,'^%d+$' ) ) then
		triggerServerEvent( "onServerGroupApplyTurfColor", localPlayer, R, G, B )
		guiLabelSetColor( CSGGroupsGUI[27], R, G, B )
		guiSetVisible( CSGGroupsGUI[100], false )
	else
		exports.DENdxmsg:createNewDxMessage( "A RGB color may only contain numeric characters!", 225, 0, 0 )
	end
end

function onClientTurfColorChange ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local R, G, B = guiGetText( CSGGroupsGUI[101] ), guiGetText( CSGGroupsGUI[104] ), guiGetText( CSGGroupsGUI[106] )
	if ( string.match( R,'^%d+$' ) ) and ( string.match( G,'^%d+$' ) ) and ( string.match( B,'^%d+$' ) ) then
		guiLabelSetColor( CSGGroupsGUI[107], R, G, B )
	else
		exports.DENdxmsg:createNewDxMessage( "A RGB color may only contain numeric characters!", 225, 0, 0 )
	end
end

-- Set new founder
function onClientGroupSetNewFounder ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local thePlayer, accountName = getSelectedMaintenanceTabPlayer ()
	if not ( accountName ) then
		exports.DENdxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
	elseif ( accountName ) and ( accountName == exports.server:getPlayerAccountName( localPlayer ) ) then
		exports.DENdxmsg:createNewDxMessage( "You are already the leader!", 225, 0, 0 )
	else
		guiSetVisible( CSGGroupsGUI[95], true )
		guiBringToFront( CSGGroupsGUI[95] )
		guiSetProperty( CSGGroupsGUI[95], "AlwaysOnTop", "True" )
	end
end

function onClientGroupCancelNewFounder ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[95], false )
end

function onClientGroupApplyNewFounder ()
	local thePlayer, accountName = getSelectedMaintenanceTabPlayer ()
	if ( thePlayer ) and ( isElement( thePlayer ) ) then
		triggerServerEvent( "onServerGroupApplyNewFounder", localPlayer, accountName, thePlayer )
	else
		triggerServerEvent( "onServerGroupApplyNewFounder", localPlayer, accountName, false )
	end

	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[95], false )
end

-- Promote and demote members
local proDeSpam = false

function onClientPromoteMember ()
	local thePlayer, accountName = getSelectedMaintenanceTabPlayer ()
	local playerRank = false

	local CSGGroupsGUI = getGroupsTableGUI ()
	local row, column = guiGridListGetSelectedItem ( CSGGroupsGUI[37] )
	if ( tostring( row ) ~= "-1" ) and ( tostring( column ) ~= "-1" ) then
		playerRank = guiGridListGetItemData( CSGGroupsGUI[37], row, 1 )
	end

	if not ( accountName ) or not ( playerRank ) then
		exports.DENdxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
	elseif ( accountName ) and ( accountName == exports.server:getPlayerAccountName( localPlayer ) ) then
		exports.DENdxmsg:createNewDxMessage( "You can't promote yourself!", 225, 0, 0 )
	elseif ( getGroupRankACL()[playerRank] +1 > 4 ) then
		exports.DENdxmsg:createNewDxMessage( "This person can't get a promotion anymore!", 225, 0, 0 )
	elseif ( proDeSpam ) and ( getTickCount()-proDeSpam < 6000 ) then
		exports.DENdxmsg:createNewDxMessage( "Due preventing spam you need to wait a few seconds to do this!", 200, 0, 0 )
	else
		proDeSpam = getTickCount()
		local newRank = ranknumberToName ()[getGroupRankACL()[playerRank] +1]
		triggerServerEvent( "onServerPromoteMember", localPlayer, thePlayer, accountName, newRank, row )
	end
end

function onClientDemoteMember ()
	local thePlayer, accountName = getSelectedMaintenanceTabPlayer ()
	local playerRank = false

	local CSGGroupsGUI = getGroupsTableGUI ()
	local row, column = guiGridListGetSelectedItem ( CSGGroupsGUI[37] )
	if ( tostring( row ) ~= "-1" ) and ( tostring( column ) ~= "-1" ) then
		playerRank = guiGridListGetItemData( CSGGroupsGUI[37], row, 1 )
	end

	if not ( accountName ) or not ( playerRank ) then
		exports.DENdxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
	elseif ( accountName ) and ( accountName == exports.server:getPlayerAccountName( localPlayer ) ) then
		exports.DENdxmsg:createNewDxMessage( "You can't demote yourself!", 225, 0, 0 )
	elseif ( getGroupRankACL()[playerRank] -1 < 1 ) then
		exports.DENdxmsg:createNewDxMessage( "This person can't get a demotion anymore!", 225, 0, 0 )
	elseif ( getGroupRankACL()[playerRank] == 5 ) then
		exports.DENdxmsg:createNewDxMessage( "You can't demote a founder!", 225, 0, 0 )
	elseif ( proDeSpam ) and ( getTickCount()-proDeSpam < 6000 ) then
		exports.DENdxmsg:createNewDxMessage( "Due preventing spam you need to wait a few seconds to do this!", 200, 0, 0 )
	else
		proDeSpam = getTickCount()
		local newRank = ranknumberToName ()[getGroupRankACL()[playerRank] -1]
		triggerServerEvent( "onServerDemoteMember", localPlayer, thePlayer, accountName, newRank, row )
	end
end

addEvent( "onClientUpdateRankRow", true )
addEventHandler( "onClientUpdateRankRow", root,
	function ( row, theRank )
		local CSGGroupsGUI = getGroupsTableGUI ()
		guiGridListSetItemData( CSGGroupsGUI[37], row, 1, theRank )
	end
)

-- Delete group
function onClientDeleteGroup ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[87], true )
	guiBringToFront( CSGGroupsGUI[87], true )
	guiSetText( CSGGroupsGUI[89], getGroupFounderAccountname () )
end

function onClientDeleteGroupConfirm ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local password = guiGetText( CSGGroupsGUI[92] )
	if ( password:match( "^%s*$" ) ) then
		exports.DENdxmsg:createNewDxMessage( "You didn't enter a password!", 225, 0, 0 )
	else
		triggerServerEvent( "onServerDeleteGroup", localPlayer, getGroupFounderAccountname (), password, getGroupID () )
	end
end

function onClientDeleteGroupCancel ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	guiSetVisible( CSGGroupsGUI[87], false )
	guiSetText( CSGGroupsGUI[92], "" )
	guiSetText( CSGGroupsGUI[89], "" )
end
