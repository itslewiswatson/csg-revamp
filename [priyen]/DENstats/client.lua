local statsTable = {}

-- Sync function
addEvent( "onSyncPlayerStats", true )
addEventHandler( "onSyncPlayerStats", localPlayer,
	function ( theTable, thePlayer )
		if ( isElement( thePlayer ) ) then
			statsTable[thePlayer] = theTable
		else
			statsTable = theTable
		end
	end
)

addEvent( "onSyncSpecific", true )
addEventHandler( "onSyncSpecific", localPlayer,
	function ( key, value, thePlayer )
		if ( isElement( thePlayer ) ) then
			if statsTable[thePlayer] == nil then statsTable[thePlayer] = {} end
			statsTable[thePlayer][key] = value
		--else
		--	statsTable = theTable
		end
	end
)

-- Function to set a player stat
function getPlayerAccountData ( thePlayer, data )
	local thePlayer = thePlayer or localPlayer
	if ( isElement( thePlayer ) ) then
		local userID = exports.server:getPlayerAccountID ( thePlayer )
		if ( userID ) and ( statsTable[thePlayer] ) then
			if ( data == 'table' ) then
				return statsTable[thePlayer]
			else
				return statsTable[thePlayer][data]
			end
		else
			return false
		end
	else
		return false
	end
end
