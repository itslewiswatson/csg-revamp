local saaf_ranks = {
	[0]={name="Recruit", kills=0, skin=121},
	[1]={name="Private", kills=50, skin=73},
	[2]={name="Corporal", kills=150, skin=179},
	[3]={name="Sergeant", kills=250, skin=277},
	[4]={name="Lieutenant", kills=350, skin=287},
	[5]={name="Captain", kills=450, skin=287},
	[6]={name="Major", kills=550, skin=287},
	[7]={name="Lieutenant Colonel", kills=650, skin=312},
	[8]={name="Colonel", kills=750, skin=288},
	[9]={name="General", kills=850, skin=288},
}
local saafMarker = createMarker(2743.71240, -2445.84570, 12.64844, "cylinder", 2, 0, 159, 175)
local insurgentMarker = createMarker(2747.42896, -2445.97949, 12.64844, "cylinder", 2, 255, 122, 0)
local SAAF = createTeam("SAAF", 0, 159, 175)
local Insurgents = createTeam("Insurgents", 255, 122, 0)
setElementData(saafMarker,"markerName","SAAF War")
setElementData(insurgentMarker,"markerName","Insurgent War")

local weapon_shops  = {
	{x=393.52923583984, y=607.43273925781, z=54.470668792725},
	{x=387.56024169922, y=607.36505126953, z=54.470668792725},
	{x=381.06958007813, y=607.29901123047, z=54.470668792725},
	{x=151.5721282959, y=357.74569702148, z=55.512874603271},
	{x=151.85247802734, y=353.69659423828, z=55.512874603271},
	{x=152.31819152832, y=349.88452148438, z=55.512874603271},
}

local weapons = {
	[22] = 5,
	[23] = 7,
	[24] = 10,
	[25] = 12,
	[27] = 20,
	[28] = 24,
	[29] = 32,
	[30] = 50,
}

local leave_markers = {
	{x=369.57730102539, y=606.79632568359, z=54.472103118896},
	{x=163.12678527832, y=349.93124389648, z=55.505081176758},
}

local teamSpawns = {
	["SAAF"] = {393.06225585938, 593.82287597656, 54.462860107422},
	["Insurgents"] = {158.43919372559, 369.25064086914, 55.512874603271},
}

local players = {}
players["SAAF"] = {}
players["Insurgents"] = {}

local hour = 3600000
local game = {}

