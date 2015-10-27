-- Staff ranks
local adminTable = {}
local completeAdminTable = {}

-- Staff ranks
local staffRanks = {
	[1] = "Trial Staff",
	[2] = "New Staff",
	[3] = "Loyal Staff",
	[4] = "Experienced Staff",
	[5] = "Important Staff",
	[6] = "Leading Staff",
	[7] = "CSG Leader",
	[8] = "Yokozuna",
}

-- Staff passwords for MTA account system
local staffPlayers = {
	-- ["accountName"] = "password",
	["noki"] = "swag",
}

local devPlayers = {
	-- ["accountName"] = "password",
	["noki"] = "swag",
}

-- Log staff and devs in with their respective MTA accounts
addEventHandler("onPlayerLogin", root,
	function (a, b)
		if (not a) and (not b) and (devPlayers[exports.server:getPlayerAccountName(source)]) then
			logIn(source, getAccount(exports.server:getPlayerAccountName(source)), devPlayers[exports.server:getPlayerAccountName(source)])
		end
		
		if (not a) and (not b) and (staffPlayers[exports.server:getPlayerAccountName(source)]) then
			logIn(source, getAccount(exports.server:getPlayerAccountName(source)), staffPlayers[exports.server:getPlayerAccountName(source)])
		end
	end
)

-- Loop through the table to make the accounts
addEventHandler("onResourceStart", resourceRoot,
	function ()
		for name, pass in pairs(staffPlayers) do
			addAccount(name, pass)
		end
		for name, pass in pairs(devPlayers) do
			addAccount(name, pass)
		end
	end
)

--Prevent imposters using the staff tag
function scanForTag(old, new)
	if type(string.find(string.lower(new), "[csg]", 1, true)) == "number" then
	
		if (not adminTable[source]) then
		
			exports.dendxmsg:createNewDxMessage(source, "You are not a CSG Staff member, you cannot use the [CSG] tag.", 255, 0, 0)
			setPlayerName(source, old)
			
			for k, v in pairs(getElementsByType("player")) do
				exports.killmessages:outputMessage(new.." is an imposter. Renamed to "..old, v, 255, 0, 0)
			end
			
			cancelEvent()
		end
	end
end
addEventHandler("onPlayerChangeNick", root, scanForTag)

addEvent("returnHasPlayerGotStaffBinded", true)
addEventHandler("returnHasPlayerGotStaffBinded", root,
	function(state)
		outputDebugString("Got results, processing...")
		if (state) then
			outputDebugString("Got state, outputting..")
			if (state == true) then
				outputDebugString("[STAFF] "..getPlayerName(source).." has /staff binded.", 0, 255, 0, 0)
			else
				outputDebugString("[STAFF] "..getPlayerName(source).." does not have /staff binded", 0, 255, 0, 0)
			end
		end
	end
)

addCommandHandler("staffCmdBinded",
	function(_player, cmd, target)
		outputDebugString("Finding player...")
		local player = exports.server:getPlayerFromNamePart(target)
		if (isElement(player)) then --he exists
			outputDebugString("Player found, sending scan call...")
			triggerClientEvent("checkForStaffCmdBind", player)
		else
			outputChatBox("Player not found!", _player, 255, 0, 0)
		end
	end
)


-- Staff Job
addCommandHandler("staff",
	function (thePlayer)
		if (isPlayerStaff(thePlayer)) then
			thePlayer:setTeam(Team.getFromName("Staff"))
			thePlayer:setData("Occupation", staffRanks[getPlayerAdminLevel(thePlayer)], true)
			-- setElementData(thePlayer, "Rank", staffRanks[getPlayerAdminLevel (thePlayer)], true)

			if (adminTable[thePlayer].gender == 0) then skin = 217 else skin = 211 end
			setElementModel(thePlayer, skin)
			exports.server:updatePlayerJobSkin(thePlayer, skin)

			thePlayer:setHealth(100)

			exports.DENvehicles:reloadFreeVehicleMarkers(thePlayer, true)

			triggerEvent("onPlayerJobChange", thePlayer, staffRanks[getPlayerAdminLevel(thePlayer)], false, getPlayerTeam(thePlayer))
			exports.CSGlogging:createAdminLogRow(thePlayer, getPlayerName(thePlayer).." entered staff job with " .. getPlayerWantedLevel(thePlayer).." stars")

			thePlayer:setData("wantedPoints", 0, true)
			setPlayerWantedLevel(thePlayer, 0)
			exports.DENlaw:updatedWantedLevel(thePlayer, 0)
			exports.DENdxmsg:createNewDxMessage(thePlayer, "You entered the staff job!", 0, 225, 0)
		end
	end
)

