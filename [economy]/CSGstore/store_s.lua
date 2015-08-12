function onRequestedTransaction(player,type,value,_email,)
	if (player) and (value ~= "" or nil) then
		if (type == 1) then
			constructSMS(player,value,_email) --SMS Payment
		elseif (type == 2) then
			constructPaypal(player,value,_email) --Paypal Payment
		else
			return false --the type wasn't defined
		end
	else
		outputDebugString("[STORE] Player or value not found.",0,255,0,0)
		return false
	end
end
addEvent("onPaymentTransaction",true)
addEventHandler("onPaymentTransaction",root,onRequestedTransaction)

function constructSMS(player,phoneNumber,_email)
	local username = exports.server:getPlayerAccountName(player)
	local transaction = phoneNumber
	local email = _email
	local status = 1 -- "Pending..."
	local issuedBy = "Not Available"
	local DAT = constructDateAndTime()
	processDatabaseAction(username,transaction,email,status,issuedBy,DAT)
end

function constructPaypal(player,transactionID,_email)
	local username = exports.server:getPlayerAccountName(player)
	local transaction = transactionID
	local email = _email
	local status = 1
	local issuedBy = "Not Available"
	local DAT = constructDateAndType()
	processDatabaseAction(username,transaction,email,status,issuedBy,DAT)
end

function processDatabaseAction(username,transaction,email,status,issuedBy,DAT)
	if (exports.DENmysql:exec("INSERT INTO store (username,transaction,email,status,issuedBy,dateAndTime,state) VALUES (?,?,?,?,?,?,?)",username,transaction,email,status,issuedBy,DAT,1)) then
		state = true
	else
		state = false
	end
	triggerClientEvent(player,"return:paymentActionState",player,state)
end

function getAllAvailableTransactions()
	local query = exports.DENmysql:query("SELECT * FROM store WHERE state=?",1)
	if (query) then
		triggerClientEvent(source,"returnTransactionData",source,query)
		triggerClientEvent(source,"postNotice",source,"Transactions collected. Total: "..#query,0,255,0)
	else
		triggerClientEvent(source,"postNotice",source,"An error occured while trying to collect the data! Please hit refresh to try again.",255,0,0)
		return false
	end
end
-------------------------------------------------------------------------------------------------------------------------------------------

function constructDateAndType()
	local time = getRealTime()
	local day = time.monthday
	local month = time.month+1
	local year = time.year+1900
	local hour = time.hour
	local minute = time.minute
	return hour..":"..minute.." - "..day.."/"..month.."/"..year
end