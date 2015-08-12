local bankrobMarkerCoords = {
-- Bankrob markers
{590.29, -1270.52, 64.18, 0, 0, 442.63, -2523.15, 70.05, 210.8885345459, "bank"}, -- dak enter
{597.22, -1249.51, 18.3, 0, 0, 475.08, -2553.36, 52.63, 31.056091308594, "bank"}, -- linksvoor enter
{593.71, -1250.95, 18.25, 0, 0, 477.66, -2553.36, 52.63, 30.742950439453, "bank"}, -- rechtsvoor enter
{600.87, -1282.58, 16.05, 0, 0, 453.69, -2542.71, 52.63, 300.47790527344, "bank"}, -- achter enter
{442.63, -2520.57, 70.05, 0, 200, 593.32, -1270.65, 64.18, 278.96633911133, "bank"}, -- dak exit
{475.08, -2556.46, 52.63, 0, 200, 597.22, -1246.51, 18.3, 18.718231201172, "bank"}, -- linksvoor exit
{477.72, -2554.94, 52.63, 0, 200, 593.37, -1246.95, 18.22, 18.718231201172, "bank"}, -- rechtsvoor exit
{451.41, -2542.71, 52.63, 0, 200, 603.09, -1283.31, 16.05, 197.6662902832, "bank"}, -- achter exit
{457.72, -2483.23, 30.81, 0, 200, 593.37, -1246.95, 18.22, 18.718231201172, "bank"}, -- police basement exit
-- Casinorob markers
{2196.96, 1677.07, 12.36, 1, 0, 2234.02, 1712.3, 1011.78, 189.20118713379, "casino" }, -- Front enter
{2197.24, 1647.08, 20.39, 1, 0, 2271.26, 1635.9, 1008.35, 189.38795471191, "casino" },-- Roof enter
{2234, 1714.599609375, 1011.9000244141, 1 ,0, 2190.95, 1677.22, 11.82, 90.948944091797, "casino" }, -- Front exit
{2270.8994140625, 1638.19921875, 1007.9000244141, 1 ,0, 2196, 1651.67, 20.39, 4.3973388671875, "casino" }, -- Roof exit
{2215.5, 1574.8994140625, 999.5, 1 ,0, 2190.95, 1677.22, 11.82, 90.948944091797, "casino" } -- Cop exit
}

-- Tables and other variaibles
local theBankDoor = createObject( 11416, 479.29998779297, -2524.1999511719, 49.400001525879, 0, 0, 300 ) -- Create gate
local theCasinoDoor = createObject( 2957, 2149.8999023438, 1602.5, 1002.5999755859, 0, 0, 270 ) -- Create gate
local theDoorState = false -- (False = closed)
local currentRob = "casino"

local bankrobMarkers = {} -- The markers for entering
local bankRobbers = {} -- All the robbers
local lawPlayers = {} -- All the LAW
local deadLawPlayers = {} -- All dead law that can't rejoin

local bankCol = createColSphere( 596.67, -1283.18, 16.07, 200 ) -- Create a Col outside the bank
local casinoCol = createColSphere( 2227.66, 1695.86, 16.39, 200 ) -- Create a Col outside the bank
local bankBlip = createBlip ( 591.08, -1247.14, 18.07, 52 )
local casinoBlip = createBlip ( 2209.75, 1679.35, 16.39, 52 )

local timeBetweenRobs = 1800000 -- Time between the bankrobs (30 min)
local timeForCrimEnter = 300000 -- Time when crims are allowed to enter the bank (25 min)
local timeBankrobDuration = 420000 -- Total time of the bank (6 min)
local isBankRobStarted = false
local waitForReset = false

setElementDimension( theBankDoor, 1 )
setElementDimension( theCasinoDoor, 1 )
setElementInterior( theCasinoDoor, 1 )

-- When the bankrob resource gets started
addEventHandler ( 'onResourceStart', getResourceRootElement(getThisResource()),
function ()
	currentRob = "casino"
	timeBetweenRobs = 180000 -- 10 min
	timeForCrimEnter = 180000 -- Crim can enter direct
	bankrobStartTimer = setTimer( onDelayStartBankrob, timeBetweenRobs, 1 )
end
)

