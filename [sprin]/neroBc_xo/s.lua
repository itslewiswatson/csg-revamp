local playersPlaying = {}
local msgColor = "#FF6464"
local requestTimeout = 30
local requestCommand = "xo"
local antiRequestFlood = 60 
local acceptCommand = "accept"
local declineCommand = "decline"
local resignCommand = "resign"

function getPlayerFromPart(part)
	if part then
		for i,v in ipairs(getElementsByType"player") do
			if (((getPlayerName(v)):lower()):gsub("#%x%x%x%x%x%x","")):find(part:lower(),1,true) then
				return v
			end
		end
		return false
	end
	return false
end

requestCommand = tostring(requestCommand)
acceptCommand = tostring(acceptCommand)
declineCommand = tostring(declineCommand)
local r,g,b = getColorFromString(msgColor or "#FFFFFF")
local msgColor = tostring(msgColor)

addCommandHandler(requestCommand,
	function(player,command,toplayer)
		toplayer = getPlayerFromPart(toplayer)
		if ( getTickCount() - ( getElementData(player,"XO_lastRequest") or getTickCount() * - math.huge ) ) > antiRequestFlood * 1000 then
			if toplayer and isElement(toplayer) then
				local toplayerName = getPlayerName(toplayer)
				if toplayer ~= player then
					if not playersPlaying[toplayer] and not playersPlaying[checkExist(toplayer)] then
						if not playersPlaying[player] and not playersPlaying[checkExist(player)] then
							playersPlaying[player] = { toplayer, false } -- false means he hasn't accepted request yet
							outputChatBox("You sent a request to #ffffff"..toplayerName..msgColor.." to play X/O!",player,r,g,b,true)
							outputChatBox(getPlayerName(player)..msgColor.." wants to play X/O with you!",toplayer,r,g,b,true)
							outputChatBox("Type #ffffff/"..acceptCommand..msgColor.." or #ffffff/"..declineCommand..msgColor.." in #ffffff"..tostring(requestTimeout)..msgColor.." seconds to respond",toplayer,r,g,b,true)
							setElementData(player,"XO_lastRequest",getTickCount())
							setTimer(
								function()
									if playersPlaying[player] and not playersPlaying[player][2] then
										playersPlaying[player] = nil
										playersPlaying[toplayer] = nil
										if player then 
											outputChatBox(toplayerName..msgColor.." did not respond to your X/O request!",player,r,g,b,true)
										end
									end
								end, requestTimeout * 1000, 1
							)
						else
							outputChatBox("You are already playing or got a X/O request from someone!",player,r,g,b,true)
						end
					else
						outputChatBox(getPlayerName(toplayer)..msgColor.." is already playing a X/O match with someone!",player,r,g,b,true)
					end
				else
					outputChatBox("You can't play with yourself!",player,r,g,b,true)
				end
			else
				outputChatBox("Player not found!",player,r,g,b,true)
			end
		else
			outputChatBox("Please wait for #ffffff"..math.ceil(antiRequestFlood - ((getTickCount() - getElementData(player,"XO_lastRequest")) / 1000))..msgColor.." seconds more to request someone!",player,r,g,b,true)
		end
	end
)

addCommandHandler(declineCommand,
	function(player)
		if checkExist(player) and not playersPlaying[checkExist(player)][2] then
			local name = getPlayerName(checkExist(player))
			outputChatBox("You successfully declined the request of #ffffff"..name,player,r,g,b,true)
			outputChatBox(getPlayerName(player)..msgColor.." has declined your request!",checkExist(player),r,g,b,true)
			playersPlaying[checkExist(player)] = nil
			playersPlaying[player] = nil
		else
			outputChatBox("You never got a request!",player,r,g,b)
		end
	end
)

