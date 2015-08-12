 addCommandHandler("rolldice",function(ps)
	if getTeamName(getPlayerTeam(ps)) == "Staff" then
		x,y,z = getElementPosition(ps)
		for k,v in pairs(getElementsByType("player")) do
			x2,y2,z2 = getElementPosition(v)
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) <= 300 then
				exports.CSGsmithsdx:addTextNotification(v,"Rolling Dice...",0,255,0)
			end
		end
		local i = math.random(1,4)
		setTimer(function()
			for k,v in pairs(getElementsByType("player")) do
				x2,y2,z2 = getElementPosition(v)
				if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) <= 300 then
					exports.CSGsmithsdx:addTextNotification(v,"Dice: "..i.."",0,255,0)
				end
			end
		end,5000,1)
	end
 end)
