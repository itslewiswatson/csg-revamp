------------------------------------------------------------------------------------
-- PROJECT:				CSG ~ Community of Social Gaming
-- DEVELOPERS: 				Smart
-- RIGHTS: 				All rights reserved by developers
------------------------------------------------------------------------------------

function convertMoneyToString(money)
    local formatted = money
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k==0 then break end
    end
    formatted = "$"..tostring(formatted)
    return formatted
end

function getPlayerFPS(player)
	return getElementData(player, "fps") or 0
end

function findPlayer(name, player)
	if (not name) then return end
	local matches = {}
	for index, player2 in pairs(getElementsByType("player")) do
		if getPlayerName(player2) == name then
			return player2
		end
		if getPlayerName(player2):lower():find(name:lower()) then
			table.insert(matches, player2)
		end
	end
	if #matches == 1 then
		return matches[1]
	else
		if (player) then
			--
		end
	end
	return false
end