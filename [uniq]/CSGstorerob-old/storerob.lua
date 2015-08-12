local markers = {
[1] = {9, 0, 363.25, -12.35, 1000.851, "Clucking-Bell in Bone County (Bone County)", 18.3, 9.7},
[2] = {9, 1, 363.25, -12.35, 1000.851, "Clucking-Bell in Tierra Robada (Tierra Robada)", 18.3, 9.7}, 
[3] = {9, 2, 363.25, -12.35, 1000.851, "Clucking-Bell in Angel Pine (Whetstone)", 18.3, 9.7},
[4] = {9, 3, 363.25, -12.35, 1000.851, "Clucking-Bell in East Los Santos (Los Santos)", 18.3, 9.7},
[5] = {9, 4, 363.25, -12.35, 1000.851, "Clucking-Bell in Willowfield (Los Santos)", 18.3, 9.7},
[6] = {9, 5, 363.25, -12.35, 1000.851, "Clucking-Bell in Market (Los Santos)", 18.3, 9.7},
[7] = {9, 6, 363.25, -12.35, 1000.851, "Clucking-Bell in Downtown (San Fierro)", 18.3, 9.7},
[8] = {9, 7, 363.25, -12.35, 1000.851, "Clucking-Bell in Ocean Flats (San Fierro)", 18.3, 9.7},
[9] = {9, 8, 363.25, -12.35, 1000.851, "Clucking-Bell in Pilgrim (Las Venturas)", 18.3, 9.7},
[10] = {9, 9, 363.25, -12.35, 1000.851, "Clucking-Bell in Old Venturas Strip (Las Venturas)", 18.3, 9.7},
[11] = {9, 10, 363.25, -12.35, 1000.851, "Clucking-Bell in Creek (Las Venturas)", 18.3, 9.7},
[12] = {9, 11, 363.25, -12.35, 1000.851, "Clucking-Bell in The Emerald Isle (Las Venturas)", 18.3, 9.7},
[13] = {5, 1, 366.54, -134.06, 1000.492, "The Well Stacked Pizza Co. in Palomino Creek (Red County)", 14, 21.5},
[14] = {5, 3, 366.54, -134.06, 1000.492, "The Well Stacked Pizza Co. in Montgomery (Red County)", 14, 21.5},
[15] = {5, 4, 366.54, -134.06, 1000.492, "The Well Stacked Pizza Co. in Blueberry (Red County)", 14, 21.5},
[16] = {5, 5, 366.54, -134.06, 1000.492, "The Well Stacked Pizza Co. in Idlewood (Los Santos)", 14, 21.5},
[17] = {5, 6, 366.54, -134.06, 1000.492, "The Well Stacked Pizza Co. in Financial (San Fierro)", 14, 21.5},
[18] = {5, 7, 366.54, -134.06, 1000.492, "The Well Stacked Pizza Co. in Esplanade North (San Fierro)", 14, 21.5},
[19] = {5, 8, 366.54, -134.06, 1000.492, "The Well Stacked Pizza Co. in Starfish Casino (Las Venturas)", 14, 21.5},
[20] = {5, 9, 366.54, -134.06, 1000.492, "The Well Stacked Pizza Co. in Creek (Las Venturas)", 14, 21.5},
[21] = {5, 10, 366.54, -134.06, 1000.492, "The Well Stacked Pizza Co. in Roca Escalante (Las Venturas)", 14, 21.5},
[22] = {5, 11, 366.54, -134.06, 1000.492, "The Well Stacked Pizza Co. in The Emerald Isle (Las Venturas)", 14, 21.5},
[23] = {10, 0, 360.31, -78.98, 1000.507, "Burger Shot in Marina (Los Santos)", 23, 23},
[24] = {10, 1, 360.31, -78.98, 1000.507, "Burger Shot in Temple (Los Santos)", 23, 23},
[25] = {10, 2, 360.31, -78.98, 1000.507, "Burger Shot in Downtown (San Fierro)", 23, 23},
[26] = {10, 3, 360.31, -78.98, 1000.507, "Burger Shot in Garcia (San Fierro)", 23, 23},
[27] = {10, 4, 360.31, -78.98, 1000.507, "Burger Shot in Juniper Hollow (San Fierro)", 23, 23},
[28] = {10, 5, 360.31, -78.98, 1000.507, "Burger Shot in Old Venturas Strip (Las Venturas)", 23, 23},
[29] = {10, 6, 360.31, -78.98, 1000.507, "Burger Shot in Old Venturas Strip (Las Venturas)", 23, 23},
[30] = {10, 7, 360.31, -78.98, 1000.507, "Burger Shot in Spinybed (Las Venturas)", 23, 23}, 
[31] = {10, 8, 360.31, -78.98, 1000.507, "Burger Shot in Redsands East (Las Venturas)", 23, 23},
[32] = {10, 9, 360.31, -78.98, 1000.507, "Burger Shot in Whitewood Estates (Las Venturas)", 23, 23},
[33] = {15, 5, 199.52, -113.03, 1004.140, "Binco in Ganton (Los Santos)", 19.5, 18.5},
[34] = {15, 6, 199.52, -113.03, 1004.140, "Binco in Juniper Hill (San Fierro)", 19.5, 18.5},
[35] = {15, 7, 199.52, -113.03, 1004.140, "Binco in Las Venturas Airport (Las Venturas)", 19.5, 18.5},
[36] = {15, 8,  199.52, -113.03, 1004.140, "Binco in The Emerald Isle (Las Venturas)", 19.5, 18.5},
[37] = {5, 9, 198.7, -13.83, 1000.21, "Victim in Rodeo (Los Santos)", 29.3, 12},
[38] = {5, 10, 198.7, -13.83, 1000.21, "Victim in Downtown (San Fierro)", 29.3, 12},
[39] = {5, 11, 198.7, -13.83, 1000.21, "Victim in Creek (Las Venturas)", 29.3, 12},
[40] = {18, 1, 144.41, -97.24, 1000.804, "ZIP in Downtown Los Santos (Los Santos)", 39, 28},
[41] = {18, 2, 144.41, -97.24, 1000.804, "ZIP in Downtown (San Fierro)", 39, 28},
[42] = {18, 3, 144.41, -97.24, 1000.804, "ZIP in Starfish Casino (Las Venturas)", 39, 28},
[43] = {18, 4, 144.41, -97.24, 1000.804, "ZIP in The Emerald Isle (Las Venturas)", 39, 28},
[44] = {1, 1, 196.05, -51.08, 1000.929, "Sub Urban in Hashbury (San Fierro)", 27, 19},
[45] = {1, 2, 196.05, -51.08, 1000.929, "Sub Urban in Creek (Las Venturas)", 27, 19},
[46] = {18, 0, -40.24, -93.91, 1002.54, "24/7 in Idlewood (Los Santos)", 27, 20},
[47] = {18, 1, -40.24, -93.91, 1002.54, "24/7 in Mulholland (Los Santos)", 27, 20},
[48] = {18, 2, -40.24, -93.91, 1002.54, "24/7 in Starfish Casino (Las Venturas)", 27, 20},
[49] = {18, 3, -40.24, -93.91, 1002.54, "24/7 in Creek (Las Venturas)", 27, 20},
[50] = {18, 99, -40.24, -93.91, 1002.54, "24/7 in Juniper Hill (San Fierro)", 27, 20},
[51] = {4, 0, -37.86, -33.21, 1001.55, "24/7 in Mulholland (Los Santos)", 13, 33}, 
[52] = {6, 0, -37.4, -58.53, 1002.54, "24/7 inFort Carson (Bone County)", 20.5, 10.5},
[53] = {6, 1, -37.4, -58.53, 1002.54, "24/7 in Whetstone (Whetstone)", 20.5, 10.5},
[54] = {6, 2, -37.4, -58.53, 1002.54, "24/7 in Commerce (Los Santos)", 20.5, 10.5},
[55] = {6, 5, -37.4, -58.53, 1002.54, "24/7 in Old Venturas Strip (Las Venturas)", 20.5, 10.5},
[56] = {6, 5, -37.4, -58.53, 1002.54, "24/7 in Starfish Casino (Las Venturas)", 20.5, 10.5},
[57] = {6, 6, -37.4, -58.53, 1002.54, "24/7 in The Emerald Isle (Las Venturas)", 20.5, 10.5},
[58] = {6, 7, -37.4, -58.53, 1002.54, "24/7 in Redsands East (Las Venturas)", 20.5, 10.5},
[59] = {14, 12, 195.89, -170.01, 999.52, "DS in Rodeo (Los Santos)", 23, 16},
[60] = {3, 14, 196.11, -140.35, 1002.06, "Train Hard in Creek (Las Venturas)", 22, 15}
}

