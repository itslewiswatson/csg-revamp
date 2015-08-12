
function getPos ( player, commandName )
    if ( player ) then
		local x, y, z = getElementPosition( player )
		local xr = getPedRotation ( player )
		outputChatBox( "Position: " .. ( math.floor( x * 100 ) / 100 ) .. ", " .. ( math.floor( y * 100 ) / 100 ) .. ", " .. ( math.floor( z * 100 ) / 100 ) .." Interior: " .. getElementInterior( player ) .. ", Dimension: " .. getElementDimension( player ).. " City: " .. exports.server:getPlayChatZone(player) .. " Rotation: " .. xr, player, 0, 255, 153 )
	end
end
addCommandHandler ( "pos", getPos )