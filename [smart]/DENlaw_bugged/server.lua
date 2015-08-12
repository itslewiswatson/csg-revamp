-- Update player wanted level
setTimer (
function ()
	for k, thePlayer in pairs ( getElementsByType( "player" ) ) do
		setPlayerNametagText( thePlayer, getPlayerName( thePlayer ).." (" .. tostring( getPlayerWantedLevel ( thePlayer ) ) .. ")" )
	end
end
, 5000 , 0)

tazerAssists = {}

addEventHandler( "onElementDataChange", root,
function ( dataName )
	if ( exports.server:getPlayerAccountName ( source ) ) then
		if ( dataName == "wantedPoints" ) then
			local wantedPoints = getElementData ( source, dataName )
			if ( wantedPoints > 9 ) and ( wantedPoints < 20 ) then
				setPlayerWantedLevel( source, 1 )
			elseif ( wantedPoints > 19 ) and ( wantedPoints < 29 ) then
				setPlayerWantedLevel( source, 2 )
			elseif ( wantedPoints > 29 ) and ( wantedPoints < 39 ) then
				setPlayerWantedLevel( source, 3 )
				removeJobDueWantedLevel( source, "Emergency" )
			elseif ( wantedPoints > 39 ) and ( wantedPoints < 49 ) then
				setPlayerWantedLevel( source, 4 )
				removeJobDueWantedLevel( source, "All Jobs" )
			elseif ( wantedPoints > 49 ) and ( wantedPoints < 59 ) then
				setPlayerWantedLevel( source, 5 )
				removeJobDueWantedLevel( source, "All Jobs" )
			elseif ( wantedPoints > 59 ) then
				setPlayerWantedLevel( source, 6 )
				removeJobDueWantedLevel( source, "All Jobs" )
			elseif ( wantedPoints < 10 ) then
				setPlayerWantedLevel( source, 0 )
			end
			setPlayerNametagText( source, getPlayerName( source ).." (" .. tostring( getPlayerWantedLevel ( source ) ) .. ")" )
		end
	end
end
)

local warns = {}
local complied = {}
local warnsCD = {}
addEventHandler("onPlayerCommand",root,function(c)
	if c == "surr" then
		local t = getElementsByType("player")
		local n = getPlayerName(source)
		local x,y,z = getElementPosition(source)
		local msg
		local zonename = getZoneName(x,y,z)
		if warns[source] and getTickCount()-warns[source]<=10000 then
			msg = n.." has complied and surrendered at "..zonename..""
			complied[source] = true
		else
			msg = n.." has surrendered to law at "..zonename..""
		end
		for k,v in pairs(t) do
			if isPlayerLawEnforcer(v) then
				exports.killmessages:outputMessage(msg,v,0,255,0)
			end
		end
	end
end)

addEventHandler("onPlayerQuit",root,function() if complied[source] then complied[source] = nil end end)

function warn(ps,_,name)
	if isPlayerLawEnforcer(ps) then
		if warnsCD[ps] then
			exports.DENdxmsg:createNewDxMessage(ps,"Please wait before trying to warn again",255,0,0)
			return
		end
		local t = getElementsByType("player")
		local sdist = 9999
		local scrim = false
		local px,py,pz = getElementPosition(ps)
		for k,v in pairs(t) do
			if getPlayerWantedLevel(v) > 0 and not(isPlayerLawEnforcer(v)) then
				local x,y,z = getElementPosition(v)
				local dist = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				if dist < 10 and dist < sdist then sdist = dist scrim = v end
			end
		end
		if scrim then
			if isElement(scrim) then
				if not warns[scrim] then
					warns[scrim] = getTickCount()
					local pname = getPlayerName(ps)
					local cname = getPlayerName(scrim)
					if isPedInVehicle(scrim) then
						exports.DENdxmsg:createNewDxMessage(scrim,getElementData(ps,"Rank").." "..pname.." has asked you to Pull Over!",255,0,0)
						exports.DENdxmsg:createNewDxMessage(ps,"Asked "..cname.." to Pull Over!",0,255,0)
						for k,v in pairs(t) do
							if isPlayerLawEnforcer(v) then
								exports.killmessages:outputMessage(""..pname.." has asked "..cname.." to Pull Over",v,0,0,255)
							end
						end

					else
						exports.DENdxmsg:createNewDxMessage(scrim,getElementData(ps,"Rank").." "..pname.." has asked you to surrender!",255,0,0)
						exports.DENdxmsg:createNewDxMessage(scrim,"Use /surr to surrender within 10 seconds for decreased jail time!",255,0,0)
						exports.DENdxmsg:createNewDxMessage(ps,"Asked "..cname.." to give himself up and surrender!",0,255,0)
						for k,v in pairs(t) do
							if isPlayerLawEnforcer(v) then
								exports.killmessages:outputMessage(""..pname.." has asked "..cname.." to Surrender",v,0,0,255)
							end
						end
					end
				else
					exports.DENdxmsg:createNewDxMessage(ps,getPlayerName(scrim).." was warned recently, please wait before warning again",255,0,0)
				end
			else
				exports.DENdxmsg:createNewDxMessage(ps,"There is no wanted person nearby to warn",255,0,0)
			end
		end
	end
end
addCommandHandler("warn",warn)

