-- Positions for the matrix view for the login screen
local matrixViewPositions = {
	{2060.693359375, 1323.3287353516, 65.554336547852, 2154.0563964844, 1301.9788818359, 36.787712097168},
	{-488.73297119141, 2129.7478027344, 131.07089233398, -577.43792724609, 2095.4423828125, 100.17473602295},
	{355.38235473633, -1999.6640625, 34.214122772217, 401.36798095703, -2077.3337402344, -8.8294067382813},
	{2373.4975585938, 69.472595214844, 68.322166442871, 2420.0559082031, -10.329551696777, 30.060695648193},
	{2055.7841796875, 1197.9633789063, 25.738883972168, 2141.7668457031, 1147.1596679688, 20.643169403076},
	{2321.8068847656, -1100.53125, 76.947044372559, 2365.5268554688, -1017.3639526367, 42.716026306152},
	{-807.52880859375, 2699.8017578125, 75.263061523438, -853.92779541016, 2777.5541992188, 32.816757202148},
	{196.63110351563, 2660.5759277344, 53.300601959229, 262.5549621582, 2594.3989257813, 17.598323822021},
	{-458.94390869141, -164.11698913574, 123.5959777832, -548.6953125, -195.21823120117, 92.332641601563},
	{-1070.3149414063, -1610.5084228516, 94.326530456543, -1135.0595703125, -1682.0073242188, 67.944076538086},
	{-632.33306884766, -1473.3518066406, 44.557136535645, -545.33532714844, -1492.6140136719, -0.833984375},
	{270.52749633789, -1205.0640869141, 110.60611724854, 321.99029541016, -1128.5759277344, 71.861503601074},
	{1156.4423828125, -1441.9432373047, 38.343357086182, 1086.1207275391, -1504.4560546875, 4.4757308959961},
	{-1267.3508300781, 1106.96484375, 102.32939910889, -1311.2535400391, 1019.9342041016, 80.008575439453},
	{-2662.2238769531, 2242.8115234375, 89.52938079834, -2584.8740234375, 2297.583984375, 57.639293670654},
}

local antisaveTimers = {}
local loggingIn = {}

-- Still need to add the teams from CSG
local teams = {
	[1] = {"Staff", 255, 255, 255},
	[2] = {"Criminals", 255, 0, 0},
	[3] = {"Unemployed", 125, 125, 125},
	[4] = {"Unoccupied", 255, 165, 0},
}

-- Create teams and set time
addEventHandler("onResourceStart", resourceRoot,
	function ()
		setGameType("CSG V"..getCSGServerVersion())
		setOcclusionsEnabled(false)
		
		for k, v in ipairs(teams) do
			createTeam(v[1], v[2], v[3], v[4])
		end

		local realtime = getRealTime()
		setTime(realtime.hour, realtime.minute)
		setMinuteDuration(60000)
		setServerPassword("") --set the password to nothing if any password is set.
		setFPSLimit(70)
	end
)

-- Disabled this as this resource will constantly being restarted during development
--[[
addEventHandler("onResourceStop", resourceRoot,
	function ()
		setServerPassword(math.random(1239871)) --set a password so that no one can connect back on while the kicking process continues.
		for _, v in pairs(getElementsByType("player")) do
			kickPlayer(v, "Core", "Core stopping/restarting")
		end
	end
)
--]]

-- Check if there is not already a player ingame with the same serial
addEventHandler("onPlayerConnect", root,
	function (playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber)
		for _, thePlayer in pairs(getElementsByType ("player")) do
			if (getPlayerSerial(thePlayer) == playerSerial) then
				cancelEvent(true, "There is already a player online with this serial!")
				return
			end
		end
	end
)

-- When the player joins spawn him ingame
addEventHandler( "onPlayerJoin", root,
	function ()
		if (spawnPlayer(source, 0, 0, 0)) then
			setCameraTarget(source )
			fadeCamera(source, true, 1.0, 0, 0, 0)

			startMatrix(source)

			showPlayerHudComponent(source, "radar", false)
			showPlayerHudComponent(source, "area_name", false)
			setElementDimension(source, 1234)
			showChat(source, false)
		end
	end
)

local refreshTimers = {}

