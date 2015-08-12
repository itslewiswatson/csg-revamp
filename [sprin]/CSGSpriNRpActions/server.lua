en = true
function action(cmd, source)
	if cmd then
	if getElementZoneName(source, true) == "Las Venturas" then return end
			if isTimer(a) then killTimer(a) end
			a = setTimer(function () spam = 0 end,3000,1)
			x,y,z = getElementPosition(source)
		for i,v in pairs ( getElementsByType ( "player" ) ) do
			xx, yy, zz = getElementPosition(v)
			local distance = getDistanceBetweenPoints3D(x, y, z, xx, yy, zz)
			if (distance < 200) then
				if cmd == "lock" then
					if isPedInVehicle(source) then
						theVehicle = getPedOccupiedVehicle(source)
						if theVehicle then
							if isVehicleLocked(theVehicle) then
								outputChatBox("* " ..getPlayerName(source).. " unlocks his vehicle doors", v, 167, 0, 162)
							else
								outputChatBox("* " ..getPlayerName(source).. " locks his vehicle doors", v, 167, 0, 162)	
							end
						else
							for k,j in pairs(getElementsByType("vehicle")) do
								x1,y1,z1 = getElementPosition(j)
								local distance = getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
								if (distance < 30) then
									if isVehicleLocked(j) then
										outputChatBox("* " ..getPlayerName(source).. " unlocks his vehicle doors", v, 167, 0, 162)
									else
										outputChatBox("* " ..getPlayerName(source).. " locks his vehicle doors", v, 167, 0, 162)	
									end
								end
							end
						end
					end		
				elseif cmd == "lights" then
					if isPedInVehicle(source) then
						theVehicle = getPedOccupiedVehicle(source)
						if (getVehicleOverrideLights(theVehicle) ~= 2) then
							outputChatBox("* " ..getPlayerName(source).. " turns on his vehicle lights", v, 167, 0, 162)
						else
							outputChatBox("* " ..getPlayerName(source).. " turns off his vehicle lights", v, 167, 0, 162)
						end
					end	
				elseif cmd == "engine" then
					if isPedInVehicle(source) then
						theVehicle = getPedOccupiedVehicle(source)
						if (en == true) then
							outputChatBox("* " ..getPlayerName(source).. " turns off his vehicle engine", v, 167, 0, 162)
							en = false
						else
							outputChatBox("* " ..getPlayerName(source).. " turns on his vehicle engine", v, 167, 0, 162)
							en = true
						end
					end	
				elseif cmd == "gsc" then
					outputChatBox("* " ..getPlayerName(source).. " refuel his vehicle", v, 167, 0, 162)
				elseif cmd == "tire" then
					outputChatBox("* " ..getPlayerName(source).. " changes his vehicle tire", v, 167, 0, 162)
				elseif cmd == "smoke" then
					outputChatBox("* " ..getPlayerName(source).. " smoking", v, 167, 0, 162)
				elseif cmd == "drink" then
					outputChatBox("* " ..getPlayerName(source).. " drinking", v, 167, 0, 162)
				elseif cmd == "od" then
					if isPedInVehicle(source) then
						theVehicle = getPedOccupiedVehicle(source)
						if (getVehicleDoorState(theVehicle) == 2) then
							outputChatBox("* " ..getPlayerName(source).. " opens his vehicle door", v, 167, 0, 162)
						else
							outputChatBox("* " ..getPlayerName(source).. " closes his vehicle door", v, 167, 0, 162)
						end
					end	
				end
			end
		end
	end	
end
--addEventHandler("onPlayerCommand", root, action)


local commandSpam = {}
 
function preventCommandSpam(cmd)
	if (not commandSpam[source]) then
		commandSpam[source] = 1
		action(cmd, source)
		
	elseif (commandSpam[source] == 5) then
		cancelEvent()
		outputChatBox("Please refrain from command spamming!", source, 255, 0, 0)
	else
		commandSpam[source] = commandSpam[source] + 1
		action(cmd, source)
	end
end
addEventHandler("onPlayerCommand", root, preventCommandSpam)
setTimer(function() commandSpam = {} end, 1000, 0)