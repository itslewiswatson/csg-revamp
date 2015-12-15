-- All the bans are here
local theBanTable = {}

-- On resource start get all the bans
addEventHandler( "onResourceStart", resourceRoot,
	function ()
		theBanTable = exports.DENmysql:query("SELECT * FROM `bans`")
	end
)

-- Get the complete ban table
function getServerBans ()
	if (theBanTable) then
		return theBanTable
	else
		return false
	end
end

-- On player ban
function onPlayerBanned(userAccount, banTime, theReason, thePlayer)
	local newTable = exports.DENmysql:query("SELECT * FROM `bans` WHERE `account`=? AND `banstamp`=? LIMIT 1", userAccount, banTime)
	if (newTable) then
		table.insert(theBanTable, newTable)
	else
		theBanTable = exports.DENmysql:query("SELECT * FROM `bans`")
	end
	if (thePlayer) then triggerEvent("onServerPlayerBan", thePlayer, userAccount, banTime, theReason) end
end

-- Ban a player
function banServerPlayer(theAdmin, thePlayer, theReason, theTime, theType )
	if (thePlayer) and (theReason) and (theTime) and (theType) then
		local userID = exports.server:getPlayerAccountID(thePlayer)
		local userAccount = exports.server:getPlayerAccountName(thePlayer)
		local timeHours = math.floor(theTime / 3600)
		if (theTime ~= 0) then banTime = (getRealTime().timestamp + theTime) else theTime = 0 end
		if (theType == "account") then
			exports.DENmysql:exec("INSERT into bans SET account=?, reason=?, banstamp=?, bannedby=?", userAccount, theReason, banTime, getPlayerName(theAdmin))
			exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial(thePlayer), getPlayerName(theAdmin).." account banned " .. getPlayerName(thePlayer) .. " for " .. timeHours .. " hours (" .. theReason .. ")")
			exports.CSGlogging:createAdminLogRow (theAdmin, getPlayerName(theAdmin).." account banned " .. getPlayerName(thePlayer) .. " for " .. timeHours .. " hours (" .. theReason .. ")")
			outputChatBox(getPlayerName(theAdmin).." account banned " .. getPlayerName(thePlayer) .. " for " .. timeHours .. " hours (" .. theReason .. ")", root, 255, 128, 0)
			onPlayerBanned(userAccount, banTime, theReason, thePlayer)
			kickPlayer(thePlayer, "You're banned from this server by: "..getPlayerName(theAdmin))
			return true
		elseif (theType == "serial") then
			exports.DENmysql:exec("INSERT into bans SET account=?, reason=?, banstamp=?, serial=?, bannedby=?", userAccount, theReason, banTime, getPlayerSerial(thePlayer), getPlayerName(theAdmin))
			exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial(thePlayer), getPlayerName(theAdmin).." serial banned " .. getPlayerName(thePlayer) .. " for " .. timeHours .. " hours (" .. theReason .. ")")
			exports.CSGlogging:createAdminLogRow (theAdmin, getPlayerName(theAdmin).." serial banned " .. getPlayerName(thePlayer) .. " for " .. timeHours .. " hours (" .. theReason .. ")")
			outputChatBox(getPlayerName(theAdmin).." serial banned " .. getPlayerName(thePlayer) .. " for " .. timeHours .. " hours (" .. theReason .. ")", root, 255, 128, 0)
			onPlayerBanned(userAccount, banTime, theReason, thePlayer)
			kickPlayer(thePlayer, "You're banned from this server by: "..getPlayerName(theAdmin).." "..theReason)
			return true
		end
	else
		return false
	end
end

-- Ban a account
function banServerAccount(theAccount, theTime, theReason, theAdmin)
	if (theAccount and theTime and theReason and theAdmin) then
		local timeHours = math.floor(theTime * 3600)
		local banTime = (getRealTime().timestamp + theTime)
		local accountTable = exports.DENmysql:query("SELECT * FROM `accounts` WHERE `username`=?", theAccount)
		if (not accountTable or #accountTable == 0) then
			-- We can't ban an account that doesn't exist
			return "This account does not exist ("..tostring(theAccount)..")"
		end
		local accountBans = exports.DENmysql:query("SELECT * FROM `bans` WHERE `account`=?", theAccount)
		if (accountBans and #accountBans >= 1) then
			return "This account is already banned"
		end
		--exports.DENmysql:exec("INSERT into bans SET account=?, reason=?, banstamp=?, bannedby=?", theAccount, theReason, banTime, getPlayerName(theAdmin))
		exports.DENmysql:exec("INSERT INTO `bans` SET `serial`=NULL, `account`=?, `reason`=?, `banstamp`=?, `bannedby`=?", theAccount, theReason, banTime, theAdmin.name)
		exports.DENmysql:exec("INSERT INTO `punishlog` SET `userid`=?, `serial`=?, `punishment`=?", accountTable[1].id, accountTable[1].serial, theAdmin.name.." account banned the account "..theAccount.." for "..timeHours.." hours (" .. theReason .. ")")
		exports.CSGlogging:createAdminLogRow(theAdmin, theAdmin.name.." banned the account " .. theAccount .. " for " .. timeHours .. " hours (" .. theReason .. ")")
		onPlayerBanned(theAccount, banTime, theReason, thePlayer)
		return true
	else
		return "Incorrect details specified"
	end
end

-- Ban a serial
function banServerSerial(theSerial, theTime, theReason, theAdmin)
	if (theSerial and theTime and theReason and theAdmin) then
		local timeHours = math.floor(theTime * (60 * 60))
		local banTime = (getRealTime().timestamp + theTime)
		local serialTable = exports.DENmysql:query("SELECT * FROM `bans` WHERE `serial`=?", theSerial)
		if (serialTable and #serialTable >= 1) then
			-- This serial is already banned
			outputChatBox("serial = "..tostring(theSerial))
			return "This serial is already banned"
		end
		exports.DENmysql:exec("INSERT INTO `bans` SET `account`=NULL, `reason`=?, `banstamp`=?, `serial`=?, `bannedby`=?", theReason, banTime, theSerial, theAdmin.name)
		exports.DENmysql:exec("INSERT INTO `punishlog` SET `serial`=?, `punishment`=?", theSerial, theAdmin.name.." banned the account "..theAccount.." for "..timeHours.." hours ("..theReason..")")
		exports.CSGlogging:createAdminLogRow (theAdmin, theAdmin.name.." banned the serial "..theSerial.." for "..timeHours.." hours (" .. theReason .. ")")
		onPlayerBanned(theSerial, banTime, theReason, thePlayer)
		return true
	else
		return "Incorrect details specified"
	end
end

-- Unban ban
function removeServerBan(banID)
	return exports.DENmysql:exec ("DELETE * FROM bans WHERE id=?", banID)
end
