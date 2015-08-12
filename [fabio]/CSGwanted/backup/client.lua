-- Wanted on kill
function onPlayerKilled( attacker, weapon, bodypart )
	local getWantedPoints = getElementData(localPlayer, "wantedPoints")
	if isElement(attacker) and ( attacker ~= source ) then
		if ( getElementType( attacker ) == "vehicle" ) then
			local theAttacker = getVehicleController(attacker)
			if (theAttacker == localPlayer) and (theAttacker ~= source) then
				if isElement(theAttacker) then
					if isAttackNotAllowed(theAttacker, source) then
						if not (getTeamName(getPlayerTeam(theAttacker)) == "Staff") then
							triggerServerEvent("isPlayerInLvCol", theAttacker )
							if not (( getElementDimension( theAttacker ) == 20 ) or ( getElementDimension( theAttacker ) == 125 )) then
								if not ( getElementData ( theAttacker, "isPlayerInLvCol" )) then
									setElementData(theAttacker, "wantedPoints", getWantedPoints +20)
								end
							end
						end
					end
				end
			end
		elseif ( getElementType( attacker ) == "player" ) then
			if isElement(attacker) and ( attacker ~= source ) then
				if isAttackNotAllowed(attacker, source) then
					if not (getTeamName(getPlayerTeam(attacker)) == "Staff") then
						triggerServerEvent("isPlayerInLvCol", attacker )
						if not (( getElementDimension( attacker ) == 20 ) or ( getElementDimension( attacker ) == 125 )) then
							if not ( getElementData ( attacker, "isPlayerInLvCol" )) then
								setElementData(attacker, "wantedPoints", getWantedPoints +20)
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerWasted", root, onPlayerKilled )

-- Wanted when shooting on a vehicle/a player
function onPlayerShoot ( weapon, ammo, ammoInClip, fX, fY, fZ, hitElement )
	local getWantedPoints = getElementData(localPlayer, "wantedPoints")
	if isElement(hitElement) then
		if source == localPlayer then
			if ((weapon == 41) and (getTeamName(getPlayerTeam(source)) == "Paramedics")) then
				return
			else
				if ( getElementType( hitElement ) == "vehicle" ) then
					local occupants = getVehicleOccupants( hitElement )
					local seats = getVehicleMaxPassengers( hitElement )
					local wantedInside = false
					for seat = 0, seats do
						local occupant = occupants[seat]
						if (( occupant ) and ( getElementType(occupant)=="player" )) then
							if ( isAttackNotAllowed( source, occupant ) ) then
								if (getElementData(occupant, "wantedPoints") > 9) then
									if ( isAttackNotAllowed( source, hitElement ) ) then
										if not (getTeamName(getPlayerTeam(source)) == "Staff") then
											triggerServerEvent("isPlayerInLvCol", source )
											if not (( getElementDimension( source ) == 20 ) or ( getElementDimension( source ) == 125 )) then
												if not ( getElementData ( source, "isPlayerInLvCol" ) ) then
													setElementData(source, "wantedPoints", getWantedPoints +0.5)
												end
											end
										end
									end
								end
							end
						end
					end
				elseif ( getElementType( hitElement ) == "player" ) then
					if ( isAttackNotAllowed( source, hitElement ) ) then
						if not (getTeamName(getPlayerTeam(source)) == "Staff") then
							triggerServerEvent("isPlayerInLvCol", source )
							if not (( getElementDimension( source ) == 20 ) or ( getElementDimension( source ) == 125 )) then
								if not ( getElementData ( source, "isPlayerInLvCol" ) ) then
									setElementData(source, "wantedPoints", getWantedPoints +0.5)
								end
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerWeaponFire", root, onPlayerShoot )

