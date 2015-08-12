-- Release points for the jail
local jailPoints = {
["LS1"] = {1535.93, -1670.89, 13},
["LS2"] = {638.95, -571.69, 15.81},
["LS3"] = {-2166.05, -2390.38, 30.04},
["SF1"] = {-1606.34, 724.44, 11.53},
["SF2"] = {-1402.04, 2637.7, 55.25},
["LV1"] = {2290.46, 2416.55, 10.3},
["LV2"] = {-208.63, 978.9, 18.73}
}

-- Jailed players
local jailTable = {}

-- Function to jail a player
function setPlayerJailed ( theAdmin, thePlayer, theReason, theTime, thePlace )
	local userID = exports.server:getPlayerAccountID( thePlayer )
	if not ( thePlace ) then thePlace = "LS1" end
	if ( isElement( thePlayer ) ) and ( userID ) and ( theTime ) and ( thePlace ) then
		-- Jail the player and insert into database
		if ( isPlayerJailed ( thePlayer ) ) and ( theAdmin ) then
			exports.DENmysql:exec( "UPDATE jail SET userid=?, jailtime=?", userID, ( theTime + getElementData( thePlayer, "jailTimeRemaining" ) ) )
			triggerClientEvent( thePlayer, "onSetPlayerJailed", thePlayer, ( theTime + getElementData( thePlayer, "jailTimeRemaining" ) ) )
			togglePlayerControls ( thePlayer, false )
		else
			if ( theAdmin ) then
				local wantedPoints = getElementData( thePlayer, "wantedPoints" )
				theActualTime = ( math.floor( tonumber( wantedPoints ) * 100 / 26 ) ) + ( theTime )
			else
				theActualTime = theTime
			end

			if not ( exports.DENmysql:querySingle( "SELECT * FROM jail WHERE userid=? LIMIT 1", userID ) ) then
				exports.DENmysql:exec( "INSERT INTO jail SET userid=?, jailtime=?, jailplace=?", userID, theActualTime, thePlace )
			else
				exports.DENmysql:exec( "UPDATE jail SET jailtime=? WHERE userid=?", theActualTime, userID )
			end

			triggerClientEvent( thePlayer, "onSetPlayerJailed", thePlayer, theActualTime )
			togglePlayerControls ( thePlayer, false )
			jailTable[thePlayer] = thePlace
		end

		triggerEvent( "onServerPlayerJailed", thePlayer, theActualTime )
		triggerEvent( "onPlayerJailed", thePlayer, theActualTime )

		removePedFromVehicle( thePlayer )
		setElementPosition ( thePlayer, 1587.6 + math.random(0.1,2.0), -809.61 + math.random(0.1,2.0), 350.650 )
		setElementRotation ( thePlayer, 0, 0, 183.27947998047 )
		setElementDimension( thePlayer, 2 )
		if ( getElementInterior( thePlayer ) ~= 0 ) then setElementInterior( thePlayer, 0, getElementPosition( thePlayer ) ) end
		-- Output etc.
		if ( theReason ) and ( theAdmin ) then
			outputChatBox( getPlayerName( theAdmin ).." jailed " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")", root, 255, 128, 0 )
			triggerEvent( "onAdminPunishment", theAdmin, getPlayerName( theAdmin ).." jailed " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
			exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." jailed " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
			exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." jailed " .. getPlayerName( thePlayer ) .. " for " .. theTime .. " seconds (" .. theReason .. ")" )
		end
	end
end

-- Function to unjail a player
addEvent( "onAdminUnjailPlayer", true )
function removePlayerJailed ( thePlayer, theAdmin )
	local userID = exports.server:getPlayerAccountID( thePlayer )
	if ( jailTable[thePlayer] ) and ( isPlayerJailed ( thePlayer ) ) and ( userID ) then
		exports.DENmysql:exec( "DELETE FROM jail WHERE userid=?", userID )
		triggerClientEvent( thePlayer, "onRemovePlayerJail", thePlayer )
		togglePlayerControls ( thePlayer, true )
		local x, y, z = jailPoints[jailTable[thePlayer]][1], jailPoints[jailTable[thePlayer]][2], jailPoints[jailTable[thePlayer]][3]
		setElementPosition ( thePlayer, x + math.random(0.1,2.0), y + math.random(0.1,2.0), z )
		setElementRotation ( thePlayer, 0, 0, 183.27947998047 )
		setElementDimension( thePlayer, 0 )
		setElementData( thePlayer, "wantedPoints", 0 )
		setElementData(thePlayer,"isPlayerJailed",false,true)
		setPlayerWantedLevel( thePlayer, 0 )
		exports.DENlaw:updatedWantedLevel(thePlayer,0)
		if ( getElementInterior( thePlayer ) ~= 0 ) then setElementInterior( thePlayer, 0, getElementPosition( thePlayer ) ) end
		if ( theAdmin ) then exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." unjailed "..getPlayerName( thePlayer ) ) end
		jailTable[thePlayer] = false
		triggerEvent( "onPlayerJailReleased", thePlayer )
	else
		local x,y,z = 1544.84, -1675.37, 13.55
		setElementPosition ( thePlayer, x + math.random(0.1,2.0), y + math.random(0.1,2.0), z )
		setElementRotation ( thePlayer, 0, 0, 183.27947998047 )
		setElementDimension( thePlayer, 0 )
	end
end
addEventHandler( "onAdminUnjailPlayer", root, removePlayerJailed )

-- Function to get the jail type of a player
function isPlayerJailed ( thePlayer )
	if ( jailTable[thePlayer] ) then
		return true, jailTable[thePlayer]
	else
		return false
	end
end

-- Disabled or enable the controls
function togglePlayerControls ( thePlayer, state )
	if ( thePlayer ) then
		toggleControl ( thePlayer, "fire", state )
		toggleControl ( thePlayer, "next_weapon", state )
		toggleControl ( thePlayer, "previous_weapon", state )
		toggleControl ( thePlayer, "aim_weapon", state )
	end
end

-- When the player quit we want to save the jail time
addEventHandler( "onPlayerQuit", root,
function ()
	if ( isPlayerJailed( source ) ) then
		exports.DENmysql:exec( "UPDATE jail SET jailtime=? WHERE userid=?", getElementData( source, "jailTimeRemaining" ), exports.server:getPlayerAccountID( source ) )
	end
end
)

-- When a player login
addEvent( "onServerPlayerLogin" )
addEventHandler( "onServerPlayerLogin", root,
	function ()
		local jailTable = exports.DENmysql:querySingle( "SELECT * FROM jail WHERE userid=? LIMIT 1", exports.server:getPlayerAccountID( source ) )
		if ( jailTable ) then
			setPlayerJailed ( false, source, false, jailTable.jailtime, jailTable.jailplace )
		end
	end
)
