local playerLoginsFile
local playerLoginsInfo = {}
-- retrieve stored info using JSON
if fileExists("Admin Panel\\lastLogins.json") then
	playerLoginsFile = fileOpen("Admin Panel\\lastLogins.json")
	local size = fileGetSize(playerLoginsFile) or 1
	local text = fileRead(playerLoginsFile,math.max(1,size))
	playerLoginsInfo = fromJSON(text) or {}
else
	playerLoginsFile = fileCreate("Admin Panel\\lastLogins.json")
	fileWrite(playerLoginsFile,toJSON({}))
	fileFlush(playerLoginsFile)
end

addEventHandler("onPlayerLogin",root,
	function (a,b)
		if a or b then return end
		local serial = getPlayerSerial(source)
		local playerName = getPlayerName(source)
		local accountName = exports.server:getPlayerAccountName(source)
		if playerLoginsInfo[serial] then
			local newInfo = {}
			local i = 1
			table.insert(playerLoginsInfo[serial],1,{accountName,playerName})
			for id,info in pairs(playerLoginsInfo[serial]) do
				table.insert(newInfo,info)
				if id >= 6 then
					break
				end
			end
			playerLoginsInfo[serial] = newInfo
		else
			playerLoginsInfo[serial] = {{accountName,playerName}}
		end
	end
)

addEventHandler("onResourceStop",resourceRoot,
	function ()
		playerLoginsFile = fileCreate("Admin Panel\\lastLogins.json")
		fileWrite(playerLoginsFile,toJSON(playerLoginsInfo))
		fileFlush(playerLoginsFile)
		fileClose(playerLoginsFile)
	end
)

-- Event to get player information
addEvent("onRequestAdminPlayerInfo", true)
addEventHandler("onRequestAdminPlayerInfo", root,
	function (thePlayer)
		if (exports.server:getPlayerPremiumHours(thePlayer)) then premiumHours = math.floor(exports.server:getPlayerPremiumHours(thePlayer) / 60) else premiumHours = "Not premium" end
		if (exports.server:getPlayerAccountEmail(thePlayer)) then playerEmail = exports.server:getPlayerAccountEmail(thePlayer) else playerEmail = "Not logged in" end
		if (exports.server:getPlayerAccountName(thePlayer)) then accountname = exports.server:getPlayerAccountName(thePlayer) else accountname = "Not logged in" end
		if (getElementData(thePlayer, "Play Time")) then playTime = getElementData(thePlayer, "Play Time") else playTime = "Not logged in" end
		if (getElementData(thePlayer, "Group")) then playerGroup = getElementData(thePlayer, "Group") else playerGroup = "Not in a group" end
		if (exports.server:getPlayerBankBalance(thePlayer)) then bBalance = exports.server:convertNumber(exports.server:getPlayerBankBalance(thePlayer)) end
		local playerLogins = playerLoginsInfo[getPlayerSerial(thePlayer)]
		local _, playerCountry = exports.CSGcountry:getPlayerCountry(thePlayer)
		local playerCashMoney = exports.CSGutil:convertNumber(getPlayerMoney(thePlayer))
		
		local theTable = {
			playerCashMoney or "N/A",
			bBalance or "N/A",
			premiumHours,
			playerGroup,
			playerEmail,
			playTime,
			accountname,
			getPlayerSerial(thePlayer) or "N/A",
			getPlayerIP(thePlayer) or "N/A",
			playerCountry or "N/A",
			getPlayerVersion(thePlayer) or "N/A",
			playerLogins,
		}
		
		triggerClientEvent(source, "onRequestAdminPlayerInfo:callBack", source, theTable)
	end
)

-- Event to get all the admins
addEvent("onRequestAdminTable", true)
addEventHandler("onRequestAdminTable", root,
	function ()
		triggerClientEvent(source, "onRequestAdminTable:callBack", source, getAllAdmins())
	end
)

addEvent("CSGstaff.removePunishRequest",true)
addEventHandler("CSGstaff.removePunishRequest",root,function(id,text)
	exports.DENmysql:query("UPDATE punishlog SET active=? WHERE punishment=? AND uniqueid=?",0,text,id)
end)

addEvent("CSGstaff.enablePunishRequest",true)
addEventHandler("CSGstaff.enablePunishRequest",root,function(id,text)
	exports.DENmysql:query("UPDATE punishlog SET active=? WHERE punishment=? AND uniqueid=?",1,text,id)
end)

-- Get bans
addEvent("onRequestBansTable", true)
addEventHandler("onRequestBansTable", root,
	function ()
		local globalbans = exports.denmysql:query("SELECT * FROM bans")
		exports.dendxmsg:createNewDxMessage(source,"Transfering data, this may take a while.",255,255,0)
		triggerLatentClientEvent(source, "onRequestBansTable:callBack", 20000, false, source, exports.CSGadmin:getServerBans(), globalbansTable or {})
	end
)

-- get Accounts

