-- The window
loginsWindow = guiCreateWindow(340,253,761,241,"Community of Social Gaming ~ Last logins",false)
loginsGrid = guiCreateGridList(9,23,743,177,false,loginsWindow)
guiGridListSetSelectionMode(loginsGrid,0)
loginsButton = guiCreateButton(622,205,130,27,"Close window",false,loginsWindow)
loginsLabel = guiCreateLabel(10,207,601,23,"Serials with a red color are different from the one you are using now!",false,loginsWindow)
guiSetFont(loginsLabel,"default-bold-small")

guiGridListAddColumn( loginsGrid, "Date:", 0.20 )
guiGridListAddColumn( loginsGrid, "Nickname:", 0.20 )
guiGridListAddColumn( loginsGrid, "IP:", 0.20 )
guiGridListAddColumn( loginsGrid, "Serial:", 0.34 )

guiWindowSetMovable ( loginsWindow, true )
guiWindowSetSizable ( loginsWindow, false )
guiSetVisible ( loginsWindow, false )

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(loginsWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(loginsWindow,x,y,false)

-- Open the window and insert the last logins
addEvent( "onClientOpenLoginsWindow", true )
addEventHandler( "onClientOpenLoginsWindow", root,
	function ( theTable )
		if ( theTable ) then
			guiGridListClear( loginsGrid )
			for i=1,#theTable do
				local row = guiGridListAddRow( loginsGrid )
				guiGridListSetItemText( loginsGrid, row, 1, theTable[i].datum, false, false )
				guiGridListSetItemText( loginsGrid, row, 2, theTable[i].nickname, false, false )
				guiGridListSetItemText( loginsGrid, row, 3, theTable[i].ip, false, false )
				guiGridListSetItemText( loginsGrid, row, 4, theTable[i].serial, false, false )
				
				if ( theTable[i].serial ~= getPlayerSerial() ) then
					guiGridListSetItemColor( loginsGrid, row, 4, 225, 0, 0 )
				end
			end
			
			guiSetVisible ( loginsWindow, true )
			showCursor( true )
		else
			outputChatBox( "Something wen't wrong while loading the last logins! Try again.", 225, 0, 0 )
		end
	end
)

-- Close window
addEventHandler( "onClientGUIClick", loginsButton,
	function ()
		guiSetVisible ( loginsWindow, false )
		showCursor( false )
	end, false
)