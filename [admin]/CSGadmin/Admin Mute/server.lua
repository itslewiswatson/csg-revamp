local mutesTable = {}

-- Function to mute a player
function adminMutePlayer ( theAdmin, thePlayer, theReason, theTime, theType )
	local userID = exports.server:getPlayerAccountID( thePlayer )
	if ( isElement( thePlayer ) ) and ( userID ) and ( theTime ) and ( theType ) then
		-- First unmute the player and then mute him again if he's already muted
		adminUnmutePlayer ( thePlayer, theAdmin )
		exports.DENmysql:exec( "INSERT INTO mutes SET userid=?, mutetime=?, mutetype=?", userID, theTime, theType )
		triggerClientEvent( thePlayer, "onSetPlayerMuted", thePlayer, theTime )
		mutesTable[thePlayer] = theType
		-- Output etc.
		if ( theReason ) and ( theAdmin ) then
			if ( theType == "Main" ) then
				outputChatBox( getPlayerName( theAdmin ).." muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")", root, 255, 128, 0 )
				triggerEvent( "onAdminPunishment", theAdmin, getPlayerName( theAdmin ).." muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
				exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
			elseif ( theType == "Global" ) then
				outputChatBox( getPlayerName( theAdmin ).." global muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")", root, 255, 128, 0 )
				triggerEvent( "onAdminPunishment", theAdmin, getPlayerName( theAdmin ).." global muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." global muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
				exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." global muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
			elseif ( theType == "Support" ) then
				outputChatBox( getPlayerName( theAdmin ).." support channel muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")", root, 255, 128, 0 )
				triggerEvent( "onAdminPunishment", theAdmin, getPlayerName( theAdmin ).." support channel muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." support channel muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
				exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." support channel muted " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
			end
		end
	end
end

-- Function to unmute a player
addEvent( "onAdminUnmutePlayer", true )
function adminUnmutePlayer ( thePlayer, theAdmin )
	local userID = exports.server:getPlayerAccountID( thePlayer )
	if ( mutesTable[thePlayer] ) and ( getPlayerMute ( thePlayer ) ) and ( userID ) then
		if ( theAdmin ) then
			outputChatBox( getPlayerName( thePlayer ).." got unmuted! (Unmuted by " .. getPlayerName( theAdmin ) .. ")", root, 0, 225, 0 )
			exports.DENmysql:exec( "DELETE FROM mutes WHERE userid=?", userID )
			mutesTable[thePlayer] = false
			triggerClientEvent( thePlayer, "onRemovePlayerMute", thePlayer )
		else
			outputChatBox( getPlayerName( thePlayer ).." got unmuted! (Mute expired)", root, 0, 225, 0 )
			exports.DENmysql:exec( "DELETE FROM mutes WHERE userid=?", userID )
			mutesTable[thePlayer] = false
			triggerClientEvent( thePlayer, "onRemovePlayerMute", thePlayer )
		end
	end
end
addEventHandler( "onAdminUnmutePlayer", root, adminUnmutePlayer )

-- Function to get the mute type of a player
function getPlayerMute ( thePlayer )
	if ( mutesTable[thePlayer] ) then
		return mutesTable[thePlayer]
	else
		return false
	end
end

-- When a player quits
addEventHandler( "onPlayerQuit", root,
	function ()
		if ( mutesTable[source] ) then
			local userID = exports.server:getPlayerAccountID( source )
			exports.DENmysql:exec( "UPDATE mutes SET mutetime=? WHERE userid=?", getElementData( source, "muteTimeRemaining" ), userID )
		end
	end
)

-- When a player login
addEvent( "onServerPlayerLogin" )
addEventHandler( "onServerPlayerLogin", root,
	function ( userID )
		local muteTable = exports.DENmysql:querySingle( "SELECT * FROM mutes WHERE userid=? LIMIT 1", userID )
		if ( muteTable ) then
			adminMutePlayer ( false, source, false, muteTable.mutetime, muteTable.mutetype )
		end
	end
)