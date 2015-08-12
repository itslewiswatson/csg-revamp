-- Nickchange handler
addEventHandler("onPlayerChangeNick", root,
	function ( oldNick, newNick )
		for k, thePlayer in pairs( getOnlineAdmins () ) do
			exports.killmessages:outputMessage( oldNick.." is now known as "..newNick, thePlayer, 225, 0, 0)
		end
	end
)

-- Output a staff message
function createNewAdminDxMessage ( theMessage, r, g, b )
	for k, thePlayer in pairs( getOnlineAdmins () ) do
		exports.killmessages:outputMessage( theMessage, thePlayer, r, g, b )
	end
end

-- Deathmatch warns
addEventHandler( "onPlayerWasted", root,
	function ( ammo, attacker, weapon, bodypart )
		if ( attacker ) and not ( source == attacker ) then
			if ( getElementType ( attacker ) == "vehicle" ) then
				if isElement(getVehicleController( attacker )) then 
					attacker = getVehicleController( attacker ) 
				else
					return false
				end
			end
			local sourceTeam = getPlayerTeam( source )
			local attackTeam = getPlayerTeam( attacker )
			if exports.server:getPlayChatZone(attacker) ~= "LV" and attackTeam and sourceTeam then
				local sourceTeam = getTeamName(sourceTeam)
				local attackTeam = getTeamName(attackTeam)
				if getElementDimension( source ) ~= 20 and getElementDimension( source ) ~= 125 and attackTeam ~= "Staff" then
					if ( attackTeam == "SWAT" ) or ( attackTeam == "Police" ) or ( attackTeam == "Military Forces" ) or ( attackTeam == "Government Agency" ) then
						if getElementData( source, "wantedPoints" ) < 1 then
							createNewAdminDxMessage( getPlayerName( attacker ).." possibly deathmatched "..getPlayerName( source ), 225, 0, 0 )
						end
					elseif attackTeam == "Criminals" then
						if getElementData( attacker, "wantedPoints" ) < 1 then
							createNewAdminDxMessage( getPlayerName( attacker ).." possibly deathmatched "..getPlayerName( source ), 225, 0, 0 )
						elseif getElementData( attacker, "wantedPoints" ) >= 1 then
							if ( sourceTeam ~= "SWAT" ) and ( sourceTeam ~= "Police" ) and ( sourceTeam ~= "Military Forces" ) and ( sourceTeam ~= "Government Agency" ) then
								createNewAdminDxMessage( getPlayerName( attacker ).." possibly deathmatched "..getPlayerName( source ), 225, 0, 0 )
							end
						end
					else
						createNewAdminDxMessage( getPlayerName( attacker ).." possibly deathmatched "..getPlayerName( source ), 225, 0, 0 )
					end
				end
			end
		end
	end
)