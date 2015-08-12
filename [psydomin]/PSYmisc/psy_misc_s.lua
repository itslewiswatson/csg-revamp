
function eject (theEjecter, command, theEjected)
	local veh = getPedOccupiedVehicle(theEjecter)
	local driverSeat = getPedOccupiedVehicleSeat(theEjecter)
	if theEjecter ~= theEjected and veh and driverSeat == 0 then
		if theEjected == "*" then 
			occupants = getVehicleOccupants(veh)
			for i,v in ipairs(occupants) do
				if v ~= theEjecter and not exports.server:isPlayerStaff(v)then 
					removePedFromVehicle(v)
					attachElements(v, veh, 0, 0, 2)
					detachElements(v, veh)
					exports.DENdxmsg:createNewDxMessage(v, "You have been ejected from the vehicle!", 255,0,0)
				end
			end
		else playerToEject = exports.server:getPlayerFromNamePart(theEjected)
			if playerToEject and getPedOccupiedVehicle(playerToEject) == veh and getPedOccupiedVehicleSeat(playerToEject) ~= 0 and not exports.server:isPlayerStaff(v) then 
				removePedFromVehicle(playerToEject)
				attachElements(playerToEject, veh, 2, 0, 0)
				detachElements(playerToEject, veh)
				exports.DENdxmsg:createNewDxMessage(playerToEject, "You have been ejected from the vehicle!", 255,0,0)
			elseif playerToEject and getPedOccupiedVehicleSeat(playerToEject) == 0 then exports.DENdxmsg:createNewDxMessage(theEjecter, "You can't eject yourself!", 255,0,0)
			else exports.DENdxmsg:createNewDxMessage(theEjecter, "The player you specified is not on your vehicle/doesn't exist!", 255,0,0)end
		end
	end
end
addCommandHandler("eject", eject)

----------------------------------------------------------