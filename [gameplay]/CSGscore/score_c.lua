function setPlayerScore(player,score)
	if (player) and (score) then
		triggerServerEvent("cSetPlayerScore",player,player,score)
	end
end

function givePlayerScore(player,score)
	if (player) and (score) then
		triggerServerEvent("cGivePlayerScore",player,player,score)
	end
end

function takePlayerScore(player,score)
	if (player) and (score) then
		triggerServerEvent("cGivePlayerScore",player,player,score)
	end
end

function resetPlayerScore(player)
	if (player) then
		triggerServerEvent("cResetPlayerScore",player,player)
	end
end
