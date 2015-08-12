
local alliances = {}
local allianceGroups = {}
local alliancesFile

-- Group ranks
local groupRanks = { ["Guest"]=0, ["Trial"]=1, ["Member"]=2, ["Group staff"]=3, ["Group leader"]=4, ["Group founder"]=5 }

-- Get a table with all the players from a group
local updateTick = false
local theTable = {}

function getGroupPlayers ( theGroup )
	if not ( updateTick ) or ( getTickCount()-updateTick > 60000 ) then
		updateTick = getTickCount()
		theTable = {}
		for k, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
			if ( getElementData( thePlayer, "Group" ) == theGroup ) then
				table.insert( theTable, thePlayer )
			end
		end
		return theTable
	else
		return theTable
	end
end

-- Get all the data needed to show the groups panel
addEvent( "requestGroupsData", true )
addEventHandler( "requestGroupsData", root,
	function ()
		local playerID = exports.server:getPlayerAccountID( source )
		local groupID = exports.server:getPlayerGroupID( source )
		if ( playerID ) and ( groupID ) then
			dbQuery(grCallBack,{source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups WHERE membercount > 7 ORDER BY membercount DESC" )
			--local groupsTable = exports.DENmysql:query( "SELECT * FROM groups ORDER BY groupid ASC" )
			--local invitesTable = exports.DENmysql:query( "SELECT * FROM groups_invites WHERE memberid=? ORDER BY groupid ASC", playerID )
			--local memberTable = exports.DENmysql:querySingle( "SELECT * FROM groups_members WHERE memberid=? LIMIT 1", playerID )
			--local membersTable = exports.DENmysql:query( "SELECT * FROM groups_members WHERE groupid=? LIMIT 80", groupID )
			--local bankingTable = exports.DENmysql:query( "SELECT * FROM groups_transactions WHERE groupid=? ORDER BY datum DESC LIMIT 25", groupID )
			--triggerClientEvent( source, "onRequestGroupDataCallback", source, groupsTable, invitesTable, memberTable, bankingTable, membersTable, groupID )

			--if ( #membersTable ) then exports.DENmysql:exec( "UPDATE groups SET membercount=? WHERE groupid=?", #membersTable, groupID ) end
		else
			dbQuery(nogGroupsCB,{source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups WHERE membercount > 7 ORDER BY membercount DESC")
			--local groupsTable = exports.DENmysql:query( "SELECT * FROM groups ORDER BY groupid ASC" )
			--local invitesTable = exports.DENmysql:query( "SELECT * FROM groups_invites WHERE memberid=? ORDER BY groupid ASC", playerID )
			--triggerClientEvent( source, "onRequestGroupDataCallback", source, groupsTable, invitesTable, false, false )
		end
	end
)

function nogGroupsCB(qh,source,playerID)
	if isElement(source) then else return end
	local groupsTable=dbPoll(qh,0)
	dbQuery(nogInvitesCB,{source,groupsTable},exports.DENmysql:getConnection(),"SELECT * FROM groups_invites WHERE memberid=? ORDER BY groupid ASC", playerID)
end

function nogInvitesCB(qh,source,groupsTable)
	if isElement(source) then else return end
	local invitesTable=dbPoll(qh,0)
	triggerClientEvent( source, "onRequestGroupDataCallback", source, groupsTable, invitesTable, false, false )
end

function grCallBack(qh,source,playerID)
	if isElement(source) then else return end
	local groupsTable=dbPoll(qh,0)
	--	outputDebugString("1")
	dbQuery(invitesCallBack,{groupsTable,source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups_invites WHERE memberid=? ORDER BY groupid ASC", playerID )
end

function invitesCallBack(qh,groupsTable,source,playerID)
	if isElement(source) then else return end
	local invitesTable=dbPoll(qh,0)
	--	outputDebugString("2")
	dbQuery(memberCallBack,{groupsTable,invitesTable,source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups_members WHERE memberid=? LIMIT 1", playerID )
end

function memberCallBack(qh,groupsTable,invitesTable,source,playerID)
	if isElement(source) then else return end
	local memberTable=dbPoll(qh,0)
	--	outputDebugString("3")
	memberTable=memberTable[1]
	local groupID = exports.server:getPlayerGroupID( source )
	dbQuery(membersCallBack,{groupsTable,invitesTable,memberTable,source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups_members WHERE groupid=? LIMIT 80", groupID )
end

function membersCallBack(qh,groupsTable,invitesTable,memberTable,source,playerID)
	if isElement(source) then else return end
	local membersTable=dbPoll(qh,0)
	local groupID = exports.server:getPlayerGroupID( source )
	--outputDebugString("4")
	dbQuery(bankingCallBack,{groupsTable,invitesTable,memberTable,membersTable,source,playerID},exports.DENmysql:getConnection(),"SELECT * FROM groups_transactions WHERE groupid=? ORDER BY datum DESC LIMIT 25", groupID )
end

function bankingCallBack(qh,groupsTable,invitesTable,memberTable,membersTable,source,playerID)
	if isElement(source) then else return end
	local bankingTable=dbPoll(qh,0)
		--outputDebugString("5")
	local groupID = exports.server:getPlayerGroupID( source )
	triggerClientEvent( source, "onRequestGroupDataCallback", source, groupsTable, invitesTable, memberTable, bankingTable, membersTable, groupID )
	if ( #membersTable ) then exports.DENmysql:exec( "UPDATE groups SET membercount=? WHERE groupid=?", #membersTable, groupID ) end
end



-- When a player wants to create a new group
addEvent( "onServerCreateNewGroup", true )
addEventHandler( "onServerCreateNewGroup", root,
	function ( groupName )
		dbQuery(createCB,{source,groupName},exports.DENmysql:getConnection(),"SELECT groupid FROM groups WHERE groupname=? LIMIT 1", groupName )
		--local groupCheck = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupname=? LIMIT 1", groupName )
	end
)

function createCB(qh,source,groupName)
	if isElement(source) then else return end
	local groupCheck=dbPoll(qh,0)
		if ( groupCheck[1] ) then
			exports.DENdxmsg:createNewDxMessage( source, "There is already a group with this name!", 200, 0, 0 )
		elseif (checkForBlacklist(groupName) == true) then
			exports.DENdxmsg:createNewDxMessage( source, "This group is blacklisted. Contact Leading Staff for information.",200,0,0)
		else
			local playerAccount = exports.server:getPlayerAccountName ( source )
			local playerID = exports.server:getPlayerAccountID( source )
			local createMySQL = exports.DENmysql:exec( "INSERT INTO groups SET groupleader=?, groupname=?", playerAccount, groupName )
			if ( createMySQL ) then
				dbQuery(createCB2,{source,groupName},exports.DENmysql:getConnection(),"SELECT * FROM groups WHERE groupname=? LIMIT 1", groupName)
			end
		end
end

function checkForBlacklist(group)
	if (group ~= "") then
		query = exports.DENmysql:querySingle("SELECT * FROM groups_blacklist WHERE groupname=? LIMIT 1",string.lower(group))
		if (query) then --its there..
			return true
		else
			return false
		end
	end
end

function createCB2(qh,source,groupName)
	if isElement(source) then else return end
	local groupTable = dbPoll(qh,0)
	if ( groupTable ) then
		groupTable=groupTable[1]
		local playerID = exports.server:getPlayerAccountID( source )
		local playerAccount = exports.server:getPlayerAccountName ( source )
		exports.DENmysql:exec("INSERT INTO groups_members SET groupid=?, memberid=?, membername=?, groupname=?, grouprank=?", groupTable.groupid, playerID, playerAccount, groupName, "Group founder" )
        exports.DENmysql:exec( "INSERT INTO groups_transactions SET groupid=?, memberid=?, transaction=?", groupID, playerID, getPlayerName( source ).." created the group. $0" )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,"Group created by "..getPlayerName(source)..".",getRealTime().timestamp)
		setElementData( source, "GroupID", groupTable.groupid, true )
		setElementData( source, "Group", groupTable.groupname, true )
		setElementData( source, "GroupRank", "Group founder", true )
		triggerClientEvent( source, "onClientFinishGroupCreate", source, true )
	end
end

-- When a player leaves the group
addEvent( "onServerLeaveGroup", true )
addEventHandler( "onServerLeaveGroup", root,
	function ()
		local groupID = exports.server:getPlayerGroupID( source )
		local playerID = exports.server:getPlayerAccountID( source )
		if ( groupID ) then
			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." left the group!" )
			exports.DENmysql:exec( "DELETE FROM groups_members WHERE memberid=?", playerID )
			exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,getPlayerName(source).." left the group!",getRealTime().timestamp)
			setElementData( source, "Group", false )
			setElementData( source, "GroupID", false )
			setElementData( source, "GroupRank", false)
			triggerClientEvent( source, "onClientHideGroupsWindow", source )
		end
	end
)

-- When a player updates the group information
addEvent( "onServerUpdateGroupInformation", true )
addEventHandler( "onServerUpdateGroupInformation", root,
	function ( groupInformation )
		local groupID = exports.server:getPlayerGroupID( source )
		if ( groupID ) then
			exports.DENmysql:exec( "UPDATE groups SET groupinfo=? WHERE groupid=?", groupInformation, groupID )
			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." updated the group information!" )
			exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,getPlayerName(source).." updated the group information!",getRealTime().timestamp)
		end
	end
)

-- When the player want to deposit money
addEvent( "onServerGroupBankingDeposit", true )
addEventHandler( "onServerGroupBankingDeposit", root,
	function ( theMoney,turfBag )
		local playerID = exports.server:getPlayerAccountID( source )
		local groupID = exports.server:getPlayerGroupID( source )
		if ( groupID ) then
			local groupsBalance = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
			if ( groupsBalance ) then
				local theBalance = ( tonumber( groupsBalance.groupbalance ) + tonumber( theMoney ) )
				exports.DENmysql:exec( "UPDATE groups SET groupbalance=? WHERE groupid=?", theBalance, groupID )
				if (turfBag) then
					exports.DENmysql:exec( "INSERT INTO groups_transactions SET groupid=?, memberid=?, transaction=?", groupID, playerID, getPlayerName( source ).." deposited $"..theMoney.." from a turf money bag" )
				else
					exports.DENmysql:exec( "INSERT INTO groups_transactions SET groupid=?, memberid=?, transaction=?", groupID, playerID, getPlayerName( source ).." deposited $"..theMoney )
				end

				exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,getPlayerName(source).." deposited $"..theMoney.." to the group bank.",getRealTime().timestamp)
				if (turfBag) then
					for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do triggerClientEvent( thePlayer, "onClientUpdateGroupBalance", thePlayer, tonumber( theBalance ), tonumber( theMoney ), "deposited", source ) end
					exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." picked up a turf money bag - $"..theMoney.." added to the group bank!" )
					exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." picked up a turf money bag - $" .. theMoney .. " for his group (GROUPID: " .. groupID .. ") (GROUP: " .. getElementData( source, "Group" ) .. ")" )
				else
					takePlayerMoney( source, tonumber( theMoney ) )
					for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do triggerClientEvent( thePlayer, "onClientUpdateGroupBalance", thePlayer, tonumber( theBalance ), tonumber( theMoney ), "deposited", source ) end
					exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." deposited $"..theMoney.." into the group bank!" )
					exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." has deposited $" .. theMoney .. " to his group (GROUPID: " .. groupID .. ") (GROUP: " .. getElementData( source, "Group" ) .. ")" )
				end
			end
		end
	end
)

-- When the play withdraw money
addEvent( "onServerGroupBankingWithdrawn", true )
addEventHandler( "onServerGroupBankingWithdrawn", root,
	function ( theMoney )
		local playerID = exports.server:getPlayerAccountID( source )
		local groupID = exports.server:getPlayerGroupID( source )
		if ( groupID ) then
			local groupsBalance = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
			if ( groupsBalance ) then
				if ( groupsBalance.groupbalance - tonumber( theMoney ) >= 0 ) then
					local theBalance = ( tonumber( groupsBalance.groupbalance ) - tonumber( theMoney ) )
					exports.DENmysql:exec( "UPDATE groups SET groupbalance=? WHERE groupid=?", theBalance, groupID )
					exports.DENmysql:exec( "INSERT INTO groups_transactions SET groupid=?, memberid=?, transaction=?", groupID, playerID, getPlayerName( source ).." withdrawn $"..theMoney )
					exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,getPlayerName(source).." withdrawn $"..theMoney.." to the bank",getRealTime().timestamp)
					givePlayerMoney( source, tonumber( theMoney ) )
					for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do triggerClientEvent( thePlayer, "onClientUpdateGroupBalance", thePlayer, tonumber( theBalance ), tonumber( theMoney ), "withdrawn", source ) end
					exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." withdrawn $"..theMoney.." from the group bank!" )
					exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." has withdrawn $" .. theMoney .. " from his group (GROUPID: " .. groupID .. ") (GROUP: " .. getElementData( source, "Group" ) .. ")" )
				else
					exports.DENdxmsg:createNewDxMessage( source, "The group doesn't have this amount of money on the bank!", 225, 0, 0 )
				end
			end
		end
	end
)

