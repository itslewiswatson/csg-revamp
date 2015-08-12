-- Disabled the seasparrow weapons for player not in staff or military forces team
addEventHandler("onClientVehicleStartEnter", root,
    function(thePlayer, seat)
        if thePlayer == localPlayer then
            if getElementModel ( source ) == 447 then
				if (getTeamName(getPlayerTeam(thePlayer)) == "Staff") or (getTeamName(getPlayerTeam(thePlayer)) == "Military Forces") then
					toggleControl ( "vehicle_fire", true )
					toggleControl ( "vehicle_secondary_fire", true )
				else
					toggleControl ( "vehicle_fire", false )
					toggleControl ( "vehicle_secondary_fire", false )		
				end
			else
				toggleControl ( "vehicle_fire", true )
				toggleControl ( "vehicle_secondary_fire", true )
			end
        end
    end
)

-- Enable the weapons again when the player leaves the vehicle
addEventHandler("OnClientVehicleStartExit", root,
    function(thePlayer, seat)
        if thePlayer == localPlayer then
            if getElementModel ( source ) == 447 then
				if not (getTeamName(getPlayerTeam(thePlayer)) == "Staff") or not (getTeamName(getPlayerTeam(thePlayer)) == "Military Forces") then
					toggleControl ( "vehicle_fire", true )
					toggleControl ( "vehicle_secondary_fire", true )
				end
			end
        end
    end
)