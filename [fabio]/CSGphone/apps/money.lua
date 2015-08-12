local moneyGUI = {}
local spamProtect = {}

function openMoneyApp()
	if not moneyGUI[1] then moneyGUI[1] = guiCreateEdit( BGX, BGY, BGWidth, 0.08*BGHeight,"",false) end
	if not moneyGUI[2] then moneyGUI[2] = guiCreateGridList ( BGX,BGY+(0.08*BGHeight), 0.99770569801331*BGWidth, 0.64*BGHeight, false ) end
	if not moneyGUI[3] then moneyGUI[3] = guiCreateLabel ( BGX, BGY+(0.75*BGHeight), BGWidth, 0.048*BGHeight,"Amount you want to send:", false) end
	if not moneyGUI[4] then moneyGUI[4] = guiCreateEdit( BGX, BGY+(0.83*BGHeight), BGWidth, 0.08*BGHeight,"",false) end
	if not moneyGUI[5] then moneyGUI[5] = guiCreateButton ( BGX+(BGWidth*0.0), BGY+(0.930*BGHeight), 1.0*BGWidth, 0.068*BGHeight, "Send money", false ) end
	if not moneyGUI[6] then moneyGUI[6] = guiGridListAddColumn ( moneyGUI[2], "  Playername:", 0.9 ) end
	
	for i=1, #moneyGUI do
		if i ~= 6 then
			guiSetVisible ( moneyGUI[i], true )
			guiSetProperty ( moneyGUI[i], "AlwaysOnTop", "True" )
		end
	end
	
	addEventHandler	("onClientGUIChanged", moneyGUI[1], onClientSearchPlayerFromGrid, false)
	addEventHandler ( "onClientGUIClick", moneyGUI[5], onSendPlayerMoney )
	
	guiSetText( moneyGUI[4], "" )
	guiSetText( moneyGUI[1], "" )
	
	guiLabelSetHorizontalAlign ( moneyGUI[3], "center" )
	guiSetFont ( moneyGUI[3], "default-bold-small" )
	loadPlayersIntoGrid()
	
	apps[9][7] = true

end

apps[9][8] = openMoneyApp

function closeMoneyApp()

	for i=1,#moneyGUI do
		if i ~= 6 then
			guiSetVisible ( moneyGUI[i], false )
			guiSetProperty ( moneyGUI[i], "AlwaysOnTop", "False" )
		end
	end
	
	removeEventHandler	("onClientGUIChanged", moneyGUI[1], onClientSearchPlayerFromGrid, false)
	removeEventHandler ( "onClientGUIClick", moneyGUI[5], onSendPlayerMoney )
	
	apps[9][7] = false

end

apps[9][9] = closeMoneyApp

function loadPlayersIntoGrid ()
	guiGridListClear( moneyGUI[2] )
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if ( thePlayer ~= localPlayer ) and ( getElementData( thePlayer, "accountUserID" ) ) then
			local theRow = guiGridListAddRow( moneyGUI[2] )
			guiGridListSetItemText ( moneyGUI[2], theRow, 1, getPlayerName( thePlayer ), false, false )
		end
	end
end

function onClientSearchPlayerFromGrid()
	guiGridListClear( moneyGUI[2] )
	local name = guiGetText( moneyGUI[1] )
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if ( thePlayer ~= localPlayer ) and ( getElementData( thePlayer, "accountUserID" ) ) then
			if ( string.find( getPlayerName( thePlayer ):lower(), name:lower() ) ) then
				local row = guiGridListAddRow ( moneyGUI[2] )
				guiGridListSetItemText ( moneyGUI[2], row, 1, getPlayerName ( thePlayer ), false, false )
			end
		end
	end
end

function onSendPlayerMoney ()
	if ( spamProtect[localPlayer] ) and ( getTickCount()-spamProtect[localPlayer] < 4000 ) then
		exports.DENdxmsg:createNewDxMessage( "Do not spam the send money function!", 225, 0, 0 )
	else
		local theMoney = guiGetText( moneyGUI[4] )
		if ( string.match(theMoney,'^%d+$') ) then
			if ( getPlayerMoney() >= tonumber( theMoney ) ) then
				local playerName = guiGridListGetItemText ( moneyGUI[2], guiGridListGetSelectedItem ( moneyGUI[2] ), 1 )
				if ( playerName ) and ( getPlayerFromName( playerName ) ) then
					spamProtect[localPlayer] = getTickCount()
					guiSetText( moneyGUI[4], "" )
					triggerServerEvent( "onTransferMoneyToPlayer", localPlayer, getPlayerFromName( playerName ), theMoney )
				else
					exports.DENdxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
				end
			else
				exports.DENdxmsg:createNewDxMessage( "You don't have enough money!", 225, 0, 0 )
			end
		end
	end
end