-- When the player delete a group invite
addEvent( "onServerDeleteGroupInvite", true )
addEventHandler( "onServerDeleteGroupInvite", root,
	function ( groupID )
		local playerID = exports.server:getPlayerAccountID( source )
		exports.DENmysql:exec( "DELETE FROM groups_invites WHERE groupid=? AND memberid=?", groupID, playerID )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,getPlayerName(source).." declined the group invite.",getRealTime().timestamp)
	end
)

-- When the player accept a group invite
addEvent( "onServerAcceptGroupInvite", true )
addEventHandler( "onServerAcceptGroupInvite", root,
	function ( groupID )
		local playerID = exports.server:getPlayerAccountID( source )
		local playerAccount = exports.server:getPlayerAccountName ( source )
		local groupTable = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupid=? LIMIT 1", groupID )
		if ( groupTable ) then
			exports.DENmysql:exec( "DELETE FROM groups_invites WHERE memberid=?", playerID )
			exports.DENmysql:exec( "INSERT INTO groups_members SET groupid=?, memberid=?, membername=?, groupname=?, grouprank=?", groupTable.groupid, playerID, playerAccount, groupTable.groupname, "Trial" )
			exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,getPlayerName(source).." has accepted the invite and joined the group.",getRealTime().timestamp)
			setElementData( source, "Group", groupTable.groupname )
			setElementData( source, "GroupID", groupTable.groupid )
			setElementData( source, "GroupRank", groupTable.grouprank )
			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." has joined the group!" )
			triggerClientEvent( source, "onClientHideGroupsWindow", source )
		end
	end
)

