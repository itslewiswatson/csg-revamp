function disableChat(message,type)
	if (type == 0) then
		outputChatBox("Chat is disabled!",source,255,0,0)
		cancelEvent()
	end
end
addEventHandler("onPlayerChat",root,disableChat)