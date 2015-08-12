function onStart(res)
	if (getResourceName(res) == "CSGserverstate") then
		onServerStart()
		return
	end
	name = getResourceName(res)
	lType = "Resource"
	date = getDate()
	time = getTime()
	log = "Resource "..name.." started."
	post(log,lType,date,time)
end

function onStop(res)
	if (getResourceName(res) == "CSGserverstate") then
		onServerStop()
		return
	end
	name = getResourceName(res)
	lType = "Resource"
	date = getDate()
	time = getTime()
	log = "Resource "..name.." stopped."
	post(log,lType,date,time)
end
addEventHandler("onResourceStart",root,onStart)
addEventHandler("onResourceStop",root,onStop)

function onServerStart()
	log = "Server started."
	lType = "Server"
	date = getDate()
	time = getTime()
	post(log,lType,date,time)
end

function onServerStop()
	log = "Server stopped."
	lType = "Server"
	date = getDate()
	time = getTime()
	post(log,lType,date,time)
end

function post(log,lType,date,time)
	if log and not (log == "") and lType and not (lType == "") and date and not (date == "") and time and not (time == "") then
		exports.DENmysql:exec("INSERT INTO serverlog (log,type,date,time) VALUES (?,?,?,?)",log,lType,date,time)
		outputDebugString("[TRACKER] Sending log to database...",0,0,255,0)
	end
end


--[[
		- Handling functions below
		- Contains: getTime(), getDate()
--]]

function getDate()
	year,month,day = getRealTime().year+1900,getRealTime().month+1,getRealTime().monthday
	convertedString = year.."-"..month.."-"..day
	return convertedString
end

function getTime()
	if getRealTime().hour < 10 then
		hour = "0"..getRealTime().hour
	else
		hour = getRealTime().hour
	end
	
	if getRealTime().minute < 10 then
		minute = "0"..getRealTime().minute
	else
		minute = getRealTime().minute
	end
	
	if getRealTime().second < 10 then
		second = "0"..getRealTime().second
	else
		second = getRealTime().second
	end
	
	convertedString = hour..":"..minute..":"..second
	return convertedString
end
