function changeWeather(cmd,id)
	if (id ~= "") then
		local _id = tonumber(id)
		if (type(_id) == "number") then
			if (_id >= 0) and (_id <= 53) then
				setWeather(_id)
				exports.dendxmsg:createNewDxMessage("Weather changed!",0,255,0,true)
			else
				xports.dendxmsg:createNewDxMessage("Invalid weather id! number 0 to 53!",255,0,0)
			end
		else
			xports.dendxmsg:createNewDxMessage("Number only!",255,0,0)
		end
	else
		xports.dendxmsg:createNewDxMessage("Syntax: /weather [id]",255,0,0)
	end
end
addCommandHandler("weather",changeWeather)