-- Send a note to all players
addEvent( "onServerSendNoteToAllPlayers", true )
addEventHandler( "onServerSendNoteToAllPlayers", root,
	function ( theMessage )
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, "[GROUP NOTE] " .. getPlayerName( source ) .. ": "..theMessage )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",getElementData(source,"GroupID"),getPlayerName(source).."(GROUP NOTE): "..theMessage,getRealTime().timestamp)
	end
)

-- Send a note to a selected player
addEvent( "onServerSendNoteToPlayer", true )
addEventHandler( "onServerSendNoteToPlayer", root,
	function ( thePlayer, theMessage )
		outputChatBox( "[GROUP MESSAGE] " .. getPlayerName( source ) .. ": "..theMessage, thePlayer, 200, 0, 0 )
	end
)


-- When a new player gets invited
addEvent( "onServerGroupInvitePlayer", true )
addEventHandler( "onServerGroupInvitePlayer", root,
	function ( thePlayer )
		local playerID = exports.server:getPlayerAccountID( thePlayer )
		local groupID = exports.server:getPlayerGroupID( source )
		local groupName = getElementData( source, "Group" )
		local groupInvite = exports.DENmysql:querySingle( "SELECT * FROM groups_invites WHERE memberid=? AND groupid=? LIMIT 1", playerID, groupID )
		local groupMembers = exports.DENmysql:query( "SELECT * FROM groups_members WHERE groupid=?", groupID )
		if ( groupInvite ) then
			exports.DENdxmsg:createNewDxMessage( source, "This player is already invited for your group!", 0, 225, 0 )
		elseif ( #groupMembers >= 55 ) then
			exports.DENdxmsg:createNewDxMessage( source, "Your group already has reached the maximum amount of members! (50)", 0, 225, 0 )
		else
			exports.DENmysql:exec( "INSERT INTO groups_invites SET groupid=?, memberid=?, groupname=?, invitedby=?" ,groupID, playerID, groupName, getPlayerName( source ) )
			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." invited "..getPlayerName( thePlayer ) )
			exports.DENdxmsg:createNewDxMessage( thePlayer, getPlayerName( source ).." invited you for the group "..groupName, 0, 225, 0 )
			exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,getPlayerName(source).." invited "..getPlayerName(thePlayer).." to the group.",getRealTime().timestamp)
		end
	end
)

