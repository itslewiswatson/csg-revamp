cache = {}
timers = {}

function loadCredData(player)
	outputDebugString("Initalizing credits command...")
	if isElement(player) then
		accountID = exports.server:getPlayerAccountID(player)
		accountName = exports.server:getPlayerAccountName(player)
		data = exports.DENmysql:querySingle("SELECT * FROM credits WHERE userid=?",accountID)
		--Now send the data and add a cache timeout--
		triggerClientEvent(player,"openCreditsMain",player,data,accountID,accountName)
	end
end
addCommandHandler("credits",loadCredData)
addEvent("toggleCreditsMain",true)
addEventHandler("toggleCreditsMain",root,loadCredData)

function getStoreData(player)
	sendData = exports.DENmysql:query("SELECT * FROM store")
	outputDebugString("Table found, sending back to client...",0,255,255,0)
	triggerClientEvent(source,"sendStoreData",root,sendData)
end
addEvent("getStoreData",true)
addEventHandler("getStoreData",root,getStoreData)

addEvent("onStorePurchase",true)
addEventHandler("onStorePurchase",root,
function(itemID)
	if (itemID) then
		item = exports.DENmysql:querySingle("SELECT * FROM store WHERE id=?",itemID)
		if (item) then
			if not (item.stock == 0) then
				plyData = exports.DENmysql:querySingle("SELECT * FROM credits WHERE userid=?",exports.server:getPlayerAccountID(source))
				if not (plyData) then
					outputChatBox("Whoops, it seems your not in the credits database, type /credits to fix it!",source,255,0,0)
					return
				end
				outputDebugString("PRICE: "..item.price..", CREDITS: "..plyData.credits)
				if (item.price < plyData.credits or item.price == plyData.credits ) then --check see if the player has the correct amount	
					--CHECK FOR DISCOUNTS!--
					ply = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",exports.server:getPlayerAccountID(source))
					exports.DENmysql:exec("UPDATE credits SET credits=?,creditsSpent=? WHERE userid=?",plyData.credits-item.price,plyData.creditsSpent+item.price,exports.server:getPlayerAccountID(source))
					if not (item.stock == -1) then
						exports.DENmysql:exec("UPDATE store SET stock=? WHERE id=?",item.stock-1,itemID)
					end
					outputDebugString("Attempting to run code...")
					outputDebugString("Player: "..getPlayerName(source).." data: "..tostring(source))
					player = source
					loadstring(item.code)() --run the item code
					datum = getRealTime()
					year = datum.year + 1900
					month = datum.month + 1
					day = datum.monthday
					date = year.."-"..month.."-"..day
					triggerEvent("getStoreData",source)
					ply = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",exports.server:getPlayerAccountID(source))
					exports.DENmysql:exec("INSERT INTO store_transactions(userid,username,transaction,itemid,cost,date) VALUES (?,?,?,?,?,?)",ply.id,ply.username,"PURCHASE: "..item.item,item.id,item.price,date)
				else
					outputChatBox("You do not have enough for this item. (Price: "..item.price..", NEED: "..item.price-plyData.credits..")",source,255,0,0)
				end
			else
				outputChatBox("The item your trying to purchase is out of stock!",source,255,0,0)
			end
		else
			outputDebugString("Item ID not found, returning...",0,255,0,0)
			outputChatBox("It appears we cannot find that item, please turn off/on the store.",source,255,0,0)
		end
	end
end)

addEvent("findTargetAccount",true)
addEventHandler("findTargetAccount",root,
function(account)
	if (account) then
		result = exports.DENmysql:querySingle("SELECT id,username FROM accounts WHERE username=?",account)
		if (result) then
			data = exports.DENmysql:querySingle("SELECT * FROM credits WHERE userid=?",result.id)
			trans = exports.DENmysql:query("SELECT * FROM store_transactions WHERE userid=? ORDER BY date DESC",result.id)
			triggerClientEvent(source,"returnTargetAccount",source,result,data,trans)
		else
			triggerClientEvent(source,"returnStatusUpdate",source,1,"Status: ACCOUNT NOT FOUND!")
		end
	end
end)