addEvent("onRequestAccountsTable", true)
addEventHandler("onRequestAccountsTable", root,
	function (userSearch,exactMatches)
		if not exactMatches then
			local userSearch = "%"..userSearch.."%"
			local accounts = exports.denmysql:query("SELECT username,id,money,email,team,occupation,score,playtime,premium FROM accounts WHERE username LIKE ?",userSearch)
			if not accounts then
				exports.dendxmsg:createNewDxMessage(source,"Something went wrong, please try again later.",255,0,0)
				return false;
			end
			if #accounts <= 25 then
				exports.dendxmsg:createNewDxMessage(source,#accounts.." hits found. Transfering data, this may take a while.",0,255,0)
				triggerLatentClientEvent(source,"onRequestAccountsTable:callBack", 15000, false, source, accounts)
			else
				exports.dendxmsg:createNewDxMessage(source,#accounts.." hits found. Please use a more specific search.",255,0,0)
			end
		else
			local accounts = exports.denmysql:query("SELECT username,id,money,email,team,occupation,score,playtime,premium FROM accounts WHERE username=?",userSearch)
			if #accounts >= 1 then
				exports.dendxmsg:createNewDxMessage(source,#accounts.." hit found. Transfering data.",0,255,0)
				triggerLatentClientEvent(source,"onRequestAccountsTable:callBack", 15000, false, source, accounts)
			else
				exports.dendxmsg:createNewDxMessage(source,#accounts.." hits found. No exact match found.",255,0,0)
			end
		end
	end
)

addEvent("onRequestAccountBalance",true)
addEventHandler("onRequestAccountBalance",root,
	function (accountID)
		local info = exports.DENmysql:query("SELECT balance FROM banking WHERE userid=? LIMIT 1",accountID);
		local balance
		if type(info[1]) == 'table' then
			balance = info[1]['balance'];
		end
		triggerClientEvent(source,"onRequestAccountBalance:callBack",source,accountID,balance or false);
	end
)

-- Get punishments
addEvent("onRequestPunishlog", true)
addEventHandler("onRequestPunishlog", root,
	function (thePlayer)
		local serial, account = exports.DENpunishments:getPlayerPunishlog (thePlayer, true)
		triggerClientEvent(source, "onRequestPunishlog:callBack", source, serial, account)
	end
)

-- Event for admin tab stuff
addEvent("onServerAdminChange", true)
addEventHandler("onServerAdminChange", root,
	function (rights, nickname)
		if (rights == "kick") then
			kickAdmin (nickname)
		elseif (rights == "demote") then
			demoteAdmin (nickname)
		elseif (rights == "promote") then
			promoteAdmin (nickname)
		elseif (rights == "developer") then
			setAdminDeveloper (nickname)
		elseif (rights == "eventmanager") then
			setAdminEventManager (nickname)
		elseif (rights == "inactive") then
			setAdminActive (nickname)
		end
		if (nickname) then
			setTimer (triggerClientEvent, 500, 1, "onRequestAdminTable:callBack", source, getAllAdmins())
			exports.DENdxmsg:createNewDxMessage(source, "Updating staff table... Please wait!", 0, 225, 0)
		end
	end
)

-- Event to create a punishment and admin log
function onAdminCreatePunishment (thePunished, theAdmin, theAction, serial)
	local playerID = exports.server:getPlayerAccountID(thePunished)
	if not (playerID) then return end
	if (serial) then
		exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, serial=?, punishment=?", tonumber(playerID), getPlayerSerial(thePunished), theAction)
	else
		exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, punishment=?", tonumber(playerID), theAction)
	end
	exports.CSGlogging:createAdminLogRow (theAdmin, theAction)
end

-- Event for admin player actions stuff
local theVehicles = {}

addEvent("onAdminPlayerActions", true)
addEventHandler("onAdminPlayerActions", root,
	function (thePlayer, action, arg3, arg4)
		if (action == "slap") and not (isPedDead(thePlayer)) then
			killPed(thePlayer)
			outputChatBox("You have been slapped by " .. getPlayerName(source) .. " (100HP)", thePlayer, 225, 0, 0)
			onAdminCreatePunishment (thePlayer, source, getPlayerName(source).." slapped " .. getPlayerName(thePlayer) .. " (100HP)", false)
		elseif (action == "freeze") then
			local vehicle = getPedOccupiedVehicle (thePlayer)
			if (isElementFrozen (thePlayer)) then
				outputChatBox("You have been unfrozen by " .. getPlayerName(source) .. "", thePlayer, 225, 0, 0)
			else
				outputChatBox("You have been frozen by " .. getPlayerName(source) .. "", thePlayer, 225, 0, 0)
				onAdminCreatePunishment (thePlayer, source, getPlayerName(source).." froze " .. getPlayerName(thePlayer) .. "", false)
			end
			if (vehicle) then if (isElementFrozen(vehicle)) then setElementFrozen (vehicle, false) else setElementFrozen (vehicle, true) end end
			if (isElementFrozen (thePlayer)) then setElementFrozen (thePlayer, false) else setElementFrozen (thePlayer, true) end
		elseif (action == "kick") then
			outputChatBox(getPlayerName(source).." kicked " .. getPlayerName(thePlayer) .. "", root, 225, 0, 0)
			onAdminCreatePunishment (thePlayer, source, getPlayerName(source).." kicked " .. getPlayerName(thePlayer) .. "", false)
			kickPlayer(thePlayer, "You have been kicked by "..getPlayerName(source))
		elseif (action == "reconnect") then
			outputChatBox(getPlayerName(source).." reconnected " .. getPlayerName(thePlayer) .. "", root, 225, 0, 0)
			onAdminCreatePunishment (thePlayer, source, getPlayerName(source).." reconnected " .. getPlayerName(thePlayer) .. "", false)
			redirectPlayer(thePlayer, "csgmta.net", 22003)
		elseif (action == "warp") then
			onAdminWarpPlayer (source, thePlayer)
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." warped to "..getPlayerName(thePlayer))
		elseif (action == "spectate") then
			if "sensei" == exports.server:getPlayerAccountName(source) then return end
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." started spectating  "..getPlayerName(thePlayer))
		elseif (action == "warpto") then
			onAdminWarpPlayer (thePlayer, arg3)
			outputChatBox(getPlayerName(source).." warped you to "..getPlayerName(arg3), thePlayer, 225, 0, 0)
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." warped " .. getPlayerName(thePlayer) .. " to "..getPlayerName(arg3))
		elseif (action == "fixvehicle") then
			local vehicle = getPedOccupiedVehicle (thePlayer)
			if (vehicle) then local rX, rY, rZ = getElementRotation(vehicle) setElementRotation(vehicle, 0, 0, (rX > 90 and rX < 270) and (rZ + 180) or rZ) fixVehicle(vehicle) outputChatBox(getPlayerName(source).." fixed your vehicle", thePlayer, 225, 0, 0) else exports.DENdxmsg:createNewDxMessage(source, "Player is not in a vehicle!", 0, 225, 0) end
			if (vehicle) then exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." repaired the vehicle from " .. getPlayerName(thePlayer) .. "") end
		elseif (action == "destroyvehicle") then
			local vehicle = getPedOccupiedVehicle (thePlayer)
			if (vehicle) and (getElementData(vehicle, "vehicleType") == "playerVehicle") then exports.DENdxmsg:createNewDxMessage(source, "Player owned vehicles cannot be destroyed yet!", 0, 225, 0) return end
			if (vehicle) then destroyElement(vehicle) outputChatBox(getPlayerName(source).." destroyed your vehicle", thePlayer, 225, 0, 0) else exports.DENdxmsg:createNewDxMessage(source, "Player is not in a vehicle!", 0, 225, 0) end
			if (vehicle) then exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." destroyed the vehicle from " .. getPlayerName(thePlayer) .. "") end
		elseif (action == "health") then
			setElementHealth(thePlayer, 200)
			outputChatBox(getPlayerName(source).." gave you full health", thePlayer, 225, 0, 0)
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." gave " .. getPlayerName(thePlayer) .. " full health")
		elseif (action == "armor") then
			setPedArmor(thePlayer, 100)
			outputChatBox(getPlayerName(source).." gave you full armor", thePlayer, 225, 0, 0)
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." gave " .. getPlayerName(thePlayer) .. " full armor")
		elseif (action == "jetpack") then
			if not (doesPedHaveJetPack(thePlayer)) then exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." gave " .. getPlayerName(thePlayer) .. " a jetpack") end
			if (doesPedHaveJetPack(thePlayer)) then removePedJetPack (thePlayer) outputChatBox(getPlayerName(source).." gave removed your jetpack", thePlayer, 225, 0, 0) else givePedJetPack (thePlayer) outputChatBox(getPlayerName(source).." gave you a jetpack", thePlayer, 225, 0, 0) end
		elseif (action == "premium") then
			if not (isPedInVehicle(thePlayer)) then exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." gave " .. getPlayerName(thePlayer) .. " a premium car") outputChatBox(getPlayerName(source).." gave you a premium car", thePlayer, 225, 0, 0) end
			givePremiumCar (thePlayer)
		elseif (action == "interior") then
			outputChatBox(getPlayerName(source).." moved you to interior "..arg3, thePlayer, 225, 0, 0)
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." moved " .. getPlayerName(thePlayer) .. " to interior "..arg3)
			setElementInterior (thePlayer, arg3, getElementPosition(thePlayer))
		elseif (action == "dimension") then
			outputChatBox(getPlayerName(source).." moved you to dimension "..arg3, thePlayer, 225, 0, 0)
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." moved " .. getPlayerName(thePlayer) .. " to dimension "..arg3)
			setElementDimension(thePlayer, arg3)
		elseif (action == "skin") then
			outputChatBox(getPlayerName(source).." changed your skin to model "..arg3, thePlayer, 225, 0, 0)
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." changed the skin from " .. getPlayerName(thePlayer) .. " to "..arg3)
			setElementModel(thePlayer, arg3)
		elseif (action == "rename") then
			outputChatBox(getPlayerName(source).." changed your nickname to "..arg3, thePlayer, 225, 0, 0)
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." changed the nickname from " .. getPlayerName(thePlayer) .. " to "..arg3)
			setPlayerName(thePlayer, arg3)
		elseif (action == "vehicle") then
			if (isPedInVehicle(thePlayer)) then return end
			outputChatBox(getPlayerName(source).." gave you a "..getVehicleNameFromModel(arg3), thePlayer, 225, 0, 0)
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." gave " .. getPlayerName(thePlayer) .. " a "..getVehicleNameFromModel(arg3))
			local x, y, z = getElementPosition(thePlayer)
			local rx, ry, rz = getElementRotation(thePlayer)
			local theVehicle = createVehicle(arg3, x, y, z, rx, ry, rz, "Premium")
			setElementInterior(theVehicle,getElementInterior(thePlayer))
			setElementDimension(theVehicle,getElementDimension(thePlayer))
			theVehicles[theVehicle] = theVehicle
			warpPedIntoVehicle(thePlayer, theVehicle)
		elseif (action == "weapon") then
			outputChatBox (getPlayerName(source).." gave you a " .. getWeaponNameFromID(arg3) .. " (Ammo: " .. arg4 .. ")", thePlayer, 225, 0, 0)
			exports.CSGlogging:createAdminLogRow (source, getPlayerName(source).." gave " .. getPlayerName(thePlayer) .. " a " .. getWeaponNameFromID(arg3) .. " (Ammo: " .. arg4 .. ")")
			giveWeapon (thePlayer, arg3, arg4, true)
		elseif (action == "warpTo") then
			outputChatBox(getPlayerName(source).." warped you to him.",thePlayer,255,0,0)
			if (isPedInVehicle(thePlayer)) then
				removePedFromVehicle(thePlayer)
			end
			x,y,z = getElementPosition(source)
			int = getElementInterior(source)
			dim = getElementDimension(source)
			x = x + 1
			setElementPosition(thePlayer,x,y,z)
			setElementInterior(thePlayer,int)
			setElementDimension(thePlayer,dim)
		end
	end
)

