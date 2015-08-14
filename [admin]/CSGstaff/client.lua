-- Table
local staffTable = {}

-- Staff skin mods
txd = engineLoadTXD("Admin Skins/wmyclot.txd")
engineImportTXD(txd, 217)
dff = engineLoadDFF("Admin Skins/wmyclot.dff", 217)
engineReplaceModel(dff, 217)

-- When a player attacks a staff cancel it and take some health from the player
addEventHandler ( "onClientPlayerDamage", root, 
	function ( attacker, weapon, bodypart, loss )
		if ( getPlayerTeam( source ) ) then
			if (attacker ) and ( getElementType( attacker ) == "ped" ) then return end
			if ( getTeamName( getPlayerTeam( source ) ) == "Staff" ) then
				cancelEvent ()
			end
			
			if ( attacker ) then
				if ( getElementType( attacker ) == "vehicle" ) then attacker = getVehicleController( attacker ) end
				if ( attacker ~= source ) and ( getTeamName( getPlayerTeam( attacker ) ) ~= "Staff" ) and ( getTeamName( getPlayerTeam( source ) ) == "Staff" ) then
					setElementHealth( attacker, ( getElementHealth( attacker ) -loss ) )
				end
			end
		end
	end
)

-- Sync for staff table
addEvent( "onSyncAdminTable", true )
addEventHandler( "onSyncAdminTable", root,
	function ( theTable, thePlayer )
		if not ( theTable ) then return end
		if ( isElement( thePlayer ) ) then
			staffTable[thePlayer] = theTable
		else
			staffTable = theTable
		end
	end
)

-- Request table when resource starts
addEventHandler( "onClientResourceStart", root,
	function ()
		triggerServerEvent( "onRequestSyncAdminTable", localPlayer )
	end
)

-- Function to check if a player is staff
function isPlayerStaff ( thePlayer )
	if ( staffTable[thePlayer] ) then
		return true
	else
		return false
	end
end

-- Function to check if a player is a developer
function isPlayerDeveloper ( thePlayer )
	if ( staffTable[thePlayer] ) then
		if ( staffTable[thePlayer].developer == 1 ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Check if a player is a eventmanager
function isPlayerEventManager ( thePlayer )
	if ( staffTable[thePlayer] ) then
		if ( staffTable[thePlayer].eventmanager == 1 ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- check if player is basemod
function isPlayerBaseMod ( thePlayer )
	if ( staffTable[thePlayer] ) then
		return staffTable[thePlayer].basemod == 1
	else
		return false
	end
end

-- Function that gets the staff level of a player
function getPlayerAdminLevel ( thePlayer )
	if ( staffTable[thePlayer] ) then
		if ( staffTable[thePlayer].rank ) then
			return staffTable[thePlayer].rank
		else
			return false
		end
	else
		return false
	end
end

addEvent("checkForStaffCmdBind",true)
addEventHandler("checkForStaffCmdBind",root,
function()
	outputDebugString("Scanning...")
	local hasBinded = getKeyBoundToCommand("staff")
	if (hasBinded == false) then
		outputDebugString("Bind not found, sending back...")
		triggerServerEvent("returnHasPlayerGotStaffBinded",localPlayer,false)
	else
		outputDebugString("Bind found, sending back...")
		triggerServerEvent("returnHasPlayerGotStaffBinded",localPlayer,true)
	end
end)