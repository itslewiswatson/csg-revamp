listenTimer = false

function listenForHighUsage()
	local time,_usage = getPerformanceStats("Lua timing")
	for k,v in ipairs(_usage) do
		local usage = string.gsub(v[2],"[^0-9]","") or 0
		if (usage ~= nil) then
			local usage = math.floor(tonumber(usage))
			if (tonumber(usage) > 50) then --above 50% CPU usage
				outputChatBox("Resource: "..v[1].." using high CPU usage! ("..usage.."%)",255,0,0,true)
				outputChatBox("Report this to a Leading Developer!",255,0,0,true)
			end
		end
	end
end

function startListening(cmd,state)
	if (state == "on") then
		if (isTimer(listenTimer)) then
			killTimer(listenTimer)
		end
		listenTimer = setTimer(listenForHighUsage,1000,0)
		outputChatBox("Watching for lagg...",0,255,0,true)
	elseif (state == "off") then
		if (isTimer(listneTimer)) then
			killTimer(listenTimer)
		end
		outputChatBox("Stopped watching for lagg.",255,0,0,true)
	else
		outputChatBox("Syntax: /checklagg on/off",255,0,0,true)
	end
end
addCommandHandler("checklagg",startListening)