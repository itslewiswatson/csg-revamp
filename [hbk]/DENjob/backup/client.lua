local policeDisc = "Here you can join the police service.\n\nPolice officer job is all about arresting wanted players. You can pick one of 8 various skins and 4 different types of police vehicles. When you get enough arrests you will be able to get promoted and become one of the special ranks in police job. Also good progress as a police officer can lead to joining one of the special government services. \n\nJob perk: To arrest players simply hit them with a nighstick. You can also use tazer to stun them. The player is wanted if he has numbers (1-6) behind his name.\n"
local hookerDisc = "Here you can work as a hooker.\n\nAs a hooker you can offer your services to other players. You are able to pick 1 of 9 different skins. You can find your customer by standing around a corner or even advertising your services. When customer pick one of your services you will receive cash and he will gain HP.\n\nJob perk: To offer your services to a customers you have to enter their car as a passanger."
local medicDisc = "As a paramedic your job is to heal players with you spraycan.\nYou can heal player by simply spray them, with the spraycan, every time you heal somebody you earn money for it.\n\nParamedics get acces to the Ambulance car. For a emergency accident you can use the medic chopper."
local mechDisc = "Here you can work as a mechanic.\n\nAs a mechanic your job is to repair vehicles owned by other players. You can pick 1 of 3 various skins and 1 of 4 vehicles for easier transportation. You are able to use Towtruck to tow other players vehicles if they run out of gas or bounce off the road.\n\nJob perk: To repair a vehicle press right mouse button near it's doors. Use num_2 and num_8 keys to adjust Towtruck's cable height."
local trafficDisc = "As a Traffic Officer you can do everything a regular Police Officer can.\nThe difference is that you may use your camera (given to you after taking the Job) to photograph drivers who are speeding.\n\nIf you manage to photograph a speeding driver, you will earn a 200$ bonus.\n\nNote that you can only photograph the same driver every 40 seconds (to prevent abuse)."
local swatDisc = "The SWAT (Special Weapons and Tactics) Team focuses on quick, effective raids against its targets.\nOur members are trained to be the best at what they do, in every aspect, always using teamwork to achieve their objectives. Our main objective is to bring order to San Andreas, in cooperation with our Law counterparts.\n\nIf you wish to join an elite Law group and you are interested in joining SWAT, apply at the SWAT Team board in the CSG forum.\n\nRequirements:\n-Good English skills;\n-50 hours of gameplay;\n-150 arrests;\n-5000 arrest points;\n-Mature behavior;\n\nWe are also recruiting full-time Paramedics to help the Tactical Teams. Paramedics will get an invite to the group, meaning that they will be able to open the base’s gate at any time.\nYou can apply for the SWAT Tactical Paramedics in our board. Other than good English, the requirements are minimal.\nMedics who use the SWAT skin/job without permission from a CPT+ will be kicked from SWAT without notice."

