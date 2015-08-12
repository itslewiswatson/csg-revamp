--[[
addCommandHandler("setwstyle",function(ps,_,nam,style)
	local style=tonumber(style)
	local player=getPlayerFromName(nam)
	for k,v in pairs(getElementsByType("player")) do
		triggerClientEvent(v,"CSGwalk.rec",v,player,style)
	end
end)
--]]

local sty = {}


addEvent("CSGwalk.buy",true)
addEventHandler("CSGwalk.buy",root,function(id)
	local curr = exports.Denstats:getPlayerAccountData(source,"walkstyle")
	if curr==false or curr==nil then curr=0 end
	if curr == id then
		exports.dendxmsg:createNewDxMessage(source,"You already have this walking style!",255,255,0)
	else
		exports.denstats:setPlayerAccountData(source,"walkstyle",id)
		sty[source]=id
		send(source)
		triggerClientEvent(source,"CSGwalk.bought",source,id)
		takePlayerMoney(source,500)
	end
end)

addEventHandler("onPlayerLogin",root,function()
	local curr = exports.Denstats:getPlayerAccountData(source,"walkstyle")
	if curr==false or curr==nil then curr=0 end
	sty[source]=curr
	send(source)
	triggerClientEvent(source,"CSGwalk.recTable",source,sty)
	setTimer(checkForBannedID,2000,1,source)
end)

setTimer(function()
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(v) then
			sty[v] = exports.denstats:getPlayerAccountData(source,"walkstyle")
			send(v)
		end
	end
end,5000,1)

function send(v)
	local id = 0
	if (sty[v]) then
		id = sty[v]
	else
		sty[v] = 0
	end

	for k,p in pairs(getElementsByType("player")) do
		triggerClientEvent(p,"CSGwalk.rec",p,v,id)
	end
end

function checkForBannedID(player)
	if (isElement(player)) then
		if (exports.server:isPlayerLoggedIn(player)) then
			local id = exports.denstats:getPlayerAccountData(player,"walkstyle")
			if (id == 138) or (id == 127) or (id == 126) or (id == 70) or (id == 69) then
				exports.denstats:setPlayerAccountData(player,"walkstyle",0)
				triggerClientEvent(player,"CSGwalk.rec",player,player,0)
			end
		end
	end
end