-- create premium car
function givePremiumCar (thePlayer)
	if not (isPedInVehicle(thePlayer)) then
		local x, y, z = getElementPosition(thePlayer)
		local rx, ry, rz = getElementRotation(thePlayer)
		local theVehicle = createVehicle(526, x, y, z, rx, ry, rz, "Premium")
		theVehicles[theVehicle] = theVehicle
		warpPedIntoVehicle(thePlayer, theVehicle)
		local handlingTable = getVehicleHandling (theVehicle)
		local newVelocity = (handlingTable["maxVelocity"] + (handlingTable["maxVelocity"] / 100 * 40))
		setVehicleHandling (theVehicle, "numberOfGears", 5)
		setVehicleHandling (theVehicle, "driveType", 'awd')
		setVehicleHandling (theVehicle, "maxVelocity", newVelocity)
		setVehicleHandling (theVehicle, "engineAcceleration", handlingTable["engineAcceleration"] +8)
	end
end

-- When a vehicle blows
addEventHandler("onVehicleExplode", root,
	function ()
		if (theVehicles[source]) then
			setTimer (destroyElement, 4000, 1, source)
		end
	end
)

-- Warp
function onAdminWarpPlayer (thePlayer, toPlayer, warpTo)
	local thePlayer = thePlayer or source
	if (isElement(thePlayer)) and (isElement(toPlayer)) then
		if (isPedInVehicle(thePlayer)) then removePedFromVehicle(thePlayer) end
		if (isPedInVehicle (toPlayer)) then
			local vehicle = getPedOccupiedVehicle (toPlayer)
			local occupants = getVehicleOccupants(vehicle)
			local seats = getVehicleMaxPassengers(vehicle)
			local x, y, z = getElementPosition (vehicle)
			local isWarped = false
			for seat = 0, seats do
				local occupant = occupants[seat]
				if not (occupant) then
					setTimer (warpPedIntoVehicle, 1000, 1, thePlayer, vehicle, seat)
					fadeCamera (thePlayer, false, 1, 0, 0, 0)
					setTimer (fadeCamera, 1000, 1, thePlayer, true, 1)
					setElementDimension (thePlayer, getElementDimension (toPlayer))
					if (getElementDimension(thePlayer)) ~= (getElementDimension(toPlayer)) then setElementInterior (thePlayer, getElementInterior (toPlayer), getElementPosition(toPlayer)) end
					isWarped = true
					return
				end
				if not (isWarped) then
					setTimer (setElementPosition, 1000, 1, thePlayer, x, y, z +1)
					fadeCamera (thePlayer, false, 1, 0, 0, 0)
					setTimer (fadeCamera, 1000, 1, thePlayer, true, 1)
					setElementDimension (thePlayer, getElementDimension (toPlayer))
					if (getElementDimension(thePlayer)) ~= (getElementDimension(toPlayer)) then setElementInterior (thePlayer, getElementInterior (toPlayer), getElementPosition(toPlayer)) end
				end
			end
		else
			local x, y, z = getElementPosition (toPlayer)
			local r = getPedRotation (toPlayer)
			x = x - math.sin (math.rad (r)) * 2
			y = y + math.cos (math.rad (r)) * 2
			setTimer (setElementPosition, 1000, 1, thePlayer, x, y, z + 1)
			fadeCamera (thePlayer, false, 1, 0, 0, 0)
			setElementDimension (thePlayer, getElementDimension (toPlayer))
			setElementInterior (thePlayer, getElementInterior (toPlayer))
			setTimer (fadeCamera, 1000, 1, thePlayer, true, 1)
		end
	end