function startMatrix(player)
	if (isElement(player)) then
		if (exports.server:isPlayerLoggedIn(player) == false) then
			fadeCamera(player, false, 1, 0, 0, 0)
			setTimer(fadeCamera, 1000, 1, player, true)
			local x, y, z, lX, lY, lZ = unpack(matrixViewPositions[ math.random(#matrixViewPositions)])
			setTimer(setCameraMatrix, 1000,1 , player, x, y, z, lX, lY, lZ)
			
			refreshTimers[player] = setTimer(startMatrix, 5000, 1, player)
		else
			if (isTimer(refreshTimers[player])) then
				killTimer(refreshTimers[player])
			end
			
			return false --no more updating.
		end
	else
		return false
	end
end

-- Kick the player when he has a too low resolution
--[[addEvent( "doKickPlayer", true )
addEventHandler( "doKickPlayer", root,
	function ()
		kickPlayer( source, "Connection refused due a too low screen resolution" )
	end
)]]--

-- When the player spawns check if we show the login screen or draw a ban window
addEvent( "doSpawnPlayer", true)
addEventHandler( "doSpawnPlayer", root,
	function ()
		local time = getRealTime()
		local banData = exports.DENmysql:query("SELECT banstamp,bannedby,reason,serial FROM bans WHERE serial=? LIMIT 1", getPlayerSerial(source))
		if banData and banData[1] then
			if (time.timestamp > tonumber( banData[1].banstamp ) ) and not ( tonumber( banData[1].banstamp) == 0) then
				exports.DENmysql:exec("DELETE FROM bans WHERE serial = ?", getPlayerSerial(source))
				triggerClientEvent(source, "setLoginWindowVisable", source)
			else
				setElementData(source, "Occupation", "Banned")
				triggerClientEvent(source, "drawClientBanScreen", source, banData[1].serial, banData[1].reason, banData[1].banstamp, banData.bannedby)
				toggleAllControls(source, false)
			end
		else
			triggerClientEvent(source, "setLoginWindowVisable", source)
		end
	end
)

-- Timestamp conversion
function timestampConvert(timeStamp)
	local time = getRealTime(timeStamp)

	local year = time.year + 1900
	local month = time.month + 1
	local day = time.monthday
	local hour = time.hour
	local minute = time.minute

	return "" .. hour ..":" .. minute .." - " .. month .."/" .. day .."/" .. year ..""
end

-- When the player creates a new account
addEvent("doAccountRegister", true)
addEventHandler("doAccountRegister", root,
	function (username, password1, password2, email, genderMale, genderFemale)
		if (exports.DENmysql:querySingle("SELECT username FROM accounts WHERE username=? LIMIT 1", string.lower(username))) then
			triggerClientEvent(source, "setWarningLabelText", source, "This username is already taken!", "registerWindow", 225, 0, 0)
		elseif (#exports.DENmysql:query("SELECT * FROM accounts WHERE serial=?", getPlayerSerial(source)) >= 2) then
			triggerClientEvent(source, "setWarningLabelText", source, "You can only register 2 accounts for each serial!", "registerWindow", 225, 0, 0)
		else
			if (genderFemale) then theGender = 93 else theGender = 0 end
			if (exports.DENmysql:exec("INSERT INTO accounts SET username=?, password=?, email=?, serial=?, skin=?", string.lower(username), hash("sha1", password1), email, getPlayerSerial(source), theGender)) then
				local userData = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", string.lower(username), hash("sha1", password1))
				exports.DENmysql:exec("INSERT INTO weapons SET userid=?", tonumber(userData.id))
				exports.DENmysql:exec("INSERT INTO playerstats SET userid=?", tonumber(userData.id))
				triggerClientEvent(source, "setPopupWindowVisable", source)
			end
		end
	end
)

-- When the player password changed
function onPasswordRequestCallback ()
	-- callBack functie after password is changed nothing important though
end

-- Password reset function
addEvent("doPlayerPasswordReset", true)
addEventHandler("doPlayerPasswordReset", root,
	function (email, username, newPassword)
		local userData = exports.DENmysql:querySingle("SELECT email FROM accounts WHERE username = ? LIMIT 1", string.lower(username))
		if (userData) then
			if (userData.email == "") or (userData.email == " ") then
				triggerClientEvent(source, "setWarningLabelText", source, "No email found with this account!", "passwordWindow", 225, 0, 0)
			elseif not (string.match(tostring(userData.email), "^.+@.+%.%a%a%a*%.*%a*%a*%a*"))then
				triggerClientEvent(source, "setWarningLabelText", source, "You didn't enter a valid email address!", "passwordWindow", 225, 0, 0)
			elseif not (string.lower(userData.email) == string.lower(email)) then
				triggerClientEvent(source, "setWarningLabelText", source, "The email with this account doesn't match!", "passwordWindow", 225, 0, 0)
			else
				if (exports.DENmysql:exec("UPDATE accounts SET password=? WHERE username=? AND email=?", hash("sha1", newPassword), string.lower(username), email)) then
					callRemote("http://csgmta.net/mail/password.php", onPasswordRequestCallback, username, email, newPassword)
					exports.DENdxmsg:createNewDxMessage(source, "Your password is changed and sent to your email!", 0, 225, 0)
					triggerClientEvent(source, "setWarningLabelText", source, "A new password has been sent!", "passwordWindow", 225, 0, 0)
					triggerClientEvent (source, "setLoginWindowVisable", source)
				end
			end
		else
			triggerClientEvent(source, "setWarningLabelText", source, "No account found with this name!", "passwordWindow", 225, 0, 0)
		end
	end
)

-- When the player send the login forum
addEvent("doPlayerLogin", true)
addEventHandler("doPlayerLogin", root,
	function (username, password, usernameTick, passwordTick)
		if not (exports.DENmysql:getConnection()) then
			triggerClientEvent(source,"setWarningLabelText",source,"Database is down! Please contact a developer!", "loginWindow", 255, 0, 0)
			return false
		end
		
		local accountID = false
		local idQuery = exports.DENmysql:query("SELECT id FROM accounts WHERE username=? LIMIT 1",username:lower())
		if idQuery and #idQuery == 1 then
			accountID = idQuery[1].id
		end
		if not accountID then
			triggerClientEvent(source, "setWarningLabelText", source, "Wrong username and/or password!", "loginWindow", 225, 0, 0)
			triggerClientEvent(source,"toggleLoginButton",source,true)
			return
		end
		
		-- Redundant code for old CSG system
		--[[
		if (#exports.DENmysql:query("SELECT id FROM accounts WHERE id=? AND password=? LIMIT 1", accountID, md5(password)) == 1) then
			-- If the password is a MD5 password from the old system then force the player to change it
			triggerClientEvent(source, "setWarningLabelText", source, "Unable to login, please change password first!", "loginWindow", 225, 0, 0)
			triggerClientEvent(source, "setNewPasswordWindowVisable", source) setElementData(source, "temp:UsernameData", string.lower(username)) setElementData(source, "temp:PasswordData", md5(password))
		--]]
		if (#exports.DENmysql:query("SELECT id FROM accounts WHERE id=? AND password=? LIMIT 1", accountID, hash("sha1", password)) == 1) then
			--exports.irc:outputIRC(tostring(loggingIn[username]))
			if (loggingIn[username] == nil) then
				loggingIn[username] = true --set this true to prevent it from logging in again
				--exports.irc:outputIRC(username.." login stored.")
			elseif (loggingIn[username] == true) then
				--exports.irc:outputIRC(username.." was refused login since he spammed the shit out of login.")
				return false
			else
				--exports.irc:outputIRC("Something fucked up, blame Priyen!")
				--exports.irc:outputIRC(tostring(loggingIn[username]))
			end
			
			local banData = exports.DENmysql:query("SELECT banstamp FROM bans WHERE username=? LIMIT 1", username:lower())
			if (banData and #banData == 1) then
				if (banData[1].banstamp == 0) then
					triggerClientEvent(source, "setWarningLabelText", source, "This account is Permanently Banned from the server!", "loginWindow", 225, 0, 0)
				elseif (getRealTime().timestamp < banData[1].banstamp) then
					triggerClientEvent(source, "setWarningLabelText", source, "This account is banned from the server til: "..timestampConvert(banData[1].banstamp), "loginWindow", 225, 0, 0)
				elseif (banData[1].banstamp > 0) and (getRealTime().timestamp > banData[1].banstamp) and (exports.DENmysql:exec("DELETE FROM bans WHERE account=?", username:lower())) then
					triggerClientEvent(source, "setWarningLabelText", source, "Your account is now unbanned! Try again.", "loginWindow", 0, 225, 0)
				end
			else
				removeElementData(source, "temp:UsernameData") removeElementData(source, "temp:PasswordData")
				triggerClientEvent(source, "updateAccountXMLData", source, username, password, usernameTick, passwordTick)

				local accountData = exports.DENmysql:query("SELECT * FROM accounts WHERE id=? LIMIT 1", accountID)
				local groupData = exports.DENmysql:query("SELECT groupname,grouprank,groupid FROM groups_members WHERE memberid=? LIMIT 1", accountID)
				
				for k, v in ipairs(getElementsByType("player")) do
					if (getElementData(v, "accountUserID") == accountData[1].id) then
						kickPlayer(v, "Accounts", getPlayerName(source).." has logged into your account.")
					end
				end
				
				exports.DENmysql:exec("INSERT INTO logins SET serial=?, ip=?, nickname=?, accountname=?", getPlayerSerial(source), getPlayerIP (source), getPlayerName(source), username)
				exports.DENmysql:exec("UPDATE accounts SET serial=?,IP=? WHERE id=?", getPlayerSerial(source), getPlayerIP(source), accountData[1].id)

				setPlayerTeam (source, getTeamFromName(accountData[1].team))

				setElementData(source, "accountUserID", accountID)
				setElementData(source, "tempdata.accountUserID", accountID)
				setElementData(source, "Occupation", accountData[1].occupation)
				setElementData(source, "playerAccount", accountData[1].username)
				setElementData(source, "playerEmail", accountData[1].email)
				setElementData(source, "playerIP", getPlayerIP (source))
				setElementData(source, "joinTick", getTickCount())
				setElementData(source,"playerScore",accountData[1].score)
				
				setElementData(source, "carLicence", true)
				setElementData(source, "planeLicence", true)
				setElementData(source, "bikeLicence", true)
				setElementData(source, "chopperLicence", true)
				setElementData(source, "boatLicence", true)

				if (groupData and #groupData == 1) then
					setElementData(source, "Group", groupData[1].groupname)
					setElementData(source, "GroupRank", groupData[1].grouprank)
					setElementData(source, "GroupID", tonumber(groupData[1].groupid))
				end

				if (tonumber(accountData[1].premium) < 1) then
					setElementData(source, "isPlayerPremium", false)
					setElementData(source, "Premium", "No")
					setElementData(source,"premiumType",accountData[1].premiumType)
				else
					setElementData(source, "isPlayerPremium", true)
					setElementData(source, "Premium", "Yes")
					setElementData(source,"premiumType",accountData[1].premiumType)
				end

				setElementData(source, "playTime", accountData[1].playtime)

				triggerClientEvent(source, "setAllWindowsHided", source)
				triggerClientEvent(source, "clientPlayerLogin", source, accountData[1].id, username)

				fadeCamera(source, false, 1.0, 0, 0, 0)
				setTimer(fadeCamera, 2000, 1, source, true, 1.0, 0, 0, 0)
				setTimer(createPlayerElementIntoGame, 1000, 1, source, accountData[1])
				antisaveTimers[source] = setTimer(allowSaving,10000,1,source)

				triggerEvent("onPlayerLogin", source)
				loggingIn[username] = nil
				
			end
		else
			-- If the password is wrong
			triggerClientEvent(source, "setWarningLabelText", source, "Wrong username and/or password!", "loginWindow", 225, 0, 0)
			triggerClientEvent(source, "toggleLoginButton", source, true)
		end
	end
)

function allowSaving(player)
	if (isElement(player)) then
		antisaveTimers[source] = nil
	end
end

-- Change password
addEvent("onPlayerUpdatePasswords", true)
addEventHandler("onPlayerUpdatePasswords", root,
	function (password)
		if (getElementData(source, "temp:UsernameData")) then
			if (exports.DENmysql:exec("UPDATE accounts SET password=? WHERE username=?", hash("sha1", password), getElementData(source, "temp:UsernameData"))) then
				triggerClientEvent(source, "setLoginWindowVisable", source)
				exports.DENdxmsg:createNewDxMessage(thePlayer, "Your password is changed!", 0, 225, 0)
			else
				triggerClientEvent(source, "setLoginWindowVisable", source)
				exports.DENdxmsg:createNewDxMessage(thePlayer, "We couldn't change your password try again!", 225, 0, 0)
			end
		else
			triggerClientEvent(source, "setLoginWindowVisable", source)
			exports.DENdxmsg:createNewDxMessage(thePlayer, "We couldn't change your password try again!", 225, 0, 0)
		end
	end
)

-- Spawn the player into the world
function createPlayerElementIntoGame (thePlayer, dataTable)
	if (exports.server:isPlayerLoggedIn(thePlayer)) then
		local playerID = exports.server:getPlayerAccountID(thePlayer)

		exports.DENdxmsg:createNewDxMessage(thePlayer, "Welcome back to CSG " .. getPlayerName(thePlayer) .. "!", 238, 154, 0)

		setCameraTarget(thePlayer, thePlayer)
		showChat(thePlayer, true)
		showPlayerHudComponent (thePlayer, "radar", true)
		showPlayerHudComponent (thePlayer, "area_name", true)

		if (dataTable.team == "Criminals") or (dataTable.team == "Unemployed") or (dataTable.team == "Unoccupied") then
			spawnPlayer(thePlayer, dataTable.x, dataTable.y, dataTable.z +1, dataTable.rotation, dataTable.skin, dataTable.interior, dataTable.dimension, dataTable.team)
		else
			spawnPlayer(thePlayer, dataTable.x, dataTable.y, dataTable.z +1, dataTable.rotation, dataTable.jobskin, dataTable.interior, dataTable.dimension, dataTable.team)
		end

		local CJCLOTTable = fromJSON(tostring(dataTable.cjskin))
		if CJCLOTTable then
			for theType, index in pairs(CJCLOTTable) do
				local texture, model = getClothesByTypeIndex (theType, index)
				addPedClothes (thePlayer, texture, model, theType)
			end
		end
		
		local weapons = fromJSON(dataTable.weapons)
		if (weapons) then
			for weapon, ammo in pairs(weapons) do
				if not (tonumber(weapon) == 36) and not (tonumber(weapon) == 37) and not (tonumber(weapon) == 38) and not (tonumber(weapon) == 18) then
					giveWeapon(thePlayer, tonumber(weapon), tonumber(ammo))
				end
			end
		end

		local playerStatus = exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=? LIMIT 1", playerID)
		if (playerStatus) then
			local wepSkills = fromJSON(playerStatus.weaponskills)
			if (wepSkills) then
				for skillint, valueint in pairs(wepSkills) do
					if (tonumber(valueint) > 950) then
						setPedStat (thePlayer, tonumber(skillint), 995)
					else
						setPedStat (thePlayer, tonumber(skillint), tonumber(valueint))
					end
				end
			end
		end

		if (dataTable.health == 0) then
			killPed(thePlayer)
		else
			setElementHealth(thePlayer, tonumber(dataTable.health))
		end

		exports.DENmysql:exec("UPDATE groups_members SET lastonline=? WHERE memberid=?", getRealTime().timestamp, playerID)

		setPedArmor(thePlayer, tonumber(dataTable.armor))
		setPlayerMoney(thePlayer, tonumber(dataTable.money))
		setPedFightingStyle (thePlayer, tonumber(dataTable.fightstyle))

		setElementData (thePlayer, "isPlayerLoggedin", true)
		setElementData (thePlayer, "wantedPoints", tonumber(dataTable.wanted))
		
		local jailData = exports.DENmysql:querySingle("SELECT * FROM jail WHERE userid=? LIMIT 1",dataTable.id)
		if (jailData) then
			triggerClientEvent(thePlayer, "onSetPlayerJailed", thePlayer, jailData.jailtime)
		end

		triggerEvent ("onServerPlayerLogin", thePlayer, playerID, dataTable.username)
	    exports.DENvehicles:reloadFreeVehicleMarkers(thePlayer)
	end
end

function getCSGServerVersion()
	query = exports.DENmysql:querySingle("SELECT value FROM settings WHERE settingName=? LIMIT 1", "serverVersion")
	if (query) then
		return query["value"]
	else
		return "2.1.4"
	end
end

addEvent("updatePlayerFPS", true)
addEventHandler("updatePlayerFPS", root,
	function (fps)
		if (isElement(source)) and fps then
			setElementData(source, "FPS", fps)
		end
	end
)

--[[function updatePlayerTeamToElementData()
	for k, v in ipairs(getElementsByType("player")) do
		team = getPlayerTeam(v)
		if (team ~= nil) then
			setElementData(v,"playerTeam",team)
			outputDebugString(getTeamFromName(team))
		end
	end
end
setTimer(updatePlayerTeamToElementData,2000,0)]]--

function isAllowedToSave(player)
	if (isTimer(antisaveTimers[player])) then
		return false
	else
		return true
	end
end