function ircc(thePlayer, cmd, user, ...)
    local text = table.concat( {...}, " " )
    local name = getPlayerName(thePlayer)
	local userr = exports.irc:ircGetUserFromNick(user)
	local server = exports.irc:ircGetUserServer(exports.irc:ircGetUserFromNick("ECHOBot"))
	if (userr) then
		if not (string.lower(tostring(user)) == "jack") then 
			exports.irc:ircRaw(server,"PRIVMSG " ..tostring(user).. " You recieved a private in game msg from " ..tostring(name))
			exports.irc:ircRaw(server,"PRIVMSG " ..tostring(user).. " msg: " ..tostring(text))
			exports.dendxmsg:createNewDxMessage(thePlayer,"Your message was sent to " ..tostring(user).. " on IRC",0,255,0)
		else
			exports.dendxmsg:createNewDxMessage(thePlayer,"YOU CAN'T PM Mr.Jack!",0,255,0)
		end	
	else
		exports.dendxmsg:createNewDxMessage(thePlayer,"Use /ircpm user msg !",0,255,0)
	end
end
addCommandHandler("ircpm",ircc) 
