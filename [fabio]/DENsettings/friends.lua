local theFile = xmlLoadFile ( "friends.xml" )
local getPlayerFromID
if not ( theFile ) then
	theFile = xmlCreateFile( "friends.xml","friends" )
end
xmlSaveFile( theFile )


function getPlayerFriends ()
	local friendsTable = {} 
	local theFriends = xmlNodeGetChildren( theFile )
    for i, theNode in ipairs( theFriends ) do
		if ( getPlayerFromID ( xmlNodeGetValue( theNode ) ) ) then
			table.insert(friendsTable,getPlayerFromID ( xmlNodeGetValue( theNode ) ) )
		end
    end
	return friendsTable
end

getPlayerFromID = function ( theID )
	for i, player in ipairs(getElementsByType("player")) do
		if ( (getElementData( player, "accountUserID" ) == tonumber(theID) ) ) then 
			return getPlayerName( player )
		end
	end
	return false
end

function addPlayerFriend ( thePlayer )
	local nodeExists = false
	local playerID = getElementData( thePlayer, "accountUserID" )
	if ( thePlayer ) and ( playerID ) then
		local theFriends = xmlNodeGetChildren( theFile ) 
		if #theFriends >=1 then 
			for i, theNode in ipairs( theFriends ) do
				if ( xmlNodeGetValue( theNode ) == tostring(playerID) ) then 
					nodeExists = true
				end
			end
			if not nodeExists then 
				xmlNodeSetValue( xmlCreateChild( theFile, "friend" ), tostring ( playerID ) )
				xmlSaveFile( theFile )
				return true
			else
				return false
			end
		else
			xmlNodeSetValue( xmlCreateChild( theFile, "friend" ), tostring ( playerID ) )
			xmlSaveFile( theFile )
			return true
		end
	end
end

function removePlayerFriend ( thePlayer )
	local playerID = getElementData( thePlayer, "accountUserID" )
	if ( thePlayer ) and ( playerID ) then
		local theFriends = xmlNodeGetChildren( theFile )
		for i, theNode in ipairs( theFriends ) do
			if ( xmlNodeGetValue( theNode ) == tostring(playerID) ) then 
				xmlDestroyNode ( theNode )
			end
		end
	end
end
