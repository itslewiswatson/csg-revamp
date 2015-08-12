-- Export to get the punishments of a player
function getPlayerPunishlog ( thePlayer, k )
	if ( isElement( thePlayer ) ) then
		local userID = exports.server:getPlayerAccountID( thePlayer )
		local userSerial = getPlayerSerial( thePlayer )
		if ( userID ) then
			if ( k ) then
				local accountTable  = exports.DENmysql:query( "SELECT * FROM punishlog WHERE userid=? ORDER BY datum ASC", userID )
				local serialTable = exports.DENmysql:query( "SELECT * FROM punishlog WHERE serial=? ORDER BY datum ASC", userSerial )
				return serialTable, accountTable
			else
				local accountTable  = exports.DENmysql:query( "SELECT * FROM punishlog WHERE userid=? AND active=? ORDER BY datum ASC", userID, 1 )
				local serialTable = exports.DENmysql:query( "SELECT * FROM punishlog WHERE serial=? AND active=? ORDER BY datum ASC", userSerial, 1 )
				return serialTable, accountTable
			end
		else
			return false, false
		end
	else
		return false, false
	end
end

-- Even triggerd when the player want to see his punishments
addEvent( "retrievePlayerPunishments", true )
addEventHandler( "retrievePlayerPunishments", root,
	function ( playerID )
		local serialTable, accountTable = getPlayerPunishlog ( source )
		triggerClientEvent( source, "showPunishmentsWindow", source, accountTable, serialTable )
	end
)