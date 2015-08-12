local suicideTimers = {}

-- Command to kill yourself
addCommandHandler( "kill",
	function ( thePlayer )
		if not ( isTimer( suicideTimers[thePlayer] ) ) and not ( isPedDead( thePlayer ) ) and ( exports.server:isPlayerLoggedIn( thePlayer ) ) then
			if not ( getElementData ( thePlayer, "isPlayerJailed" ) ) and not ( getElementData ( thePlayer, "isPlayerArrested" ) ) then
				local dim = getElementDimension(thePlayer)
				local x,y,z = getElementPosition(thePlayer)
				local x2,y2,z2 = 1561.75, -822.47, 350.84
				if dim == 2 then
					if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 100 then
					exports.DENdxmsg:createNewDxMessage( thePlayer, "You can't kill yourself while jailed!", 255, 0, 0)
					return
					end
				end

				setElementFrozen( thePlayer, true )
				suicideTimers[thePlayer] = setTimer( onPedSuicide, 10000, 1, thePlayer )
				exports.DENdxmsg:createNewDxMessage( thePlayer, "You committed suicide, you are dead within 10 seconds!", 255, 0, 0)
			else
				exports.DENdxmsg:createNewDxMessage( thePlayer, "You can't kill yourself while jailed!", 255, 0, 0)
			end
		else
			exports.DENdxmsg:createNewDxMessage( thePlayer, "You can't commit suicide right now!", 255, 0, 0)
		end
	end
)

-- Function that ends the kill
function onPedSuicide ( thePlayer )
	if ( isElement( thePlayer ) ) and ( exports.server:isPlayerLoggedIn( thePlayer ) ) then
		killPed( thePlayer )
		if getElementDimension(thePlayer) ~= 0 and getElementInterior(thePlayer) == 0 then
			exports.CSGscore:givePlayerScore(thePlayer,1)
		end
	end
	suicideTimers[thePlayer] = {}
end

-- Remove hex
function removeHEX(oldNick,newNick)
	local name = getPlayerName(source)
	if newNick then
		name = newNick
	end
	if name:find("#%x%x%x%x%x%x") then
		local name = name:gsub("#%x%x%x%x%x%x","")
		if name:len() > 0 then
			setPlayerName(source,name)
		else
			setPlayerName(source,"Player"..tostring(math.random(10000,99990)))
		end
		if newNick then
			cancelEvent()
		end
	end
end
addEventHandler("onPlayerJoin",root,removeHEX)
addEventHandler("onPlayerChangeNick",root,removeHEX)

-- Stop the kill timer when a player gets arrested
addEvent( "onPlayerArrest")
addEventHandler( "onPlayerArrest", root,
	function ( theCop, prisonerWantedPoints )
		if ( suicideTimers[source] ) then
			if ( isTimer( suicideTimers[source] ) ) then
				killTimer( suicideTimers[source] )
				setElementFrozen( source, false )
			end
		end
	end
)


-- Remove the chainsaw whenever a player has one
addEventHandler ( "onPlayerWeaponSwitch", root,
	function (_,i)
		if i == 9 and getElementData(source,"Occupation") ~= "Lumberjack" and getTeamName(getPlayerTeam(source)) ~= "Civilian Workers" then
			takeWeapon ( source, 9 )
		end
	end
)


addEventHandler("onVehicleEnter",root,function(p)
	if getElementModel(source) == 447 and getElementData(p,"Occupation") == "Lumberjack" then
		if getElementData(source,"vehicleOccupation") then
			destroyElement(source)
		end
	end
end)
-- Check if a nick is too long
addEventHandler( "onPlayerChangeNick", root,
	function ( oldNick, newNick )
		if ( string.len ( newNick ) > 18 ) then
			cancelEvent()
			outputChatBox("Your new nickname is to long, its changed back to ".. oldNick .." .", source, 255, 0, 0)
			setPlayerName ( source, oldNick )
		end
	end
)

-- Check the nick on connect
addEventHandler ( "onPlayerConnect", root,
function ( playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber )
    if ( playerNick == "Player" ) or ( playerNick == "player" ) then
        cancelEvent( true, "The nickname \"Player\" is not allowed, please change it to something else. You can change your nick in Settings menu Multiplayer tab." )
    elseif ( string.len ( playerNick ) > 18 ) then
		cancelEvent( true, "Your nickname is to long, please change it to something else. You can change your nick in Settings menu Multiplayer tab." )
    end
end
)

