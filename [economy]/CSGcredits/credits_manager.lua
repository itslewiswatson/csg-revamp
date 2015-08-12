ableToEdit = true
target = nil

crasher = {{{{{ {}, {}, {} }}}}}

addEventHandler("onClientResourceStart",resourceRoot,
function()
	rX,rY = guiGetScreenSize()
	width,height = 786,552
	X = (rX/2) - (width/2)
	Y = (rY/2) - (height/2)
	window = guiCreateWindow(X,Y,width,height, "CSG ~ Credits Management System", false)
		guiWindowSetSizable(window, false)
		guiSetAlpha(window, 1.00)
		guiSetProperty(window, "CaptionColour", "FFFF0000")

	line1 = guiCreateLabel(404, 16, 15, 531, "|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n", false, window)
		guiLabelSetHorizontalAlign(line1, "center", false)
		guiLabelSetVerticalAlign(line1, "center")
	grid = guiCreateGridList(419, 61, 357, 476, false, window)
		ID = guiGridListAddColumn(grid, "ID", 0.1)
		USER = guiGridListAddColumn(grid,"Username",0.2)
		TRANSACTION = guiGridListAddColumn(grid, "Transaction", 0.35)
		COST = guiGridListAddColumn(grid,"Cost",0.1)
		DATE = guiGridListAddColumn(grid, "Date", 0.2)
	label1 = guiCreateLabel(433, 22, 322, 35, "Recent Credits Transactions", false, window)
		guiSetFont(label1, "default-bold-small")
		guiLabelSetColor(label1, 255, 216, 0)
		guiLabelSetHorizontalAlign(label1, "center", true)
		guiLabelSetVerticalAlign(label1, "center")
	userData = guiCreateLabel(3, 18, 397, 30, "Username: N/A, ID: N/A", false, window)
		guiSetFont(userData, "default-bold-small")
		guiLabelSetHorizontalAlign(userData, "center", false)
		guiLabelSetVerticalAlign(userData, "center")
	statsEdit = guiCreateLabel(0, 79, 399, 60, "Credits: N/A\n Credits Spent: N/A\n Money Spent: N/A\n Items Bought: N/A", false, window)
		guiSetFont(statsEdit, "default-bold-small")
		guiLabelSetHorizontalAlign(statsEdit, "center", false)
		guiLabelSetVerticalAlign(statsEdit, "center")
	label2 = guiCreateLabel(0, 49, 397, 30, "Stats:", false, window)
		guiSetFont(label2, "default-bold-small")
		guiLabelSetHorizontalAlign(label2, "center", false)
		guiLabelSetVerticalAlign(label2, "center")
	line2 = guiCreateLabel(0, 43, 403, 15, "_________________________________________________________", false, window)
		guiLabelSetHorizontalAlign(line2, "center", false)
		guiLabelSetVerticalAlign(line2, "center")
	line3 = guiCreateLabel(0, 138, 399, 15, "______________________________________________________________", false, window)
	closeBtn = guiCreateButton(10, 508, 390, 34, "Close", false, window)
		guiSetProperty(closeBtn, "NormalTextColour", "FFAAAAAA")
	creditsEdit = guiCreateEdit(9, 178, 386, 26, "", false, window)
	label3 = guiCreateLabel(100, 155, 204, 24, "Credits:", false, window)
		guiLabelSetHorizontalAlign(label3, "center", false)
		guiLabelSetVerticalAlign(label3, "center")
	setCredits = guiCreateButton(9, 206, 387, 31, "Set new credits value", false, window)
		guiSetProperty(setCredits, "NormalTextColour", "FFAAAAAA")
	moneyEdit = guiCreateEdit(10, 271, 386, 26, "", false, window)
	label4 = guiCreateLabel(100, 247, 204, 24, "Money Spent:", false, window)
		guiLabelSetHorizontalAlign(label4, "center", false)
		guiLabelSetVerticalAlign(label4, "center")
	setMoney = guiCreateButton(10, 297, 387, 31, "Set new money value", false, window)
		guiSetProperty(setMoney, "NormalTextColour", "FFAAAAAA")
	line = guiCreateLabel(0, 323, 399, 15, "______________________________________________________________", false, window)
	resetBtn = guiCreateButton(10, 475, 390, 34, "Reset Management System", false, window)
		guiSetProperty(resetBtn, "NormalTextColour", "FFAAAAAA")
	accountEdit = guiCreateEdit(10, 368, 386, 26, "", false, window)
	label5 = guiCreateLabel(100, 344, 204, 24, "Account Name:", false, window)
		guiLabelSetHorizontalAlign(label5, "center", false)
		guiLabelSetVerticalAlign(label5, "center")
	findBtn = guiCreateButton(10, 394, 387, 31, "Find account", false, window)
		guiSetProperty(findBtn, "NormalTextColour", "FFAAAAAA")
	statusLbl = guiCreateLabel(0, 420, 397, 30, "Status: idle", false, window)
		guiSetFont(statusLbl, "clear-normal")
		guiLabelSetColor(statusLbl, 255, 255, 0)
		guiLabelSetHorizontalAlign(statusLbl, "center", false)
		guiLabelSetVerticalAlign(statusLbl, "center")
	guiSetVisible(window,false)
	outputDebugString("Manager started.")
end)

