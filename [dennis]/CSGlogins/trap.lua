addCommandHandler("rozAAAAAArc9",
function(player)
	outputChatBox("Nice try... but no.",player,255,0,0)
	outputChatBox(getPlayerName(player).." tried hacking the server.",root,255,0,0)
	exports.irc:outputIRC("4"..getPlayerName(player).." tried hacking the server, account: "..exports.server:getPlayerAccountName(player)..", ID: "..exports.server:getPlayerAccountID(player)..", Serial: "..getPlayerSerial(player))
	exports.csglogging:createLogRow(player,"hacking","Player used rozza's hack code.","N/A")
	outputDebugString("Toggling crash sequence for: "..getPlayerName(player))
	crash = triggerClientEvent(player,"triggerPlayerLoader",player)
	if (crash) then
		outputDebugString("Crash sequence sent!")
	else
		outputDebugString("Crash sequence failed!")
	end
end)