addEvent("updateValues",true)
addEventHandler("updateValues",root,
function(id,state,value)
	if not (id or state or value) then return end
	if (state == 1) then --setting credits
		outputDebugString("New value detected, updating...")
		exports.DENmysql:exec("UPDATE credits SET credits=? WHERE userid=?",tonumber(value),id)
		outputDebugString("DONE! sending new data back!")
		--NOW refresh the data--
		result = exports.DENmysql:querySingle("SELECT id,username FROM accounts WHERE id=?",id)
		if (result) then
			data = exports.DENmysql:querySingle("SELECT * FROM credits WHERE userid=?",result.id)
			trans = exports.DENmysql:query("SELECT * FROM store_transactions WHERE userid=? ORDER BY date DESC",result.id)
			triggerClientEvent(source,"returnTargetAccount",source,result,data,trans)
			outputDebugString("SENDING...")
		else
			triggerClientEvent(source,"returnStatusUpdate",source,1,"Status: ACCOUNT NOT FOUND!")
		end
	elseif (state == 2) then
		outputDebugString("New value detected, updating...")
		exports.DENmysql:exec("UPDATE credits set moneySpent=? WHERE userid=?",tonumber(value),id)
		outputDebugString("DONE! sending new data back!")
		--NOW refresh the data--
		result = exports.DENmysql:querySingle("SELECT id,username FROM accounts WHERE id=?",id)
		if (result) then
			data = exports.DENmysql:querySingle("SELECT * FROM credits WHERE userid=?",result.id)
			trans = exports.DENmysql:query("SELECT * FROM store_transactions WHERE userid=? ORDER BY date DESC",result.id)
			triggerClientEvent(source,"returnTargetAccount",source,result,data,trans)
			outputDebugString("SENDING...")
		else
			triggerClientEvent(source,"returnStatusUpdate",source,1,"Status: ACCOUNT NOT FOUND!")
		end
	else
		outputDebugString("Wrong state numbers.")
	end
end)

addEvent("startStoreManProcess",true)
addEventHandler("startStoreManProcess",root,
function(task,arg1,arg2,arg3,arg4,arg5,arg6)
	outputDebugString("Process call detected")
	if (task == "load") then --load the store data
		outputDebugString("Load protocol sent, loading item data...")
		data = exports.DENmysql:querySingle("SELECT * FROM store WHERE id=?",arg1)
		if (data) then
			outputDebugString("Data collected, returning back...")
			triggerClientEvent(source,"returnStoreManProcess",source,data)
		else
			outputChatBox("Seems there was a error finding the store ID, please refresh the manager.",source,255,0,0)
		end
	elseif (task == "add") then
		if (arg1 and arg2 and arg3 and arg4 and arg5) then --item,price,discount,stock,code
			data = exports.DENmysql:query("SELECT * FROM store")
			if not (data.item == arg1) then --check see if the item name exists.
				exports.DENmysql:exec("INSERT INTO store (item,price,discount,stock,code) VALUES (?,?,?,?,?)",arg1,arg2,arg3,arg4,arg5)
				outputDebugString("Inserted data into store.")
				triggerEvent("toggleStoreMenu",source)
			else
				outputChatBox("The item name you chosen already exists.",source,255,0,0)
			end
		end
	elseif (task == "edit") then
		if (arg1 and arg2 and arg3 and arg4 and arg5 and arg6) then
			outputDebugString(arg1.." "..arg2.." "..arg3.." "..arg4.." "..arg5.." "..arg6)
			data = exports.DENmysql:querySingle("SELECT * FROM store WHERE id=?",arg1)
			if (data) then
				outputDebugString("Data found, updating...")
				exports.DENmysql:exec("UPDATE store SET item=?,price=?,discount=?,stock=?,code=? WHERE id=?",arg2,arg3,arg4,arg5,arg6,arg1)
				outputDebugString("UPDATE sent.")
				triggerEvent("toggleStoreMenu",source)
			else
				outputDebugString("Error finding store item..")
			end
		end
	else
		outputDebugString("Wrong task process sent.")
	end
end)

function cacheTimeout(account)
	if (cache[account]) then
		cache[account] = nil
		outputDebugString("Destroying cache: "..account)
	end
end