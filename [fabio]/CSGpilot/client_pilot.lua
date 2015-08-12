local missionString = "Currently no mission."

local passengers = {}
local passengerMarkers = {}

function getPassengerMarker(passenger)
	for i=1, #passengers do
		if passengers[i].player == passenger then
			return passengers[i].marker
		end
	end
	return false
end

addEvent ( "airport_c_onPassengerEnter", true )
function pilot_onPassengerEnter ( targetX, targetY )

	if not isPlayerPassenger(source) then

		local x,y,z = getElementPosition ( localPlayer )
		local passengerMarker = createMarker ( targetX, targetY, getGroundPosition ( targetX, targetY, z ), "cylinder", 3, 200, 0, 0 )
		local passengerBlip = createBlipAttachedTo ( passengerMarker, 41 )
		addEventHandler ( "onClientMarkerHit", passengerMarker, pilot_onTargetMarkerHit, false )
		addEventHandler ( "onClientPlayerQuit", source, pilot_onPassengerExit, false )
		addEventHandler ( "onClientPlayerWasted", source, pilot_onPassengerExit, false )

		table.insert( passengers, { player=source, marker=passengerMarker } )
		setElementData ( localPlayer, "airport_pilot_passengers", passengers )
		setElementData ( passengerMarker, "airport_markerPassenger", source )
		setElementData ( passengerMarker, "airport_markerBlip", passengerBlip )

		exports.DENdxmsg:createNewDxMessage ( getPlayerName(source).." has entered your vehicle.", 0, 255, 0 )
		local plane = getPedOccupiedVehicle(localPlayer)

		if #passengers == 1 then

			addEventHandler ( "onClientVehicleExit", plane, pilot_onPlaneExit, false )
			addCommandHandler ( "air", airChatForPilot )
			passengersThatShouldPay = {}
			checkMarkerZTimer = setTimer ( checkMarkerZs, 500, 0 )
			addEventHandler ( "onClientPlayerWasted", localPlayer, pilot_onPilotWasted, false )

		end

		stopCargo()
		missionString = "Currently transporting "..#passengers.." passenger(s)."

	end

end

addEventHandler ( "airport_c_onPassengerEnter", root, pilot_onPassengerEnter )

function checkMarkerZs ()

	for i=1, #passengers do

		if isElement ( passengers[i].marker ) then

			local x,y,z = getElementPosition ( passengers[i].marker )
			local px,py,pz = getElementPosition ( localPlayer )

			if getGroundPosition ( x, y, pz ) ~= z then

				setElementPosition ( passengers[i].marker, x, y, getGroundPosition ( x, y, pz ) )

			end

		end

	end

end

function pilot_onPlaneExit ( thePlayer )

	if isPlayerPassenger( thePlayer ) then

		pilot_onPassengerExit( thePlayer )

	elseif thePlayer == localPlayer then

		pilot_onPilotExit()

	end

end

function pilot_onPilotExit ()

	triggerServerEvent ( "airport_s_pilotExit", localPlayer, passengers )
	removeEventHandler ( "onClientVehicleExit", getPedOccupiedVehicle ( localPlayer ), pilot_onPlaneExit, false )
	removeEventHandler ( "onClientPlayerWasted", localPlayer, pilot_onPilotWasted, false )
	removeCommandHandler ( "air", airChatForPilot )
	if isTimer(checkMarkerZTimer) then destroyTimer ( checkMarkerZTimer ) end

	pilot_reset()


end

function isPlayerPassenger( playerToCheck )

	for i=1, #passengers do

		if passengers[i].player == playerToCheck then

			return true

		end

	end

	return false

end

