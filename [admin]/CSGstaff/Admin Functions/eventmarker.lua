local eventMarkers = {}
local eventMarkerBlips = {}

addCommandHandler( "eventmarker",
	function ( thePlayer, _, cmd )
		if ( isPlayerStaff( thePlayer )) then
			data = exports.DENmysql:querySingle("SELECT * FROM staff WHERE userid=? LIMIT 1",exports.server:getPlayerAccountID(thePlayer))
			if (data.eventmanager == 1) then
				if ( string.lower( cmd ) == "create" ) then
					if not ( eventMarkers[thePlayer] ) then
						eventMarkers[thePlayer] = {}
					elseif ( isElement( eventMarkers[thePlayer] ) ) then
						return
					end
					
					eventMarkers[thePlayer] = createMarker( getElementPosition( thePlayer ) )
					setMarkerColor( eventMarkers[thePlayer], 0, 0, 255, 0 )
					eventMarkerBlips[thePlayer] = createBlipAttachedTo( eventMarkers[thePlayer] , 49 )
					
					setElementInterior( eventMarkers[thePlayer] , getElementInterior( thePlayer ) )
					setElementDimension( eventMarkers[thePlayer] , getElementDimension( thePlayer ) )
					outputChatBox("A event has been placed by "..getPlayerName(thePlayer)..", head to the blip!",root,0,255,0)
				elseif ( string.lower( cmd ) == "delete" ) then
					if not ( isElement( eventMarkers[thePlayer] ) ) then
						return false
					end
		
					destroyElement( eventMarkers[thePlayer] )
					destroyElement( eventMarkerBlips[thePlayer] )
					outputChatBox("Event has ended.",root,255,0,0)
					
					eventMarkers[thePlayer] = {}
					eventMarkerBlips[thePlayer] = {}
				elseif ( string.lower( cmd ) == "deleteall" ) then
					for k, i in pairs ( eventMarkers ) do if ( isElement( i ) ) then destroyElement( i ) end end eventMarkers = {}
					for k, i in pairs ( eventMarkerBlips ) do if ( isElement( i ) ) then destroyElement( i ) end end eventMarkerBlips = {}
				else
					outputChatBox( "Use /eventmarker [create] or [delete] or [deleteall]", thePlayer, 225, 0, 0 )
				end
			else
				outputChatBox("You're not a event manager!!!",thePlayer,255,0,0)
			end
		end
	end
)