-- The fastrope script was made by Cazomino05
function onDropPlayersFromHeli ( playerSource )
	if ( playerSource ) then
		local theHeli = getPedOccupiedVehicle ( playerSource )
		if ( theHeli ) and getElementModel(theHeli) == 497 then
			local vehController = getVehicleController ( theHeli )
			if not isVehicleOnGround ( theHeli ) and ( vehController == playerSource ) then
				local heliOccupants = getVehicleOccupants( theHeli )
				local seats = getVehicleMaxPassengers( theHeli )
				for seat = 0, seats do if not createRope then local occupant = heliOccupants[seat] if occupant and getElementType(occupant)=="player" then createRope = true else createRope = false end end end
				if ( createRope ) then
					if (getTeamName(getPlayerTeam(playerSource)) == "Police") or (getTeamName(getPlayerTeam(playerSource)) == "SWAT")
					or (getTeamName(getPlayerTeam(playerSource)) == "Military Forces") or (getTeamName(getPlayerTeam(playerSource)) == "Staff") or (getTeamName(getPlayerTeam(playerSource)) == "Government Agency") then

						-- Create the heli rope
						local ropeLeft = exports.DENheli:createFastRopeOnHeli(playerSource, theHeli, "left", 3000)
						local ropeRight = exports.DENheli:createFastRopeOnHeli(playerSource, theHeli, "right", 3000)
						local left = 0
						local right = 0
						for seat = 0, seats do
							local occupant = heliOccupants[seat]
							if occupant and getElementType(occupant)=="player" then
								if seat == 1 then side = "left" elseif seat == 2 then side = "right" elseif seat == 3 then side = "left" end
									if ( side == "left") then
										if ( left > 0 ) then
											setTimer(call, 1000, 1, getResourceFromName("DENHeli"), "addPlayerToFastRope", occupant, ropeLeft)
										else
											exports.DENheli:addPlayerToFastRope(occupant, ropeLeft)
										end
										left = left + 1
									end
									if ( side == "right") then
										if ( right > 0 ) then
											setTimer(call, 1000, 1, getResourceFromName("DENHeli"), "addPlayerToFastRope", occupant, ropeRight)
										else
											exports.DENheli:addPlayerToFastRope(occupant, ropeRight)
										end
										right = right + 1
									end
									left = 0
									right = 0
								end
							end
						end
					end
				end
			end
		end
	end
addCommandHandler( "drop", onDropPlayersFromHeli )
addCommandHandler( "helidrop", onDropPlayersFromHeli )

-- Car door
addCommandHandler( "cardoor",
	function( thePlayer, cmd, theDoor )
		local theVehicle = getPedOccupiedVehicle( thePlayer )
		if ( isElement( theVehicle ) ) and ( theDoor ) then
			local thePlayerSeat = getPedOccupiedVehicleSeat ( thePlayer )
			if ( string.match(theDoor,'^%d+$' ) ) and ( thePlayerSeat == 0 ) then
				if ( tonumber(theDoor) < 6 ) then
					if getVehicleDoorOpenRatio ( theVehicle, 2 ) == 0 then
						setVehicleDoorOpenRatio( theVehicle, tonumber(theDoor), 1, 300)
					else
						setVehicleDoorOpenRatio( theVehicle, tonumber(theDoor), 0, 300)
					end
				end
			elseif ( theDoor == "*" ) then
				for i=0,5 do
					if getVehicleDoorOpenRatio ( theVehicle, 2 ) == 0 then
						setVehicleDoorOpenRatio( theVehicle, i, 1, 300)
					else
						setVehicleDoorOpenRatio( theVehicle, i, 0, 300)
					end
				end
			end
		end
	end
)

local sthCD = {}

addEventHandler("onPlayerQuit",root,function()
	if sthCD[source]~= nil then
		sthCD[source]=nil
		--table.remove(sthCD,source)
	end
end)

-- Disable stealth kill
addEventHandler( "onPlayerStealthKill", root,
	function (tar)
		if getElementData(tar,"isPlayerArrested") == true then cancelEvent() return end
		if getElementData(source,"Rank") == "Butcher " then
			if getElementAlpha(tar) == 255 then
				if sthCD[source] == nil then
					sthCD[source]=getTickCount()
				else
					if getTickCount()-sthCD[source] > 300000 then
						sthCD[source]=getTickCount()
					else
						exports.DENdxmsg:createNewDxMessage(source,"Your too tired to stealth kill right now!",255,0,0)
						cancelEvent()
						return
					end
				end
			else

				cancelEvent()
			end
		else

			cancelEvent()
		end
	end
)

-- Disable private message
addEventHandler( "onPlayerPrivateMessage", root,
	function ()
		cancelEvent()
		outputChatBox( "This command is disabled! Use the SMS function in the phone instead!", source, 225, 0, 0 )
	end
)
