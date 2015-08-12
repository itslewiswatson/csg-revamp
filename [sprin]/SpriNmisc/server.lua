function admt (thePlayer)
	if ( getTeamName(getPlayerTeam(thePlayer)) == "Staff" ) then
        local vehicle = getPedOccupiedVehicle ( thePlayer )
        if (getElementAlpha(vehicle) == 255) then
			setElementAlpha ( vehicle,0) 
			exports.CSGlogging:createAdminLogRow ( thePlayer, getPlayerName( thePlayer ).." made his vehicle invisible" )
		else
			setElementAlpha ( vehicle,255)
			exports.CSGlogging:createAdminLogRow ( thePlayer, getPlayerName( thePlayer ).." made his vehicle visible" )
		end
	end
end
addCommandHandler("vehinvis", admt)



function admtt (thePlayer)
	if ( getTeamName(getPlayerTeam(thePlayer)) == "Staff" ) then
        local vehicle = getPedOccupiedVehicle ( thePlayer )
        if ( vehicle ) then
			setElementVelocity ( vehicle,0,0,0) 
		end
	end
end
addCommandHandler("sprin2", admtt)

