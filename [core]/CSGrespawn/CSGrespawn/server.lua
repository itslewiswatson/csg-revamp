-- Event that gets triggers from the client
addEvent ( "respawnDeadPlayer", true )
addEventHandler ( "respawnDeadPlayer", root,
	function ( hx, hy, hz, rotation, mx, my, mz, lx, ly, lz, hospitalName )
		if ( exports.server:isPlayerPremium( source ) ) then respawnTime = 2000 else respawnTime = 6000 end
		if ( getTeamName( getPlayerTeam( source ) ) == "Military Forces" ) then
			fadeCamera( source, false, 1.0, 0, 0, 0 )
			setTimer( setCameraMatrix, 1000, 1, source, 113.79219818115, 1837.3602294922, 51.73709869384, 114.40268707275, 1838.0476074219, 51.34362411499, 0, 70 )
			setTimer( fadeCamera, 2000, 1, source, true, 1.0, 0, 0, 0 )
			setTimer( respawnPlayer, respawnTime, 1, source, 277.54, 1989.42, 17.64, 268.97412109375 )
			exports.DENdxmsg:createNewDxMessage( source, "You spawned at the Military Forces base", 225, 225, 225 )
		else
			fadeCamera( source, false, 1.0, 0, 0, 0 )
			setTimer( setCameraMatrix, 1000, 1, source, mx, my, mz, lx, ly, lz )
			setTimer( fadeCamera, 2000, 1, source, true, 1.0, 0, 0, 0 )
			setTimer( respawnPlayer, respawnTime, 1, source, hx, hy, hz, rotation )
			exports.DENdxmsg:createNewDxMessage( source, "You respawned at the "..hospitalName, 225, 225, 225 )
		end
	end
)

-- Function that respawns the player
function respawnPlayer ( thePlayer, hx, hy, hz, rotation )
	if ( isElement( thePlayer ) ) then
		fadeCamera( thePlayer, true)
		setCameraTarget( thePlayer, thePlayer )
		spawnPlayer( thePlayer, hx + math.random ( 0.1, 2 ), hy + math.random ( 0.1, 2 ), hz, rotation, getElementModel( thePlayer ), 0, 0 )
		
		local dataTable = exports.DENmysql:query("SELECT weapons FROM accounts WHERE id = ? LIMIT 1",exports.server:getPlayerAccountID(thePlayer))
		if dataTable and #dataTable == 1 then
			local weapons = fromJSON( dataTable[1].weapons )
			if weapons then
				for weapon, ammo in pairs( weapons ) do
					if not ( tonumber(weapon) == 35 ) and  not ( tonumber(weapon) == 36 ) and not ( tonumber(weapon) == 37 ) and not ( tonumber(weapon) == 38 ) and not ( tonumber(weapon) == 18 ) then
						giveWeapon( thePlayer, tonumber(weapon), tonumber(ammo) )
					end
				end
			end
		end
		
		local playerStatus = exports.DENmysql:query("SELECT weaponskills FROM playerstats WHERE userid = ? LIMIT 1",exports.server:getPlayerAccountID(thePlayer))
		if playerStatus and #playerStatus == 1 then
			local wepSkills = fromJSON( playerStatus[1].weaponskills )
			if ( wepSkills ) then
				for skillint, valueint in pairs( wepSkills ) do
					if ( tonumber(valueint) > 950 ) then
						setPedStat ( thePlayer, tonumber(skillint), 995 )
					else
						setPedStat ( thePlayer, tonumber(skillint), tonumber(valueint) )
					end
				end
			end
		end
		
		-- Give player armor when he's a premium
		if ( exports.server:isPlayerPremium( thePlayer ) ) then
			setPedArmor( thePlayer, 50 )
		end
	end
end