function pilot_onPassengerExit( passenger )

	for i=1, #passengers do

		if passengers[i].player == passenger then

			if isElement ( passengers[i].marker ) then

				removeEventHandler ( "onClientMarkerHit", passengers[i].marker, pilot_onTargetMarkerHit, false )
				destroyElement ( getElementData ( passengers[i].marker, "airport_markerBlip" ) )
				destroyElement ( passengers[i].marker )

			end

			triggerServerEvent ( "airport_s_onPassengerExit", localPlayer, passenger, passengersThatShouldPay[passenger] )
			removeEventHandler ( "onClientPlayerQuit", passenger, pilot_onPassengerExit, false )
			removeEventHandler ( "onClientPlayerWasted", passenger, pilot_onPassengerExit, false )
			table.remove ( passengers, i )
			setElementData ( localPlayer, "airport_pilot_passengers", passengers )

			if #passengers <= 0 then

				removeEventHandler ( "onClientVehicleExit", getPedOccupiedVehicle ( localPlayer ), pilot_onPlaneExit, false )
				removeEventHandler ( "onClientPlayerWasted", localPlayer, pilot_onPilotWasted, false )
				removeCommandHandler ( "air", airChatForPilot )
				if isTimer(checkMarkerZTimer) then killTimer ( checkMarkerZTimer ) end
				missionString = "Currently no mission."
			end

		end

	end

	for i = 1, #passengersThatShouldPay do

		if passengersThatShouldPay[i] == passenger then

			table.remove ( passengersThatShouldPay, i )

		end

	end

	exports.DENdxmsg:createNewDxMessage ( getPlayerName( passenger ).." has left your vehicle.", 0, 255, 0 )

end

function getSmallVersionOfPassengers()

	local new = {}
	for i=1, #passengers do

		table.insert ( new, passengers.player )

	end
	return new

end

function pilot_onPilotWasted()

	local passengers = getSmallVersionOfPassengers()
	triggerServerEvent ( "airport_s_pilotDied", localPlayer, passengers )
	removeEventHandler ( "onClientVehicleExit", getPedOccupiedVehicle ( localPlayer ), pilot_onPlaneExit, false )
	removeEventHandler ( "onClientPlayerWasted", localPlayer, pilot_onPilotWasted, false )
	removeCommandHandler ( "air", airChatForPilot )
	if isTimer(checkMarkerZTimer) then killTimer ( checkMarkerZTimer ) end
	pilot_reset()

end

function pilot_reset()

	setTimer ( function () passengersThatShouldPay = {} end, 1500, 1 )
	for i=1, #passengers do


		if isElement ( passengers[i].marker ) then destroyElement ( passengers[i].marker ) end
		if isElement ( getElementData ( passengers[i].marker, "airport_markerBlip" ) ) then destroyElement ( getElementData ( passengers[i].marker, "airport_markerBlip" ) ) end

	end
	setTimer ( function () passengers = {} end, 1500, 1 )

end

function airChatForPilot(commandName, ...)

local arg = {...}
local allMessages = tostring( table.concat( arg, " " ) )

	if allMessages and string.gsub(allMessages, " ", "") ~= "" then

		if getElementData(localPlayer, "Occupation" ) == "Pilot" then

			local passengers = nil
			passengers = getElementData ( localPlayer, "airport_pilot_passengers" )

			if passengers then

				triggerServerEvent ( "airport_s_chat", localPlayer, allMessages, localPlayer, passengers )

			end

		end

	end

end

function pilot_onTargetMarkerHit()
local passenger = getElementData ( source, "airport_markerPassenger" )

	if passenger then

		if not passengersThatShouldPay[passenger] then table.insert ( passengersThatShouldPay, passenger ) end
		local marker = getPassengerMarker( passenger )
		destroyElement ( getElementData ( marker, "airport_markerBlip" ) )
		destroyElement ( marker )
		triggerServerEvent ( "airport_s_notifyPassengerOfArrival", passenger )

	end

end

--------- cargo

function playerHasPlane()

	local vehicle = getPedOccupiedVehicle( localPlayer )
	if vehicle then
		local vehType = getVehicleType( vehicle )
		return vehType == "Plane" or vehType == "Helicopter"
	end
	return false

end

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end

local cargoStartMissionTimer
local cargoDestinationMarker
local cargoDestinationBlip
local onCargoMission
local cargoStartMarkerHit
local cargoMissionTarget
local cargoMissionStart
local pilotInitialised = false
local cargoPlayerPlane

