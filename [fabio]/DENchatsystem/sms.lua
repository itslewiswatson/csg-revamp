local smsSpam = {}

addEvent( "onPlayerSendSMS", true )
function onPlayerSendSMS ( theMessage, theReciever, thePlayer, sms )
	local source = source or thePlayer
	if ( isElement( source ) ) and ( isElement( theReciever ) ) then
		if ( source ~= theReciever ) then
			if ( exports.server:getPlayerAccountName ( source ) ) then
				if theMessage:match("^%s*$") then
					exports.DENdxmsg:createNewDxMessage(source, "You didn't enter a message!", 225, 0, 0)
				elseif ( smsSpam[source] ) and ( getTickCount()-smsSpam[source] < 1000 ) then
					exports.DENdxmsg:createNewDxMessage(source, "You are typing too fast! The limit is one message each second.", 200, 0, 0)
				elseif ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then
					exports.DENdxmsg:createNewDxMessage( source, "You are muted!", 236, 201, 0 )
				elseif ( getElementData(theReciever,"PlayerIsBusy") and not exports.CSGstaff:isPlayerStaff(source) ) then -- if target is busy and sender isn't staff ( they need to sms for staff purposes )
					exports.DENdxmsg:createNewDxMessage( source, "This player is busy!", 236, 201, 0 )
				else
					smsSpam[source] = getTickCount()

					local logStringSender = " -> " .. getPlayerName( theReciever ) ..": ".. theMessage
					local logStringReceiver = getPlayerName( source ) .." -> Me: ".. theMessage
					exports.CSGlogging:createLogRow ( source, "SMS", logStringSender )
					exports.CSGlogging:createLogRow ( theReciever, "SMS", logStringReceiver )

					triggerClientEvent( theReciever, "onReceiveSMS", source, theMessage ) -- validate on receiver, that sender is not blacklisted
				end
			end
		else
			exports.DENdxmsg:createNewDxMessage( source, "You can't SMS yourself!", 255, 0, 0 )
		end
	end
end
addEventHandler( "onPlayerSendSMS", root, onPlayerSendSMS )

function onPlayerQuickSMS ( playerSource, commandName, reciever, ... )
	if ( playerSource ) and ( reciever ) then
		if ( exports.server:getPlayerAccountName ( playerSource ) ) then
			local arg = {...}
			local theMessage = table.concat({...}, " ")
			local theReciever = exports.server:getPlayerFromNamePart( reciever )
			if ( theReciever ) then
				onPlayerSendSMS ( theMessage, theReciever, playerSource, false )
			else
				exports.DENdxmsg:createNewDxMessage(playerSource, "We couldn't find a player with that name! Be more specific.", 225, 0, 0)
			end
		end
	end
end
addCommandHandler ( "sms", onPlayerQuickSMS )

addEvent("smsSuccess",true)
addEvent("smsBlocked",true)
addEventHandler("smsSuccess",root,
	function (sender,message)
		local memoMessage = "Me -> "..getPlayerName( source )..": ".. message .."\n"
		exports.DENdxmsg:createNewDxMessage(sender, "SMS to "..getPlayerName(source).." sent!", 0, 255, 0)
		triggerClientEvent( sender, "onInsertSMSMemo", source, memoMessage, sender ) -- insert sms in sender's memo
		if ( getElementData( sender, "SMSoutput" ) ) then
			local chatboxMessage = "[PM TO: ".. getPlayerName( source ) .. "]: "..message 
			outputChatBox(chatboxMessage, sender, 0, 225, 0) -- output sms to sender's chatbox, if enabled
		end
	end
)
addEventHandler("smsBlocked",root,
	function (sender)
		exports.DENdxmsg:createNewDxMessage(sender, getPlayerName(source).." has blacklisted you. You can not send him a SMS.", 225, 0, 0) -- let sender know it failed
	end
)

--

function toggleBusy(player)
    local busy = getElementData(player,"PlayerIsBusy")
    if busy then            
		setElementData(player, "PlayerIsBusy", false)
		exports.dendxmsg:createNewDxMessage(player, "Busy Mode: Off", 255, 0, 0)
    else
		setElementData(player, "PlayerIsBusy", true)
		exports.dendxmsg:createNewDxMessage(player, "Busy Mode: On", 0, 255, 0)
    end
end
addCommandHandler("busy",toggleBusy)

