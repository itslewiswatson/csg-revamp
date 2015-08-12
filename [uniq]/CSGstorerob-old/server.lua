PlayerRobbedStore = {}
isStoreBeingRobbed = {}

addEvent( "onPlayerRobbedStore", true )
-- Trigger this after the player did a attempt to robbery a store so he can't rob again.
function onPlayerRobbedStore ( markerID )
	isStoreBeingRobbed[markerID] = setTimer( function () isStoreBeingRobbed[markerID] = nil end, 360000, 1 )
end
addEventHandler ( "onPlayerRobbedStore", root, onPlayerRobbedStore )

addEvent( "canPlayerRobStore", true )
-- Check if the player can rob a store
function canPlayerRobStore (theMarker)
	local account = exports.server:getPlayerAccountId(source)
	if ( PlayerRobbedStore[account] ) and ( getTickCount()-PlayerRobbedStore[account] < 900000 ) then 
		exports.DENdxmsg:createNewDxMessage(source, "You're not allowed to rob a store at this moment.", 225, 0, 0)
	else
		if ( isStoreBeingRobbed[theMarker]) then 
			exports.DENdxmsg:createNewDxMessage(source, "You're not allowed to rob this store at the moment.", 225, 0, 0)
		else
			triggerClientEvent( source, "onStartRobbery", source )
			PlayerRobbedStore[account] = getTickCount()
		end
	end
end
addEventHandler ( "canPlayerRobStore", root, canPlayerRobStore )

addEvent( "lawMessage", true )
function lawMessage (storeName)
	for i,thePlayer in ipairs( getElementsByType("player") ) do 
		if ( exports.server:getPlayerAccountId(thePlayer) ) then
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == "Police" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Military Forces" ) then
				outputChatBox( "A " .. tostring(storeName) .." is being robbed, please respond.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addEventHandler( "lawMessage", root, lawMessage )

addEvent( "storeRobPayout", true )
function storeRobPayout ()
	givePlayerMoney (source , 5000)
end
addEventHandler( "storeRobPayout", root, storeRobPayout )
