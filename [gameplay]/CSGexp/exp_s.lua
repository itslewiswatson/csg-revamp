local cache = {}

addEventHandler("onResourceStart",resourceRoot,
function()
	--begin the loop--
	for k,v in ipairs(getElementsByType("player")) do
		accountID = exports.server:getPlayerAccountID(v)
		if (accountID) then --is logged in
			local query = exports.DENmysql:querySingle("SELECT * FROM exp WHERE id=? LIMIT 1",accountID)
			if (query) then
				cache[accountID] = {query.exp,query.expNeeded,query.level}
				exp = query.exp
				need = query.expNeeded
				level = query.level
			else --he was not found...
				local need = math.random(1000)
				exp = 0
				level = 0
				cache[accountID] = {exp,need,level}
				exports.DENmysql:exec("INSERT INTO exp (id,exp,expNeeded,level) VALUES (?,?,?,?)",accountID,exp,need,level)
			end
			
			setElementData(v,"exp",exp)
			setElementData(v,"expNeeded",need)
			setElementData(v,"level",level)
		else
			return --hes not logged in
		end
	end
end)

addEvent("onPlayerLogin")
addEventHandler("onPlayerLogin",root,
function()
	if (isElement(source)) then
		accountID = exports.server:getPlayerAccountID(source)
		if (accountID) then
			if not (cache[accountID]) then --lets just check see if theres anything in the cache...
				local query = exports.DENmysql:querySingle("SELECT * FROM exp WHERE id=?",accountID)
				if query then
					local exp = query.exp
					local need = query.expNeeded
					local level = query.level
				else
					local exp = 0
					local need = math.random(1000)
					local level = 0
					exports.DENmysql:exec("INSERT INTO exp (id,exp,expNeeded,level) VALUES (?,?,?,?)",accountID,exp,need,level)
				end
				
				setElementData(source,"exp",exp)
				setElementData(source,"expNeeded",need)
				setElementData(source,"level",level)
				
				cache[accountID] = {exp,need,level}
			else
				setElementData(source,"exp",cache[accountID][1])
				setElementData(source,"expNeeded",cache[accountID][2])
				setElementData(source,"level",cache[accountID][3])
			end
		else
			outputDebugString("Player "..getPlayerName(source).." is not logged in, returning...",0,255,0,0)
			return false
		end
	else
		return false
	end
end)

function onPlayerQuit()
	local exp = getElementData(source,"exp") or 0
	local need = getElementData(source,"expNeeded") or math.random(1000)
	local level = getElementData(source,"level") or 0
	
	exports.DENmysql:exec("INSERT INTO exp (id,exp,expNeeded,level) VALUES ("..exports.server:getPlayerAccountID(source)..",?,?,?) ON DUPLICATE KEY UPDATE exp=?, expNeeded=?, level=?",exp,need,level,exp,need,level)
end
addEventHandler("onPlayerQuit",root,onPlayerQuit)

function getPlayerEXP(player)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		
		if not accountID then return "Player not logged in." end
		
		if (cache[accountID]) then --find the cache...
			return cache[accountID][1]
		else --not found
			if (getElementData(player,"exp")) then
				return getElementData(player,"exp")
			else
				local query = exports.DENmysql:querySingle("SELECT exp FROM exp WHERE id=?",accountID)
				if (query) then
					return query["exp"]
				else
					return false
				end
			end
		end
	else
		return "Player not found."
	end
end

function getPlayerLevel(player)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		
		if not accountID then return "Player not logged in." end
		
		if (cache[accountID]) then
			return cache[accountID][3]
		else
			if (getElementData(player,"level")) then
				return getElementData(player,"level")
			else
				local query = exports.DENmysql:querySingle("SELECT level FROM exp WHERE id=?",accountID)
				if (query) then
					return query["level"]
				else
					return false
				end
			end
		end
	else
		return "Player not found."
	end
end

function getPlayerNeededEXP(player)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		
		if not accountID then return "Player not logged in." end
		
		if (cache[accountID]) then
			return cache[accountID][2]
		else
			if (getElementData(player,"expNeeded")) then
				return getElementData(player,"expNeeded")
			else
				local query = exports.DENmysql:querySingle("SELECT expNeeded FROM exp WHERE id=?",accountID)
				if (query) then
					return query["expNeeded"]
				else
					return false
				end
			end
		end
	else
		return "Player not found."
	end
end

function setPlayerEXP(player,amount)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		
		if not accountID then return "Player is not logged in." end
		
		if (cache[accountID]) then
			cache[accountID][1] = tonumber(amount)
		end
		
		setElementData(source,"exp",tonumber(amount))
		
		if (exports.DENmysql:querySingle("SELELCT exp FROM exp WHERE id=?",accountID)) then
			exports.DENmysql:exec("UPDATE exp SET exp=? WHERE id=?",tonumber(amount),accountID)
		else
			exports.DENmysql:exec("INSERT INTO exp (id,exp,expNeeded,level) VALUES (?,?,?,?)",accountID,tonumber(amount),getElementData(player,"expNeeded"),getElementData(player,"level"))
		end
	else
		return "Player not found."
	end
end

function setPlayerLevel(player,amount)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		
		if not accountID then return "Player is not logged in." end
		
		if (cache[accountID]) then
			cache[accountID][3] = tonumber(amount)
		end
		
		setElementData(source,"level",tonumber(amount))
		
		if(exports.DENmysql:querySingle("SELECT level FROM exp WHERE id=?",accountID)) then
			exports.DENmysql:exec("UPDATE exp SET level=? WHERE id=?",tonumber(amount),accountID)
		else
			exports.DENmysql:exec("INSERT INTO exp (id,exp,expNeeded,level) VALUES (?,?,?,?)",accountID,getElementData(player,"exp"),getElementData(player,"expNeeded"),tonumber(amount))
		end
	else
		return "Player not found."
	end
end

function givePlayerEXP(player,amount)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		
		if not accountID then return "Player not logged in." end
		
		if (cache[accountID]) then
			cache[accountID][1] = cache[accountID][1] + tonumber(amount)
		end
		
		setElementData(player,"exp",getElementData(player,"exp")+tonumber(amount))
		
		if (exports.DENmysql:querySingle("SELECT exp FROM exp WHERE id=?",accountID)) then
			exports.DENmysql:exec("UDPATE exp SET exp=? WHERE id=?",getElementData(player,"exp")+tonumber(amount),accountID)
		else
			exports.DENmysql:exec("INSERT INTO exp (id,exp,expNeeded,level) VALUES (?,?,?,?)",accountID,getElementData(player,"exp")+tonumber(amount),getElementData(player,"expNeeded"),getElementData(player,"level"))
		end
	else
		return "Player not found."
	end
end

function resetPlayerEXP(player)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		
		if not accountID then return "Player not logged in." end
		
		if (cache[accountID]) then
			cache[accountID] = {0,math.random(1000),0}
		end
		
		setElementData(player,"exp",0)
		setElementData(player,"expNeeded",0)
		setElementData(player,"level",0)
		
		if (exports.DENmysql:querySingle("SELECT exp FROM exp WHERE id=?",accountID)) then
			exports.DENmysql:exec("UDPATE exp SET exp=?,expNeeded=?,level=? WHERE id=?",0,math.random(1000),0,accountID)
		else
			exports.DENmysql:exec("INSERT INTO exp (id,exp,expNeeded,level) VALUES (?,?,?,?)",accountID,0,math.random(1000),0)
		end
	else
		return "Player not found."
	end
end