-- Spawn functions for a turfer
addEvent ( "spawnTurfingPlayer", true )
addEventHandler ( "spawnTurfingPlayer", root,
	function ( x, y, z, rotation )
		if ( isElement( source ) ) then
			spawnPlayer( source, x + math.random ( 0.1, 2 ), y + math.random ( 0.1, 2 ), z, rotation, getElementModel( source ), 0, 0 )

			local playerID = exports.server:getPlayerAccountID( source )
			local dataTable = exports.DENmysql:query( "SELECT weapons FROM accounts WHERE id = ? LIMIT 1", playerID )
			if dataTable and dataTable[1] then
				local weapons = fromJSON( dataTable[1].weapons )
				if ( weapons ) then
					for weapon, ammo in pairs( weapons ) do
						if not ( tonumber(weapon) == 35 ) and  not ( tonumber(weapon) == 36 ) and not ( tonumber(weapon) == 37 ) and not ( tonumber(weapon) == 38 ) and not ( tonumber(weapon) == 18 ) then
							giveWeapon( source, tonumber(weapon), tonumber(ammo) )
						end
					end
				end
			end
				
			local playerStatus = exports.DENmysql:query( "SELECT weaponskills FROM playerstats WHERE userid = ? LIMIT 1", playerID )
			if playerStatus and playerStatus[1] then
				local wepSkills = fromJSON( playerStatus[1].weaponskills )
				if ( wepSkills ) then
					for skillint, valueint in pairs( wepSkills ) do
						if ( tonumber(valueint) > 950 ) then
							setPedStat ( source, tonumber(skillint), 995 )
						else
							setPedStat ( source, tonumber(skillint), tonumber(valueint) )
						end
					end
				end
			end
		end
	end
)

-- Some tables
local spawnAFK = {}
local allowedAFK = {}

-- Reset the playing being AFK
function onSpawnMoveAFK ( thePlayer )
	spawnAFK[thePlayer] = false
	setElementFrozen( thePlayer, false )
	setElementDimension( thePlayer, 0 )
	unbindKey( thePlayer, "w", "down", onSpawnMoveAFK )
	unbindKey( thePlayer, "a", "down", onSpawnMoveAFK )
	unbindKey( thePlayer, "d", "down", onSpawnMoveAFK )
	unbindKey( thePlayer, "s", "down", onSpawnMoveAFK )	
	unbindKey( thePlayer, "arrow_l", "down", onSpawnMoveAFK)
	unbindKey( thePlayer, "arrow_u", "down", onSpawnMoveAFK)
	unbindKey( thePlayer, "arrow_r", "down", onSpawnMoveAFK)
	unbindKey( thePlayer, "arrow_d", "down", onSpawnMoveAFK)
	triggerClientEvent( thePlayer, "onClientShowAFK", thePlayer, false )
end

-- Set the player AFK
function onSetPlayerAFK( thePlayer )
	if ( isElement ( thePlayer ) ) and ( spawnAFK[thePlayer] ) and ( exports.server:isPlayerLoggedIn ( thePlayer ) ) and not ( getElementData( thePlayer, "isPlayerJailed" ) ) and not ( getElementData( thePlayer, "isPlayerArrested" ) ) then
		setElementDimension( thePlayer, math.random(100, 20000) )
		setElementFrozen( thePlayer, true )
		triggerClientEvent( thePlayer, "onClientShowAFK", thePlayer, true )
	end
end

-- When the player spawns toggle the controls
addEventHandler( "onPlayerSpawn", root,
	function ()
		if ( exports.server:isPlayerLoggedIn ( source ) ) and not ( getElementData( source, "isPlayerJailed" ) ) and not ( getElementData( source, "isPlayerArrested" ) ) and ( allowedAFK[source] ) then
			spawnAFK[source] = true
			allowedAFK[source] = false
			setTimer( onSetPlayerAFK, 16000, 1, source )
			bindKey( source, "w", "down", onSpawnMoveAFK )
			bindKey( source, "a", "down", onSpawnMoveAFK )
			bindKey( source, "d", "down", onSpawnMoveAFK )
			bindKey( source, "s", "down", onSpawnMoveAFK )
			bindKey( source, "arrow_l", "down", onSpawnMoveAFK)
			bindKey( source, "arrow_u", "down", onSpawnMoveAFK)
			bindKey( source, "arrow_r", "down", onSpawnMoveAFK)
			bindKey( source, "arrow_d", "down", onSpawnMoveAFK)
		end
	end
)

addEventHandler("onPlayerSpawn",root,
function()	
	if (exports.server:isPlayerLoggedIn(source)) and not (getElementData(source,"isPlayerJailed")) and not (getElementData(source,"isPlayerArrested")) then
		if not (spawnAFK[source] == true) then --make sure hes not AFK
			if not (getElementDimension(source) == 0) and (getElementInterior(source) == 0) and not (getElementDimension(source) == 2) then
				setElementDimension(source,0) --set him back to normal.
			end
		end
	end
end)
-- When a player dies allow the spawn protections
addEventHandler( "onPlayerWasted", root,
	function ()
		allowedAFK[source] = true
	end
)