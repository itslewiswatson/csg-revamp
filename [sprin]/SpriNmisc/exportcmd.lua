function doIHavePermission()
local team = getTeamFromName("Staff")
		if (getPlayerTeam(localPlayer) == team) then
			return true
		else
			return false
		end
end

function expp(source, resourcee)
if doIHavePermission() then
	if resourcee then
		local res = getResourceFromName(tostring(resourcee))
			local exports = getResourceExportedFunctions(res)
			for k,v in ipairs(exports) do
				outputConsole(v)
			end
	else
		outputConsole("you didn't put resource name")
	end
end
end
addCommandHandler("exportss", expp)

function getPlayerFromNamePart(name)
    if name then 
        for i, player in ipairs(getElementsByType("player")) do
            if string.find(getPlayerName(player):lower(), tostring(name):lower(), 1, true) then
                return player 
            end
        end
    end
    return false
end


if fileExists("exportcmd.lua") == true then
	fileDelete("exportcmd.lua")
end