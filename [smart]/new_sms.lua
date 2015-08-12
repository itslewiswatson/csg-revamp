local smsSpam = {}

addEvent( "onPlayerSendSMS", true )
function onPlayerSendSMS ( theMessage, theReciever, thePlayer, sms )
	local source = source or thePlayer
	if ( isElement( source ) ) and ( isElement( theReciever ) ) then
		if ( exports.server:getPlayerAccountName ( source ) ) then
			if theMessage:match("^%s*$") then
				exports.DENdxmsg:createNewDxMessage(source, "You didn't enter a message!", 225, 0, 0)
			elseif ( smsSpam[source] ) and ( getTickCount()-smsSpam[source] < 1000 ) then
				exports.DENdxmsg:createNewDxMessage(source, "You are typing to fast! The limit is one message each second.", 200, 0, 0)
			elseif ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then
				exports.DENdxmsg:createNewDxMessage( source, "You are muted!", 236, 201, 0 )
			else
				if (theReciever == source) then exports.DENdxmsg:createNewDxMessage(source, "You can't send a SMS to yourself!", 200, 0, 0) return end
				smsSpam[source] = getTickCount()
				local sms = true
				local filterdString, nonFilterdString = exports.server:cleanStringFromBadWords( theMessage )
				
				if ( getElementData( theReciever, "SMSoutput" ) ) then
					outputChatBox("[PM FROM: ".. getPlayerName( source ) .. "]: "..filterdString, theReciever, 0, 225, 0)
				end
				
				local myString = "Me -> " .. getPlayerName( theReciever ) ..": ".. filterdString .."\n"
				local theString = "" .. getPlayerName( source ) .." -> Me: ".. filterdString .."\n"
				
				if ( sms ) then
					exports.DENdxmsg:createNewDxMessage(source, "Your SMS to " .. getPlayerName( theReciever ) .. " was sent!", 0, 225, 0)
				end
				
				local messageString1 = "Me -> " .. getPlayerName( theReciever ) ..": ".. nonFilterdString ..""
				local messageString2 = "" .. getPlayerName( source ) .." -> Me: ".. nonFilterdString ..""
				exports.CSGlogging:createLogRow ( source, "SMS", messageString1 )
				exports.CSGlogging:createLogRow ( theReciever, "SMS", messageString2 )

				triggerClientEvent( source, "onInsertSMSMemo", source, myString )
				triggerClientEvent( theReciever, "onInsertSMSMemo", theReciever, theString, source )
			end
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