local CSGGroupsGUI = {}
local theFounderAccount = false
local theGroupID = false
nickToPlayer={}
exports.DENsettings:addPlayerSetting( "groupblips", "true" )
exports.DENsettings:addPlayerSetting( "grouptags", "false" )

function createGroupWindows ()
	-- Window
	CSGGroupsGUI[1] = guiCreateWindow(628,406,550,402,"Community of Social Gaming ~ Groups Management",false)
	setWindowPrefs ( CSGGroupsGUI[1] )
	CSGGroupsGUI[2] = guiCreateTabPanel(9,25,532,368,false,CSGGroupsGUI[1])
	-- Tab 1
	CSGGroupsGUI[3] = guiCreateTab("Main",CSGGroupsGUI[2])
	CSGGroupsGUI[4] = guiCreateButton(7,12,151,29,"Create new group",false,CSGGroupsGUI[3])
	CSGGroupsGUI[5] = guiCreateEdit(162,11,363,30,"",false,CSGGroupsGUI[3])
	CSGGroupsGUI[6] = guiCreateLabel(9,44,519,11,string.rep("-",128),false,CSGGroupsGUI[3])
	CSGGroupsGUI[7] = guiCreateLabel(9,64,130,16,"Your current group:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[8] = guiCreateLabel(9,91,130,16,"Member count:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[9] = guiCreateLabel(9,119,130,16,"Group founder:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[10] = guiCreateLabel(9,148,130,16,"Date created:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[11] = guiCreateLabel(9,177,130,16,"Date joined:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[12] = guiCreateLabel(9,207,130,16,"Group bank balance:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[13] = guiCreateLabel(9,236,130,16,"Your rank:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[14] = guiCreateLabel(9,283,519,11,string.rep("-",128),false,CSGGroupsGUI[3])
	CSGGroupsGUI[15] = guiCreateLabel(9,268,130,16,"Turf color:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[17] = guiCreateButton(7,304,151,29,"Leave group",false,CSGGroupsGUI[3])
	CSGGroupsGUI[18] = guiCreateCheckBox(167,304,139,29,"Enable group blips",false,false,CSGGroupsGUI[3])
	CSGGroupsGUI[19] = guiCreateCheckBox(303,304,213,29,"Enable red nametags for members",false,false,CSGGroupsGUI[3])
	CSGGroupsGUI[20] = guiCreateLabel(137,64,382,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[21] = guiCreateLabel(137,90,385,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[22] = guiCreateLabel(137,118,381,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[23] = guiCreateLabel(137,147,382,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[24] = guiCreateLabel(137,176,377,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[25] = guiCreateLabel(137,207,384,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[26] = guiCreateLabel(137,236,383,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[27] = guiCreateLabel(137,269,382,16,"N/A",false,CSGGroupsGUI[3])
	-- Tab 2
	CSGGroupsGUI[28] = guiCreateTab("Members",CSGGroupsGUI[2])
	CSGGroupsGUI[29] = guiCreateLabel(6,6,517,15,"All groups members and their status:",false,CSGGroupsGUI[28])
	CSGGroupsGUI[30] = guiCreateGridList(2,24,528,317,false,CSGGroupsGUI[28])
	-- Tab 3
	CSGGroupsGUI[31] = guiCreateTab("Information",CSGGroupsGUI[2])
	CSGGroupsGUI[32] = guiCreateLabel(6,6,115,16,"Group information:",false,CSGGroupsGUI[31])
	CSGGroupsGUI[33] = guiCreateMemo(3,22,526,293,"",false,CSGGroupsGUI[31])
	CSGGroupsGUI[34] = guiCreateButton(3,317,526,22,"Update group information (Group maintainers only)",false,CSGGroupsGUI[31])
	-- Tab 4
	CSGGroupsGUI[35] = guiCreateTab("Maintenance",CSGGroupsGUI[2])
	CSGGroupsGUI[36] = guiCreateLabel(6,6,185,14,"Group and member maintenace:",false,CSGGroupsGUI[35])
	CSGGroupsGUI[37] = guiCreateGridList(5,25,186,314,false,CSGGroupsGUI[35])
	CSGGroupsGUI[38] = guiCreateLabel(196,6,9,331,string.rep("|\n",30),false,CSGGroupsGUI[35])
	CSGGroupsGUI[39] = guiCreateButton(206,9,155,36,"Note to all members",false,CSGGroupsGUI[35])
	CSGGroupsGUI[40] = guiCreateButton(366,9,160,36,"Note to selected member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[41] = guiCreateButton(206,51,155,36,"Invite new member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[42] = guiCreateButton(206,132,155,36,"Promote member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[43] = guiCreateButton(366,132,160,36,"Demote member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[44] = guiCreateButton(206,174,155,36,"Kick member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[45] = guiCreateButton(206,258,155,36,"Change turf color",false,CSGGroupsGUI[35])
	CSGGroupsGUI[46] = guiCreateButton(366,258,160,36,"Delete group",false,CSGGroupsGUI[35])
	CSGGroupsGUI[47] = guiCreateButton(366,173,160,36,"Set new founder",false,CSGGroupsGUI[35])
	CSGGroupsGUI[48] = guiCreateLabel(207,318,319,20,"Trail, Member, Group staff, Group Leader, Group Founder",false,CSGGroupsGUI[35])
	CSGGroupsGUI[49] = guiCreateLabel(207,302,319,20,"Ranks:",false,CSGGroupsGUI[35])
	-- Tab 5
	CSGGroupsGUI[50] = guiCreateTab("Banking",CSGGroupsGUI[2])
	CSGGroupsGUI[51] = guiCreateLabel(7,8,377,18,"Last bank transactions: (Current balance: $0)",false,CSGGroupsGUI[50])
	CSGGroupsGUI[52] = guiCreateGridList(4,25,525,282,false,CSGGroupsGUI[50])
	CSGGroupsGUI[53] = guiCreateButton(383,309,145,30,"Withdraw",false,CSGGroupsGUI[50])
	CSGGroupsGUI[54] = guiCreateButton(232,309,147,30,"Deposit",false,CSGGroupsGUI[50])
	CSGGroupsGUI[55] = guiCreateEdit(4,310,226,29,"",false,CSGGroupsGUI[50])
	-- Tab 6
	CSGGroupsGUI[56] = guiCreateTab("Invites",CSGGroupsGUI[2])
	CSGGroupsGUI[57] = guiCreateLabel(7,7,394,16,"Group invites:",false,CSGGroupsGUI[56])
	CSGGroupsGUI[58] = guiCreateGridList(4,24,523,278,false,CSGGroupsGUI[56])
	CSGGroupsGUI[59] = guiCreateButton(4,305,260,34,"Accept group invite",false,CSGGroupsGUI[56])
	CSGGroupsGUI[60] = guiCreateButton(267,305,260,34,"Delete group invite",false,CSGGroupsGUI[56])
	-- Tab 7
	CSGGroupsGUI[61] = guiCreateTab("Groups",CSGGroupsGUI[2])
	CSGGroupsGUI[62] = guiCreateLabel(8,6,351,19,"All groups:",false,CSGGroupsGUI[61])
	CSGGroupsGUI[63] = guiCreateGridList(3,24,526,316,false,CSGGroupsGUI[61])
	-- Invites window
	CSGGroupsGUI[64] = guiCreateWindow(340,333,291,434,"Invite a new player",false)
	setWindowPrefs ( CSGGroupsGUI[64] )
	CSGGroupsGUI[65] = guiCreateEdit(9,24,273,24,"",false,CSGGroupsGUI[64])
	CSGGroupsGUI[66] = guiCreateGridList(9,49,272,348,false,CSGGroupsGUI[64])
	CSGGroupsGUI[67] = guiCreateButton(9,401,134,24,"Invite player",false,CSGGroupsGUI[64])
	CSGGroupsGUI[68] = guiCreateButton(146,401,134,24,"Close window",false,CSGGroupsGUI[64])
	-- Group created window
	CSGGroupsGUI[69] = guiCreateWindow(493,312,260,136,"Your group is created!",false)
	setWindowPrefs ( CSGGroupsGUI[69] )
	CSGGroupsGUI[70] = guiCreateLabel(38,27,196,16,"Your group is created!",false,CSGGroupsGUI[69])
	guiLabelSetColor( CSGGroupsGUI[70], 0, 225, 0 )
	CSGGroupsGUI[71] = guiCreateLabel(19,44,227,16,"Press F6 again to manage your group.",false,CSGGroupsGUI[69])
	CSGGroupsGUI[72] = guiCreateLabel(25,61,212,16,"For more information press F1!",false,CSGGroupsGUI[69])
	CSGGroupsGUI[73] = guiCreateButton(39,95,180,32,"Close",false,CSGGroupsGUI[69])
	-- Message to all players window
	CSGGroupsGUI[74] = guiCreateWindow(314,366,364,98,"Send a note to all group members",false)
	setWindowPrefs ( CSGGroupsGUI[74] )
	CSGGroupsGUI[75] = guiCreateEdit(9,24,346,32,"",false,CSGGroupsGUI[74])
	CSGGroupsGUI[76] = guiCreateButton(10,58,176,30,"Send Message",false,CSGGroupsGUI[74])
	CSGGroupsGUI[77] = guiCreateButton(190,58,165,30,"Close Window",false,CSGGroupsGUI[74])
	-- Message to selected player window
	CSGGroupsGUI[78] = guiCreateWindow(314,366,364,98,"Send a note to a selected member",false)
	setWindowPrefs ( CSGGroupsGUI[78] )
	CSGGroupsGUI[79] = guiCreateEdit(9,24,346,32,"",false,CSGGroupsGUI[78])
	CSGGroupsGUI[80] = guiCreateButton(10,58,176,30,"Send Message",false,CSGGroupsGUI[78])
	CSGGroupsGUI[81] = guiCreateButton(190,58,165,30,"Close Window",false,CSGGroupsGUI[78])
	-- Leave group window
	CSGGroupsGUI[82] = guiCreateWindow(622,413,255,112,"Leave group warning",false)
	setWindowPrefs ( CSGGroupsGUI[82] )
	CSGGroupsGUI[85] = guiCreateLabel(36,28,190,17,"Do you want to leave the group?",false,CSGGroupsGUI[82])
	CSGGroupsGUI[83] = guiCreateButton(9,56,237,21,"Yes, I want to leave",false,CSGGroupsGUI[82])
	CSGGroupsGUI[84] = guiCreateButton(9,80,237,21,"No, I changed my mind",false,CSGGroupsGUI[82])
	-- Delete group window
	CSGGroupsGUI[87] = guiCreateWindow(530,328,239,166,"Delete your group",false)
	setWindowPrefs ( CSGGroupsGUI[87] )
	CSGGroupsGUI[90] = guiCreateLabel(87,25,62,17,"Username:",false,CSGGroupsGUI[87])
	CSGGroupsGUI[89] = guiCreateEdit(10,45,220,20,"",false,CSGGroupsGUI[87])
	guiSetEnabled( CSGGroupsGUI[89], false )
	CSGGroupsGUI[91] = guiCreateLabel(87,72,62,17,"Password:",false,CSGGroupsGUI[87])
	CSGGroupsGUI[92] = guiCreateEdit(10,91,220,20,"",false,CSGGroupsGUI[87])
	guiEditSetMasked( CSGGroupsGUI[92], true )
	CSGGroupsGUI[93] = guiCreateButton(11,115,218,19,"Yes I want to delete the group",false,CSGGroupsGUI[87])
	CSGGroupsGUI[94] = guiCreateButton(11,138,218,19,"No I want to keep it",false,CSGGroupsGUI[87])
	-- Set new leader window
	CSGGroupsGUI[95] = guiCreateWindow(622,413,255,112,"Set new founder",false)
	setWindowPrefs ( CSGGroupsGUI[95] )
	CSGGroupsGUI[98] = guiCreateLabel(36,28,190,17,"Do you want to set a new founder?",false,CSGGroupsGUI[95])
	CSGGroupsGUI[96] = guiCreateButton(9,56,237,21,"Yes, I do",false,CSGGroupsGUI[95])
	CSGGroupsGUI[97] = guiCreateButton(9,80,237,21,"No, I changed my mind",false,CSGGroupsGUI[95])
	-- Choose turf color window
	CSGGroupsGUI[100] = guiCreateWindow(583,273,207,240,"Change the turfcolor",false)
	setWindowPrefs ( CSGGroupsGUI[100] )
	CSGGroupsGUI[101] = guiCreateEdit(59,40,88,22,"225",false,CSGGroupsGUI[100])
	CSGGroupsGUI[102] = guiCreateLabel(56,24,91,18,"Red:",false,CSGGroupsGUI[100])
	guiLabelSetColor(CSGGroupsGUI[102],225,0,0)
	CSGGroupsGUI[103] = guiCreateLabel(56,71,91,18,"Green:",false,CSGGroupsGUI[100])
	guiLabelSetColor(CSGGroupsGUI[103],0,225,0)
	CSGGroupsGUI[104] = guiCreateEdit(59,90,88,22,"225",false,CSGGroupsGUI[100])
	CSGGroupsGUI[105] = guiCreateLabel(56,121,91,18,"Blue:",false,CSGGroupsGUI[100])
	guiLabelSetColor(CSGGroupsGUI[105],0,0,225)
	CSGGroupsGUI[106] = guiCreateEdit(59,139,88,22,"225",false,CSGGroupsGUI[100])
	CSGGroupsGUI[107] = guiCreateLabel(8,175,192,17,"Turf color example",false,CSGGroupsGUI[100])
	CSGGroupsGUI[108] = guiCreateButton(10,203,92,25,"Save",false,CSGGroupsGUI[100])
	CSGGroupsGUI[109] = guiCreateButton(105,203,92,25,"Close",false,CSGGroupsGUI[100])

	CSGGroupsGUI[110] = guiCreateButton(425,260,92,30,"Alliances",false,CSGGroupsGUI[3]) -- alliance button
	-- Group members
	column1 = guiGridListAddColumn( CSGGroupsGUI[30], "Nick (Accountname):", 0.35 )
	column2 = guiGridListAddColumn( CSGGroupsGUI[30], "Rank:", 0.30 )
	column3 = guiGridListAddColumn( CSGGroupsGUI[30], "Activity:", 0.30 )
	-- Group maintenace
	column4 = guiGridListAddColumn( CSGGroupsGUI[37], "Nick (Accountname):", 0.90 )
	-- Group banking
	column5 = guiGridListAddColumn( CSGGroupsGUI[52], "Date:", 0.30 )
	column6 = guiGridListAddColumn( CSGGroupsGUI[52], "Transaction:", 0.60 )
	-- Group invites
	column7 = guiGridListAddColumn( CSGGroupsGUI[58], "Groupname:", 0.50 )
	column8 = guiGridListAddColumn( CSGGroupsGUI[58], "Invited by:", 0.40 )
	-- Groups
	column9 = guiGridListAddColumn( CSGGroupsGUI[63], "Groupname:", 0.40 )
	column10 = guiGridListAddColumn( CSGGroupsGUI[63], "Membercount:", 0.25 )
	column11 = guiGridListAddColumn( CSGGroupsGUI[63], "Leader:", 0.30 )
	-- Invite player
	column12 = guiGridListAddColumn( CSGGroupsGUI[66], "Nickname:", 0.30 )
	column13 = guiGridListAddColumn( CSGGroupsGUI[66], "Playtime:", 0.60 )

	-- Set some GUI data
	setGroupGUIData ()

	-- Leave group handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[17], onClientShowLeavePopup, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[84], onClientCancelLeave, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[83], onClientLeaveGroup, false )
	-- Close popup window
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[73], setGroupsWindowDisabled, false )
	-- Create new group handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[4] , onClientCreateNewGroup, false )
	-- Update group information handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[34], onClientUpdateGroupInformation, false )
	-- Group banking handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[54], onClientGroupBankingDeposit, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[53], onClientGroupBankingWithdraw, false )
	-- Group invites handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[59], onClientAcceptGroupInvite, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[60], onClientDeleteGroupInvite, false )
	-- Note to members handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[40], onClientNoteToPlayer, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[39], onClientNoteToAllPlayers, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[81], onClientCancelNoteToPlayer, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[77], onClientCancelNoteToAllPlayers, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[80], onClientSendNoteToPlayer, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[76], onClientSendNoteToAllPlayers, false )
	-- Invite member handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[41]  , onClientGroupInviteWindow, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[68]  , onClientGroupInviteCancel, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[67]  , onClientGroupInviteSend, false )
	-- Handlers for kicking
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[44], onClientGroupKickPlayer, false)
	-- Turf color change handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[45], onClientGroupChangeTurfColor, false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[108], onClientGroupApplyTurfColor, false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[109], onClientGroupCancelTurfColor, false)
	-- Set new leader handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[47], onClientGroupSetNewFounder, false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[97], onClientGroupCancelNewFounder, false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[96], onClientGroupApplyNewFounder , false)
	-- Promote and demote handler
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[42], onClientPromoteMember, false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[43], onClientDemoteMember , false)
	-- Delete group
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[46], onClientDeleteGroup , false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[93], onClientDeleteGroupConfirm , false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[94], onClientDeleteGroupCancel , false)
	-- Alliances
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[110], onClientOpenAllianceGUI , false)

end

-- Create all GUI elements on start of the resource
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function ()
		createGroupWindows()
	end
)