local theMarkers = {}
crimtimer = {}
escapeTimer = {}

function markerHit ( hitElement, matchingDimension )
local markerID = getElementData ( source, "markerID" )
local markerInt = getElementInterior ( hitElement )
local playerInt = getElementInterior ( source )
	if ( markerID ) and ( hitElement == localPlayer ) and ( matchingDimension ) then
		if (theMarkers[tonumber(markerID)]) then
			theMarker = source
			if (getElementType(hitElement) == "player" ) then
				if not (getTeamName(getPlayerTeam(hitElement)) == "Staff") then
					if ( markerInt == playerInt ) then
						exports.DENdxmsg:createNewDxMessage("Use /robstore to rob this store!", 255, 0, 0)
					end
				end
			end
		end
	end
end 

function attemptToStartRobbery ( )
	if not (getTeamName(getPlayerTeam(localPlayer)) == "Staff") then
		if ( isElement( theMarker ) ) then
			triggerServerEvent( "canPlayerRobStore", localPlayer, getElementData( theMarker, "markerID" ) ) 
		end
	end
end
addCommandHandler ( "robstore", attemptToStartRobbery )

addEvent( "onStartRobbery", true )
function onStartRobbery ()
	if not (getTeamName(getPlayerTeam(localPlayer)) == "Staff") then
		if ( isElement (theMarker)) then
			local x, y, z = getElementPosition( localPlayer )
			if (z > 990 and z < 1020) then
				local markerID = getElementData( theMarker, "markerID" )
				local storeName = markers[markerID][6]
				exports.DENdxmsg:createNewDxMessage("Robbery started! Stay alive for 3 minutes inside the shop, cops are warned!", 255, 0, 0)
				triggerServerEvent ( "lawMessage", localPlayer, storeName )
				triggerServerEvent ( "onPlayerRobbedStore", localPlayer, markerID )
				local getWantedPoints = getElementData(localPlayer, "wantedPoints")
				setElementData(source, "wantedPoints", getWantedPoints +40)
				crimtimer[localPlayer] = setTimer  ( succes, 180000, 1 ) -- 3 min
			end
		end
	end
