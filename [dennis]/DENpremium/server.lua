---- Premium chat
local enabledPCHAT = {}
addCommandHandler("pchat",
	function (thePlayer, cmd, ...)
		if (exports.server:isPlayerPremium(thePlayer)) then
			if enabledPCHAT[thePlayer] == nil then enabledPCHAT[thePlayer] = true end
			if enabledPCHAT[thePlayer] == false then
				exports.DENdxmsg:createNewDxMessage(thePlayer,"Premium chat is disabled, type /togglepchat to enable it", 0, 255, 0)
				return
			end
			
			local theMessage = table.concat({...}, " ")
			for k, aPlayer in ipairs (getElementsByType("player")) do
				if (exports.server:isPlayerPremium(aPlayer)) then
					if enabledPCHAT[aPlayer] == nil then
						outputChatBox("(PREMIUM) "..getPlayerName(thePlayer)..": #FFFFFF"..theMessage, aPlayer, 255, 69, 0, true)
					elseif enabledPCHAT[aPlayer] == true then
						outputChatBox("(PREMIUM) "..getPlayerName(thePlayer)..": #FFFFFF"..theMessage, aPlayer, 255, 69, 0, true)
					else
						--off for him
					end
				end
			end
			exports.CSGlogging:createLogRow(thePlayer, "premiumchat", theMessage)
		end
	end
)
 
addCommandHandler("togglepchat",
	function(ps)
        if enabledPCHAT[ps] == nil then enabledPCHAT[ps]=true end
        enabledPCHAT[ps] = (not enabledPCHAT[ps])
        if enabledPCHAT[ps] == true then
			exports.DENdxmsg:createNewDxMessage(ps,"Premium chat enabled, you can now talk and see premium chat", 0, 255, 0)
        else
			exports.DENdxmsg:createNewDxMessage(ps,"Premium chat disabled, you can no longer talk or see premium chat", 0, 255, 0)
        end
	end
)

-- Show the remaining hours or say that the player isn't premium
addCommandHandler("premium",
	function (thePlayer)
		if (exports.server:getPlayerAccountID(thePlayer)) then
			local userData = exports.DENmysql:querySingle("SELECT * FROM `accounts` WHERE `id`=? LIMIT 1", exports.server:getPlayerAccountID(thePlayer))
			if (userData) then
				--define the premium type--
				if (userData.premiumType == 0) then
					premType = "None"
				elseif (userData.premiumType == 1) then
					premType = "Bronze"
				elseif (userData.premiumType == 2) then
					premType = "Silver"
				elseif (userData.premiumType == 3) then
					premType = "Gold"
				elseif (userData.premiumType == 4) then
					premType = "Platinum"
				else
					premType = "N/A"
				end
 
				if (userData.premium == 0) then
					exports.DENdxmsg:createNewDxMessage(thePlayer, "You are not a premium member! Check the forum for more information!", 225, 0, 0)
				elseif (userData.premium < 60) then
					exports.DENdxmsg:createNewDxMessage(thePlayer, "Premium time remaining: "..userData.premium.." minutes. ("..premType..")", 0, 225, 0)
				else
					if (math.floor(userData.premium / 60) == 1) then
						exports.DENdxmsg:createNewDxMessage(thePlayer, "Premium time remaining: 1 hour ("..premType..")", 0, 225, 0)
					else
						exports.DENdxmsg:createNewDxMessage(thePlayer, "Premium time remaining: "..math.floor(userData.premium / 60).." hours ("..premType..")", 0, 225, 0)
					end
				end
			end
		end
	end
)
  
