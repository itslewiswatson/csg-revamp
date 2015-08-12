local chat = {}
addCommandHandler("pchat",
function(player,cmd,...)
	if (exports.server:isPlayerPremium(player)) then
		if chat[player] == nil then chat[player] = true end
		if chat[player] == false then
			exports.DENdxmsg:createNewDxMessage(player,"Premium chat is disabled, toggle /togglepchat to enable it",0,255,0)
			return
		end
		
		local message = table.concat({...}, " ")
		for k,v in ipairs(getElementsByType("player")) do
			if (exports.server:isPlayerPremium(v)) then
				if chat[player] == nil then
					outputChatBox("(PREMIUM - "..getPlayerName(player)..") "..message,255,69,0,true)
				elseif chat[player] == true then
					outputChatBox("(PREMIUM - "..getPlayerName(player)..") "..message,255,69,0,true)
				end
			end
		end
		exports.CSGlogging:createLogRow(player,"premiumchat",message)
	end
end)

addCommandHandler("togglepchat",
function(ply)
	if chat[ply] == nil then chat[ply] = true end
	chat[ply] = (not chat[ply]) --switch statement
	if chat[ply] == true then
		exports.DENdxmsg:createNewDxMessage(ply,"Premium chat enabled.",0,255,0)
	else
		exports.DENdxmsg:createNewDxMessage(ply,"Premium chat disabled.",255,0,0)
	end
end)

addCommandHandler( "premium",
	function ( player )
		if ( exports.server:getPlayerAccountID( player ) ) then
			local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID( player ) )
			if ( userData ) then
				--define the premium type--
				if (userData.premiumType == 0) then
					premType = "None"
				elseif (userData.premiumType == 1) then
					premType = "Bronze"
				elseif (userData.premiumType == 2) then
					premType == "Silver"
				elseif (userData.premiumType == 3) then
					premType == "Gold"
				elseif (userData.premiumType == 4) then
					premType == "Platinum"
				else
					premType == "N/A"
				end
				
				if (userData.premium == 0) then
					exports.DENdxmsg:createNewDxMessage(player,"You are not premium! check out the forum for more information about premium!",255,0,0)
				elseif (userData.premium < 60) then
					exports.DENdxmsg:createNewDxMessage(player,"Premium time remaining: "..userData.premium.." minutes. ("..premType..")",0,255,0)
				else
					if (math.floor(userData.premium / 60) == 1) then
						exports.DENdxmsg:createNewDxMessage(player,"Premium time remaining: 1 hour ("..premType..")",0,255,0)
					else
						exports.DENdxmsg:createNewDxMessage(player,"Premium time remaining: "..math.floor(userData.premium/60).." hours. ("..premType..")",0,255,0)
					end
				end
			end
		end
	end
)

setTimer(
function()
	for k,v in ipairs(getElementsByType("player")) do
		if (exports.server:getPlayerAccountID(v)) then
			if (exports.server:isPlayerPremium(v)) then
				
				local data = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=? LIMIT 1",exports.server:getPlayerAccountID(v)
				
				if userData == nil then 
					userData = {} 
					userData.premium = 0 
				end
				
				if (userData.premium > 4) then
					premiumTime = userData.premium - 5
					premType = 0
				elseif (userData.premium == 4) then
					premiumTime = userData.premium - 4
					premType = 0
				elseif (userData.premium == 3) then
					premiumTime = userData.premium - 3
					premType = 0
				elseif (userData.premium == 2) then
					premiumTime = userData.premium - 2
					premType = 0
				elseif (userData.premium == 1) then
					premiumTime = userData.premium - 1
					premType = 0
				end
				
				if (premiumTime == 0) then
					setElementData(v,"isPlayerPremium",false)
					setElementData(v,"Premium","No")
					setElementData(v,"premiumType",premType)
				end
				
				exports.DENmysql:exec("UPDATE accounts SET premium=?,premiumType=? WHERE id=?",tonumber(premiumTime),tonumber(premType),exports.server:getPlayerAccountID(v))
			end
		end
	end
end, 300000,0)

addCommandHandler("pc",
	function (thePlayer)
		if  getElementData(thePlayer, "isPlayerPremium") or getElementData(thePlayer, "canUsePremiumCar") and ( getElementInterior(thePlayer) == 0 ) then
			if getElementInterior(thePlayer) ~= 0 then exports.DENdxmsg:createNewDxMessage(thePlayer,"You can't use premium vehicle in a interior!",255,0,0) return end
			if ( latestSpawn[getPlayerSerial(thePlayer)] ) and ( getTickCount()-latestSpawn[getPlayerSerial(thePlayer)] < 600000 ) then
				exports.DENdxmsg:createNewDxMessage(thePlayer, "You can only use this feature once every 10 minutes!", 225, 0, 0)
			elseif ( exports.server:getPlayerWantedPoints(thePlayer) >= 10 ) then
				exports.DENdxmsg:createNewDxMessage(thePlayer, "You can't use this feature when having one or more wanted stars!", 225, 0, 0)
			else
				if not ( isPedInVehicle(thePlayer) ) then
					if ( isElement( theVehicle[thePlayer] ) ) then destroyElement( theVehicle[thePlayer] ) end
					latestSpawn[getPlayerSerial(thePlayer)] = getTickCount()
					local x, y, z = getElementPosition(thePlayer)
					local rx, ry, rz = getElementRotation(thePlayer)
					theVehicle[thePlayer] = createVehicle( 526, x, y, z, rx, ry, rz, "Premium" )
					warpPedIntoVehicle(thePlayer, theVehicle[thePlayer])
					setElementData(theVehicle[thePlayer], "vehicleType", "PremiumCar")
					setElementData(theVehicle[thePlayer], "vehicleOwner", thePlayer)
					local handlingTable = getVehicleHandling ( theVehicle[thePlayer] )
					local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 40 ) )
					setVehicleHandling ( theVehicle[thePlayer], "numberOfGears", 5 )
					setVehicleHandling ( theVehicle[thePlayer], "driveType", 'awd' )
					setVehicleHandling ( theVehicle[thePlayer], "maxVelocity", newVelocity )
					setVehicleHandling ( theVehicle[thePlayer], "engineAcceleration", handlingTable["engineAcceleration"] +8 )
				end
			end
		end
	end
)

