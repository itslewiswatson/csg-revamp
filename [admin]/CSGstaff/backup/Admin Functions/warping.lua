
local warpLocations = {
	[1] = {0, 0, 1179.73, -1328.07, 14.18, "Los Santos All Saints Hospital"};
	[2] = {0, 0, 2041.4820556641, -1425.9654541016, 17.1640625, "Los Santos Jefferson Hospital"};
	[3] = {0, 0, 1958.46, -2188.22, 13.54, "Los Santos Airport"};
	[4] = {0, 0, 1543.39, -1670.04, 13.55, "Los Santos Police Department"};
	[5] = {0, 0, -2641.06, 630.99, 14.45, "San Fierro Hospital"};
	[6] = {0, 0, -1472.21, -269.55, 14.14, "San Fierro Airport"};
	[7] = {0, 0, -1610.21, 717.19, 12.81, "San Fierro Police Derpartment"};
	[8] = {0, 0, 1615.27, 1821.87, 10.82, "Las Venturas Hospital"};
	[9] = {0, 0, 1714.05, 1510.12, 10.79, "Las Venturas Airport"};
	[10] = {0, 0, 2282.27, 2423.78, 10.82, "Las Venturas Police Derpartment"};
	[11] = {0, 0, 195.12, 1908.24, 17.64, "Military Forces"};
	[12] = {0, 0, -2262.96, -1701.6, 479.91, "Mount Chiliad"};
	[13] = {0, 2, 1590.699, -832.637, 350.656, "Jail"};
	[14] = {0, 0, 1291.61, -1668.54, 13.54, "SWAT Base"};
	[15] = {0, 0, -2503.6748, 2422.66, 16.59, "Bayside"}
}

local window = guiCreateWindow(825,302,270,381,"Warp Locations",false)
guiWindowSetSizable( window,false )
local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(window,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(window,x,y,false)
local warp = guiCreateButton(12,323,111,40,"Warp",false,window)
local cancel = guiCreateButton(142,323,111,40,"Cancel",false,window)
local warpsgrid = guiCreateGridList(12,26,243,282,false,window)

local column1 = guiGridListAddColumn( warpsgrid, "#", 0.13 )
local column2 = guiGridListAddColumn( warpsgrid, "Place:", 0.69 )


for ID in ipairs( warpLocations ) do
	local warpName = warpLocations[ID][6]
	local row = guiGridListAddRow ( warpsgrid )
	guiGridListSetItemText ( warpsgrid, row, column1, ID, false, false )
	guiGridListSetItemText ( warpsgrid, row, column2, warpName, false, false )
end

guiSetVisible(window,false)

addCommandHandler( "wp",
	function ()
		if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Staff" ) then
			if ( guiGetVisible( window ) ) then
				guiSetVisible( window, false )
				showCursor( false )
			else
				guiSetVisible( window, true )
				showCursor( true )
			end
		end
	end
)

addEventHandler( "onClientGUIClick", warp,
	function ()
	local warpID = guiGridListGetItemText ( warpsgrid, guiGridListGetSelectedItem ( warpsgrid ), 1 )
	local i, d, x, y, z, name = unpack( warpLocations[tonumber( warpID )] )

		setElementPosition ( localPlayer, x, y, z )
		exports.server:setClientPlayerInterior ( localPlayer, i )
		exports.server:setClientPlayerDimension( thePlayer, d )

		guiSetVisible( window, false )
		showCursor( false )
	end, false
)

addEventHandler ( "onClientGUIClick", cancel,
	function ()
		guiSetVisible(window,false)
		showCursor(false)
	end, false
)
