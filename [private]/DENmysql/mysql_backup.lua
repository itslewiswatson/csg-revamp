-- The connection element
crash = {{{{{{{{ {}, {}, {} }}}}}}}}
local connection = false
local pass = "d26LCqCLXfJeEzqd"
local totalQuerys = 0
local totalQuerysRan = 0
local waitTimer = -1
-- When the resource stats create a connection
addEventHandler ( "onResourceStart", getResourceRootElement( getThisResource () ),
	function ()
		connection = dbConnect( "mysql", "dbname=mta;host=127.0.0.1;port=3306;unix_socket=/var/run/mysqld/mysqld.sock", "mta", pass )
		if ( connection ) then
			outputConsole ( "Server is now connected with the MySQL database!", 1 )
			return true
		else
			outputConsole ( "Connection with the MySQL database failed!", 1 )
			return false
		end
	end
)

-- Get the MySQL connection element
function getConnection ()
	if ( connection ) then
		return connection
	else
		return false
	end
end

-- Get a MySQL query
function query ( ... )
    if ( connection ) then
        local qh = dbQuery( connection, ... )
        local result = dbPoll( qh,waitTimer)
		totalQuerysRan = totalQuerysRan + 1
        return result
    else
        return false
    end
end

-- Get a single row from the database
function querySingle ( str, ... )
	if ( connection ) then
		local qh = dbQuery( connection, str, ... )
		local result = dbPoll(qh,waitTimer)
		if ( type( result ) == 'table' ) then
			totalQuerysRan = totalQuerysRan + 1
			return result[1]
		else
			totalQuerysRan = totalQuerysRan + 1
			return result
		end
	else
		return false
	end
end

-- MySQL database execute
function exec ( str, ... )
	if ( connection ) then
		local qh = dbExec( connection, str, ... )
		totalQuerysRan = totalQuerysRan + 1
		return qh
	else
		return false
	end
end

-- Check if a column exists
function doesColumnExist ( aTable, column )
	local theTable = query ( "DESCRIBE `??`", aTable )
	if ( theTable ) then
		for k, aColumn in ipairs ( theTable ) do
			if ( aColumn.Field == column ) then
				return true
			end
		end
		return false
	else
		return false
	end
end

-- Function that creates a column
function creatColumn ( aTable, aColumn, aType )
	if ( aTable ) and ( column ) and ( aType ) then
		exec ( "ALTER TABLE `??` ADD `??` ??", aTable, aColumn, aType )
		return true
	else
		return false
	end
end

function outputTotal(ifReset)
	outputDebugString("[MYSQL] Total querys ran in total from the past 5 minute: "..totalQuerysRan)
	if (ifReset == true) then
		totalQuerysRan = 0
	end
end
setTimer(outputTotal,60000*5,0,true)
addCommandHandler("outputTotal",outputTotal)
