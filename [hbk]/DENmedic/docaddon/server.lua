addEvent("CSGdoc",true)
addEventHandler("CSGdoc",root,
function ()
	money = math.random (225,300)
	exports.DENdxmsg:createNewDxMessage(source,"Successfully saved this civilian! Paid $"..money.."",0,255,0)
	givePlayerMoney(source,money)
end
)

