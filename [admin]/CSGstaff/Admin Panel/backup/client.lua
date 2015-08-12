--Em
-- Search for player
function onClientSearchPlayerFromEmGrid()
guiGridListClear(adminEmPlayerGrid)
local name = guiGetText(adminEmPlayerSearch)
	for id, player in ipairs(getElementsByType("player")) do
        if string.find(getPlayerName(player):lower(), name:lower()) then
			local playerTeam = getPlayerTeam( player )
			if ( playerTeam ) then
				local r, g, b = getTeamColor ( playerTeam )
				local row = guiGridListAddRow ( adminEmPlayerGrid )
				guiGridListSetItemText(adminEmPlayerGrid, row, 1, getPlayerName(player), false, false)
				guiGridListSetItemColor ( adminEmPlayerGrid, row, 1, r, g, b )
			end
		end
	end
end

function onClientDestroyEventPickup()
	triggerServerEvent("onDestroyEventPickup",localPlayer)
end
-- EM create vehicle
function onClientEventCreateVehicleMarker ()
	local theVehicle = guiGetText( adminEmVehicleEdit )
	if ( theVehicle ) and not ( theVehicle == "" ) and not ( theVehicle == " " ) then
		triggerServerEvent( "onCreateEventVehicleMarker", localPlayer, theVehicle )
	else
		exports.dendxmsg:createNewDxMessage( "There is no vehicle found with this name!", 225, 0, 0 )
	end
end

function onClientEventDestroyVehicleMarker ()
	triggerServerEvent( "onDestroyEventVehicleMarker", localPlayer, exports.server:getPlayerAccountName() )
end

function onClientEventDestroyVehicles ()
	triggerServerEvent( "onDestroyEventVehicles", localPlayer, exports.server:getPlayerAccountName() )
end

-- EM
function onClientCreateEvent ()
	local warpLimit = guiGetText( adminEmWarpsLimit )
	local warpInt = getElementInterior( localPlayer )
	local warpDim = guiGetText( adminEmWarpsDimension )
	local eventName = guiGetText( adminEmWarpsTitle )
	if ( string.match( warpLimit ,'^%d+$' ) ) and ( string.match( warpInt ,'^%d+$' ) ) and ( string.match( warpDim ,'^%d+$' ) ) then
		triggerServerEvent( "onCreateWarpEvent", localPlayer, warpLimit, warpDim, warpInt, eventName )
	else
		exports.dendxmsg:createNewDxMessage( "Not all fields are filled in right!", 225, 0, 0 )
	end
end

function onClientUnfeezeEvent ()
	triggerServerEvent( "onUnfreezeEventPlayers", localPlayer )
end

function onClientDestroyEvent ()
	triggerServerEvent( "onDestroyEvent", localPlayer )
end

-- EM give
function onClientGiveEventMoney ()
	local thePlayer = guiGridListGetItemText(adminEmPlayerGrid, guiGridListGetSelectedItem(adminEmPlayerGrid), 1)
	if ( isElement( getPlayerFromName( thePlayer ) ) ) then
		local theMoney = guiGetText( adminEmMoneyEdit )
		if ( string.match( theMoney ,'^%d+$' ) ) then
			triggerServerEvent( "onSendEventMoney", localPlayer, getPlayerFromName( thePlayer ), tonumber(theMoney) )
		else
			exports.dendxmsg:createNewDxMessage( "The money amount must be a number!", 225, 0, 0 )
		end
	else
		exports.dendxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
	end
end

function onClientGiveEventScore ()
	local thePlayer = guiGridListGetItemText(adminEmPlayerGrid, guiGridListGetSelectedItem(adminEmPlayerGrid), 1)
	if ( isElement( getPlayerFromName( thePlayer ) ) ) then
		local theScore = guiGetText( adminEmScoreEdit )
		if ( theScore == "" ) or ( theScore == " " ) or type(tonumber(theScore)) ~= "number" then
			exports.dendxmsg:createNewDxMessage( "You didn't enter a valid score!", 225, 0, 0 )
		else
			exports.DENdxmsg:createNewDxMessage("Event: You have given "..thePlayer.." "..theScore.." score!",0,255,0)
			triggerServerEvent("CSGevents.gotScore",localPlayer,getPlayerFromName( thePlayer ),theScore)
			--triggerServerEvent( "onSendWeapon", localPlayer, getPlayerFromName( thePlayer ), theWeapon )
		end
	else
		exports.dendxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
	end
end

-- Pickup
function onClientCreateEventPickup ()
	local pickupType = guiGetText( adminEmPickupEdit )
	if ( string.lower( pickupType ) == "health" ) or ( string.lower( pickupType ) == "armor" ) then
		triggerServerEvent( "onCreateEventPickup", localPlayer, pickupType )
	else
		exports.dendxmsg:createNewDxMessage( "Wrong pickup model! (Use: health or armor)", 225, 0, 0 )
	end
end

-- Table with all the GUI elements
local adminGUI = {
	GUIbuttons = {},
	GUIlabels  = {},
	GUIedits   = {},
	GUIgrids   = {},
	GUIwindow  = {},
	GUItabs	   = {},
	GUItabbar  = {},
	GUIcombos  = {},
	GUIchecks  = {},
	GUIradios  = {},
	GUImemos   = {},
}

-- Table with the punishment reaons
local punishmentReaons = {
	"#00 - Removing punishment",
	"#00 - Testing punishments",
	"#00 - Custom reason",
	"#01 - Deathmatching",
	"#02 - Abusing bug(s)",
	"#03 - Insulting/flaming",
	"#04 - Annoying server staff(s)",
	"#05 - Advertising for other servers",
	"#06 - Cheating/hacking",
	"#07 - Blackmailing players",
	"#08 - Support channel misuse",
	"#09 - Avoiding ingame situations",
	"#10 - Non-english",
	"#11 - Camping",
	"#12 - Not listening to staff",
	"#13 - Using main/team chat for advertising",
	"#14 - Spamming/flooding",
	"#15 - Selling ingame contents",
	"#16 - Using unacceptable name",
	"#17 - Trolling/griefing",
}

-- The window
adminGUI.GUIwindow[1] = guiCreateWindow(348, 156, 862, 610, "Community of Social Gaming ~ Admin Panel V3 (By Dennis)", false)

-- The search edit to for players and the gridlist
adminGUI.GUIedits[1] = guiCreateEdit(10, 23, 181, 25, "", false, adminGUI.GUIwindow[1])
adminGUI.GUIgrids[1] = guiCreateGridList(10, 54, 182, 546, false, adminGUI.GUIwindow[1])
adminGUI.GUItabbar[1] = guiCreateTabPanel(198, 27, 655, 573, false, adminGUI.GUIwindow[1])

