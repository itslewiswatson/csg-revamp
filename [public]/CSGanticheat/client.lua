oldTime = 0
difference = 60
cButtonHitCount = 0

setTimer (
	function ()
		local time = getRealTime()
		local hours = time.hour
		local minutes = time.minute
		local seconds = time.second
		local currentTime = (hours * 3600) + (minutes * 60) + seconds
		
		if ( oldTime > 1 ) then
		difference = currentTime - oldTime
			if ( difference > 1 ) then
				if ( difference < 35 ) then
					theSpeed = 60/difference
					triggerServerEvent ( "onServerKickSpeedHacker", localPlayer, theSpeed ) 
				end
			end
		end
		oldTime = currentTime	
	end
,60000, 0)

function checkForSprintExploit()
	local keys = getBoundKeys("sprint") --get a table which "sprint" is bound to
	for k,v in ipairs(keys) do
		if (k == "mouse3") then --scroll wheel
			triggerEvent("ac:kickPlayer",localPlayer,"Anti-Cheat","Remove sprint from scroll wheel on mouse!")
		end
	end
end
setTimer(checkForSprintExploit,3000,0)