-- Update the premium time from all players and update it
setTimer(
	function ()
		for k, thePlayer in ipairs (getElementsByType ("player")) do
			if (exports.server:getPlayerAccountID(thePlayer)) then
				if (exports.server:isPlayerPremium(thePlayer)) then
				
					local userData = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID(thePlayer))
					if userData == nil then userData={} userData.premium=0 end
					if (userData.premium > 4) then
						premiumTime = userData.premium - 5
						premType = userData.premiumType
					elseif (userData.premium == 4) then
						premiumTime = userData.premium - 4
						premType = userData.premiumType
					elseif (userData.premium == 3) then
						premiumTime = userData.premium - 3
						premType = userData.premiumType
					elseif (userData.premium == 2) then
						premiumTime = userData.premium - 2
						premType = userData.premiumType
					elseif (userData.premium == 1) then
						premiumTime = userData.premium - 1
						premType = userData.premiumType
					end
 
					if (premiumTime == 0) then
						setElementData(thePlayer, "isPlayerPremium", false)
						setElementData(thePlayer, "Premium", "No")
						setElementData(thePlayer,"premiumType",0)
						premType = 0
					end
 
					exports.DENmysql:exec("UPDATE accounts SET premium=?,premiumType=? WHERE id=?", tonumber(premiumTime),tonumber(premiumType), exports.server:getPlayerAccountID(thePlayer))
				end
			end
		end
	end, 300000, 0
)
 
-- Premium jetpack
addCommandHandler("jetpack",
	function (thePlayer)
		if (exports.server:isPlayerPremium(thePlayer)) then
			if not (exports.server:getPlayerPremiumType(thePlayer) == 2) or not (exports.server:getPlayerPremiumType(thePlayer) == 3) or (exports.server:getPlayerPremiumType(thePlayer) == 4) then
				if (exports.server:getPlayerPremiumType(thePlayer) == 1) then
					exports.DENdxmsg:createNewDxMessage(thePlayer,"The premium plan you have does not include a jetpack.", 255, 0, 0)
					return false
				elseif (exports.server:getPlayerPremiumType(thePlayer) == 0) then
					return false
				end
			else
				if (exports.server:getPlayerWantedPoints(thePlayer) >= 10) then
					exports.DENdxmsg:createNewDxMessage(thePlayer, "You can't use the premium jetpack while wanted!", 225, 0, 0)
				elseif (getElementZoneName (thePlayer, true) == "Las Venturas") then
					exports.DENdxmsg:createNewDxMessage(thePlayer, "You can't use the premium jetpack whilst inside the city of LV!", 225, 0, 0)
				elseif (getElementDimension(thePlayer) ~= 0) then
					exports.DENdxmsg:createNewDxMessage(thePlayer, "You can only use a jetpack in the main world!", 225, 0, 0)
				else
					if (doesPedHaveJetPack(thePlayer)) then
						removePedJetPack(thePlayer)
					else
						givePedJetPack(thePlayer)
						setTimer(giveWeapon, 500, 1, thePlayer, 0, 1, true)
					end
				end
			end
		end
	end
)
 
for i=1,46 do
	if (i ~= 46) and (i ~= 13) and (i ~= 19) and (i ~= 20) and (i ~= 21) and (getWeaponNameFromID(i) ~= "Freefall Bomb") then
		setJetpackWeaponEnabled(getWeaponNameFromID(i), false)
	end
end
 
-- Vehicle spawn
local theVehicle = {}
local latestSpawn = {}
local theTimer = {}
 
