--[[
local recentUpdates = false

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
function ()
	recentUpdates = exports.DENmysql:query( "SELECT * FROM updates ORDER BY datum DESC LIMIT 50" )
end
)

function reloadRecentUpdates ()
	recentUpdates = exports.DENmysql:query( "SELECT * FROM updates ORDER BY datum DESC LIMIT 50" )
end

addEvent( "getRecentUpdates", true )
addEventHandler( "getRecentUpdates", root,
function ()
	if ( recentUpdates ) then
		triggerClientEvent( source, "openUpdatesWindow", source, recentUpdates )
	end
end
)

addEvent( "addNewUpdate", true )
addEventHandler( "addNewUpdate", root,
function ( theUpdate )
	if ( getPlayerName( source ) ) then
		local doUpdate = exports.DENmysql:exec( "INSERT INTO updates SET information=?, developer=?", theUpdate, getPlayerName( source ) )
		if ( doUpdate ) then
			reloadRecentUpdates ()
			outputChatBox( "Update posted!", source, 0, 225 ,0 )
		else
			outputChatBox( "Something went wrong while uploading the update!", source, 255, 0 ,0 )
		end
	else
		outputChatBox( "Something went wrong while uploading the update!", source, 255, 0 ,0 )
	end
end
)
--]]