end

-- Punishments
addEvent("onServerPlayerPunish", true)
addEventHandler("onServerPlayerPunish", root,
	function (thePlayer, theType, theTime, theReason)
		if (theType == "Mainchat/teamchat mute") then
			exports.CSGadmin:adminMutePlayer (source, thePlayer, theReason, theTime, "Main")
		elseif (theType == "Global mute") then
			exports.CSGadmin:adminMutePlayer (source, thePlayer, theReason, theTime, "Global")
		elseif (theType == "Jail") then
			setElementData(thePlayer,"isPlayerArrested",false)
			exports.CSGadmin:setPlayerJailed (source, thePlayer, theReason, theTime)
		elseif (theType == "Account ban") then
			exports.CSGadmin:banServerPlayer (source, thePlayer, theReason, theTime, "account" )
		elseif (theType == "Serial ban") then
			exports.CSGadmin:banServerPlayer (source, thePlayer, theReason, theTime, "serial" )
		end
	end
)

-- Punishments remove
addEvent("onServerPlayerPunishRemove", true)
addEventHandler("onServerPlayerPunishRemove", root,
	function (thePlayer, theType)
		if (theType == "Mainchat/teamchat mute") then
			exports.CSGadmin:adminUnmutePlayer (thePlayer, source)
		elseif (theType == "Global mute") then
			exports.CSGadmin:adminUnmutePlayer (thePlayer, source)
		elseif (theType == "Jail") then
			exports.CSGadmin:removePlayerJailed(thePlayer, source)
		end
	end
)

