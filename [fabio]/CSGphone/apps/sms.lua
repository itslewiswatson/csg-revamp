local SMSGUI = {}
local reciever
local playersColumn
local friendColumn
local lastSender
local playerIsAFK
local unreadMessages = {}
local AFKTime = 120*1000
local setAFKTimer
local outputSMS = exports.DENsettings:getPlayerSetting('smschatbox')
local SMSnotification = exports.DENsettings:getPlayerSetting('smsnotification')
local SMSringtone = exports.DENsettings:getPlayerSetting('smsringtone')
local SMSringtoneNumber = exports.DENsettings:getPlayerSetting('smsringtonenumber')
outputSMS=true
setElementData(localPlayer,"SMSoutput",outputSMS)
if not SMSringtoneNumber then exports.DENsettings:addPlayerSetting("smsringtonenumber", "1") SMSringtoneNumber = 1 end

addEvent( "onPlayerSettingChange" )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, state )
		if setting == 'smschatbox' then
			outputSMS = state
			setElementData(localPlayer,"SMSoutput",state)
		elseif setting == 'smsnotification' then
			SMSnotification = state
		elseif setting == 'smsringtone' then
			SMSringtone = state
		elseif setting == 'smsringtonenumber' then
			SMSringtoneNumber = state
		end
	end, false
)

function replySMS(cmdName,...)
	if isElement(lastSender) then
		local arg = {...}
		local allMessages = tostring( table.concat( arg, " " ) )
		exports.DENchatsystem:onPlayerSendSMS(localPlayer, allMessages, lastSender)
		local newMessages = {}
		for i=1,#unreadMessages do
			if unreadMessages[i] ~= lastSender then
				table.insert(newMessages,unreadMessages[i])
			end
		end
		unreadMessages = newMessages
	else
		exports.DENdxmsg:createNewDxMessage("You have not recieved a SMS or the player left!",255, 0, 0)
	end

end

addCommandHandler ( 'r', replySMS)
addCommandHandler ( 'reply', replySMS)

