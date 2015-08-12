itemEditing = false

function drawWindow()
	rX,rY = guiGetScreenSize()
	width,height = 634,427
	X = (rX/2) - (width/2)
	Y = (rY/2) - (height/2)
	window = guiCreateWindow(398, 269, 634, 427, "CSG ~ Store Manager", false)
	guiWindowSetSizable(window, false)
	guiSetAlpha(window, 1.00)

	gridlist = guiCreateGridList(349, 20, 275, 374, false, window)
		ID = guiGridListAddColumn(gridlist, "Item ID", 0.1)
		ITEM = guiGridListAddColumn(gridlist, "Item Name", 0.4)
		COST = guiGridListAddColumn(gridlist, "Item Cost",0.1)
		STOCK = guiGridListAddColumn(gridlist, "Stock",0.15)
	line1 = guiCreateLabel(329, 16, 15, 401, "|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n", false, window)
		guiLabelSetHorizontalAlign(line1, "center", false)
		guiLabelSetVerticalAlign(line1, "center")
	itemEdit = guiCreateEdit(10, 37, 310, 23, "", false, window)
	label1 = guiCreateLabel(10, 19, 309, 15, "Item", false, window)
		guiSetFont(label1, "default-bold-small")
		guiLabelSetHorizontalAlign(label1, "center", false)
		guiLabelSetVerticalAlign(label1, "center")
	label2 = guiCreateLabel(10, 70, 309, 15, "Price", false, window)
		guiSetFont(label2, "default-bold-small")
		guiLabelSetHorizontalAlign(label2, "center", false)
		guiLabelSetVerticalAlign(label2, "center")
	priceEdit = guiCreateEdit(10, 85, 310, 23, "", false, window)
	discountEdit = guiCreateEdit(10, 133, 310, 23, "", false, window)
	label3 = guiCreateLabel(10, 118, 309, 15, "Discount", false, window)
		guiSetFont(label3, "default-bold-small")
		guiLabelSetHorizontalAlign(label3, "center", false)
		guiLabelSetVerticalAlign(label3, "center")
	stockEdit = guiCreateEdit(10, 181, 310, 23, "", false, window)
		label4 = guiCreateLabel(10, 166, 309, 15, "Stock", false, window)
		guiSetFont(label4, "default-bold-small")
		guiLabelSetHorizontalAlign(label4, "center", false)
		guiLabelSetVerticalAlign(label4, "center")
	label5 = guiCreateLabel(10, 214, 309, 15, "Item code", false, window)
		guiSetFont(label5, "default-bold-small")
		guiLabelSetHorizontalAlign(label5, "center", false)
		guiLabelSetVerticalAlign(label5, "center")
	codeEdit = guiCreateMemo(10, 229, 310, 71, "", false, window)
	closeBtn = guiCreateButton(10, 392, 311, 25, "Close", false, window)
		guiSetProperty(closeBtn, "NormalTextColour", "FFAAAAAA")
	resetBtn = guiCreateButton(10, 367, 311, 25, "Reset", false, window)
		guiSetProperty(resetBtn, "NormalTextColour", "FFAAAAAA")
	loadBtn = guiCreateButton(10, 342, 311, 25, "Load", false, window)
		guiSetProperty(loadBtn, "NormalTextColour", "FFAAAAAA")
	addBtn = guiCreateButton(10, 317, 311, 25, "Add / Change", false, window)
		guiSetProperty(addBtn, "NormalTextColour", "FFAAAAAA")
	refreshBtn = guiCreateButton(349, 392, 275, 25, "Refresh", false, window)
		guiSetProperty(refreshBtn, "NormalTextColour", "FFAAAAAA")
	line2 = guiCreateLabel(10, 289, 309, 18, "______________________________________________________", false, window)
		guiLabelSetHorizontalAlign(line2, "center", false)
		guiLabelSetVerticalAlign(line2, "center")
	outputDebugString("Store Manager started.")
	guiSetVisible(window,false)
end
addEventHandler("onClientResourceStart",resourceRoot,drawWindow)

function buttonHandler(button,state)
	if button == "left" and state == "up" then
		if (source == closeBtn) then
			outputDebugString("Close button pressed.")
			guiSetVisible(window,false)
			showCursor(false)
			
		elseif (source == resetBtn) then
			outputDebugString("Reset button pressed.")
			itemEditing = false
			guiSetText(itemEdit,"")
			guiSetText(priceEdit,"")
			guiSetText(discountEdit,"")
			guiSetText(stockEdit,"")
			guiSetText(codeEdit,"")
		elseif (source == loadBtn) then
			outputDebugString("Load button pressed.")
			if (itemEditing == true) then outputChatBox("Reset the manager before editing a new one!",255,0,0) return end
			ID = guiGridListGetItemText(gridlist,guiGridListGetSelectedItem(gridlist),ID)
			if (ID) then
				triggerServerEvent("startStoreManProcess",localPlayer,"load",ID)
			end
		elseif (source == addBtn) then
			if (itemEditing == false) then
				outputDebugString("Add button pressed.")
				item = guiGetText(itemEdit)
				price = guiGetText(priceEdit)
				discount = guiGetText(discountEdit)
				stock = guiGetText(stockEdit)
				code = guiGetText(codeEdit)
				triggerServerEvent("startStoreManProcess",localPlayer,"add",item,price,discount,stock,code)
			else --editing
				outputDebugString("Change button pressed.")
				id = guiGridListGetItemText(gridlist,guiGridListGetSelectedItem(gridlist),ID)
				item = guiGetText(itemEdit)
				price = guiGetText(priceEdit)
				discount = guiGetText(discountEdit)
				stock = guiGetText(stockEdit)
				code = guiGetText(codeEdit)
				triggerServerEvent("startStoreManProcess",localPlayer,"edit",id,item,price,discount,stock,code)
			end
		elseif (source == refreshBtn) then
			outputDebugString("Reset button pressed.")
			triggerServerEvent("toggleStoreMenu",root,localPlayer)
		end
	end
end
addEventHandler("onClientGUIClick",root,buttonHandler)

addEvent("openStoreMenu",true)
addEventHandler("openStoreMenu",root,
function(data)
	if not (localPlayer == source) then return end
	if (data) then
		guiGridListClear(gridlist)
		for k,v in ipairs(data) do
			row = guiGridListAddRow(gridlist)
			guiGridListSetItemText(gridlist,row,ID,v.id,false,false)
			guiGridListSetItemText(gridlist,row,ITEM,v.item,false,false)
			guiGridListSetItemText(gridlist,row,COST,v.price,false,false)
			guiGridListSetItemText(gridlist,row,STOCK,v.stock,false,false)
		end
	end
	
	--open the GUI--
	if (not guiGetVisible(window) == true) then
		guiSetVisible(window,true)
		showCursor(true)
	end
end)

addEvent("returnStoreManProcess",true)
addEventHandler("returnStoreManProcess",root,
function(data)
	outputDebugString("Return call processing...")
	if (data) then
		outputDebugString("Setting...")
		guiSetText(itemEdit,data.item)
		guiSetText(priceEdit,data.price)
		guiSetText(discountEdit,data.discount)
		guiSetText(stockEdit,data.stock)
		guiSetText(codeEdit,data.code)
		outputDebugString(data.item.." "..data.price.." "..data.discount.." "..data.stock.." "..data.code)
	end
	itemEditing = true
	outputDebugString("processed.")
end)