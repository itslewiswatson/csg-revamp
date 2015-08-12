function jump()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local Controller = getVehicleController ( localPlayer )
	local team = getPlayerTeam(localPlayer)
	if getVehicleController(getPedOccupiedVehicle(localPlayer)) == localPlayer then
	if ( isElement(vehicle) ) and (isVehicleOnGround( vehicle )) and ( getTeamName(team) ) and ( getTeamName(team) == "Staff" ) then
		local sx,sy,sz = getElementVelocity ( vehicle )
		setElementVelocity( vehicle ,sx, sy, sz+0.7)
	end
	end
end
bindKey ( "lshift","down", jump)
