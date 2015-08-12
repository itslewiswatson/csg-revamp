function destroyPlayerGroupBlips (thePlayer)
	if ( thePlayer ) then
		triggerClientEvent( thePlayer, "deleteGroupBlip", thePlayer )
		return true
	else
		return false
	end
end