-- Get the GUI table
function getGroupsTableGUI ()
	return CSGGroupsGUI
end

-- Center the window and set is not visable untill we need it
function setWindowPrefs ( theWindow )
	guiWindowSetMovable ( theWindow, true )
	guiWindowSetSizable ( theWindow, false )
	guiSetVisible ( theWindow, false )

	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(theWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(theWindow,x,y,false)
end

-- Get the selected player in the maintenance tab
function getSelectedMaintenanceTabPlayer ()
	local theAccountName = nickToPlayer[guiGridListGetItemText ( CSGGroupsGUI[37], guiGridListGetSelectedItem ( CSGGroupsGUI[37] ), 1 )]
	local row, column = guiGridListGetSelectedItem ( CSGGroupsGUI[37] )
	if ( theAccountName ) and ( tostring( row ) ~= "-1" ) then
		local thePlayer = exports.server:getPlayerFromAccountname ( theAccountName )
		if ( thePlayer ) and ( isElement( thePlayer ) ) then
			return thePlayer, theAccountName
		else
			return false, theAccountName
		end
	else
		return false, false
	end
end

-- Get the selected member from the invites grid
function getSelectedInviteTabPlayer ()
	local thePlayerName = guiGridListGetItemText ( CSGGroupsGUI[66], guiGridListGetSelectedItem ( CSGGroupsGUI[66] ), 1 )
	if ( thePlayerName ) and ( getPlayerFromName( thePlayerName ) ) then
		return getPlayerFromName( thePlayerName )
	else
		return false
	end
end

-- Set some GUI element data
function setGroupGUIData ()
	for i=1,#CSGGroupsGUI do
		if i == 7 or i == 8 or i == 9 or i == 10 or i == 11 or i == 12 or i == 13 or i == 15 or i == 18 or i == 19 or i == 29 or i == 32 or i == 36 or i == 49 or i ==51 or i == 57 or i == 62 or i == 70 or i == 85 or i == 90 or i == 91 or i == 98 or i == 102 or i == 103 or i == 105 then
			guiSetFont(CSGGroupsGUI[i],"default-bold-small")
		end

		if i == 30 or i == 37 or i == 52 or i == 58 or i == 63 or i == 66 then
			guiGridListSetSelectionMode(CSGGroupsGUI[i],0)
		end

		if i == 70 or i == 71 or i == 72 or i == 102 or i == 103 or i == 105 or i == 107 then
			guiLabelSetHorizontalAlign(CSGGroupsGUI[i],"center",false)
		end
	end
end

-- Clear all the gridlists
function clearAllGroupGrids ()
	guiGridListClear ( CSGGroupsGUI[30] )
	guiGridListClear ( CSGGroupsGUI[37] )
	guiGridListClear ( CSGGroupsGUI[52] )
	guiGridListClear ( CSGGroupsGUI[58] )
	guiGridListClear ( CSGGroupsGUI[63] )
	guiGridListClear ( CSGGroupsGUI[66] )
end

-- Get the state of the groups window
function getGroupWindowVisable ()
	if ( guiGetVisible ( CSGGroupsGUI[1] ) ) then
		return true
	else
		return false
	end
end

-- Set the groups window disabled
function setGroupsWindowDisabled ()
	guiSetVisible ( CSGGroupsGUI[1] , false )
	guiSetVisible ( CSGGroupsGUI[69], false )
	guiSetVisible ( CSGGroupsGUI[64], false )
	guiSetVisible ( CSGGroupsGUI[74], false )
	guiSetVisible ( CSGGroupsGUI[78], false )
	guiSetVisible ( CSGGroupsGUI[82], false )
	guiSetVisible ( CSGGroupsGUI[87], false )
	guiSetVisible ( CSGGroupsGUI[95], false )
	guiSetVisible ( CSGGroupsGUI[100], false )
	showCursor( false )
end

-- Hide the group window though server
addEvent( "onClientFinishGroupCreate", true )
addEventHandler( "onClientFinishGroupCreate", root,
	function ( state )
		local state = state or false
		guiSetVisible ( CSGGroupsGUI[1] , false )
		guiSetVisible ( CSGGroupsGUI[69], state )
		guiSetVisible ( CSGGroupsGUI[64], false )
		guiSetVisible ( CSGGroupsGUI[74], false )
		guiSetVisible ( CSGGroupsGUI[78], false )
		guiSetVisible ( CSGGroupsGUI[82], false )
		guiSetVisible ( CSGGroupsGUI[87], false )
		guiSetVisible ( CSGGroupsGUI[95], false )
		guiSetVisible ( CSGGroupsGUI[100], false )
		showCursor( state )
	end
)

-- Hide the groups window
addEvent( "onClientHideGroupsWindow", true )
addEventHandler( "onClientHideGroupsWindow", root,
	function ()
		guiSetVisible ( CSGGroupsGUI[1] , false )
		guiSetVisible ( CSGGroupsGUI[82], false )
		showCursor( false )
	end
)

-- Reset the tabels
function resetGroupLabels ()
	guiSetText( CSGGroupsGUI[20], "N/A" )
	guiSetText( CSGGroupsGUI[21], "N/A" )
	guiSetText( CSGGroupsGUI[22], "N/A" )
	guiSetText( CSGGroupsGUI[23], "N/A" )
	guiSetText( CSGGroupsGUI[24], "N/A" )
	guiSetText( CSGGroupsGUI[25], "N/A" )
	guiSetText( CSGGroupsGUI[51], "Last bank transactions: (Current balance: $0)" )
	guiSetText( CSGGroupsGUI[26], "N/A" )
	guiSetText( CSGGroupsGUI[27], "N/A" )
	guiSetText( CSGGroupsGUI[33], "" )
end

-- Set the groups window visable
function setGroupWindowVisable ( groupsTable, invitesTable, memberTable, bankingTable, membersTable, groupID )
	if not ( memberTable ) then theRank = "Guest" else theRank = memberTable.grouprank end
	local groupsACL = getGroupsACL ()
	local groupRanks = getGroupRankACL ()

	resetGroupLabels ()

	if ( groupsACL ) and ( groupRanks ) and ( groupRanks[theRank] ) then
		for i=1,#groupsACL do
			if not ( memberTable ) and ( groupsACL[i][2] == 999 ) then
				guiSetEnabled( groupsACL[i][1], true )
			elseif ( memberTable ) and ( groupRanks[theRank] < 5 ) and ( groupsACL[i][2] == 888 ) then
				guiSetEnabled( groupsACL[i][1], true )
			elseif ( groupRanks[theRank] ) and ( groupRanks[theRank] >= groupsACL[i][2] ) then
				guiSetEnabled( groupsACL[i][1], true )
			else
				guiSetEnabled( groupsACL[i][1], false )
			end
		end

		if ( membersTable ) then memberCount = #membersTable else memberCount = "N/A" end

		local state1 = exports.DENsettings:getPlayerSetting( "groupblips" )
		local state2 = exports.DENsettings:getPlayerSetting( "grouptags" )
		guiCheckBoxSetSelected( CSGGroupsGUI[18], state1 )
		guiCheckBoxSetSelected( CSGGroupsGUI[19], state2 )

		if ( membersTable ) then insertGroupMemberList( membersTable ) end

		local groupsTableRow = nil
		local groupsTableName = nil
		local groupsTableFounder = nil
		local groupsTableDate = nil
		local groupsTableBalance = nil
		local groupsTableInfo = nil
		if ( groupsTable ) then
			guiGridListClear(CSGGroupsGUI[63] )
			for i=1,#groupsTable do
				local row1 = guiGridListAddRow ( CSGGroupsGUI[63] )
				guiGridListSetItemText( CSGGroupsGUI[63], row1, 1, groupsTable[i].groupname, false, false )
				guiGridListSetItemText( CSGGroupsGUI[63], row1, 2, groupsTable[i].membercount.." member(s)", false, true )
				guiGridListSetItemText( CSGGroupsGUI[63], row1, 3, groupsTable[i].groupleader, false, false )

				if ( tonumber( groupsTable[i].groupid ) == groupID ) then
					groupsTableRow = groupsTable[i].groupid
					groupsTableName = groupsTable[i].groupname
					groupsTableFounder = groupsTable[i].groupleader
					groupsTableDate = groupsTable[i].datecreated
					groupsTableBalance = groupsTable[i].groupbalance
					groupTableTurf = groupsTable[i].turfcolor
					groupsTableInfo = groupsTable[i].groupinfo

					theGroupID = groupsTable[i].groupid
					theFounderAccount = groupsTable[i].groupleader
				end
			end
		end

		if ( invitesTable ) then
			guiGridListClear(CSGGroupsGUI[58] )
			for i=1,#invitesTable do
				local row2 = guiGridListAddRow ( CSGGroupsGUI[58] )
				guiGridListSetItemText( CSGGroupsGUI[58], row2, 1, invitesTable[i].groupname, false, false )
				guiGridListSetItemText( CSGGroupsGUI[58], row2, 2, invitesTable[i].invitedby, false, false )
				guiGridListSetItemData( CSGGroupsGUI[58], row2, 1, invitesTable[i].groupid )
			end
		end

		if ( bankingTable ) then
			guiGridListClear(CSGGroupsGUI[52] )
			for i=1,#bankingTable do
				local row3 = guiGridListAddRow ( CSGGroupsGUI[52] )
				guiGridListSetItemText( CSGGroupsGUI[52], row3, 1, bankingTable[i].datum, false, false )
				guiGridListSetItemText( CSGGroupsGUI[52], row3, 2, bankingTable[i].transaction, false, false )
			end
		end

		if ( groupTableTurf  ) then turfColorData = exports.server:stringExplode( groupTableTurf, "," ) end

		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[20], groupsTableName ) end
		if ( memberCount ) then guiSetText( CSGGroupsGUI[21], memberCount ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[22], groupsTableFounder ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[23], groupsTableDate ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[24], memberTable.joindate ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[25], "$"..exports.server:convertNumber( groupsTableBalance ) ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[51], "Last bank transactions: (Current balance: $"..exports.server:convertNumber( groupsTableBalance )..")" ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[26], memberTable.grouprank ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[27], "This is the turf color" ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[33], groupsTableInfo ) end
		if ( turfColorData  ) then guiLabelSetColor( CSGGroupsGUI[27], turfColorData[1], turfColorData[2], turfColorData[3] ) end

		guiSetVisible ( CSGGroupsGUI[1], true )
		showCursor( true )
	else
		exports.DENdxmsg:createNewDxMessage( "We couldn't open groups panel, contact a developer please!", 200, 0, 0 )
	end