--EM

---- Event vehicles
local eventVehicleMarker = {}
local markerData = {}
local markerCreator = {}
local eventVehicles = {}
local createTick = nil

-- Create a marker with vehicles
addEvent("onCreateEventVehicleMarker", true)
function createEventVehicleMarker (theVehicleName)
	local creatorAccount = exports.server:getPlayerAccountName(source)
    if not (getVehicleModelFromName(theVehicleName)) then
		exports.dendxmsg:createNewDxMessage(source, "There is no vehicle found with this name!", 225, 0, 0)
	elseif (creatorAccount) then
		if (isElement(eventVehicleMarker[creatorAccount])) then destroyElement(eventVehicleMarker[creatorAccount]) end
        local x, y, z = getElementPosition(source)
        eventVehicleMarker[creatorAccount] = createMarker(x, y, z - 1, "cylinder", 1.5, 21,27,141, 100)
		setElementDimension(eventVehicleMarker[creatorAccount], getElementDimension(source))
        local theVehicleModel = getVehicleModelFromName(theVehicleName)
        if not (theVehicleModel) then
			exports.dendxmsg:createNewDxMessage(source, "There is no vehicle found with this name!", 225, 0, 0)
		else
			createTick = getTickCount()
			markerData[eventVehicleMarker[creatorAccount]] = theVehicleModel
			markerCreator[eventVehicleMarker[creatorAccount]] = creatorAccount
			setElementInterior(eventVehicleMarker[creatorAccount], getElementInterior(source))
			addEventHandler("onMarkerHit", eventVehicleMarker[creatorAccount], onEventVehicleMarkerHit)
			--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." created a event vehicle marker (VEHICLE: " .. theVehicleName .. ")")
		end
	end
end
addEventHandler("onCreateEventVehicleMarker", root, createEventVehicleMarker)

-- Delete all the vehicles create by a marker
addEvent("onDestroyEventVehicles", true)
function destroyEventMarkerVehicles (theCreator)
	if (eventVehicles[theCreator]) then
		for i, theElement in ipairs (eventVehicles[theCreator]) do
			if (isElement(theElement)) then
				destroyElement(theElement)
			end
		end
		--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." deleted all event vehicles")
	end
	eventVehicles[theCreator] = {}
end
addEventHandler("onDestroyEventVehicles", root, destroyEventMarkerVehicles)

-- Destroy the marker
addEvent("onDestroyEventVehicleMarker", true)
function destroyEventMarkerVehicleMarker (theCreator)
	if (isElement(eventVehicleMarker[theCreator])) then
		removeEventHandler("onMarkerHit", eventVehicleMarker[theCreator], onEventVehicleMarkerHit)
		destroyElement(eventVehicleMarker[theCreator])
		--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." deleted the event vehicle marker")
	end
	if (eventVehicleMarker[theCreator]) then eventVehicleMarker[theCreator] = {} end
