db = exports.DENmysql:getConnection()
local statsTable = {}
local changed = {}
local checkSync = {
	["kills"] = false,
	["deaths"] = false,
	["turfsTaken"] = false,
	["moneyGotRobbed"] = false,
	["moneyRobbed"] = false,
	["moneyRobbedAsCon"] = false,
	["moneyRobbedAsPick"] = false,
	["moneyRobbedAsNormal"] = false,
	["radioTurfsTaken"] = false,
	["radioTurfsTakenAsCop"] = false,
	["radioTurfsTakenAsCrim"] = false,
	["walkstyle"] = false,
	["tazerassists"] = false,
	["armoredtrucks"] = false,
	["brcrlaw"] = false,
	["drugshipmentlaw"] = false,
	["brcrcrimfail"] = false,
	["brcrcrimsuccess"] = false,
	["drugshipmentcrim"] = false,
	["hijackcarscrim"] = false,
	["hijackcarslaw"] = false,
}

-- When a player login store the stat in the table
addEvent("onServerPlayerLogin")
addEventHandler("onServerPlayerLogin", root,
	function ()
		dbQuery(getDataCB, {source}, db, "SELECT * FROM `playerstats` WHERE `userid`=? LIMIT 1", exports.server:getPlayerAccountID(source))
	end
)

function getDataCB(qh, source)
	if (not isElement(source)) then return false end
	changed[source] = {}
	local userData = dbPoll(qh, 0)
	if (userData) then
		userData = userData[1]
		statsTable[source] = userData
		if userData == nil then return end
		for stat, value in pairs(userData) do
			changed[source][stat] = false
			if checkSync[stat] == nil or checkSync[stat] ~= false then
				for k, v in pairs(getElementsByType("player")) do
					--triggerClientEvent(v,"onSyncPlayerStats",v, statsTable[source], source)
					triggerClientEvent(v, "onSyncSpecific", v, stat, value, source)
				end
			end
		end
	end
end

-- Function to set a player stat
function getPlayerAccountData(plr, data)
	if (not plr) or (not data) then return false end
	if (not isElement(plr)) or (not exports.server:isPlayerLoggedIn(plr)) then return false end
	
	local userID = exports.server:getPlayerAccountID(plr)
	-- If the player is in the table
	if (statsTable[plr]) then
		if (data == "table") then
			return statsTable[plr]
		else
			return statsTable[plr][data]
		end
		
	-- The player isn't in the table
	else
		if (data == "table") then
			return exports.DENmysql:querySingle("SELECT * FROM `playerstats` WHERE `userid`=? LIMIT 1", userID) or nil
		else
			return exports.DENmysql:querySingle("SELECT `??` FROM `playerstats` WHERE `userid`=? LIMIT 1", data, userID)[data] or nil
		end
	end
end

-- Function that sets a player stat
function setPlayerAccountData(plr, data, value)
	-- Preliminary checks
 	if (not isElement(plr)) then return false end
	local userID = exports.server:getPlayerAccountID(plr)
	if (not userID) then return false end
	
	-- Change it in our table
	if (statsTable[plr]) then
		statsTable[plr][data] = value
		changed[plr][data] = true
	end
	
	-- This part here is an alternative to the silly 5 second infinite timer. This should
	-- Sync it to the database
	exports.DENmysql:exec("UPDATE `playerstats` SET `??`=? WHERE `userid`=?", data, value, userID)
	-- Callback and update the data
	dbQuery(getDataCB, {plr}, db, "SELECT * FROM `playerstats` WHERE `userid`=? LIMIT 1", userID)
	
	-- Since we're already syncing it in the callback function, this isn't needed. Keep it here anyway.
	--[[
	for k, v in pairs(getElementsByType("player")) do
		triggerClientEvent(v, "onSyncSpecific", v, data, value, plr)
		--triggerClientEvent(v, "onSyncPlayerStats", v, statsTable[plr], plr)
	end
	--]]
	return true
end

-- Function that creates a column
function createAccountDataRow(aColumn, aType)
	if (column) and (aType) and (not exports.DENmysql:doesColumnExist(aTable, column)) then
		exports.DENmysql:exec("ALTER TABLE `playerstats` ADD `??` ??", aColumn, aType)
	else
		return false
	end
	return true
end

-- No wonder CSG was so laggy and had about 7000 SQL queries every 5 minutes
-- As far as I see this, it's useless as the data is already cached in a table
--[[
setTimer(
	function()
		for k, v in pairs(getElementsByType("player")) do
			if (exports.server:isPlayerLoggedIn(v)) then
				dbQuery(getDataCB, {v}, db, "SELECT * FROM `playerstats` WHERE `userid`=? LIMIT 1", exports.server:getPlayerAccountID(v))
			end
		end
	end, 5000, 1
)
--]]

addEventHandler("onPlayerQuit", root,
	function ()
		if statsTable[source] == nil then return end
		--[[
		for k, v in pairs(statsTable[source]) do
			if (changed[source][k]) then
				exports.DENmysql:exec("UPDATE `playerstats` SET "..k.."=? WHERE `userid`=?", v, userid)
			end
		end
		--]]
		statsTable[source] = nil
		changed[source] = nil
	end
)