-- When a player get kicked
addEvent( "onServerGroupPlayerKicked", true )
addEventHandler( "onServerGroupPlayerKicked", root,
	function ( accountName, thePlayer )
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." kicked "..accountName )
		exports.DENmysql:exec( "DELETE FROM groups_members WHERE membername=?", accountName )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",getElementData(thePlayer,"GroupID"),getPlayerName(thePlayer).." was kicked from the group by "..getPlayerName(source),getRealTime().timestamp)
		if ( thePlayer ) then
			setElementData( thePlayer, "Group", false )
			setElementData( thePlayer, "GroupID", false )
			setElementData( thePlayer, "GroupRank", false )
			triggerClientEvent( thePlayer, "onClientHideGroupsWindow", source )
		end
	end
)

-- Change turf color
addEvent( "onServerGroupApplyTurfColor", true )
addEventHandler( "onServerGroupApplyTurfColor", root,
	function ( R, G, B )
		local groupID = exports.server:getPlayerGroupID( source )
		local colorString = R.."," .. G .. ","..B
		exports.DENmysql:exec( "UPDATE groups SET turfcolor=? WHERE groupid=?", colorString, groupID )
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." changed the turf color!" )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,getPlayerName(source).." changed the group turf color.",getRealTime().timestamp)
		exports.server:setGroupColor(groupID,colorString)
	end
)

-- Set new group leader
addEvent( "onServerGroupApplyNewFounder", true )
addEventHandler( "onServerGroupApplyNewFounder", root,
	function ( accountName, thePlayer )
		local playerID = exports.server:getPlayerAccountID( source )
		local groupID = exports.server:getPlayerGroupID( source )
		exports.DENmysql:exec( "UPDATE groups_members SET grouprank=? WHERE membername=?", "Group founder", accountName )
		exports.DENmysql:exec( "UPDATE groups_members SET grouprank=? WHERE memberid=?", "Group leader", playerID )
		exports.DENmysql:exec( "UPDATE groups SET groupleader=? WHERE groupid=?", groupID, accountName )
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." gave the leadership of the group to "..accountName )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,getPlayerName(source).." gave leadership of the group to "..accountName)
		if ( thePlayer ) then
			setElementData( thePlayer, "GroupRank", "Group founder" )
			triggerClientEvent( thePlayer, "onClientHideGroupsWindow", source )
		end
		setElementData( source, "GroupRank", "Group leader" )
		triggerClientEvent( source, "onClientHideGroupsWindow", source )
	end
)

-- Promote member
addEvent( "onServerPromoteMember", true )
addEventHandler( "onServerPromoteMember", root,
	function ( thePlayer, accountName, newRank, theRow )
		exports.DENmysql:exec( "UPDATE groups_members SET grouprank=? WHERE membername=?", newRank, accountName )
		for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do triggerClientEvent( thePlayer, "onClientUpdateRankRow", thePlayer, theRow, newRank ) end
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." promoted " .. accountName .. " to "..newRank )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",groupID,getPlayerName(source).." promoted "..accountName.." to "..newRank,getRealTime().timestamp)

		if ( thePlayer ) then
			setElementData( thePlayer, "groupRank", newRank )
		end
	end
)

-- Demote member
addEvent( "onServerDemoteMember", true )
addEventHandler( "onServerDemoteMember", root,
	function ( thePlayer, accountName, newRank, theRow )
		exports.DENmysql:exec( "UPDATE groups_members SET grouprank=? WHERE membername=?", newRank, accountName )
		for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do triggerClientEvent( thePlayer, "onClientUpdateRankRow", thePlayer, theRow, newRank ) end
		exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." demoted " .. accountName .. " to "..newRank )
		exports.DENmysql:exec("INSERT INTO groups_logs (groupid,log,date) VALUES (?,?,?)",getElementData(thePlayer,"GroupID"),getPlayerName(source).." demoted "..accountName.." to "..newRank,getRealTime().timestamp)

		if ( thePlayer ) then
			setElementData( thePlayer, "groupRank", newRank )
		end
	end
)