function drawUnreadMessages ()

	if not SMSnotification then return end

	if #unreadMessages >= 1 then

		local x,y,width,height = (1120/1440)*sW, (205/900)*sH, (330/1920)*sW, 30
		dxDrawRectangle( x,y, width, height, tocolor( 0,0,0,200 ) )
		dxDrawImage(x+10,y+5,30,20,"icons\\unreadSMS.png" )
		dxDrawText("Unread messages. ( "..tostring(#unreadMessages).." )", x+40,y, x+width, y+height, tocolor( 0,200,0 ), 1, 'default','center','center' )

	end

end
addEventHandler( 'onClientRender', root, drawUnreadMessages )

function setPlayerAFK()

	playerIsAFK = true
	if isTimer( setAFKTimer ) then killTimer(setAFKTimer) end

end

	setAFKTimer = setTimer( setPlayerAFK, AFKTime, 0 )

function cancelAFK()

	if isTimer( setAFKTimer ) then killTimer(setAFKTimer) end
	setAFKTimer = setTimer( setPlayerAFK, AFKTime, 0 )
	playerIsAFK = false

end

addEventHandler( "onClientKey", root, cancelAFK )

function fillSMSPlayerGrid()
guiGridListClear ( SMSGUI[6] )
local friendTable = exports.DENsettings:getPlayerFriends()
local players = getElementsByType('player')
local onlyFriends = guiCheckBoxGetSelected ( SMSGUI[2] )
	for i=1, #players do
		if isElement(players[i]) and players[i] ~= localPlayer then
			if ( not onlyFriends ) or isPlayerFriend(friendTable, players[i]) then
				local pRow = guiGridListAddRow ( SMSGUI[6] )
				guiGridListSetItemText ( SMSGUI[6], pRow, 1, getPlayerName(players[i]), false, false )
				guiGridListSetItemData ( SMSGUI[6], pRow, 1, players[i] )
				local friends = "No"
				if isPlayerFriend(friendTable, players[i]) then
					friends = "Yes"
				end
				guiGridListSetItemText ( SMSGUI[6], pRow, 2, friends, false, false )
			end
		end
	end
end


addEventHandler ( 'onClientResourceStart', getResourceRootElement(getThisResource()),
function ()

	apps[2][7] = false
	apps[2][8] = openSMS
	apps[2][9] = closeSMS

	-- send button
	SMSGUI[1] = guiCreateButton(BGX+(0.7330470085144*BGWidth),BGY+(0.92585468292236*BGHeight),0.26420080661774*BGWidth,0.066704228520393*BGHeight,"Send",false)
	-- friend checkbox
	SMSGUI[2] = guiCreateCheckBox(BGX+(BGWidth)-90,BGY+(0.50962030887604*BGHeight),90,0.056031551212072*BGHeight,"Friends only",false,false)
	-- messages memo
	SMSGUI[3] = guiCreateMemo(BGX+(0.0064947726204991*BGWidth),BGY+(0.0026681690942496*BGHeight),0.99422937631607*BGWidth,0.50428396463394*BGHeight,"",false)
	guiMemoSetReadOnly ( SMSGUI[3], true )
	-- find players edit
	SMSGUI[4] = guiCreateEdit(BGX+(0.0030184460338205*BGWidth),BGY+(0.50695210695267*BGHeight),BGWidth-90,0.064036056399345*BGHeight,"",false)
	-- send msg edit
	SMSGUI[5] = guiCreateEdit(BGX+(0.0030184460338205*BGWidth),BGY+(0.92585468292236*BGHeight),0.73002856969833*BGWidth,0.069372393190861*BGHeight,"",false)
	guiEditSetMaxLength(SMSGUI[5],100)
	-- playersgrid
	SMSGUI[6] = guiCreateGridList(BGX,BGY+(0.5736563205719*BGHeight),0.99770569801331*BGWidth,0.34686198830605*BGHeight,false)
	playersColumn = guiGridListAddColumn ( SMSGUI[6], "Players:", 0.66 )
	friendColumn = guiGridListAddColumn ( SMSGUI[6], "Friend:", 0.2 )
	guiGridListSetSelectionMode(SMSGUI[6],0)
	fillSMSPlayerGrid()

	for i=1,#SMSGUI do

		guiSetVisible(SMSGUI[i],false)
	end

	addEvent ( "onInsertSMSMemo", true )
	addEventHandler ( "onInsertSMSMemo", root, onSMSRecieve )

end
)

function openSMS()

	for i=1,#SMSGUI do

		guiSetVisible(SMSGUI[i],true)
		guiSetProperty( SMSGUI[i], "AlwaysOnTop", "True" )

	end

	addEventHandler ( "onClientGUIClick", root, onSMSClick )
	addEventHandler ( "onClientGUIAccepted", SMSGUI[5], onSMSSend, false )
	addEventHandler ( "onClientGUIChanged", SMSGUI[4], onSMSChangeSearchBox, false )
	addEventHandler ( "onClientPlayerJoin", root, onSMSPlayerJoin )
	addEventHandler ( "onClientPlayerQuit", root, onSMSPlayerQuit )

	fillSMSPlayerGrid()
	unreadMessages = {}

	apps[2][7] = true
end

function closeSMS()

	for i=1,#SMSGUI do

		guiSetVisible(SMSGUI[i],false)
		guiSetProperty( SMSGUI[i], "AlwaysOnTop", "False" )

	end

	removeEventHandler ( "onClientGUIClick", root, onSMSClick )
	removeEventHandler ( "onClientGUIAccepted", SMSGUI[5], onSMSSend, false )
	removeEventHandler ( "onClientGUIChanged", SMSGUI[4], onSMSChangeSearchBox, false )
	removeEventHandler ( "onClientPlayerJoin", root, onSMSPlayerJoin )
	removeEventHandler ( "onClientPlayerQuit", root, onSMSPlayerQuit )
	apps[2][7] = false

end

function onSMSChangeSearchBox()
local friendTable = exports.DENsettings:getPlayerFriends()
local onlyFriends = guiCheckBoxGetSelected ( SMSGUI[2] )

	if guiGetText ( SMSGUI[4] ) ~= "" then
		guiGridListClear ( SMSGUI[6] )
		local players = getElementsByType('player')
			for i=1, #players do
				if isElement(players[i]) and players[i] ~= localPlayer then

					if string.find(string.lower(getPlayerName(players[i])), string.lower(guiGetText ( SMSGUI[4] ) )) then

						if ( not onlyFriends ) or isPlayerFriend(friendTable, players[i]) then

							local pRow = guiGridListAddRow ( SMSGUI[6] )
							guiGridListSetItemText ( SMSGUI[6], pRow, 1, getPlayerName(players[i]), false, false )
							local friends = "No"
								if friendTable[getPlayerName(players[i])] then
									friends = "Yes"
								end
							guiGridListSetItemText ( SMSGUI[6], pRow, 2, friends, false, false )
						end

					end

				end

			end

	else
		fillSMSPlayerGrid()
	end

end

function onSMSClick ()
	if source == SMSGUI[1] then
		onSMSSend()
	elseif source == SMSGUI[2] then
		fillSMSPlayerGrid()
	end
end

function onSMSSend ()
	if guiGetText ( SMSGUI[5] ) then
		local playerName = guiGridListGetItemText ( SMSGUI[6], guiGridListGetSelectedItem ( SMSGUI[6] ), 1 )
		if ( playerName ) and ( getPlayerFromName( playerName ) ) then
			triggerServerEvent( "onPlayerSendSMS", localPlayer, guiGetText ( SMSGUI[5] ), getPlayerFromName(playerName))
			guiSetText ( SMSGUI[5], "" )
		end
	end
end

function onSMSRecieve(theString, sender)
	if theString then
		guiSetText ( SMSGUI[3], theString .. guiGetText ( SMSGUI[3] ) )
		if sender and sender ~= localPlayer then
			lastSender = sender
			if playerIsAFK then
				table.insert(unreadMessages,sender)
			end
			if SMSringtone then playSound("apps\\ringtones\\"..tostring(SMSringtoneNumber)..".mp3") end
		end
	end
end

function onSMSPlayerJoin ()
local friendTable = exports.DENsettings:getPlayerFriends()
local onlyFriends = guiCheckBoxGetSelected(SMSGUI[2])
	if ( not onlyFriend ) or isPlayerFriend(friendTable, source) then
		local pRow = guiGridListAddRow ( SMSGUI[6] )
		guiGridListSetItemText ( SMSGUI[6], pRow, 1, getPlayerName(source), false, false )
		guiGridListSetItemData ( SMSGUI[6], pRow, 1, source )
		local friends = "No"
			if isPlayerFriend(friendTable, source) then
				friends = "Yes"
			end
		guiGridListSetItemText ( SMSGUI[6], pRow, 2, friends, false, false )
	end
end

function onSMSPlayerQuit ()
	for i=1,guiGridListGetRowCount(SMSGUI[6]) do
		if guiGridListGetItemText ( SMSGUI[6], i, playerColumn ) == getPlayerName(source) then
			guiGridListRemoveRow ( SMSGUI[6], i )
		end
	end
	if source == lastSender then lastSender = nil end
end
