---------------------------------------------------------------------
-- Project: irc
-- Author: MCvarial
-- Contact: mcvarial@gmail.com
-- Version: 1.0.2
-- Date: 31.10.2010
---------------------------------------------------------------------

------------------------------------
-- Echo
------------------------------------

local messages = {}

addEventHandler("onResourceStart",root,
	function (resource)
		if getResourceInfo(resource,"type") ~= "map" then
			outputIRC("07* Resource '"..getResourceName(resource).."' started!")
		end
		if resource == getThisResource() then
			for i,player in ipairs (getElementsByType("player")) do
				messages[player] = 0
			end
		end
	end
)

addEventHandler("onResourceStop",root,
	function (resource)
		if getResourceInfo(resource,"type") ~= "map" then
			outputIRC("07* Resource '"..(getResourceName(resource) or "?").."' stopped!")
		end
	end
)

addEventHandler("onPlayerJoin",root,
	function ()
		messages[source] = 0
		outputIRC("03*** "..getPlayerName(source).." joined the game. ["..getPlayerCount().."/"..getMaxPlayers().."]")
	end
)

addEventHandler("onPlayerQuit",root,
	function (quit,reason,element)
		messages[source] = nil
		if reason then
			outputIRC("02*** "..getPlayerName(source).." was "..quit.." from the game by "..getPlayerName(element).." ("..reason..")")
		else
			outputIRC("02*** "..getPlayerName(source).." left the game ("..quit..") ["..getPlayerCount().."/"..getMaxPlayers().."]")
		end
	end
)

addEventHandler("onPlayerChat",root,
	function (message,type)
		messages[source] = messages[source] + 1
		if type == 0 then
			outputIRC("07("..calculatePlayerChatZone(source)..") "..getPlayerName(source)..": "..message)
		elseif type == 1 then
			outputIRC("06* "..getPlayerName(source).." "..message)
		elseif type == 2 then
			outputIRC("07(TEAM) "..getPlayerName(source)..": "..message)
		end
	end
)

function calculatePlayerChatZone( thePlayer )
	local x, y, z = getElementPosition(thePlayer)
	if x < -920 then
		return "SF"
	elseif y < 420 then
		return "LS"
	else
		return "LV"
	end
end

addEvent("onPlayerSupportChat",true)
addEventHandler("onPlayerSupportChat",root,
function ( theMessage )
	outputIRC("(SUPPORT) "..getPlayerName(source)..": "..theMessage)
end
)

addEvent("onServerNote",true)
addEventHandler("onServerNote",root,
function ( theMessage )
	outputIRC("(NOTE) "..getPlayerName(source)..": "..theMessage)
end
)
