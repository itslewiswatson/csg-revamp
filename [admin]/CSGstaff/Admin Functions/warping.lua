
local warpLocations = {
	[1] = {0, 0, 1179.73, -1328.07, 14.18, "LS Hospital"};
	[2] = {0, 0, 2041.4820556641, -1425.9654541016, 17.1640625, "LS Jefferson Hospital"};
	[3] = {0, 0, -2641.06, 630.99, 14.45, "SF Hospital"};
	[4] = {0, 0, 1615.27, 1821.87, 10.82, "LV Hospital"};
	[5] = {0, 0, 1958.46, -2188.22, 13.54, "LS Airport"};
	[6] = {0, 0, -1472.21, -269.55, 14.14, "SF Airport"};
	[7] = {0, 0, 1714.05, 1510.12, 10.79, "LV Airport"};
	[8] = {0, 0, 1543.39, -1670.04, 13.55, "LSPD"};
	[9] = {0, 0, -1610.21, 717.19, 12.81, "SFPD"};
	[10] = {0, 0, 2282.27, 2423.78, 10.82, "LVPD"};
	[11] = {0, 0, 195.12, 1908.24, 17.64, "Military Forces"};
	[12] = {0, 0, 1260.79, -1660.23, 14.58, "SWAT Base"};
	[13] = {0, 0, 1944.31, 20.76, 33.89, "FBI Base"};
	[14] = {0, 0, -2262.96, -1701.6, 479.91, "Mount Chiliad"};
	[15] = {0, 0, -1941.48, 2396.00, 49.49, "Drugstore"};
	[16] = {0, 0, 4414.6123, -2016.2823, 50.4513, "Maze"};
	[17] = {0, 0, 2012.699, -3542.1001, 15.3, "Dice"};
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
		if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Staff" ) and ( getPlayerAdminLevel( localPlayer ) >= 2 ) then
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