end
addEventHandler("onDestroyEventVehicleMarker", root, destroyEventMarkerVehicleMarker)

-- When the player hits a marker for vehicles
function onEventVehicleMarkerHit (theElement, matchingDimension)
	if (matchingDimension) then
		if (createTick) and (getTickCount()-createTick < 3000) then
			return
		else
			if (getElementType (theElement) == "player") and not (isPedInVehicle(theElement)) then
				local theModel = markerData[source]
				local theCreator = markerCreator[source]
				if (theModel) and (theCreator) then
					local x, y, z = getElementPosition(source)
					local theVehicle = createVehicle(theModel, x, y, z +2)
					setElementDimension(theVehicle, getElementDimension(source))
					setElementInterior(theVehicle, getElementInterior(source))
					warpPedIntoVehicle(theElement, theVehicle)
					if not (eventVehicles[theCreator]) then eventVehicles[theCreator] = {} end
					table.insert(eventVehicles[theCreator], theVehicle)
					exports.DENlogging:writePlayerLog (theElement, getPlayerName(theElement).." picked a " .. getVehicleNameFromModel (theModel) .." from a event marker (EVENT PANEL)")
				end
			end
		end
	end
end

-- Warp function
local thePlayers = {}
local x, y, z, int, dim = 0, 0, 0, 0, 0
local isEvent = false
local warpLimit = 0
local warps = 0
local frozen = true

addEvent("onCreateWarpEvent", true)
function createWarpEvent (theLimit, theDimension, theInterior, eventName)
	if (unfreezeEventPlayer ()) then
		if (isEvent) then
			exports.dendxmsg:createNewDxMessage(source, "There is already a event going, please wait till this event ends or destroy it!", 225, 0, 0)
		else
			setElementDimension(source, theDimension)
			local px, py, pz = getElementPosition(source)

			if (getElementInterior(source) ~= theInterior) then
				setElementInterior(source, theInterior, px, py, pz)
			end

			x = px
			y = py
			z = pz
			int = tonumber(theInterior)
			dim = tonumber(theDimension)
			isEvent = true
			frozen = true
			warpLimit = tonumber(theLimit)
			warps = 0
			thePlayers = {}
			exports.dendxmsg:createNewDxMessage(root,"[EVENT] " .. eventName .. " (LIMIT: " .. theLimit .. ")",0,255,0)
			exports.dendxmsg:createNewDxMessage(root,"(BY: " .. getPlayerName(source) .. ")",0,255,0)
			exports.dendxmsg:createNewDxMessage(root,"Use /eventwarp to participate",0,255,0)
			outputChatBox("[EVENT] " .. eventName .. " (LIMIT: " .. theLimit .. ") (BY: " .. getPlayerName(source) .. ") Use /eventwarp to participate!", root, 0, 225, 0)
			--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." created a event: (NAME: " .. eventName .. ") (LIMIT: " .. theLimit .. ")")
		end
	end
end
addEventHandler("onCreateWarpEvent", root, createWarpEvent)

addCommandHandler("eventwarp",
function (thePlayer)
	if (isEvent) then
		local jx,jy,jz = getElementPosition(thePlayer)
		local jx2,jy2,jz2 = 1561.75, -822.47, 350.84
		local jailDim = getElementDimension(thePlayer)
		if jailDim == 2 then
			if getDistanceBetweenPoints3D(jx,jy,jz,jx2,jy2,jz2) < 100 then
				exports.dendxmsg:createNewDxMessage(thePlayer, "You can't join a event while jailed!",255,0,0)
				return
			end
		end
		if (getElementData (thePlayer, "isPlayerArrested")) or (getElementData (thePlayer, "isPlayerRobbing")) or (getElementData (thePlayer, "isPlayerJailed")) or (isPedInVehicle(thePlayer)) then
			exports.dendxmsg:createNewDxMessage(thePlayer, "You can't warp while arrested, jailed or when driving a vehicle!", 225, 0, 0)
		else
			if (getElementInterior(thePlayer) == int) then
				setElementPosition(thePlayer, x, y, z)
			else
				setElementInterior(thePlayer, int, x, y, z)
			end

			setElementDimension(thePlayer, dim)

			if (frozen) then
				setElementFrozen(thePlayer, true)
			end

			if not (thePlayers[thePlayer]) then
				thePlayers[thePlayer] = thePlayer
				warps = warps + 1
			end

			if (warps >= warpLimit) then
				isEvent = false
				outputChatBox("The event is now full!", root, 0, 225, 0)
			end
		end
	else
		exports.dendxmsg:createNewDxMessage(thePlayer, "There is no event or the current event is full!", 225, 0, 0)
	end
end
)