addCommandHandler("pc",
	function (thePlayer)
		if exports.server:isPlayerLoggedIn(thePlayer) then
			if getElementData(thePlayer,"isPlayerJailed") then
				exports.DENdxmsg:createNewDxMessage(thePlayer, "You can't use this feature while jailed!", 225, 0, 0)
				return
			end
			
			if getElementData(thePlayer, "isPlayerPremium") or getElementData(thePlayer, "canUsePremiumCar") and (getElementInterior(thePlayer) == 0) then
				if getElementInterior(thePlayer) ~= 0 then exports.DENdxmsg:createNewDxMessage(thePlayer,"You can't use premium vehicle in a interior!", 255, 0, 0) return end
				if (latestSpawn[getPlayerSerial(thePlayer)]) and (getTickCount()-latestSpawn[getPlayerSerial(thePlayer)] < 600000) then
					exports.DENdxmsg:createNewDxMessage(thePlayer, "You can only use this feature once every 10 minutes!", 225, 0, 0)
				elseif (exports.server:getPlayerWantedPoints(thePlayer) >= 10) then
					exports.DENdxmsg:createNewDxMessage(thePlayer, "You can't use this feature when having one or more wanted stars!", 225, 0, 0)
				else
					if not (isPedInVehicle(thePlayer)) then
						if (isElement(theVehicle[thePlayer])) then destroyElement(theVehicle[thePlayer]) end
						latestSpawn[getPlayerSerial(thePlayer)] = getTickCount()
						local x, y, z = getElementPosition(thePlayer)
						local rx, ry, rz = getElementRotation(thePlayer)
						theVehicle[thePlayer] = createVehicle(526, x, y, z, rx, ry, rz, "Premium")
						warpPedIntoVehicle(thePlayer, theVehicle[thePlayer])
						setElementData(theVehicle[thePlayer], "vehicleType", "PremiumCar")
						setElementData(theVehicle[thePlayer], "vehicleOwner", thePlayer)
						local handlingTable = getVehicleHandling (theVehicle[thePlayer])
						local newVelocity = (handlingTable["maxVelocity"] + (handlingTable["maxVelocity"] / 100 * 40))
						setVehicleHandling (theVehicle[thePlayer], "numberOfGears", 5)
						setVehicleHandling (theVehicle[thePlayer], "driveType", 'awd')
						setVehicleHandling (theVehicle[thePlayer], "maxVelocity", newVelocity)
						setVehicleHandling (theVehicle[thePlayer], "engineAcceleration", handlingTable["engineAcceleration"] +8)
					end
				end
			end
		end
	end
)
 
addEventHandler("onVehicleEnter", root,
	function(p, seat)
		if seat == 0 then
			if getElementData(source,"vehicleType") == "PremiumCar" then
				if getPlayerWantedLevel(p) > 0 then
					exports.DENdxmsg:createNewDxMessage(p,"You can't drive a premium car while wanted", 255, 0, 0)
					cancelEvent()
				end
			end
		end
	end
)

--[[
addCommandHandler("pcfer",
        function (thePlayer)
			if (not isPedInVehicle(thePlayer)) then
				if (isElement(theVehicle[thePlayer])) then destroyElement(theVehicle[thePlayer]) end
				latestSpawn[getPlayerSerial(thePlayer)] = getTickCount()
				local x, y, z = getElementPosition(thePlayer)
				local rx, ry, rz = getElementRotation(thePlayer)
				theVehicle[thePlayer] = createVehicle(401, x, y, z, rx, ry, rz, "Premium")
				setVehicleColor(theVehicle[thePlayer],255,0,0)
				warpPedIntoVehicle(thePlayer, theVehicle[thePlayer])
				setElementData(theVehicle[thePlayer], "vehicleType", "PremiumCar")
				setElementData(theVehicle[thePlayer], "vehicleOwner", thePlayer)
				local handlingTable = getVehicleHandling (theVehicle[thePlayer])
				local newVelocity = (handlingTable["maxVelocity"] + (handlingTable["maxVelocity"] / 100 * 45))
				setVehicleHandling (theVehicle[thePlayer], "numberOfGears", 5)
				setVehicleHandling (theVehicle[thePlayer], "driveType", 'awd')
				setVehicleHandling (theVehicle[thePlayer], "maxVelocity", newVelocity)
				setVehicleHandling (theVehicle[thePlayer], "engineAcceleration", handlingTable["engineAcceleration"] +8)
				setVehicleHandling (theVehicle[thePlayer], "engineAcceleration", handlingTable["engineAcceleration"] +8)
		end
	end
)
--]]

-- Destroy the vehicle on quit
addEventHandler("onPlayerQuit", root,
	function ()
		if (isElement(theVehicle[source])) then
			destroyElement(theVehicle[source])
			theVehicle[source] = nil
		end
	end
)
 