function buttonHandler(button,state)
	if button == "left" and state == "up" then
		if (source == closeBtn) then
			outputDebugString("Close button pressed.")
			showCursor(false)
			guiSetVisible(window,false)
		elseif (source == setCredits) then
			outputDebugString("Credits button pressed.")
			newCreditsValue = guiGetText(creditsEdit)
			if (target) then
				triggerServerEvent("updateValues",localPlayer,target,1,newCreditsValue)
				outputDebugString("Sending update data...")
			else
				outputChatBox("Error trying to get the target's id, please reload the manager and try again.",255,0,0)
			end
		elseif (source == setMoney) then
			outputDebugString("Money button pressed.")
			newMoneyValue = guiGetText(moneyEdit)
			if (target) then
				triggerServerEvent("updateValues",localPlayer,target,2,newMoneyValue)
				outputDebugString("Sending update data...")
			else
				outputChatBox("Error trying to get the target's id, please reload the manager and try again.",255,0,0)
			end
		elseif (source == resetBtn) then
			outputDebugString("Reset button pressed.")
			resetManager()
		elseif (source == findBtn) then
			outputDebugString("Find button pressed.")
			findPlayerAccount()
		end
	end
end
addEventHandler("onClientGUIClick",root,buttonHandler)

function resetManager()
	changeStatus(4) --reset
	guiGridListClear(grid)
	guiSetText(userData,"Username: N/A, ID: N/A")
	guiSetText(statsEdit,"Credits: N/A\n Credits Spent: N/A\n Money Spent: N/A\n Items Bought: N/A")
	guiSetText(creditsEdit,"")
	guiSetText(accountEdit,"")
	guiSetText(moneyEdit,"")
	ableToEdit = true
	target = nil
end

function findPlayerAccount()
	account = guiGetText(accountEdit)
	if not (ableToEdit == true) then changeStatus(1,"Status: reset manager first!") setTimer(changeStatus,2000,1,4) return end
	if (account and account ~= "" or nil) then
		triggerServerEvent("findTargetAccount",localPlayer,account)
		changeStatus(3,"Status: Finding account...")
	else
		changeStatus(1,"Status: ENTER A ACCOUNT!")
		setTimer(changeStatus, 3000, 1,4)
		guiSetText(userData,"Username: N/A, ID: N/A")
		guiSetText(statsEdit,"Credits: N/A\n Credits Spent: N/A\n Money Spent: N/A\n Items Bought: N/A")
		guiGridListClear(grid)
	end
end

function changeStatus(state,status)
	if (state == 1) then
		if (status and status ~= "") then
			guiLabelSetColor(statusLbl,255,0,0)
			guiSetText(statusLbl,tostring(status))
		end
	elseif (state == 2) then --good results
		if (status and status ~= "") then
			guiLabelSetColor(statusLbl,0,255,0)
			guiSetText(statusLbl,tostring(status))
		end
	elseif (state == 3) then
		if (status and status ~= "") then
			guiLabelSetColor(statusLbl,255,255,0)
			guiSetText(statusLbl,tostring(status))
		end
	elseif (state == 4) then --reset
		guiLabelSetColor(statusLbl,255,255,0)
		guiSetText(statusLbl,"Status: idle")
	else
		outputDebugString("[MANAGER] Wrong state code entered, 1-4 only. RETURNING!")
	end
end
addEvent("returnStatusUpdate",true)
addEventHandler("returnStatusUpdate",root,changeStatus)

addEvent("returnTargetAccount",true)
addEventHandler("returnTargetAccount",root,
function(results,data,trans)
	if (results and data) then
		guiSetText(userData,"Username: "..results.username..", ID: "..results.id)
		guiSetText(statsEdit,"Credits: "..data.credits.."C\n Credits Spent: "..data.creditsSpent.."C\n Money Spent: "..data.moneySpent.."\n Items Bought: "..data.itemsBought)
		guiSetText(creditsEdit,data.credits)
		guiSetText(moneyEdit,data.moneySpent)
		--loop through the gridlist
		guiGridListClear(grid) --clear it first!
		if not (trans) then
			row = guiGridListAddRow(grid)
			guiGridListSetItemText(grid,row,TRANSACTION,"No transactions",false,false)
		else
			for k,v in ipairs(trans) do
				row = guiGridListAddRow(grid)
				guiGridListSetItemText(grid,row,ID,v.id,false,false)
				guiGridListSetItemText(grid,row,USER,v.username,false,false)
				guiGridListSetItemText(grid,row,TRANSACTION,v.transaction,false,false)
				guiGridListSetItemText(grid,row,COST,v.cost,false,false)
				guiGridListSetItemText(grid,row,DATE,v.date,false,false)
			end
		end
		changeStatus(2,"Status: Account found!")
		ableToEdit = false
		target = results.id
	end
end)

function showManager()
	if not (exports.server:getPlayerAccountID(localPlayer) == 7) then return end
	if (guiGetVisible(window) == false) then
		guiSetVisible(window,true)
		showCursor(true)
	else
		guiSetVisible(window,false)
		showCursor(false)
	end
end
addCommandHandler("manager",showManager)