addCommandHandler("pcfer",
	function (thePlayer)
		if exports.server:getPlayerAccountName(thePlayer) ~= "sensei" or exports.server:getPlayerAccountName(thePlayer) ~= "jack" then return end
					if not ( isPedInVehicle(thePlayer) ) then
						if ( isElement( theVehicle[thePlayer] ) ) then destroyElement( theVehicle[thePlayer] ) end
						latestSpawn[getPlayerSerial(thePlayer)] = getTickCount()
						local x, y, z = getElementPosition(thePlayer)
						local rx, ry, rz = getElementRotation(thePlayer)
						theVehicle[thePlayer] = createVehicle( 401, x, y, z, rx, ry, rz, "Premium" )
						setVehicleColor(theVehicle[thePlayer],255,0,0)
						warpPedIntoVehicle(thePlayer, theVehicle[thePlayer])
						setElementData(theVehicle[thePlayer], "vehicleType", "PremiumCar")
						setElementData(theVehicle[thePlayer], "vehicleOwner", thePlayer)
						local handlingTable = getVehicleHandling ( theVehicle[thePlayer] )
						local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 45 ) )
						setVehicleHandling ( theVehicle[thePlayer], "numberOfGears", 5 )
						setVehicleHandling ( theVehicle[thePlayer], "driveType", 'awd' )
						setVehicleHandling ( theVehicle[thePlayer], "maxVelocity", newVelocity )
						setVehicleHandling ( theVehicle[thePlayer], "engineAcceleration", handlingTable["engineAcceleration"] +8 )
					setVehicleHandling ( theVehicle[thePlayer], "engineAcceleration", handlingTable["engineAcceleration"] +8 )
					end
	end
)
-- Destroy the vehicle on quit
addEventHandler ( "onPlayerQuit", root,
	function()
		if ( isElement( theVehicle[source] ) ) then
			destroyElement( theVehicle[source] )
			theVehicle[source] = nil
		end
	end
)
-- Prevent people from entering premium cars
addEventHandler("onVehicleStartEnter", root,
	function ( thePlayer, seat, jacked )
		if ( getElementData(source, "vehicleType") == "PremiumCar" ) and ( seat == 0 ) and not ( getTeamName( getPlayerTeam( thePlayer ) ) == "Staff" ) then
			if ( getVehicleController( source ) ) and ( exports.server:getPlayerWantedPoints( getVehicleController( source ) ) >= 10 ) then
				if not ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or not ( getTeamName( getPlayerTeam( thePlayer ) ) == "Military Forces" ) or not ( getTeamName( getPlayerTeam( thePlayer ) ) == "Police" ) or not ( getTeamName( getPlayerTeam( thePlayer ) ) == "Government Agency" ) then
					--if ( exports.CSGgift:getChristmasDay() == "Day29" ) or ( exports.CSGgift:getChristmasDay() == "Day17" ) then return end
					cancelEvent()
					exports.DENdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle!", 225, 0, 0)
				end
			else
				if ( exports.server:getPlayerWantedPoints( thePlayer ) < 10 ) then
					if not ( exports.server:isPlayerPremium( thePlayer ) ) then
						--if ( exports.CSGgift:getChristmasDay() == "Day29" ) or ( exports.CSGgift:getChristmasDay() == "Day17" ) then return end
						cancelEvent()
						exports.DENdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle!", 225, 0, 0)
					end
				end
			end
		end
	end
)

addEventHandler("onElementDataChange",root,function(k)
	if k == "wantedPoints" then
		if getPlayerWantedLevel(source) > 0 then
			if doesPedHaveJetPack(source) then
				removePedJetPack(source)
				exports.DENdxmsg:createNewDxMessage(source,"Jetpack removed due to being wanted",255,0,0)
			end
		end
	end
end)

- Destroy the vehicle when it explodes
addEventHandler("onVehicleExplode", root,
	function ()
		if ( getElementData(source, "vehicleType") == "PremiumCar" ) then
			local theOwner = getElementData(source, "vehicleOwner")
			theTimer[theOwner] = setTimer(destroyVehicle, 5000, 1, source, theOwner)
		end
	end
)

-- Destroy function
function destroyVehicle ( vehicle, thePlayer  )
	theVehicle[thePlayer] = nil
	theTimer[thePlayer] = nil
	destroyElement(vehicle)
end

-- onPlayerZoneChange
addEvent( "playerZoneChange", true )
addEventHandler( "playerZoneChange", root,
	function ( oldZone, newZone )
		triggerEvent( "onPlayerZoneChange", source, oldZone, newZone )

		if ( doesPedHaveJetPack ( source ) ) and not ( getTeamName( getPlayerTeam( source ) ) == "Staff" ) then
			if ( newZone == "Las Venturas" ) then
				exports.DENdxmsg:createNewDxMessage( source, "You lost your jetpack, it's not allowed to use it in LV!", 225, 0, 0 )
				removePedJetPack ( source )
			end
		end
	end
)