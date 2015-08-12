local mapsGUI = {}
local updateBookmarks = true

local GPSTable = {
	["Los Santos"] =  {
		{"LS Airport", 1937, -2262, 0},
		{"All Saints Hospital", 1180, -1324, 0},
		{"LS Police Department", 1548, -1676, 0},
		{"Bus Driver", 1108.9, -1804.55, 16.59},
		{"License Test (car)", 1238.21, -1813.59, 13.42},
		{"LS Stadium", 2665.06, -1850.75, 11.03},
		{"Mechanic job & Pay 'n Spray", 1010.22, -1030.93, 31.94},
		{"Firefighters (ob", 1112.31, -1205.09, 17.78},
		{"Hooker job", 785.45, -1550.77, 13.54},
		{"Bankrob", 593.4, -1241.33, 17.98},
		{"Trucker job", 2227.67, -2212.85, 13.54},
		{"Chopper License", 2001.03, -2269.29, 13.54},
		{"Car Shop (Luxury)", 559.88, -1254.5, 17.21},
		{"Car Shop", 2134.41, -1121.76, 25.41},
		{"Boat License", 2314.8, -2391.71, 3},
		{"Pilot Job",1896.97, -2245.41, 13.54},
		{"Trash Collector",2200.05, -1974.24, 13.55},
		{"Street Cleaner",2196.31, -1973.15, 13.55},
		{"Fisherman",982.05, -2087, 4.8},
		{"Electrician",1614.02, -1885.32, 13.54},
		{"Lumberjack job",-534.85, -178.03, 78.4},
		{"Rescuer job",147.29, -1941.83, 3.77},
		{"News Reporter",646.93, -1362.63, 13.6},
		{"Limo Driver / LS Club",-534.85, -178.03, 78.4},
		{"Mail Officer",1711.93, -1614.79, 13.55},
		{"Taxi Driver",1804.27, -1934.27, 13.38},
		{"Airport Attendant",1643.04, -2239.61, 13.49},
		{"Pizza Boy",2093.25, -1796.47, 13.38},
		{"Fuel Tank Driver",2594.06, -2201.41, 13.54},
		{"Delivery man",2691.11, -1112.28, 69.52},
	},

	["San Fierro"] =  {
		{"SF Airport", -1673, -400, 0},
		{"License Test (Bike)", -2268.57, 216.42, 35.16},
		{"SF Medical Center (Medic job)", -2641.52, 632.28, 14.45},
		{"Busdriver job", -2268.67, 521.49, 35.01},
		{"Car Shop", -1970.5, 300.23, 35.17},
		{"mechanic job", -1896.03, 273.75, 41.04},
		{"Drug Factory", -1823.68, 43.81, 15.12},
		{"Car Shop (Luxury)", -1641.63, 1203.41, 7.24},
		{"Bike shop", -2069.29, -92.76, 35.16},
		{"Firefighters", -2023.22, 66.88, 28.46},
		{"Hooker job", -2625.99, 1402.28, 7.1},
		{"Plane License", -1677.6, -165.7, 14.14},
		{"Trucker job", -1736.69, -104.04, 3.55},
		{"Pilot Job",-1543.59, -438.17, 6},
		{"Electrician",-1736.13, -5.23, 3.55},
		{"Street Cleaner", -2090.22, 84.8, 35.31},
	},

	["Las Venturas"] =  {
		{"LV Airport", 1584, 1643, 0},
		{"LV Police Department", 2287, 2425, 0},
		{"Car Shop (Luxury)", 2154.36, 1403.53, 11.13},
		{"Car Shop", 1736.64, 1879.18, 10.82},
		{"Casino Rob", 2194.89, 1676.92, 12.36},
		{"LV Hospital", 1606.75, 1833.73, 10.82},
		{"LV Stadium", 1308.25, 2083.12, 10.82},
		{"Trucker job", 685.15, 1847.83, 5.56},
		{"Mech job", 1962.9, 2143.65, 10.82},
		{"Hooker job", 2107.08, 2198.28, 10.82},
		{"Pilot Job",1711.91, 1614.83, 10.13},
		{"Fisherman",1622.74, 606.36, 7.78},
	},
}

