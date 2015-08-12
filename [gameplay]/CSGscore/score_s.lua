function round2(num, idp)
 return num
 -- return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

local scores = {}

function setPlayerScore(player,score)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		if (accountID) then
			exports.DENmysql:exec("UPDATE accounts SET score=? WHERE id=?",tonumber(score),accountID)
			setElementData(player,"playerScore",math.floor(score),true)
			setElementData(player,"sbPS",math.floor(score),true)
			scores[player]=score
			return true
		else
			outputDebugString("[SCORE] ID not found (not logged in), returning...",0,255,0,0)
			return false
		end
	end
end
addEvent("cSetPlayerScore",true)
addEventHandler("cSetPlayerScore",root,setPlayerScore)
--[[
function givePlayerScore(player,score)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		if (accountID) then
			q = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",accountID)
			if q then
				exports.DENmysql:query("UPDATE accounts SET score=? WHERE id=?",tonumber(q.score+score),accountID)
				local new = round2(q.score+score,2)
				--outputDebugString("old "..q.score.." new "..new.."")
				setElementData(player,"playerScore",new,true)
				setElementData(player,"sbPS",new,true)
				return true
			end
		else
			outputDebugString("[SCORE] ID not found (not logged in), returning...",0,255,0,0)
			return false
		end
	end
end
--]]

function givePlayerScore(p,score)
	if p == nil or score == nil or scores[p] == nil then return end
	local new = scores[p]+score
	scores[p]=new
	setElementData(p,"playerScore",math.floor(new),true)
	setElementData(p,"sbPS",math.floor(new),true)
	return true
end

addEvent("cGivePlayerScore",true)
addEventHandler("cGivePlayerScore",root,givePlayerScore)
--[[
function takePlayerScore(player,score)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		if (accountID) then
			q = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",accountID)
			if q then
				exports.DENmysql:exec("UPDATE accounts SET score=? WHERE id=?",q.score-score,accountID)
				local new = round2(q.score-score,2)
				setElementData(player,"playerScore",new,true)
				setElementData(player,"sbPS",new,true)
				return true
			end
		else
			outputDebugString("[SCORE] ID not found (not logged in), returning...",0,255,0,0)
			return false
		end
	end
end
--]]
function takePlayerScore(p,score)
	if p == nil or score == nil or scores[p] == nil then return end
	local new = scores[p]-score
	scores[p]=new
	setElementData(p,"playerScore",math.floor(new),true)
	setElementData(p,"sbPS",math.floor(new),true)
	return true
end

addEvent("cTakePlayerScore",true)
addEventHandler("cTakePlayerScore",root,takePlayerScore)

addEventHandler("onPlayerQuit",root,function()
	if scores[source] ~= nil then
		local accountID = exports.server:getPlayerAccountID(source)
		exports.DENmysql:exec("UPDATE accounts SET score=? WHERE id=?",scores[source],accountID)
	end
end)

function resetPlayerScore(player)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		if (accountID) then
			exports.DENmysql:exec("UPDATE accounts SET score=0 WHERE id=?",accountID)
			setElementData(player,"playerScore",0,true)
			setElementData(player,"sbPS",0,true)
			return true
		else
			outputDebugString("[SCORE] ID not found (not logged in), returning...",0,255,0,0)
		end
	end
end
addEvent("cResetPlayerScore",true)
addEventHandler("cResetPlayerScore",root,resetPlayerScore)


function loginCB(qh,p)
	if isElement(p) then else return end
	local t = dbPoll(qh,0)
	if (t) then
		if (t[1]) then
			t=t[1]
			local score = t.score
			setElementData(p,"sbPS",math.floor(score),true)
			setElementData(p,"playerScore",math.floor(score),true)
			scores[p] = math.floor(score)
		end
	end
end


for k,v in pairs(getElementsByType("player")) do
	if exports.server:isPlayerLoggedIn(v) == true then
		--[[local id = exports.server:getPlayerAccountID(v)
		local q = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",id)
		local score = q.score
		setElementData(v,"sbPS",round2(score,2),true)
		setElementData(v,"playerScore",round2(score,2),true)
		scores[v]=round2(score,2)--]]
		dbQuery(loginCB,{v},exports.DENmysql:getConnection(),"SELECT * FROM accounts WHERE id=?",exports.server:getPlayerAccountID(v))
	end
end

addEventHandler("onPlayerLogin",root,function()
		local accountID = exports.server:getPlayerAccountID(source)
		--[[local q = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",accountID)
		local score = q.score
		setElementData(source,"sbPS",round2(score,2),true)
		setElementData(source,"playerScore",round2(score,2),true)
		scores[source]=round2(score,2)--]]
		dbQuery(loginCB,{source},exports.DENmysql:getConnection(),"SELECT * FROM accounts WHERE id=?",accountID)
end)
