------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGstaffsteath/client (client-side)
--  Staff Preventing STEATH Script
--  [CSG]Smith
------------------------------------------------------------------------------------

function isPlayerInTeam(src, TeamName)
	if src and isElement ( src ) and getElementType ( src ) == "player" then
		local team = getPlayerTeam(src)
		if team then
			if getTeamName(team) == TeamName then
				return true
			else
				return false
			end
		end
	end
end

addEventHandler("onClientPlayerStealthKill",localPlayer,
function (targetPlayer)
    if isPlayerInTeam(targetPlayer,"Staff") then
	cancelEvent()
    end
end)
