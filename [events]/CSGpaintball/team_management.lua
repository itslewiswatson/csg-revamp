local team1 = {} --team 1 table for players
local team2 = {} --team 2 table for players
local sorting = 0 -- Team management
local players = {}
local x1,y1,z1,rot1 = 1359.6923828125,-17.9736328125,1000.921875,273
local x2,y2,z2,rot2 = 1414.5908203125, -15.65625, 1000.9253540039,90

function splitTeam()
	for player,_ in ipairs(players) do
		if (sorting == 0) then
			setElementData(player,"team",1)
			team1[player] = true
			sorting = 1
			setElementPosition(player,x1+math.random(0.5,1),y1+math.random(0.5,1),z1+math.random(0.5,1))
			setElementRotation(player,rot1)
		else
			setElementData(player,"team",2)
			team2[player] = true
			sorting = 0
			setElementPosition(player,x2+math.random(0.5,1),y2+math.random(0.5,1),z2+math.random(0.5,1))
			setElementRotation(player,rot2)
		end
		setElementFrozen(player,true) --freeze them til the event starts
	end
end

function getWinningTeam()
	if (#team1 >= #team2) then
		return 1 --return team 1 is winning
	else
		return 2 --return team 2 is winning
	end
end

function breakTeam()
	for player,_ in pairs(team1) do
		removeElementData(player,"team")
	end
	for player,_ in pairs(team2) do
		removeElementData(player,"team")
	end
	
	--empty the caches
	team1 = {}
	team2 = {}
end

function playerOut(player,killer)
	local team = getElementData(player,"team")
	if (team ~= nil) then
		outputChatBox("You're OUT! You was tagged by "..getPlayerName(killer),player,255,0,0)
		killPed(player)
		if (team == 1) then
			team1[player] = nil
			removeElementData(player,"team")
		elseif (team == 2) then
			team2[player] = nil
			removeElementData(player,"team")
		end
		
		checkForRoundOver()
	else
		return false
	end
end

function checkForRoundOver()
	if (#team1 == 0) then
		winningTeam(2)
	elseif (#team2 == 0) then
		winningTeam(1)
	else
		return false
	end
end

function payTeam(teamID)
	if (team == 1) then
		tableTeam = team1
	elseif (team == 2) then
		tableTeam = team2
	end
	
	for player,_ in pairs(tableTeam) do
		amount = getPrizeMoney()
		givePlayerMoney(player,tonumber(amount))
		
		score = math.random(5,10)
		exports.CSGscore:givePlayerScore(player,score)
		
		outputChatBox("Winnings: $"..amount..", Score: "..score,player,0,255,0)
	end
end

function arePlayersInEM()
	if (#players >= 0) then
		return true
	else
		return false
	end
end

function cleanUp()
	for k,v in pairs(team1) do
		if (isPlayerInArena(v) == true) then
			removeFromArena(v)
		end
	end
	
	for k,v in pairs(team2) do
		if (isPlayerInArena(v) == true) then
			removeFromArena(v)
		end
	end
	team1 = {} --empty cache
	team2 = {} --empty cache
	players = {} --empty the cache
end

function isPlayerInArena(player)
	if (getElementInterior(player) == 1) and (getElementDimension(player) == 100) then
		return true
	else
		return false
	end
end

function removeFromArena(player)
	removeElementData(player,"team")
	killPed(player)
end

function addPlayer(player)
	outputDebugString("Running...")
	if (isElement(player)) then --make sure hes still exists..
		outputDebugString("Player found.")
		players[player] = true
		if (players[player] == true) then
			outputDebugString("[PA] Player was added successfully")
		else
			outputDebugString("[PA] Player failed to add!")
		end
		fadeCamera(player,false,1.0,0,0,0)
		setTimer(setElementInterior,1000,1,player,1)
		setTimer(setElementPosition,1000,1,player,1385.0400390625, -25.0361328125, 1000.9224853516)
		setTimer(setElementDimension,1000,1,player,100)
		setTimer(fadeCamera,1000,1,player,true)
	end
	--outputDebugString("Player count: "..#players)
end

function unfreezePlayers()
	for k,v in pairs(players) do
		if (isElement(v)) then
			setElementFrozen(v,false)
		end
	end
end

function checkTeamSorting()
	for k,v in pairs(players) do
		if (isElement(v)) then
			if (team1[v]) then
				return true
			elseif (team2[v]) then
				return true
			else
				return false
			end
		end
	end
end

function count()
	for k,v in ipairs(players) do
		outputChatBox("[PA] GET READY!",v,255,0,0)
		setTimer(outputChatBox,1000,1,"3",v,255,255,0)
		setTimer(outputChatBox,2000,1,"2",v,255,255,0)
		setTimer(outputChatBox,3000,1,"1",v,0,255,0)
		setTimer(unfreezePlayers,4000,1)
		setTimer(outputChatBox,4000,"GO GO GO!",v,255,0,0)
	end
end