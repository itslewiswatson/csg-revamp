local db = exports.DENmysql:getConnection()
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
		dbQuery(getDataCB, {source}, db, "SELECT * FROM playerstats WHERE userid=? LIMIT 1", exports.server:getPlayerAccountID(source))
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
		for stat,value in pairs(userData) do
			changed[source][stat] = false
			if checkSync[stat] == nil or checkSync[stat] ~= false then
				for k,v in pairs(getElementsByType("player")) do
					--triggerClientEvent(v,"onSyncPlayerStats",v, statsTable[source], source)
					triggerClientEvent(v, "onSyncSpecific", v, stat, value, source)
				end
			end
		end
	end
end

-- Function to set a player stat
function getPlayerAccountData(pE, data)
	local userID = exports.server:getPlayerAccountID(pE)
	if isElement(pE) == true and type(tonumber(userID)) == "number" then
		if (statsTable[pE]) then
			if (data == 'table') then
				return statsTable[pE]
			else
				return statsTable[pE][data]
			end
		else
			if (data == 'table') then
				return exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=? LIMIT 1", userID)
			else
				local t=exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=? LIMIT 1", userID)
				local res = false
				if t == nil then return nil end
				if (t[data]~=nil) then res=t[data] end
				return res
			end
		end
	else
		return false
	end
end

-- Function that sets a player stat
function setPlayerAccountData (pE, data, value)
 	if isElement(pE) then
		local userID = exports.server:getPlayerAccountID(pE)
		--if (userID) and (exports.DENmysql:exec("UPDATE playerstats SET `??`=? WHERE userid=?", data, value, userID)) then
		if (userID) then
			--[[
			if data == "paramedic" then
				outputDebugString("SAVING    para "..value.."")
			end
			--]]
			if (statsTable[pE]) then
				statsTable[pE][data] = value
				changed[pE][data] = true 
			end
			for k, v in pairs(getElementsByType("player")) do
				triggerClientEvent(v, "onSyncSpecific", v, data, value, pE)
				--triggerClientEvent(v, "onSyncPlayerStats", v, statsTable[pE], pE)
			end
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Function that creates a column
function createAccountDataRow(aColumn, aType)
	if (column) and (aType) and (not exports.DENmysql:doesColumnExist(aTable, column)) then
		exports.DENmysql:exec("ALTER TABLE `playerstats` ADD `??` ??", aColumn, aType)
		return true
	else
		return false
	end
end

setTimer(
	function()
		for k, v in pairs(getElementsByType("player")) do
			if exports.server:isPlayerLoggedIn(v) == true then
				dbQuery(getDataCB, {v}, db, "SELECT * FROM `playerstats` WHERE `userid`=? LIMIT 1", exports.server:getPlayerAccountID(v))
			end
		end
	end, 5000, 1
)

addEventHandler("onPlayerQuit", root,
	function ()
		if statsTable[source] == nil then return end
		local userid = exports.server:getPlayerAccountID(source)
		for k,v in pairs(statsTable[source]) do
			if (changed[source][k]) then
				exports.DENmysql:exec("UPDATE `playerstats` SET "..k.."=? WHERE `userid`=?", v, userid)
			end
		end
		statsTable[source] = nil
		changed[source] = nil
	end
)
