crash = {{{{{{{{ {}, {}, {} }}}}}}}}

function createNewBankingTransAction(recT, transaction)
	if (recT) and (transaction) then
		exports.DENmysql:exec("INSERT INTO `banking_transactions` SET `userid`=?, `transaction`=?", recT, transaction)
	end
end

addEvent("onBankMarkerHit", true)
function onBankMarkerHit()
	local recT = exports.server:getPlayerAccountID(source)
	local balanceCheck = exports.DENmysql:querySingle("SELECT * FROM `banking` WHERE `userid`=? LIMIT 1", recT)
	if not balanceCheck then
		exports.DENdxmsg:createNewDxMessage(source, "It seems you do not have a bank account. We have created one for you!", 200, 0, 0)
		local makeBankAccount = exports.DENmysql:exec("INSERT INTO `banking` SET `userid`=?", recT)
	else
		triggerClientEvent(source, "showBankingGui", source, balanceCheck.balance)
		triggerClientEvent(source, "updateBalanceLabel", source, balanceCheck.balance)
	end
end
addEventHandler("onBankMarkerHit", root, onBankMarkerHit)

addEvent ("withdrawMoney", true)
function withdrawMoney (value)
	local recT = exports.server:getPlayerAccountID(source)
	local balanceCheck = exports.DENmysql:querySingle("SELECT * FROM `banking` WHERE `userid`=?", recT)
	local playerMoney = getPlayerMoney(source)

	local totalGive = value
	local totalNewBalance = (balanceCheck.balance - value)

	if tonumber(value) > tonumber(balanceCheck.balance) or balanceCheck.balance == 0 then
		exports.DENdxmsg:createNewDxMessage(source, "You have insufficient funds!", 200,0,0)
	else
		givePlayerMoney (source, totalGive)
		local updateBank = exports.DENmysql:exec("UPDATE banking SET balance = ? WHERE `userid`=?", totalNewBalance, recT)
		createNewBankingTransAction (recT, "Withdrawn $".. value .."")
		exports.CSGlogging:createLogRow (source, "money", getPlayerName(source).." withdrawn $".. value .." from his bank account (New balance: $" .. totalNewBalance ..")")
		triggerClientEvent (source, "updateBalanceLabel", source, totalNewBalance)
	end
end
addEventHandler ("withdrawMoney", root, withdrawMoney)

addEvent ("depositMoney", true)
function depositMoney(value)
	local recT = exports.server:getPlayerAccountID(source)
	local balanceCheck = exports.DENmysql:querySingle("SELECT * FROM banking WHERE `userid`=?", recT)
	local playerMoney = getPlayerMoney (source)

	local totalTake = value
	local totalNewBalance = (balanceCheck.balance + value)

	if tonumber(value) > tonumber(playerMoney) or playerMoney == 0 then
		exports.DENdxmsg:createNewDxMessage(source, "You can't deposit this much money, because you dont have it!", 200,0,0)
	else
		takePlayerMoney (source, totalTake)
		updateBank = exports.DENmysql:exec("UPDATE banking SET balance =? WHERE `userid`=?", totalNewBalance, recT)
		createNewBankingTransAction (recT, "Deposited $".. value .."")
		exports.CSGlogging:createLogRow (source, "money", getPlayerName(source).." deposited $".. value .." from his bank account (New balance: $" .. totalNewBalance ..")")
		triggerClientEvent (source, "updateBalanceLabel", source, totalNewBalance)
	end
end
addEventHandler ("depositMoney", root, depositMoney)

addEvent ("requestTransactions", true)
function requestTransactions ()
	local recT = exports.server:getPlayerAccountID(source)
	local transactionsCheck = exports.DENmysql:querySingle("SELECT * FROM banking_transactions WHERE `userid`=?", recT)
	local transactions = exports.DENmysql:query("SELECT * FROM banking_transactions WHERE `userid`=? ORDER BY datum DESC, datum ASC LIMIT 50", recT)
	if not transactionsCheck then
		exports.DENdxmsg:createNewDxMessage(source, "You don't have any recent transactions.", 0, 200, 0)
	elseif transactions and #transactions > 0 then
		for key, transaction in ipairs(transactions) do
			triggerClientEvent(source, "insertTransactions", source, transaction.datum, transaction.transaction)
		end
	end
end
addEventHandler("requestTransactions", root, requestTransactions)

addEvent ("buyCreditcard", true)
function buyCreditcard ()
	local recT = exports.server:getPlayerAccountID(source)
	if (getPlayerMoney(source) < 1000) then
		exports.DENdxmsg:createNewDxMessage(source, "You dont have enough cash for a creditcard!", 0,200,0)
	elseif (getElementData(source, "creditcard") == 1) then
		exports.DENdxmsg:createNewDxMessage(source, "You already have a creditcard!", 0,200,0)
	else
		local giveTheCard = exports.DENmysql:exec("UPDATE banking SET creditcard =? WHERE `userid`=?", 1, recT)
		exports.DENdxmsg:createNewDxMessage(source, "You have bought a creditcard for $1000", 0,200,0)
		setElementData(source, "creditcard", 1)
		takePlayerMoney(source, 1000)
	end