local cargos = {
{1847.3192138672, -2433.3432617188,13.5546875, "Los Santos" },
{-1246.8717041016, -98.002494812012, 14.1484375, "San Fierro"},
{349.71725463867, 2538.3332519531, 16.741161346436, "the Abandoned Airstrip"},
{1565.3238525391, 1642.0261230469, 10.8203125, "Las Venturas"}
}

function onElementDataChange( dataName, oldValue )
	if dataName == "Occupation" and source == localPlayer then
		if getElementData(localPlayer,dataName) == "Pilot" then
			initCargo()
		else
			onEndPilotJob()
		end
	end
end
addEventHandler ( "onClientElementDataChange", localPlayer, onElementDataChange )

addEvent( "onClientPlayerTeamChange" )
function onTeamChange ( oldTeam, newTeam )
	if source == localPlayer then
		setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local newTeam = getTeamName ( getPlayerTeam( localPlayer ) )
				if getElementData ( localPlayer, "Occupation" ) == "Pilot" and newTeam == "Civilian Workers" then
					initCargo ()
				else
					onEndPilotJob()
				end
			end
		end, 500, 1 )
	end
end
addEventHandler( "onClientPlayerTeamChange", localPlayer, onTeamChange )

function onResourceStart()
	setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local team = getTeamName ( getPlayerTeam( localPlayer ) )
				if getElementData ( localPlayer, "Occupation" ) == "Pilot" and team == "Civilian Workers" then
					initCargo()
				end
			end
		end
	, 2500, 1 )
end
addEventHandler ( "onClientResourceStart", resourceRoot, onResourceStart )

function isPlayerPilot()
	local occupation = getElementData ( localPlayer, "Occupation" )
	local team = getPlayerTeam ( localPlayer )
	if team then
		return getTeamName ( team ) == "Civilian Workers" and occupation == "Pilot"
	end
end

function initCargo()

	if pilotInitialised then return false end
	pilotInitialised = true
	if isTimer ( cargoStartMissionTimer ) then killTimer ( cargoStartMissionTimer ) end

	cargoStartMissionTimer = setTimer ( startCargoMission, math.random(5000,15000), 1 )
	bindKey("F5","down",togglePilotPanel)
end

function onEndPilotJob()

	if not pilotInitialised then return false end
	pilotInitialised = false
	if isTimer ( cargoStartMissionTimer ) then

		killTimer ( cargoStartMissionTimer )

	else


		if cargoPlayerPlane and isElement ( cargoPlayerPlane ) then

			removeEventHandler ( "onClientVehicleExit", cargoPlayerPlane, onExitVehicle, false )
			removeEventHandler ( "onClientElementDestroy", onCargoMission, stopCargo, false )

		end
		cargoPlayerPlane = false

		cargoMissionTarget = false
		cargoMissionStart = false
		onCargoMission = false
		cargoStartMarkerHit = false

		removeEventHandler ( "onClientPlayerWasted", localPlayer, stopCargo, false )
		if isElement(cargoDestinationMarker) then removeEventHandler ( "onClientMarkerHit", cargoDestinationMarker, onCargoMarkerHit ) end
		cargoPlayerPlane = nil
		if isElement ( cargoDestinationBlip ) then destroyElement ( cargoDestinationBlip ) end
		if isElement ( cargoDestinationMarker ) then destroyElement ( cargoDestinationMarker ) end

	end
	unbindKey("F5","down",togglePilotPanel)
end

