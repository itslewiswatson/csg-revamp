local antiCheatTable = {}
local antiExploitTable = {}
local cHitCounts = {}

addEvent( "onServerKickSpeedHacker", true )
addEventHandler( "onServerKickSpeedHacker", root,
	function ( theSpeed )
		if ( antiCheatTable[getPlayerSerial(source)] ) then
			antiCheatTable[getPlayerSerial(source)] = antiCheatTable[getPlayerSerial(source)] +1
			if ( antiCheatTable[getPlayerSerial(source)] >= 3 ) then
				outputChatBox( "[ANTI CHEAT] " .. getPlayerName ( source ) .. " has been permanently banned for using a speedhack 3 or more times!", root, 225, 0, 0 )
				exports.DENmysql:exec( "INSERT INTO bans SET serial=?, account=?, reason=?, banstamp=?, bannedby=?", getPlayerSerial( source ), exports.server:getPlayerAccountName( source ), theReason, theTime, theBanner )
				kickPlayer ( source, "Speedhack detected for the 3rd time, permanently banned!" )
			else
				outputChatBox( "[ANTI CHEAT] " .. getPlayerName ( source ) .. " possibly used a speedhack, user has been kicked!", root, 225, 0, 0 )
				kickPlayer ( source, "Speedhack detected for the 3rd time, permanently banned!" )
			end
		else
			antiCheatTable[getPlayerSerial(source)] = 1
			outputChatBox( "[ANTI CHEAT] " .. getPlayerName ( source ) .. " possibly used a speedhack, user has been kicked!", root, 225, 0, 0 )
			kickPlayer ( source, "Speedhack detected! Turn off your speedhack." )
		end
	end
)

addEvent("ac:kickPlayer",true)
addEventHandler("ac:kickPlayer",root,
function(kicker,kickReason)
	kickPlayer(source,tostring(kicker),tostring(kickReason))
end)