local bans = {}
-- Set player job when he made a choise
addEvent( "onSetPlayerJob", true )
function onSetPlayerJob ( theTeam, theOccupation, theSkin, theWeapon, nrgb )
	local theArrests = exports.DENstats:getPlayerAccountData( source, "arrests" )
	if ( theArrests ) and ( theArrests < 280 ) and ( theOccupation == "Dog Force Officer" ) then
		exports.DENdxmsg:createNewDxMessage( source, "You need 280 or more arrests for this job!", 200, 0, 0 )
	else
		local playerID = exports.server:getPlayerAccountID( source )
		local acc = exports.server:getPlayerAccountName(source)
		for k,v in pairs(bans) do
			if v[1] == acc then
				if v[2] == "LawBan" then
					if theTeam == "Police" or theTeam == "Military Forcess" or theTeam == "SWAT Team" or theTeam == "Government Agency" then
						local mins = getTickCount()-v[3]
						mins = v[4]-mins
						mins=mins/1000
						mins=mins/60
						mins=math.floor(mins)
						if mins == 0 then mins = "Less then 1" end
						exports.DENdxmsg:createNewDxMessage( source, "You are currently banned from this job for "..mins.." more Minutes", 200, 0, 0 )
						return
					end
				else
					if v[2] == theOccupation then
						local mins = getTickCount()-v[3]
						mins = v[4]-mins
						mins=mins/1000
						mins=mins/60
						mins=math.floor(mins)
						if mins == 0 then mins = "Less then 1" end
						exports.DENdxmsg:createNewDxMessage( source, "You are currently banned from this job for "..mins.." more Minutes", 200, 0, 0 )
						return
					end
				end
			end
		end

		local oldOccupation = getElementData( source, "Occupation" )
		local oldTeam = getPlayerTeam( source )
		setElementData( source, "Occupation", theOccupation, true )
		setElementData( source, "Rank", theOccupation, true )
		setPlayerTeam ( source, getTeamFromName( theTeam ) )
		if (nrgb) then
			if (nrgb[1]) then
				setPlayerNametagColor(source,nrgb[1],nrgb[2],nrgb[3])
			else
				setPlayerNametagColor(source,false)
			end
			if getElementData(source,"Group") == "The Smurfs" or getElementData(source,"Group") == "The Terrorists" then
				if theOccupation == "Criminal" then
					if theSkin == 261 or theSkin == 136 then
						local pAccountID = exports.server:getPlayerAccountID(source)
						exports.denmysql:exec("UPDATE accounts SET skin=? WHERE id=?",theSkin,pAccountID)
					end
				end
			end
		else
			setPlayerNametagColor(source,false)
		end
		local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", theSkin, playerID)
		setElementModel ( source, theSkin )
		exports.DENdxmsg:createNewDxMessage( source, "You successfully changed your job!", 200, 0, 0 )
		exports.DENvehicles:reloadFreeVehicleMarkers( source, true )

		if ( theTeam ~= getTeamName( oldTeam ) ) then
			triggerEvent( "onPlayerTeamChange", source, oldTeam, getTeamFromName( theTeam ) )
		end
		triggerClientEvent(source,"onPlayerJobChange",source,theOccupation, oldOccupation, getTeamFromName( theTeam ) )
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
--[[
addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	if ( getElementData(source,"Occupation") == "Criminal" ) then
		if getElementData(source,"Group") ~= false then
			if getElementData(source,"Group") == "The Smurfs" then
				setPlayerNametagColor(source,139, 0, 139)
end)
--]]
-- Weapon controls
function deleteWhenLeftJob ()
	if (getTeamName(getPlayerTeam(source)) == "Unoccupied") or (getTeamName(getPlayerTeam(source)) == "Paramedics") then
		return
	else
		if getElementData(source,"skill") == "Support Unit" then return end
		takeWeapon ( source, 41 )
	end
	
	local team = getPlayerTeam(source)
	if not (team) then
		return false
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
	local playerData = exports.DENmysql:query("SELECT skin FROM accounts WHERE id=? LIMIT 1",playerID)
    local unemployedTeam = getTeamFromName ( "Unemployed" )

	setPlayerTeam ( source, unemployedTeam )

	setElementData ( source, "Occupation", "Unemployed" )
	triggerClientEvent( source, "updateLabel", source )
	exports.DENdxmsg:createNewDxMessage(source, "You have quit your job as ".. oldJob, 0, 200, 0)
	exports.DENvehicles:reloadFreeVehicleMarkers(source, true)

	if playerData and #playerData == 1 then
		if ( tonumber( playerData[1].skin ) == 0 ) then
			exports.DENcriminal:givePlayerCJClothes( source )
		else
			setElementModel ( source, tonumber( playerData[1].skin ) )
		end
	end

	triggerEvent( "onPlayerJobChange", source, "Unemployed", oldOccupation, unemployedTeam )
	triggerClientEvent(source,"onPlayerJobChange",source,"Unemployed", oldOccupation, unemployedTeam )
	triggerEvent( "onPlayerTeamChange", source, theTeam, unemployedTeam )