-- Delete group
addEvent( "onServerDeleteGroup", true )
addEventHandler( "onServerDeleteGroup", root,
	function ( username, password )
		local accountCheck = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", username, sha512( password ) )
		local groupID = exports.server:getPlayerGroupID( source )
		if ( accountCheck ) and ( groupID ) then

			exports.DENmysql:exec( "DELETE FROM groups_members WHERE groupid=?", groupID )
			exports.DENmysql:exec( "DELETE FROM groups_invites WHERE groupid=?", groupID )
			exports.DENmysql:exec( "DELETE FROM groups WHERE groupid=?", groupID )

			exports.DENchatsystem:outPutGroupMessageByPlayer( source, getPlayerName( source ).." deleted the group!" )
			exports.DENmysql:exec("DELETE FROM groups_logs WHERE groupid=?",groupID) --remove all the logs, prevents more database memory.

			for k, thePlayer in ipairs ( getGroupPlayers ( getElementData( source, "Group" ) ) ) do
				setElementData( thePlayer, "groupRank", false )
				setElementData( thePlayer, "Group", false )
				setElementData( thePlayer, "groupID", false )
				setElementData( thePlayer, "alliance",false)
				setElementData(thePlayer,"aName",false)
				triggerClientEvent( thePlayer, "onClientFinishGroupCreate", thePlayer )
			end
			if allianceGroups[groupID] then
				alliance_kickGroup(allianceGroups[groupID],groupID,true,source)
				allianceGroups[groupID] = nil
			end
			for id,allianceInfo in pairs(alliances) do
				alliances_removeInvite(id,groupID, true, "")
			end
		else
			exports.DENdxmsg:createNewDxMessage( source, "The password doesn't match with the username from the groupleader!", 225, 0, 0 )
		end
	end
)


-- When the player quit save the last online time
addEventHandler( "onPlayerQuit", root,
	function ()
		local playerID = exports.server:getPlayerAccountID( source )
		exports.DENmysql:exec( "UPDATE groups_members SET lastonline=? WHERE memberid=?", getRealTime().timestamp, playerID )
	end
)

function getGroupMembers(groupID)
end

-- Alliances
local allianceSettings = {["shareGates"] = "true",["shareSpawners"] = "true",["shareArmor"] = "false",["forceBlips"]="true",["canDefend"]="true",["splitMoney"]="true",["turfAsAlliance"]="true"}

function getAlliancePlayers ( allianceID, groupID )
	if alliances[allianceID] then
		local theTable = {}
		local groups = {}
		for i=1,#alliances[allianceID].groups do
			groups[alliances[allianceID].groups[i]] = true
		end
		local players = getElementsByType ( "player" )
		for i=1,#players do
			if ( groups[getElementData( players[i], "GroupID" )] ) and ( not groupID or getElementData( players[i], "GroupID" ) == groupID ) then
				table.insert( theTable, players[i] )
			end
		end
		return theTable
	end
	return false
end

addEventHandler("onResourceStart",resourceRoot,
	function ()
		if fileExists("alliancesInfo.xml") then
			alliancesFile = xmlLoadFile("alliancesInfo.xml")
		else
			alliancesFile = xmlCreateFile("alliancesInfo.xml","alliances")
		end
		local alliancesInfo = xmlNodeGetChildren(alliancesFile)
		for i=1,#alliancesInfo do
			local allianceNode = alliancesInfo[i]
			makeAllianceEntryForNode(allianceNode)
		end
		for id,alliance in pairs(alliances) do
			if #alliance.groups >= 1 then
				local playersInAlliance = getAlliancePlayers ( id )
				for i=1,#playersInAlliance do
					setElementData(playersInAlliance[i],"alliance",id)
					setElementData(playersInAlliance[i],"aName",alliance.name)
				end
			end
		end
	end
)

