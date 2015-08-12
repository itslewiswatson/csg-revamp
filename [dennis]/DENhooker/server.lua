function askOnEnter ( theVehicle, seat, jacked )
	if (getVehicleType(theVehicle) == "Automobile") or (getVehicleType(theVehicle) == "Helicopter") or (getVehicleType(theVehicle) == "Monster Truck") then
		if (getTeamName(getPlayerTeam(source )) == "Civilian Workers") and (getElementData( source , "Occupation" ) == "Prostitute") then
			if seat == 1 then
				if not ( getElementData ( source, "isPlayerArrested" ) ) then
					local theUser = getVehicleOccupant ( theVehicle, 0 )
					if isElement(theUser) then
						triggerClientEvent ( theUser, "askForBlowjob", getRootElement(), source)
						outputChatBox ("Waiting till player has made a choise...", source, 0, 225, 0)
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), askOnEnter )

addEvent ("cancelBlowJob", true )
function cancelBlowJob(hooker, thePlayer)
	outputChatBox ("This person dont want a blowjob!", hooker, 225,0,0)
end
addEventHandler ( "cancelBlowJob", getRootElement(), cancelBlowJob )

addEvent ("acceptBlowjob", true )
function acceptBlowjob(hooker, theSucked)
		local clienHealth = getElementHealth ( theSucked )
		local clientMoney = getPlayerMoney(theSucked)
		if clienHealth > 98 then
		outputChatBox ("This player has already full health and don't need a blowjob!", hooker, 225, 0, 0)
		elseif clientMoney < 10 then
		outputChatBox ("This player dont have enough money to pay the blowjob.", hooker, 225, 0, 0)
		elseif isPedInVehicle(hooker) == true then
		setPedAnimation( hooker, "BLOWJOBZ", "BJ_Car_Loop_W", -1, true, false, false)
		takeanother = setTimer ( startBlowjob, 3000, 0, hooker, theSucked )
		startBlowjob(hooker, theSucked)
	end
end
addEventHandler ( "acceptBlowjob", getRootElement(), acceptBlowjob )

function startBlowjob(hooker, blowedPlayer)
		local clientMoney = getPlayerMoney(blowedPlayer)
		local clienHealth = getElementHealth ( blowedPlayer )
			if clienHealth > 98 then
				setPedAnimation ( hooker, "BLOWJOBZ", "BJ_Car_Stop", -1, false, false, true)
				outputChatBox ("Good work!, You are now done with the blowjob.", hooker, 225, 0, 0)
				killTimer ( takeanother )
			elseif clientMoney < 10 then
				setPedAnimation ( hooker, "BLOWJOBZ", "BJ_Car_Stop", -1, false, false, true)
				outputChatBox ("This player dont have enough money to pay the blowjob.", hooker, 225, 0, 0)
				killTimer ( takeanother )
			else
		setElementHealth ( blowedPlayer, clienHealth + 15 )
		takePlayerMoney ( blowedPlayer, 100 )
		givePlayerMoney ( hooker, 100 )
	end
end