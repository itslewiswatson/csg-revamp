local recentCaught = {}

addEventHandler( "onClientPlayerWeaponFire", root,
function ( weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	if ( weapon == 43 ) and ( isElement( hitElement ) ) and ( getElementType( hitElement ) == "vehicle" ) then
		if ( getVehicleController( hitElement ) ) then
			local theDriver = getVehicleController ( hitElement )
			local sx, sy, sz = getElementVelocity( hitElement )  
			local kphSpeed = (sx^2 + sy^2 + sz^2) ^ 0.5 * 1.61 * 100
			if ( getTeamName( getPlayerTeam( source ) ) == "Police" ) and ( getElementData( source, "Occupation" ) == "Traffic Officer" ) then
				if ( getTeamName( getPlayerTeam( theDriver ) ) == "Staff" ) or ( getTeamName( getPlayerTeam( theDriver ) ) == "Police" ) or ( getTeamName( getPlayerTeam( theDriver ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( theDriver ) ) == "Paramedics" ) or ( getTeamName( getPlayerTeam( theDriver ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( theDriver ) ) == "Department of Defense" ) then
					return
				else
					if ( kphSpeed >= 110 ) then
						if ( recentCaught[theDriver] ) and ( getTickCount()-recentCaught[theDriver] < 40000 ) then
							return
						else
							exports.DENdxmsg:createNewDxMessage( "You caught " .. getPlayerName( theDriver ) .. " for speeding! Here is a $200 reward!", 0, 225, 0 )
							triggerServerEvent( "onPlayerCaughtSpeeding", theDriver, source )
							recentCaught[theDriver] = getTickCount()
						end
					end
				end
			end
		end
	end
end
)

-- String for cops
function getPointFrontOfElement( element, distance )
    local x, y, z = getElementPosition ( element )
    local rx, ry, rz = getElementRotation ( element )
    x = x + (distance * (math.sin(math.rad(-rz))) )
    y = y + (distance * (math.cos(math.rad(-rz))) )
	return x,y,z
end

function getPositionFromElementAtOffset( element, x, y, z )
	if not x or not y or not z then      
		return x, y, z   
	end
	
	local matrix = getElementMatrix ( element )
	local offX = x * matrix[1][1] + y * matrix[2][1] + z * matrix[3][1] + matrix[4][1]
	local offY = x * matrix[1][2] + y * matrix[2][2] + z * matrix[3][2] + matrix[4][2]
	local offZ = x * matrix[1][3] + y * matrix[2][3] + z * matrix[3][3] + matrix[4][3]
	return offX, offY, offZ
end

function getVehicleWheelPosition( vehicle, wheel)
	local x, y, z = 0, 0, 0
	local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(vehicle)
	if wheel == 1 then
		x, y, z = getPositionFromElementAtOffset(vehicle, minX, maxY, minZ)
	elseif wheel == 2 then
		x, y, z = getPositionFromElementAtOffset(vehicle, minX, -maxY, minZ)		
	elseif wheel == 3 then
		x, y, z = getPositionFromElementAtOffset(vehicle, maxX, maxY, minZ)
	elseif wheel == 4 then
		x, y, z = getPositionFromElementAtOffset(vehicle, maxX, -maxY, minZ)
	end	 
	return x, y, z
end

addCommandHandler("stinger",
	function ()
		if ( getPlayerTeam( localPlayer ) ) then 
			if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Police" ) and ( getElementData( localPlayer, "Occupation" ) == "Traffic Officer" ) or ( getTeamName( getPlayerTeam( localPlayer ) ) == "SWAT" ) then
				local x, y, z = getPointFrontOfElement( localPlayer , 3 ) 
				local rx, ry ,rz = getElementRotation( localPlayer )
				z = getGroundPosition(x, y, z)
				triggerServerEvent ( "onCreateStinger",  localPlayer , x, y, z, rx, ry ,rz )
			end
		end
	end
)

addEventHandler("onClientRender", root,
	function ()
		if ( isPedInVehicle( localPlayer ) ) and ( getPlayerWantedLevel() >= 1 ) then
			local theVehicle = getPedOccupiedVehicle( localPlayer )
			if ( theVehicle ) then
				local wx1, wy1, wz1 = getVehicleWheelPosition( theVehicle, 1 )
				local wx2, wy2, wz2 = getVehicleWheelPosition( theVehicle, 2 )
				local wx3, wy3, wz3 = getVehicleWheelPosition( theVehicle, 3 )
				local wx4, wy4, wz4 = getVehicleWheelPosition( theVehicle, 4 )
				
				for k, v in ipairs( getElementsByType( "object" ) ) do
					if getElementData( v, "isStinger" ) == true then
						local vx, vy, vz = getElementPosition( v )
						if getDistanceBetweenPoints2D( wx1, wy1, vx, vy ) <= 1.4 then
							setVehicleWheelStates( theVehicle, 1, -1, -1, -1 )	
						end
						if getDistanceBetweenPoints2D( wx2, wy2, vx, vy ) <= 1.4 then
							setVehicleWheelStates( theVehicle, -1, 1, -1, -1 )	
						end
						if getDistanceBetweenPoints2D( wx3, wy3, vx, vy ) <= 1.4 then
							setVehicleWheelStates( theVehicle, -1, -1, 1, -1 )	
						end
						if getDistanceBetweenPoints2D( wx4, wy4, vx, vy ) <= 1.4 then
							setVehicleWheelStates( theVehicle, -1, -1, -1, 1 )	
						end		
					end										
				end
			end
		end
	end
)