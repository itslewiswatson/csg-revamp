
--[[updatesWindow = guiCreateWindow(389,269,700,487,"Community of Social Gaming ~ Recent updates",false)
updatesGrid = guiCreateGridList(9,24,682,430,false,updatesWindow)
guiGridListSetSelectionMode(updatesGrid,0)
guiGridListAddColumn(updatesGrid,"Date:",0.22)
guiGridListAddColumn(updatesGrid,"Update:",0.55)
guiGridListAddColumn(updatesGrid,"Developer:",0.18)
updatesGridButton = guiCreateButton(10,457,681,21,"Close window",false,updatesWindow)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(updatesWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(updatesWindow,x,y,false)

guiWindowSetMovable (updatesWindow, true)
guiWindowSetSizable (updatesWindow, false)
guiSetVisible (updatesWindow, false)

addEventHandler( "onClientGUIClick", updatesGridButton, function () guiSetVisible(updatesWindow, false) showCursor(false,false) end, false )

addCommandHandler ( "updates",
function ()
	if ( getElementData ( localPlayer, "isPlayerLoggedin" ) ) then
		guiGridListClear( updatesGrid )
		triggerServerEvent ( "getRecentUpdates", localPlayer )
	end
end
)

addEvent( "openUpdatesWindow", true )
addEventHandler( "openUpdatesWindow", root,
function ( theTable )
	for i=1,#theTable do
		local row = guiGridListAddRow ( updatesGrid )
		guiGridListSetItemText ( updatesGrid, row, 1, theTable[i].datum, false, false )
		guiGridListSetItemText ( updatesGrid, row, 2, theTable[i].information, false, false )
		guiGridListSetItemText ( updatesGrid, row, 3, theTable[i].developer, false, false )
	end

	guiSetVisible(updatesWindow, true) showCursor(true,true)
end
)

addCommandHandler( "createupdate",
function ( cmd, ... )
	if ( exports.CSGstaff:isPlayerDeveloper( localPlayer ) ) then
		local theUpdate = table.concat({...}, " ")
		if theUpdate:match("^%s*$") then
			outputChatBox( "The update should contain text!", 225, 0, 0 )
		else
			triggerServerEvent( "addNewUpdate", localPlayer, theUpdate )
		end
	end
end
)
--]]
