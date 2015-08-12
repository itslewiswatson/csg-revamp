local screenX, screenY = guiGetScreenSize()
truckMissionActive = false
gps = false

missionData = {}

function getPointFromDistanceRotation(x, y, dist, angle)

    local a = math.rad(angle-90);

    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;

    return x+dx, y+dy;

end

function centerWindow(center_window)
    local screenW,screenH=screenX, screenY
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

missions =
{
{ 76.698150634766, -244.18774414063, 1.5, "" },
{ 1348.78, 355.87, 19.69, " - BIO-Engineering" },
{ 2461.66, -2110.8, 13.54, " - Oil Plant" },
{ 2183.56,-2274.58,13.5, " - Train Station" },
{ 2757.73, -2394.69, 13.63, " - Docks" },
{ -1534.42, -2748.16, 48.53, " - Gas Station" },
{ -2109.35, -93.63, 35.32, "" },
{ -334.22, 1522.82, 75.35, "" },
{ -479.57, -504.42, 25.51, "" },
{ -1048.74, -655.38, 32, "" },
{ 688, 1844.42, 5.5, "" },
{ -1742.28, -106.07, 3.55, " - Docks" },
{ -2100.42, -2255.42, 30.62, "" },
{ -74.57, -1129.11, 1.07, " - RS Haul" },
{ 1018.1, -333.53, 73.99, " - Farm" },
{ -1843.15, 135.49, 15.11, " - Solarin Factory" },
{ 0, 20, 4, " - Farm" },
{ 2100.55, -2218.26, 13.54, " - Airport" },
{ -110.71, 1117.29, 19.74, "" },
{ -531.12, 2622.91, 53.41, "" },
{ -743.63, 2740.09, 47.7, "" },
{ -1116.82, -1660.43, 76.36, " - Farm" },
{ -2198.19, -2435.08, 30.62, "" },
{ -265.66, -2166.94, 28.86, "" },
{ 382.7, -1861.36, 7.83, "" },
{ 1775.6, -2049.4, 13.56, "" },
{ 1780.85, -1928.19, 13.38, "" },
{ 2393.54, -1474.36, 23.81, "" },
{ 2412.35, -2470.56, 13.62, "" },
{ 2317.81, -74.56, 26.48, "" },
{ 1694.32, 693.18, 10.82, "" },
{ 2634.6, 1075.75, 10.82, " - Gas Station" },
{ 1618, 1623, 10.82, " - Airport" },
{ 2050.45, 2238.89, 10.82, "" }
}

truckIDs =
{
515,
514,
403
}

function isTruck(ID)

	for i=1, #truckIDs do

		if truckIDs[i] == ID then return true end

	end

	return false

end

function onElementDataChange( dataName, oldValue )

	if dataName == "Occupation" and getElementData(localPlayer,dataName) == "Trucker" then

		initTruckerJob()

	elseif dataName == "Occupation" then

		stopTruckerJob()

	end

end

addEventHandler ( "onClientElementDataChange", localPlayer, onElementDataChange, false )

function onTruckerTeamChange ( oldTeam, newTeam )

	if getElementData ( localPlayer, "Occupation" ) == "Trucker" and source == localPlayer then

		setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local newTeam = getTeamName ( getPlayerTeam( localPlayer ) )

				if newTeam == "Unoccupied" then

					stopTruckerJob()

				elseif getElementData ( localPlayer, "Occupation" ) == "Trucker" and newTeam == "Civilian Workers" then

					initTruckerJob()

				end

			end

		end, 200, 1 )

	end

end

addEventHandler( "onClientPlayerTeamChange", localPlayer, onTruckerTeamChange, false )

function onResourceStart()

	setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local team = getTeamName ( getPlayerTeam( localPlayer ) )

				if getElementData ( localPlayer, "Occupation" ) == "Trucker" and team == "Civilian Workers" then

					initTruckerJob()

				end

			end

		end
	, 2500, 1 )

	if type(getElementData ( localPlayer, "trucking_stopsDone" )) ~= "number" then

		setElementData ( localPlayer, "trucking_stopsDone", 0 )

	end

end

addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), onResourceStart )