function makeAllianceEntryForNode(node)

	if node then

		local allianceInfo = {}

		allianceInfo.node = node
		local allianceNode = node

		allianceInfo.ID = tonumber(xmlNodeGetValue(allianceNode))
		allianceInfo.founderGroup = tonumber(xmlNodeGetAttribute(allianceNode,"founder"))
		allianceInfo.groups = fromJSON(xmlNodeGetAttribute(allianceNode,"groups"))
		local allianceMemberCount = 0
			for i=1,#allianceInfo.groups do
				allianceGroups[tonumber(allianceInfo.groups[i])] = allianceInfo.ID
				local groupMembers = exports.DENmysql:query( "SELECT * FROM groups_members WHERE groupid=? LIMIT 80", tonumber(allianceInfo.groups[i]) )
				allianceMemberCount = allianceMemberCount + ( #groupMembers or 0 )
			end
		allianceInfo.memberCount = allianceMemberCount
		allianceInfo.name = xmlNodeGetAttribute(allianceNode,"name")
		allianceInfo.dateCreated = xmlNodeGetAttribute(allianceNode,"dateCreated")
		allianceInfo.dateLastJoin = xmlNodeGetAttribute(allianceNode,"dateOfLastJoin")
		allianceInfo.info = xmlNodeGetAttribute(allianceNode,"info")
		allianceInfo.invites = fromJSON(xmlNodeGetAttribute(allianceNode,"invites"))
		allianceInfo.rgb = xmlNodeGetAttribute(allianceNode,"rgb")
		allianceInfo.balance = tonumber(xmlNodeGetAttribute(allianceNode,"balance"))
		allianceInfo.transactions = fromJSON(xmlNodeGetAttribute(allianceNode,"transactions"))
			for setting,_ in pairs(allianceSettings) do
				allianceInfo[setting] = xmlNodeGetAttribute(allianceNode,setting) == "true"
			end
		alliances[allianceInfo.ID] = allianceInfo

	end

end


addEvent( "requestAllianceData", true )
addEventHandler( "requestAllianceData", root,
	function ()
		local groupID = exports.server:getPlayerGroupID( source )
		local playerAllianceID

		if allianceGroups[groupID] then playerAllianceID = allianceGroups[groupID] end

		triggerClientEvent(source,"onRequestAllianceDataCallBack",source,alliances,playerAllianceID,allianceSettings)
	end
)

function getAllianceColor(id)
	if (alliances[id]) and (alliances[id].rgb) then
		return alliances[id].rgb
	else
		return toJSON({math.random(255),math.random(255),math.random(255)})
	end
end

function getCurrentTimeFormatted()

	local theTime = getRealTime()
	for key,value in pairs(theTime) do
		if value < 10 then theTime[key] = "0"..value end
	end
	return (theTime.year+1900).."-"..theTime.month.."-"..theTime.monthday.." "..theTime.hour..":"..theTime.minute..":"..theTime.second

end

addEvent("alliances_createNewAlliance",true )
addEventHandler("alliances_createNewAlliance",root,
	function (allianceName)
		local latestID = tonumber(exports.DENmysql:query( "SELECT * FROM serverstats WHERE name=? LIMIT 1", "allianceCountTicker" )[1].value)
		for ID,alliance in pairs(alliances) do
			if string.lower(allianceName) == string.lower(alliance.name) then
				exports.dendxmsg:createNewDxMessage(source,"Alliance name already in use!",255,0,0)
				return false
			end
			--newID = ID+1
		end
		local newID = latestID+1
		exports.DENmysql:exec('UPDATE serverstats SET value=? WHERE name=?',tostring(newID),"allianceCountTicker")
		if newID then
			local newNode = xmlCreateChild(alliancesFile,"alliance")
			xmlNodeSetValue(newNode,tostring(newID))
			xmlNodeSetAttribute(newNode,"founder",exports.server:getPlayerGroupID(source))
			xmlNodeSetAttribute(newNode,"groups",toJSON({exports.server:getPlayerGroupID(source)}))
			xmlNodeSetAttribute(newNode,"name",allianceName)

			xmlNodeSetAttribute(newNode,"dateCreated",getCurrentTimeFormatted())
			xmlNodeSetAttribute(newNode,"dateOfLastJoin",getCurrentTimeFormatted())
			xmlNodeSetAttribute(newNode,"info","")
			xmlNodeSetAttribute(newNode,"invites",toJSON({}))
			xmlNodeSetAttribute(newNode,"transactions",toJSON({}))
			xmlNodeSetAttribute(newNode,"balance",0)
			xmlNodeSetAttribute(newNode,"rgb",toJSON({255,0,0}))

			for setting,standardValue in pairs(allianceSettings) do
				xmlNodeSetAttribute(newNode,setting,standardValue)
			end
			local playerGroup = exports.server:getPlayerGroupID(source)
			xmlSaveFile(alliancesFile)
			makeAllianceEntryForNode(newNode)
			exports.dendxmsg:createNewDxMessage(source,"Alliance '"..allianceName.."' created!",0,255,0)
			allianceGroups[playerGroup] = newID
			triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,newID,nil,alliances[newID],newID)
			local players = getAlliancePlayers ( newID, playerGroup )
			for i=1,#players do
				setElementData(players[i],"alliance",newID)
				setElementData(players[i],"aName",allianceName)
			end
		end
	end
)

addEvent("alliances_inviteGroup",true)
addEventHandler("alliances_inviteGroup",root,
	function (allianceID,groupID)
		local invites = alliances[allianceID].invites
		for i=1,#invites do
			if groupID == invites[i][1] then
				exports.dendxmsg:createNewDxMessage(source,"Group already invited!",255,0,0)
				return false
			end
		end
		table.insert(alliances[allianceID].invites,{groupID,exports.server:getPlayerGroupID(source)})
		xmlNodeSetAttribute(alliances[allianceID].node,"invites",toJSON(invites))
		xmlSaveFile(alliancesFile)
		exports.dendxmsg:createNewDxMessage(source,"Group successfully invited!",0,255,0)
		triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'invites',alliances[allianceID].invites)
	end
)

addEvent("alliances_kickGroup",true)
function alliance_kickGroup(allianceID,groupID,silent,player)
	local groups = alliances[allianceID].groups
	local found
	for i=1,#groups do
		if groupID == groups[i] then
			table.remove(groups,i)
			found = true
			break
		end
	end
	if #groups <= 0 then
		deleteAlliance(allianceID,true,source or player)
		if not silent then
			exports.dendxmsg:createNewDxMessage(source or player,"Alliance '"..(alliances[alliance].name).."' deleted because you kicked the only group left!",255,255,0)
		end
	elseif found then
		xmlNodeSetAttribute(alliances[allianceID].node,"groups",toJSON(groups))
		xmlSaveFile(alliancesFile)
		alliances[allianceID].groups = groups
		if not silent then
			exports.dendxmsg:createNewDxMessage(source or player,"Group has been kicked!",0,255,0)
		end
		allianceGroups[groupID] = nil
		triggerClientEvent(source or player,'alliances_client_updateAllianceInfo',source or player,allianceID,'groups',alliances[allianceID].groups)
		local players = getAlliancePlayers ( allianceID, groupID )
		for i=1,#players do
			setElementData(players[i],"alliance",false)
			setElementData(players[i],"aName",false)
		end
	else
		if not silent then
			exports.dendxmsg:createNewDxMessage(source or player,"Group not found!",255,0,0)
		end
	end
end
addEventHandler("alliances_kickGroup",root,alliance_kickGroup)

