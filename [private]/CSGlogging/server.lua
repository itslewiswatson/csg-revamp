-- Get the time from a log
function getCurrentTime ()
	local time = getRealTime()
	local year, month, day, hours, mins, secs = time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second
	
	if (month < 10) then
		month = "0" .. month
	end
	
	if (day < 10) then
		day = "0" .. day
	end
	
	if (hours < 10) then
		hours = "0" .. hours
	end
	
	if (mins < 10) then
		mins = "0" .. mins
	end
	
	if (secs < 10) then
		secs = "0" .. secs
	end
	
	aTime = day .. "-" .. month .. "-" .. year
	aDate = hours .. ":" .. mins .. ":" .. secs
	return aTime, aDate, time.timestamp
end

-- Create a new log
function createLogRow(thePlayer, theType, theAction, theType2)
	if (isElement(thePlayer)) then
		if (exports.server:getPlayerAccountName(thePlayer)) then theAccount = (exports.server:getPlayerAccountName(thePlayer)) else theAccount = "NONE_ACCOUNT" end
		local aTime, aDate, aTimestamp = getCurrentTime ()
		local theType2 = theType2 or "N/A"
		exports.DENmysql:exec("INSERT INTO `logs` SET `player`=?, `account`=?, `type`=?, `type2`=?, `timestamp`=?, `date`=?, `time`=?, `action`=?, `serial`=?",
			getPlayerName(thePlayer),
			theAccount,
			theType,
			theType2,
			aTimestamp,
			aDate,
			aTime,
			theAction,
			getPlayerSerial(thePlayer)
		)
		return true
	else
		return false
	end
end

-- Create a new staff log
function createAdminLogRow(thePlayer, theAction)
	if (isElement(thePlayer)) then
		if (exports.server:getPlayerAccountName(thePlayer)) then theAccount = (exports.server:getPlayerAccountName(thePlayer)) else theAccount = "NONE_ACCOUNT" end
		local aTime, aDate, aTimestamp = getCurrentTime()
		exports.DENmysql:exec("INSERT INTO `adminlog` SET `player`=?, `account`=?, `timestamp`=?, `date`=?, `time`=?, `action`=?, `serial`=?",
			getPlayerName(thePlayer),
			theAccount,
			aTimestamp,
			aDate,
			aTime,
			theAction,
			getPlayerSerial(thePlayer)
		)
		return true
	else
		return false
	end
end