-- Restart the bank
function restartBankrob ()
	if ( currentRob == "casino" ) then currentRob = "bank" elseif ( currentRob == "bank" ) then currentRob = "casino" else currentRob = "casino" end
	if ( isTimer( bankrobStartTimer ) ) then killTimer( bankrobStartTimer ) end
	if ( isTimer( criminalsExpliotTimer ) ) then killTimer( criminalsExpliotTimer ) end
	bankRobbers = {}
	lawPlayers = {}
	deadLawPlayers = {}
	closeDoor()
	timeBetweenRobs = 1800000 -- Time between the bankrobs (30 min)
	timeForCrimEnter = 1500000
	isBankRobStarted = false
	waitForReset = false
	bankrobStartTimer = setTimer( onDelayStartBankrob, timeBetweenRobs, 1 )
	triggerClientEvent( "onResetBankrobStats", root )
end

-- Delay start
function onDelayStartBankrob ()
	if ( isTimer( bankrobDelayStartTimer ) ) then killTimer( bankrobDelayStartTimer ) end

	bankrobDelayStartTimer = setTimer( onStartBankRob, 10000, 1 )

	for k, thePlayer in ipairs ( bankRobbers ) do
		exports.DENdxmsg:createNewDxMessage( thePlayer, "The rob will start in 10 seconds, prepare yourself!", 225, 0, 0 )
	end
end

-- When the bankrob start or stops move the door
function onMoveBankrobDoor ()
	if not ( theDoorState ) then
		moveObject( theBankDoor, 12000, 479.29998779297, -2524.1999511719, 52.400001525879 )
		moveObject( theCasinoDoor, 12000, 2149.8999023438, 1602.5, 1005.5999755859 )
		theDoorState = true
	else
		moveObject( theBankDoor, 12000, 479.29998779297, -2524.1999511719, 49.400001525879 )
		moveObject( theCasinoDoor, 12000, 2149.8999023438, 1602.5, 1002.5999755859 )
		theDoorState = false
	end
end

function closeDoor()
	moveObject( theBankDoor, 12000, 479.29998779297, -2524.1999511719, 49.400001525879 )
	moveObject( theCasinoDoor, 12000, 2149.8999023438, 1602.5, 1002.5999755859 )
end

function openDoor()
	moveObject( theBankDoor, 12000, 479.29998779297, -2524.1999511719, 52.400001525879 )
	moveObject( theCasinoDoor, 12000, 2149.8999023438, 1602.5, 1005.5999755859 )
end
-- When an admin force to open the door
addCommandHandler( "forcedoor",
function ( theAdmin )
	if ( getPlayerTeam( theAdmin ) ) then
		if ( exports.CSGstaff:isPlayerStaff( theAdmin ) ) then
			onMoveBankrobDoor ()
		end
	end
end
)

-- When an admin does a force reset of the whole bank
addCommandHandler( "forcereset",
function ( theAdmin )
	if ( getPlayerTeam( theAdmin ) ) then
		if ( exports.CSGstaff:isPlayerStaff( theAdmin ) ) then
			restartBankrob ()
		end
	end
end
)

