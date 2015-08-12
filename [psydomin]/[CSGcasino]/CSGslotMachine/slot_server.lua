function takeBetMoney (bet)
	if getPlayerMoney(source) >= bet then triggerClientEvent("slot:continue", source) 
	else exports.DENdxmsg:createNewDxMessage(source, "You don't have that amount of money!", 255, 0, 0) 
	return end
	
	takePlayerMoney(source, bet)

end
addEvent("slot:takeBetMoney",true)
addEventHandler("slot:takeBetMoney",root, takeBetMoney)

function givePrizeMoney (bet, multiplier)
	givePlayerMoney(source, bet*multiplier)
end
addEvent("slot:givePrizeMoney",true)
addEventHandler("slot:givePrizeMoney",root, givePrizeMoney)