end
addEventHandler( "onQuitJob", root, onQuitJob )

addEvent( "onEndShift", true )
function onEndShift ()
	local theTeam = getPlayerTeam( source )
	local oldOccupation = getElementData( source, "Occupation" )
	local playerID = exports.server:getPlayerAccountID( source )
	local playerData = exports.DENmysql:query("SELECT skin FROM accounts WHERE id=? LIMIT 1",playerID)
	local unoccupiedTeam = getTeamFromName ( "Unoccupied" )

	setPlayerTeam ( source, unoccupiedTeam )

	triggerClientEvent( source, "updateLabel", source )
	exports.DENdxmsg:createNewDxMessage(source, "You have ended your shift!", 0, 200, 0)
	exports.DENvehicles:reloadFreeVehicleMarkers(source, false)

	if playerData and #playerData == 1 then
		if ( tonumber( playerData[1].skin ) == 0 ) then
			exports.DENcriminal:givePlayerCJClothes( source )
		else
			setElementModel ( source, tonumber( playerData[1].skin ) )
		end
	end

	triggerEvent( "onPlayerTeamChange", source, theTeam, unoccupiedTeam  )
	triggerClientEvent(source,"onPlayerJobChange",source,"Unemployed", oldOccupation, unemployedTeam )
	triggerEvent( "onPlayerJobChange", source, "Unemployed", oldOccupation, unoccupiedTeam )
end
addEventHandler( "onEndShift", root, onEndShift )

addEvent( "onStartShift", true )
function onStartShift ( theOccupation )
	local theTeam = getPlayerTeam( source )
	local setTeam = nil
	local playerID = exports.server:getPlayerAccountID( source )
	local playerData = exports.DENmysql:query("SELECT jobskin FROM accounts WHERE id=? LIMIT 1",playerID)

    if ( theOccupation == "Criminal" ) then
		if getElementData(source,"Group") ~= false then
			if getElementData(source,"Group") == "The Smurfs" or getElementData(source,"Group") == "The Terrorists"  then
				local skinID=261
				if ( getElementData(source,"Group") == "The Terrorists" ) then skinID = 136 end
				local playerID = exports.server:getPlayerAccountID(source)
				exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", skinID, playerID)
				exports.DENmysql:exec( "UPDATE accounts SET skin=? WHERE id=?", skinID, playerID)
			end
		end
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
	elseif ( theOccupation == "Government" ) then
		setTeam = getTeamFromName ( "Government Agency" )
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
	elseif ( theOccupation == "Federal Agent" ) then
		setTeam = getTeamFromName ( "Government Agency" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "News Reporter" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Taxi Driver" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Fuel Tank Driver" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Iron Miner" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Mortuary Agency" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Farmer" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	elseif ( theOccupation == "Photographer" ) then
		setTeam = getTeamFromName ( "Civilian Workers" )
		setPlayerTeam ( source, setTeam )
	else
		setTeam = getTeamFromName ( "Unemployed" )
		setPlayerTeam ( source, setTeam )
	end

	triggerClientEvent( source, "updateLabel", source )
	exports.DENdxmsg:createNewDxMessage(source, "You are back on shift as ".. theOccupation, 0, 200, 0)
	exports.DENvehicles:reloadFreeVehicleMarkers(source, false)
	if playerData and #playerData == 1 and playerData[1].jobskin then
		setElementModel ( source, tonumber( playerData[1].jobskin ) )
	end
	triggerEvent( "onPlayerTeamChange", source, theTeam, setTeam )
end
addEventHandler( "onStartShift", root, onStartShift )

function banFromJob(acc,name,mins)
	table.insert(bans,{acc,name,getTickCount(),mins*1000*60})
end

function unbanFromJob(acc,name)
	for k,v in pairs(bans) do
		if v[1] == acc and v[2] == name then
			table.remove(bans,k)
			return true
		end
	end
	return false
end

setTimer(function()
	for k,v in pairs(bans) do
		if getTickCount() - v[3] > v[4] then
			table.remove(bans,k)
		end
	end
end,5000,0)