addEvent( "onClientPlayerTeamChange" )
function initTruckerJob()

	if not isTrucker then

		for i=1,#missions do

			missions[i][6] = createMarker ( missions[i][1],  missions[i][2],  missions[i][3]-1,  "cylinder", 3, 75, 120, 40 )
			addEventHandler ( "onClientMarkerHit", missions[i][6], startTruckerMissions, false )

		end

		isTrucker = true
		bindKey ( "F5", "down", toggleTruckerInfoGUI )

	end

end

function stopTruckerJob ()

	if isTrucker then

		stopTruckerMission()
		for i=1, #missions do

			if isElement(missions[i][6]) then

				removeEventHandler ( "onClientMarkerHit", missions[i][6], startTruckerMissions, false )
				destroyElement(missions[i][6])

			end

		end
		unbindKey ( "F5", "down", toggleTruckerInfoGUI )
		isTrucker = false

	end

end

function fillDestinationGrid(element)

missionData = {}
destroyElement(truckGrid)
truckGrid = guiCreateGridList(9,24,445,294,false,truckWindow)
nameColumn = guiGridListAddColumn ( truckGrid, "Destination", 0.55 )
rewardColumn = guiGridListAddColumn ( truckGrid, "Reward", 0.35 )
guiGridListSetSelectionMode(truckGrid,0)
guiGridListClear(truckGrid)
local px, py, pz = getElementPosition(element)

	for i=1, #missions do

		local distance = getDistanceBetweenPoints3D ( px, py, pz, missions[i][1], missions[i][2], missions[i][3] )

			if distance >= 300 then

				local row = guiGridListAddRow(truckGrid)
				local price = calculateDestinationPrice(px,py,pz,missions[i][1], missions[i][2],missions[i][3])
				local zoneName = getZoneName(missions[i][1], missions[i][2],missions[i][3], true)
				guiGridListSetItemText ( truckGrid, row, 1, zoneName..tostring(missions[i][4]), false, false )
				guiGridListSetItemText ( truckGrid, row, 2, tostring(price).."$", false, true )
				missions[i][5] = price
				local rowID = guiGridListGetRowCount(truckGrid)-1
				guiGridListSetItemData ( truckGrid, rowID, 1, rowID )
				guiGridListSetItemData ( truckGrid, rowID, 2, rowID )
				missionData[rowID] = missions[i]
				missions[i].dist = distance

			end

	end

end

function calculateDestinationPrice (playerX, playerY, playerZ, targetX, targetY, targetZ)

	local startPrice = 100
	local distance = getDistanceBetweenPoints3D ( playerX, playerY, playerZ, targetX, targetY, targetZ )
	if distance > 2500 then

		startPrice = 250

	end
	local distancePrice = math.floor((distance/1.1) / 10) * 10
	local bonus = math.floor( getTruckerBonusForLevel ( getTruckerLevel(), distancePrice ) )
	local price = startPrice + distancePrice + bonus

	return price

end

function startTruckerMissions ( hitElement )

if hitElement ~= localPlayer then return end

	if getElementData ( hitElement, "Occupation" ) == "Trucker" then

		if ( getPedOccupiedVehicle ( hitElement ) and getVehicleController ( getPedOccupiedVehicle ( hitElement ) ) == hitElement ) or truckMissionActive then

			if isTruck(getElementModel ( getPedOccupiedVehicle ( hitElement ) )) then

				createTruckerGUI(source)
				setElementVelocity ( getPedOccupiedVehicle ( hitElement ), 0, 0, 0 )
				setElementFrozen ( getPedOccupiedVehicle ( hitElement ), true )
				lastMarkerHit = source
				sourceMarker = source

			else

				exports.DENdxmsg:createNewDxMessage( "You need to be the driver of a truck!", 255, 0, 0 )

			end

		else

			exports.DENdxmsg:createNewDxMessage( "You need to be the driver of a truck!", 255, 0, 0 )

		end

	else

		exports.DENdxmsg:createNewDxMessage( "You have to be a truck driver!", 255, 0, 0 )
		stopTruckerJob()

	end

end