function stopCargo()

	if isTimer ( cargoStartMissionTimer ) then

		killTimer ( cargoStartMissionTimer )

	else

		cargoMissionTarget = false
		cargoMissionStart = false
		onCargoMission = false
		cargoStartMarkerHit = false
		if cargoPlayerPlane and isElement ( cargoPlayerPlane ) then

			removeEventHandler ( "onClientVehicleExit", cargoPlayerPlane, onExitVehicle, false )
			removeEventHandler ( "onClientElementDestroy", cargoPlayerPlane, stopCargo, false )

		end
		cargoPlayerPlane = false

		removeEventHandler ( "onClientPlayerWasted", localPlayer, stopCargo, false )
		removeEventHandler ( "onClientMarkerHit", cargoDestinationMarker, onCargoMarkerHit )
		cargoPlayerPlane = nil
		if isElement ( cargoDestinationBlip ) then destroyElement ( cargoDestinationBlip ) end
		if isElement ( cargoDestinationMarker ) then destroyElement ( cargoDestinationMarker ) end

		if isPlayerPilot() then

			cargoStartMissionTimer = setTimer ( startCargoMission, math.random(5000,15000), 1 )

		end
		missionString = "Currently no mission."
		
	end
end

function onExitVehicle(thePlayer)

	if thePlayer == localPlayer then

		stopCargo()

	end

end


