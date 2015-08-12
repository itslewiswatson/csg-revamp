local groupRanks = { ["Guest"]=0, ["Trial"]=1, ["Member"]=2, ["Group staff"]=3, ["Group leader"]=4, ["Group founder"]=5 }
local ranknumberTorankname = { [0]="Guest", [1]="Trial", [2]="Member", [3]="Group staff", [4]="Group leader", [5]="Group founder" }

-- If you set a rank all ACL right all ranks above them one you used are able to use the function
-- Use 999 if you want to set something only usable for users not in a group
-- Use 888 if the option shouldn't be usable for group founders

function getGroupRankACL ()
	return groupRanks
end

function ranknumberToName ()
	return ranknumberTorankname
end

function getGroupsACL ()
	local CSGGroupsGUI = getGroupsTableGUI ()
	local groupACL = {
		-- Tabs
		{CSGGroupsGUI[3] , 0},
		{CSGGroupsGUI[28], 1},
		{CSGGroupsGUI[31], 1},
		{CSGGroupsGUI[35], 3},
		{CSGGroupsGUI[50], 1},
		{CSGGroupsGUI[56], 0},
		{CSGGroupsGUI[61], 0},
		-- Buttons and GUI elements
		{CSGGroupsGUI[4] , 999},
		{CSGGroupsGUI[5] , 999},
		{CSGGroupsGUI[59], 999},
		{CSGGroupsGUI[17], 888},
		{CSGGroupsGUI[34], 3},
		{CSGGroupsGUI[39], 3},
		{CSGGroupsGUI[40], 3},
		{CSGGroupsGUI[41], 3},
		{CSGGroupsGUI[42], 4},
		{CSGGroupsGUI[43], 4},
		{CSGGroupsGUI[44], 3},
		{CSGGroupsGUI[45], 4},
		{CSGGroupsGUI[46], 5},
		{CSGGroupsGUI[47], 5},
		{CSGGroupsGUI[53], 5},
		{CSGGroupsGUI[54], 1},
		{CSGGroupsGUI[55], 1},
		{CSGGroupsGUI[67], 3},
		{CSGGroupsGUI[76], 3},
		{CSGGroupsGUI[80], 3},
		{CSGGroupsGUI[93], 5},
		{CSGGroupsGUI[98], 5},
		{CSGGroupsGUI[108], 4}
	}
	
	return groupACL
end
-- alliances

-- 0 = not in alliance
-- 1 = not in alliance, but is group founder
-- 2 = alliance's group's members
-- 3 = group founder
-- 4 = alliance founder
function getAliancesACL ()
	return {
		-- Tabs
		{allianceGUI.tabs.groups[1] , 2},
		{allianceGUI.tabs.info[1] , 2},
		{allianceGUI.tabs.maintenance[1], 3},
		{allianceGUI.tabs.bank[1], 2},
		{allianceGUI.tabs.invites[1], 1},
		{allianceGUI.tabs.alliances[1], 0},
		-- Buttons and GUI elements
		{allianceGUI.tabs.invites.acceptInvite,1,1},
		{allianceGUI.tabs.invites.rejectInvite,1},
		{allianceGUI.tabs.info.update,3},
		{allianceGUI.tabs.main.createNewAlliance , 1, 1},
		{allianceGUI.tabs.main.createNewAllianceEdit , 1, 1},
		{allianceGUI.tabs.main.leaveAlliance, 3},
		{allianceGUI.tabs.maintenance.deleteAlliance, 4},
		{allianceGUI.tabs.maintenance.setAllianceFounder, 4},
		{allianceGUI.tabs.maintenance.shareBases, 4},
		-- ?banking?
		
		{}
	}

end

