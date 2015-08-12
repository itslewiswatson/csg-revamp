------------------------------
----- Advertising system -----
------------------------------
antiSpam = {}

function advertising ( thePlayer, amount, ...  )

	local message = table.concat( {...}, " " )
	local money = getPlayerMoney(thePlayer) 

	if message == "" then
		exports.DENdxmsg:createNewDxMessage(thePlayer, "You didnt enter a message!", 200, 0, 0)
	elseif isTimer(antiSpam[thePlayer]) then
		exports.DENdxmsg:createNewDxMessage(thePlayer, "Wait 60 seconds before sending a new advert message.", 200, 0, 0)
	elseif (money >= 500) then
		takePlayerMoney ( thePlayer, tonumber(500) )
		outputChatBox("(AD) ".. getPlayerName(thePlayer)..": "..removeHEX(message), root, 225, 0, 0)
		exports.DENdxmsg:createNewDxMessage(root, "(AD) ".. getPlayerName(thePlayer)..": "..removeHEX(message), 225, 0, 0)
		antiSpam[thePlayer] = setTimer(function(thePlayer) antiSpam[thePlayer] = nil end, 60000, 1, thePlayer) 
	elseif (money < 500) then
			exports.DENdxmsg:createNewDxMessage(thePlayer, "You don't have enough money to make an advertisement", 200, 0, 0)
	end
end
addCommandHandler ( "advert", advertising )

function removeHEX(message)
	return string.gsub(message,"#%x%x%x%x%x%x", "")
end

----------------------------------
----- Weakening rhino system -----
----------------------------------
addEvent ("healthchange", true)
function healthchange (a)
setElementHealth(source, a)
end
addEventHandler("healthchange", root, healthchange)