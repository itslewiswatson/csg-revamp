-- Command start open the window
addCommandHandler( "resources",
	function ( thePlayer )
		accountID = exports.server:getPlayerAccountID(thePlayer)
		data = exports.DENmysql:querySingle("SELECT * FROM developer WHERE userid=?",accountID)
		if (data) then
			local resourceTable = {}
			for k, i in ipairs( getResources() ) do
				resourceTable[k] = { getResourceName( i ), getResourceState ( i ) }
			end
			triggerClientEvent( thePlayer, "onOpenResourcesWindow", thePlayer, resourceTable )
		end
	end
)

-- Resource event
addEvent ( "onUpdateResourceState", true )
addEventHandler ( "onUpdateResourceState", root,
	function ( theType, theResource, theRow )
		if ( getResourceFromName( theResource ) ) then
			if ( theType == "start" ) then
				if ( startResource ( getResourceFromName( theResource ) ) ) then
					outputChatBox( "You started "..theResource, source, 0, 225, 0 )
					triggerClientEvent( source, "setResourceColor", source, theRow, 0, 225, 0 )
				elseif ( getResourceState ( getResourceFromName( theResource ) ) == "running" ) or ( getResourceState ( getResourceFromName( theResource ) ) == "starting" ) then
					outputChatBox( theResource.." is already running or starting!", source, 0, 225, 0 )
				else
					outputChatBox( theResource.." failed to start, reason: "..getResourceLoadFailureReason ( getResourceFromName( theResource ) ), source, 225, 0, 0 )
				end
			elseif ( theType == "restart" ) then
				if ( restartResource ( getResourceFromName( theResource ) ) ) then
					outputChatBox( "You restarted "..theResource, source, 0, 225, 0 )
				elseif ( getResourceState ( getResourceFromName( theResource ) ) == "starting" ) then
					outputChatBox( theResource.." is already starting!", source, 0, 225, 0 )
				else
					outputChatBox( theResource.. " failed to restart, reason: "..getResourceLoadFailureReason ( getResourceFromName( theResource ) ), source, 225, 0, 0 )
				end
			elseif ( theType == "stop" ) then
				if ( stopResource ( getResourceFromName( theResource ) ) ) then
					outputChatBox( "You stopped "..theResource, source, 0, 225, 0 )
					triggerClientEvent( source, "setResourceColor", source, theRow, 225, 0, 0 )
				elseif ( getResourceState ( getResourceFromName( theResource ) ) == "stopping" ) or ( getResourceState ( getResourceFromName( theResource ) ) == "loaded" ) then
					outputChatBox( theResource.." is already stopping or stopped!", source, 0, 225, 0 )
				else
					outputChatBox( theResource.. " failed to stop, reason: "..getResourceLoadFailureReason ( getResourceFromName( theResource ) ), source, 225, 0, 0 )
				end
			end
		end
	end
)