taxiIDs = { [420]=true, [438]=true }

function taxiLightFunc ( thePlayer )
	if ( isPedInVehicle ( thePlayer ) ) then
		if ( taxiIDs[getElementModel(getPedOccupiedVehicle(thePlayer))] ) and ( getPedOccupiedVehicleSeat ( thePlayer ) == 0 ) then
			setVehicleTaxiLightOn ( getPedOccupiedVehicle ( thePlayer ), not isVehicleTaxiLightOn ( getPedOccupiedVehicle ( thePlayer ) ) )
			if isVehicleTaxiLightOn(getPedOccupiedVehicle(thePlayer)) then
				triggerClientEvent(thePlayer,"CSGtaxi.togLight",thePlayer,true)
			else
				triggerClientEvent(thePlayer,"CSGtaxi.togLight",thePlayer,false)
			end
		end
	end
end


function checkTaxiDriver ( thePlayer, seat, jacked )
	if ( taxiIDs[getElementModel(source)] ) and ( seat == 0 ) then
		if ( getElementData ( thePlayer, "Job" ) ~= 6 and getElementData ( thePlayer, "Occupation" ) == "Taxi Driver" ) then
			bindKey ( thePlayer, "2", "down", taxiLightFunc )
			exports.dendxmsg:createNewDxMessage (thePlayer,"Press the 2 button to start or stop your service for players, or use F5!", 0,255,0 )
		end
	elseif ( taxiIDs[getElementModel(source)] ) and ( seat >= 1 ) then
		if ( isVehicleTaxiLightOn ( source ) ) then
			local taxidriver = getVehicleOccupant ( source, 0 )
			if isElement(taxidriver) and getElementData ( taxidriver, "Occupation" ) == "Taxi Driver" then
				setTimer ( payTaxiFunc, 5000, 1, taxidriver, thePlayer )
			end
		end
	end
end
addEventHandler ( "onVehicleEnter", getRootElement(), checkTaxiDriver )

function payTaxiFunc ( taxidriver, customer )
	if ( isPedInVehicle ( customer ) ) then
		if ( taxiIDs[getElementModel(getPedOccupiedVehicle(customer))] ) then
			if ( getPlayerName ( taxidriver ) == getPlayerName ( getVehicleOccupant ( getPedOccupiedVehicle ( customer ), 0 ) ) ) then
				if ( isVehicleTaxiLightOn ( getPedOccupiedVehicle ( customer ) ) ) then
					if ( getPlayerMoney ( customer ) >= 20 ) then
						takePlayerMoney ( customer, 20 )
						givePlayerMoney ( taxidriver, 20 )
						setTimer ( payTaxiFunc, 5000, 1, taxidriver, customer )
					else
						removePedFromVehicle ( customer )
						outputChatBox ( "You do not have enough money!", customer )
					end
				end
			end
		end
	end
end


