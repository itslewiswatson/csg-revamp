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
			if ( getElementType ( attacker ) == "vehicle" ) then attacker = getVehicleController( attacker ) end
			if not ( getElementData( attacker, "isPlayerInLvCol" ) ) and ( getPlayerTeam( attacker ) ) and ( getPlayerTeam( source ) ) and ( getPlayerTeam( attacker ) ) then
				if not ( ( getElementDimension( source ) == 20 ) or ( getElementDimension( source ) == 125 ) ) and not ( getTeamName( getPlayerTeam( attacker ) ) == "Staff" ) then
					if ( getTeamName( getPlayerTeam( attacker ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( attacker ) ) == "Police" ) or ( getTeamName( getPlayerTeam( attacker ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( attacker ) ) == "Government Agency" ) then
						if ( getElementData( source, "wantedPoints" ) < 9 ) then
							createNewAdminDxMessage( getPlayerName( attacker ).." possibly deathmatched "..getPlayerName( source ), 225, 0, 0 )
						end
					elseif ( getTeamName( getPlayerTeam( attacker ) ) == "Criminals" ) then
						if ( getElementData( attacker, "wantedPoints" ) < 9 ) then
							createNewAdminDxMessage( getPlayerName( attacker ).." possibly deathmatched "..getPlayerName( source ), 225, 0, 0 )
						elseif ( getElementData( attacker, "wantedPoints" ) > 9 ) then
							if ( getTeamName( getPlayerTeam( source ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( source ) ) == "Police" ) or ( getTeamName( getPlayerTeam( source ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( attacker ) ) == "Government Agency" ) then
								return
							else
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