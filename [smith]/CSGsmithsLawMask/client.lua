------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGmask/client (client-side)
--  Mask Script
--  [CSG]Smith
------------------------------------------------------------------------------------

-- Function which check if Player is in Current Team.
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

-- Function 
function Mask_Script_ ( attacker, weapon )
	if ( weapon == 17 ) then --if the weapon is TEARGAS
		if (isPlayerInTeam(source,"Military Forces") or isPlayerInTeam(source,"SWAT")) then -- Check if current player which is taking DMG is from SWAT or MF
			cancelEvent() -- Canceling taking demage
		end
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), Mask_Script_ )


