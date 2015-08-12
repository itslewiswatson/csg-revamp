function out(player)
    setElementPosition (source, 1575.95, -1329.55, 16.48)
	setElementDimension (source, 0)
end
addEvent ("warpOut", true)
addEventHandler ("warpOut", getRootElement(), out)

function enter(player)
    setElementPosition (source, 1547.06, -1366.3, 326.21)
	setElementDimension (source, 0)
end
addEvent ("warpIn", true)
addEventHandler ("warpIn", getRootElement(), enter)

function buy()
   giveWeapon (source, 46,1)
   takePlayerMoney (source, 500)
end
addEvent ("buyPara", true)
addEventHandler ("buyPara", getRootElement(), buy)
