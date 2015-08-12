------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithsNote/server (server-side)
--  Note system
--  Smith
------------------------------------------------------------------------------------

function outputServersNote(player,text11,text21)
	triggerClientEvent(player,"OutputsNote",root,text11,text21)
end

function adminnote(thePlayer,commandName,...)
	if "gusolina" == exports.server:getPlayerAccountName(thePlayer) or "jockedabaws" == exports.server:getPlayerAccountName(thePlayer) then
		local noteWords = { ... }
		local noteMessage = table.concat( noteWords, " " )
		outputServersNote(getRootElement(),"* * *  NOTE  * * *",noteMessage .. " [by "..getPlayerName(thePlayer).."]")
	end
end
addCommandHandler("snote", adminnote)

function getPlayerFromParticalName(thePlayerName)
	local thePlayer = getPlayerFromName(thePlayerName)
	if thePlayer then
		return thePlayer
	end
	for _,thePlayer in ipairs(getElementsByType("player")) do
		if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), thePlayerName:lower(), 1, true) then
			return thePlayer
		end
	end
return false
end

function shoutMSG(thePlayer,commandName,sendToName,...)
	local shoutWords = { ... }
	local shoutMessage = table.concat( shoutWords, " " )

	if exports.csgstaff:isPlayerStaff(thePlayer) then
	else
		return
	end

	if sendToName then
		if (getPlayerFromParticalName (sendToName)) then

			toPlayer = (getPlayerFromParticalName (sendToName))

				if not (pmMessage == "") then
					outputServersNote(toPlayer,"SHOUTED by "..getPlayerName(thePlayer),shoutMessage)
					outputChatBox("SHOUT: You have successfuly shouted #FFFFFF" .. getPlayerName(toPlayer) .. ".", thePlayer, 0, 255, 0, true)
				else
					outputChatBox("SHOUT: Invalid syntax! Usage:#FFFFFF /shout <particalname> <message>", thePlayer, 255, 0, 0, true)
					return false
				end
		else
			outputChatBox("SHOUT: Player not found!(#FFFF00"..sendToName.."#FF0000)", thePlayer, 255, 0, 0, true)
			return false
		end
	else
		outputChatBox("SHOUT: Invalid syntax! Usage:#FFFFFF /shout <particalname> <message>", thePlayer, 255, 0, 0, true)
					return false
	end
end
addCommandHandler("shout", shoutMSG)