-- Tab one Player Details
adminGUI.GUItabs[1] = guiCreateTab("Player Details", adminGUI.GUItabbar[1])
adminGUI.GUIlabels[1] = guiCreateLabel(10, 10, 640, 20, "General Information:", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[3] = guiCreateLabel(10, 40, 298, 18, "Nickname: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[4] = guiCreateLabel(315, 40, 325, 18, "Accountname: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[5] = guiCreateLabel(10, 68, 298, 18, "Serial: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[6] = guiCreateLabel(315, 68, 325, 18, "IP Adress: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[7] = guiCreateLabel(10, 96, 298, 18, "Country: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[8] = guiCreateLabel(10, 128, 640, 20, "Location Information:", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[9] = guiCreateLabel(10, 158, 192, 18, "X: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[10] = guiCreateLabel(207, 158, 192, 18, "Y: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[11] = guiCreateLabel(404, 158, 192, 18, "Z: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[12] = guiCreateLabel(10, 186, 298, 18, "Dimension: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[13] = guiCreateLabel(313, 186, 298, 18, "Interior: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[14] = guiCreateLabel(10, 214, 298, 18, "Vehicle: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[15] = guiCreateLabel(313, 214, 298, 18, "Vehicle Health: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[16] = guiCreateLabel(315, 96, 325, 18, "MTA Version: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[17] = guiCreateLabel(10, 246, 640, 20, "Player Information:", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[18] = guiCreateLabel(10, 276, 298, 18, "Health: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[19] = guiCreateLabel(313, 276, 298, 18, "Armor: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[20] = guiCreateLabel(10, 304, 298, 18, "Skin: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[21] = guiCreateLabel(313, 304, 298, 18, "Playtime: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[22] = guiCreateLabel(10, 332, 298, 18, "Occupation: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[23] = guiCreateLabel(313, 332, 298, 18, "Team: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[24] = guiCreateLabel(10, 360, 298, 18, "Cash Money: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[25] = guiCreateLabel(313, 360, 298, 18, "Bank Money: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[26] = guiCreateLabel(10, 388, 298, 18, "Premium Hours: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[27] = guiCreateLabel(313, 388, 298, 18, "Group name: N/A", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[28] = guiCreateLabel(10, 416, 640, 20, "Other Information:", false, adminGUI.GUItabs[1])
adminGUI.GUIlabels[29] = guiCreateLabel(10, 446, 298, 18, "Email: N/A", false, adminGUI.GUItabs[1])

-- Player actions tab
adminGUI.GUItabs[2] = guiCreateTab("Player Actions", adminGUI.GUItabbar[1])
adminGUI.GUIlabels[30] = guiCreateLabel(10, 6, 371, 20, "Select a reason for the punishment or enter a custom reason:", false, adminGUI.GUItabs[2])
adminGUI.GUIcombos[1] = guiCreateComboBox(10, 33, 279, 330, "Select a punishment reason", false, adminGUI.GUItabs[2])
adminGUI.GUIedits[2] = guiCreateEdit(295, 32, 354, 24, "Custom Reason", false, adminGUI.GUItabs[2])
adminGUI.GUIlabels[32] = guiCreateLabel(10, 66, 195, 19, "Select a punishment time:", false, adminGUI.GUItabs[2])
adminGUI.GUIedits[3] = guiCreateEdit(10, 95, 283, 24, "Punishment time amount", false, adminGUI.GUItabs[2])
adminGUI.GUIradios[1] = guiCreateRadioButton(299, 95, 62, 21, "Days", false, adminGUI.GUItabs[2])
adminGUI.GUIradios[2] = guiCreateRadioButton(371, 95, 62, 21, "Hours", false, adminGUI.GUItabs[2])
adminGUI.GUIradios[3] = guiCreateRadioButton(443, 95, 62, 21, "Minutes", false, adminGUI.GUItabs[2])
adminGUI.GUIradios[4] = guiCreateRadioButton(513, 95, 132, 21, "Permanently", false, adminGUI.GUItabs[2])
adminGUI.GUIcombos[2] = guiCreateComboBox(10, 158, 279, 120, "Select a punishment", false, adminGUI.GUItabs[2])
adminGUI.GUIlabels[34] = guiCreateLabel(10, 129, 195, 19, "Select a punishment:", false, adminGUI.GUItabs[2])
adminGUI.GUIlabels[35] = guiCreateLabel(10, 190, 637, 19, "------------------------------------------------------------------------------------------------------------------------------------------------------------", false, adminGUI.GUItabs[2])
adminGUI.GUIchecks[1] = guiCreateCheckBox(327, 160, 130, 15, "Remove punishment", false, false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[1] = guiCreateButton(11, 209, 154, 25, "Slap Player", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[2] = guiCreateButton(171, 209, 154, 25, "Freeze Player", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[3] = guiCreateButton(331, 209, 154, 25, "Kick Player", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[4] = guiCreateButton(491, 209, 154, 25, "Reconnect Player", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[5] = guiCreateButton(10, 244, 154, 25, "Warp To Player", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[6] = guiCreateButton(171, 244, 154, 25, "Warp Player To...", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[7] = guiCreateButton(331, 244, 154, 25, "Fix Vehicle", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[8] = guiCreateButton(491, 244, 154, 25, "Destroy Vehicle", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[9] = guiCreateButton(10, 279, 154, 25, "Specate Player", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[10] = guiCreateButton(171, 314, 154, 25, "Give Vehicle", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[11] = guiCreateButton(331, 314, 154, 25, "Set Skin", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[12] = guiCreateButton(491, 314, 154, 25, "Rename", false, adminGUI.GUItabs[2])
adminGUI.GUIedits[4] = guiCreateEdit(10, 314, 156, 26, "Name, ID or New name", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[13] = guiCreateButton(171, 279, 75, 25, "Give Health", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[80] = guiCreateButton(250, 279, 75, 25, "Give Armor", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[14] = guiCreateButton(331, 279, 154, 25, "Give Jetpack", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[15] = guiCreateButton(491, 279, 154, 25, "Give Premium Car", false, adminGUI.GUItabs[2])
adminGUI.GUIedits[5] = guiCreateEdit(10, 349, 74, 26, "Wep Name", false, adminGUI.GUItabs[2])
adminGUI.GUIedits[6] = guiCreateEdit(85, 349, 79, 26, "Amount", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[16] = guiCreateButton(171, 349, 154, 25, "Give Weapon", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[17] = guiCreateButton(491, 155, 154, 25, "Punish Player", false, adminGUI.GUItabs[2])
adminGUI.GUIedits[71] = guiCreateEdit(331, 348, 156, 26, "INT or Dimension", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[18] = guiCreateButton(491, 347, 75, 25, "Interior", false, adminGUI.GUItabs[2])
adminGUI.GUIbuttons[20] = guiCreateButton(569, 347, 77, 25, "Dimension", false, adminGUI.GUItabs[2])
adminGUI.GUIlabels[36] = guiCreateLabel(10, 384, 637, 19, "------------------------------------------------------------------------------------------------------------------------------------------------------------", false, adminGUI.GUItabs[2])
adminGUI.GUImemos[1] = guiCreateMemo(10, 404, 640, 139, "Last logins with the same serial as the selected player:\n\n1. N/A\n2. N/A\n3. N/A\n4. N/A\n5. N/A\n6. N/A", false, adminGUI.GUItabs[2])

-- Punishlog tab
adminGUI.GUItabs[3] = guiCreateTab("Punishlog", adminGUI.GUItabbar[1])
adminGUI.GUIgrids[2] = guiCreateGridList(4, 4, 648, 504, false, adminGUI.GUItabs[3])
adminGUI.GUIlabels[37] = guiCreateLabel(10, 519, 640, 19, "Double click on a punishment to remove the punishment, double click on a red punishment to re-enable it again.", false, adminGUI.GUItabs[3])

-- Accounts management tab
adminGUI.GUItabs[4] = guiCreateTab("Accounts", adminGUI.GUItabbar[1])
adminGUI.GUIedits[7] = guiCreateEdit(10, 5, 200, 26, "", false, adminGUI.GUItabs[4])
adminGUI.GUIgrids[3] = guiCreateGridList(10, 36, 199, 507, false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[38] = guiCreateLabel(225, 10, 346, 15, "Select a account from the list, the field will update instantly!!", false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[39] = guiCreateLabel(225, 36, 170, 17, "Username:", false, adminGUI.GUItabs[4])
adminGUI.GUIedits[8] = guiCreateEdit(219, 57, 201, 24, "", false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[40] = guiCreateLabel(442, 40, 170, 17, "Playtime:", false, adminGUI.GUItabs[4])
adminGUI.GUIedits[9] = guiCreateEdit(439, 57, 201, 24, "", false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[41] = guiCreateLabel(442, 91, 170, 17, "Premium hours:", false, adminGUI.GUItabs[4])
adminGUI.GUIedits[10] = guiCreateEdit(439, 108, 201, 24, "", false, adminGUI.GUItabs[4])
adminGUI.GUIedits[11] = guiCreateEdit(221, 108, 201, 24, "", false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[42] = guiCreateLabel(225, 91, 170, 17, "Email:", false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[43] = guiCreateLabel(225, 142, 170, 17, "Occupation:", false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[44] = guiCreateLabel(442, 142, 170, 17, "Team:", false, adminGUI.GUItabs[4])
adminGUI.GUIedits[12] = guiCreateEdit(221, 159, 201, 24, "", false, adminGUI.GUItabs[4])
adminGUI.GUIedits[13] = guiCreateEdit(439, 164, 201, 24, "", false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[45] = guiCreateLabel(225, 219, 172, 15, "Cash Money:", false, adminGUI.GUItabs[4])
adminGUI.GUIedits[14] = guiCreateEdit(221, 236, 201, 24, "", false, adminGUI.GUItabs[4])
adminGUI.GUIedits[15] = guiCreateEdit(439, 236, 201, 24, "", false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[46] = guiCreateLabel(443, 219, 170, 17, "Bank Money:", false, adminGUI.GUItabs[4])
adminGUI.GUIbuttons[75] = guiCreateButton(221, 351, 420, 26, "Update Account", false, adminGUI.GUItabs[4])
adminGUI.GUIbuttons[76] = guiCreateButton(219, 387, 420, 26, "Reset Account", false, adminGUI.GUItabs[4])
adminGUI.GUIbuttons[19] = guiCreateButton(220, 423, 420, 26, "Disable account", false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[47] = guiCreateLabel(225, 293, 172, 15, "New Password:", false, adminGUI.GUItabs[4])
adminGUI.GUIlabels[48] = guiCreateLabel(443, 293, 170, 17, "Password Repeat:", false, adminGUI.GUItabs[4])
adminGUI.GUIedits[16] = guiCreateEdit(221, 310, 201, 24, "", false, adminGUI.GUItabs[4])
adminGUI.GUIedits[17] = guiCreateEdit(439, 308, 201, 24, "", false, adminGUI.GUItabs[4])
adminGUI.GUIbuttons[77] = guiCreateButton(220, 459, 420, 26, "Kick Account From Group", false, adminGUI.GUItabs[4])
adminGUI.GUIbuttons[21] = guiCreateButton(220, 513, 420, 26, "Delete Account", false, adminGUI.GUItabs[4])

-- Event management tab
--[[
adminGUI.GUItabs[5] = guiCreateTab("Event Management", adminGUI.GUItabbar[1])
adminGUI.GUIlabels[49] = guiCreateLabel(10, 6, 443, 15, "Create new event: (Event name)", false, adminGUI.GUItabs[5])
adminGUI.GUIedits[18] = guiCreateEdit(5, 21, 645, 25, "Event Name", false, adminGUI.GUItabs[5])
adminGUI.GUIlabels[50] = guiCreateLabel(10, 51, 180, 15, "Maximum Players:", false, adminGUI.GUItabs[5])
adminGUI.GUIedits[19] = guiCreateEdit(5, 66, 193, 24, "Max Players", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[22] = guiCreateButton(200, 66, 141, 24, "Create Event", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[23] = guiCreateButton(344, 66, 146, 24, "Unfreeze Players", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[24] = guiCreateButton(494, 66, 157, 24, "Destroy Event", false, adminGUI.GUItabs[5])
adminGUI.GUIlabels[51] = guiCreateLabel(10, 119, 443, 15, "Create Vehicle Marker: (Vehicle name)", false, adminGUI.GUItabs[5])
adminGUI.GUIedits[20] = guiCreateEdit(5, 135, 195, 24, "Vehicle name", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[25] = guiCreateButton(202, 135, 139, 24, "Create Marker", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[26] = guiCreateButton(344, 134, 144, 24, "Destroy Marker", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[27] = guiCreateButton(493, 133, 157, 25, "Destroy Vehicles", false, adminGUI.GUItabs[5])
adminGUI.GUIlabels[52] = guiCreateLabel(10, 96, 637, 15, "------------------------------------------------------------------------------------------------------------------------------------------------------------", false, adminGUI.GUItabs[5])
adminGUI.GUIlabels[53] = guiCreateLabel(10, 169, 637, 15, "------------------------------------------------------------------------------------------------------------------------------------------------------------", false, adminGUI.GUItabs[5])
adminGUI.GUIlabels[54] = guiCreateLabel(10, 193, 443, 15, "Create Pickups:", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[29] = guiCreateButton(221, 210, 223, 24, "Create Marker", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[30] = guiCreateButton(221, 210, 223, 24, "Create/Destroy Armor Pickup", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[31] = guiCreateButton(450, 210, 200, 24, "Create/Destroy Parachute Pickup", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[32] = guiCreateButton(7, 210, 208, 24, "Create/Destroy Health Pickup", false, adminGUI.GUItabs[5])
adminGUI.GUIlabels[55] = guiCreateLabel(10, 270, 291, 16, "Player Options (Enter a (Part of the) playername):", false, adminGUI.GUItabs[5])
adminGUI.GUIlabels[56] = guiCreateLabel(10, 241, 637, 15, "------------------------------------------------------------------------------------------------------------------------------------------------------------", false, adminGUI.GUItabs[5])
adminGUI.GUIedits[22] = guiCreateEdit(5, 289, 195, 24, "Playername", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[34] = guiCreateButton(202, 289, 139, 24, "Kick From Event", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[37] = guiCreateButton(344, 288, 144, 24, "Block From Event", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[38] = guiCreateButton(493, 287, 157, 25, "Warp Player to You", false, adminGUI.GUItabs[5])
adminGUI.GUIlabels[57] = guiCreateLabel(10, 347, 637, 15, "------------------------------------------------------------------------------------------------------------------------------------------------------------", false, adminGUI.GUItabs[5])
adminGUI.GUIedits[23] = guiCreateEdit(5, 316, 111, 24, "Amount", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[39] = guiCreateButton(118, 316, 139, 24, "Give Money", false, adminGUI.GUItabs[5])
adminGUI.GUIedits[24] = guiCreateEdit(260, 316, 111, 24, "Weapon Name", false, adminGUI.GUItabs[5])
adminGUI.GUIedits[25] = guiCreateEdit(372, 316, 117, 24, "Amount", false, adminGUI.GUItabs[5])
adminGUI.GUIbuttons[40] = guiCreateButton(493, 316, 157, 25, "Give Weapon", false, adminGUI.GUItabs[5])
adminGUI.GUIlabels[58] = guiCreateLabel(10, 372, 291, 16, "Notes:", false, adminGUI.GUItabs[5])
adminGUI.GUImemos[2] = guiCreateMemo(8, 388, 643, 156, "", false, adminGUI.GUItabs[5])
--]]
	-- Event manager panel
tab = {}
edit = {}
memo = {}
adminGUI.GUItabs[5] = guiCreateTab("Event Manager Panel",adminGUI.GUItabbar[1])
label = {}
        label[46] = guiCreateLabel(8, 8, 136, 19, "Select player from list:", false, adminGUI.GUItabs[5])
        guiSetFont(label[46], "default-bold-small")
        adminEmPlayerGrid = guiCreateGridList(5, 47, 235, 266, false, adminGUI.GUItabs[5])
        playersColumn2 = guiGridListAddColumn(adminEmPlayerGrid, "", 0.9)
		guiGridListSetSelectionMode(adminEmPlayerGrid,0)
        adminEmPlayerSearch = guiCreateEdit(5, 25, 236, 20, "", false, adminGUI.GUItabs[5])
        adminEmMoneyTransfer = guiCreateButton(260, 288, 218, 25, "Transfer money to player", false, adminGUI.GUItabs[5])
        label[47] = guiCreateLabel(263, 247, 169, 19, "Send player money: (Amount)", false, adminGUI.GUItabs[5])
        guiSetFont(label[47], "default-bold-small")
        guiLabelSetColor(label[47], 89, 193, 19)
        adminEmMoneyEdit = guiCreateEdit(261, 264, 218, 20, "MAX: 100,000$", false, adminGUI.GUItabs[5])
        label[48] = guiCreateLabel(250, 8, 15, 317, "|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n", false, adminGUI.GUItabs[5])
        guiSetFont(label[48], "default-bold-small")
        guiLabelSetColor(label[48], 199, 64, 11)
        label[49] = guiCreateLabel(264, 8, 230, 19, "Create vehicle spawner: (Vehicle name)", false, adminGUI.GUItabs[5])
        guiSetFont(label[49], "default-bold-small")
        guiLabelSetColor(label[49], 89, 193, 19)
        adminEmVehicleEdit = guiCreateEdit(261, 27, 125, 20, "", false, adminGUI.GUItabs[5])
        adminEmVehicleCreate = guiCreateButton(387, 27, 54, 22, "Create", false, adminGUI.GUItabs[5])
        adminEmVehicleDestroyVehicles = guiCreateButton(546, 27, 104, 22, "Destroy Vehicles", false, adminGUI.GUItabs[5])
        adminEmVehicleDestroyMarker = guiCreateButton(447, 27, 94, 22, "Destroy Marker", false, adminGUI.GUItabs[5])
        label[50] = guiCreateLabel(263, 45, 392, 15, "______________________________________________________________________________________________________________________", false, adminGUI.GUItabs[5])
        guiSetFont(label[50], "default-small")
        guiLabelSetColor(label[50], 199, 64, 11)
        label[51] = guiCreateLabel(264, 70, 282, 19, "Create health or armor pickup: (Health or Armor)", false, adminGUI.GUItabs[5])
        guiSetFont(label[51], "default-bold-small")
        guiLabelSetColor(label[51], 89, 193, 19)
        adminEmPickupEdit = guiCreateEdit(264, 88, 182, 20, "", false, adminGUI.GUItabs[5])
        adminEmPickupCreate = guiCreateButton(452, 89, 94, 19, "Create", false, adminGUI.GUItabs[5])
        adminEmPickupDestroy = guiCreateButton(562, 89, 83, 19, "Destroy", false, adminGUI.GUItabs[5])
        label[52] = guiCreateLabel(263, 114, 392, 15, "_____________________________________________________________________________________________________________________________", false, adminGUI.GUItabs[5])
        guiSetFont(label[52], "default-bold-small")
        guiLabelSetColor(label[52], 199, 64, 11)
        guiLabelSetHorizontalAlign(label[52], "center", false)
        guiLabelSetVerticalAlign(label[52], "center")
        label[53] = guiCreateLabel(264, 139, 299, 19, "Create eventwarp to current position: (Event name)", false, adminGUI.GUItabs[5])
        guiSetFont(label[53], "default-bold-small")
        guiLabelSetColor(label[53], 89, 193, 19)
        adminEmWarpsTitle = guiCreateEdit(261, 159, 391, 21, "", false, adminGUI.GUItabs[5])
        label[54] = guiCreateLabel(263, 186, 69, 19, "Warp limit:", false, adminGUI.GUItabs[5])
        guiSetFont(label[54], "default-bold-small")
        guiLabelSetColor(label[54], 89, 193, 19)
        adminEmWarpsLimit = guiCreateEdit(328, 186, 151, 21, "", false, adminGUI.GUItabs[5])
        adminEmWarpsCreate = guiCreateButton(261, 211, 132, 26, "Create event", false, adminGUI.GUItabs[5])
        adminEmWarpsUnfreeze = guiCreateButton(397, 213, 146, 24, "Unfreeze players", false, adminGUI.GUItabs[5])
        adminEmWarpsDestroy = guiCreateButton(548, 215, 97, 22, "Destroy event", false, adminGUI.GUItabs[5])
        label[55] = guiCreateLabel(253, 232, 402, 15, "__________________________________________________________________________________________", false, adminGUI.GUItabs[5])
        guiSetFont(label[55], "default-bold-small")
        guiLabelSetColor(label[55], 199, 64, 11)
        label[56] = guiCreateLabel(6, 315, 705, 14, "_______________________________________________________________________________________________________________________________________________________________", false, adminGUI.GUItabs[5])
        guiSetFont(label[56], "default-bold-small")
        guiLabelSetColor(label[56], 199, 64, 11)
        label[57] = guiCreateLabel(481, 247, 235, 19, "Give Score: (Amount)", false, adminGUI.GUItabs[5])
        guiSetFont(label[57], "default-bold-small")
        guiLabelSetColor(label[57], 89, 193, 19)
        adminEmScoreEdit = guiCreateEdit(484, 264, 161, 20, "", false, adminGUI.GUItabs[5])
        adminEmWeaponGive = guiCreateButton(487, 288, 158, 25, "Give player score", false, adminGUI.GUItabs[5])
        label[58] = guiCreateLabel(7, 329, 169, 19, "Notes:", false, adminGUI.GUItabs[5])
        guiLabelSetColor(label[58], 89, 193, 19)
        memo[2] = guiCreateMemo(5, 344, 645, 201, "", false, adminGUI.GUItabs[5])
        label[59] = guiCreateLabel(487, 186, 62, 19, "Dimension:", false, adminGUI.GUItabs[5])
        guiSetFont(label[59], "default-bold-small")
        guiLabelSetColor(label[59], 89, 193, 19)
        adminEmWarpsDimension = guiCreateEdit(553, 186, 99, 21, "0", false, adminGUI.GUItabs[5])
	-- EVENT MANAGER HANDLERS
	addEventHandler	("onClientGUIChanged", adminEmPlayerSearch, onClientSearchPlayerFromEmGrid, false)
	addEventHandler	("onClientGUIClick", adminEmVehicleCreate, onClientEventCreateVehicleMarker, false)
	addEventHandler	("onClientGUIClick", adminEmVehicleDestroyMarker, onClientEventDestroyVehicleMarker, false)
	addEventHandler	("onClientGUIClick", adminEmVehicleDestroyVehicles, onClientEventDestroyVehicles, false)
	addEventHandler	("onClientGUIClick", adminEmWarpsCreate, onClientCreateEvent, false)
	addEventHandler	("onClientGUIClick", adminEmWarpsUnfreeze, onClientUnfeezeEvent, false)
	addEventHandler	("onClientGUIClick", adminEmWarpsDestroy, onClientDestroyEvent, false)
	addEventHandler	("onClientGUIClick", adminEmWeaponGive, onClientGiveEventScore, false)
	addEventHandler ("onClientGUIClick", adminEmMoneyTransfer, onClientGiveEventMoney, false)
	addEventHandler ("onClientGUIClick", adminEmPickupCreate, onClientCreateEventPickup, false)
	addEventHandler ("onClientGUIClick", adminEmPickupDestroy, onClientDestroyEventPickup,false)
-- Server management tab
adminGUI.GUItabs[6] = guiCreateTab("Server Management", adminGUI.GUItabbar[1])
adminGUI.GUIlabels[59] = guiCreateLabel(10, 4, 334, 16, "All CSG Admins:", false, adminGUI.GUItabs[6])
adminGUI.GUIgrids[4] = guiCreateGridList(5, 20, 470, 172, false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[41] = guiCreateButton(477, 20, 174, 24, "Kick Admin", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[42] = guiCreateButton(477, 49, 174, 24, "Promote One Level", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[43] = guiCreateButton(477, 78, 174, 24, "Demote One Level", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[44] = guiCreateButton(477, 108, 174, 24, "Set/Remove Developer", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[45] = guiCreateButton(477, 137, 174, 24, "Set/Remove Eventmanager", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[46] = guiCreateButton(477, 166, 174, 24, "(De)Activate Rights", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[53] = guiCreateButton(477, 193, 174, 24, "Add Staff", false, adminGUI.GUItabs[6])
adminGUI.GUIedits[40] = guiCreateEdit(5, 193, 175, 24, "Username", false, adminGUI.GUItabs[6])
adminGUI.GUIradios[9] = guiCreateRadioButton(358, 198, 53, 15, "Male", false, adminGUI.GUItabs[6])
adminGUI.GUIradios[10] = guiCreateRadioButton(413, 198, 64, 15, "Female", false, adminGUI.GUItabs[6])
adminGUI.GUIedits[41] = guiCreateEdit(180, 193, 175, 24, "Nickname", false, adminGUI.GUItabs[6])
adminGUI.GUIchecks[3] = guiCreateCheckBox(7, 228, 163, 20, "Disable Mainchat", false, false, adminGUI.GUItabs[6])
adminGUI.GUIchecks[4] = guiCreateCheckBox(170, 228, 163, 20, "Disable Advertchat", false, false, adminGUI.GUItabs[6])
adminGUI.GUIchecks[5] = guiCreateCheckBox(333, 228, 163, 20, "Disable Joining Server", false, false, adminGUI.GUItabs[6])
adminGUI.GUIchecks[6] = guiCreateCheckBox(498, 228, 126, 23, "Freeze All Players", false, false, adminGUI.GUItabs[6])
adminGUI.GUIlabels[61] = guiCreateLabel(10, 258, 334, 16, "Groups Options:", false, adminGUI.GUItabs[6])
adminGUI.GUIgrids[5] = guiCreateGridList(6, 279, 466, 267, false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[47] = guiCreateButton(475, 279, 174, 24, "Delete Group", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[49] = guiCreateButton(475, 309, 174, 24, "Kick All Members", false, adminGUI.GUItabs[6])
adminGUI.GUIedits[26] = guiCreateEdit(3, 31, 86, 22, "", false, adminGUI.GUIbuttons[49])
adminGUI.GUIedits[27] = guiCreateEdit(475, 338, 175, 24, "New name", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[50] = guiCreateButton(475, 367, 174, 24, "Rename Group", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[51] = guiCreateButton(475, 425, 174, 24, "Set New Founder", false, adminGUI.GUItabs[6])
adminGUI.GUIedits[29] = guiCreateEdit(475, 396, 175, 24, "Accountname", false, adminGUI.GUItabs[6])
adminGUI.GUIedits[30] = guiCreateEdit(475, 453, 175, 24, "Amount", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[52] = guiCreateButton(475, 481, 174, 24, "Change Group Bank Money", false, adminGUI.GUItabs[6])
adminGUI.GUIbuttons[53] = guiCreateButton(476, 519, 174, 24, "Join Group As a Leader", false, adminGUI.GUItabs[6])

-- Bans tab
adminGUI.GUItabs[7] = guiCreateTab("Bans", adminGUI.GUItabbar[1])
adminGUI.GUIgrids[6] = guiCreateGridList(2, 3, 650, 440, false, adminGUI.GUItabs[7])
adminGUI.GUIedits[31] = guiCreateEdit(1, 518, 279, 28, "Serial/Accountname", false, adminGUI.GUItabs[7])
adminGUI.GUIbuttons[54] = guiCreateButton(281, 519, 122, 26, "Ban Account", false, adminGUI.GUItabs[7])
adminGUI.GUIbuttons[58] = guiCreateButton(405, 519, 122, 26, "Ban Serial", false, adminGUI.GUItabs[7])
adminGUI.GUIbuttons[59] = guiCreateButton(529, 519, 122, 26, "Unban Selected", false, adminGUI.GUItabs[7])
adminGUI.GUIlabels[62] = guiCreateLabel(10, 499, 265, 16, "Enter a serial or accountname:", false, adminGUI.GUItabs[7])
adminGUI.GUIlabels[63] = guiCreateLabel(10, 443, 265, 16, "Choose a time and reason:", false, adminGUI.GUItabs[7])
adminGUI.GUIedits[32] = guiCreateEdit(1, 465, 279, 28, "Reason", false, adminGUI.GUItabs[7])
adminGUI.GUIedits[33] = guiCreateEdit(281, 465, 84, 28, "Time", false, adminGUI.GUItabs[7])
adminGUI.GUIradios[5] = guiCreateRadioButton(367, 467, 61, 25, "Days", false, adminGUI.GUItabs[7])
adminGUI.GUIradios[6] = guiCreateRadioButton(430, 467, 61, 25, "Hours", false, adminGUI.GUItabs[7])
adminGUI.GUIradios[7] = guiCreateRadioButton(561, 467, 90, 25, "Permanently", false, adminGUI.GUItabs[7])
adminGUI.GUIradios[8] = guiCreateRadioButton(494, 467, 61, 25, "Minutes", false, adminGUI.GUItabs[7])
guiSetEnabled(adminGUI.GUItabs[7],false)
-- Make the GUI movable and center it
guiWindowSetMovable ( adminGUI.GUIwindow[1], true )
guiWindowSetSizable ( adminGUI.GUIwindow[1], false )
guiSetVisible ( adminGUI.GUIwindow[1], false )

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(adminGUI.GUIwindow[1],false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(adminGUI.GUIwindow[1],x,y,false)

-- Gridlist columns
guiGridListAddColumn( adminGUI.GUIgrids[1], "Players:", 0.85 )

guiGridListAddColumn( adminGUI.GUIgrids[4], "Nick:", 0.45 )
guiGridListAddColumn( adminGUI.GUIgrids[4], "LVL:", 0.15 )
guiGridListAddColumn( adminGUI.GUIgrids[4], "Dev:", 0.15 )
guiGridListAddColumn( adminGUI.GUIgrids[4], "EM:", 0.15 )

guiGridListAddColumn( adminGUI.GUIgrids[6], "Serial/Username:", 0.45 )
guiGridListAddColumn( adminGUI.GUIgrids[6], "Reason:", 0.90 )
guiGridListAddColumn( adminGUI.GUIgrids[6], "Banned by:", 0.18 )
guiGridListAddColumn( adminGUI.GUIgrids[6], "Banned till:", 0.18 )

guiGridListAddColumn( adminGUI.GUIgrids[2], "Date:", 0.24 )
guiGridListAddColumn( adminGUI.GUIgrids[2], "Punishment:", 0.73 )

-- Loop to set the labels in a color and font
for i=1,#adminGUI.GUIlabels do
	if ( i == 1 or i == 8 or i == 17 or i == 28 or i == 30 or i == 32 or i == 34 or i == 35 or i == 36 or i == 37 or i == 38 or i == 49 or i == 50 or i == 51 or i == 52 or i == 53 or i == 54 or i == 55 or i == 56 or i == 57 or i == 58 or i == 59 or i == 60 or i == 61 or i == 62 or i == 63 ) then
		guiLabelSetColor( adminGUI.GUIlabels[i], 225, 128, 0 )
		guiSetFont( adminGUI.GUIlabels[i], "default-bold-small" )
	end
end

-- Function that returns the complete window table
function getAdminPanelGUI ()
	return adminGUI
end

-- Loops to set comboboxes their data
for i=1,#punishmentReaons do
	guiComboBoxAddItem( adminGUI.GUIcombos[1], punishmentReaons[i] )
end

-- Function to open the GUI
bindKey ( "P", "Down",
	function ()
		if ( guiGetVisible( adminGUI.GUIwindow[1] ) ) then
			showCursor( false )
			guiSetVisible ( adminGUI.GUIwindow[1], false )
		else
			if ( isPlayerStaff ( localPlayer ) ) then
				showCursor( true ) onCheckPlayerACL ()
				guiSetVisible ( adminGUI.GUIwindow[1], true )
			end
		end
	end
)

-- Get the select player
function getAdminPanelSelectedPlayer ()
	local playerName = guiGridListGetItemText ( adminGUI.GUIgrids[1], guiGridListGetSelectedItem ( adminGUI.GUIgrids[1] ), 1 )
	local row, column = guiGridListGetSelectedItem ( adminGUI.GUIgrids[1] )
	if ( playerName ) and ( tostring( row ) ~= "-1" ) then
		if ( getPlayerFromName( playerName ) ) then
			return getPlayerFromName( playerName )
		end
	end
end

-- This puts all the players in a grid
for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
	local row = guiGridListAddRow ( adminGUI.GUIgrids[1] )
	if ( getPlayerTeam( thePlayer ) ) then
		guiGridListSetItemText ( adminGUI.GUIgrids[1], row, 1, getPlayerName( thePlayer ), false, false )
		guiGridListSetItemColor( adminGUI.GUIgrids[1], row, 1, getTeamColor ( getPlayerTeam( thePlayer ) ) )
	else
		guiGridListSetItemText ( adminGUI.GUIgrids[1], row, 1, getPlayerName( thePlayer ), false, false )
	end
end

-- Add a player when they join
addEventHandler("onClientPlayerJoin", root,
	function ()
		local row = guiGridListAddRow ( adminGUI.GUIgrids[1] )
		if ( getPlayerTeam( source ) ) then
			guiGridListSetItemText ( adminGUI.GUIgrids[1], row, 1, getPlayerName( source ), false, false )
			guiGridListSetItemColor( adminGUI.GUIgrids[1], row, 1, getTeamColor ( getPlayerTeam( source ) ) )
		else
			guiGridListSetItemText ( adminGUI.GUIgrids[1], row, 1, getPlayerName( source ), false, false )
		end
	end
)

-- Remove a player when they quit
addEventHandler("onClientPlayerQuit", root,
	function ()
		for i=1,guiGridListGetRowCount ( adminGUI.GUIgrids[1] ) do
			if ( guiGridListGetItemText ( adminGUI.GUIgrids[1], i, 1 ) == getPlayerName( source ) ) then
				guiGridListRemoveRow ( adminGUI.GUIgrids[1], i )
			end
		end
	end
)

-- When a player changes his nick
addEventHandler("onClientPlayerChangeNick", root,
	function ( oldNick, newNick )
		for i=1,guiGridListGetRowCount ( adminGUI.GUIgrids[1] ) do
			if ( guiGridListGetItemText ( adminGUI.GUIgrids[1], i, 1 ) == oldNick ) then
				guiGridListSetItemText ( adminGUI.GUIgrids[1], i, 1, newNick, false, false )
			end
		end
	end
)

-- Check for team colors so they are up-to-date and to keep the player field op-to-date
addEventHandler( "onClientRender", root,
	function ()
		for i=1,guiGridListGetRowCount ( adminGUI.GUIgrids[1] ) do
			local playerName = guiGridListGetItemText ( adminGUI.GUIgrids[1], i, 1 )
			if ( playerName ) and ( getPlayerFromName( playerName ) ) then
				if ( getPlayerTeam( getPlayerFromName( playerName ) ) ) then
					guiGridListSetItemColor( adminGUI.GUIgrids[1], i, 1, getTeamColor ( getPlayerTeam( getPlayerFromName( playerName ) ) ) )
				end
			end
		end

		if ( getAdminPanelSelectedPlayer () ) then
			local thePlayer = getAdminPanelSelectedPlayer ()
			local x, y, z = getElementPosition ( thePlayer )
			if ( getPedOccupiedVehicle( thePlayer ) ) then theVehicle = getVehicleName ( getPedOccupiedVehicle( thePlayer ) ) vehicleHealth = math.floor( getElementHealth( getPedOccupiedVehicle( thePlayer ) ) ) else theVehicle = "Walking" vehicleHealth = "N/A" end
			if ( getPlayerTeam( thePlayer ) ) then playerTeam = getTeamName( getPlayerTeam( thePlayer ) ) else playerTeam = "N/A" end
			if ( exports.server:getPlayerOccupation( thePlayer ) ) then playerOccupation = exports.server:getPlayerOccupation( thePlayer ) else playerOccupation = "N/A" end
			guiSetText( adminGUI.GUIlabels[3] , "Nickname: "..getPlayerName( thePlayer )  )
			guiSetText( adminGUI.GUIlabels[9] , "X: "..x )
			guiSetText( adminGUI.GUIlabels[10], "Y: "..y )
			guiSetText( adminGUI.GUIlabels[11], "Z: "..z )
			guiSetText( adminGUI.GUIlabels[12], "Dimension: "..getElementDimension( thePlayer ) )
			guiSetText( adminGUI.GUIlabels[13], "Interior: "..getElementInterior( thePlayer ) )
			guiSetText( adminGUI.GUIlabels[14], "Vehicle: "..theVehicle )
			guiSetText( adminGUI.GUIlabels[15], "Vehicle Health: "..vehicleHealth )
			guiSetText( adminGUI.GUIlabels[18], "Health: "..math.floor(getElementHealth( thePlayer ) ))
			guiSetText( adminGUI.GUIlabels[19], "Armor: "..math.floor(getPedArmor( thePlayer ) ))
			guiSetText( adminGUI.GUIlabels[20], "Skin: "..getElementModel( thePlayer ) )
			guiSetText( adminGUI.GUIlabels[22], "Occupation: "..playerOccupation )
			guiSetText( adminGUI.GUIlabels[23], "Team: "..playerTeam )
		end
	end
)

-- When searching a player
addEventHandler( "onClientGUIChanged", adminGUI.GUIedits[1],
	function ( theElement )
		guiGridListClear( adminGUI.GUIgrids[1] )
		for k, thePlayer in pairs( getElementsByType( "player" ) ) do
			if ( string.find( getPlayerName( thePlayer ):lower(), guiGetText( adminGUI.GUIedits[1] ):lower() ) ) then
				local row = guiGridListAddRow ( adminGUI.GUIgrids[1] )
				if ( getPlayerTeam( thePlayer ) ) then
					guiGridListSetItemText ( adminGUI.GUIgrids[1], row, 1, getPlayerName( thePlayer ), false, false )
					guiGridListSetItemColor( adminGUI.GUIgrids[1], row, 1, getTeamColor ( getPlayerTeam( thePlayer ) ) )
				else
					guiGridListSetItemText ( adminGUI.GUIgrids[1], row, 1, getPlayerName( thePlayer ), false, false )
				end
			end
		end
	end, false
)

-- When the player selects a player
addEventHandler( "onClientGUIClick", adminGUI.GUIgrids[1],
	function ()
		if ( getAdminPanelSelectedPlayer () ) then
			triggerServerEvent ( "onRequestAdminPlayerInfo", localPlayer, getAdminPanelSelectedPlayer () )
		end
	end
)

-- Callback when a player was clicked
addEvent( "onRequestAdminPlayerInfo:callBack", true )
addEventHandler( "onRequestAdminPlayerInfo:callBack", root,
	function ( theTable )
		if not ( source == localPlayer ) then return end
		guiSetText( adminGUI.GUIlabels[24], "Cash Money: "..theTable[1] )
		guiSetText( adminGUI.GUIlabels[25], "Bank Money: "..theTable[2] )
		guiSetText( adminGUI.GUIlabels[26], "Premium Hours: "..theTable[3] )
		guiSetText( adminGUI.GUIlabels[27], "Group name: "..theTable[4] )
		guiSetText( adminGUI.GUIlabels[29], "Email: "..theTable[5] )
		guiSetText( adminGUI.GUIlabels[21], "Playtime: "..theTable[6] )
		guiSetText( adminGUI.GUIlabels[4] , "Accountname: "..theTable[7] )
		guiSetText( adminGUI.GUIlabels[5] , "Serial: "..theTable[8] )
		guiSetText( adminGUI.GUIlabels[6] , "IP Adress: "..theTable[9] )
		guiSetText( adminGUI.GUIlabels[7] , "Country: "..theTable[10] )
		guiSetText( adminGUI.GUIlabels[16], "MTA Version "..theTable[11] )
	end
)

-- Callback when a player was clicked
addEvent( "onRequestAdminTable:callBack", true )
addEventHandler( "onRequestAdminTable:callBack", root,
	function ( theTable )
		guiGridListClear( adminGUI.GUIgrids[4] )
		for i=1,#theTable do
			local row = guiGridListAddRow ( adminGUI.GUIgrids[4] )
			if ( theTable[i].active == 1 ) then
				guiGridListSetItemText ( adminGUI.GUIgrids[4], row, 1, theTable[i].nickname, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[4], row, 2, theTable[i].rank, false, false )

				if ( theTable[i].developer == 1 ) then isDeveloper = "Yes" else isDeveloper = "No"  end
				if ( theTable[i].eventmanager == 1 ) then isEventmanager = "Yes" else isEventmanager = "No"  end

				guiGridListSetItemText ( adminGUI.GUIgrids[4], row, 3, isDeveloper, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[4], row, 4, isEventmanager, false, false )

				guiGridListSetItemColor( adminGUI.GUIgrids[4], row, 1, 0, 225, 0 )
			else
				guiGridListSetItemText ( adminGUI.GUIgrids[4], row, 1, theTable[i].nickname, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[4], row, 2, theTable[i].rank, false, false )

				if ( theTable[i].developer == 1 ) then isDeveloper = "Yes" else isDeveloper = "No"  end
				if ( theTable[i].eventmanager == 1 ) then isEventmanager = "Yes" else isEventmanager = "No"  end

				guiGridListSetItemText ( adminGUI.GUIgrids[4], row, 3, isDeveloper, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[4], row, 4, isEventmanager, false, false )

				guiGridListSetItemColor( adminGUI.GUIgrids[4], row, 1, 225, 0, 0 )
			end
		end
	end
)

-- timestamp
function timestampConvert ( timeStamp )
	if ( timeStamp == 0 ) then return "Permanently" end
	local time = getRealTime(timeStamp)
	local year = time.year + 1900
	local month = time.month + 1
	local day = time.monthday
	local hour = time.hour
	local minute = time.minute

	return "" .. hour ..":" .. minute .." - " .. month .."/" .. day .."/" .. year ..""
end

-- Callback for bans
addEvent( "onRequestBansTable:callBack", true )
addEventHandler( "onRequestBansTable:callBack", root,
	function ( theTable )
		guiGridListClear( adminGUI.GUIgrids[6] )
		-- Serial punishments
		guiGridListSetItemText( adminGUI.GUIgrids[6], guiGridListAddRow( adminGUI.GUIgrids[6] ), 1, "Serial Bans", true, false )
		for i=1,#theTable do
			if ( string.len( theTable[i].serial ) > 30 ) then
				local row = guiGridListAddRow ( adminGUI.GUIgrids[6] )
				guiGridListSetItemText ( adminGUI.GUIgrids[6], row, 1, theTable[i].serial, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[6], row, 2, theTable[i].reason, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[6], row, 3, theTable[i].bannedby, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[6], row, 4, timestampConvert ( theTable[i].banstamp ), false, false )
				guiGridListSetItemData ( adminGUI.GUIgrids[6], row, 1, theTable[i].id )
			end
		end
		-- Account bans
		guiGridListSetItemText( adminGUI.GUIgrids[6], guiGridListAddRow( adminGUI.GUIgrids[6] ), 1, "Account Bans", true, false )
		for i=1,#theTable do
			if ( string.len( theTable[i].serial ) < 30 ) then
				local row = guiGridListAddRow ( adminGUI.GUIgrids[6] )
				guiGridListSetItemText ( adminGUI.GUIgrids[6], row, 1, theTable[i].account, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[6], row, 2, theTable[i].reason, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[6], row, 3, theTable[i].bannedby, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[6], row, 4, timestampConvert ( theTable[i].banstamp ), false, false )
				guiGridListSetItemData ( adminGUI.GUIgrids[6], row, 1, theTable[i].id )
			end
		end
	end
)

-- Callback for punishments
addEvent( "onRequestPunishlog:callBack", true )
addEventHandler( "onRequestPunishlog:callBack", root,
	function ( serialTable, accountTable )
		guiGridListClear( adminGUI.GUIgrids[2] )
		-- Serial punishments
		guiGridListSetItemText( adminGUI.GUIgrids[2], guiGridListAddRow( adminGUI.GUIgrids[2] ), 1, "Serial Punishments", true, false )
		for i=1,#serialTable do
			local row = guiGridListAddRow ( adminGUI.GUIgrids[2] )
			guiGridListSetItemText ( adminGUI.GUIgrids[2], row, 1, serialTable[i].datum, false, false )
			guiGridListSetItemText ( adminGUI.GUIgrids[2], row, 2, serialTable[i].punishment, false, false )
			guiGridListSetItemData ( adminGUI.GUIgrids[2], row, 1, serialTable[i].uniqueid )

			if ( serialTable[i].active == 0 ) then
				guiGridListSetItemColor ( adminGUI.GUIgrids[2], row, 1, 225, 0, 0 )
				guiGridListSetItemColor ( adminGUI.GUIgrids[2], row, 2, 225, 0, 0 )
			end
		end
		-- Account bans
		guiGridListSetItemText( adminGUI.GUIgrids[2], guiGridListAddRow( adminGUI.GUIgrids[2] ), 1, "Account Punishments", true, false )
		for i=1,#accountTable do
			if ( string.len( accountTable[i].serial ) < 30 ) then
				local row = guiGridListAddRow ( adminGUI.GUIgrids[2] )
				guiGridListSetItemText ( adminGUI.GUIgrids[2], row, 1, accountTable[i].datum, false, false )
				guiGridListSetItemText ( adminGUI.GUIgrids[2], row, 2, accountTable[i].punishment, false, false )
				guiGridListSetItemData ( adminGUI.GUIgrids[2], row, 1, accountTable[i].uniqueid )

				if ( accountTable[i].active == 0 ) then
					guiGridListSetItemColor ( adminGUI.GUIgrids[2], row, 1, 225, 0, 0 )
					guiGridListSetItemColor ( adminGUI.GUIgrids[2], row, 2, 225, 0, 0 )
				end
			end
		end
	end
)

-- Event for the buttons in the management tab
addEventHandler ( "onClientGUIClick", root,
	function ()
		local nickName = guiGridListGetItemText ( adminGUI.GUIgrids[4], guiGridListGetSelectedItem ( adminGUI.GUIgrids[4] ), 1 )
		if ( source == adminGUI.GUIbuttons[41] ) then -- Kick
			if not ( type( nickName ) == "string" ) then return end
			triggerServerEvent( "onServerAdminChange", localPlayer, "kick", nickName )
		elseif ( source == adminGUI.GUIbuttons[42] ) then -- Promote
			if not ( type( nickName ) == "string" ) then return end
			triggerServerEvent( "onServerAdminChange", localPlayer, "promote", nickName )
		elseif ( source == adminGUI.GUIbuttons[43] ) then -- Demote
			if not ( type( nickName ) == "string" ) then return end
			triggerServerEvent( "onServerAdminChange", localPlayer, "demote", nickName )
		elseif ( source == adminGUI.GUIbuttons[44] ) then -- Developer
			if not ( type( nickName ) == "string" ) then return end
			triggerServerEvent( "onServerAdminChange", localPlayer, "developer", nickName )
		elseif ( source == adminGUI.GUIbuttons[45] ) then -- Eventmanager
			if not ( type( nickName ) == "string" ) then return end
			triggerServerEvent( "onServerAdminChange", localPlayer, "eventmanager", nickName )
		elseif ( source == adminGUI.GUIbuttons[46] ) then -- Rights
			if not ( type( nickName ) == "string" ) then return end
			triggerServerEvent( "onServerAdminChange", localPlayer, "inactive", nickName )
		elseif ( source == adminGUI.GUIbuttons[47] ) then -- Delete group

		elseif ( source == adminGUI.GUIbuttons[49] ) then -- Kick all members

		elseif ( source == adminGUI.GUIbuttons[50] ) then -- Rename

		elseif ( source == adminGUI.GUIbuttons[51] ) then -- Founder

		elseif ( source == adminGUI.GUIbuttons[52] ) then -- Money

		elseif ( source == adminGUI.GUIbuttons[53] ) then -- Join leader
		end
	end
)

-- Event for the tabs
addEventHandler ( "onClientGUITabSwitched", root,
	function ( tab )
		if ( source == adminGUI.GUItabs[2] ) then -- Player actions

		elseif ( source == adminGUI.GUItabs[3]  ) and ( getAdminPanelSelectedPlayer () ) then -- Punishlog
			triggerServerEvent( "onRequestPunishlog", localPlayer, getAdminPanelSelectedPlayer () )
		elseif ( source == adminGUI.GUItabs[4]  ) then -- Accounts

		elseif ( source == adminGUI.GUItabs[6]  ) then -- Server management
			triggerServerEvent( "onRequestAdminTable", localPlayer )
		elseif ( source == adminGUI.GUItabs[7]  ) then -- Bans
			--triggerServerEvent( "onRequestBansTable", localPlayer )
		end
	end
)

-- Event for the buttons in the tab to set player data
local spamProtection = false

function spamPro () spamProtection = getTickCount() end

addEventHandler ( "onClientGUIClick", root,
	function ()
		if ( spamProtection ) and ( getTickCount()-spamProtection < 2000 ) then return end
		if not ( getAdminPanelSelectedPlayer () ) then return end
		local thePlayer = getAdminPanelSelectedPlayer ()
		if ( source == adminGUI.GUIbuttons[1] ) then -- Slap Player
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "slap" )
		elseif ( source == adminGUI.GUIbuttons[2]  ) then -- Freeze Player
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "freeze" )
		elseif ( source == adminGUI.GUIbuttons[3]  ) then -- Kick Player
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "kick" ) spamPro()
		elseif ( source == adminGUI.GUIbuttons[4]  ) then -- Reconnect Player
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "reconnect" ) spamPro()
		elseif ( source == adminGUI.GUIbuttons[5]  ) then -- Warp To Player
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "warp" )
		elseif ( source == adminGUI.GUIbuttons[6]  ) then -- Warp Player To...
			triggerServerEvent("onAdminPlayerActions",localPlayer,thePlayer,"warpTo")
		elseif ( source == adminGUI.GUIbuttons[7]  ) then -- Fix Vehicle
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "fixvehicle" )
		elseif ( source == adminGUI.GUIbuttons[8]  ) then -- Destroy Vehicle
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "destroyvehicle" )
		elseif ( source == adminGUI.GUIbuttons[9]  ) then -- Spectate Player
			onPlayerSpecate ( thePlayer )
		elseif ( source == adminGUI.GUIbuttons[10] ) then -- Give Vehicle
			if ( getVehicleModelFromName ( guiGetText( adminGUI.GUIedits[4] ) ) ) then triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "vehicle", getVehicleModelFromName ( guiGetText( adminGUI.GUIedits[4] ) ) ) else exports.DENdxmsg:createNewDxMessage ( "No vehicle found with that name!", 0, 225, 0 ) end
		elseif ( source == adminGUI.GUIbuttons[11] ) then -- Set Skin
			if ( string.match( guiGetText( adminGUI.GUIedits[4] ), '^%d+$' ) ) then triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "skin", tonumber( guiGetText( adminGUI.GUIedits[4] ) ) ) end
		elseif ( source == adminGUI.GUIbuttons[12] ) then -- Rename
			if ( guiGetText( adminGUI.GUIedits[4] ) ~= "" ) or ( guiGetText( adminGUI.GUIedits[4] ) ~= " " ) then triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "rename", guiGetText( adminGUI.GUIedits[4] ) ) end
		elseif ( source == adminGUI.GUIbuttons[13] ) then -- Give health
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "health" )
		elseif ( source == adminGUI.GUIbuttons[80] ) then -- Give armor
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "armor" )
		elseif ( source == adminGUI.GUIbuttons[14] ) then -- Give Jetpack
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "jetpack" )
		elseif ( source == adminGUI.GUIbuttons[15] ) then -- Give Premium Car
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "premium" )
		elseif ( source == adminGUI.GUIbuttons[16] ) then -- Give Weapon
			if ( getWeaponIDFromName ( guiGetText( adminGUI.GUIedits[5] ) ) ) and ( string.match( guiGetText( adminGUI.GUIedits[6] ), '^%d+$' ) ) then triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "weapon", getWeaponIDFromName ( guiGetText( adminGUI.GUIedits[5] ) ), tonumber( guiGetText( adminGUI.GUIedits[6] ) ) ) else exports.DENdxmsg:createNewDxMessage ( "No weapon found with that name!", 0, 225, 0 ) end
		elseif ( source == adminGUI.GUIbuttons[18] ) then -- Interior
			if ( string.match( guiGetText( adminGUI.GUIedits[71] ), '^%d+$' ) ) then triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "interior", tonumber( guiGetText( adminGUI.GUIedits[71] ) ) ) end
		elseif ( source == adminGUI.GUIbuttons[20] ) then -- Dimension
			if ( string.match( guiGetText( adminGUI.GUIedits[71] ), '^%d+$' ) ) then triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "dimension", tonumber( guiGetText( adminGUI.GUIedits[71] ) ) ) end
		end
	end
)

-- Function get punishment reason
function getPunishmentReason ()
	if ( guiComboBoxGetItemText ( adminGUI.GUIcombos[1], guiComboBoxGetSelected( adminGUI.GUIcombos[1] ) ) == "#00 - Custom reason" ) then
		return guiGetText ( adminGUI.GUIedits[2] )
	else
		return guiComboBoxGetItemText ( adminGUI.GUIcombos[1], guiComboBoxGetSelected ( adminGUI.GUIcombos[1] ) )
	end
end

-- Get the punishment time
function getPunishmentTime ()
	if ( guiRadioButtonGetSelected ( adminGUI.GUIradios[4] ) ) then
		return 0
	elseif ( string.match( guiGetText( adminGUI.GUIedits[3] ), '^%d+$' ) ) then
		if ( guiRadioButtonGetSelected ( adminGUI.GUIradios[1] ) ) then
			return ( tonumber( guiGetText( adminGUI.GUIedits[3] ) ) * 86400 )
		elseif ( guiRadioButtonGetSelected ( adminGUI.GUIradios[2] ) ) then
			return ( tonumber( guiGetText( adminGUI.GUIedits[3] ) ) * 3600 )
		elseif ( guiRadioButtonGetSelected ( adminGUI.GUIradios[3] ) ) then
			return ( tonumber( guiGetText( adminGUI.GUIedits[3] ) ) * 60 )
		else
			return false
		end
	else
		exports.DENdxmsg:createNewDxMessage ( "No valid punishment time enterd!", 0, 225, 0 )
		return false
	end
end

-- Punishing a player
addEventHandler ( "onClientGUIClick", adminGUI.GUIbuttons[17],
	function ()
		local thePlayer = getAdminPanelSelectedPlayer ()
		if not ( thePlayer ) then return end
		if ( guiCheckBoxGetSelected ( adminGUI.GUIchecks[1] ) ) then
			if ( guiComboBoxGetItemText ( adminGUI.GUIcombos[2], guiComboBoxGetSelected ( adminGUI.GUIcombos[2] ) ) == "Mainchat/teamchat mute" )  then
				triggerServerEvent( "onServerPlayerPunishRemove", localPlayer, thePlayer, "Mainchat/teamchat mute" )
			elseif ( guiComboBoxGetItemText ( adminGUI.GUIcombos[2], guiComboBoxGetSelected ( adminGUI.GUIcombos[2] ) ) == "Global mute" ) then
				triggerServerEvent( "onServerPlayerPunishRemove", localPlayer, thePlayer, "Global mute" )
			elseif ( guiComboBoxGetItemText ( adminGUI.GUIcombos[2], guiComboBoxGetSelected ( adminGUI.GUIcombos[2] ) ) == "Jail" ) then
				triggerServerEvent( "onServerPlayerPunishRemove", localPlayer, thePlayer, "Jail" )
			end
		elseif ( guiComboBoxGetItemText ( adminGUI.GUIcombos[2], guiComboBoxGetSelected ( adminGUI.GUIcombos[2] ) ) == "Mainchat/teamchat mute" ) and ( getPunishmentTime () ) then
			if ( getPunishmentTime () == 0 ) then exports.DENdxmsg:createNewDxMessage ( "You can't mute someone permanently!", 0, 225, 0 ) return end
			triggerServerEvent( "onServerPlayerPunish", localPlayer, thePlayer, "Mainchat/teamchat mute", getPunishmentTime (), getPunishmentReason () )
		elseif ( guiComboBoxGetItemText ( adminGUI.GUIcombos[2], guiComboBoxGetSelected ( adminGUI.GUIcombos[2] ) ) == "Global mute" ) and ( getPunishmentTime () ) then
			if ( getPunishmentTime () == 0 ) then exports.DENdxmsg:createNewDxMessage ( "You can't mute someone permanently!", 0, 225, 0 ) return end
			triggerServerEvent( "onServerPlayerPunish", localPlayer, thePlayer, "Global mute", getPunishmentTime (), getPunishmentReason () )
		elseif ( guiComboBoxGetItemText ( adminGUI.GUIcombos[2], guiComboBoxGetSelected ( adminGUI.GUIcombos[2] ) ) == "Jail" ) and ( getPunishmentTime () ) then
			if ( getPunishmentTime () == 0 ) then exports.DENdxmsg:createNewDxMessage ( "You can't jail someone permanently!", 0, 225, 0 ) return end
			triggerServerEvent( "onServerPlayerPunish", localPlayer, thePlayer, "Jail", getPunishmentTime (), getPunishmentReason () )
		elseif ( guiComboBoxGetItemText ( adminGUI.GUIcombos[2], guiComboBoxGetSelected ( adminGUI.GUIcombos[2] ) ) == "Account ban" ) and ( getPunishmentTime () ) then
			triggerServerEvent( "onServerPlayerPunish", localPlayer, thePlayer, "Account ban", getPunishmentTime (), getPunishmentReason () )
		elseif ( guiComboBoxGetItemText ( adminGUI.GUIcombos[2], guiComboBoxGetSelected ( adminGUI.GUIcombos[2] ) ) == "Serial ban" ) and ( getPunishmentTime () ) then
			triggerServerEvent( "onServerPlayerPunish", localPlayer, thePlayer, "Serial ban", getPunishmentTime (), getPunishmentReason () )
		end
	end, false
)

--event management system handlers
addEventHandler("onClientGUIClick",root,
function(button,state)
	if (source == adminGUI.GUIbuttons[22]) then --create event
		local eventName = guiGetText(adminGUI.GUIedits[18]) --event name
		local maxPlayers = guiGetText(adminGUI.GUIedits[19]) --players
		local interior = getElementInterior(localPlayer) --int
		local dimension = getElementDimension(localPlayer) --dim
		if not (eventName ~= "") and not (maxPlayers ~= "") and not (type(maxPlayers) == "string") then
			triggerServerEvent("onCreateWarpEvent",localPlayer,maxPlayers,dimension,interior,eventName)
			outputDebugString("Toggling new event...",0,255,0,0)
		else
			exports.DENdxmsg:createNewDxMessage(localPlayer,"Eventname or maxplayers is not filled correctly.",255,0,0)
		end
	elseif (source == adminGUI.GUIbuttons[23]) then --unfreeze all players
		triggerServerEvent("onUnfreezeEventPlayers",localPlayer)
		outputDebugString("Toggling unfreeze...",0,255,0,0)
	elseif (source == adminGUI.GUIbuttons[24]) then --destroy event
		triggerServerEvent("onDestroyEvent",localPlayer)
		outputDebugString("Toggling destroy event...",0,255,0,0)
	end
end)

onClientSearchPlayerFromEmGrid()
