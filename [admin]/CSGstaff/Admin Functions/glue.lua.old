function glue()
	if not getPlayerOccupiedVehicle( localPlayer ) then
		--if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Staff" ) then
			local vehicle = getPlayerContactElement( localPlayer )
			if getElementType(vehicle) == "vehicle" then
				if getElementModel(vehicle) ~= 497 then
					if ( getTeamName( getPlayerTeam( localPlayer ) ) ~= "Staff" ) then
						return
					end
				end
				local px, py, pz = getElementPosition( localPlayer )
				local vx, vy, vz = getElementPosition(vehicle)
				local sx = px - vx
				local sy = py - vy
				local sz = pz - vz

				local rotpX = 0
				local rotpY = 0
				local rotpZ = getPlayerRotation( localPlayer )

				local rotvX,rotvY,rotvZ = getVehicleRotation(vehicle)

				local t = math.rad(rotvX)
				local p = math.rad(rotvY)
				local f = math.rad(rotvZ)

				local ct = math.cos(t)
				local st = math.sin(t)
				local cp = math.cos(p)
				local sp = math.sin(p)
				local cf = math.cos(f)
				local sf = math.sin(f)

				local z = ct*cp*sz + (sf*st*cp + cf*sp)*sx + (-cf*st*cp + sf*sp)*sy
				local x = -ct*sp*sz + (-sf*st*sp + cf*cp)*sx + (cf*st*sp + sf*cp)*sy
				local y = st*sz - sf*ct*sx + cf*ct*sy

				local rotX = rotpX - rotvX
				local rotY = rotpY - rotvY
				local rotZ = rotpZ - rotvZ

				local slot = getPlayerWeaponSlot( localPlayer )

				triggerServerEvent("gluePlayer", localPlayer, slot, vehicle, x, y, z, rotX, rotY, rotZ)

				unbindKey("x","down",glue)
				bindKey("x","down",unglue)
				bindKey("jump","down",unglue)
			end
		--end
	end
end

function unglue ()
	triggerServerEvent("ungluePlayer", localPlayer )
	unbindKey("jump","down",unglue)
	unbindKey("x","down",unglue)
	bindKey("x","down",glue)
end

bindKey("x","down",glue)
addCommandHandler("glue",glue)
addCommandHandler("unglue",unglue)