addEvent("onUnfreezeEventPlayers", true)
function unfreezeEventPlayer ()
	local msg = false
	if (thePlayers) then
		for i, k in pairs (thePlayers) do
			if (isElement(i)) then
				setElementFrozen(i, false)
				exports.dendxmsg:createNewDxMessage(i, "You are now unfrozen!", 225, 0, 0)
				msg = true
			end
		end
		if (msg) then
			exports.dendxmsg:createNewDxMessage(source, "All players are now unfrozen!", 225, 0, 0)
		end
	end
	thePlayers = {}
	frozen = false
	return true
end
addEventHandler("onUnfreezeEventPlayers", root, unfreezeEventPlayer)

addEvent("onDestroyEvent", true)
function destroyAdminEvent ()
	if (isEvent) then
		if (unfreezeEventPlayer ()) then
			isEvent = false
			outputChatBox("Warping to the event is no longer available!", root, 0, 225, 0)
			exports.dendxmsg:createNewDxMessage(source, "Event is destroyed and all players are unfrozen!", 225, 0, 0)
			--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." destroyed the event")
		end
	end
end
addEventHandler("onDestroyEvent", root, destroyAdminEvent)

-- Send money
addEvent("onSendEventMoney", true)
function givePlayerEventMoney (thePlayer, theMoney)
	if (isElement (thePlayer)) then
		if (theMoney > 100000) then
			exports.dendxmsg:createNewDxMessage(source, "Server refused to give more the %100,000 a report has been send to a L6 staff!", 225, 0, 0)
			--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." wanted to send $" .. theMoney .. " to " .. getPlayerName(thePlayer) .. " server refused")
		else
			givePlayerMoney(thePlayer, theMoney)
			exports.dendxmsg:createNewDxMessage(source, "You sent $" .. theMoney .. " to "..getPlayerName(thePlayer), 0, 255, 0)
			exports.dendxmsg:createNewDxMessage(thePlayer, "You recieved $" .. theMoney .. " from a event! By: "..getPlayerName(source), 0, 255, 0)
			--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." has sent $" .. theMoney .. " to " .. getPlayerName(thePlayer) .. " (EVENT PANEL)")
			exports.DENlogging:writePlayerLog (thePlayer, getPlayerName(thePlayer).." recieved $".. theMoney .." from ".. getPlayerName(source) .." (EVENT PANEL)")
		end
	end
end
addEventHandler("onSendEventMoney", root, givePlayerEventMoney)

-- Give weapon
addEvent("onSendWeapon", true)
function givePlayerEventWeapon (thePlayer, theWeapon)
	if (isElement (thePlayer)) then
		local theWeaponID = getWeaponIDFromName (theWeapon)
		giveWeapon(thePlayer, theWeaponID, 500, true)
		exports.dendxmsg:createNewDxMessage(source, "You sended a " .. theWeapon .. " to "..getPlayerName(thePlayer), 225, 0, 0)
		exports.dendxmsg:createNewDxMessage(thePlayer, "You recieved a " .. theWeapon .. " from a event! By: "..getPlayerName(source), 225, 0, 0)
		--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." has sent a " .. theWeapon .. " to " .. getPlayerName(thePlayer) .. " (EVENT PANEL)")
		exports.DENlogging:writePlayerLog (thePlayer, getPlayerName(thePlayer).." recieved a ".. theWeapon .." from ".. getPlayerName(source) .." (EVENT PANEL)")
	end
end
addEventHandler("onSendWeapon", root, givePlayerEventWeapon)

-- Create pickup
local eventPickups = {}

addEvent("onCreateEventPickup", true)
function createEventPickup (theType)
	local creatorAccount = exports.server:getPlayerAccountName(source)
	if (isElement (source)) and (creatorAccount) then
		local x, y, z = getElementPosition(source)
		if (string.lower(theType) == "health") then
			if (eventPickups[creatorAccount]) and (isElement(eventPickups[creatorAccount])) then destroyElement(eventPickups[creatorAccount]) eventPickups[creatorAccount] = {} end
			eventPickups[creatorAccount] = createPickup (x, y, z, 0, 100, 0)
			setElementDimension(eventPickups[creatorAccount], getElementDimension(source))
			setElementInterior(eventPickups[creatorAccount], getElementInterior(source))
			--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." created a health pickup (EVENT PANEL)")
		elseif (string.lower(theType) == "armor") then
			if (eventPickups[creatorAccount]) and (isElement(eventPickups[creatorAccount])) then destroyElement(eventPickups[creatorAccount]) eventPickups[creatorAccount] = {} end
			eventPickups[creatorAccount] = createPickup (x, y, z, 1, 100, 0)
			setElementDimension(eventPickups[creatorAccount], getElementDimension(source))
			setElementInterior(eventPickups[creatorAccount], getElementInterior(source))
			--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." created a armor pickup (EVENT PANEL)")
		else
			exports.dendxmsg:createNewDxMessage(thePlayer, "Wrong pickup model! (Use: health or armor)", 225, 0, 0)
		end
	end
end
addEventHandler("onCreateEventPickup", root, createEventPickup)