addEvent("alliances_leaveAlliance",true)
addEventHandler("alliances_leaveAlliance",root,
	function (allianceID)
		if not alliances[allianceID] then return false end
		local playerGroup = exports.server:getPlayerGroupID(source)
		if playerGroup then
			local groupsInAlliance = alliances[allianceID].groups
			local newGroups = {}
			for i=1,#groupsInAlliance do
				if groupsInAlliance[i] ~= playerGroup then
					table.insert(newGroups,groupsInAlliance[i])
				end
			end
			if #newGroups < 1 then
				exports.dendxmsg:createNewDxMessage(source,"Alliance '"..(alliances[allianceID].name).."' deleted because you were the only group left!",255,255,0)
				deleteAlliance(allianceID,true,source)
			else
				alliances[allianceID].groups = newGroups
				xmlNodeSetAttribute(alliances[allianceID].node,"groups",toJSON(newGroups))
				xmlSaveFile(alliancesFile)
				exports.dendxmsg:createNewDxMessage(source,"Your group is no longer part of '"..(alliances[allianceID].name).."'!",200,125,0)
				allianceGroups[playerGroup] = nil
				triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'groups',alliances[allianceID].groups)
				local players = getAlliancePlayers ( allianceID, playerGroup )
				for i=1,#players do
					setElementData(players[i],"alliance",false)
					setElementData(players[i],"aName",false)
				end
			end
		end
	end
)
addEvent("alliances_deleteAlliance",true)
function deleteAlliance(alliance,silent,player)
	local players = getAlliancePlayers ( alliance )
	for i=1,#players do
		setElementData(players[i],"alliance",false)
		setElementData(players[i],"aName",false)
	end
	xmlDestroyNode(alliances[alliance].node)
	for i=1,#alliances[alliance].groups do
		allianceGroups[alliances[alliance].groups[i]] = nil
	end
	alliances[alliance] = nil
	xmlSaveFile(alliancesFile)
	if not silent then
		exports.dendxmsg:createNewDxMessage(source,"Group successfully deleted!",0,255,0)
	end
	triggerClientEvent(source or player,'alliances_client_updateAllianceInfo',source or player,alliance,nil,nil)-- remove entry at client
end
addEventHandler("alliances_deleteAlliance",root,
	function (allianceID,username,pass)
		local accountCheck = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", username, sha512( pass ) )
		if ( accountCheck ) then
			if allianceID then
				deleteAlliance(allianceID,false,source)
			end
		else
			exports.dendxmsg:createNewDxMessage(source,"Password incorrect!",255,0,0)
		end
	end
)

addEvent("alliances_setNewFounder",true)
addEventHandler("alliances_setNewFounder",root,
	function (allianceID,newFounderGroupID,username,pass)
		local accountCheck = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", username, sha512( pass ) )
		if ( accountCheck ) then
			if allianceID and newFounderGroupID then
				alliances[allianceID].founderGroup = newFounderGroupID
				xmlNodeSetAttribute((alliances[allianceID] or {}).node,"founder",tostring(newFounderGroupID))
				xmlSaveFile(alliancesFile)
				exports.dendxmsg:createNewDxMessage(source,"Alliance founder succesfully changed!",0,255,0)
				triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'founderGroup',newFounderGroupID)
			end
		else
			exports.dendxmsg:createNewDxMessage(source,"Password incorrect!",255,0,0)
		end
	end
)

addEvent("alliances_updateInfo",true)
addEventHandler("alliances_updateInfo",root,
	function (allianceID,newText)
		(alliances[allianceID] or {}).info = newText
		xmlNodeSetAttribute((alliances[allianceID] or {}).node,"info",newText)
		xmlSaveFile(alliancesFile)
	end
)

addEvent("alliances_noteGroup",true)
addEventHandler("alliances_noteGroup",root,
	function (groups,message)
		if type(groups) ~= "table" then groups = {groups} end
		local sourceGroupName = exports.server:getPlayerGroupName(source)
		local message = "[ALLIANCE NOTE] ("..sourceGroupName..") " .. getPlayerName( source ) .. ": "..message
		for i=1,#groups do
			exports.denchatsystem:outPutGroupMessage (groups[i], message,200,125,0)
		end
		exports.dendxmsg:createNewDxMessage(source,"Note successfully sent!",0,255,0)
	end
)

addEvent("alliances_acceptInvite",true)
addEventHandler("alliances_acceptInvite",root,
	function (allianceID,groupID)
		local inAlliance
		if alliances[allianceID] and groupID then
			for i=1,#alliances[allianceID].groups do
				if alliances[allianceID].groups[i] == groupID then
					inAlliance = true
					break
				end
			end
			if not inAlliance then
				table.insert(alliances[allianceID].groups,groupID)
				local theTime = getCurrentTimeFormatted()
				xmlNodeSetAttribute(alliances[allianceID].node,"groups",toJSON(alliances[allianceID].groups))
				xmlNodeSetAttribute(alliances[allianceID].node,"dateOfLastJoin",theTime)
				xmlSaveFile(alliancesFile)
				inAlliance = true
			end
			if inAlliance then
				triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'groups',alliances[allianceID].groups,allianceID)
				allianceGroups[groupID] = allianceID
				alliances_removeInvite(allianceID,groupID, true)
				local players = getAlliancePlayers ( allianceID, groupID )
				for i=1,#players do
					setElementData(players[i],"alliance",allianceID)
					setElementData(players[i],"aName",alliances[allianceID].name)
					exports.dendxmsg:createNewDxMessage(players[i],"Your group is now part of '"..(alliances[allianceID].name).."'!",0,255,0)
				end
			end
		end
	end
)

