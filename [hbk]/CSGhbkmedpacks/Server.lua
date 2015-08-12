addEvent("givekitsmoney",true)
addEventHandler("givekitsmoney",root,
function()
	local kitMoney = getPlayerMoney(source)
	local kits = exports.DENstats:getPlayerAccountData(source,"mk")
	if (kitMoney >= 850) then
		if (kits < 0) then
			exports.DENstats:setPlayerAccountData(source,"mk",0)
			kits = 0
		end

		if (kits >= 10) then
			exports.DENdxmsg:createNewDxMessage(source,"You have too many medkits!",255,0,0)
			return false
		end

		exports.DENstats:setPlayerAccountData(source,"mk",kits+1)
		takePlayerMoney(source,850)
		fadeCamera(source,false,1)
		setTimer(fadeCamera,500,1,source,true,1)
		triggerClientEvent(source,"CSGmedkitsbought",source)
	else
		exports.DENdxmsg:createNewDxMessage(source,"You don't have $850!",255,0,0)
		return false
	end
end)

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	triggerClientEvent(source,"recMK",source,exports.DENstats:getPlayerAccountData(source,"mk"))
end)

addEvent("usedMK",true)
addEventHandler("usedMK",root,function()
	exports.DENstats:setPlayerAccountData(source,"mk",exports.DENstats:getPlayerAccountData(source,"mk")-1)
end)

setTimer(function()
	for k,source in pairs(getElementsByType("player")) do
		triggerClientEvent(source,"recMK",source,exports.DENstats:getPlayerAccountData(source,"mk"))
	end
end,5000,1)

addEvent("usedFM",true)
addEventHandler("usedFM",root,function()
setElementFrozen(source, true)
exports.DENdxmsg:createNewDxMessage(source,"You have been Frozen to use medic kit for 2sec",255,255,255)
setTimer(setElementFrozen, 2000, 1, source, false)
end )
