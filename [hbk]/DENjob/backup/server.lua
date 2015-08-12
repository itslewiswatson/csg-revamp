-- Set player job when he made a choise
addEvent( "onSetPlayerJob", true )
function onSetPlayerJob ( theTeam, theOccupation, theSkin, theWeapon )
	local theArrests = exports.DENstats:getPlayerAccountData( source, "arrests" )
	if ( theArrests ) and ( theArrests < 280 ) and ( theOccupation == "Dog Force Officer" ) then
		exports.DENdxmsg:createNewDxMessage( source, "You need 280 or more arrests for this job!", 200, 0, 0 )
	else
		local playerID = exports.server:getPlayerAccountID( source )
		local oldOccupation = getElementData( source, "Occupation" )
		local oldTeam = getPlayerTeam( source )
		setElementData( source, "Occupation", theOccupation, true )
		setElementData( source, "Rank", theOccupation, true )
		setPlayerTeam ( source, getTeamFromName( theTeam ) )

		local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", theSkin, playerID)
		setElementModel ( source, theSkin )
		exports.DENdxmsg:createNewDxMessage( source, "You successfully changed your job!", 200, 0, 0 )
		exports.DENvehicles:reloadFreeVehicleMarkers( source, true )
		
		if ( theTeam ~= getTeamName( oldTeam ) ) then
			triggerEvent( "onPlayerTeamChange", source, oldTeam, getTeamFromName( theTeam ) )
		end
		
		triggerEvent( "onPlayerJobChange", source, theOccupation, oldOccupation, getTeamFromName( theTeam ) )
		
		if ( theWeapon ) then
			giveWeapon( source, tonumber(theWeapon), 9999, true )
			
			if ( theOccupation == "Traffic Officer" ) then
				giveWeapon( source, 43, 9999 )
			end
		end
	end
end
addEventHandler( "onSetPlayerJob", root, onSetPlayerJob )

-- Weapon controls
function deleteWhenLeftJob ()
	if (getTeamName(getPlayerTeam(source)) == "Unoccupied") or (getTeamName(getPlayerTeam(source)) == "Paramedics") then
		return
	else
		takeWeapon ( source, 41 )
	end

	if (getTeamName(getPlayerTeam(source)) == "Police") or (getTeamName(getPlayerTeam(source)) == "SWAT") or (getTeamName(getPlayerTeam(source)) == "Military Forces") or (getTeamName(getPlayerTeam(source)) == "Unoccupied") or (getTeamName(getPlayerTeam(source)) == "Government Agency") then
		return
	else
		takeWeapon ( source, 3 )
	end
end
addEventHandler ( "onPlayerWeaponSwitch", root, deleteWhenLeftJob )

-- Serverside jobmenu
addEvent( "onQuitJob", true )
function onQuitJob (oldJob)
	local theTeam = getPlayerTeam( source )
	local oldOccupation = getElementData( source, "Occupation" )
	local playerID = exports.server:getPlayerAccountID( source )
	local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )
    local unemployedTeam = getTeamFromName ( "Unemployed" )
	
	setPlayerTeam ( source, unemployedTeam )

	setElementData ( source, "Occupation", "Unemployed" )
	triggerClientEvent( source, "updateLabel", source )
	exports.DENdxmsg:createNewDxMessage(source, "You have quit your job as ".. oldJob, 0, 200, 0)
	exports.DENvehicles:reloadFreeVehicleMarkers(source, true)
	
	if ( tonumber( playerData.skin ) == 0 ) then
		exports.DENcriminal:givePlayerCJClothes( source )
	else
		setElementModel ( source, tonumber( playerData.skin ) )
	end
	
	triggerEvent( "onPlayerJobChange", source, "Unemployed", oldOccupation, unemployedTeam )
	triggerEvent( "onPlayerTeamChange", source, theTeam, unemployedTeam )
end
addEventHandler( "onQuitJob", root, onQuitJob )