addEvent("alliances_removeInvite",true)
function alliances_removeInvite(allianceID,groupID, silent, msg)
	if alliances[allianceID] and groupID then
		for i=1,#alliances[allianceID].invites do
			if alliances[allianceID].invites[i][1] == groupID then
				table.remove(alliances[allianceID].invites,i)
				xmlNodeSetAttribute(alliances[allianceID].node,"invites",toJSON(alliances[allianceID].invites))
				xmlSaveFile(alliancesFile)
				if not silent then
					exports.dendxmsg:createNewDxMessage(source,msg,0,255,0)
				end
				if source then
					triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'invites',alliances[allianceID].invites)
				end
				return true
			end
		end
		if not silent then
			exports.dendxmsg:createNewDxMessage(source,"Invitation not found!",255,0,0)
			if source then
				triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,'invites',alliances[allianceID].invites)
			end
		end
	end
end
addEventHandler("alliances_removeInvite",root,alliances_removeInvite)

addEvent("CSGalliance.newcolor",true)
addEventHandler("CSGalliance.newcolor",root,function(alliance,r,g,b)
	xmlNodeSetAttribute(alliances[alliance].node,"rgb",tostring(toJSON{r,g,b}))
	alliances[alliance].rgb=toJSON{r,g,b}
	for k,v in pairs(getAlliancePlayers(alliance)) do
		exports.dendxmsg:createNewDxMessage(v,""..getPlayerName(source).." updated the alliance turf colors to this color",r,g,b)
	end
	triggerEvent("onAllianceChangeColor",getRandomPlayer(),getElementData(source,"aName"),r,g,b)
end)

addEvent("alliances_bank",true)
addEventHandler("alliances_bank",root,
	function (allianceID, transaction, amount)
		local currentBalance = alliances[allianceID].balance
		if currentBalance then
			local groupID = exports.server:getPlayerGroupID(source)
			local newBalance = currentBalance
			if transaction == "deposit" then
				newBalance = newBalance + amount
				exports.CSGaccounts:removePlayerMoney ( source, amount )
				transaction = "deposited"
			else
				if currentBalance-amount >= 0 then
					newBalance = newBalance - amount
					exports.CSGaccounts:addPlayerMoney ( source, amount )
					transaction = "withdrawn"
				else
					exports.dendxmsg:createNewDxMessage(source,"Not enough money in the bank!",255,0,0)
					return false
				end
			end
			local transactionEntry = {groupID,amount,transaction}
			alliances[allianceID].balance = newBalance
			table.insert(alliances[allianceID].transactions,transactionEntry)
			xmlNodeSetAttribute(alliances[allianceID].node,"balance",tostring(newBalance))
			xmlNodeSetAttribute(alliances[allianceID].node,"transactions",toJSON(alliances[allianceID].transactions))
			xmlSaveFile(alliancesFile)
			exports.dendxmsg:createNewDxMessage(source,"Transaction succesfully made!",0,255,0)
			triggerClientEvent(source,'alliances_client_updateAllianceInfo',source,allianceID,nil,alliances[allianceID])
		end
	end
)

addEvent("alliances_settingsAdjusted",true)
addEventHandler("alliances_settingsAdjusted",root,
	function (allianceID,newSettings)
		if alliances[allianceID] then
			for setting,value in pairs(newSettings) do
				alliances[allianceID][setting] = value == true
				xmlNodeSetAttribute(alliances[allianceID].node,setting,tostring(value == true))
				for k,v in pairs(getAlliancePlayers(allianceID)) do
					if setting == "turfAsAlliance" then
						setElementData(v,"ta",value)
					end
					exports.DENdxmsg:createNewDxMessage(v,""..getPlayerName(source).." has changed alliance setting: "..setting..": "..tostring(value).." - F6 to Refresh",0,255,0)
				end
			end
		end
	end
)



function alliances_saveAndUnloadXML()
	xmlSaveFile(alliancesFile)
	xmlUnloadFile(alliancesFile)
end

addEventHandler("onResourceStop",resourceRoot,alliances_saveAndUnloadXML)

-- alliance chat

function alliances_getGroupAlliance(groupID)
	return allianceGroups[groupID]
end

function alliances_getAllianceIDByName(name)
	for id,alliance in pairs(alliances) do
		if alliance.name == name then
			return id
		end
	end
end

function alliances_getAllianceName(allianceID)
	if alliances[allianceID] then
		return alliances[allianceID].name
	else
		error("Alliance not found",2)
	end
end
addEvent("alliances_getAllianceSettings",true)
function alliances_getAllianceSettings(allianceID)
	if alliances[allianceID] then
		local settings = {}
		for setting,_ in pairs(allianceSettings) do
			settings[setting] = alliances[allianceID][setting]
		end
		if eventName and isElement(client) then -- was triggered by client event
			triggerClientEvent(client,"alliances_receiveAllianceSettings",source,settings)
		end
		return settings
	else
		error("Alliance not found",2)
	end
end
addEventHandler("alliances_getAllianceSettings",root,alliances_getAllianceSettings)

addEventHandler("onPlayerLogin",root,
	function ()
		local playerGroup = getElementData(source,"GroupID")
		if playerGroup then
			if allianceGroups[playerGroup] then
				setElementData(source,"alliance",alliances[allianceGroups[playerGroup]].ID)
				setElementData(source,"aName",alliances[allianceGroups[playerGroup]].name)
				setElementData(source,"ta",alliances_getAllianceSettings(alliances[allianceGroups[playerGroup]].ID).turfAsAlliance)
			end
		end
	end
)