-- Destroy pickup
addEvent("onDestroyEventPickup", true)
function destroyEventPickup ()
	local creatorAccount = exports.server:getPlayerAccountName(source)
	if (isElement (source)) and (creatorAccount) then
		if (eventPickups[creatorAccount]) and (isElement(eventPickups[creatorAccount])) then
			--exports.DENlogging:writeStaffLog(source, getPlayerName(source).." destroyed a pickup (EVENT PANEL)")
			destroyElement(eventPickups[creatorAccount])
			eventPickups[creatorAccount] = {}
		end
	end
end
addEventHandler("onDestroyEventPickup", root, destroyEventPickup)

addEvent("CSGevents.gotScore",true)
addEventHandler("CSGevents.gotScore",root,function(p,score)
	exports.DENdxmsg:createNewDxMessage(p,"Event: You have been rewarded "..score.." score!",0,255,0)
	exports.CSGscore:givePlayerScore(p,score)
end)

-- bans

addEvent("staffpanel.ban",true)
addEventHandler("staffpanel.ban",root,
function(serialOrAccount,banType,reason,duration,global)
	local theTime = getRealTime()
	local timestamp = theTime.timestamp
	local banstamp
	if not duration then
		banstamp = 0
	else
		banstamp = timestamp+duration
	end
	local banTable = "bans"
	if global then banTable = 'globalbans' end
	local serial = serialOrAccount
	local account = ""
	if banType == 'account' then
		serial = ""
		account = serialOrAccount
	end
	exports.denmysql:exec("INSERT INTO ?? (serial,account,reason,banstamp,bannedby) VALUES (?,?,?,?,?)",banTable,serial,account,serialOrAccount,reason,banstamp,getPlayerName(source))
	local players = getElementsByType('player')
	for i=1,#players do
		if banType == 'serial' then
			local pSerial = getPlayerSerial(players[i])
			if pSerial == serialOrAccount then
				kickPlayer(players[i],source,reason)
			end
		else
			local pAccount = exports.server:getPlayerAccountName(players[i])
			if pAccount == serialOrAccount then
				kickPlayer(players[i],source,reason)
			end
		end
	end
end)
addEvent("staffpanel.unban",true)
addEventHandler("staffpanel.unban",root,
	function(banID,global)
	local banTable = "bans"
	if global then banTable = "globalbans" end
	exports.denmysql:exec("DELETE FROM ?? WHERE id=?",banTable,banID)
end)

addEvent('staffpanel.accounts.delete',true)
addEventHandler('staffpanel.accounts.delete',root,
	function (id)
		if not tonumber(id) then return false; end
		local playerAccount = isAccountLoggedIn(tonumber(ID))
		if playerAccount then
			exports.dendxmsg:createNewDxMessage(source,"Account logged in as "..getPlayerName(playerAccount)..", please wait till user logs out.",255,0,0)
			return false;
		end
		exports.denmysql:exec("DELETE FROM accounts WHERE id=?",id)
		exports.denmysql:exec("DELETE FROM banking WHERE userid=?",id)
		exports.dendxmsg:createNewDxMessage(source,"Account deleted!",0,255,0)
	end
)

addEvent("staffpanel.accounts.updateInfo",true)
addEventHandler("staffpanel.accounts.updateInfo",root,
	function(ID, updatedInfo)
		if not tonumber(ID) then
			exports.dendxmsg:createNewDxMessage(source,"ID invalid, account bugged?",255,0,0)
			return false;
		else
			local playerAccount = isAccountLoggedIn(tonumber(ID))
			if playerAccount then
				exports.dendxmsg:createNewDxMessage(source,"Account logged in as "..getPlayerName(playerAccount)..", please wait till user logs out.",255,0,0)
				return false;
			end
		end
		local tables = {['banking'] = {}, ['accounts'] = {} }
		for k,v in pairs(updatedInfo) do
			if k == 'bankmoney' then
				table.insert(tables['banking'],{'balance',tonumber(v)})
			elseif k == 'password' then
				table.insert(tables['accounts'],{k,sha512(v)})
			else
				table.insert(tables['accounts'],{k,v})
			end
		end
		for dbTable,values in pairs(tables) do
			if #values >= 1 then
				local setString = ""
				local allValues = {}
				for i=1,#values do
					local key,value = unpack(values[i])
					if i ~= #values then
						setString = setString..""..key.."=?,"
					else
						setString = setString..""..key.."=?"
					end
					table.insert(allValues,value)
				end
				table.insert(allValues,tonumber(ID))
				table.insert(allValues,1,dbTable)
				local queryString = "UPDATE ?? SET "..setString.." WHERE id=?"
				exports.denmysql:exec(queryString,unpack(allValues))
			end
		end
		exports.dendxmsg:createNewDxMessage(source,"Info updated!",0,255,0)
	end
)
-- manage accounts that are logged in

function isAccountLoggedIn(ID)
	local players = getElementsByType('player');
	for i=1,#players do
		local userID = getElementData(players[i],"accountUserID");
		if userID == ID then
			return players[i];
		end
	end
	return false;
end
