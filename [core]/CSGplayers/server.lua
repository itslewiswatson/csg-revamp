players = {}
local playerCount = 0

function getPlayers()
	if (players) then
		return players
	else
		return false
	end
end

function refreshTable()
	players = {} --empty the table
	for k,v in ipairs(getElementsByType("player")) do
		name = getPlayerName(v)
		occupation = getElementData(v,"Occupation")
		if (occupation == false) then
			occupation = "None"
		end
		money = exports.server:convertNumber(getPlayerMoney(v))
		playtime = getElementData(v,"playTime")
		if (playtime == false) then
			playtime = 0
		end
		group = getElementData(v,"Group")
		if (group == false) then
			group = "None"
		end
		ping = getPlayerPing(v)
		team = getPlayerTeam(v)
		if (team) then
			r,g,b = getTeamColor(team)
		else
			r,g,b = 100,100,100
		end
		if (getPlayerTeam(v) ~= nil) then
			if (isElement(team)) and (getTeamName(team) == "Staff") then
				r,g,b = 200,200,200
			end
		end
		fps = exports.server:getPlayerFPS(v)
		city = exports.server:getPlayChatZone(v)
		sortID = getSortIDByTeam(v)
		if not (city) then
			city = "N/A"
		end
		table.insert(players,{name,occupation,money,math.floor(playtime/60),group,ping,r,g,b,fps,city,sortID})
	end
	
	table.sort(players,function(a,b) return a[12] < b[12] end)
end
addEventHandler("onResourceStart",resourceRoot,refreshTable)
setTimer(refreshTable,math.random(5000,10000),0)

function getSortIDByTeam(player)
	if (isElement(player)) then
		local team = getPlayerTeam(player)
		if not (team) then
			return 0
		end
		_name = getTeamName(team)
	end
	
	if (_name == "Staff") then
		return 1
	elseif (_name == "Unemployed") then
		return 2
	elseif (_name == "Unoccupied") then
		return 3
	elseif (_name == "Civilian Workers") then
		return 4
	elseif (_name == "Police") then
		return 5
	elseif (_name == "SWAT") then
		return 6
	elseif (_name == "Military Forces") then
		return 7
	elseif (_name == "Government Agency") then
		return 8
	elseif (_name == "Paramedics") then
		return 9
	elseif (_name == "Firefighters") then
		return 10
	elseif (_name == "The Smurfs") then
		return 11
	elseif (_name == "Criminals") then
		return 12
	else
		return 0
	end
end

--[[function getServerInformation()
	if (data) then
		return data
	else
		return false
	end
end

function updateServerInformation()
	data = {}
	gamemode = getGameType()
	
	local playerCount
	for k,v in ipairs(getElementsByType("player")) do
		playerCount = playerCount + 1
	end
	
	local staff
	for k,v in ipairs(getElementsByType("player")) do
		if (exports.CSGstaff:isPlayerStaff(v)) then
			staff = staff + 1
		end
	end
	
	table.insert(data,{gamemode,playerCount,staff})
end
setTimer(updateServerInformation,5000,0)

function getAllPlayers()
	return playerCount
end
]]--
function getVersion()
	return "2.3"
end