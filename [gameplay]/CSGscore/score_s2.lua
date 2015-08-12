function round2(num, idp)
  return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

function setPlayerScore(player,score)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		if (accountID) then
			exports.DENmysql:exec("UPDATE accounts SET score=? WHERE id=?",tonumber(score),accountID)
			setElementData(player,"playerScore",round2(score,2))
			return true
		else
			outputDebugString("[SCORE] ID not found (not logged in), returning...",0,255,0,0)
			return false
		end
	end
end
addEvent("onClientSetPlayerScore",true)
addEventHandler("onClientSetPlayerScore",root,setPlayerScore)

function givePlayerScore(player,score)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		if (accountID) then
			local q = exports.DENmysql:query("SELECT score FROM accounts WHERE id=? LIMIT 1",accountID)
			if q and #q == 1 then
				exports.DENmysql:exec("UPDATE accounts SET score=? WHERE id=?",q[1].score+score,accountID)
				setElementData(player,"playerScore",round2((getElementData(player,"playerScore")+score),2))
				return true
			end
		else
			outputDebugString("[SCORE] ID not found (not logged in), returning...",0,255,0,0)
			return false
		end
	end
end
addEvent("onClientGivePlayerScore",true)
addEvent("onClientGivePlayerScore",root,givePlayerScore)

function takePlayerScore(player,score)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		if (accountID) then
			q = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",accountID)
			if q then
				exports.DENmysql:exec("UPDATE accounts SET score=? WHERE id=?",q.score-score)
				setElementData(player,"playerScore",round2((getElementData(player,"playerScore")-score),2))
				return true
			end
		else
			outputDebugString("[SCORE] ID not found (not logged in), returning...",0,255,0,0)
			return false
		end
	end
end
addEvent("onClientTakePlayerScore",true)
addEventHandler("onClientTakePlayerScore",root,takePlayerScore)

function resetPlayerScore(player)
	if (isElement(player)) then
		accountID = exports.server:getPlayerAccountID(player)
		if (accountID) then
			exports.DENmysql:exec("UPDATE accounts SET score=0 WHERE id=?",accountID)
			setElementData(player,"playerScore",0)
			return true
		else
			outputDebugString("[SCORE] ID not found (not logged in), returning...",0,255,0,0)
		end
	end
end
addEvent("onClientResetPlayerScore",true)
addEventHandler("onClientResetPlayerScore",root,resetPlayerScore)
