local time = get("timelimit") --define the default time limit
local ff = get("friendlyfire") or true --define the friendly fire setting
local earn = get("default_earn") or 50000 --define the default earning
local isPaintballOnline = false
local isPaintballRunning = false

local hits = {}

function startRound(player)
	if (exports.CSGstaff:isPlayerEventManager(player) == true) then --make sure player is EM
		checkTeamSorting() --make sure players are in teams
		outputChatBox("[PA] Round Started!",root,0,255,0)
		count()
		if (isTimer(roundTimer)) then
			killTimer(roundTimer) --kill any existing timers
		end
		roundTimer = setTimer(endRound,time,1,false) --start new one
		isPaintballRunning = true
	else
		return false --prevent players from using this
	end
end
addCommandHandler("pa:start",startRound)

function endRound(forced)
	outputDebugString("Running...")
	if (forced == true) then --check see if it was force ending
		outputDebugString("Forced was used.")
		outputChatBox("[PA] Event has ended!",root,255,0,0)
		if (isTimer(roundTimer)) then
			killTimer(roundTimer) --kill any existing timers
			outputDebugString("Timers killed.")
		end
		return true --end here
	elseif (forced == false) then
		outputDebugString("Force was not used!")
		winTeam = getWinningTeam() --get winning team (team_management.lua)
		if (winTeam == 1) then
			winningTeam = 1
		else
			winningTeam = 2
		end
		outputChatBox("[PA] Team "..winningTeam.." won!",root,0,255,0)
		payTeam(winningTeam)
		isPaintballOnline = false
		isPaintballRunning = false
	end
	cleanUp() --kills all players
end
addCommandHandler("pa:end",function() endRound(true) end)

function prepRound(player,cmd)
	outputDebugString("[PA] Running...",0,0,255,0)
	if (exports.CSGstaff:isPlayerEventManager(player) == true) then
		outputChatBox("[PA] Paintball match is about to start...",root,0,255,0)
		isPaintballOnline = true
		isPaintballRunning = false
	else
		return false
	end
end
addCommandHandler("pa:prepair",prepRound)

function setSetting(player,cmd,setting,value)
	if (setting == "time") then
		time = (value*1000)
	elseif (setting == "ff") then
		ff = value
	elseif (setting == "money" or "earn") then
		earn = value
	else
		outputChatBox("Wrong setting name (time, ff, money or earn)",player,255,0,0)
		return false
	end
end
addCommandHandler("pa:setting",setSetting)

function playerHit(player)
	if (isElement(player)) and (isElement(source)) then
		if (hits[player] == nil) then
			hits[player] = 1
		else
			hits[player] = hits[player] + 1
		end
		
		if (hits[player] == 3) then
			playerOut(player,source)
		end
	else
		return false --players aren't on o_O
	end
end
addEvent("paintball:hit",true)
addEventHandler("paintball:hit",root,playerHit)

function getPrizeMoney()
	return earn
end

function winningTeam(team)
	if (team == 1) then
		outputChatBox("[PA] Team 1 won!",root,0,255,0)
		payTeam(1)
	elseif (team == 2) then
		outputChatBox("[PA] Team 2 won!",root,0,255,0)
		payTeam(2)
	end
	endRound(true)
end

function joinPaintball(player)
	if (isElement(player)) then
		if not (exports.CSGstaff:isPlayerStaff(player)) then
			outputChatBox("This is currently available for staff only!",player,255,0,0)
			return false
		end
		if (isPaintballOnline == true) and (isPaintballRunning == false) then
			addPlayer(player)
		else
			outputChatBox("Paintball Event is not available!",player,255,0,0)
			return false
		end
	else
		return false
	end
end
addCommandHandler("pa:join",joinPaintball)