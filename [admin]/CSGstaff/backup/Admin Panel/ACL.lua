-- GUI table
local adminGUI = getAdminPanelGUI ()
-- ACL Table
local adminPanelACL = {
	-- Tabs
	{ adminGUI.GUItabs[1], 1 },
	{ adminGUI.GUItabs[2], 1 },
	{ adminGUI.GUItabs[3], 1 },
	{ adminGUI.GUItabs[4], 4 },
	{ adminGUI.GUItabs[6], 5 },
	{ adminGUI.GUItabs[7], 3 },
	-- Buttons
	{ adminGUI.GUIbuttons[1], 1 }, -- Slap Player
	{ adminGUI.GUIbuttons[2], 1 }, -- Freeze Player
	{ adminGUI.GUIbuttons[3], 1 }, -- Kick Player
	{ adminGUI.GUIbuttons[4], 2 }, -- Reconnect Player
	{ adminGUI.GUIbuttons[5], 1 }, -- Warp To Player
	{ adminGUI.GUIbuttons[6], 3 }, -- Warp Player To...
	{ adminGUI.GUIbuttons[7], 3 }, -- Fix Vehicle
	{ adminGUI.GUIbuttons[8], 2 }, -- Destroy Vehicle
	{ adminGUI.GUIbuttons[9], 1 }, -- Spectate Player
	{ adminGUI.GUIbuttons[10], 4 }, -- Give Vehicle
	{ adminGUI.GUIbuttons[11], 4 }, -- Set Skin
	{ adminGUI.GUIbuttons[12], 2 }, -- Rename
	{ adminGUI.GUIbuttons[13], 4 }, -- Give health
	{ adminGUI.GUIbuttons[80], 4 }, -- Give Armor
	{ adminGUI.GUIbuttons[14], 3 }, -- Give Jetpack
	{ adminGUI.GUIbuttons[15], 4 }, -- Give Premium Car
	{ adminGUI.GUIbuttons[16], 5 }, -- Give Weapon
	{ adminGUI.GUIbuttons[17], 1 }, -- Punish Player
	{ adminGUI.GUIbuttons[18], 2 }, -- Interior
	{ adminGUI.GUIbuttons[20], 2 }, -- Dimension
}

-- Punishments ACL
local punishmentTypes = {
	{ "Mainchat/teamchat mute", 1 },
	{ "Global mute", 1 },
	{ "Jail", 1 },
	{ "Account ban", 3 },
	{ "Serial ban", 3 },
}

-- Function that gets the ACL table
function onCheckPlayerACL ()
	for i=1,#adminPanelACL do
		if ( adminPanelACL[i][2] > getPlayerAdminLevel( localPlayer ) ) then
			guiSetEnabled ( adminPanelACL[i][1], false )
		else
			guiSetEnabled ( adminPanelACL[i][1], true )
		end
	end
	
	if ( isPlayerEventManager ( localPlayer ) ) then
		guiSetEnabled ( adminGUI.GUItabs[5], true )
	else
		guiSetEnabled ( adminGUI.GUItabs[5], false )
	end
	
	guiComboBoxClear ( adminGUI.GUIcombos[2] )
	for i=1,#punishmentTypes do
		if ( getPlayerAdminLevel( localPlayer ) >= punishmentTypes[i][2] ) then
			guiComboBoxAddItem( adminGUI.GUIcombos[2], punishmentTypes[i][1] )
		end
	end
end