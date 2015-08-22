function convertNumber(theNumber)  
	local formatted = theNumber
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if (k == 0) then      
			break   
		end  
	end  
	return formatted
end

function getPlayerFromPartialName(name)
    if name then 
        for i, player in ipairs(getElementsByType("player")) do
            if string.find(getPlayerName(player):lower(), tostring(name):lower(), 1, true) then
                return player 
            end
        end
    end
    return false
end