function countPlayersInGame(teamName)
	if players[teamName] then
		return tonumber(#players[teamName])
	else
		return 0
	end
end

function removePlayerFromTeam(teamName, thePlayer)
	for index, player in pairs(players[teamName]) do
		if (player == thePlayer) then
			table.remove(players[teamName], index)
		end
	end
end

addEventHandler("onResourceStart",resourceRoot,
function ()
	executeSQLCreateTable("saaf_system", "accountName STRING, accountRank STRING, accountLevel INT, accountPoints INT, accountKills INT")
	for index, pos in pairs(weapon_shops) do
		local marker = createMarker(pos.x, pos.y, pos.z-1, "cylinder", 2, 0, 255, 0, 120)
		setElementData(marker,"markerName","Weapons Shop")
		setElementDimension(marker, 2)
		addEventHandler("onMarkerHit",marker,onWeaponShopMarkerHit)
	end
	for index, pos in pairs(leave_markers) do
		local marker = createMarker(pos.x, pos.y, pos.z-1, "cylinder", 2, 255, 100, 0, 120)
		setElementDimension(marker, 2)
		setElementData(marker,"markerName","Leave War")
		addEventHandler("onMarkerHit",marker,onLeaveMarkerHit)
	end
	if getElementByID("saafTime") then destroyElement(getElementByID("saafTime")) end
	saafTime = createElement("saafTime", "saafTime")
	setGameState(false, true)
end)

function setGameState(state, skip)
	game["running"] = state
	if (state) then
		if isTimer(game["timer_round"]) then killTimer(game["timer_round"]) end
		if isTimer(game["timer_round_update"]) then killTimer(game["timer_round_update"]) end
		game["timer_round"] = setTimer(setGameState,tonumber(hour),1,false,false)
		game["timer_round_update"] = setTimer(function ()
			if isTimer(game["timer_round"]) then
				setElementData(saafTime,"timeLeft",tostring(getTimerDetails(game["timer_round"])),true)
			end
		end, 1000, 0)
		exports["(CSG)Info"]:sendGlobalMessage("Announce: SAAF vs Insurgents war has started, the round will end in one hour.",0,255,0)
	else
		if (not skip) then
		exports["(CSG)Info"]:sendGlobalMessage("Announce: SAAF vs Insurgents war is over, the round will start again in 6 hours.",0,255,0)
		for index, player in pairs(getElementsByType("player")) do
			if getPlayerTeam(player) then
				local teamName = getTeamName(getPlayerTeam(player))
				if (teamName == "SAAF" or teamName == "Insurgents") then
					if getElementDimension(player) == 2 then
						setElementPosition(player, 2745.5632324219, -2449.9165039063, 14.6484375)
						setElementDimension(player, 0)
						showPlayerHudComponent (player, "radar", true )
						removePlayerFromTeam(teamName, player)
						local account = getPlayerAccount(player)
						if (account and not isGuestAccount(account)) then
							local accountName = getAccountName(account)
							local stats = exports["(CSG)Skills"]:getPlayerSkillsData(accountName, "mac")
							setPedStat(player, 75, tonumber(stats))
							end
						end
					end
				end
			end		
		end
		if isTimer(game["timer_start"]) then killTimer(game["timer_start"]) end
		if isTimer(game["timer_start_update"]) then killTimer(game["timer_start_update"]) end
		game["timer_start"] = setTimer(setGameState,tonumber(hour)*0.001,1,true)
		setElementData(saafTime,"startTimeLeft",tostring(getTimerDetails(game["timer_start"])),true)
		game["timer_start_update"] = setTimer(function ()
		if isTimer(game["timer_start"]) then
				setElementData(saafTime,"startTimeLeft",tostring(getTimerDetails(game["timer_start"])),true)
			end
		end, 1000, 0)
	end
end

addEventHandler("onMarkerHit",root,
function (hitPlayer, dim)
if (not hitPlayer) then return end
if (getElementType(hitPlayer) ~= "player") then return end
if (not getPlayerTeam(hitPlayer)) then return end
local team = getPlayerTeam(hitPlayer)
	if (source == saafMarker) then
		if (not dim) then return end
		if isPedInVehicle(hitPlayer) then return end
		if (not team) then return end
		if (getTeamName(team) == "SAAF") then
			setPedStat(hitPlayer, 75, 0)
			table.insert(players["SAAF"], hitPlayer)
			setElementDimension(hitPlayer, 2)
			setElementPosition(hitPlayer, unpack(teamSpawns["SAAF"]))
			showPlayerHudComponent (hitPlayer, "radar", false )
		end
	elseif (source == insurgentMarker) then
		if (not dim) then return end
		if isPedInVehicle(hitPlayer) then return end
		if (not team) then return end
		if (getTeamName(team) == "Insurgents") then
			setPedStat(hitPlayer, 75, 0)
			table.insert(players["Insurgents"], hitPlayer)
			setElementDimension(hitPlayer, 2)
			showPlayerHudComponent (hitPlayer, "radar", false )
			setElementPosition(hitPlayer, unpack(teamSpawns["Insurgents"]))
		end
	end
end)

addEventHandler("onResourceStop",resourceRoot,
function ()
	for index, player in pairs(getElementsByType("player")) do
		if getPlayerTeam(player) then
			local teamName = getTeamName(getPlayerTeam(player))
			if (teamName == "SAAF" or teamName == "Insurgents") then
				if getElementDimension(player) == 2 then
				setElementPosition(player, 2745.5632324219, -2449.9165039063, 14.6484375)
				setElementDimension(player, 0)
				showPlayerHudComponent (player, "radar", true )
				removePlayerFromTeam(teamName, player)
				local account = getPlayerAccount(player)
				if (account and not isGuestAccount(account)) then
					local accountName = getAccountName(account)
					local stats = exports["(CSG)Skills"]:getPlayerSkillsData(accountName, "mac")
					setPedStat(player, 75, tonumber(stats))
					end
				end
			end
		end
	end
end)

function onWeaponShopMarkerHit(hitPlayer, dim)
	if (not dim) then return end
	if getPlayerTeam(hitPlayer) then
		local teamName = getTeamName(getPlayerTeam(hitPlayer))
		if (teamName == "SAAF" or teamName == "Insurgents") then
			triggerClientEvent(hitPlayer,"weaponShop:show",hitPlayer,weapons,getPlayerPoints(hitPlayer))
		end
	end
end

function onLeaveMarkerHit(hitPlayer, dim)
	if (not dim) then return end
	if getPlayerTeam(hitPlayer) then
		local teamName = getTeamName(getPlayerTeam(hitPlayer))
		if (teamName == "SAAF" or teamName == "Insurgents") then
			fadeCamera(hitPlayer, false)
			setTimer(setElementPosition,2000,1,hitPlayer, 2745.5632324219, -2449.9165039063, 14.6484375)
			setTimer(fadeCamera,2000,1,hitPlayer,true)
			setTimer(setElementDimension,2000,1,hitPlayer, 0)
			showPlayerHudComponent (hitPlayer, "radar", true )
			removePlayerFromTeam(teamName, hitPlayer)
			local account = getPlayerAccount(hitPlayer)
			if (account and not isGuestAccount(account)) then
				local accountName = getAccountName(account)
				local stats = exports["(CSG)Skills"]:getPlayerSkillsData(accountName, "mac")
				setPedStat(hitPlayer, 75, tonumber(stats))
			end
		end
	end	
end

addEventHandler("onPlayerLogout",root,
function (prev)
	if getPlayerTeam(source) then
		local teamName = getTeamName(getPlayerTeam(source))
		if (teamName == "SAAF" or teamName == "Insurgents") then
		if getElementDimension(source) ~= 2 then return end
		removePlayerFromTeam(teamName, source)
		setElementPosition(source, 2745.5632324219, -2449.9165039063, 14.6484375)
		setElementDimension(source, 0)
		setTimer(setAccountData,200,1,prev,"WWRPG.playerX",2745.5632324219)
		setTimer(setAccountData,200,1,prev,"WWRPG.playerY",-2449.9165039063)
		setTimer(setAccountData,200,1,prev,"WWRPG.playerZ",14.6484375)
		setTimer(setAccountData,200,1,prev,"WWRPG.playerDim",0)
		end
	end
end)

addEventHandler("onPlayerQuit",root,
function ()
	if getPlayerTeam(source) then
	local prev = getPlayerAccount(source)
		local teamName = getTeamName(getPlayerTeam(source))
		if (teamName == "SAAF" or teamName == "Insurgents") then
		if getElementDimension(source) ~= 2 then return end
		removePlayerFromTeam(teamName, source)
		setElementPosition(source, 2745.5632324219, -2449.9165039063, 14.6484375)
		setElementDimension(source, 0)
		setTimer(setAccountData,200,1,prev,"WWRPG.playerX",2745.5632324219)
		setTimer(setAccountData,200,1,prev,"WWRPG.playerY",-2449.9165039063)
		setTimer(setAccountData,200,1,prev,"WWRPG.playerZ",14.6484375)
		setTimer(setAccountData,200,1,prev,"WWRPG.playerDim",0)
		end
	end
end)

function isPlayerInSAAF(player)
local account = getPlayerAccount(player)
if not account or isGuestAccount(account) then return false end
local accountName = getAccountName(account)
	local check = executeSQLSelect ( "saaf_system", "*", "accountName = '" .. tostring(accountName) .. "'" )
	if ( type( check ) == "table" and #check == 0 ) or not check then	
		return false
	else
		return true
	end
end

function addPlayerToSAAF(player)
local account = getPlayerAccount(player)
if not account or isGuestAccount(account) then return false end
local accountName = getAccountName(account)
	if not isPlayerInSAAF(player) then
		executeSQLInsert ( "saaf_system", "'".. tostring(accountName) .."','Recruit','0','0','0'" )
		return true
	else
		return false
	end
end

function getPlayerPoints(player)
local account = getPlayerAccount(player)
if not account or isGuestAccount(account) then return false end
local accountName = getAccountName(account)
	local data = executeSQLQuery("SELECT * FROM saaf_system WHERE accountName='".. tostring(accountName) .."'")
	return tonumber(data[1]["accountPoints"]), tonumber(data[1]["accountKills"])
end

function setPlayerPoints(player, points, kills)
local account = getPlayerAccount(player)
if not account or isGuestAccount(account) then return false end
local accountName = getAccountName(account)
if isPlayerInSAAF(player) then
	if executeSQLUpdate("saaf_system", "accountPoints = '".. tonumber(points) .."', accountKills = '".. tonumber(kills) .."'", "accountName = '".. tostring(accountName) .."'") then
		return true
	else
		return false
		end
	end
end

function getPlayerRank(player)
local account = getPlayerAccount(player)
if not account or isGuestAccount(account) then return false end
local accountName = getAccountName(account)
	if isPlayerInSAAF(player) then
		local data = executeSQLQuery("SELECT * FROM saaf_system WHERE accountName='".. tostring(accountName) .."'")
		return tostring(data[1]["accountRank"]), tonumber(data[1]["accountLevel"])
	end
end

function setPlayerRank(player, rank, level)
local account = getPlayerAccount(player)
if not account or isGuestAccount(account) then return false end
local accountName = getAccountName(account)
if isPlayerInSAAF(player) then
	if executeSQLUpdate("saaf_system", "accountRank = '".. tostring(rank) .."', accountLevel = '".. tonumber(level) .."'", "accountName = '".. tostring(accountName) .."'") then
		return true
	else
		return false
		end
	end
end

addEvent("onPlayerGetJob",true)
addEventHandler("onPlayerGetJob",root,
function (player, team, job)
	if (team == "SAAF" or team == "Insurgents") then
	if not isPlayerInSAAF(player) then
		addPlayerToSAAF(player)
	end
	local rank, level = getPlayerRank(player)
	exports["(CSG)Jobs"]:setPlayerJob(player, rank)
	local account = getPlayerAccount(player)
	setAccountData(account,"job",rank)
	setAccountData(account,"jobSkin",tonumber(saaf_ranks[level].skin))
	if not getAccountData(account,"tempSkin") then
		setAccountData(account,"tempSkin",tostring(getElementModel(player)))
	end
	setTimer(setElementModel,2000,1,player,tonumber(saaf_ranks[level].skin))
	end
end)

addEventHandler( "onPlayerWasted", root,
function (_,killer)
if (killer and getElementType(killer) == "player") then
	if getPlayerTeam(killer) then
		local teamName = getTeamName(getPlayerTeam(killer))
		if (teamName == "SAAF" or teamName == "Insurgents") then
			if getElementDimension(killer) ~= 2 then return end
			givePlayerMoney(killer, 100)
			exports["(CSG)Info"]:sendMessage(killer,"You killed ".. tostring(getPlayerName(source)) .." ( + $100 & 1 point)",255,100,0)
			local points, kills = getPlayerPoints(killer)
			local _,level = getPlayerRank(killer)
			setPlayerPoints(killer, points+1, kills+1)
			exports["(CSG)PoliceDatabase"]:resetPlayerWantedOffences(killer)
			if saaf_ranks[level] and tonumber(kills+1) >= tonumber(saaf_ranks[level+1].kills) then
				local newLevel = level +1
				setPlayerRank(killer, saaf_ranks[newLevel].name, newLevel)
				exports["(CSG)Jobs"]:setPlayerJob(killer, tostring(saaf_ranks[newLevel].name))
				setElementModel(killer, tonumber(saaf_ranks[newLevel].skin))
				setAccountData(getPlayerAccount(killer),"job",tostring(saaf_ranks[newLevel].name))
				setAccountData(getPlayerAccount(killer),"jobSkin",tonumber(saaf_ranks[newLevel].skin))
				exports["(CSG)Info"]:sendMessage(killer, "Rank: You have been promoted to ".. tostring(saaf_ranks[newLevel].name) .." with ".. tostring(kills+1) .." kills, congratulations!",0,255,0)
				end
			end
		end
	if (source and getPlayerTeam(source) and getTeamName(getPlayerTeam(source)) == "SAAF" or getTeamName(getPlayerTeam(source)) == "Insurgents") then
		if getElementDimension(source) ~= 2 then return end
		if getPlayerMoney(source) <= 200 then
			fadeCamera(source, false)
			setTimer(setElementPosition,2000,1,source, 2745.5632324219, -2449.9165039063, 14.6484375)
			setTimer(fadeCamera,5000,1,source,true)
			setTimer(setElementDimension,5000,1,source, 0)
			showPlayerHudComponent (source, "radar", true )
			removePlayerFromTeam(getTeamName(getPlayerTeam(source)), source)
		elseif getPlayerMoney(source) >= 200 then
			exports["(CSG)Info"]:sendMessage(source,"You got killed by ".. tostring(getPlayerName(killer)) .." ( - $150 )",255,0,0)
			local teamName = getTeamName(getPlayerTeam(source))
			local x, y, z = getTeamSpawn(teamName)
			fadeCamera(source, false)
			setTimer(setElementPosition,5000,1,source, x, y, z)
			setTimer(fadeCamera,5000,1,source,true)
			setTimer(setElementDimension,5000,1,source, 2)
			takePlayerMoney(source, 150)
			end
		end
	end
end)

addEvent("weaponShop:buy",true)
addEventHandler("weaponShop:buy",root,
function (weaponName)
	local model = getWeaponIDFromName(weaponName)
	if weapons[model] then
		local price = tonumber(weapons[model])
		if getPlayerPoints(source) >= price then
			giveWeapon(source, model, 1000)
			exports["(CSG)Info"]:sendMessage(source,"Weapon shop: You have bought a ".. tostring(weaponName) .." for ".. tostring(price) .." points.",0,255,0)
			local points, kills = getPlayerPoints(source)
			setPlayerPoints(source, points-price, kills)
			triggerClientEvent(source,"weaponShop:show",source,weapons,getPlayerPoints(source))
		else
			exports["(CSG)Info"]:sendMessage(source,"Weapon shop: You don't have ".. tostring(price) .." points to buy this weapon.",255,0,0)
		end
	end
end)

function getTeamSpawn(teamName)
	return unpack(teamSpawns[teamName])
end

addEvent("respawnPlayer",true)
addEventHandler("respawnPlayer",root,
function ()
	local teamName = getTeamName(getPlayerTeam(source))
	local x, y, z = getTeamSpawn(teamName)
	fadeCamera(source, false)
	setTimer(setElementPosition,1000,1,source, x, y, z)
	setTimer(fadeCamera,1000,1,source,true)
	setTimer(setElementData,1000,1,source,"respawning",false)
	setTimer(setElementFrozen,1000,1,source,false)
	exports["(CSG)Info"]:sendMessage(source,"You have been respawned by System.",255,0,0)
end)

addCommandHandler("scores",
function (thePlayer)
	if not getPlayerTeam(thePlayer) then return end
	local teamName = getTeamName(getPlayerTeam(thePlayer))
	if (teamName == "SAAF" or teamName == "Insurgents") then
		if getElementDimension(thePlayer) ~= 2 then return end
		local query = executeSQLQuery("SELECT * FROM saaf_system")
		local points, kills = getPlayerPoints(thePlayer)
		local rank, level = getPlayerRank(thePlayer)
		local stats = {["stats_rank"]=rank, ["stats_points"]=points, ["stats_kills"]=kills, ["stats_promotion"]=tonumber(saaf_ranks[level+1].kills)}
		triggerClientEvent(thePlayer,"scores:showPanel",thePlayer,stats,query)
	end
end)

function convertTime(ms)
    local min = math.floor ( ms/60000 )
    local sec = math.floor( (ms/1000)%60 )
    return min, sec
end