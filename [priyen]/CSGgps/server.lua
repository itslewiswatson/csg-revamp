function setDestination ( player, x, y, z, locationDesc, blip, settings )

	if player and x and y and z and locationDesc then

		triggerClientEvent ( player, "gps_setDestination", player, x, y, z, locationDesc, blip, settings )

	end

end

function setDestinationToPlayer(gpsClient,targetPlayer,desc,blip,settings)
	triggerClientEvent(gpsClient,"GPSrecDestToPlayer",gpsClient,targetPlayer,desc,blip,settings)
end

function setDestinationCmd ( cmd, pSource, x, y, z, desc )

	if pSource and x and y and z and desc then

		setDestination ( pSource, x, y, z, desc )

	end

end

addCommandHandler ( "addgps", setDestinationCmd )

function resetDestination ( player )

	if player then

		triggerClientEvent ( player, "gps_resetDestination", player )

	end

end

function getDestination ( player )

	if player then

		triggerClientEvent ( player, "gps_getDestination", player )

	end

end

addEvent ( 'GPS_showMap', true )

function forceMap()
		outputChatBox ( "forceMap" )

	if isPlayerMapForced(source) then

		forcePlayerMap(source, false)

	else

		forcePlayerMap(source, true)

	end

end

addEventHandler ( 'GPS_showMap', root, forceMap )


