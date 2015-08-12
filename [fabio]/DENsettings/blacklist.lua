local theFile = xmlLoadFile ( "blacklist.xml" )
local getThePlayerFromID
if not ( theFile ) then
	theFile = xmlCreateFile( "blacklist.xml","blacklist" )
end
xmlSaveFile( theFile )

addEvent( "getBlacklistedPlayers", true )
function getBlacklistedPlayers ( )
	local blacklistedPlayers = {} 
	local theBlacklistedPlayers = xmlNodeGetChildren( theFile )
    for i, theNode in ipairs( theBlacklistedPlayers ) do
		local playerFromID = getThePlayerFromID ( xmlNodeGetValue( theNode ) )
		if ( playerFromID ) then
			table.insert(blacklistedPlayers,playerFromID )
		end
    end
	return blacklistedPlayers
end
addEventHandler( "getBlacklistedPlayers", root, getBlacklistedPlayers )

function isPlayerBlacklisted(thePlayer)
	local blacklistedPlayers = {}
	local playerID = getElementData( thePlayer, "accountUserID" )
	local theBlacklistedPlayers = xmlNodeGetChildren( theFile )
    for i, theNode in ipairs( theBlacklistedPlayers ) do
		if ( tonumber(xmlNodeGetValue( theNode )) ) == tonumber(playerID) then
			return true
		end
    end
	return false
end

getThePlayerFromID = function ( theID )
	for i, player in ipairs(getElementsByType("player")) do
		if ( (getElementData( player, "accountUserID" ) == tonumber(theID) ) ) then 
			return getPlayerName(player)
		end
	end
	return false
end

function addPlayerBlacklisted ( thePlayer )
	local nodeExists = false
	local playerID = getElementData( thePlayer, "accountUserID" )
	if ( thePlayer ) and ( playerID ) then
		local theBlacklistedPlayers = xmlNodeGetChildren( theFile ) 
		if #theBlacklistedPlayers >=1 then 
			for i, theNode in ipairs( theBlacklistedPlayers ) do
				if ( xmlNodeGetValue( theNode ) == tostring(playerID) ) then 
					nodeExists = true
				end
			end
			if not nodeExists then 
				xmlNodeSetValue( xmlCreateChild( theFile, "userid" ), tostring ( playerID ) )
				xmlSaveFile( theFile )
				return true
			else
				return false
			end
		else
			xmlNodeSetValue( xmlCreateChild( theFile, "userid" ), tostring ( playerID ) )
			xmlSaveFile( theFile )
			return true
		end
	end
end

function removePlayerBlacklisted ( thePlayer )
	local playerID = getElementData( thePlayer, "accountUserID" )
	if ( thePlayer ) and ( playerID ) then
		local theBlacklistedPlayers = xmlNodeGetChildren( theFile )
		for i, theNode in ipairs( theBlacklistedPlayers ) do
			if ( xmlNodeGetValue( theNode ) == tostring(playerID) ) then 
				xmlDestroyNode ( theNode )
			end
		end
		xmlSaveFile(theFile)
	end
end