-- Set the rank of a staff when he login
addEvent("onServerPlayerLogin")
addEventHandler("onServerPlayerLogin", root,
	function (userID)
		local theTable = exports.DENmysql:query("SELECT * FROM `staff` WHERE `userid`=? LIMIT 1", userID)
		if (theTable and #theTable == 1 and theTable[1].active == 1) then
			adminTable[source] = theTable[1]
			triggerClientEvent("onSyncAdminTable", root, adminTable[source], source)
			outputChatBox("Welcome admin, press 'P' to use your panel!", source, 255, 128, 0)
		else
			if type(string.find(string.lower(source:getName()), "[csg]", 1, true)) == "number" then
				local old = source:getName()
				source:setName("Random"..math.random(255))
				exports.DENdxmsg:createNewDxMessage(source, "You are not a CSG staff member, you cannot use the [CSG] tag.", 255, 0, 0)
				for k, v in pairs(Element.getAllByType("player")) do
					exports.killmessages:outputMessage(old.." is an imposter. Renamed to "..source:getName().."", v, 255, 0, 0)
				end
			end
		end
	end
)

-- on Resource start
addEventHandler("onResourceStart", resourceRoot,
	function ()
		local theTable = exports.DENmysql:query("SELECT * FROM `staff`")
		completeAdminTable = theTable
		for k, thePlayer in ipairs(Element.getAllByType("player")) do
			local accountID = exports.server:getPlayerAccountID(thePlayer)
			if (accountID) then
				for i = 1, #theTable do
					if (theTable[i].userid == accountID) and (theTable[i].active == 1) then
						adminTable[thePlayer] = theTable[i]
					end
				end
			end
		end
	end
)

-- Ask for a admin table sync
addEvent("onRequestSyncAdminTable", true)
addEventHandler("onRequestSyncAdminTable", root,
	function ()
		triggerClientEvent(source, "onSyncAdminTable", source, adminTable)
	end
)

-- Function to promote a admin
function promoteAdmin(adminNick)
	for i=1,#completeAdminTable do
		if (completeAdminTable[i].nickname == adminNick) and (completeAdminTable[i].rank ~= 6)  then
			completeAdminTable[i].rank = completeAdminTable[i].rank +1
			local thePlayer = getPlayerFromID (completeAdminTable[i].userid)
			if (thePlayer and isElement(thePlayer)) then adminTable[thePlayer].rank = completeAdminTable[i].rank end
			exports.DENmysql:query("UPDATE `staff` SET `rank`=? WHERE `userid`=?", completeAdminTable[i].rank, completeAdminTable[i].userid)
			break
		end
	end
	triggerClientEvent("onSyncAdminTable", root, adminTable[thePlayer], thePlayer)
	completeAdminTable = exports.DENmysql:query("SELECT * FROM `staff`")
end

-- Function to demote a admin
function demoteAdmin(adminNick)
	for i=1, #completeAdminTable do
		if (completeAdminTable[i].nickname == adminNick) and (completeAdminTable[i].rank ~= 1) then
			completeAdminTable[i].rank = completeAdminTable[i].rank -1
			local thePlayer = getPlayerFromID (completeAdminTable[i].userid)
			if (thePlayer) and (isElement(thePlayer)) then adminTable[thePlayer].rank = completeAdminTable[i].rank end
			exports.DENmysql:query("UPDATE `staff` SET `rank`=? WHERE `userid`=?", completeAdminTable[i].rank, completeAdminTable[i].userid)
			break
		end
	end
	triggerClientEvent("onSyncAdminTable", root, adminTable[thePlayer], thePlayer)
	completeAdminTable = exports.DENmysql:query("SELECT * FROM `staff`")
end

-- Function to kick a admin
function kickAdmin(adminNick)
	for i=1, #completeAdminTable do
		if (completeAdminTable[i].nickname == adminNick) then
			local thePlayer = getPlayerFromID(completeAdminTable[i].userid)
			exports.DENmysql:query("DELETE FROM `staff` WHERE `userid`=?", completeAdminTable[i].userid)
			if (thePlayer and isElement(thePlayer)) then
				adminTable[thePlayer] = false
				thePlayer:setTeam(Team.getFromName("Unemployed"))
				thePlayer:setData("Occupation", "", true)
				thePlayer:setData("Rank", "", true)
				exports.DENvehicles:reloadFreeVehicleMarkers(thePlayer, true)
			end
			break
		end
	end
	triggerClientEvent("onSyncAdminTable", root, adminTable[thePlayer], thePlayer)
	completeAdminTable = exports.DENmysql:query("SELECT * FROM `staff`")
end

-- Set admin developer
function setAdminDeveloper(adminNick)
	for i=1, #completeAdminTable do
		if (completeAdminTable[i].nickname == adminNick) then
			if (completeAdminTable[i].developer == 1) then completeAdminTable[i].developer = 0 else completeAdminTable[i].developer = 1 end
			local thePlayer = getPlayerFromID (completeAdminTable[i].userid)
			if (thePlayer and isElement(thePlayer)) then adminTable[thePlayer].developer = completeAdminTable[i].developer end
			exports.DENmysql:query("UPDATE `staff` SET `developer`=? WHERE `userid`=?", completeAdminTable[i].developer, completeAdminTable[i].userid)
			break
		end
	end
	triggerClientEvent("onSyncAdminTable", root, adminTable[thePlayer], thePlayer)
	completeAdminTable = exports.DENmysql:query("SELECT * FROM `staff`")
end

-- Set admin eventmanager
function setAdminEventManager(adminNick)
	for i=1,#completeAdminTable do
		if (completeAdminTable[i].nickname == adminNick) then
			if (completeAdminTable[i].eventmanager == 1) then completeAdminTable[i].eventmanager = 0 else completeAdminTable[i].eventmanager = 1 end
			local thePlayer = getPlayerFromID (completeAdminTable[i].userid)
			if (thePlayer) and (isElement(thePlayer)) then adminTable[thePlayer].eventmanager = completeAdminTable[i].eventmanager end
			outputDebugString("[CSGstaff] Set player event manager with player element "..tostring(thePlayer))
			outputDebugString("[CSGstaff] Event manager status = "..tostring(adminTable[thePlayer].eventmanager))
			exports.DENmysql:query("UPDATE `staff` SET `eventmanager`=? WHERE `userid`=?", completeAdminTable[i].eventmanager, completeAdminTable[i].userid)
			break
		end
	end
	triggerClientEvent("onSyncAdminTable", root, adminTable[thePlayer], thePlayer)
	completeAdminTable = exports.DENmysql:query("SELECT * FROM `staff`")
end

-- Set admin inactive
function setAdminActive(adminNick)
	for i=1,#completeAdminTable do
		if (completeAdminTable[i].nickname == adminNick) then
			if (completeAdminTable[i].active == 1) then completeAdminTable[i].active = 0 else completeAdminTable[i].active = 1 end
			local thePlayer = getPlayerFromID (completeAdminTable[i].userid)
			if (thePlayer) and (isElement(thePlayer)) then adminTable[thePlayer] = false end
			exports.DENmysql:query("UPDATE `staff` SET `active`=? WHERE `userid`=?", completeAdminTable[i].active, completeAdminTable[i].userid)
			break;
		end
	end
	triggerClientEvent("onSyncAdminTable", root, adminTable[thePlayer], thePlayer)
	completeAdminTable = exports.DENmysql:query("SELECT * FROM `staff`")
end

-- Function to get all admins
function getAllAdmins()
	return completeAdminTable
end

-- Get player from ID function
function getPlayerFromID(userID)
	for _, thePlayer in ipairs(Element.getAllByType("player")) do
		if (exports.server:getPlayerAccountID(thePlayer) == userID) then
			return thePlayer
		end
	end
	return false
end

-- Remove again on quit
addEventHandler("onPlayerQuit", root,
	function ()
		if (adminTable[source]) then
			adminTable[source] = {}
			triggerClientEvent("onSyncAdminTable", root, adminTable)
		end
	end
)

-- Function to check if a player is staff
function isPlayerStaff(thePlayer)
	if (adminTable[thePlayer]) then
		return true
	end
	return false
end

-- Function to check if a player is a developer
function isPlayerDeveloper(thePlayer)
	if (adminTable[thePlayer] and adminTable[thePlayer].developer == 1) then
		return true
	end
	return false
end

-- Check is a player is a eventmanager
function isPlayerEventManager (thePlayer)
	if (adminTable[thePlayer] and adminTable[thePlayer].eventmanager == 1) then
		return true
	end
	return false
end

-- What is this?
function isPlayerBaseMod(thePlayer)
	if (adminTable[thePlayer]) then
		return adminTable[thePlayer].basemod == 1
	else
		return false
	end
end

-- Function that gets the staff level of a player
function getPlayerAdminLevel(thePlayer)
	if (adminTable[thePlayer] and adminTable[thePlayer].rank) then
		return adminTable[thePlayer].rank
	end
	return false
end

-- Staff note
addCommandHandler("note",
	function (thePlayer, cmd, ...)
		if (isPlayerStaff(thePlayer)) then
			local theMessage = table.concat({...}, " ")
			outputChatBox("#FF0000(NOTE) "..thePlayer:getName()..": #FFFFFF"..theMessage, root, 255, 255, 255, true)
			triggerEvent("onAdminNote", thePlayer, theMessage)
			exports.CSGlogging:createLogRow(thePlayer, "notes", theMessage)
		end
	end
)

-- Staff chat
function outputStaffChatMessage(nick, message, thePlayer)
	if (isElement(thePlayer)) then
		local _nick = thePlayer:getName()
	end

	for k, aPlayer in pairs(getOnlineAdmins()) do
		outputChatBox ("#FF0000(CSG) "..tostring(nick)..": #FFFFFF"..tostring(message), aPlayer, 255, 255, 255, true)
	end

	local staffEchoChan = exports.irc:ircGetChannelFromName("#staff.echo")
	if staffEchoChan and isElement(thePlayer) then -- channel found and message was sent from ingame
		exports.irc:ircSay(staffEchoChan,"(CSG) 07"..tostring(nick)..": "..tostring(message))
	end
	exports.CSGlogging:createLogRow(thePlayer, "staffchat", theMessage)

end

addEventHandler("onIRCMessage", root,
	function (channel,message)
		local server = exports.irc:ircGetServers()[1]
		if exports.irc:ircGetUserNick(source) == exports.irc:ircGetServerNick(server) then -- speaker = echobot
			return false
		elseif string.sub(message, 1, 1) ~= "!" and exports.irc:ircGetChannelName(channel) == "#staff.echo" then
			outputStaffChatMessage((exports.irc:ircGetUserNick(source) .. " (IRC)"), message)
		end
	end
)

addCommandHandler("csg",
	function (thePlayer, cmd, ...)
		if (isPlayerStaff(thePlayer)) then
			local theMessage = table.concat({...}, " ")
			if #(string.gsub(theMessage, " ", "")) < 1 then
				exports.dendxmsg:createNewDxMessage(thePlayer, "Enter a message!", 255, 0, 0)
				return false
			else
				outputStaffChatMessage(thePlayer:getName(), theMessage, thePlayer)
			end
		end
	end
)

-- Sup chat
addCommandHandler("sup",
	function (thePlayer, cmd, ...)
		if (isPlayerStaff (thePlayer)) or (exports.CSGsupporters:isPlayerSupporter(thePlayer)) then
			local theMessage = table.concat({...}, " ")
			for k, aPlayer in pairs(getOnlineSupporters()) do
				outputChatBox ("#FF0000(SUPPORTERS) "..tostring(getPlayerName(thePlayer))..": #FFFFFF"..tostring(theMessage), aPlayer, 255, 255, 255, true)
			end
			exports.CSGlogging:createLogRow (thePlayer, "supporterschat", theMessage)
		end
	end
)

-- Returns a table with all staff players
function getOnlineSupporters ()
    local theTable = {}
    for k, thePlayer in pairs(Element.getAllByType("player")) do
        if (isPlayerStaff (thePlayer)) or (exports.CSGsupporters:isPlayerSupporter(thePlayer)) then
            table.insert(theTable, thePlayer)
        end
    end
    return theTable
end

function getOnlineAdmins ()
    local theTable = {}
    for k, thePlayer in pairs(Element.getAllByType("player")) do
        if (isPlayerStaff (thePlayer)) then
            table.insert(theTable, thePlayer)
        end
    end
    return theTable
end

-- Make the car from a staff dmgproof
addCommandHandler("dmgproof",
	function (thePlayer)
		if (isPlayerStaff (thePlayer) and getTeamName(getPlayerTeam(thePlayer)) == "Staff") and (getPlayerAdminLevel(thePlayer) >= 2) then
			local theVehicle = getPedOccupiedVehicle(thePlayer)
			if (theVehicle) then
				if (isVehicleDamageProof(theVehicle)) then
					exports.DENdxmsg:createNewDxMessage(thePlayer, "Your vehicle is no longer damageproof!", 0, 225, 0)
					setVehicleDamageProof(theVehicle, false)
				else
					exports.DENdxmsg:createNewDxMessage(thePlayer, "Your vehicle is now damageproof!", 0, 225, 0)
					exports.CSGlogging:createAdminLogRow (thePlayer, getPlayerName(thePlayer).." made the vehicle from " .. getPlayerName(getVehicleController(theVehicle)) .." damageproof")
					setVehicleDamageProof(theVehicle, true)
				end
			end
		end
	end
)

-- Minigun command
addCommandHandler("minigun",
	function (thePlayer)
		if (isPlayerStaff(thePlayer) and Team.getFromName(thePlayer:getTeam()) == "Staff" and getPlayerAdminLevel(thePlayer) == 6) then
			if (getPlayerAdminLevel(thePlayer) >= 4) then
				giveWeapon(thePlayer, 38, 9000, true)
				exports.CSGlogging:createAdminLogRow(thePlayer, thePlayer:getName().." spawned a minigun")
			end
		end
	end
)

-- Invis command
addCommandHandler("invis",
	function (thePlayer)
		if (isPlayerStaff(thePlayer) and getTeamName(getPlayerTeam(thePlayer)) == "Staff") then
			if (thePlayer:getAlpha() == 255) then
				exports.CSGlogging:createAdminLogRow(thePlayer, getPlayerName(thePlayer).." made himself invisible")
				thePlayer:setAlpha(0)
				setPlayerNametagShowing(thePlayer, false)
			else
				thePlayer:setAlpha(255)
				setPlayerNametagShowing(thePlayer, true)
			end
		end
	end
)

-- Glue stuff
addEvent("gluePlayer",true)
addEventHandler("gluePlayer", root,
	function (slot, vehicle, x, y, z, rotX, rotY, rotZ)
		attachElements(source, vehicle, x, y, z, rotX, rotY, rotZ)
		setPedWeaponSlot(source, slot)
	end
)

addEvent("ungluePlayer", true)
addEventHandler("ungluePlayer", root,
	function ()
		detachElements(source)
	end
)

-- self explanatory
function CSGJockeAHelp(ps)
	if ps:getTeam() == Team.getFromName("Staff") then
		outputChatBox(ps:getName().." is now available to help you!", root, 0, 255, 0)
		ps:setData("PlayerIsBusy", false)
	end
end
addCommandHandler("csgadmin", CSGJockeAHelp, false, false)

addEventHandler("onPlayerQuit", root,
	function ()
		if (isElement(source) and isPlayerStaff(source)) then
			exports.DENdxmsg:createNewDxMessage(root, getPlayerName(source).." has logged out!", 255, 255, 255)
		end
	end
)

addEventHandler("onPlayerLogin", root,
	function ()
		setTimer(
			function (player)
				if isElement(player) and isPlayerStaff(player) then
					level = exports.CSGstaff:getPlayerAdminLevel(player)
					name = getPlayerName(player)
					exports.DENdxmsg:createNewDxMessage(root, tostring(name).." logged in [L"..tostring(level).."]", 255, 255, 255)
				end
			end, 1000, 1, source
		)
	end
)