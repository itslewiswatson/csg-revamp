-- Tables
local weaponStringTable = {}
local playerWeaponTable = {}

-- When the player login
addEvent("onServerPlayerLogin")
addEventHandler("onServerPlayerLogin", root,
	function (userID)
		dbQuery(recCB, {source}, exports.DENmysql:getConnection(), "SELECT * FROM `weapons` WHERE `userid`=?", userID)
		dbQuery(recCB, {source}, exports.DENmysql:getConnection(), "SELECT * FROM `accounts` WHERE `id`=?", userID)
		dbQuery(recCBwep, {source}, exports.DENmysql:getConnection(), "SELECT * FROM `accounts` WHERE `id`=?", userID)
	end
)

function recCB(qh, source)
	if isElement(source) then else return end
	local weaponTable = dbPoll(qh, 0)
	if (weaponTable) then
		weaponTable = weaponTable[1]
		playerWeaponTable[source] = weaponTable
	end

end

function recCBwep(qh,source)
	if isElement(source) then else return end
	local weaponTable = dbPoll(qh, 0)
 	if weaponTable[1] ~= nil then
		local t = fromJSON(weaponTable[1].weapons)

		for k, v in pairs(t) do
			if k == 35 and v > 0 then
				giveWeapon(source, k, v)
			end
		end
	end
end

function recCB2(qh,source)
	if isElement(source) then else return end
	local weaponTable = dbPoll(qh,0)
	if(weaponTable) then
		weaponTable=weaponTable[1]
		weaponStringTable[ source ] = weaponTable["weapons"]
	end
end

-- Function that checks if the player owns this weapons
function doesPlayerHaveWeapon(thePlayer, theWeapon)
	if (playerWeaponTable[thePlayer]) and(playerWeaponTable[ thePlayer][tonumber(theWeapon)]) then
		if (playerWeaponTable[thePlayer][tonumber(theWeapon)] == 1) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Function that gives the player the weapon
function setPlayerOwnedWeapon(thePlayer, theWeapon, theState)
	if (theState) then theState = 1 else theState = 0 end
	if not (thePlayer) or not (theWeapon) then return false end
	
	if (playerWeaponTable[thePlayer]) and (playerWeaponTable[thePlayer][tonumber(theWeapon)]) then
		if (exports.server:exec("UPDATE `weapons` SET `??`=? WHERE `userid`=?", tonumber(theWeapon), theState, expors.server:getPlayerAccountID(thePlayer))) then
			playerWeaponTable[thePlayer][tonumber(theWeapon)] = theState
			return true
		else
			return false
		end
	else
		return exports.server:exec("UPDATE `weapons` SET `??`=? WHERE `userid`=?", tonumber(theWeapon), theState, exports.server:getPlayerAccountID(thePlayer))
	end
end

-- Function to give player money
function addPlayerMoney(thePlayer, theMoney)
	if (givePlayerMoney(thePlayer, tonumber(theMoney))) and (exports.server:getPlayerAccountID(thePlayer)) then
		exports.DENmysql:exec("UPDATE `accounts` SET `money`=? WHERE `id`=?", (tonumber(theMoney) + getPlayerMoney(thePlayer)), exports.server:getPlayerAccountID(thePlayer))
		return true
	else
		return false
	end
end

-- Function to remove player money
function removePlayerMoney(thePlayer, theMoney)
	if (takePlayerMoney(thePlayer, tonumber(theMoney))) and (exports.server:getPlayerAccountID(thePlayer)) then
		exports.DENmysql:exec("UPDATE `accounts` SET `money`=? WHERE `id`=?", (tonumber(theMoney) + getPlayerMoney(thePlayer)), exports.server:getPlayerAccountID(thePlayer))
		return true
	else
		return false
	end
end

-- Event that changes the element model in the database
addEventHandler("onElementModelChange", root,
	function (oldModel, newModel)
		if (getElementType(source) == "player") and (exports.server:getPlayerAccountID(source)) and (getPlayerTeam(source)) then
			if (getTeamName(getPlayerTeam(source))  == "Criminals") or (getTeamName(getPlayerTeam(source))  == "Unemployed") or (getTeamName(getPlayerTeam(source))  == "Unoccupied") then
				exports.DENmysql:exec("UPDATE `accounts` SET `skin`=? WHERE `id`=?", newModel, exports.server:getPlayerAccountID(thePlayer))
			else
				exports.DENmysql:exec("UPDATE `accounts` SET `jobskin`=? WHERE `id`=?", newModel, exports.server:getPlayerAccountID(thePlayer))
			end
		end
	end
)