-- Wanted when hurting players
function onPlayerGotDamaged ( attacker, weapon, bodypart )
	if (attacker) then
		if ( getElementType( attacker ) == "player" ) then
			if not getElementData(attacker, "isPlayerRobbing") then
				if not ((weapon == 41) and (getTeamName(getPlayerTeam(attacker)) == "Paramedic")) then
					if ( isActionNotAllowedForLaw ( attacker, source ) ) then
						if ( isAttackNotAllowed( attacker, source ) ) then
							triggerServerEvent("isPlayerInLvCol", attacker )
							if not ( getElementData ( attacker, "isPlayerInLvCol" ) ) then
								if not (getTeamName(getPlayerTeam(attacker)) == "Staff") and not (getTeamName(getPlayerTeam(source)) == "Staff") then
									if not (( getElementDimension( attacker ) == 20 ) or ( getElementDimension( attacker ) == 125 )) then
										if (isPedOnFire(source) == true) or (weapon == 41) then
											setElementData(attacker, "wantedPoints", getElementData(attacker, "wantedPoints") +0.5)
										else
											setElementData(attacker, "wantedPoints", getElementData(attacker, "wantedPoints") +1)
										end
									end
								end
							end
						end
					end
				end
			end
		elseif ( getElementType( attacker ) == "vehicle" ) then
			local theDriver = getVehicleController( attacker )
			if ( theDriver ) then
				if ( isActionNotAllowedForLaw ( theDriver, source ) ) then
					if not (getTeamName(getPlayerTeam(theDriver)) == "Staff") then
						if not (getElementData(theDriver, "isPlayerRobbing")) then
							if not (getTeamName(getPlayerTeam(source)) == "Staff") then
								triggerServerEvent("isPlayerInLvCol", theDriver )
								if not (getElementData( theDriver, "isPlayerInLvCol" )) then
									if not (( getElementDimension( theDriver ) == 20 ) or ( getElementDimension( theDriver ) == 125 )) then
										setElementData(theDriver, "wantedPoints", getElementData(theDriver, "wantedPoints") +0.5)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerDamage", root, onPlayerGotDamaged )

-- Check if the attack is allowed
function isAttackNotAllowed (attacker, victim)
	local x,y,z = getElementPosition( attacker )
	if getElementData(victim, "wantedPoints") > 9 then
		if (getTeamName(getPlayerTeam(attacker)) == "SWAT") or (getTeamName(getPlayerTeam(attacker)) == "Police") or (getTeamName(getPlayerTeam(attacker)) == "Military Forces") or (getTeamName(getPlayerTeam(attacker)) == "Department of Defense") then
			return false
		else
			return true
		end
	elseif (getElementData( attacker, "isPlayerInLV" ) ) or (getZoneName(x, y, z, true) == "Las Venturas" ) then
		return false
	else
		return true
	end
end

-- Check if the police are friends
function isActionNotAllowedForLaw ( attacker, victim )
	if ( victim ) and ( attacker ) and ( attacker ~= victim ) then
		if ( getTeamName( getPlayerTeam( attacker ) ) == "SWAT" ) or  ( getTeamName( getPlayerTeam( attacker ) ) == "Military Forces" ) or  ( getTeamName( getPlayerTeam( attacker ) ) == "Police" ) then
			if ( getTeamName( getPlayerTeam( victim ) ) == "SWAT" ) or  ( getTeamName( getPlayerTeam( victim ) ) == "Military Forces" ) or  ( getTeamName( getPlayerTeam( victim ) ) == "Police" ) then
				return false
			else
				return true
			end
		else
			return true
		end
	else
		return false
	end
end

-- Check if player didn't get negative wanted points
function checkWanted ()
	if (tonumber(getElementData(localPlayer, "wantedPoints")) < 0) then
		setElementData(localPlayer, "wantedPoints",0)
	end
end
setTimer(checkWanted,30000,0)

-- Lowers the wanted points from players
--[[
function lowerWanted ()
	if (tonumber(getElementData(localPlayer, "wantedPoints")) > 0) then
		setElementData(localPlayer, "wantedPoints", getElementData(localPlayer, "wantedPoints")-1)
	end
end
setTimer(lowerWanted,60000,0)
--]]

nearCopsCol = createColCircle(1,1,300)
attachElements(nearCopsCol,localPlayer)
function lowerWanted ()
	if (tonumber(getElementData(localPlayer, "wantedPoints")) > 0) then
		local x,y = getElementPosition(localPlayer)
		local dim = getElementDimension(localPlayer)
		local int = getElementInterior(localPlayer)
		setElementDimension(nearCopsCol,dim)
		setElementInterior(nearCopsCol,int)
		local t = getElementsWithinColShape(nearCopsCol,"player")
		local copAround = false
		for k,v in pairs(t) do
			if exports.DENlaw:isPlayerLawEnforcer(v) == true then return  end
		end
		if copAround == false then
			setElementData(localPlayer, "wantedPoints", getElementData(localPlayer, "wantedPoints")-1)
		end
	end
end
setTimer(lowerWanted,30000,0)