-- Prevent people from entering premium cars
addEventHandler("onVehicleStartEnter", root,
	function (thePlayer, seat, jacked)
		if (getElementData(source, "vehicleType") == "PremiumCar") and (seat == 0) and not (getTeamName(getPlayerTeam(thePlayer)) == "Staff") then
			if (getVehicleController(source)) and (exports.server:getPlayerWantedPoints(getVehicleController(source)) >= 10) then
				if not (getTeamName(getPlayerTeam(thePlayer)) == "SWAT") or not (getTeamName(getPlayerTeam(thePlayer)) == "Military Forces") or not (getTeamName(getPlayerTeam(thePlayer)) == "Police") or not (getTeamName(getPlayerTeam(thePlayer)) == "Government Agency") then
					cancelEvent()
					exports.DENdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle!", 225, 0, 0)
				end
			else
				if (exports.server:getPlayerWantedPoints(thePlayer) < 10) then
					if not (exports.server:isPlayerPremium(thePlayer)) then
						cancelEvent()
						exports.DENdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle!", 225, 0, 0)
					end
				end
			end
		end
	end
)
 
addEventHandler("onElementDataChange", root,
	function (k)
		if k == "wantedPoints" then
			if getPlayerWantedLevel(source) > 0 then
				if doesPedHaveJetPack(source) then
					removePedJetPack(source)
					exports.DENdxmsg:createNewDxMessage(source,"Jetpack removed due to being wanted",255,0,0)
				end
			end
		end
	end
)
 
-- Destroy the vehicle when it explodes
addEventHandler("onVehicleExplode", root,
	function ()
		if (getElementData(source, "vehicleType") == "PremiumCar") then
			local theOwner = getElementData(source, "vehicleOwner")
			theTimer[theOwner] = setTimer(destroyVehicle, 5000, 1, source, theOwner)
		end
	end
)
 
-- Destroy function
function destroyVehicle (vehicle, thePlayer )
	theVehicle[thePlayer] = nil
	theTimer[thePlayer] = nil
	destroyElement(vehicle)
end
 
-- onPlayerZoneChange
addEvent("playerZoneChange", true)
addEventHandler("playerZoneChange", root,
	function (oldZone, newZone)
		triggerEvent("onPlayerZoneChange", source, oldZone, newZone)
		
		if (doesPedHaveJetPack (source)) and (getTeamName(getPlayerTeam(source)) ~= "Staff") then
			if (newZone == "Las Venturas") then
				exports.DENdxmsg:createNewDxMessage(source, "You cannot use your jetpack in LV!", 225, 0, 0)
				removePedJetPack(source)
			end
		end
	end
)
 
function givePlayerPremium(_type,_data, amount)
	if (type(_type) == "string" and _type == "web-based") then
		if not (_data) then
			outputDebugString("[PREMIUM] Missing username...")
			return "MISSING USERNAME"
		end
	
		local data = exports.DENmysql:querySingle("SELECT premium FROM accounts WHERE username=? LIMIT 1",_data)
		if (exports.DENmysql:exec("UPDATE accounts SET premium=?,premiumType=? WHERE username=?",data["premium"] + amount, _data)) then
			outputDebugString("[PREMIUM] Account "..data.." has been given "..amount.." of premium.")
			return true --stop the script here
		else
			outputDebugString("[PREMIUM] Account "..data.." failed to receive premium.")
			return "ERROR"
		end
	else
		if not (getElementType(_type) == "player") then
			return "Incorrect player type."
		end
               
		local player = _type
		local id = exports.server:getPlayerAccountID(player)
		local data = exports.DENmysql:querySingle("SELECT premium FROM accounts WHERE id=?", id)
		local newValue = data["premium"] + amount			
		if (exports.DENmysql:exec("UPDATE accounts SET premium=?, premiumType=? WHERE id=?", newValue, 4, id)) then
			outputDebugString("[PREMIUM] "..getPlayerName(player).." has been given "..amount.." of premium hours.", 0, 0, 255, 0)
			setElementData(player, "isPlayerPremium", true)
			setElementData(player, "Premium", "Yes")
			return true
		else
			outputDebugString("[PREMIUM] failed to give "..getPlayerName(player).." "..amount.." of premium hours!", 0, 255, 0, 0)
			return false
		end
	end
end