function openMaps()
	if not mapsGUI[1] then mapsGUI[1] = guiCreateButton ( BGX+(BGWidth*0.50), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Start GPS", false ) end
	if not mapsGUI[2] then mapsGUI[2] = guiCreateButton ( BGX+(BGWidth*0.0), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Stop GPS", false ) end
	if not mapsGUI[3] then mapsGUI[3] = guiCreateCheckBox ( BGX+34, BGY+(0.74*BGHeight), BGWidth, 0.058*BGHeight, "Enable voice turn by turn GPS", false, false ) end
	if not mapsGUI[4] then mapsGUI[4] = guiCreateCheckBox ( BGX+34, BGY+(0.79*BGHeight), BGWidth, 0.058*BGHeight, "Enable car rotation arrow", false, false ) end
	if not mapsGUI[5] then mapsGUI[5] = guiCreateCheckBox ( BGX+34, BGY+(0.84*BGHeight), BGWidth, 0.058*BGHeight, "Enable road rotation arrows", false, false ) end
	if not mapsGUI[6] then mapsGUI[6] = guiCreateGridList ( BGX, BGY, 0.99770569801331*BGWidth, 0.57*BGHeight, false ) end
	if not mapsGUI[7] then mapsGUI[7] = guiCreateLabel ( BGX, BGY+(0.61*BGHeight), BGWidth, 0.048*BGHeight,"Or enter a playername to put GPS on:", false) end
	if not mapsGUI[8] then mapsGUI[8] = guiCreateEdit( BGX+(0.05*BGWidth),BGY+(0.67*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"",false) end

	guiGridListSetSortingEnabled ( mapsGUI[6], false )
	guiLabelSetHorizontalAlign ( mapsGUI[7], "center" )

	addEventHandler( "onClientGUIClick", mapsGUI[1], onStartMapsGPS )
	addEventHandler( "onClientGUIClick", mapsGUI[2], onStopMapsGPS )

	for i=1, #mapsGUI do
		if i <= 8 then
			guiSetVisible ( mapsGUI[i], true )
			guiSetProperty ( mapsGUI[i], "AlwaysOnTop", "True" )
		end
	end

	if ( updateBookmarks ) then uploadGridlistBookmarks () end

	apps[10][7] = true
end
apps[10][8] = openMaps

function closeMaps()

	removeEventHandler( "onClientGUIClick", mapsGUI[1], onStartMapsGPS )
	removeEventHandler( "onClientGUIClick", mapsGUI[2], onStopMapsGPS )

	for i=1,#mapsGUI do
		if i <= 8 then
			guiSetVisible ( mapsGUI[i], false )
			guiSetProperty ( mapsGUI[i], "AlwaysOnTop", "False" )
		end
	end

	apps[10][7] = false
end
apps[10][9] = closeMaps

function getSelectBookmark ()
	local row, column = guiGridListGetSelectedItem ( mapsGUI[6] )
	if ( tostring( row ~= "-1" ) ) then
		local thePos = guiGridListGetItemData( mapsGUI[6], row, 1 )
		local thePlace = guiGridListGetItemText ( mapsGUI[6], row, 1 )
		if ( thePos ) then
			local theTable = exports.server:stringExplode( thePos, "," )
			return theTable[1], theTable[2], theTable[3], thePlace
		else
			return false
		end
	else
		return false
	end
end

function onStartMapsGPS ()
	local opt1, opt2, opt3 = guiCheckBoxGetSelected( mapsGUI[3] ), guiCheckBoxGetSelected( mapsGUI[4] ), guiCheckBoxGetSelected( mapsGUI[5] )
	local x, y, z, thePlace = getSelectBookmark()
	if ( x ) and ( y ) and ( z ) then
		exports.CSGgps:setDestination( x, y, z, thePlace, false, { opt2, opt3, opt1, false } )
	else
		local thePlayer = exports.server:getPlayerFromNamePart( guiGetText( mapsGUI[8] ) )
		if ( thePlayer ) and ( isElement( thePlayer ) ) then
			exports.CSGgps:setDestinationToPlayer( thePlayer, getPlayerName( thePlayer ), false, { opt2, opt3, opt1, false } )
			-- exports.DENdxmsg:createNewDxMessage( "Setting GPS on a player is temporary disabled due a bug, fixed soon!", 255,0, 0 )
		else
			exports.DENdxmsg:createNewDxMessage( "You didn't select a bookmark or enter a valid playname!", 255,0, 0 )
		end
	end
end

function onStopMapsGPS ()
	exports.CSGgps:resetDestination()
end

function uploadGridlistBookmarks ()
	guiGridListAddColumn( mapsGUI[6], "Bookmarks:", 0.9 )
	for theName, theCategory in pairs( GPSTable ) do
		local row = guiGridListAddRow( mapsGUI[6] )
		guiGridListSetItemText( mapsGUI[6], row, 1, theName, true, false )

		for theIndex, theBookmark in pairs( theCategory ) do
			local row = guiGridListAddRow( mapsGUI[6] )
			guiGridListSetItemText( mapsGUI[6], row, 1, theBookmark[1], false, false )
			guiGridListSetItemData( mapsGUI[6], row, 1, theBookmark[2].."," .. theBookmark[3] ..","..theBookmark[4] )
		end
	end
	updateBookmarks = false
end