function startCargoMission ()

	if playerHasPlane() and getElementHealth ( localPlayer ) > 0 and #passengers == 0 then

		cargoMissionStart = math.random(1,#cargos)
		cargoMissionTarget = math.random(1,#cargos)
		while cargoMissionTarget == cargoMissionStart do

			cargoMissionTarget = math.random(1,#cargos)

		end
		onCargoMission = true
		cargoPlayerPlane = getPedOccupiedVehicle( localPlayer )
		cargoStartMarkerHit = false
		cargoDestinationMarker = createMarker ( cargos[cargoMissionStart][1], cargos[cargoMissionStart][2], cargos[cargoMissionStart][3]-1, "cylinder", 5, 255, 0, 0 )
		cargoDestinationBlip = createBlipAttachedTo ( cargoDestinationMarker, 0, 3 )
		addEventHandler ( "onClientMarkerHit", cargoDestinationMarker, onCargoMarkerHit )
		addEventHandler ( "onClientVehicleExit", cargoPlayerPlane, onExitVehicle, false )
		addEventHandler ( "onClientElementDestroy", cargoPlayerPlane, stopCargo, false )
		addEventHandler ( "onClientPlayerWasted", localPlayer, stopCargo, false )
		exports.DENdxmsg:createNewDxMessage( "There has been a request for cargo transport, pick up the cargo in "..tostring(cargos[cargoMissionStart][4])..".", 0, 255, 0 )
		missionString = cargos[cargoMissionStart][4].." to "..cargos[cargoMissionTarget][4]
	else

		cargoStartMissionTimer = setTimer ( startCargoMission, math.random(5000,15000), 1 )

	end

end

function onCargoMarkerHit ( hitElement )
	if hitElement ~= localPlayer and hitElement ~= cargoPlayerPlane then return end
	local vehiclespeed = getElementSpeed ( getPedOccupiedVehicle ( localPlayer ) )
	if vehiclespeed <= 35 then

		setElementFrozen ( getPedOccupiedVehicle ( localPlayer ), true )
		fadeCamera ( false, 1 )
		setTimer ( fadeCamera, 1500, 1, true, 1 )
		setTimer (
			function (veh)
			if isElement ( veh ) then setElementFrozen ( veh, false )  end
		end, 2000, 1, getPedOccupiedVehicle ( localPlayer ) )
		if not cargoStartMarkerHit then
			cargoStartMarkerHit = true
			setTimer (
			function ()
				if onCargoMission then
					local x,y,z = cargos[cargoMissionTarget][1], cargos[cargoMissionTarget][2], cargos[cargoMissionTarget][3]-1
					setElementPosition ( cargoDestinationMarker, x, y, z )
					exports.DENdxmsg:createNewDxMessage( "You picked up the cargo, now bring it to "..cargos[cargoMissionTarget][4]..".", 0, 255, 0 )
				end
			end, 1500, 1 )
		else
			setTimer(
			function ()
				if onCargoMission then
					local sx, sy = cargos[cargoMissionStart][1], cargos[cargoMissionStart][2]
					local tx, ty = cargos[cargoMissionTarget][1], cargos[cargoMissionTarget][2]
					
					local theRank,stat,rankN, nextRank, nextRankPoints = exports.csgranks:getPlayerRankInfo()
					local reward = 1000 +  ( ( math.floor( getDistanceBetweenPoints2D( sx, sy, tx, ty ) /100 ) * 100 ) * getBonusMultiplier(rankN or 1) )
					triggerServerEvent ( "onPlayerFinishCargo", localPlayer, reward )
					stopCargo()
				end
			end, 1500, 1 )
		end
	else
		local pre = ""
		if cargoStartMarkerHit then
			pre = "un"
		end
		local message = "Slow down, the cargo can't be "..pre.."loaded!"
		exports.DENdxmsg:createNewDxMessage ( message, 255, 0, 0 )
	end
end

-- panel
local pilotGUI = {}

function togglePilotPanel()
	if isElement(pilotGUI.window) then
		if guiGetVisible(pilotGUI.window) then
			guiSetVisible(pilotGUI.window,false)
			showCursor(false)
		else
			updatePilotPanel()
			guiSetVisible(pilotGUI.window,true)
			showCursor(true)		
		end
	else
		pilotGUI.window = guiCreateWindow(490, 317, 461, 314, "Pilot panel", false)
		guiWindowSetSizable(pilotGUI.window, false)

		pilotGUI.close = guiCreateButton(324, 270, 127, 34, "Close", false, pilotGUI.window)
			addEventHandler("onClientGUIClick",pilotGUI.close,togglePilotPanel,false)
		pilotGUI.points = guiCreateLabel(15, 32, 421, 31, "points", false, pilotGUI.window)
			guiLabelSetVerticalAlign(pilotGUI.points,"center")
			guiLabelSetHorizontalAlign(pilotGUI.points,"left")
		pilotGUI.rank = guiCreateLabel(15, 77, 421, 31, "rank", false, pilotGUI.window)
			guiLabelSetVerticalAlign(pilotGUI.rank,"center")
			guiLabelSetHorizontalAlign(pilotGUI.rank,"left")
		pilotGUI.nextRank = guiCreateLabel(15, 126, 421, 31, "next rank with points", false, pilotGUI.window)
			guiLabelSetVerticalAlign(pilotGUI.nextRank,"center")
			guiLabelSetHorizontalAlign(pilotGUI.nextRank,"left")
		pilotGUI.bonus = guiCreateLabel(15, 172, 421, 31, "bonus", false, pilotGUI.window)
			guiLabelSetVerticalAlign(pilotGUI.bonus,"center")
			guiLabelSetHorizontalAlign(pilotGUI.bonus,"left")
		pilotGUI.mission = guiCreateLabel(15, 223, 421, 31, "mission", false, pilotGUI.window)
			guiLabelSetVerticalAlign(pilotGUI.mission,"center")
			guiLabelSetHorizontalAlign(pilotGUI.mission,"left")
		
		showCursor(true)
		updatePilotPanel()
	end
end

function getBonusMultiplier(rankNumber)
	rankNumber = rankNumber -1 -- first rank has no bonus
	return 1+(math.floor(rankNumber*4)/100)
end

function updatePilotPanel()
	local theRank,stat,rankN, nextRank, nextRankPoints = exports.csgranks:getPlayerRankInfo()
	if theRank and stat and rankN then
		guiSetText(pilotGUI.points,"Pilot points: "..stat..".")
		guiSetText(pilotGUI.rank,"Pilot rank: "..theRank..".")
		if nextRank and nextRankPoints then
			guiSetText(pilotGUI.nextRank,"Next pilot rank: "..nextRank.." with "..nextRankPoints.." points earning a "..math.floor((getBonusMultiplier(rankN+1)-1)*100).."% bonus reward.")
		else
			guiSetText(pilotGUI.nextRank,"Next pilot rank: maximum rank! Good job.")
		end
		guiSetText(pilotGUI.bonus,"Current bonus: "..math.floor((getBonusMultiplier(rankN)-1)*100).."%.")
		guiSetText(pilotGUI.mission, "Current mission: "..missionString)
	end
end

