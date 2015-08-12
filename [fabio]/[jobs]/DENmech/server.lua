local options = {[1] = { regularPrice = 1000, mechPrice = 600, upgradeID = 1008 }}

function notifyMechanic( message)
	exports.DENdxmsg:createNewDxMessage(source, message, 200, 0, 0)
end
addEvent("notifyMechanic", true)
addEventHandler("notifyMechanic", root, notifyMechanic)

function doVehicleRepair(option,mechanic,vehicle,price)

	local messageToBuyer
	local messageToMechanic
	if getPlayerMoney(source) >= price then
		if option == 1 then	
			messageToBuyer = "You have bought 5 NOS ( $"..price.." ) for your vehicle."
			messageToMechanic = "You have sold 5 NOS to "..getPlayerName(source)..', earning you: $'..price.."."
			addVehicleUpgrade(vehicle,1008)		
		elseif option == 2 then		
			messageToBuyer = "You have bought hydraulics ( $"..price.." ) for your vehicle."
			messageToMechanic = "You have sold hydraulics to "..getPlayerName(source)..", earning you: $"..price.."."
			addVehicleUpgrade(vehicle,1087)
		elseif option == 3 then		
			setVehicleWheelStates(vehicle,0,0,0,0)
			messageToBuyer = "You have bought new wheels ( $"..price.." ) for your vehicle."
			messageToMechanic = "You have sold new wheels to "..getPlayerName(source)..", earning you: $"..price.."."
			setVehicleDamageProof(vehicle,false)				
		elseif option == 4 then		
			setVehicleDamageProof(vehicle,false)
			local vx,vy,vz = getElementRotation(vehicle)
			if vx > 90 or vy > 90 then 		
				setElementRotation(vehicle,0,0,vz)
			end
			fixVehicle(vehicle)
			messageToBuyer = "You have bought a complete repair ( $"..price.." ) for your vehicle."
			messageToMechanic = "You have repaired "..getPlayerName(source).."'s vehicle, earning you: $"..price.."."
		elseif option == 5 then
			setElementData(vehicle,"vehicleFuel",100)
			messageToBuyer = "You have bought a complete refill ( $"..price.." ) for your vehicle."
			messageToMechanic = "You have filled "..getPlayerName(source).."'s vehicle, earning you: $"..price.."."
		end	
		exports.DENdxmsg:createNewDxMessage(source, messageToBuyer, 0, 255, 0)
		takePlayerMoney(source,price)
		if source ~= mechanic then
			exports.DENdxmsg:createNewDxMessage(mechanic, messageToMechanic, 0, 255, 0)
			givePlayerMoney(mechanic,price)
		end	
	else	
		exports.DENdxmsg:createNewDxMessage(source, "You don't have enough money!", 255, 0, 0)		
	end
end
addEvent("doVehicleRepair", true)
addEventHandler("doVehicleRepair", root, doVehicleRepair)

-- rewrite
addEvent("onMechanicPickVehicle",true)
function onMechanicPickVehicle(vehicleOwner,vehicle)
	triggerClientEvent(vehicleOwner, "onMechanicShowGUI", vehicleOwner, source, vehicle)
end

addEventHandler("onMechanicPickVehicle", root, onMechanicPickVehicle )

function rejectMechanicRequest (theMechanic)
	exports.DENdxmsg:createNewDxMessage(theMechanic, getPlayerName(source) .. " doesn't need your services now.", 200, 0, 0)
end
addEvent("rejectMechanicRequest", true)
addEventHandler("rejectMechanicRequest", root, rejectMechanicRequest)