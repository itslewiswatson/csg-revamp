
addEventHandler("onPlayerWasted",root,function(_,k)
	local am = exports.DENstats:getPlayerAccountData(source,"deaths")
	if am==nil or am==false then am=0 end
	am=am+1
	exports.DENstats:setPlayerAccountData(source,"deaths",am)
	if (k) and isElement(k) then
		local kills = exports.DENstats:getPlayerAccountData(k,"kills")
		if kills == nil or kills==false then kills=0 end
		exports.DENstats:setPlayerAccountData(k,"kills",kills+1)
	end
end)
