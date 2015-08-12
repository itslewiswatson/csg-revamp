addEvent ( "airport_s_buyTicket", true )
function onPlaneEnter ( thePlayer )
local vehID = getElementModel ( source )

	if getVehicleOccupant ( source, 0 ) and thePlayer ~= getVehicleOccupant ( source, 0 ) then

		if getElementData(getVehicleOccupant ( source, 0 ), "Occupation") == "Pilot" and getElementData(thePlayer, "Occupation") ~= "Pilot" then

			if vehID == 487 or getVehicleType ( source ) == "Plane" then

				local occupants = getVehicleOccupants(source)
				local seats = getVehicleMaxPassengers(source)
				local vehOccupants = 0
					for seat = 0, seats do
						if isElement(getVehicleOccupant ( source, seat )) then
							vehOccupants = vehOccupants + 1
						end
					end
					if vehID == 511 then

						if vehOccupants-1 >= 2 then

							exports.DENdxmsg:createNewDxMessage(thePlayer, "Sorry, this plane is full!", 255, 0, 0)
							cancelEvent()
							return

						end

					elseif getVehicleType ( source ) == "Helicopter" then

						if vehOccupants-1 >= 4 then

							exports.DENdxmsg:createNewDxMessage(thePlayer, "Sorry, this helicopter is full!", 255, 0, 0)
							cancelEvent()
							return

						end

					end

				triggerClientEvent ( thePlayer, "airport_c_buyTicket", source )
				cancelEvent()
				setElementData ( thePlayer, "planeToEnter", source )

			end

		end

	end

end

addEventHandler ( "onVehicleStartEnter", root, onPlaneEnter )

function server_buyTicket ( check, price, coords )

	if check == true then

		if getPlayerMoney ( source ) >= price then

			local plane = getElementData ( source, "planeToEnter" )
			local pilot = getVehicleOccupant ( plane, 0 )
			setElementData ( source, "airportPrice", price )
			triggerClientEvent ( source, "airport_c_onStartFlight", pilot, plane )
			local targetX, targetY = coords[1], coords[2]

			if getVehicleType ( plane ) == "Helicopter" or getElementModel ( plane ) == 511 then

				if not getVehicleOccupant ( plane, 1 ) then
					warpPedIntoVehicle ( source, plane, 1 )
				elseif not getVehicleOccupant ( plane, 2 ) then
					warpPedIntoVehicle ( source, plane, 2 )
				elseif not getVehicleOccupant ( plane, 3 ) then
					warpPedIntoVehicle ( source, plane, 3 )
				end

			else

				setElementInterior ( source, 1, 1.6127,34.7411,1199.2 )

			end

			setTimer ( triggerClientEvent, 50, 1, pilot, "airport_c_onPassengerEnter", source, targetX, targetY )
			setElementData ( source, "air_pilot", pilot )
			setElementData ( source, "airport_destination", coords )

		else

			exports.DENdxmsg:createNewDxMessage(source, "You need $" .. tostring(price) .. " to buy this ticket!", 255, 0, 0)

		end

		triggerClientEvent ( source, "airport_c_buyTicket", source )

	end

end

addEventHandler ( "airport_s_buyTicket", root, server_buyTicket )

addEvent ( "airport_s_onPassengerExit", true )

function onPassengerExit ( passenger, shouldPay )

	local pilot = source
	if shouldPay then

		local price = getElementData ( passenger, "airportPrice" )

		if price then

			exports.CSGaccounts:addPlayerMoney ( pilot, price )

			exports.CSGaccounts:removePlayerMoney ( passenger, price )
			exports.DENdxmsg:createNewDxMessage ( pilot, "Your passenger "..getPlayerName(passenger).." reached it's destination.", 0, 255, 0 )
			exports.DENdxmsg:createNewDxMessage ( pilot, "You earned $"..price.." and 5 pilot points.", 0, 255, 0 )
			
			local pts = exports.DENstats:getPlayerAccountData(pilot,"pilot")
			exports.DENstats:setPlayerAccountData ( pilot, "pilot", pts+5 )
			
		end

	end

end

addEventHandler ( "airport_s_onPassengerExit", root, onPassengerExit )

addEvent ( "airport_s_notifyPassengerOfArrival", true )

function onArrival ()

	exports.DENdxmsg:createNewDxMessage ( source, "Your pilot has arrived at your destination.", 0, 255, 0 )

end

addEventHandler ( "airport_s_notifyPassengerOfArrival", root, onArrival )

addEvent ( "airport_s_pilotDied", true )

function pilotDied ( passengers )

	for i=1, #passengers do

		if isElement ( passengers[i] ) and not isPedDead ( passengers[i] ) then

			exports.DENdxmsg:createNewDxMessage ( passengers[i], "Your pilot has died, you will be ejected.", 255, 0, 0 )
			triggerClientEvent ( passengers[i], "airport_c_exitTransporter", source )

		end

	end

end

addEventHandler ( "airport_s_pilotDied", root, pilotDied )

addEvent ( "airport_s_pilotExit", true )

function pilotEit ( passengers )

	for i=1, #passengers do

		if isElement ( passengers[i] ) and not isPedDead ( passengers[i] ) then

			exports.DENdxmsg:createNewDxMessage ( passengers[i], "Your pilot has got out of his vehicle, you will be ejected.", 255, 0, 0 )
			triggerClientEvent ( passengers[i], "airport_c_exitTransporter", source )

		end

	end

end

addEventHandler ( "airport_s_pilotExit", root, pilotDied )

addEvent ( "airport_s_notifyPassengersOfPilotDeath", true )

function notifyPassengersPilotDied ( passengerTable )


		for i=1,#passengerTable do
			triggerClientEvent ( passengerTable[i], "exitTheTransporter", source )
			outputChatBox ( "Air Services >> Your pilot " .. getPlayerName ( source ) .. " has died, you have been ejected.", v,0,0,255 )
		end

end

addEventHandler ( "airport_s_notifyPassengersOfPilotDeath", root, notifyPassengersPilotDied )


addEvent ( "airport_s_chat", true )

function passengerPilotChat ( message, pilot, pilotTable )

	if message and pilot and pilotTable then

		local prefix = "Air Services >> " .. getPlayerName(source) .. ":#FFFFFF "

			if source == pilot then

				prefix = "Air Services >> Pilot " .. getPlayerName(source) .. ":#FFFFFF "

			end
	local message, original = exports.server:cleanStringFromBadWords( message )

		for i=1, #pilotTable do

			outputChatBox ( prefix .. message, pilotTable[i], 0, 0, 255, true )

		end

			outputChatBox ( prefix .. message, pilot, 0, 0, 255, true )

	end

end

addEventHandler ( "airport_s_chat", root, passengerPilotChat )


addEvent( "onPlayerFinishCargo", true )

function payPlayerForCargo( reward )

	exports.CSGaccounts:addPlayerMoney ( source, reward )
	exports.CSGscore:givePlayerScore(source,0.5)
	exports.DENdxmsg:createNewDxMessage( source, "You succesfully dropped off the cargo and earned $"..tostring(reward)..", 0.5 score and 3 pilot points.", 0, 255, 0 )
	local pts = exports.DENstats:getPlayerAccountData(source,"pilot")
	exports.DENstats:setPlayerAccountData ( source, "pilot", pts+3 )
end

addEventHandler ( "onPlayerFinishCargo", root, payPlayerForCargo )
