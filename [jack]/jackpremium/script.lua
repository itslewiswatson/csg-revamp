local commandLimit = {}

function prankThePlayer(player,cmd,...)
	if (player) and (isElement(player)) then
		if (commandLimit[getPlayerSerial(player)]) and (commandLimit[getPlayerSerial(player)] == 1) then return end
		outputChatBox("[PREMIUM] Processing premium hack...",player,255,0,0)
		outputChatBox("[PREMIUM] Attempting to access database...",player,255,0,0)
		outputChatBox("[PREMIUM] Access successful. Collecting data...",player,255,0,0)
		outputChatBox("[PREMIUM] Data found, account id: "..exports.server:getPlayerAccountID(player),player,255,0,0)
		outputChatBox("[PREMIUM] Generating session ID...",player,255,0,0)
		outputChatBox("[PREMIUM] Done. URL: http://csgmta.net/premium/hack.php?id="..math.random(100,10000),player,255,0,0)
		commandLimit[getPlayerSerial(player)] = 1
	end
end
addCommandHandler("premiumhack",prankThePlayer)