local theJobsTable = {
	-- { Occupation, Team, MarkerX, MarkerY, MarkerZ, markerR, markerG, markerB, Weapon, {skins}, wantedLevel, Group, Information, pedRotation }
	-- SWAT
	{ "SWAT Team", "SWAT", 1288.86, -1661.72, 13.54, 39, 64, 139, 3, {285}, 10, "SWAT Team", swatDisc, 270 },
	-- MF
	{ "Military Forces", "Military Forces", 88.73, 1914.82, 17.86, 107, 142, 35, 3, {97, 287}, 10, "Military Forces", "Empty", 97.145355224609 },
	-- Police
	{ "Police Officer", "Police", 2348.09, 2455.07, 14.97, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 85.274444580078 },
	{ "Police Officer", "Police", -215.8, 973.69, 19.32, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 271.76470947266 },
	{ "Police Officer", "Police", -1395.03, 2646.44, 55.85, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 136.15838623047 },
	{ "Police Officer", "Police", -2161.64, -2385.5, 30.62, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 137.83932495117 },
	{ "Police Officer", "Police", 1574.700, -1634.300, 13.600, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 87.235534667969 },
	{ "Police Officer", "Police", 630.84, -569.06, 16.33, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 271.76470947266 },
	{ "Police Officer", "Police", -1622.52, 686.91, 7.18, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 167.47540283203 },
	-- Traffic police
	{ "Traffic Officer", "Police", 1601.24, -1634.94, 13.71, 67, 156, 252, 3, {284}, 10, nil, trafficDisc, 3.403076171875 },
	{ "Traffic Officer", "Police", 619.01, -584.65, 17.22, 67, 156, 252, 3, {284}, 10, nil, trafficDisc, 175.54498291016 },
	{ "Traffic Officer", "Police", -1619.49, 692.34, 7.18, 67, 156, 252, 3, {284}, 10, nil, trafficDisc, 90.580902099609 },
	{ "Traffic Officer", "Police", -226.3, 985.22, 19.59, 67, 156, 252, 3, {284}, 10, nil, trafficDisc, 85.884185791016 },
	-- Pilot
	{ "Pilot", "Civilian Workers", 1895.26, -2246.88, 13.54, 225, 225, 0, 0, {61}, 25, nil, "Empty", 211.89929199219 },
	{ "Pilot", "Civilian Workers", 1712.99, 1615.86, 10.15, 225, 225, 0, 0, {61}, 25, nil, "Empty", 247.35270690918 },
	{ "Pilot", "Civilian Workers", -1542.99, -437.79, 6, 225, 225, 0, 0, {61}, 25, nil, "Empty", 130.25314331055 },
	-- Paramedic
	{ "Paramedic", "Paramedics", 1178.61, -1319.42, 14.12, 0, 225, 225, 41, {274, 275, 276}, 10, nil, medicDisc, 278.97186279297 },
	{ "Paramedic", "Paramedics", 1253.16, 328.22, 19.75, 0, 225, 225, 41, {274, 275, 276}, 10, nil, medicDisc, 335.29962158203 },
	{ "Paramedic", "Paramedics", -2641.51, 636.4, 14.45, 0, 225, 225, 41, {274, 275, 276}, 10, nil, medicDisc, 161.91076660156 },
	{ "Paramedic", "Paramedics", -323.25, 1055.37, 19.74, 0, 225, 225, 41, {274, 275, 276}, 10, nil, medicDisc, 313.19479370117 },
	{ "Paramedic", "Paramedics", -1510.04, 2520.85, 55.87, 0, 225, 225, 41, {274, 275, 276}, 10, nil, medicDisc, 358.06912231445 },
	{ "Paramedic", "Paramedics", 1600.54, 1818.96, 10.82, 0, 225, 225, 41, {274, 275, 276}, 10, nil, medicDisc, 359.32159423828 },
	{ "Paramedic", "Paramedics", 2036.27, -1404.07, 17.26, 0, 225, 225, 41, {274, 275, 276}, 10, nil, medicDisc, 146.98010253906 },
	{ "Paramedic", "Paramedics", -2204.52, -2312.74, 30.61, 0, 225, 225, 41, {274, 275, 276}, 10, nil, medicDisc, 271.76470947266 },
	-- Hooker
	{ "Prostitute", "Civilian Workers", 2425.92, -1222.26, 25.39, 205, 104, 137, 0, {152, 243, 244, 245, 256, 257, 63, 64, 237}, 10, nil, hookerDisc, 159.32891845703 },
	{ "Prostitute", "Civilian Workers", -2628.85, 1403.44, 7.09, 205, 104, 137, 0, {152, 243, 244, 245, 256, 257, 63, 64, 237}, 10, nil, hookerDisc, 250.25863647461 },
	{ "Prostitute", "Civilian Workers", 788.28, -1550.94, 13.56, 205, 104, 137, 0, {152, 243, 244, 245, 256, 257, 63, 64, 237}, 10, nil, hookerDisc, 87.202575683594 },
	{ "Prostitute", "Civilian Workers", 2104.58, 2198.14, 10.82, 205, 104, 137, 0, {152, 243, 244, 245, 256, 257, 63, 64, 237}, 10, nil, hookerDisc, 266.93612670898 },
	-- Mechanic
	{ "Mechanic", "Civilian Workers", 1013.06, -1028.97, 32.1, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 186.24034118652 },
	{ "Mechanic", "Civilian Workers", 2070.31, -1865.53, 13.54, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 272.57769775391 },
	{ "Mechanic", "Civilian Workers", 708.79, -474.49, 16.33, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 182.90043640137 },
	{ "Mechanic", "Civilian Workers", -1895.93, 276.32, 41.04, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 172.72692871094 },
	{ "Mechanic", "Civilian Workers", -89.71, 1115.7, 19.74, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 177.17645263672 },
	{ "Mechanic", "Civilian Workers", 1966.14, 2143.93, 10.82, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 95.299621582031 },
	-- Trucker
	{ "Trucker", "Civilian Workers", 46.56, -223.96, 1.59, 225, 225, 0, 0, {261, 206, 202, 133, 15}, 25, nil, "empty", 269.0510559082 },
	{ "Trucker", "Civilian Workers", 2225.56, -2210.81, 13.54, 225, 225, 0, 0, {261, 206, 202, 133, 15}, 25, nil, "empty", 223.98443603516 },
	{ "Trucker", "Civilian Workers", -80.32, -1115.62, 1.08, 225, 225, 0, 0, {261, 206, 202, 133, 15}, 25, nil, "empty", 161.91076660156 },
	{ "Trucker", "Civilian Workers", -2096.45, -2254.1, 30.62, 225, 225, 0, 0, {261, 206, 202, 133, 15}, 25, nil, "empty", 142.96450805664 },
	{ "Trucker", "Civilian Workers", -1734.64, -101.94, 3.55, 225, 225, 0, 0, {261, 206, 202, 133, 15}, 25, nil, "empty", 128.15472412109 },
	{ "Trucker", "Civilian Workers", 682.5, 1848.21, 5.53, 225, 225, 0, 0, {261, 206, 202, 133, 15}, 25, nil, "empty", 257.57015991211 },
	-- Firefighter
	{ "Firefighter", "Firefighters",  1112.5, -1201.1, 18.23, 255, 0, 0, 42, {277,278,279}, 10, nil, "Empty", 181 },
	{ "Firefighter", "Firefighters",  -2025.3, 66.96, 28.46, 255, 0, 0, 42, {277,278,279}, 10, nil, "Empty", 270 },
	-- Police dog officer
	{ "K-9 Unit Officer", "Police",  1543.16, -1644.61, 5.89, 67, 156, 252, 3, {283,288,164,163}, 10, false, "Empty", 174 },
	-- Bus driver
	{ "Bus Driver", "Civilian Workers", -2271, 521.44, 35.01, 255, 255, 0, 0, {255,253}, 3, false, "Empty", 270 },
	{ "Bus Driver", "Civilian Workers", 1110.47, -1806.08, 16.59, 255, 255, 0, 0, {255,253}, 3, false, "Empty", 48 },
	-- Street cleaners
	{ "Street Cleaner", "Civilian Workers", 2195.63, -1973.31, 13.55, 255, 255, 0, 0, {16}, 3, false, "Empty", 181.14259338379 },
	{ "Street Cleaner", "Civilian Workers", -2089.74, 84.27, 35.31, 255, 255,0, 0, {16}, 3, false, "Empty", 81.022644042969 },
	-- Electrican
	{ "Electrician", "Civilian Workers", 1613.5861816406, -1886.6519775391, 13.546875, 255, 255, 0, 0, {260}, 3, false, "Empty", 360 },
	{ "Electrician", "Civilian Workers", -1737.3839111328,-5.1656022071838,3.5489187240601, 255, 255, 0, 0, {260}, 3, false, "Empty", 0 },
	-- Fisherman
	{ "Fisherman", "Civilian Workers", 979.92, -2087.71, 4.8, 255, 255, 255, false, {35,36,37}, 3, false, "Work as a Fisherman to get fish and earn money!", 2.1 },
	{ "Fisherman", "Civilian Workers", -2425.48, 2321, 4.99, 255, 255, 0, false, {35,36,37}, 3, false, "Work as a Fisherman to get fish and earn money!", 2 },
	{ "Fisherman", "Civilian Workers", 1623.78, 606.04, 7.78 , 255, 255, 0, false, {35,36,37}, 3, false, "Work as a Fisherman to get fish and earn money!", 360 },
}