-- When the timer ends start den bankrob
function onStartBankRob ()
	if ( isTimer( bankrobDelayStartTimer ) ) then killTimer( bankrobDelayStartTimer ) end
	if ( #bankRobbers >= 5 ) then
		for k, thePlayer in ipairs ( bankRobbers ) do
			if ( isElement( thePlayer ) ) then
				exports.DENdxmsg:createNewDxMessage( thePlayer, "The bankrob started! Stay alive for 6 minutes and kill the cops!", 225, 0, 0 )
				setElementData( thePlayer, "wantedPoints", 60 )
				setPedArmor ( thePlayer, 50 )
				setElementData( thePlayer, "robberyFinished", false )


			end
		end
	for k,v in pairs(lawPlayers) do
		if isElement(v) then
			local hitElement=v
			exports.DENstats:setPlayerAccountData(hitElement,"brcrlaw",exports.DENstats:getPlayerAccountData(hitElement,"brcrlaw")+1)
		end
	end
		for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
			if ( exports.server:getPlayerAccountID(thePlayer) ) and ( getPlayerTeam( thePlayer ) ) then
				if ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Police" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Government Agency" ) then
					exports.DENdxmsg:createNewDxMessage( thePlayer, "The bankrob started! Go to the bank in LS and kill the robbers!", 225, 0, 0 )
				end
			end
		end

		isBankRobStarted = true
		openDoor()
		bankrobDelayStarted = false
		bankrobProgressTimer = setTimer( onStopBankRob, timeBankrobDuration, 1 )

	else
		if ( #bankRobbers < 1 ) then
			for k, thePlayer in ipairs ( bankRobbers ) do
				if ( isElement( thePlayer ) ) then
					exports.DENdxmsg:createNewDxMessage( thePlayer, "You need at least 5 robbers to rob the bank!", 225, 0, 0 )
				end
			end
			if ( isTimer( bankrobStartTimer ) ) then killTimer( bankrobStartTimer ) end
			bankrobStartTimer = setTimer( onStartBankRob, 30000, 1 )
		else
			if ( isTimer( bankrobStartTimer ) ) then killTimer( bankrobStartTimer ) end
			bankrobStartTimer = setTimer( onStartBankRob, 60000, 1 )
		end
	end
end

-- Stop the bankrob
function onStopBankRob ()
	if ( #bankRobbers > 0 ) then
		for k, thePlayer in ipairs ( bankRobbers ) do
			if ( exports.server:getPlayerAccountID(thePlayer) ) and ( getPlayerTeam( thePlayer ) ) then
				exports.DENdxmsg:createNewDxMessage( thePlayer, "The bank is robbed! Leave the bank area within 2 minutes for your money!", 225, 0, 0 )
				criminalsExpliotTimer = setTimer( onCriminalRefuseLeave, 120000, 1 )
				setElementData( thePlayer, "robberyFinished", true )
			end
		end
		bankrobRestartTimer = setTimer( checkPlayerInsideBank, 10000, 1 )
		isBankRobStarted = false
		waitForReset = true
	else
		restartBankrob ()
		isBankRobStarted = false
	end
	onCheckForForceStopBankrob ()
end

-- When a crim refuse to leave the bank
function onCriminalRefuseLeave ()
	if ( #bankRobbers > 0 ) then
		for k, thePlayer in ipairs ( bankRobbers ) do
			if ( isElement( thePlayer ) ) then
				exports.DENdxmsg:createNewDxMessage( thePlayer, "You didn't leave the bank within 2 minutes, next time better!", 0, 225, 0 )
				setElementData ( thePlayer, "isPlayerRobbing", false )
				setElementData( thePlayer, "robberyFinished", false )
				triggerClientEvent( thePlayer, "onToggleBankrobStats", thePlayer, false )
				triggerClientEvent( "onChangeCount", root, #lawPlayers, #bankRobbers )
				if getElementDimension(thePlayer) ~= 0 and getElementInterior(thePlayer) ~= 0 then
					killPed( thePlayer )
				end
				onCheckForForceStopBankrob ()
			end
		end
	else
		if ( isTimer( criminalsExpliotTimer ) ) then killTimer( criminalsExpliotTimer ) end
	end
	restartBankrob ()
end

-- On force stop the bankrobbery
function onForceStopTheBankRob ()
	if ( #bankRobbers < 1 ) then
		if ( isTimer( bankrobProgressTimer ) ) then killTimer( bankrobProgressTimer ) end
		for k, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Police" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Government Agency" ) then
				exports.DENdxmsg:createNewDxMessage( thePlayer, "The law forces have successfully stopped the robbery!", 0, 225, 0 )
			end
		end
		restartBankrob ()
	end
end

-- On force stop the bankrobbery
function onCheckForForceStopBankrob ()
	if ( #bankRobbers < 1 ) and ( waitForReset ) then
		if ( isTimer( bankrobProgressTimer ) ) then killTimer( bankrobProgressTimer ) end
		restartBankrob ()
	end
end

-- When all players leaved the bank restart the timer again, after timer end
function checkPlayerInsideBank ()
	if ( #bankRobbers < 1 ) then
		if ( isTimer( bankrobRestartTimer ) ) then killTimer( bankrobRestartTimer ) end
		restartBankrob ()
		isBankRobStarted = false
	else
		if ( isTimer( bankrobRestartTimer ) ) then killTimer( bankrobRestartTimer ) end
		bankrobRestartTimer = setTimer( checkPlayerInsideBank, 10000, 1 )
	end
end

-- If the crim can enter
function canCriminalEnterBankrob ( thePlayer )
	if ( isTimer(bankrobStartTimer) ) and not ( isBankRobStarted ) then
		local timeLeft, timeExLeft, timeExMax = getTimerDetails(bankrobStartTimer)
		if ( timeLeft < timeForCrimEnter ) then
			return true
		else
			return false
		end
	else
		if ( getElementData ( thePlayer, "isPlayerRobbing" ) ) then
			return true
		else
			return false
		end
	end
end

-- Check if the law player already died while in bank
function canLawOfficerEnter ( theOfficer )
	local state = true
	for k, theLawAccount in ipairs ( deadLawPlayers ) do
		if ( theLawAccount == exports.server:getPlayerAccountName( theOfficer ) ) then
			state = false
		end
	end
	return state
end

-- Warp the player into the bankrob it moet klopenn is niks aan veranderd
function warpPlayerIntoBankrob ( thePlayer, ID )
	if ( getPlayerTeam( thePlayer ) ) then
		if not ( isBankRobStarted ) and ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Police" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Government Agency" ) then
			setElementDimension( thePlayer, 1 )
			if ( bankrobMarkerCoords[ID][10] == "bank" ) then
				setElementPosition( thePlayer, 432.45, -2494.94, 30.81 )
				setPedRotation( thePlayer, 211.87730407715 )
			else
				setElementInterior( thePlayer, 1, 2220.24, 1581.91, 999.97 )
				setPedRotation( thePlayer, 357.97573852539 )
			end
			setElementData ( thePlayer, "isPlayerRobbing", true )
			triggerClientEvent( thePlayer, "onToggleBankrobStats", thePlayer, true )
			triggerClientEvent( "onChangeCount", root, #lawPlayers, #bankRobbers )
		else
			if ( bankrobMarkerCoords[ID][10] == "bank" ) then
				local x, y, z, rotation = bankrobMarkerCoords[ID][6], bankrobMarkerCoords[ID][7], bankrobMarkerCoords[ID][8], bankrobMarkerCoords[ID][9]
				setElementDimension( thePlayer, 1 )
				setElementPosition( thePlayer, x +1, y +1, z )
				setPedRotation( thePlayer, rotation )
				setElementData ( thePlayer, "isPlayerRobbing", true )
				triggerClientEvent( thePlayer, "onToggleBankrobStats", thePlayer, true )
				triggerClientEvent( "onChangeCount", root, #lawPlayers, #bankRobbers )
			else
				local x, y, z, rotation = bankrobMarkerCoords[ID][6], bankrobMarkerCoords[ID][7], bankrobMarkerCoords[ID][8], bankrobMarkerCoords[ID][9]
				setElementDimension( thePlayer, 1 )
				setElementInterior( thePlayer, 1, x +1, y +1, z )
				setPedRotation( thePlayer, rotation )
				setElementData ( thePlayer, "isPlayerRobbing", true )
				triggerClientEvent( thePlayer, "onToggleBankrobStats", thePlayer, true )
				triggerClientEvent( "onChangeCount", root, #lawPlayers, #bankRobbers )
			end
		end
	end
end

-- Warp the player out the bankrob
function warpPlayerOutBankrob ( thePlayer, ID )
	local x, y, z, rotation = bankrobMarkerCoords[ID][6], bankrobMarkerCoords[ID][7], bankrobMarkerCoords[ID][8], bankrobMarkerCoords[ID][9]
	setElementDimension( thePlayer, 0 )
	if ( getElementInterior( thePlayer ) == 0 ) then
		setElementPosition( thePlayer, x, y, z )
	else
		setElementInterior( thePlayer, 0, x, y, z )
	end

	setPedRotation( thePlayer, rotation )

	if ( getTeamName( getPlayerTeam( thePlayer ) ) == "Criminals" ) and ( getElementData ( thePlayer, "isPlayerRobbing" ) ) and ( isBankRobStarted ) then
		exports.DENdxmsg:createNewDxMessage( thePlayer, "You left the bank too early, you failed the robbery!", 224, 0, 0 )
		local hitElement=thePlayer
		exports.DENstats:setPlayerAccountData(hitElement,"brcrcrimfail",exports.DENstats:getPlayerAccountData(hitElement,"brcrcrimfail")+1)
	end

	setElementData ( thePlayer, "isPlayerRobbing", false )
	triggerClientEvent( thePlayer, "onToggleBankrobStats", thePlayer, false )

	if ( getTeamName( getPlayerTeam( thePlayer ) ) == "Criminals" ) then
		for k, theRobber in ipairs ( bankRobbers ) do
			if ( theRobber == thePlayer ) then
				table.remove( bankRobbers, k )
			end
		end
	elseif ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Police" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Government Agency" ) then
		for k, theCop in ipairs ( lawPlayers ) do
			if ( theCop == thePlayer ) then
				table.remove( lawPlayers, k )
			end
		end
	end

	triggerClientEvent( "onChangeCount", root, #lawPlayers, #bankRobbers )
	onCheckForForceStopBankrob ()
end

-- When the player hits the bankrob marker
function onBankrobMarkerHit ( hitElement, matchingDimension )
	if ( matchingDimension ) and ( bankrobMarkers[source] ) then
		local markerID = bankrobMarkers[source]
		if ( getElementType ( hitElement ) == "player" ) then
			if not ( getPedOccupiedVehicle ( hitElement ) ) then
				if ( getElementDimension( hitElement ) == 1 ) or ( getElementDimension( hitElement ) == 2 ) or ( getElementDimension( hitElement ) == 3 ) then
					if ( getTeamName( getPlayerTeam( hitElement ) ) == "Staff" ) then
						warpPlayerOutBankrob ( hitElement, markerID )
					elseif ( getTeamName( getPlayerTeam( hitElement ) ) == "Criminals" ) then
						warpPlayerOutBankrob ( hitElement, markerID )
					elseif ( getTeamName( getPlayerTeam( hitElement ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( hitElement ) ) == "Police" ) or ( getTeamName( getPlayerTeam( hitElement ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( hitElement ) ) == "Government Agency" ) then
						warpPlayerOutBankrob ( hitElement, markerID )
					elseif ( getTeamName( getPlayerTeam( hitElement ) ) == "Paramedics" ) then
						warpPlayerOutBankrob ( hitElement, markerID )
					end
				else
					if ( getTeamName( getPlayerTeam( hitElement ) ) == "Staff" ) then
						warpPlayerIntoBankrob( hitElement, markerID )
					elseif ( getTeamName( getPlayerTeam( hitElement ) ) == "Criminals" ) then
						if ( isTimer( bankrobDelayStartTimer ) ) then
							exports.DENdxmsg:createNewDxMessage( hitElement, "Your not allowed to enter at this time!", 225, 0, 0 )
						else
							if ( canCriminalEnterBankrob( hitElement ) ) then
								if ( currentRob == bankrobMarkerCoords[markerID][10] ) then
									warpPlayerIntoBankrob ( hitElement, markerID )
									table.insert( bankRobbers, hitElement )
								else
									exports.DENdxmsg:createNewDxMessage( hitElement, "There is no robbery here anytime soon!", 225, 0, 0 )
								end
							else
								exports.DENdxmsg:createNewDxMessage( hitElement, "Your not allowed to enter at this time!", 225, 0, 0 )
							end
						end
					elseif ( getTeamName( getPlayerTeam( hitElement ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( hitElement ) ) == "Police" ) or ( getTeamName( getPlayerTeam( hitElement ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( hitElement ) ) == "Government Agency" ) then
						if not ( isTimer( bankrobDelayStartTimer ) ) then
							if ( canLawOfficerEnter ( hitElement ) ) then
								if ( currentRob == bankrobMarkerCoords[markerID][10] ) then
									warpPlayerIntoBankrob ( hitElement, markerID )
									table.insert( lawPlayers, hitElement )
									exports.DENstats:setPlayerAccountData(hitElement,"brcrlaw",exports.DENstats:getPlayerAccountData(hitElement,"brcrlaw")+1)
								else
									exports.DENdxmsg:createNewDxMessage( hitElement, "There is no robbery here anytime soon!", 225, 0, 0 )
								end
							else
								exports.DENdxmsg:createNewDxMessage( hitElement, "Law can only enter the bank once in a robbery!", 225, 0, 0 )
							end
						else
							exports.DENdxmsg:createNewDxMessage( hitElement, "Law can only enter before or when the bankrob is started!", 225, 0, 0 )
						end
					elseif ( getTeamName( getPlayerTeam( hitElement ) ) == "Paramedics" ) then
						if ( canCriminalEnterBankrob( hitElement ) ) or not ( isTimer( bankrobDelayStartTimer ) ) then
							if ( currentRob == bankrobMarkerCoords[markerID][10] ) then
								warpPlayerIntoBankrob ( hitElement, markerID )
							else
								exports.DENdxmsg:createNewDxMessage( hitElement, "There is no robbery here anytime soon!", 225, 0, 0 )
							end
						else
							exports.DENdxmsg:createNewDxMessage( hitElement, "Your not allowed to enter at this time!", 225, 0, 0 )
						end
					else
						exports.DENdxmsg:createNewDxMessage( hitElement, "Civilian workers can not participate in the bankrobbery!", 225, 0, 0 )
					end
				end
			end
		end
	end
end

-- Create the bankmarker once the resource is started
for i=1,#bankrobMarkerCoords do
	if ( i == 1 ) or ( i == 2 ) or ( i == 3 ) or ( i == 4 ) or ( i == 10 ) or ( i == 11 ) then
		local x, y, z, int = bankrobMarkerCoords[i][1], bankrobMarkerCoords[i][2], bankrobMarkerCoords[i][3], bankrobMarkerCoords[i][4]
		local theMarker = createMarker(x, y, z +1, "arrow", 1.5, 255, 128, 0 )
		setElementInterior(theMarker, 0, x, y, z)
		setElementDimension(theMarker, 0)
		bankrobMarkers[theMarker] = i
		addEventHandler("onMarkerHit", theMarker, onBankrobMarkerHit)
	else
		for k=1,3 do
			local x, y, z, int = bankrobMarkerCoords[i][1], bankrobMarkerCoords[i][2], bankrobMarkerCoords[i][3], bankrobMarkerCoords[i][4]
			local theMarker = createMarker(x, y, z +1, "arrow", 1.5, 255, 128, 0 )
			setElementInterior(theMarker, int, x, y, z)
			setElementDimension(theMarker, k)
			bankrobMarkers[theMarker] = i
			addEventHandler("onMarkerHit", theMarker, onBankrobMarkerHit)
		end
	end
end

-- When the robber leaves the bankrob area outside the bank
function onRobberyColLeave ( leaveElement, matchingDimension )
	if ( matchingDimension ) then
		if ( getElementType(leaveElement ) == "vehicle" ) then
			local occupants = getVehicleOccupants( leaveElement )
			local seats = getVehicleMaxPassengers( leaveElement )
			local wantedInside = false
			for seat = 0,seats do
				local occupant = occupants[seat]
				if (( occupant ) and ( getElementType(occupant)=="player" )) then
					if ( getTeamName( getPlayerTeam( occupant ) ) == "Criminals" ) then
						if ( getElementData ( occupant, "robberyFinished" ) ) then
							if not ( getElementData ( occupant, "isPlayerArrested" ) ) then
								givePlayerMoney( occupant, 15000 )
								exports.DENdxmsg:createNewDxMessage( occupant, "You escaped from the bank area! Here is you reward: $15,000 and 5 Score!", 0, 225, 0 )
								exports.CSGscore:givePlayerScore(occupant,5)
								setElementData ( occupant, "robberyFinished", false )
								local hitElement=occupant
								exports.DENstats:setPlayerAccountData(hitElement,"brcrcrimsuccess",exports.DENstats:getPlayerAccountData(hitElement,"brcrcrimsuccess")+1)
							end
						end
					end
				end
			end
		elseif ( getElementType(leaveElement ) == "player" ) then
			if ( getTeamName( getPlayerTeam( leaveElement ) ) == "Criminals" ) then
				if ( getElementData ( leaveElement, "robberyFinished" ) ) then
					if not ( getElementData ( leaveElement, "isPlayerArrested" ) ) then
						givePlayerMoney( leaveElement, 15000 )
								exports.DENdxmsg:createNewDxMessage( leaveElement, "You escaped from the bank area! Here is you reward: $15,000 and 5 Score!", 0, 225, 0 )
								exports.CSGscore:givePlayerScore(leaveElement,5)
						setElementData ( leaveElement, "robberyFinished", false )
						local hitElement=leaveElement
						exports.DENstats:setPlayerAccountData(hitElement,"brcrcrimsuccess",exports.DENstats:getPlayerAccountData(hitElement,"brcrcrimsuccess")+1)

					end
				end
			end
		end
	end
end
addEventHandler( "onColShapeLeave", bankCol, onRobberyColLeave )
addEventHandler( "onColShapeLeave", casinoCol, onRobberyColLeave )

-- When a cop wants to arrest a player while robbing wat nog meer alleen de markers toch, en de int zelf pff we moeten een bankrob ik ga ff ig kijken of die mappers er zijn
addEvent ( "onPlayerNightstickHit" )
addEventHandler ( "onPlayerNightstickHit", root,
function ( theCop )
	if ( getPlayerTeam( source ) ) then
		if ( getElementData ( source, "isPlayerRobbing" ) ) or ( getElementData ( source, "robberyFinished" ) ) then
			if ( getTeamName( getPlayerTeam( source ) ) == "Criminals" ) then
				exports.DENdxmsg:createNewDxMessage( theCop, "Don't arrest robbers but kill them!", 225, 0, 0 )
				cancelEvent()
			end
		end
	end
end
)

-- When a player in the rob dies
addEventHandler( "onPlayerWasted", root,
function ( ammo, theKiller, weapon, bodypart )
	if ( getElementData ( source, "isPlayerRobbing" ) ) or ( getElementData ( source, "robberyFinished" ) ) and ( getPlayerTeam( source ) ) then
		if ( theKiller ) and ( getPlayerTeam( theKiller ) ) then
			if ( getTeamName( getPlayerTeam( theKiller ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( theKiller ) ) == "Police" ) or ( getTeamName( getPlayerTeam( theKiller ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( theKiller ) ) == "Government Agency" ) and ( getTeamName( getPlayerTeam( source ) ) == "Criminals" ) then
				givePlayerMoney( theKiller, 5000 )
				exports.DENdxmsg:createNewDxMessage( theKiller, "You killed a robber! Here is a $5000 reward! + 1 Score", 0, 255, 0 )
				setElementData ( source, "robberyFinished", false )
				setElementData ( source, "isPlayerRobbing", false )
				exports.CSGscore:givePlayerScore(theKiller,1)
				triggerClientEvent( source, "onToggleBankrobStats", source, false )
				for k, thePlayer in ipairs ( bankRobbers ) do
					if ( thePlayer == source ) then
						table.remove( bankRobbers, k )
					end
				end
				local hitElement=source
				exports.DENstats:setPlayerAccountData(hitElement,"brcrcrimfail",exports.DENstats:getPlayerAccountData(hitElement,"brcrcrimfail")+1)
				onForceStopTheBankRob ()
			elseif ( getTeamName( getPlayerTeam( theKiller ) ) == "Criminals" ) and  ( getTeamName( getPlayerTeam( source ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( source ) ) == "Police" ) or ( getTeamName( getPlayerTeam( source ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( source ) ) == "Government Agency" ) then
				givePlayerMoney( theKiller, 3000 )
				setElementData ( source, "isPlayerRobbing", false )
				triggerClientEvent( source, "onToggleBankrobStats", source, false )
				exports.DENdxmsg:createNewDxMessage( theKiller, "You killed a cop! Here is a $3000 reward! + 1 Score", 0, 255, 0 )
				exports.CSGscore:givePlayerScore(theKiller,1)
				table.insert( deadLawPlayers, exports.server:getPlayerAccountName(source) )
			end
			triggerClientEvent( "onChangeCount", root, #lawPlayers, #bankRobbers )
		else
			if ( getElementData ( source, "robberyFinished" ) ) or  ( getElementData ( source, "isPlayerRobbing" ) ) then
				setElementData ( source, "robberyFinished", false )
				setElementData ( source, "isPlayerRobbing", false )
				triggerClientEvent( source, "onToggleBankrobStats", source, false )
				if ( bankRobbers ) and ( #bankRobbers > 0 ) then
					for k, thePlayer in ipairs ( bankRobbers ) do
						if ( thePlayer == source ) then
							table.remove( bankRobbers, k )
						end
					end
				end
				triggerClientEvent( "onChangeCount", root, #lawPlayers, #bankRobbers )
			end
		end
	end
end
)

-- When a player quits inside the bank
addEventHandler( "onPlayerQuit", root,
function ()
	if ( getPlayerTeam( source ) ) then
		if ( getElementData ( source, "isPlayerRobbing" ) ) and ( getPlayerTeam( source ) ) then
			if ( getPlayerTeam( source ) ) then
				if ( getTeamName( getPlayerTeam( source ) ) == "Criminals" ) then
					onForceStopTheBankRob ()
				end
			end

			if ( getTeamName( getPlayerTeam( thePlayer ) ) == "Criminals" ) then
				for k, theRobber in ipairs ( bankRobbers ) do
					if ( theRobber == thePlayer ) then
						table.remove( bankRobbers, k )
					end
				end
				triggerClientEvent( "onChangeCount", root, #lawPlayers, #bankRobbers )
			elseif ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Police" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Government Agency" ) then
				for k, theCop in ipairs ( lawPlayers ) do
					if ( theCop == thePlayer ) then
						table.remove( lawPlayers, k )
					end
				end
				triggerClientEvent( "onChangeCount", root, #lawPlayers, #bankRobbers )
			end
		end
	end
end
)

-- When player does /banktime
function onCalculateBanktime ( theTime )
	if ( theTime >= 60000 ) then
		local plural = ""
		if ( math.floor((theTime/1000)/60) >= 2 ) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)/60) .. " minute" .. plural)
	else
		local plural = ""
		if ( math.floor((theTime/1000)) >= 2 ) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)) .. " second" .. plural)
	end
end


showTime = function( thePlayer )
	local robType = "(LS Bankrob)"
	if ( currentRob == "bank") then robType = "(LS Bankrob)" elseif ( currentRob == "casino") then robType = "(LV Caligula's Casino)" end

	if ( isTimer(bankrobStartTimer) ) then
		local timeLeft, timeExLeft, timeExMax = getTimerDetails(bankrobStartTimer)
		exports.DENdxmsg:createNewDxMessage( thePlayer, "Time left until next robbery: " .. onCalculateBanktime ( math.floor( timeLeft ) ) .. " "..robType, 225, 0, 0 )
	elseif ( isTimer(bankrobProgressTimer) ) then
		local timeLeft, timeExLeft, timeExMax = getTimerDetails( bankrobProgressTimer )
		exports.DENdxmsg:createNewDxMessage( thePlayer, "The safe will be cracked in " .. onCalculateBanktime( math.floor( timeLeft ) ), 235, 0, 0 )
	else
		exports.DENdxmsg:createNewDxMessage( thePlayer, "The bank is already able to be robbed! "..robType, 0, 255, 0 )
	end
end
addCommandHandler ( "banktime",showTime)
addCommandHandler("casinotime",showTime)