end

function insertGroupMemberList( membersTable )
	guiGridListClear(CSGGroupsGUI[30] )
	guiGridListClear(CSGGroupsGUI[37] )
	for i=1,#membersTable do
		local row1 = guiGridListAddRow ( CSGGroupsGUI[30] )
		local row2 = guiGridListAddRow ( CSGGroupsGUI[37] )
		local playerElement = exports.server:getPlayerFromAccountname ( membersTable[i].membername )

		guiGridListSetItemText( CSGGroupsGUI[30], row1, 1, membersTable[i].membername, false, false )
		guiGridListSetItemText( CSGGroupsGUI[30], row1, 2, membersTable[i].grouprank, false, false )

		guiGridListSetItemText( CSGGroupsGUI[37], row2, 1, membersTable[i].membername, false, false )
		guiGridListSetItemData( CSGGroupsGUI[37], row2, 1, membersTable[i].grouprank )
	nickToPlayer[membersTable[i].membername]=membersTable[i].membername
		if ( playerElement ) and ( isElement( playerElement ) ) then
			guiGridListSetItemText ( CSGGroupsGUI[30], row1, 3, "Online", false, false )

			guiGridListSetItemText( CSGGroupsGUI[30], row1, 1, getPlayerName(playerElement).." ("..membersTable[i].membername..")", false, false )
			guiGridListSetItemText( CSGGroupsGUI[37], row2, 1, getPlayerName(playerElement).." ("..membersTable[i].membername..")", false, false )

			guiGridListSetItemColor( CSGGroupsGUI[30], row1, 3, 0, 225, 0 )
			guiGridListSetItemColor( CSGGroupsGUI[30], row1, 1, 0, 225, 0 )
			guiGridListSetItemColor( CSGGroupsGUI[37], row2, 1, 0, 225, 0 )
			nickToPlayer[getPlayerName(playerElement).." ("..membersTable[i].membername..")"]=membersTable[i].membername

		else
			guiGridListSetItemText ( CSGGroupsGUI[30], row1, 3, compareTimestampDays( membersTable[i].lastonline ), false, false )
			guiGridListSetItemColor( CSGGroupsGUI[37], row2, 1, 225, 0, 0 )
		end
	end
end

-- Change the setting for group settings
addEventHandler( "onClientGUIClick", root,
	function ()
		if ( source == CSGGroupsGUI[18] ) then
			exports.DENsettings:setPlayerSetting( "groupblips", tostring( guiCheckBoxGetSelected( CSGGroupsGUI[18] ) ) )
		elseif ( source == CSGGroupsGUI[19] ) then
			exports.DENsettings:setPlayerSetting( "grouptags", tostring( guiCheckBoxGetSelected( CSGGroupsGUI[19] ) ) )
		end
	end
)

-- Event handlers for on-screen changes
addEventHandler( "onClientGUIChanged", root,
	function ()
		if ( source == CSGGroupsGUI[65] ) then
			onClientGroupInviteSearch()
		elseif 	( source == CSGGroupsGUI[102] ) or ( source == CSGGroupsGUI[106] ) or ( source == CSGGroupsGUI[104] ) then
			onClientTurfColorChange()
		end
	end
)

-- Get the accountname of the founder
function getGroupFounderAccountname ()
	if ( theFounderAccount ) then
		return theFounderAccount
	else
		return false
	end
end

-- Get groupID
function getGroupID ()
	if ( theGroupID ) then
		return theGroupID
	else
		return false
	end
end
