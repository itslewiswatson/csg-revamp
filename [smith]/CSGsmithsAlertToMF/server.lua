------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithAlertToMF/server (server-side)
--  Notify MF Soldiers that there someone has enter to Seasparrow or Rustler
--  [CSG]Smith
------------------------------------------------------------------------------------

Enemy_Blips = {}
Restricted_Vehicles = { [447]=true,[476]=true }

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

function addAlerOnVehiceEnter ( vehicle, seat, jacked )
if getElementDimension ( source ) == 0 then
	if (( Restricted_Vehicles[getElementModel( vehicle )] ) and seat == 0) then
		if (isPlayerInTeam(source, "Military Forces") or isPlayerInTeam(source, "Staff")) then return end
			Enemy_Blips[source] = createBlipAttachedTo ( source, 23,2,255,0,0,255,nil,nil, getTeamFromName("Military Forces") )
			setElementVisibleTo ( Enemy_Blips[source], getRootElement(), false )
			for k,v in ipairs(getElementsByType("player")) do
				if isPlayerInTeam(v, "Military Forces") then
					exports.killmessages:outputMessage("ATTENTION: "..getPlayerName(source).." entered an unathorized vehicle ("..getVehicleName(vehicle)..")", v, 250, 0, 0,"default-bold")
					setElementVisibleTo ( Enemy_Blips[source], v, true )
				end
			end
	end
end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), addAlerOnVehiceEnter )

function OnExit ( vehicle, seat, jacked )
	if Enemy_Blips[source] then
		if isElement(Enemy_Blips[source]) then
			destroyElement(Enemy_Blips[source])
		end
	end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), OnExit )

