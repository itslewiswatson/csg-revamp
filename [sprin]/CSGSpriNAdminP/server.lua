--check serial
function protect( )
	acc = exports.server:getPlayerAccountName(source)
	local data = exports.DENmysql:query( "SELECT serial,serial2,serial3 FROM protection WHERE account=? LIMIT 1", acc)
	if data and data[1] then
		local playerSerial = getPlayerSerial ( source )
		local aSerial = tostring(data[1].serial)
		local aSerial2 = tostring(data[1].serial2)
		local aSerial3 = tostring(data[1].serial3)
		if (aSerial ~= false) and (aSerial2 ~= false) and (aSerial3 ~= false) then
			if (playerSerial ~= aSerial) then
				if (playerSerial ~= aSerial2) then
					if (playerSerial ~= aSerial3) then
						kickPlayer ( source, 'Account Protected' )
					end
				end
			end
		elseif (aSerial ~= false) and (aSerial2 ~= false) and (aSerial3 == false) then
			if (playerSerial ~= aSerial) then
				if (playerSerial ~= aSerial2) then
					kickPlayer ( source, 'Account Protected' )
				end
			end
		elseif (aSerial ~= false) and (aSerial2 == false) and (aSerial3 ~= false) then
			if (playerSerial ~= aSerial) then
				if (playerSerial ~= aSerial3) then
					kickPlayer ( source, 'Account Protected' )
				end
			end
		elseif (aSerial ~= false) and (aSerial2 == false) and (aSerial3 == false) then
			if (playerSerial ~= aSerial) then
				kickPlayer ( source, 'Account Protected' )
			end
		end
	end
end
addEventHandler ( 'onPlayerLogin', getRootElement(), protect)

--add Protection
addEvent("add", true)
function add(account, serial)
	if string.len(account) >= 2 then
		if string.len(serial) == 32 then
			local data = exports.DENmysql:querySingle( "SELECT * FROM protection WHERE account=? ",account)
			if data then
				if (string.len(tostring(data.serial)) == 32) and not(data.serial2) then
					p = exports.DENmysql:exec("UPDATE protection SET account = ?, serial2 = ?", account, serial)
					if p then
						outputChatBox(getPlayerName(source).. " added protection on account " ..account, source, 0, 255,0)
					end	
				elseif 	(string.len(tostring(data.serial)) == 32) and (string.len(tostring(data.serial2)) == 32) and not(data.serial3) then
					p = exports.DENmysql:exec("UPDATE protection SET account = ?, serial3 = ?", account, serial)
					if p then
						outputChatBox(getPlayerName(source).. " added protection on account " ..account, source, 0, 255,0)
					end	
				end	
			else
				s = exports.DENmysql:exec("INSERT INTO protection SET account = ?, serial = ?", account, serial)
				if s then
					outputChatBox(getPlayerName(source).. " added protection on account " ..account, source, 0, 255,0)
				end
			end	
		else
			outputChatBox("enter a correct serial",source, 255, 0, 0)
		end
	else
		outputChatBox("enter a correct account name",source, 255, 0, 0)
	end
end
addEventHandler("add", getRootElement(), add)

--Remove Protection
addEvent("del", true)
function del(account, serial)
	if (account) and (not serial) then
		d = exports.DENmysql:exec("DELETE FROM protection WHERE account = ?",account)
		if d then
			outputChatBox(getPlayerName(source).. " deleted protection on account " ..account, source, 0, 255,0)
		end	
	elseif (account) and (serial) then
		local data = exports.DENmysql:querySingle( "SELECT * FROM protection WHERE account=? ", account)
			if (data.serial == serial) then
				exports.DENmysql:exec("UPDATE protection SET serial = NULL WHERE account = ?",account)
			elseif (data.serial2 == serial) then
				exports.DENmysql:exec("UPDATE protection SET serial2 = NULL WHERE account = ?",account)
			elseif (data.serial3 == serial) then
				exports.DENmysql:exec("UPDATE protection SET serial3 = NULL WHERE account = ?",account)
			end
	end
end
addEventHandler("del", getRootElement(), del)	

--find me
addEvent("find",true)
function getPlayerFromNamePart(name)
    if name then 
        for i, player in ipairs(getElementsByType("player")) do
            if string.find(getPlayerName(player):lower(), tostring(name):lower(), 1, true) then
                return player 
            end
        end
    end
    return false
end
addEventHandler("find", getRootElement(),getPlayerFromNamePart)

addEvent("requestAdP",true)
function requestAdP()
	data = exports.DENmysql:query( "SELECT * FROM `protection`")
	triggerClientEvent( source, "cRequestAdP", source, data )
end
addEventHandler("requestAdP", root, requestAdP)