-- Function that get the correct weapon string of the player
function getPlayerWeaponString(thePlayer)
	return weaponStringTable[thePlayer]
end

-- Event that syncs the correct weapon string with the server
addEvent("syncPlayerWeaponString", true)
addEventHandler("syncPlayerWeaponString", root,
	function (theString, allow)
		if (allow) then
			if isPedDead(source) == true then
				local t = fromJSON(theString)
				if #t == 0 then return end
			end

			weaponStringTable[source] = theString
			exports.DENmysql:exec("UPDATE `accounts` SET `weapons`=? WHERE `id`=?", theString, exports.server:getPlayerAccountID(source))
		elseif isPedDead(source) == true then
			return
		else
			weaponStringTable[source] = theString
			exports.DENmysql:exec("UPDATE `accounts` SET `weapons`=? WHERE `id`=?", theString, exports.server:getPlayerAccountID(source))
		end
	end
)

addEventHandler("onPlayerLogin", root,
	function ()
		triggerClientEvent(source, "startSaveWep", source)
	end
)

-- Function that saves the important playerdata
function savePlayerData(thePlayer)
	if (exports.server:getPlayerAccountID(thePlayer)) and (getElementData(thePlayer, "joinTick")) and (getTickCount() - getElementData(thePlayer, "joinTick") > 5000) then
		if (isPedDead(thePlayer)) then
			playerArmor = 0
		else
			playerArmor = getPedArmor(thePlayer)
		end

		local playerMoney = getPlayerMoney(thePlayer)
		local playerHealth = getElementHealth(thePlayer)
		local playerWP = getElementData(thePlayer, "wantedPoints") or 0
		local pX, pY, pZ = getElementPosition(thePlayer)
		local playerInterior = getElementInterior(thePlayer)
		local playerDimension = getElementDimension(thePlayer)
		local playerRotation = getPedRotation(thePlayer)
		local playerOccupation = exports.server:getPlayerOccupation(thePlayer)
		local playerTeam = getTeamName(getPlayerTeam(thePlayer))
		local playerPlayTime = getElementData(thePlayer, "playTime")
		local playerAccountID = exports.server:getPlayerAccountID(thePlayer)

		exports.DENmysql:exec("UPDATE `accounts` SET `money`=?, `health`=?, `armor`=?, `wanted`=?, `x`=?, `y`=?, `z`=?, `interior`=?, `dimension`=?, `rotation`=?, `occupation`=?, `team`=?, `playtime`=? WHERE `id`=?",
			playerMoney,
			playerHealth,
			playerArmor,
			playerWP,
			pX,
			pY,
			pZ,
			playerInterior,
			playerDimension,
			playerRotation,
			playerOccupation,
			playerTeam,
			playerPlayTime,
			playerAccountID,
		)
		return true
	else
		return false
	end
end

-- Triggers that should save playerdata
function doSaveData()
	if (exports.server:isAllowedToSave(source) == true) then
		savePlayerData(source)
	end
end

function quit()
	savePlayerData(source)
	playerWeaponTable[source] = nil
	weaponStringTable[source] = nil
end
addEventHandler("onPlayerQuit", root, quit)
addEventHandler("onPlayerWasted", root, doSaveData)
addEventHandler("onPlayerLogout", root, doSaveData)

function getPlayerSkin(p)
	local t = exports.DENmysql:query("SELECT * FROM `accounts` WHERE `username`=?", exports.server:getPlayerAccountName(p))
	return t[1].skin
end

setTimer(
	function()
		for k, v in pairs(getElementsByType("player")) do
			if exports.server:isPlayerLoggedIn(v) then
				local source=v
				local userid = exports.server:getPlayerAccountID(source)
				dbQuery(recCB, {source}, exports.DENmysql:getConnection(), "SELECT * FROM `weapons` WHERE `userid`=?", userID)
				dbQuery(recCB, {source}, exports.DENmysql:getConnection(), "SELECT * FROM `accounts` WHERE `id`=?", userID)
				dbQuery(recCBwep, {source}, exports.DENmysql:getConnection(), "SELECT * FROM `accounts` WHERE `id`=?", userID)
			end
		end
	end, 1000, 1
)

function forceWeaponSync(p)
	triggerClientEvent(p, "forceWepSync", p)
end