function createTruckerGUI(marker)

	if truckWindow then

		if guiGetVisible ( truckWindow ) then

			return false

		else

			guiSetVisible ( truckWindow, true )

		end

	else

		truckWindow = guiCreateWindow(529,290,463,360,"CSG ~ Trucker Locations",false)
		centerWindow(truckWindow)
		truckGrid = guiCreateGridList(9,24,445,294,false,truckWindow)
		nameColumn = guiGridListAddColumn ( truckGrid, "Destination", 0.55 )
		rewardColumn = guiGridListAddColumn ( truckGrid, "Reward", 0.35 )
		guiGridListSetSelectionMode(truckGrid,0)

		local toggleText = "Choose location"

		if truckMissionActive then

			toggleText = "Stop"
			guiSetEnabled ( truckGrid, false )

		end

		truckButton_toggle = guiCreateButton(9,323,217,26,toggleText,false,truckWindow)
		truckButton_cancel = guiCreateButton(228,323,225,26,"Close window",false,truckWindow)

	end

	addEventHandler ( "onClientGUIClick", root, onTruckerGUIClick )
	if not truckMissionActive then
		fillDestinationGrid(marker)
	end
	showCursor(true)

end

function closeTruckerGUI()

	guiSetVisible ( truckWindow, false )
	removeEventHandler ( "onClientGUIClick", root, onTruckerGUIClick )
	showCursor(false)
	setElementFrozen ( getPedOccupiedVehicle ( localPlayer ), false )

end

function onTruckerGUIClick ()

	if source == truckButton_toggle then

		if truckMissionActive then

			exports.DENdxmsg:createNewDxMessage("Truck Mission Canceled!",255,0,0)

		else

			local veh = getPedOccupiedVehicle(localPlayer)
			local x,y,z = getElementPosition(veh)
			local rx,ry,rz = getElementRotation(veh)
			local endX, endY = getPointFromDistanceRotation ( x,y, 13, rz )
			if not isLineOfSightClear(x,y,z-1,endX, endY, z-1,true,true,true,true,true,false,false,veh) then

				exports.DENdxmsg:createNewDxMessage("There is no room for a trailer!",255,0,0)
				return false

			end

		end

		toggleTruckerMission()

	elseif source == truckButton_cancel then

		closeTruckerGUI()

	end

end

