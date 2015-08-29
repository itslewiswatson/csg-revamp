-- Counter to keep an eye on how many queries are being processed
totalQuerysRan = 0

-- Enter your database information here (I highly recommend using MySQL for your database)
local dbType, dbName, dbHost, dbUsr, dbPass = "mysql", "mta", "127.0.0.1", "root", ""

-- This is our connection variable
local sql = dbConnect(dbType, "dbname="..dbName..";host="..dbHost, dbUsr, dbPass)

-- 'Master' function to determine whether we are connected to the db or not
function getConnection()
	return sql
end

-- Let's get our connection when we start
function onResourceStart()
	local dbConnection = getConnection()
	-- If we don't have connection, let debug know
	if (not dbConnection) then
		outputDebugString("[MySQL] Connection to database failed")
	else
	-- Yay, we have connection
		outputDebugString("[MySQL] Connection to database successful")
	end
end
addEventHandler("onResourceStart", resourceRoot, onResourceStart)

function query(...)
    if isElement(sql) then
        local qh = dbQuery(sql, ...)
		totalQuerysRan = totalQuerysRan + 1
        return dbPoll(qh, -1)
    end
	return false
end

function querySingle(str,...)
	if not str:find("LIMIT 1") then
		str = str.." LIMIT 1"
	end
	local result = query(str, ...)
	if result then
		return result[1]
	end
	return false
end

function exec(str, ...)
	if isElement(sql) then
		totalQuerysRan = totalQuerysRan + 1
		return dbExec(sql, str, ...)
	end
	return false
end

function doesColumnExist(aTable, column)
	local theTable = query("DESCRIBE `??`", aTable)
	if theTable then
		for k, v in ipairs(theTable) do
			if v.Field == column then
				return true
			end
		end
	end
	return false
end

function creatColumn(aTable,aColumn,aType)
	if aTable and column and aType then
		return exec("ALTER TABLE `??` ADD `??` ??", aTable, aColumn, aType)
	end
end

function outputTotal(ifReset)
	outputDebugString("[DENmysql] Total querys ran in total from the past 5 minutes: "..totalQuerysRan)
	if (ifReset == true) then
		totalQuerysRan = 0
	end
end
setTimer(outputTotal, 60000 * 5, 0, true)
addCommandHandler("outputTotal", outputTotal, false, false)