setTimer(function()
	local count = getTickCount()
	for k,v in pairs(warns) do
		if count-v > 20000 then
			warns[k]=nil
		end
	end
	for k,v in pairs(warnsCD) do
		if count-v > 3000 then
			warns[k]=nil
		end
	end
end,1000,0)

local tazer = {}

-- Kick from job if the player is high wanted
function removeJobDueWantedLevel (thePlayer, type)
	if not ( getTeamName( getPlayerTeam( thePlayer ) ) == "Criminals" ) then
		if ( type == "Emergency" ) then
			if (getTeamName(getPlayerTeam(thePlayer)) == "Police") or (getTeamName(getPlayerTeam(thePlayer)) == "SWAT")
			or (getTeamName(getPlayerTeam(thePlayer)) == "Military Forces") or (getTeamName(getPlayerTeam(thePlayer)) == "Paramedics") or (getTeamName(getPlayerTeam(thePlayer)) == "Government Agency") then

			exports.DENcriminal:setPlayerCriminal( thePlayer )
			triggerEvent( "onPlayerJobKick", thePlayer )

			end
		elseif type == "All Jobs" then

			exports.DENcriminal:setPlayerCriminal( thePlayer )

		end
	end
end

local arrestTable = {}

-- Add a new player to the arrested table of the cop
function addCopArrestedPlayer ( theCop, thePrisoner )
	if not arrestTable[theCop] then
		arrestTable[theCop] = {}
	end

	table.insert ( arrestTable[theCop], thePrisoner )
end

-- Remove a player from the arrest table of the cop
function removeCopArrestedPlayer ( theCop, thePrisoner )
	if arrestTable[theCop] then
		for i=1,#arrestTable[theCop] do
			if arrestTable[theCop][i] == thePrisoner then
				table.remove ( arrestTable[theCop], i )
			end
		end
	end
end

-- Get all the arrested players of the cop
function getCopArrestedPlayers ( theCop )
	return arrestTable[theCop]
end

-- When the player got arrested by a nightstick
function onPlayerNightstickArrest ( attacker, weapon, bodypart, loss )
	if isElement(attacker) and (weapon == 3) then
		--if getControlState(attacker,"aim_weapon") == true then return end
	setElementHealth(source, getElementHealth( source ) + loss)
		if (getTeamName(getPlayerTeam(attacker)) == "Police") or (getTeamName(getPlayerTeam(attacker)) == "SWAT") or (getTeamName(getPlayerTeam(attacker)) == "Military Forces") or (getTeamName(getPlayerTeam(attacker)) == "Government Agency") then
			if ( isArrestAllowedForLaw ( attacker, source ) ) then
				if canCopArrest (attacker, source) then
					if not(getElementData ( source, "isPlayerArrested" )) and ( getPlayerWantedLevel(source) > 0 ) then
						triggerEvent( "onPlayerNightstickHit", source, attacker )
						if ( not wasEventCancelled() ) then
							if ( getElementData ( source, "isPlayerRobbing" ) ) and ( getElementDimension( source ) == 1 ) or ( getElementDimension( source ) == 2 ) or ( getElementDimension( source ) == 3 ) then
								return
							else
								local player = tazer[source]
								if (player) then
									if (player ~= attacker) then
										exports.DENdxmsg:createNewDxMessage(player, "You assisted in an arrest (tazer) when this player gets jailed you will get 50% of the money!", 0, 225, 0)
									end
								end
								setElementData ( source, "isPlayerArrested", true )
								toggleAllControls ( source, false, true, false )
								giveWeapon ( source, 0, 0, true )
								triggerClientEvent( source, "onClientFollowTheCop", source, attacker, source)
								triggerClientEvent( source, "onPlayerSetArrested", source )
								exports.DENdxmsg:createNewDxMessage(source, "You got arrested by " .. getPlayerName(attacker) .. "!", 0, 225, 0)
								exports.DENdxmsg:createNewDxMessage(attacker, "You arrested " .. getPlayerName(source) .. "!", 0, 225, 0)
								addCopArrestedPlayer ( attacker, source )
								setElementData( source, "arrestedBy", attacker )
								setCameraTarget ( source, source )
								triggerEvent( "onPlayerArrest", source, attacker )
								onCheckForJailPoints ( attacker, true )
								showCursor ( source, true, true )

								setElementData ( source, "isPlayerRobbing", false )
								setElementData( source, "robberyFinished", false )
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerDamage", root, onPlayerNightstickArrest )

function onCheckForJailPoints ( theCop, state )
	if state and arrestTable[theCop] then
		triggerClientEvent ( theCop, "onCreateJailPoints", theCop )
	elseif not state and #arrestTable[theCop] == 0 then
		triggerClientEvent ( theCop, "onRemoveJailPoints", theCop )
	else
		triggerClientEvent ( theCop, "onRemoveJailPoints", theCop )
	end
end

-- Function that warp a player into the vehicle
function warpPrisonerIntoVehicle (officer)
local officerVehicle = getPedOccupiedVehicle ( officer )
local officerVehicleSeats = getVehicleMaxPassengers( officerVehicle )
local officerVehicleOccupants = getVehicleOccupants( officerVehicle )
	for seat = 0, officerVehicleSeats do
		local occupant = officerVehicleOccupants[seat]
		if not occupant then
			warpPedIntoVehicle( source, officerVehicle, seat)
		end
	end
end
addEvent("warpPrisonerIntoVehicle", true)
addEventHandler("warpPrisonerIntoVehicle", root, warpPrisonerIntoVehicle)

