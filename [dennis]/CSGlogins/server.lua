-- Get the last logins and send them to the client
addCommandHandler( "lastlogins",
	function ( thePlayer )
		local theAccount = exports.server:getPlayerAccountName ( thePlayer )
		if ( theAccount ) then
			local theTable = exports.DENmysql:query( "SELECT ip,serial,datum,nickname FROM logins WHERE accountname=? ORDER BY datum ASC LIMIT 10", theAccount )
			triggerClientEvent( thePlayer, "onClientOpenLoginsWindow", thePlayer, theTable )
		end
	end
)