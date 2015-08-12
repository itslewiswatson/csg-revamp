_resroot = getResourceRootElement ( getThisResource ( ) )

function isPlayerInTeam(src, TeamName)
	if src and isElement ( src ) and getElementType ( src ) == "player" then
		local team = getPlayerTeam(src)
		if team then
			if getTeamName(team) == TeamName then
				return true
			else
				return false
			end
		end
	end
end



addEventHandler ( "onResourceStart" , _resroot , 
	function ( )
		local file = fileOpen("speedlogs.txt") 
		
		if not file then
			file = fileCreate("speedlogs.txt")
			outputDebugString("AntiSpeedHack: Creating speedlogs.txt")
		end
	end
)

addEvent("speedlogs",true)
function speedlogs(text)
	OutputGUIToFile(text)
	return "true: added text '"..text.."'"
end
addEventHandler( "speedlogs", getRootElement(), speedlogs )


function OutputGUIToFile(text)
	local file = fileOpen("speedlogs.txt") 
	
	if not file then
		file = fileCreate("speedlogs.txt")
		outputDebugString("AntiSpeedHack: Creating speedlogs.txt")
	end
    
	if file then    
		local time = getRealTime()
	
		fileSetPos(file,fileGetSize(file))
		local written = fileWrite(file,"",string.format("[%02s/%02s/%04s %02s:%02s.%02s] ",
						tostring(time.monthday),
						tostring(time.month+1),
						tostring(time.year+1900),
						tostring(time.hour),
						tostring(time.minute),
						tostring(time.second)),		
						text,"\n")
		fileFlush(file)
		fileClose(file)
		
		if written then
			outputDebugString("AntiSpeedHack: Succesfully saved to logs!")
		end
	else
		outputDebugString("AntiSpeedHack: Cannot find or create speedlogs.txt")
	end
end

function gamespeedvalue ( )
    local speed = getGameSpeed ( )
	for k,v in ipairs(getElementsByType("player")) do
		if isPlayerInTeam(v, "Staff") then
			exports.killmessages:outputMessage("Test: => "..speed.." <=", v, 250, 0, 0,"default-bold")
		end
	end
end
addCommandHandler ( "oops", gamespeedvalue )