end
addEventHandler ( "onStartRobbery", root, onStartRobbery )

function drawText ()
	if isTimer(crimtimer[localPlayer]) then
		local sW, sH = guiGetScreenSize ()
		dxDrawText ( "Time left:".. string.format("%.0f", tostring((getTimerDetails(crimtimer[localPlayer])/1000))) .. " seconds", 0, 0, sW, sH, tocolor(238, 233, 233), 1, "bankgothic", "right", "bottom" )
	end
end
addEventHandler ( "onClientRender", root, drawText )

function markerLeave (leaveElement)
	if ( leaveElement == localPlayer ) then
		if isTimer(crimtimer[localPlayer]) then
			killTimer (crimtimer[localPlayer])
			exports.DENdxmsg:createNewDxMessage("You have failed the robbery!", 255, 0, 0)
			theMarker = nil
		end
	end
end

for ID in pairs(markers) do
	theMarkers[ID] = createColCuboid ( markers[ID][3], markers[ID][4], markers[ID][5], markers[ID][7], markers[ID][8], 7.0 )
	setElementInterior ( theMarkers[ID], markers[ID][1], markers[ID][3], markers[ID][4], markers[ID][5] )
	setElementDimension ( theMarkers[ID], markers[ID][2] )
	setElementData ( theMarkers[ID], "markerID", ID )
	addEventHandler ( "onClientColShapeHit", theMarkers[ID], markerHit )
	addEventHandler ( "onClientColShapeLeave", theMarkers[ID], markerLeave )
end

function succes ()
	if isElementWithinColShape(localPlayer, theMarker) then
		escapeTimer[localPlayer] = setTimer ( payout, 300000, 1 ) -- 5 min
		exports.DENdxmsg:createNewDxMessage("Leave the store and survive 5 minutes without dieing/getting arrested to get the money!", 255, 0, 0) else
		exports.DENdxmsg:createNewDxMessage("You have failed the robbery!", 255, 0, 0)
	end
end

function drawText ()
	if isTimer(escapeTimer[localPlayer]) then
		local sW, sH = guiGetScreenSize ()
		dxDrawText ( "Time left before safety: ".. string.format("%.0f", tostring((getTimerDetails(escapeTimer[localPlayer])/1000))) .. " seconds", 0, 0, sW, sH, tocolor(238, 233, 233), 1, "bankgothic", "right", "bottom" )
	end
end
addEventHandler ( "onClientRender", root, drawText )

function rundead ()
	if ( source == localPlayer ) then 
		if isTimer(escapeTimer[localPlayer]) then
			exports.DENdxmsg:createNewDxMessage("You have failed to escape from the robbery!", 255, 0, 0)
			killTimer(escapeTimer[localPlayer])
		elseif isTimer(crimtimer[localPlayer])  then
			exports.DENdxmsg:createNewDxMessage("You have failed the robbery!", 255, 0, 0)
			killTimer (crimtimer[localPlayer])
		end
	end
end
addEventHandler ( "onClientPlayerWasted", localPlayer, rundead )

addEvent ( "onPlayerArrest", true )
function onPlayerGetArrest ()
	if ( source == localPlayer ) then
		if ( isTimer(escapeTimer[localPlayer]) == true ) then
			exports.DENdxmsg:createNewDxMessage("You have failed to escape from the robbery!", 255, 0, 0)
			killTimer(escapeTimer[localPlayer])
		elseif ( isTimer(crimtimer[localPlayer]) == true ) then
			exports.DENdxmsg:createNewDxMessage("You have failed the robbery!", 255, 0, 0)
			killTimer (crimtimer[localPlayer])
		end
	end
end
addEventHandler ( "onPlayerArrest", root, onPlayerGetArrest )

function payout ()
	if isElementWithinColShape(localPlayer, theMarker) then
		exports.DENdxmsg:createNewDxMessage("You didn't leave the store in time, robbery failed!", 255, 0, 0) else
		triggerServerEvent ( "storeRobPayout", localPlayer )
		exports.DENdxmsg:createNewDxMessage("You have succesfully robbed the store, here's your money!", 255, 0, 0)
	end
end