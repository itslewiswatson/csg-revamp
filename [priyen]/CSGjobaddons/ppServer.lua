local statName = "ironminerstat"
local rankStat = "ironminer"
local nameToI = {
	["Times deposited rocks"] = 1,
	["Money earned in total"] = 2,
	["Kg of rocks deposited"] = 3,
	["Kg of rocks mined"] = 4,
}
addEvent("CSGiron.setDefault",true)
addEventHandler("CSGiron.setDefault",root,function()
		local t = {}
		for i=1,#nameToI do t[i]=0 end
		exports.DENstats:setPlayerAccountData(source,statName,toJSON(t),true)
end)

setTimer(function()
	for k,source in pairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(source) then
			triggerClientEvent(source,"CSGironRecData",source,nil)
		end
	end
end,5000,1)

function CSGironSetStat(stat,rankPTS)
	--[[if (source) then p=source end
	if (p) then
		if isElement(p) == false then
			if isElement(source) then p = source end
		end
	end
	if (bool) then
		if bool == true then
			if isElement(p) then
				if getElementType(p) == "player" then
					triggerClientEvent(p,"CSGironAddStat",p,stat,value)
					return
				end
			end
		end
	end
	local t = exports.DENstats:getPlayerAccountData(p,"paramedic2")

	tt = fromJSON(t)
	if tt==nil or tt["healedscore"] == nil or tt[1] == nil then
		tt = {["healedscore"]=0,["rankPTS"]=0,0,0,0,0,0,0,0}
		for i=1,10 do tt[i]=0 end
		exports.DENstats:setPlayerAccountData(p,"paramedic2",toJSON(tt))

	end
	--]]
	exports.DENstats:setPlayerAccountData(source,statName,stat)
	local pts = exports.DENstats:getPlayerAccountData(source,rankStat)
	if not pts then pts = 0 end
	exports.DENstats:setPlayerAccountData(source,rankStat,pts+rankPTS)
end
addEvent("CSGironSetStat",true)
addEventHandler("CSGironSetStat",root,CSGironSetStat)