function toggleTruckerMission(success)

	if truckMissionActive then

		if isElement( targetBlip ) then destroyElement ( targetBlip ) end

		-- remove event handlers for exit, death, trailer stop, vehicle explode, quit. etc.
		local targetMarker = truckMissionActive[6]
		guiSetText ( truckButton_toggle, "Choose location" )
		guiSetEnabled ( truckGrid, true )
		addEventHandler ( "onClientMarkerHit", targetMarker, startTruckerMissions, false )
		removeEventHandler ( "onClientMarkerHit", targetMarker, truckerDestinationHit, false )
		removeEventHandler ( "onClientVehicleExit", playerTruck, onExitVehicle, false )
		removeEventHandler ( "onClientVehicleEnter", playerTruck, onEnterVehicle, false )
		removeEventHandler ( "onClientVehicleExplode", playerTruck, onExplodeVehicle, false )
		removeEventHandler ( "onClientTrailerDetach", playerTrailer, onDetachTrailer, false )
		removeEventHandler ( "onClientTrailerAttach", playerTrailer, onAttachTrailer, false )
		removeEventHandler ( "onClientPlayerWasted", localPlayer, onDeath, false )

		if isElement ( truckerInfo_stopMission ) then guiSetEnabled ( truckerInfo_stopMission, false ) end

		if gps then

			exports.csggps:resetDestination ()

		end

		if isTimer(exitVehicleStopTimer) then

			killTimer(exitVehicleStopTimer)
			removeEventHandler ( "onClientRender", root, drawTimeLeftOnExit )

		end
		triggerServerEvent ( "trucking_DestroyTrailer", playerTrailer )
		playerTruck = nil
		playerTrailer = nil
		truckMissionActive = false
		fillDestinationGrid(sourceMarker)

	else

		if guiGridListGetSelectedItem ( truckGrid ) then

			local row, column = guiGridListGetSelectedItem ( truckGrid )
			local missionSelected = missionData[guiGridListGetItemData(truckGrid,row,1)] or missionData[row]
			if missionSelected then

				truckMissionActive = missionSelected
				guiSetText ( truckButton_toggle, "Stop" )
				guiSetEnabled ( truckGrid, false )
				targetBlip = createBlipAttachedTo(missionSelected[6],51)

				if gps then

					exports.csggps:setDestination (missionSelected[1],missionSelected[2],missionSelected[3],missionSelected[4])

				end

				playerTruck = getPedOccupiedVehicle(localPlayer)
				addEventHandler ( "onClientMarkerHit", missionSelected[6], truckerDestinationHit, false )
				addEventHandler ( "onClientVehicleExit", playerTruck, onExitVehicle, false )
				addEventHandler ( "onClientVehicleEnter", playerTruck, onEnterVehicle, false )
				addEventHandler ( "onClientVehicleExplode", playerTruck, onExplodeVehicle, false )
				addEventHandler ( "onClientPlayerWasted", localPlayer, onDeath, false )
				removeEventHandler ( "onClientMarkerHit", missionSelected[6], startTruckerMissions, false )
				triggerServerEvent ( "trucking_CreatePlayerTrailer", localPlayer )
				closeTruckerGUI()
				local zoneName = getZoneName(missionSelected[1], missionSelected[2],missionSelected[3], true)
				local oldX,oldY,oldZ = getElementPosition(sourceMarker)
				local oldZoneName = getZoneName(oldX,oldY,oldZ, true)
				exports.DENdxmsg:createNewDxMessage("Truck Mission started, drive to: "..tostring(zoneName)..tostring(missionSelected[4]),0,255,0)
				missionData = {}
				guiGridListClear(truckGrid)
				if isElement ( truckerInfo_stopMission ) then guiSetEnabled ( truckerInfo_stopMission, true ) end

			else

				exports.DENdxmsg:createNewDxMessage("You must select a mission!",255,0,0)

			end

		else

			exports.DENdxmsg:createNewDxMessage("You must select a mission!",255,0,0)

		end

	end

end

function truckerDestinationHit ( hitElement )

	if(  hitElement == localPlayer and getPedOccupiedVehicle ( hitElement ) and getVehicleController ( getPedOccupiedVehicle ( hitElement ) ) == hitElement )
	or ( ( hitElement == playerTruck or hitElement == playerTrailer ) and getVehicleController(hitElement) == localPlayer ) then

		if truckMissionActive and getVehicleTowedByVehicle( playerTruck ) == playerTrailer then

			lastMarkerHit = source
			sourceMarker = source
			setElementVelocity ( playerTruck, 0, 0, 0)
			setElementVelocity ( playerTrailer, 0, 0, 0)
			setElementFrozen ( playerTruck, true )
			fadeCamera( false, 1.0, 0, 0, 0 )
			local price = truckMissionActive[5]
			triggerServerEvent("trucking_GiveReward", localPlayer, price, truckMissionActive.dist)
			setTimer ( toggleTruckerMission, 1500, 1 )
			exports.DENdxmsg:createNewDxMessage( "Truck mission completed, you earned $"..tostring(price), 0 ,255, 0)
			setTimer( fadeCamera, 2000, 1, true, 1.0, 0, 0, 0 )
			setTimer( setElementFrozen, 2000, 1, playerTruck, false )
			setTimer ( createTruckerGUI, 1600, 1, source)
			local oldStops = getElementData ( localPlayer, "trucking_stopsDone" )
			setElementData ( localPlayer, "trucking_stopsDone", oldStops+1 )
			if isElement ( truckInfo_window ) then

				updateTruckerInfoGUI()

			end

		end

	end

end

function getTruckerLevel ( )

	local stops = tonumber ( getElementData ( localPlayer, "trucking_stopsDone" ) ) or 0

	if stops < 20 then

		return 0

	elseif stops < 50 then

		return 1

	elseif stops < 80 then

		return 2

	elseif stops < 120 then

		return 3

	elseif stops < 170 then

		return 4

	elseif stops < 225 then

		return 5

	elseif stops < 300 then

		return 6

	elseif stops >= 300 then

		stops = stops - 300
		return 7 + math.floor(stops/100)

	end

