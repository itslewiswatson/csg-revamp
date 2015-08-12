------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGfbiinterior/client (client-side)
--  Fbi Interior (LVPD)
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

addCommandHandler("sgs",
  function(command, value)
    setGameSpeed(1)
	triggerServerEvent ( "speedlogs", localPlayer, tostring(getPlayerName(localPlayer).." has tryed to abuse /sgs command with value ="..tonumber(value)) )
  end
)