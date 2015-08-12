-- Anti compiller
local CSGSecurity = {{{{{ {}, {}, {} }}}}}

-- The Vehicle Spawn Gui
vehiclesWindow = guiCreateWindow(395,237,241,413,"CSG ~ Vehicles",false)
vehiclesGrid = guiCreateGridList(9,26,221,307,false,vehiclesWindow)
guiGridListSetSelectionMode(vehiclesGrid,0)
spawnVehicleSystemButton = guiCreateButton(9,337,220,30,"Spawn Vehicle",false,vehiclesWindow)
closeWindowButton = guiCreateButton(9,373,220,30,"Close Window",false,vehiclesWindow)
guiGridListSetSortingEnabled ( vehiclesGrid, false )

vehicleName = guiGridListAddColumn( vehiclesGrid, " Vehiclename:", 0.80 )

addEventHandler("onClientGUIClick", closeWindowButton, function() guiSetVisible(vehiclesWindow, false) showCursor(false,false) guiGridListClear ( vehiclesGrid ) end, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(vehiclesWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(vehiclesWindow,x,y,false)

guiWindowSetMovable (vehiclesWindow, true)
guiWindowSetSizable (vehiclesWindow, false)
guiSetVisible (vehiclesWindow, false)


local mclist = {
[442] = {"Romero", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
}

local Photolist = {
[541] = {"Bullet", 0, 0, 0, 0,r=255,g=255,b=0,r2=0,g2=0,b2=0},
}

local farmerlist = {
[531] = {"Tractor", 0, 0, 0, 0,r=255,g=255,b=0,r2=0,g2=0,b2=0},
}
local farmer2list = {
[532] = {"Combine Harvester", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
}

local imlist = {
[573] = {"Dune", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
}

----LSPD
local polist = {
[497] = {"Police Maverick", 0, 0, 0, 0,r=255,g=255,b=255,r2=0,g2=0,b2=0},
}
----LSPD
local fblist = {
[447] = {"Sea Sparrow", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[497] = {"Police Maverick", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
}
------------FBI BASE
local fblist0 = {
[519] = {"FBI Shamal", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
}
local fblist1 = {
[447] = {"FBI Sea Sparrow", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[497] = {"FBI Maverick", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[563] = {"FBI Raindance", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
}
local fb2list = {
[428] = {"FBI Securicar", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[416] = {"FBI Ambulance", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[427] = {"FBI Enforcer", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
}
local fb3list = {
[426] = {"FBI Premier", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[405] = {"FBI Sentinel", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[560] = {"FBI Sultan", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[451] = {"FBI Turismo", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[415] = {"FBI Cheetah", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[596] = {"FBI LSPD", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[598] = {"FBI LVPD", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[523] = {"FBI Harly PDBike", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
}
local fb4list = {
[528] = {"FBI Truck", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[490] = {"FBI Rancher", 0, 0, 0, 0,r=25,g=25,b=25,r2=25,g2=25,b2=25},
[599] = {"FBI Police Ranger", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[579] = {"FBI Huntley", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
}
local fb5list = {
[472] = {"FBI CoastGuard", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[595] = {"FBI Launch", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
[430] = {"FBI Predator", 0, 0, 0, 0,r=25,g=25,b=25,r2=230,g2=230,b2=230},
}
----------------
----LSPD
local swlist = {
[447] = {"Sea Sparrow", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[497] = {"Police Maverick", 0, 0, 0, 0,r=0,g=0,b=90,r2=0,g2=0,b2=0},
[563] = {"Raindance", 0, 0, 0, 0,r=0,g=0,b=90,r2=0,g2=0,b2=0},
}
------SWAT BASE
local swb1list = {
[519] = {"SWAT Shamal", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
}
------SWAT BASE
local swb2list = {
[497] = {"SWAT Maverick", 0, 0, 0, 0,r=0,g=0,b=90,r2=255,g2=255,b2=255},
[563] = {"SWAT Raindance", 0, 0, 0, 0,r=0,g=0,b=90,r2=255,g2=255,b2=255},
[447] = {"SWAT SeaSparrow", 0, 0, 0, 0,r=0,g=0,b=90,r2=255,g2=255,b2=255},
}
------SWAT BASE
local swb3list = {
[426] = {"SWAT Premier", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[451] = {"SWAT Turismo", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[598] = {"SWAT LVPD", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[596] = {"SWAT LSPD", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[597] = {"SWAT SFPD", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[599] = {"SWAT RANGER", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[490] = {"SWAT Rancher", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[523] = {"SWAT HPV1000", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[601] = {"SWAT S.W.A.T", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[427] = {"SWAT Enforcer", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[415] = {"SWAT Cheetah", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[579] = {"SWAT Huntley", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[468] = {"SWAT Sanchez", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[560] = {"SWAT Sultan", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
}
------SWAT BASE
local swb4list = {
[428] = {"SWAT Securicar", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[416] = {"SWAT Ambulance", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[407] = {"SWAT Fire Truck", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
[486] = {"SWAT Dozer", 0, 0, 0, 0,r=20,g=33,b=73,r2=255,g2=255,b2=255},
}
------LSPD
local mflist = {
[447] = {"Sea Sparrow", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[497] = {"Police Maverick", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[563] = {"Raindance", 0, 0, 0, 0,r=0,g=60,b=0,r2=0,g2=60,b2=0},
[548] = {"Cargobob", 0, 0, 0, 0,r=0,g=60,b=0,r2=0,g2=60,b2=0},
[425] = {"Hunter", 0, 0, 0, 0,r=0,g=60,b=0,r2=0,g2=60,b2=0},
}
----- MF base
local mfblist = {
[476] = {"Rustler", 0, 0, 0, 0,r=0,g=50,b=0,r2=0,g2=0,b2=0},
[520] = {"Hydra", 0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
}

local vehicleMarkers = {
	{ 833.31, -1111.58, 24.17,255,255,0, mclist,"Civilian Workers","Mortuary Agency",1,false,nil,nil,nil},
	{ 1802.44, -1293, 13.5,255,255,0, Photolist,"Civilian Workers","Photographer",19,false,nil,nil,nil},
	{ -1055.4, -1190.63, 129.13,255,255,0, farmerlist,"Civilian Workers","Farmer",267,false,nil,nil,nil},
	{ -1055.28, -1184.32, 129.14,255,255,0, farmerlist,"Civilian Workers","Farmer",267,false,nil,nil,nil},
	{ -1211.52, -1117.77, 129.21,255,255,0, farmer2list,"Civilian Workers","Farmer",356,false,nil,nil,nil},
	{ 630.73, 882.04, -42.97,255,255,0, imlist,"Civilian Workers","Iron Miner",1,false,nil,nil,nil},
	{ 639.89, 898.57, -42.96,255,255,0, imlist,"Civilian Workers","Iron Miner",1,false,nil,nil,nil},
	{ 1569.14, -1657.31, 28.45,50,100,255, polist,"Police","Police Officer",1,false,nil,nil,nil},
	{ 1569.8, -1644.02, 28.45,50,100,255, polist,"Police","Police Officer",1,false,nil,nil,nil},
	{ 1569.14, -1657.31, 28.45,50,100,255, fblist,"Government Agency","Federal Agent",1,false,nil,nil,nil},
	{ 1569.8, -1644.02, 28.45,50,100,255, fblist,"Government Agency","Federal Agent",1,false,nil,nil,nil},
	{ 2043.14, -180.55, 36.61 ,80,80,80, fblist0,"Government Agency","Federal Agent",268,false,nil,nil,nil},
	{ 2006.56, -182.4, 58.84 ,80,80,80, fblist1,"Government Agency","Federal Agent",268,false,nil,nil,nil},
	{ 1959.04, -138.65, 35.46,80,80,80, fb2list,"Government Agency","Federal Agent",355,false,nil,nil,nil},
	{ 1944.74, -120.81, 35.46,80,80,80, fb3list,"Government Agency","Federal Agent",268,false,nil,nil,nil},
	{ 1971.02, -76.59, 35.46,80,80,80, fb4list,"Government Agency","Federal Agent",177,false,nil,nil,nil},
	{ 1992.87, -125.37, -0.56,80,80,80, fb5list,"Government Agency","Federal Agent",270,false,nil,nil,nil},
	{ 1569.14, -1657.31, 28.45,50,100,255, swlist,"SWAT","SWAT Team",1,false,nil,nil,nil},
	{ 1569.8, -1644.02, 28.45,50,100,255, swlist,"SWAT","SWAT Team",1,false,nil,nil,nil},
	{ 1569.14, -1657.31, 28.45,50,100,255, mflist,"Military Forces","Military Forces",1,false,nil,nil,nil},
	{ 1569.8, -1644.02, 28.45,50,100,255, mflist,"Military Forces","Military Forces",1,false,nil,nil,nil},
	{ 370.32, 1940.86, 17.66,0,60,0, mfblist,"Military Forces","Military Forces",85,false,nil,nil,nil},


	{ 1280.61, -1692.06, 21.51,20,33,73, swb1list,"SWAT","SWAT Team",90,false,nil,nil,nil},
    { 1199.27, -1620.06, 76.11,20,33,73, swb2list,"SWAT","SWAT Team",90,false,nil,nil,nil},
    { 1198.65, -1596.75, 76.11,20,33,73, swb2list,"SWAT","SWAT Team",90,false,nil,nil,nil},
    { 1234.17, -1622.76, 14.66,20,33,73, swb3list,"SWAT","SWAT Team",90,false,nil,nil,nil},
    { 1234.77, -1613.72, 14.66,20,33,73, swb3list,"SWAT","SWAT Team",90,false,nil,nil,nil},
    { 1224.65, -1683.65, 14.58,20,33,73, swb4list,"SWAT","SWAT Team",0,false,nil,nil,nil},



	}

local JobsToTables = {

}

local asdmarkers = {}
local workingWithTable=false
for i,v in pairs(vehicleMarkers) do
	if getPlayerTeam ( localPlayer ) then
		local overRide=false
		if v[8] ~= nil and v[8] == "Police" then
			if getTeamName(getPlayerTeam ( localPlayer )) == "Police" or getTeamName(getPlayerTeam ( localPlayer )) == "Government Agency" or getTeamName(getPlayerTeam ( localPlayer )) == "SWAT" or getTeamName(getPlayerTeam ( localPlayer )) == "Military Forces" then
				overRide=true
			end
		end
		if overRide==false and getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer, "Occupation") == v[9] or
			getTeamName(getPlayerTeam ( localPlayer )) == v[8] and v[11] == "noOccupation" or
			getTeamName(getPlayerTeam ( localPlayer )) == v[11] or getTeamName(getPlayerTeam ( localPlayer )) == v[12] or v[8] == nil and v[9] == nil then

			elref = createMarker(v[1], v[2], v[3] -1, "cylinder", 2.2, v[4], v[5], v[6])
			asdmarkers [elref ] = v[7]
			setElementData(elref, "freeVehiclesSpawnRotation", v[10])
			setElementData(elref, "isMakerForFreeVehicles", true)

			if ( v[11] == "aGroup" ) then setElementData(elref, "groupMarkerName", v[15] ) end
		end
	end
end

local workingWith = {}

addEventHandler("onClientMarkerHit", root, function(hitElement, matchingDimension)
if getElementType ( hitElement ) == "player" and getElementData(source, "isMakerForFreeVehicles") == true and hitElement == localPlayer then
	guiGridListClear ( vehiclesGrid )
	if not isPedInVehicle(localPlayer) then
		if (asdmarkers [source] ) then
			workingWithTable=asdmarkers [source]
			for i,v in pairs( asdmarkers [source] ) do
				if hitElement == localPlayer then
					local px,py,pz = getElementPosition ( hitElement )
					local mx, my, mz = getElementPosition ( source )
						if ( pz-3 < mz ) and ( pz+3 > mz ) then
							if ( getElementData( source, "groupMarkerName" ) ) and ( getElementData( localPlayer, "Group" ) ) and not ( getElementData( source, "groupMarkerName" ) == getElementData( localPlayer, "Group" ) ) then
								exports.DENdxmsg:createNewDxMessage("You are not allowed to use this vehicle marker!", 225 ,0 ,0)
							else
								local row = guiGridListAddRow ( vehiclesGrid )
								workingWith[tostring(v[1])] = tonumber(i)
								guiGridListSetItemText ( vehiclesGrid, row, vehicleName, tostring(v[1]), false, false )
								guiGridListSetItemData ( vehiclesGrid, row, vehicleName, tostring(i) )
								guiSetVisible (vehiclesWindow, true)
								showCursor(true,true)

								theVehicleRoation = getElementData(source, "freeVehiclesSpawnRotation")
								theMarker = source
							end
						end
					end
				end
			end
		end
	end
end)

-- Reload the markers
function reloadFreeVehicleMarkers ()
	for i,v in pairs( asdmarkers ) do
		destroyElement(i)
	end

	asdmarkers = {}

	for i,v in pairs(vehicleMarkers) do
		if getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer, "Occupation") == v[9] or
			getTeamName(getPlayerTeam ( localPlayer )) == v[8] and v[11] == "noOccupation" or
			getTeamName(getPlayerTeam ( localPlayer )) == v[11] or getTeamName(getPlayerTeam ( localPlayer )) == v[12] or v[8] == nil and v[9] == nil then

			elref =  createMarker(v[1], v[2], v[3] -1, "cylinder", 2.2, v[4], v[5], v[6])
			asdmarkers [elref ] = v[7]
			setElementData(elref, "freeVehiclesSpawnRotation", v[10])
			setElementData(elref, "isMakerForFreeVehicles", true)

			if ( v[11] == "aGroup" ) then setElementData(elref, "groupMarkerName", v[15] ) end
		end
	end
end
addEvent("reloadFreeVehicleMarkers", true)
addEventHandler("reloadFreeVehicleMarkers", root, reloadFreeVehicleMarkers )

function spawnTheVehicle ()
local x,y,z = getElementPosition(theMarker)
local selectedVehicle = guiGridListGetItemText ( vehiclesGrid, guiGridListGetSelectedItem ( vehiclesGrid ), 1 )
	if selectedVehicle == "" or selectedVehicle == " " then
		exports.DENdxmsg:createNewDxMessage("You didnt select a vehicle!", 225 ,0 ,0)
	else
		local selectedRow, selectedColumn = guiGridListGetSelectedItem(vehiclesGrid)
		local theVehicleID = workingWith[tostring(selectedVehicle)]
		--local theVehicleID = tonumber(guiGridListGetItemData ( vehiclesGrid, selectedRow, selectedColumn ))
		if ( tonumber( theVehicleID) == 481 ) or ( tonumber( theVehicleID) == 510 ) or ( tonumber( theVehicleID) == 509 ) or ( tonumber( theVehicleID) == 462 ) or ( getElementData( localPlayer, "Occupation" ) == "Criminal" ) then
			if ( getElementData( localPlayer, "wantedPoints" ) >= 20 ) then
				exports.DENdxmsg:createNewDxMessage("You can't spawn free vehicles when having more then 1 wanted stars!", 225 ,0 ,0)
			else
				local getTable = workingWithTable --JobsToTables[getElementData(localPlayer, "Occupation")] or JobsToTables[getTeamName(getPlayerTeam ( localPlayer ))]
			local vehicle,color1,color2,color3,color4 = getTable[theVehicleID][1],getTable[theVehicleID][2],getTable[theVehicleID][3],getTable[theVehicleID][4],getTable[theVehicleID][5]--unpack( getTable[tonumber( theVehicleID )] )
			local r,g,b=nil,nil,nil
			local r2,g2,b2=nil,nil,nil
			if getTable[theVehicleID].r ~= nil then
				r,g,b=getTable[theVehicleID].r,getTable[theVehicleID].g,getTable[theVehicleID].b
			end
			if getTable[theVehicleID].r2 ~= nil then
				r2,g2,b2=getTable[theVehicleID].r2,getTable[theVehicleID].g2,getTable[theVehicleID].b2
			end
			triggerServerEvent("spawnVehicleSystem", localPlayer, x, y, z, theVehicleID, color1, color2, color3, color4, theVehicleRoation,r,g,b,r2,g2,b2)
				guiSetVisible (vehiclesWindow, false)
				showCursor(false,false)
				guiGridListClear ( vehiclesGrid )
			end
		elseif doesPlayerHaveLiceForVehicle(tonumber(theVehicleID)) then
			local getTable = workingWithTable --JobsToTables[getElementData(localPlayer, "Occupation")] or JobsToTables[getTeamName(getPlayerTeam ( localPlayer ))]
			local vehicle,color1,color2,color3,color4 = getTable[theVehicleID][1],getTable[theVehicleID][2],getTable[theVehicleID][3],getTable[theVehicleID][4],getTable[theVehicleID][5]--unpack( getTable[tonumber( theVehicleID )] )
			local r,g,b=nil,nil,nil
			local r2,g2,b2=nil,nil,nil
			if getTable[theVehicleID].r ~= nil then
				r,g,b=getTable[theVehicleID].r,getTable[theVehicleID].g,getTable[theVehicleID].b
			end
			if getTable[theVehicleID].r2 ~= nil then
				r2,g2,b2=getTable[theVehicleID].r2,getTable[theVehicleID].g2,getTable[theVehicleID].b2
			end
			triggerServerEvent("spawnVehicleSystem", localPlayer, x, y, z, theVehicleID, color1, color2, color3, color4, theVehicleRoation,r,g,b,r2,g2,b2)
			guiSetVisible (vehiclesWindow, false)
			showCursor(false,false)
			guiGridListClear ( vehiclesGrid )
		else
			exports.DENdxmsg:createNewDxMessage("You don't have a licence for this type of vehicle!", 225 ,0 ,0)
		end
	end
end
addEventHandler("onClientGUIClick", spawnVehicleSystemButton, spawnTheVehicle, false)

function doesPlayerHaveLiceForVehicle (vehicleID)
	local playtime = getElementData(localPlayer,"playTime")
	if getVehicleType ( vehicleID ) == "Automobile" or getVehicleType ( vehicleID ) == "Monster Truck"
	or getVehicleType ( vehicleID ) == "Quad" or getVehicleType ( vehicleID ) == "Trailer" then
		if playtime == false or playtime==nil then return true end
		if math.floor((tonumber(playtime)/60)) < 10 then return true end
		if getElementData(localPlayer, "carLicence") then
			return true
		else
			return false
		end
	elseif getVehicleType ( vehicleID ) == "Plane" then
		if getElementData(localPlayer, "planeLicence") then
			return true
		else
			return false
		end
	elseif getVehicleType ( vehicleID ) == "Helicopter" then
		if getElementData(localPlayer, "chopperLicence") then
			return true
		else
			return false
		end
	elseif getVehicleType ( vehicleID ) == "Bike" or getVehicleType ( vehicleID ) == "BMX" then
		if getElementData(localPlayer, "bikeLicence") then
			return true
		else
			return false
		end
	elseif getVehicleType ( vehicleID ) == "Boat" then
		if getElementData(localPlayer, "boatLicence") then
			return true
		else
			return false
		end
	end
end
