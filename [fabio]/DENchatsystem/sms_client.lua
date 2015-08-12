addEvent('onReceiveSMS',true)
addEventHandler('onReceiveSMS',root,
	function (pMessage)
		local memoMessage = getPlayerName( source ) .." -> Me: ".. pMessage .."\n"
		local chatBoxMessage = "[PM FROM: ".. getPlayerName( source ) .. "]: "..pMessage
		if not ( exports.densettings:isPlayerBlacklisted(source) ) then -- if sender is not blacklisted
			if ( getElementData( localPlayer, "SMSoutput" ) ) then outputChatBox(chatBoxMessage,0,255,0) end -- output chatbox if enabled
			triggerEvent('onInsertSMSMemo',source,memoMessage,source) -- add sms to memo
			triggerServerEvent('smsSuccess',localPlayer,source,pMessage) -- let server know it succeeded
		else
			triggerServerEvent('smsBlocked',localPlayer,source) -- let server know it failed
		end
	end
)