-- Function that removes a player out the vehicle
function removePrisonerOutVehicle (theOfficer)
	removePedFromVehicle ( source )
	local x, y, z = getElementPosition ( theOfficer )
	setElementPosition ( source, x + 2, y + 2, z )
end
addEvent("removePrisonerOutVehicle", true)
addEventHandler("removePrisonerOutVehicle", root, removePrisonerOutVehicle)

-- Function that checks if the cop can arrest
function canCopArrest( officer, thePrisoner )
	-- Check if the player already has 2 prisoners
	if ( arrestTable[officer] ) then
		if ( #arrestTable[officer] > 2 ) then
			return false
		else
			return true
		end
	else
		return true
	end
end

-- Check so Police can't arrest SWAT or MF and SWAT and MF can't arrest eachother
function isArrestAllowedForLaw ( officer, thePrisoner )
	if ( thePrisoner ) and ( officer ) and ( officer ~= thePrisoner ) and ( getTeamName( getPlayerTeam( officer ) ) ) and ( getTeamName( getPlayerTeam( thePrisoner ) ) ) then
		local attackerTeam = (getTeamName(getPlayerTeam(officer)))
		local sourceTeam = (getTeamName(getPlayerTeam(thePrisoner)))
		if ( attackerTeam == "Police" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) or ( sourceTeam == "Police" ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "SWAT" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				return false
			elseif ( sourceTeam == "Police" ) and ( getElementData( thePrisoner, "wantedPoints" ) < 9 ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "Military Forces" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				return false
			elseif ( sourceTeam == "Police" ) and ( getElementData( thePrisoner, "wantedPoints" ) < 9 ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "Government Agency" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				return false
			elseif ( sourceTeam == "Police" ) and ( getElementData( thePrisoner, "wantedPoints" ) < 9 ) then
				return false
			else
				return true
			end
		end
	end
end

-- /release function of the cop
function releasePlayerFromArrest (officer, cmd, prisoner)
	if ( arrestTable[officer] ) then
		if ( prisoner == "*" ) then
			for i, element in ipairs ( arrestTable[officer] ) do
				exports.DENdxmsg:createNewDxMessage(element, "You are now free! RUN!", 0, 225, 0)
				setElementData ( element, "isPlayerArrested", false )
				toggleAllControls ( element, true, true, true )
				onCheckForJailPoints ( officer, false )
				showCursor ( element, false, false )
				if (tazer[element]) then
					tazer[element] = false
				end
			end
			exports.DENdxmsg:createNewDxMessage(officer, "You released all players under your custody!", 0, 225, 0)
			arrestTable[officer] = {}
		else
			local getPrisoner = exports.server:getPlayerFromNamePart( prisoner )
			for i=1,#arrestTable[officer] do
				local thePrisoner = arrestTable[officer][i]
				if ( getPrisoner ) and ( getPrisoner == thePrisoner ) then
					exports.DENdxmsg:createNewDxMessage(officer, "You released ".. getPlayerName( thePrisoner ) .."!", 0, 225, 0)
					exports.DENdxmsg:createNewDxMessage(thePrisoner, "You are now free! RUN!", 0, 225, 0)
					setElementData ( thePrisoner, "isPlayerArrested", false )
					toggleAllControls ( thePrisoner, true, true, true )
					removeCopArrestedPlayer ( officer, thePrisoner )
					onCheckForJailPoints ( officer, false )
					showCursor ( thePrisoner, false )
					if (tazer[thePrisoner]) then
						tazer[thePrisoner] = false
					end
				else
					exports.DENdxmsg:createNewDxMessage(officer, "We couldn't find a player with that name!", 225, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("release", releasePlayerFromArrest)

addEvent("CSGbribe.accepted",true)
addEventHandler("CSGbribe.accepted",root,releasePlayerFromArrest)

-- Serverside part when player got tazerd, source is the officer
addEvent("onWantedPlayerGotTazerd", true)
function onWantedPlayerGotTazerd ( prisoner, dogTaz )


	if ( isElement( source ) ) then
		giveWeapon ( source, 3, 1, true )
	end

	if ( isElement(prisoner) ) then
		if tazerAssists[prisoner] == nil then tazerAssists[prisoner] = {} end
		local exists = false
		for k,v in pairs(tazerAssists[prisoner]) do
			if v == source then exists=true break end
		end
		if exists==false then
			table.insert(tazerAssists[prisoner],source)
		end
		if (getPlayerPing(prisoner) < 300) then
			tazer[prisoner] = source
			setTimer(destroyTazerTable, 3800, 1, prisoner)
			setTimer(function() setPedAnimation(prisoner, "CRACK", "crckidle2") end,2000,1)
			setTimer(setPedAnimation, 3800, 1, prisoner)
			giveWeapon ( prisoner, 0, 0, true )
			local p = prisoner
			toggleControl(p,"fire",false)
			toggleControl(p,"jump",false)
			toggleControl(p,"sprint",false)
			setControlState(p,"walk",true)
			toggleControl(p,"aim_weapon",false)
			setTimer(function()
			toggleControl(p,"jump",true)
			toggleControl(p,"sprint",true)
			toggleControl(p,"fire",true)
			toggleControl(p,"aim_weapon",true)
			setControlState(p,"walk",false)
			end,3800,1)
			--toggleAllControls ( prisoner, false, true, false )
			--setTimer(toggleAllControls, 3000, 1, prisoner, true, true, true)
		elseif (getPlayerPing(prisoner) > 300) then
			tazer[prisoner] = source
			setTimer(destroyTazerTable, 4000, 1, prisoner)
			setTimer(function() setPedAnimation(prisoner, "CRACK", "crckidle2") end,2000,1)
			setTimer(setPedAnimation, 4000, 1, prisoner)
			local p = prisoner
			giveWeapon ( prisoner, 0, 0, true )
			toggleControl(p,"jump",false)
			toggleControl(p,"fire",false)
			toggleControl(p,"sprint",false)
			toggleControl(p,"aim_weapon",false)
			setControlState(p,"walk",true)
			setTimer(function()
			toggleControl(p,"jump",true)
			toggleControl(p,"sprint",true)
			toggleControl(p,"fire",true)
			toggleControl(p,"aim_weapon",true)
			setControlState(p,"walk",false)
			end,4000,1)
			--toggleAllControls ( prisoner, false, true, false )
			--setTimer(toggleAllControls, 5000, 1, prisoner, true, true, true)
		end
	end

	if ( dogTaz ) then
		local theAnimal = exports.CSGanimals:getPlayerAnimal ( source )
		if ( theAnimal ) then
			exports.CSGanimals:setAnimalFollowing ( theAnimal, prisoner )
			setTimer( call, 6000, 1, getResourceFromName("CSGanimals"), "resetAnimalFollowing", theAnimal )
			setElementHealth( prisoner, getElementHealth( prisoner ) -5 )
		end
	end
end
addEventHandler("onWantedPlayerGotTazerd", root, onWantedPlayerGotTazerd)

function destroyTazerTable(plr)
	if (not getElementData(plr, "isPlayerArrested")) then
		if (not tazer[plr]) then return end
		tazer[plr] = false
		tazer[plr] = {}
	end
end

-- Release when the cop dies
addEventHandler( "onPlayerWasted", root,
function( ammo, attacker, weapon, bodypart )
	if ( exports.server:getPlayerAccountName ( source ) ) then
		if (getTeamName(getPlayerTeam(source)) == "Police") or (getTeamName(getPlayerTeam(source)) == "SWAT") or (getTeamName(getPlayerTeam(source)) == "Military Forces") or (getTeamName(getPlayerTeam(source)) == "Government Agency") then
			if arrestTable[source] then
				for i, element in ipairs ( arrestTable[source] ) do
					exports.DENdxmsg:createNewDxMessage(element, "The cop died! You're free again.", 0, 225, 0)
					setElementData ( element, "isPlayerArrested", false )
					toggleAllControls ( element, true, true, true )
					onCheckForJailPoints ( source, false )
					showCursor ( element, false, false )
				end
				arrestTable[source] = {}
			end
		end
	end
end
)

addEvent("onPlayerJobChange",true)
addEventHandler("onPlayerJobChange",root,function(new,old)
	if arrestTable[source] then
			for i, element in ipairs ( arrestTable[source] ) do
				exports.DENdxmsg:createNewDxMessage(element, "The cop quit his job! You're free again.", 0, 225, 0)
				setElementData ( element, "isPlayerArrested", false )
				toggleAllControls ( element, true, true, true )
				onCheckForJailPoints ( source, false )
				showCursor ( element, false, false )
			end
		arrestTable[source] = {}
	end
end)

-- Release when the cop reconnect
addEventHandler( "onPlayerQuit", root,
function()
	if ( exports.server:getPlayerAccountName ( source ) ) then
		if ( getPlayerTeam( source ) ) and (getTeamName(getPlayerTeam(source)) == "Police") or (getTeamName(getPlayerTeam(source)) == "SWAT") or (getTeamName(getPlayerTeam(source)) == "Military Forces") or (getTeamName(getPlayerTeam(source)) == "Government Agency") then
			if arrestTable[source] then
				for i, element in ipairs ( arrestTable[source] ) do
					exports.DENdxmsg:createNewDxMessage(element, "The cop disconnected! You're free again!", 0, 225, 0)
					setElementData ( element, "isPlayerArrested", false )
					toggleAllControls ( element, true, true, true )
					showCursor ( element, false, false )
				end
				arrestTable[source] = {}
			end
		end
	end
end
)

-- Get nearst copy
function getNearestCop( thePlayer )
	if ( exports.server:getPlayerAccountName ( thePlayer ) ) then
		local x, y, z = getElementPosition( thePlayer )
		local distance = nil
		local theCopNear = nil
		for i, theCop in ipairs ( getElementsByType( "player" ) ) do
			local x1, x2, x3 = getElementPosition( theCop )
			if ( exports.server:getPlayerAccountName ( theCop ) ) then
				if (getTeamName(getPlayerTeam(theCop)) == "Police") or (getTeamName(getPlayerTeam(theCop)) == "SWAT") or (getTeamName(getPlayerTeam(theCop)) == "Military Forces") or (getTeamName(getPlayerTeam(theCop)) == "Government Agency") then
					if ( distance ) and ( getDistanceBetweenPoints2D( x, y, x1, x2 ) < distance ) then
						distance = getDistanceBetweenPoints2D( x, y, x1, x2 )
						theCopNear = theCop
					elseif ( getDistanceBetweenPoints2D( x, y, x1, x2 ) < 40 ) then
						distance = getDistanceBetweenPoints2D( x, y, x1, x2 )
						theCopNear = theCop
					end
				end
			end
		end
		return theCopNear
	end
end

-- When the player that is arrest quit
addEventHandler( "onPlayerQuit", root,
	function(typ)
		if ( exports.server:getPlayerAccountName ( source ) ) and ( getElementData ( source, "isPlayerArrested" ) ) then
			local theCop = getElementData( source, "arrestedBy" )
			if typ ~= "Bad Connection" and typ ~= "Timed Out" and typ ~= "Unknown" then
				exports.CSGscore:takePlayerScore(source,5)
			end
			if ( arrestTable[theCop] ) then
				for i=1,#arrestTable[theCop] do
					local thePrisoner = arrestTable[theCop][i]
					if ( thePrisoner == source ) then
						local userID = exports.server:getPlayerAccountID( source )
						local wantedPoints = getElementData ( source, "wantedPoints" )
						local jailTime = ( math.floor(tonumber(wantedPoints) * 100 / 26 ) )/2
						local jailMoney = ( math.floor(tonumber(wantedPoints) * 200 / 4.2 ) )
						if tazerAssists[source] == nil then tazerAssists[source] = {} end
						for k,v in pairs(tazerAssists[source]) do
							if v ~= theCop and isElement(v) then
								exports.denstats:setPlayerAccountData(v,"tazerassists",(exports.denstats:getPlayerAccountData(v,"tazerassists"))+1)
							end
						end
						tazerAssists[source] = nil
						if isElementWithinColShape(source,LVcol) == true then
							jailMoney=jailMoney*4
						end
						local addJail = exports.DENmysql:exec( "INSERT INTO jail SET userid=?, jailtime=?, jailplace=?", userID, tonumber(jailTime), "LS1" )
						givePlayerMoney ( theCop, tonumber(jailMoney) )

						exports.DENstats:setPlayerAccountData ( theCop, "arrests", exports.DENstats:getPlayerAccountData ( theCop, "arrests" ) + 1 )
						exports.DENstats:setPlayerAccountData ( theCop, "arrestpoints", exports.DENstats:getPlayerAccountData ( theCop, "arrestpoints" ) + tonumber(wantedPoints) )

						local message = exports.DENdxmsg:createNewDxMessage(theCop, "" .. getPlayerName(source) .." quited you earned $".. jailMoney .."", 0, 225, 0)
						removeCopArrestedPlayer ( theCop, source )
						onCheckForJailPoints ( theCop, false )
					end
				end
			end
		elseif ( exports.server:getPlayerAccountName ( source ) ) and not ( getElementData ( source, "isPlayerArrested" ) ) and not(getElementData ( source, "isPlayerJailed" )) and ( getElementData ( source, "wantedPoints" ) >= 10 ) then
			local nearestCop = getNearestCop( source )
			if ( nearestCop ) and not ( nearestCop == source ) then
				local userID = exports.server:getPlayerAccountID( source )
				local wantedPoints = getElementData ( source, "wantedPoints" )
				local jailTime = ( math.floor(tonumber(wantedPoints) * 100 / 26 ) )/2
				local jailMoney = ( math.floor(tonumber(wantedPoints) * 200 / 4.2 ) )
				if isElementWithinColShape(source,LVcol) == true then
					jailMoney=jailMoney*4
				end
				if tazerAssists[source] == nil then tazerAssists[source] = {} end
				for k,v in pairs(tazerAssists[source]) do
					if v ~= theCop and isElement(v) then
						exports.denstats:setPlayerAccountData(v,"tazerassists",(exports.denstats:getPlayerAccountData(v,"tazerassists"))+1)
					end
				end
				tazerAssists[source] = nil
				local addJail = exports.DENmysql:exec( "INSERT INTO jail SET userid=?, jailtime=?, jailplace=?", userID, tonumber(jailTime), "LS1" )
				givePlayerMoney ( nearestCop, tonumber(jailMoney) )
				if type(exports.DENstats:getPlayerAccountData ( theCop, "arrests" )) == "boolean" then

				else
					exports.DENstats:setPlayerAccountData ( theCop, "arrests", exports.DENstats:getPlayerAccountData ( theCop, "arrests" ) + 1 )
					exports.DENstats:setPlayerAccountData ( theCop, "arrestpoints", exports.DENstats:getPlayerAccountData ( theCop, "arrestpoints" ) + tonumber(wantedPoints) )
				end

				local message = exports.DENdxmsg:createNewDxMessage(nearestCop, "" .. getPlayerName(source) .." evaded his arrest, you earned $".. jailMoney .."!", 0, 225, 0)
			end
		end
	end
)

-- Release when vehicle with wanted player in it get too damaged
function onCopVehicleDamage( loss )
	if ( getElementHealth ( source ) < 380 ) then
		local occupants = getVehicleOccupants( source )
		local seats = getVehicleMaxPassengers( source )
		for seat = 0, seats do
			local occupant = occupants[seat]
			if occupant and getElementType(occupant)=="player" then
				if getElementData ( occupant, "isPlayerArrested" ) then
					exports.DENdxmsg:createNewDxMessage(thePrisoner, "The cop vehicle broke down! You're free now!", 0, 225, 0)
					setElementData ( occupant, "isPlayerArrested", false )
					toggleAllControls ( occupant, true, true, true )
					removeCopArrestedPlayer ( getElementData( occupant, "arrestedBy" ), occupant )
					removePedFromVehicle( occupant )
					onCheckForJailPoints ( getElementData( occupant, "arrestedBy" ), false )
					showCursor ( occupant, false, false )
				end
			end
		end
    end
end
addEventHandler ( "onVehicleDamage", root, onCopVehicleDamage )

addEvent( "onServerPlayerJailed" )
addEventHandler ( "onServerPlayerJailed", root,
	function ()
		local arrestedTable = getCopArrestedPlayers( source )
		if ( arrestedTable ) then
			for i, thePrisoner in ipairs ( arrestedTable ) do
				exports.DENdxmsg:createNewDxMessage(thePrisoner, "The cop get jailed! You're free again!", 0, 225, 0)
				setElementData ( thePrisoner, "isPlayerArrested", false )
				toggleAllControls ( thePrisoner, true, true, true )
				removeCopArrestedPlayer ( source, thePrisoner )
				onCheckForJailPoints ( source, false )
				showCursor ( thePrisoner, false, false )
			end
		end
	end
)

addEvent( "onPlayerJobKick" )
-- When the cop get kicked from job release wanteds
function onCopRemoveJob()
	local arrestedTable = getCopArrestedPlayers( source )
	if ( arrestedTable ) then
		for i, thePrisoner in ipairs ( arrestedTable ) do
			exports.DENdxmsg:createNewDxMessage(thePrisoner, "Cop switched job! You're free again!", 0, 225, 0)
			setElementData ( thePrisoner, "isPlayerArrested", false )
			toggleAllControls ( thePrisoner, true, true, true )
			removeCopArrestedPlayer ( source, thePrisoner )
			onCheckForJailPoints ( source, false )
			showCursor ( thePrisoner, false, false )
		end
	end
end
addEventHandler ( "onPlayerJobKick", root, onCopRemoveJob )

-- Arrest when a cop jacks him
function onCopJackWantedPlayer ( thePlayer, seat, jacked )
    if (getTeamName(getPlayerTeam(thePlayer)) == "Police") or (getTeamName(getPlayerTeam(thePlayer)) == "SWAT") or (getTeamName(getPlayerTeam(thePlayer)) == "Military Forces") or (getTeamName(getPlayerTeam(thePlayer)) == "Government Agency")  then
        if ( jacked ) and ( seat == 0 ) then
			if ( isArrestAllowedForLaw ( thePlayer, jacked ) ) and ( canCopArrest( thePlayer, jacked ) ) then
				if ( getElementData( jacked, "wantedPoints" ) > 9 ) and not ( getElementData( jacked, "isPlayerArrested" ) ) and not ( getElementData( jacked, "isPlayerJailed" ) ) then
					setElementData ( jacked, "isPlayerArrested", true )
					toggleAllControls ( jacked, false, true, false )
					giveWeapon ( jacked, 0, 0, true )
					triggerClientEvent( jacked, "onClientFollowTheCop", jacked, thePlayer, jacked)
					exports.DENdxmsg:createNewDxMessage(jacked, "You got arrested by " .. getPlayerName(thePlayer) .. "!", 0, 225, 0)
					exports.DENdxmsg:createNewDxMessage(thePlayer, "You arrested " .. getPlayerName(jacked) .. "!", 0, 225, 0)
					addCopArrestedPlayer ( thePlayer, jacked )
					setElementData( jacked, "arrestedBy", thePlayer )
					onCheckForJailPoints ( thePlayer, true )
					showCursor ( jacked, true, true )
				end
			end
		end
    end
end
addEventHandler ( "onVehicleEnter", root, onCopJackWantedPlayer )

-- Arrest all wanted player in the vehicle
function onCopJackWantedPlayer ( thePlayer, seat, jacked )
	if not (isElement(thePlayer)) then return end
    if (getTeamName(getPlayerTeam(thePlayer)) == "Police") or (getTeamName(getPlayerTeam(thePlayer)) == "SWAT") or (getTeamName(getPlayerTeam(thePlayer)) == "Military Forces") or (getTeamName(getPlayerTeam(thePlayer)) == "Government Agency")  then
        if ( seat == 0 ) then
			local occupants = getVehicleOccupants( source )
			local seats = getVehicleMaxPassengers( source )
			for seat = 0, seats do
				local occupant = occupants[seat]
				if ( occupant ) and ( getElementType(occupant)=="player" ) then
					if ( isArrestAllowedForLaw ( thePlayer, occupant ) ) and ( canCopArrest( thePlayer, occupant ) ) then
						if getElementData( occupant, "wantedPoints" ) > 9 and not ( getElementData( occupant, "isPlayerArrested" ) ) and not ( getElementData( occupant, "isPlayerJailed" ) ) then
							setElementData ( occupant, "isPlayerArrested", true )
							toggleAllControls ( occupant, false, true, false )
							giveWeapon ( occupant, 0, 0, true )
							triggerClientEvent( occupant, "onClientFollowTheCop", occupant, thePlayer, occupant)
							exports.DENdxmsg:createNewDxMessage(occupant, "You got arrested by " .. getPlayerName(thePlayer) .. "!", 0, 225, 0)
							exports.DENdxmsg:createNewDxMessage(thePlayer, "You arrested " .. getPlayerName(occupant) .. "!", 0, 225, 0)
							addCopArrestedPlayer ( thePlayer, occupant )
							setElementData( occupant, "arrestedBy", thePlayer )
							onCheckForJailPoints ( thePlayer, true )
							showCursor ( occupant, true, true )
						end
					end
				end
			end
		end
    end
end
addEventHandler ( "onVehicleEnter", root, onCopJackWantedPlayer )

LVcol = createColRectangle(866,656,2100,2300)
-- Jail the player when the prisoner hits the col jail
addEvent("onJailArrestedPlayers", true)
function onJailArrestedPlayers ( theJailPoint, thePrisoner )
	local arrestedTable = getCopArrestedPlayers( source )
	if ( arrestedTable ) then
		for i=1,#arrestedTable do
			if ( arrestedTable[i] == thePrisoner ) then
				local wantedPoints = getElementData ( thePrisoner, "wantedPoints" )
				local jailTime = ( math.floor(tonumber(wantedPoints) * 100 / 26 ) )/2
				local jailMoney = ( math.floor(tonumber(wantedPoints) * 200 / 4.2 ) )
				if isElementWithinColShape(thePrisoner,LVcol) == true then
					jailMoney=jailMoney*4
				end
				if tazerAssists[thePrisoner] == nil then tazerAssists[thePrisoner] = {} end
				for k,v in pairs(tazerAssists[thePrisoner]) do
					if v ~= source and isElement(v) then
						exports.denstats:setPlayerAccountData(v,"tazerassists",(exports.denstats:getPlayerAccountData(v,"tazerassists"))+1)
					end
				end
				local chance = 0
				if complied[thePrisoner] then
					exports.DENdxmsg:createNewDxMessage(source, "You jailed "..getPlayerName(thePrisoner).." who had complied with a warning : Bonus $"..math.floor(jailMoney*0.25),0,255,0)
					givePlayerMoney(source,jailMoney*0.25)
					complied[thePrisoner] = nil
					chance = math.random(15,25)
					exports.DENdxmsg:createNewDxMessage(thePrisoner,"Jail Time reduced by "..chance.."% for surrendering to law enforcerment when asked to",0,255,0)
				end
				jailTime=jailTime-(jailTime*(chance/100))
				jailTime=math.floor(jailTime)
				tazerAssists[thePrisoner] = nil
				removePedFromVehicle ( arrestedTable[i] )

				toggleAllControls ( thePrisoner, true, true, true )
				removeCopArrestedPlayer ( source, thePrisoner )
				showCursor ( thePrisoner, false )

				setControlState ( thePrisoner, "sprint", false )
				setControlState ( thePrisoner, "walk", false )
				setControlState ( thePrisoner, "forwards", false )
				setControlState ( thePrisoner, "jump", false )

				exports.DENstats:setPlayerAccountData ( source, "arrests", exports.DENstats:getPlayerAccountData ( source, "arrests" ) + 1 )
				exports.DENstats:setPlayerAccountData ( source, "arrestpoints", exports.DENstats:getPlayerAccountData ( source, "arrestpoints" ) + tonumber(wantedPoints) )

				exports.CSGadmin:setPlayerJailed ( false, thePrisoner, false, jailTime, theJailPoint )
				if (tazer[thePrisoner]) then
					local assister = tazer[thePrisoner]
					if (assister ~= source) then
						exports.CSGscore:givePlayerScore(assister, 1)
						givePlayerMoney(assister, jailMoney / 2)
						exports.DENdxmsg:createNewDxMessage(assister, "A criminal you assisted to arrest got jailed and you earned half the money, $"..jailMoney / 2 , 0, 225, 0)
					end
				end

				triggerEvent("onPlayerJailed",thePrisoner,jailTime)
				givePlayerMoney ( source, jailMoney)
				--[[local scoreToGive=0.5
				if wantedPoints > 30 then scoreToGive=1 end
				if wantedPoints > 40 then scoreToGive=1.5 end
				if wantedPoints > 50 then scoreToGive=2 end
				if wantedPoints > 70 then scoreToGive=3 end
				if wantedPoints > 100 then scoreToGive=4 end
				exports.CSGscore:givePlayerScore(source,scoreToGive)--]]
				exports.DENdxmsg:createNewDxMessage(thePrisoner, "You got jailed by ".. getPlayerName ( source ) .." for " .. jailTime .. " seconds", 225, 165, 0 )
				exports.DENdxmsg:createNewDxMessage(source, "You jailed ".. getPlayerName ( thePrisoner ) .." for " .. jailTime .. " seconds and earned $" .. jailMoney .. ".", 0, 225, 0 )

				setElementData ( thePrisoner, "isPlayerArrested", false )

				onCheckForJailPoints ( source, false )
			end
		end
	end
end
addEventHandler("onJailArrestedPlayers", root, onJailArrestedPlayers)

-- Release player event
addEvent("onReleasePlayerFromArrest", true)
function onReleasePlayerFromArrest ( theCop )
	if ( arrestTable[theCop] ) then
		for i=1,#arrestTable[theCop] do
			local thePrisoner = arrestTable[theCop][i]
			if ( source ) and ( source == thePrisoner ) then
				exports.DENdxmsg:createNewDxMessage(theCop, "You released ".. getPlayerName( thePrisoner ) .."!", 0, 225, 0)
				exports.DENdxmsg:createNewDxMessage(thePrisoner, "You are now free! RUN!", 0, 225, 0)
				setElementData ( thePrisoner, "isPlayerArrested", false )
				toggleAllControls ( thePrisoner, true, true, true )
				removeCopArrestedPlayer ( theCop, thePrisoner )
				onCheckForJailPoints ( theCop, false )
				showCursor ( thePrisoner, false )
			end
		end
	end
end
addEventHandler("onReleasePlayerFromArrest", root, onReleasePlayerFromArrest)

-- On element datachange
addEventHandler( "onElementDataChange", root,
	function ( theName )
		if ( theName == "Occupation" ) and ( getPlayerTeam( source ) ) then
			if not (getTeamName(getPlayerTeam(source)) == "Police") and not (getTeamName(getPlayerTeam(source)) == "SWAT") and not (getTeamName(getPlayerTeam(source)) == "Military Forces") and not (getTeamName(getPlayerTeam(source)) == "Government Agency")  then
				onReleasePlayerFromArrest ( source )
			end
		end
	end
)

-- Remove from bike
addEvent("onRemovePlayerFromBike", true)
function onRemovePlayerFromBike ( )
	if ( isElement( source ) ) then
		removePedFromVehicle ( source )
		exports.DENdxmsg:createNewDxMessage( source, "You fell of your bike due too much damage!", 0, 225, 0)
	end
end
addEventHandler("onRemovePlayerFromBike", root, onRemovePlayerFromBike)

-- Give the cop some money after killing a wanted crim in water
addEventHandler( "onPlayerWasted", root,
function ( ammo, attacker, weapon, bodypart )
	if ( attacker ) and ( isElement( attacker ) ) and ( getElementType ( attacker ) == "player" ) then
		if not ( source == attacker ) and ( getPlayerTeam( attacker ) )then
			if (getTeamName(getPlayerTeam(attacker)) == "Police") or (getTeamName(getPlayerTeam(attacker)) == "SWAT") or (getTeamName(getPlayerTeam(attacker)) == "Military Forces") or (getTeamName(getPlayerTeam(attacker)) == "Government Agency")  then
				if ( isArrestAllowedForLaw ( attacker, source ) ) and ( isElementInWater ( source ) ) then
					local theReward = ( math.floor( tonumber( getElementData ( thePrisoner, "wantedPoints" ) ) * 200 / 8 ) )
					givePlayerMoney( attacker, tonumber( theReward ) )
					exports.DENdxmsg:createNewDxMessage( attacker, "You killed a wanted person in the water you earned $"..theReward, 225, 0, 0)
				end
			end
		end
	end
end
)

-- Check if a player is a law player
local lawTeams = {
	"Police",
	"Military Forces",
	"SWAT",
	"Government Agency",
}

function isPlayerLawEnforcer ( thePlayer )
	if ( isElement( thePlayer ) ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#lawTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == lawTeams[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end

function dx(a,b,c,d,e) exports.DENdxmsg:createNewDxMessage(a,b,c,d,e) end

function transfer(ps,cmd,crimname,copname)
	if isPlayerLawEnforcer(ps) then
		if (crimname) then
			if (copname) then
				local crim = exports.server:getPlayerFromNamePart(crimname)
				if isElement(crim) then
					local list = arrestTable[ps]
					local found = false
					for k,v in pairs(list) do if v == crim then found=true break end end
					if found == false then
						dx("You didn't arrest "..getPlayerName(crim)..", you can't transfer them!",255,0,0)
						return
					end
					local cop = exports.server:getPlayerFromNamePart(copname)
					if isElement(cop) then
						if cop ~= ps then
							if isPlayerLawEnforcer(cop) then
								local x,y,z = getElementPosition(cop)
								local x2,y2,z2 = getElementPosition(ps)
								if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 7 then
									for k,v in pairs(arrestTable[ps]) do
										if v == crim then
											table.remove(arrestTable[ps],k)
											if not(arrestTable[cop]) then arrestTable[cop] = {} end
											triggerEvent( "onPlayerArrest", crim, cop )
											triggerClientEvent(crim, "onClientFollowTheCop", crim, cop, crim)
											table.insert(arrestTable[cop],crim)
											dx(crim,"You have been transferred from officer "..getPlayerName(ps).." to officer "..getPlayerName(cop).."",255,255,0)
											dx(ps,"You have transferred "..getPlayerName(crim).." to officer "..getPlayerName(cop).."",0,255,0)
											dx(ps,""..getPlayerName(crim).." is no longer in your custody",0,255,0)
											dx(cop,"Officer "..getPlayerName(ps).." has transferred "..getPlayerName(crim).." into your custody",0,255,0)
											break
										end
									end
								else
									dx(ps,""..getPlayerName(cop).." is too far away, you can't transfer "..getPlayerName(crim).." to them",255,0,0)
								end
							else
								dx(ps,"The person you want to transfer to is not a law enforcer",255,0,0)
							end
						else
							dx(ps,"You can't transfer someone to yourself",255,0,0)
						end
					else
						dx(ps,"The police officer "..copname.." cannot be found",255,0,0)
					end
				else
					dx(ps,"The player "..crimname.." cannot be found",255,0,0)
				end
			else
				dx(ps,"You didn't enter the name of the police to transfer to",255,0,0)
				dx(ps,"Usage: /arrtransfer criminalName copName",255,0,0)
			end
		else
			dx(ps,"You didn't enter the name of the person you want to transfer",255,0,0)
			dx(ps,"Usage: /arrtransfer criminalName copName",255,0,0)
		end
	end
end
addCommandHandler("arrtransfer",transfer)
addCommandHandler("arrt",transfer)