for i=1,#theJobsTable do
	local x, y, z = theJobsTable[i][3], theJobsTable[i][4], theJobsTable[i][5]
	if ( theJobsTable[i][2] == "Civilian Workers" ) then
		createBlip ( x, y, z, 56, 2, 0, 0, 0, 0, 0, 270 )
	elseif ( theJobsTable[i][1] == "Police Officer" ) then
		exports.customblips:createCustomBlip ( x, y, 14, 14, "images/policeBlip.png", 270 )
	elseif ( theJobsTable[i][2] == "Paramedics" ) then
		exports.customblips:createCustomBlip ( x, y, 14, 14, "images/medicBlip.png", 270 )
	elseif ( theJobsTable[i][2] == "Firefighters" ) then
		exports.customblips:createCustomBlip ( x, y, 14, 14, "images/fireBlip.png", 270 )
	end
end

local jobMarkersTable = {}

local theJobWindow = guiCreateWindow(544,193,321,470,"CSG ~ Job",false)
local theJobGrid = guiCreateGridList(9,288,322,133,false,theJobWindow)
local column1 = guiGridListAddColumn( theJobGrid, "  Skin Name:", 0.69 )
local column2 = guiGridListAddColumn( theJobGrid, "ID:", 0.2 )
local theJobButton1 = guiCreateButton(11,426,149,35,"Take job!",false,theJobWindow)
local theJobButton2 = guiCreateButton(163,426,149,35,"No thanks!",false,theJobWindow)
local theJobMemo = guiCreateMemo(9,44,322,217,"",false,theJobWindow)
guiMemoSetReadOnly(theJobMemo, true)
local theJobLabel1 = guiCreateLabel(14,22,257,17,"Information about this job:",false,theJobWindow)
guiSetFont(theJobLabel1,"default-bold-small")
local theJobLabel2 = guiCreateLabel(14,269,257,17,"Choose job clothes:",false,theJobWindow)
guiSetFont(theJobLabel2,"default-bold-small")

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(theJobWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(theJobWindow,x,y,false)

guiWindowSetMovable (theJobWindow, true)
guiWindowSetSizable (theJobWindow, false)
guiSetVisible (theJobWindow, false)

local theHitMarker = nil

function onClientJobMarkerHit( hitElement, matchingDimension ) 
	local px,py,pz = getElementPosition ( hitElement )
	local mx, my, mz = getElementPosition ( source )
	local markerNumber = getElementData( source, "jobMarkerNumber" )
	if ( hitElement == localPlayer ) and ( pz-3 < mz ) and ( pz+3 > mz ) then
		if (getTeamName(getPlayerTeam(localPlayer)) == "Staff") or ( isElementInGroup ( localPlayer, markerNumber ) ) then
			if not ( getPedOccupiedVehicle (localPlayer) ) then
				if ( getElementData( localPlayer, "wantedPoints" ) >= theJobsTable[markerNumber][11] ) then
					exports.DENdxmsg:createNewDxMessage( "Your wantedlevel is to high to take this job!", 225, 0, 0 )
				else
					theHitMarker = source
					setElementData ( localPlayer, "skinBeforeEnter", getElementModel ( localPlayer ), false )
					guiSetText ( theJobWindow, "CSG ~ "..theJobsTable[markerNumber][1] )
					guiSetText ( theJobMemo, theJobsTable[markerNumber][13] )
					loadSkinsIntoGrid( markerNumber )
					guiSetVisible( theJobWindow, true )
					showCursor( true, true )
				end
			end
		end
	end
end

function loadSkinsIntoGrid( markerNumber )
	local theTable = theJobsTable[markerNumber][10]
	guiGridListClear( theJobGrid )
	for k, v in ipairs ( theTable ) do
		local row = guiGridListAddRow ( theJobGrid )
		guiGridListSetItemText ( theJobGrid, row, 1, theJobsTable[markerNumber][1].." "..k, false, true )
		guiGridListSetItemText ( theJobGrid, row, 2, v, false, false )
	end
end

function isElementInGroup ( thePlayer, markerNumber )
	if ( theJobsTable[markerNumber][12] ) then
		if ( getElementData( thePlayer, "Group" ) == theJobsTable[markerNumber][12] ) then
			return true
		else
			exports.DENdxmsg:createNewDxMessage( "You can't take this job!", 225, 0, 0 )
			return false
		end
	else
		return true
	end
end

for i=1,#theJobsTable do
	local x, y, z = theJobsTable[i][3], theJobsTable[i][4], theJobsTable[i][5]
	local r, g, b = theJobsTable[i][6], theJobsTable[i][7], theJobsTable[i][8]
	jobMarkersTable[i] = createMarker( x, y, z -1, "cylinder", 2.0, r, g, b, 150)
	setElementData( jobMarkersTable[i], "jobMarkerNumber", i )
	local theSkin = theJobsTable[i][10][math.random(1,#theJobsTable[i][10])]
	local thePed = createPed ( theSkin, x, y, z )
	setElementFrozen ( thePed, true )
	setPedRotation ( thePed, theJobsTable[i][14] )
	setElementData( thePed, "showModelPed", true )
	addEventHandler( "onClientMarkerHit", jobMarkersTable[i], onClientJobMarkerHit )
end

function onJobSelectSkin ()     
	local theSkin = guiGridListGetItemText ( theJobGrid, guiGridListGetSelectedItem ( theJobGrid ), 2, 1 )
	if ( theSkin == nil ) or ( theSkin == "" ) then 
		setElementModel ( localPlayer, tonumber( getElementData( localPlayer, "skinBeforeEnter" ) ) )
	else
		setElementModel ( localPlayer, theSkin )
	end
end
addEventHandler ( "onClientGUIClick", theJobGrid, onJobSelectSkin )

function onJobWindowClose ()
	guiSetVisible( theJobWindow, false ) 
	showCursor( false ) 
	setElementModel ( localPlayer, tonumber( getElementData( localPlayer, "skinBeforeEnter" ) ), true )
end
addEventHandler("onClientGUIClick", theJobButton2, onJobWindowClose, false )

function onPlayerTakeJob ()
	if ( theHitMarker ) then
		local theSkin = guiGridListGetItemText ( theJobGrid, guiGridListGetSelectedItem ( theJobGrid ), 2, 1 )
		if ( theSkin == nil ) or ( theSkin == "" ) then
			exports.DENdxmsg:createNewDxMessage( "Please select a skin before taking the job!", 225, 0, 0 )
		else
			guiSetVisible( theJobWindow, false ) showCursor( false ) 
			local markerNumber = getElementData( theHitMarker, "jobMarkerNumber" )
			local theTeam, theOccupation, theWeapon = theJobsTable[markerNumber][2], theJobsTable[markerNumber][1], theJobsTable[markerNumber][9]
			
			setElementModel ( localPlayer, tonumber( getElementData( localPlayer, "skinBeforeEnter" ) ) )
			triggerServerEvent( "onSetPlayerJob", localPlayer, theTeam, theOccupation, tonumber(theSkin), theWeapon )
			
			if ( theTeam ~= getTeamName( getPlayerTeam( localPlayer ) ) ) then
				triggerEvent( "onClientPlayerTeamChange", localPlayer, getPlayerTeam( localPlayer ), getTeamFromName( theTeam ) )
			end
			triggerEvent( "onClientPlayerJobChange", localPlayer, theOccupation, theTeam )
		end
	end
end
addEventHandler("onClientGUIClick", theJobButton1, onPlayerTakeJob, false )
