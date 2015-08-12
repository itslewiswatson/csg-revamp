-- GUI 'n stuff
local resourceWindow = guiCreateWindow(576, 200, 324, 452, "Community of Social Gaming ~ Resources", false)
local resourceGrid = guiCreateGridList(10, 24, 304, 291, false, resourceWindow)
local resourceStart = guiCreateButton(11, 319, 302, 24, "Start Resource", false, resourceWindow)
local resourceRestart = guiCreateButton(10, 347, 302, 24, "Restart Resource", false, resourceWindow)
local resourceStop = guiCreateButton(10, 375, 302, 24, "Stop Resource", false, resourceWindow)
local resourceClose = guiCreateButton(10, 418, 302, 24, "Close Window", false, resourceWindow)

guiWindowSetMovable ( resourceWindow, true )
guiWindowSetSizable ( resourceWindow, false )
guiSetVisible ( resourceWindow, false )

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(resourceWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(resourceWindow,x,y,false)

guiGridListAddColumn ( resourceGrid, "Resource:", 0.9 )

-- Get the selected resource
function getSelectedResourceName ()
	local resourceName = guiGridListGetItemText ( resourceGrid, guiGridListGetSelectedItem ( resourceGrid ), 1 )
	local row, column = guiGridListGetSelectedItem ( resourceGrid )
	if ( resourceName ) and ( tostring( row ) ~= "-1" ) then
		return resourceName, row
	end
end

-- Event handler for buttons
addEventHandler( "onClientGUIClick", root,
	function ()
		local resource, rowid = getSelectedResourceName ()
		if ( source == resourceClose ) then
			guiSetVisible ( resourceWindow, false )
			showCursor( false )
		elseif ( source == resourceStart ) and ( resource ) then
			triggerServerEvent( "onUpdateResourceState", localPlayer, "start", resource, rowid )
		elseif ( source == resourceRestart ) and ( resource ) then
			triggerServerEvent( "onUpdateResourceState", localPlayer, "restart", resource, rowid )
		elseif ( source == resourceStop ) and ( resource ) then
			triggerServerEvent( "onUpdateResourceState", localPlayer, "stop", resource, rowid )
		end
	end
)

-- Put the resources in the grid
addEvent( "onOpenResourcesWindow", true )
addEventHandler( "onOpenResourcesWindow", root,
	function ( theTable )
		guiGridListClear( resourceGrid )
		for i=1,#theTable do
			local row = guiGridListAddRow ( resourceGrid )
			if ( theTable[i][2] == "running" ) or ( theTable[i][2] == "starting" ) then
				guiGridListSetItemText ( resourceGrid, row, 1, theTable[i][1], false, false )
				guiGridListSetItemColor( resourceGrid, row, 1, 0, 225, 0 )
			else
				guiGridListSetItemText ( resourceGrid, row, 1, theTable[i][1], false, false )
				guiGridListSetItemColor( resourceGrid, row, 1, 225, 0, 0 )
			end
		end
		guiSetVisible ( resourceWindow, true )
		showCursor( true )
	end
)

-- Update row color
addEvent( "setResourceColor", true )
addEventHandler( "setResourceColor", root,
	function ( row, R, G, B )
		guiGridListSetItemColor( resourceGrid, row, 1, R, G, B )
	end
)