addCommandHandler(acceptCommand,
	function(player,command)
		if checkExist(player) then
			playersPlaying[checkExist(player)][2] = true
			playersPlaying[checkExist(player)][3] = {}
			if not playersPlaying[player] then
				playersPlaying[player] = {}
			end
			playersPlaying[player][2] = true
			playersPlaying[player][1] = checkExist(player)
			playersPlaying[player][3] = {}
			outputChatBox(getPlayerName(player)..msgColor.." and #ffffff"..getPlayerName(checkExist(player))..msgColor.." are now playing a X/O match!",root,r,g,b,true)
			outputChatBox("Type #ffffff/"..resignCommand..msgColor.." to give up!",player,r,g,b,true)
			outputChatBox("Type #ffffff/"..resignCommand..msgColor.." to give up!",checkExist(player),r,g,b,true)
			setTimer(startMatch,1500,1,player,checkExist(player))
		else
			outputChatBox("You never got a X/O request or you responded too late!",player,r,g,b,true)
		end
	end
)

function checkExist(player)
	for k,v in pairs(playersPlaying) do
		if v[1] == player then
			return k
		end
	end
	return false
end

function startMatch (player1,player2)
	if player1 and player2 then
		local rand = math.random(2)
		if rand == 1 then
			setElementData(player1,"XO_Sign","O")
			setElementData(player2,"XO_Sign","X")
		elseif rand == 2 then
			setElementData(player2,"XO_Sign","O")
			setElementData(player1,"XO_Sign","X")
		end
		triggerClientEvent(player1,"startXO",root,player2)
		triggerClientEvent(player2,"startXO",root,player1)
	end
end

addEvent("XO_submitMove",true)
addEventHandler("XO_submitMove",root,
	function(move)
		if not playersPlaying[source][3] then
			playersPlaying[source][3] = {}
			playersPlaying[playersPlaying[source][1]][3] = {}
		end
		if not playersPlaying[source][3][move] then
			playersPlaying[source][3][move] = getElementData(source,"XO_Sign")
			playersPlaying[playersPlaying[source][1]][3][move] = getElementData(source,"XO_Sign")
		end
		triggerClientEvent(playersPlaying[source][1],"receiveOpponentMove",source,move,getElementData(source,"XO_Sign"))
		if playersPlaying[source][3][1] and playersPlaying[source][3][1] == playersPlaying[source][3][2] and playersPlaying[source][3][1] == playersPlaying[source][3][3] then
			outputChatBox(getPlayerName(source)..msgColor.." has defeated #ffffff"..getPlayerName(playersPlaying[source][1])..msgColor.." in X/O!",root,r,g,b,true)
			setTimer(endGame, 3000, 1, source, playersPlaying[source][1])
			preEndGame(playersPlaying[source][1],source)
		elseif playersPlaying[source][3][4] and playersPlaying[source][3][4] == playersPlaying[source][3][5] and playersPlaying[source][3][4] == playersPlaying[source][3][6] then
			outputChatBox(getPlayerName(source)..msgColor.." has defeated #ffffff"..getPlayerName(playersPlaying[source][1])..msgColor.." in X/O!",root,r,g,b,true)
			setTimer(endGame, 3000, 1, source, playersPlaying[source][1])
			preEndGame(playersPlaying[source][1],source)
		elseif playersPlaying[source][3][7] and playersPlaying[source][3][7] == playersPlaying[source][3][8] and playersPlaying[source][3][7] == playersPlaying[source][3][9] then
			outputChatBox(getPlayerName(source)..msgColor.." has defeated #ffffff"..getPlayerName(playersPlaying[source][1])..msgColor.." in X/O!",root,r,g,b,true)
			setTimer(endGame, 3000, 1, source, playersPlaying[source][1])
			preEndGame(playersPlaying[source][1],source)
		elseif playersPlaying[source][3][1] and playersPlaying[source][3][1] == playersPlaying[source][3][4] and playersPlaying[source][3][4] == playersPlaying[source][3][7] then
			outputChatBox(getPlayerName(source)..msgColor.." has defeated #ffffff"..getPlayerName(playersPlaying[source][1])..msgColor.." in X/O!",root,r,g,b,true)
			setTimer(endGame, 3000, 1, source, playersPlaying[source][1])
			preEndGame(playersPlaying[source][1],source)
		elseif playersPlaying[source][3][2] and playersPlaying[source][3][2] == playersPlaying[source][3][5] and playersPlaying[source][3][5] == playersPlaying[source][3][8] then
			outputChatBox(getPlayerName(source)..msgColor.." has defeated #ffffff"..getPlayerName(playersPlaying[source][1])..msgColor.." in X/O!",root,r,g,b,true)
			setTimer(endGame, 3000, 1, source, playersPlaying[source][1])
			preEndGame(playersPlaying[source][1],source)
		elseif playersPlaying[source][3][3] and playersPlaying[source][3][3] == playersPlaying[source][3][6] and playersPlaying[source][3][6] == playersPlaying[source][3][9] then
			outputChatBox(getPlayerName(source)..msgColor.." has defeated #ffffff"..getPlayerName(playersPlaying[source][1])..msgColor.." in X/O!",root,r,g,b,true)
			setTimer(endGame, 3000, 1, source, playersPlaying[source][1])
			preEndGame(playersPlaying[source][1],source)
		elseif playersPlaying[source][3][3] and playersPlaying[source][3][3] == playersPlaying[source][3][5] and playersPlaying[source][3][5] == playersPlaying[source][3][7] then
			outputChatBox(getPlayerName(source)..msgColor.." has defeated #ffffff"..getPlayerName(playersPlaying[source][1])..msgColor.." in X/O!",root,r,g,b,true)
			setTimer(endGame, 3000, 1, source, playersPlaying[source][1])
			preEndGame(playersPlaying[source][1],source)
		elseif playersPlaying[source][3][1] and playersPlaying[source][3][1] == playersPlaying[source][3][5] and playersPlaying[source][3][5] == playersPlaying[source][3][9] then
			outputChatBox(getPlayerName(source)..msgColor.." has defeated #ffffff"..getPlayerName(playersPlaying[source][1])..msgColor.." in X/O!",root,r,g,b,true)
			setTimer(endGame, 3000, 1, source, playersPlaying[source][1])
			preEndGame(playersPlaying[source][1],source)
		elseif playersPlaying[source][3][1] and
			playersPlaying[source][3][2] and
			playersPlaying[source][3][3] and
			playersPlaying[source][3][4] and
			playersPlaying[source][3][5] and
			playersPlaying[source][3][6] and
			playersPlaying[source][3][7] and
			playersPlaying[source][3][8] and
			playersPlaying[source][3][9] then
			outputChatBox("Your match with #ffffff"..getPlayerName(playersPlaying[source][1])..msgColor.." resulted in a tie!",source,r,g,b,true)
			outputChatBox("Your match with #ffffff"..getPlayerName(source)..msgColor.." resulted in a tie!",playersPlaying[source][1],r,g,b,true)
			setTimer(preEndGame, 2000, 1, playersPlaying[source][1],source)
			setTimer(endGame, 1500, 1, source, playersPlaying[source][1])
		end
	end
)

