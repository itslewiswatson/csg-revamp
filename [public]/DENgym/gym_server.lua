-- Gym script Social Gaming Network
-- Scripted by Dennis (UniOn)
-- All rights reserved / Alle rechten voorbehouden
-- Dont use this script without permission from the original developer

-- Set the style and take the money also upload to MySQL the style what player want
function setFightStyle (style)
local costs = 1000
local money = getPlayerMoney(source)

	if (money < costs) then
		exports.DENdxmsg:createNewDxMessage(source, "You dont have not enough money for a new fighting style", 200, 0, 0)	
	else
		local takemoney = takePlayerMoney ( source, costs )
		setPedFightingStyle( source, style )
		playerID = exports.server:getPlayerAccountID(source)
		setMysql = exports.DENmysql:exec( "UPDATE accounts SET fightstyle = " .. style .. " WHERE id = " .. playerID )
		exports.DENdxmsg:createNewDxMessage(source, "New fighting style is set and ready to use! Price: 1000$", 0, 200, 0)
	end
end
addEvent ("buyFightingStyle", true)
addEventHandler ("buyFightingStyle", getRootElement(), setFightStyle)