end
addEventHandler ("buyCreditcard", root, buyCreditcard)

function sendPlayerMoney(player,reciever, money, localPlayerMoney, ele)
	if not (reciever) then
		exports.DENdxmsg:createNewDxMessage(player, "The account entered is not found.", 200,0,0)
		outputDebugString("[BANK] Account not found, returning...",0,255,0,0)
	elseif (reciever == exports.server:getPlayerAccountName(player)) then
		exports.DENdxmsg:createNewDxMessage(player, "You can't transfer money to yourself!", 200,0,0)
	elseif tonumber(money) > tonumber(localPlayerMoney) or localPlayerMoney == 0 then
		exports.DENdxmsg:createNewDxMessage(player, "You can't transfer this much money, because you dont have it!", 200,0,0)
	elseif (reciever) then
		if (ele) and isElement(ele) then
			if ele == player then
				exports.DENdxmsg:createNewDxMessage(player, "You can't transfer money to yourself!", 200,0,0)
			return
			end
		reciever = exports.server:getPlayerAccountName(ele)
		end
		local recT = exports.DENmysql:query("SELECT * FROM accounts WHERE username=?",reciever) --since this is already defined on the clientside.
		local playerID = exports.server:getPlayerAccountID(player) --our player thats sending
		local recBankT = exports.DENmysql:query("SELECT * FROM banking WHERE `userid`=?", recT[1].id) --check if this players bank exists..
		if #recT == 0 then
			exports.DENdxmsg:createNewDxMessage(player,"The account: "..reciever.." does not have a bank account.",200,0,0)
		elseif #recT > 0 and #recBankT > 0 then
			local senderCheck = exports.DENmysql:query("SELECT * FROM banking WHERE `userid`=?", playerID)
			local totalNewBalance = (recBankT[1].balance + money)
			local takerNewBalance = (senderCheck[1].balance - money)
			exports.DENmysql:query("UPDATE banking SET balance =? WHERE `userid`=?",totalNewBalance, recT[1].id)
			exports.DENmysql:query("UPDATE banking SET balance =? WHERE `userid`=?",takerNewBalance, playerID)

			createNewBankingTransAction (recT[1].id, "Recieved $"..money.." from username "..exports.server:getPlayerAccountName(player).."")
			createNewBankingTransAction (playerID, "Sent $".. money .."" .. " to username "..reciever.."")

			triggerClientEvent (player, "updateBalanceLabel", player, takerNewBalance)
			if isElement(ele) then
				exports.DENdxmsg:createNewDxMessage(ele,""..getPlayerName(player).." has transferred $"..money.." to your bank account.",0,200,0)
			end
			exports.DENdxmsg:createNewDxMessage(player, "You sent $"..money.." to username "..reciever.."'s bank account", 0,200,0)
		end
	else
		exports.DENdxmsg:createNewDxMessage(source, "The player you want to send money dont have a bank account.", 200,0,0)
	end
end

addEvent ("CSGbanking.SPM", true)
addEventHandler ("CSGbanking.SPM", root, sendPlayerMoney)

local atmHackSpam = {}

addEvent ("onPlayerHackedATM", true)
function onPlayerHackedATM ()
	if (isElement (source)) then
		if (atmHackSpam[getPlayerSerial(source)]) and (getTickCount()-atmHackSpam[getPlayerSerial(source)] < 300000) then
			exports.DENdxmsg:createNewDxMessage(source, "You can only hack a ATM once every 5 minutes!", 255, 0, 0)
		else
			local reward = math.random(400,1200)
			local wanted = math.random(0.4,2.0)
			local passed = math.random(100,500)
			if (passed > 200) then
				exports.DENdxmsg:createNewDxMessage(source, "Pro hacker! You hacked this ATM and stole $" .. reward .. "", 0, 225, 0)
				givePlayerMoney(source, reward)
				exports.server:givePlayerWantedPoints(source, wanted)
				atmHackSpam[getPlayerSerial(source)] = getTickCount()
			else
				exports.DENdxmsg:createNewDxMessage(source, "This ATM had a good anti virus, you failed hacking it!", 255, 0, 0)
				exports.server:givePlayerWantedPoints(source, wanted)
				atmHackSpam[getPlayerSerial(source)] = getTickCount()
			end
		end
	end
end
addEventHandler("onPlayerHackedATM", root, onPlayerHackedATM)