function endGame(p1,p2)
	triggerClientEvent(p1,"XOEnded",p1)
	if p2 then
		triggerClientEvent(p2,"XOEnded",p2)
	end
end

function preEndGame(p1,p2)
	playersPlaying[p1] = nil
	setElementData(p1, "XO_Sign",nil)
	if p2 then
		playersPlaying[p2] = nil
		setElementData(p2,"XO_Sign",nil)
	end
end

addEventHandler("onPlayerQuit",root,
	function()
		if checkExist(source) and playersPlaying[checkExist(source)][2] then
			outputChatBox("Your opponent has left the game! You win!",checkExist(source),r,g,b,true)
			setTimer(preEndGame, 100, 1, checkExist(source),source)
			setTimer(endGame, 50, 1, checkExist(source),source)
		end
		if playersPlaying[source] then
			playersPlaying[source] = nil
		end
	end
)

addCommandHandler(resignCommand,
	function(player)
		if playersPlaying[player] and playersPlaying[player][2] and checkExist(player) and playersPlaying[checkExist(player)][2] then
			outputChatBox(getPlayerName(player)..msgColor.." has resigned! You win! ",checkExist(player),r,g,b,true)
			outputChatBox("You resigned. You lose.",player,r,g,b,true)
			setTimer(preEndGame, 100, 1, checkExist(player),player)
			setTimer(endGame, 50, 1, checkExist(player),player)
		else
			outputChatBox("You aren't playing X/O.",player,r,g,b,true)
		end
	end
)