addEvent( "onEndShift", true )
function onEndShift ()
	local theTeam = getPlayerTeam( source )
	local oldOccupation = getElementData( source, "Occupation" )
	local playerID = exports.server:getPlayerAccountID( source )
	local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )
	local unoccupiedTeam = getTeamFromName ( "Unoccupied" )
	
	setPlayerTeam ( source, unoccupiedTeam )
	
	triggerClientEvent( source, "updateLabel", source )
	exports.DENdxmsg:createNewDxMessage(source, "You have ended your shift!", 0, 200, 0)
	exports.DENvehicles:reloadFreeVehicleMarkers(source, false)
	
	if ( tonumber( playerData.skin ) == 0 ) then
		exports.DENcriminal:givePlayerCJClothes( source )
	else
		setElementModel ( source, tonumber( playerData.skin ) )
	end
	
	triggerEvent( "onPlayerTeamChange", source, theTeam, unoccupiedTeam  )
	triggerEvent( "onPlayerJobChange", source, "Unemployed", oldOccupation, unoccupiedTeam )
end
addEventHandler( "onEndShift", root, onEndShift )

addEvent( "onStartShift", true )
function onStartShift ( theOccupation )
	local theTeam = getPlayerTeam( source )
	local setTeam = nil
	local playerID = exports.server:getPlayerAccountID( source )
	local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )

    if ( theOccupation == "Criminal" ) then
		setTeam = getTeamFromName ( "Criminals" )
		setPlayerTeam ( source, setTeam )
    elseif ( theOccupation == "Leading Staff" ) or ( theOccupation == "Important Staff" ) or ( theOccupation == "Experienced Staff" ) or ( theOccupation == "Loyal Staff" ) or ( theOccupation == "New Staff" ) or ( theOccupation == "Trial Staff" ) then
		setTeam = getTeamFromName ( "Staff" )
		setPlayerTeam ( source, setTeam )
    elseif ( theOccupation == "Police Officer" ) then
		setTeam = getTeamFromName ( "Police" )
		setPlayerTeam ( source, setTeam )
    elseif ( theOccupation == "Traffic Officer" ) then
		setTeam = getTeamFromName ( "Police" )
		setPlayerTeam ( source, setTeam )
    elseif ( theOccupation == "SWAT Team" ) then
		setTeam = getTeamFromName ( "SWAT" )
		setPlayerTeam ( source, setTeam )
    elseif ( theOccupation == "Military Forces" ) then
		setTeam = getTeamFromName ( "Military Forces" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Airforce" ) then
		setTeam = getTeamFromName ( "Military Forces" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Royal Army" ) then
		setTeam = getTeamFromName ( "Military Forces" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Special Agent" ) then
		setTeam = getTeamFromName ( "Government Agency" )
		setPlayerTeam ( source, setTeam )
    elseif ( theOccupation == "Paramedic" ) then
		setTeam = getTeamFromName ( "Paramedics" )
		setPlayerTeam ( source, setTeam )
    elseif ( theOccupation == "Prostitute" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Pilot" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Special Agent" ) then
		setTeam = getTeamFromName ( "Government Agency" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Mechanic" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Trucker" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Bus Driver" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Firefighter" ) then
		setTeam = getTeamFromName ( "Firefighters" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "K-9 Unit Officer" ) then
		setTeam = getTeamFromName ( "Police" )
		setPlayerTeam ( source, setTeam )
	else
		setTeam = getTeamFromName ( "Unemployed" )
		setPlayerTeam ( source, setTeam )
	end

	triggerClientEvent( source, "updateLabel", source )
	exports.DENdxmsg:createNewDxMessage(source, "You are back on shift as ".. theOccupation, 0, 200, 0)
	exports.DENvehicles:reloadFreeVehicleMarkers(source, false)
	setElementModel ( source, tonumber( playerData.jobskin ) )
	
	triggerEvent( "onPlayerTeamChange", source, theTeam, setTeam )
end
addEventHandler( "onStartShift", root, onStartShift )