end

function getTruckerBonusForLevel ( level, distancePrice )

	local percBonus = 0

	if level == 1 then

		percBonus = 2

	elseif level == 2 then

		percBonus = 4

	elseif level == 3 then

		percBonus = 6

	elseif level == 4 then

		percBonus = 8

	elseif level == 5 then

		percBonus = 10

	elseif level == 6 then

		percBonus = 12

	elseif level == 7 then

		percBonus = 14

	elseif level >= 8 then

		percBonus = 16

	end

	return (distancePrice/100) * percBonus

end

function getTruckerInfoStopsNeeded()

	local stops = getElementData ( localPlayer, "trucking_stopsDone" )

	if stops < 20 then

		return 20

	elseif stops < 50 then

		return 50

	elseif stops < 80 then

		return 80

	elseif stops < 120 then

		return 120

	elseif stops < 170 then

		return 170

	elseif stops < 225 then

		return 225

	elseif stops < 300 then

		return 300

	elseif stops >= 300 then

		stops = stops - 300
		return 400 + (math.floor(stops/100)*100)

	end

end

function updateTruckerInfoGUI()

	local truckingDestination = "N/A"
	if truckMissionActive and truckMissionActive[4] then

		local zoneName = getZoneName(truckMissionActive[1], truckMissionActive[2],truckMissionActive[3], true)
		truckingDestination = zoneName..tostring(truckMissionActive[4])

	end

	local stops = getElementData ( localPlayer, "trucking_stopsDone" )
	local level = getTruckerLevel ()
	local bonusPerc = getTruckerBonusForLevel ( level, 100 )
	if bonusPerc == 16 then

		bonusPerc = "16 - Maximum"

	end

	local stopsNeeded = getTruckerInfoStopsNeeded()


	guiSetText ( truckerInfo_missionInfo, "Trucking mission: "..tostring( truckingDestination )  )
	guiSetText ( truckerInfo_stops, "Trucker points: "..tostring( stops ) )
	guiSetText ( truckerInfo_level, "Trucking level: "..tostring( level ) )
	guiSetText ( truckerInfo_rewardBonus, "Reward bonus: %"..tostring( bonusPerc ) )
	guiSetText ( truckerInfo_stopsNeeded, "Stops needed for next level: "..tostring( stopsNeeded ) )

end

function toggleTruckerInfoGUI()

	if not isElement ( truckerInfo_window ) then

		truckerInfo_window = guiCreateWindow(490,336,425,238,"CSG ~ Trucking",false)
		centerWindow(truckerInfo_window)
		truckerInfo_missionInfo = guiCreateLabel(0.02,0.13,0.95,0.12,"Trucking mission:",true,truckerInfo_window)
		truckerInfo_stops = guiCreateLabel(0.02,0.25,0.95,0.12,"Trucker points:",true,truckerInfo_window)
		truckerInfo_level = guiCreateLabel(0.02,0.37,0.95,0.12,"Trucking level:",true,truckerInfo_window)
		truckerInfo_rewardBonus = guiCreateLabel(0.02,0.49,0.95,0.12,"Reward bonus:",true,truckerInfo_window)
		truckerInfo_stopsNeeded = guiCreateLabel(0.02,0.61,0.95,0.12,"Stops needed for next level:",true,truckerInfo_window)
		truckerInfo_stopMission = guiCreateButton(0.1294,0.7437,0.3176,0.2017,"Stop trucking mission",true,truckerInfo_window)
		truckerInfo_close = guiCreateButton(0.5906,0.7437,0.2306,0.2017,"Close",true,truckerInfo_window)
		updateTruckerInfoGUI()
		guiSetVisible ( truckerInfo_window, true )
		addEventHandler ( "onClientGUIClick", root, onTruckerInfoGUIClick )
		showCursor(true)

	else

		if guiGetVisible ( truckerInfo_window ) then

			guiSetVisible ( truckerInfo_window, false )
			removeEventHandler ( "onClientGUIClick", root, onTruckerInfoGUIClick )
			showCursor(false)

		else

			updateTruckerInfoGUI()
			guiSetVisible ( truckerInfo_window, true )
			addEventHandler ( "onClientGUIClick", root, onTruckerInfoGUIClick )
			showCursor(true)

		end

	end

	if not truckMissionActive then

		guiSetEnabled ( truckerInfo_stopMission, false )

	else

		guiSetEnabled ( truckerInfo_stopMission, true )

	end

