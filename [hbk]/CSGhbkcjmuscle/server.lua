addEvent("Restmode", true)
addEventHandler("Restmode", root,
function ()
local moneymuscle = getPlayerMoney(source)
if (moneymuscle >= 500) then
takePlayerMoney(source,500)
setPedStat( source, 23, 0 )
else
triggerClientEvent("damn", source)
end
end )

addEvent("mus1", true)
addEventHandler("mus1", root,
function ()
setPedStat( source, 23, 100 )
exports.DENdxmsg:createNewDxMessage(source,"Increased CJ Muscle...",0,255,0)
exports.Denstats:setPlayerAccountData(source,"cjm",100)
end )

addEvent("mus2", true)
addEventHandler("mus2", root,
function ()
setPedStat( source, 23, 250 )
exports.DENdxmsg:createNewDxMessage(source,"Increased CJ Muscle...",0,255,0)
exports.Denstats:setPlayerAccountData(source,"cjm",250)
end )

addEvent("mus3", true)
addEventHandler("mus3", root,
function ()
setPedStat( source, 23, 450 )
exports.DENdxmsg:createNewDxMessage(source,"Increased CJ Muscle...",0,255,0)
exports.Denstats:setPlayerAccountData(source,"cjm",450)
end )

addEvent("mus4", true)
addEventHandler("mus4", root,
function ()
setPedStat( source, 23, 750 )
exports.DENdxmsg:createNewDxMessage(source,"Increased CJ Muscle...",0,255,0)
exports.Denstats:setPlayerAccountData(source,"cjm",750)
end )

addEvent("mus5", true)
addEventHandler("mus5", root,
function ()
setPedStat( source, 23, 999 )
exports.DENdxmsg:createNewDxMessage(source,"Increased CJ Muscle...",0,255,0)
exports.Denstats:setPlayerAccountData(source,"cjm",999)
end )

addEvent("moneymuscle", true)
addEventHandler("moneymuscle", root,
function ()
local moneymuscle = getPlayerMoney(source)
if (moneymuscle >= 500) then
takePlayerMoney(source,500)
else
exports.DENdxmsg:createNewDxMessage(source,"You can't afford to increase your muscles, you need $500",255,0,0)
end
end )


addEvent("moneymuscle2", true)
addEventHandler("moneymuscle2", root,
function ()
local moneymuscle = getPlayerMoney(source)
if (moneymuscle >= 750) then
takePlayerMoney(source,750)
else
exports.DENdxmsg:createNewDxMessage(source,"You can't afford to increase your muscles, you need $750",255,0,0)
end
end )


addEvent("moneymuscle3", true)
addEventHandler("moneymuscle3", root,
function ()
local moneymuscle = getPlayerMoney(source)
if (moneymuscle >= 1500) then
takePlayerMoney(source,1500)
else
exports.DENdxmsg:createNewDxMessage(source,"You can't afford to increase your muscles, you need $1500",255,0,0)
end
end )


addEvent("moneymuscle4", true)
addEventHandler("moneymuscle4", root,
function ()
local moneymuscle = getPlayerMoney(source)
if (moneymuscle >= 2500) then
takePlayerMoney(source,2500)
else
exports.DENdxmsg:createNewDxMessage(source,"You can't afford to increase your muscles, you need $2500",255,0,0)
end
end )


addEvent("moneymuscle5", true)
addEventHandler("moneymuscle5", root,
function ()
local moneymuscle = getPlayerMoney(source)
	if (moneymuscle >= 3500) then
		takePlayerMoney(source,3500)
	else
		exports.DENdxmsg:createNewDxMessage(source,"You can't afford to increase your muscles, you need $3500",255,0,0)
	end
end )

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	local m = exports.DENstats:getPlayerAccountData(source,"cjm")
	setPedStat(source,23,m)
	if m == false or m == nil then m = 0 end
	triggerClientEvent(source,"recCJmuscle",source,m)
end)

addEventHandler("onElementModelChange",root,function(_,newModel)
	if getElementType(source) == "player" then
		if newModel == 0 then
			setPedStat(source,23,exports.DENstats:getPlayerAccountData(source,"cjm"))
		end
	end
end)