end

function onTruckerInfoGUIClick()

	if source == truckerInfo_close then

		toggleTruckerInfoGUI()

	elseif source == truckerInfo_stopMission then

		stopTruckerMission()

	end

end

-- event

function onDeath()

	stopTruckerMission("You died, mission failed!")

end

function onEnterVehicle(thePlayer)

	if thePlayer == localPlayer then

		if isTimer(exitVehicleStopTimer) then

			killTimer(exitVehicleStopTimer)
			removeEventHandler ( "onClientRender", root, drawTimeLeftOnExit )

		end

	end

end

function drawTimeLeftOnExit()

	if isTimer(exitVehicleStopTimer) and truckMissionActive then

		local timeLeft, timeLeftEx, timeTotalEx = getTimerDetails ( exitVehicleStopTimer )
		local timeLeft = math.floor(timeLeft / 1000)
		if timeLeft > 0 then

			dxDrawText ( "Time left to get in vehicle: "..tostring(timeLeft).." seconds!", 0, screenY*0.85, screenX, screenY, tocolor(255,0,0), 1.5, "default", "center", "center" )

		end

	else

		removeEventHandler ( "onClientRender", root, drawTimeLeftOnExit )

	end

end


function drawTimeLeftOnDetach()

	if isTimer(detachTrailerStopTimer) and truckMissionActive then

		local timeLeft, timeLeftEx, timeTotalEx = getTimerDetails ( detachTrailerStopTimer )
		local timeLeft = math.floor(timeLeft / 1000)
		if timeLeft > 0 then

			dxDrawText ( "Time left to reattach trailer: "..tostring(timeLeft).." seconds!", 0, screenY*0.7, screenX, screenY*0.85, tocolor(255,0,0), 1.5, "default", "center", "center" )

		end

	else

		removeEventHandler ( "onClientRender", root, drawTimeLeftOnDetach )

	end

end

function onExitVehicle(thePlayer)

	if thePlayer == localPlayer then

		if isTimer(exitVehicleStopTimer) then killTimer(exitVehicleStopTimer) end
		exitVehicleStopTimer = setTimer ( stopTruckerMission, 60000, 1, "You didn't get back in on time, mission failed!")
		addEventHandler ( "onClientRender", root, drawTimeLeftOnExit )

	end

end

function onExplodeVehicle()

	stopTruckerMission()
	exports.DENdxmsg:createNewDxMessage("Your truck exploded, mission failed!",255,0,0)

end

function onDetachTrailer(tower)

	if tower == playerTruck then

		if isTimer(detachTrailerStopTimer) then killTimer(detachTrailerStopTimer) end
		detachTrailerStopTimer = setTimer ( stopTruckerMission, 60000, 1, "You lost your trailer, mission failed!")
		addEventHandler ( "onClientRender", root, drawTimeLeftOnDetach )

	end

end

function onAttachTrailer(tower)

	if tower == playerTruck then

		if isTimer(detachTrailerStopTimer) then killTimer(detachTrailerStopTimer) end

	end

end

function stopTruckerMission(msg)

	if truckMissionActive then

		toggleTruckerMission()

		if msg then

			exports.DENdxmsg:createNewDxMessage(msg,255,0,0)

		end

	end

end

addEvent ( "trailerAttached", true )
function trailerAttached()

playerTrailer = source
addEventHandler ( "onClientTrailerDetach", playerTrailer, onDetachTrailer, false )
addEventHandler ( "onClientTrailerAttach", playerTrailer, onAttachTrailer, false )
	for i=1,5 do
		attachTrailerToVehicle ( playerTruck, playerTrailer )
	end
	setTimer ( attachTrailerToVehicle, 300, 1, playerTruck, playerTrailer )

end

addEventHandler ( "trailerAttached", root, trailerAttached )
