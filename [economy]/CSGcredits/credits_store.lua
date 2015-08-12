guiElements = {}
visible = false

crasher = {{{{{ {}, {}, {} }}}}}

function absoluteToRelativ2( X, Y )
    local rX, rY = guiGetScreenSize()
    local x = math.floor(X*rX/rX)
    local y = math.floor(Y*rY/rY)
    return x, y
end

function createGUI()
	--GUI itself--
	x,y = absoluteToRelativ2(232,39)
	width,height = absoluteToRelativ2(793,621)
	gui = guiCreateLabel(x,y,width,height,"",false)
	--BUY BUTTON--
	x,y = absoluteToRelativ2(13,575)
	width,height = absoluteToRelativ2(242,38)
	guiElements["buy"] = guiCreateButton(x,y,width,height, "Buy item", false, gui)
	guiSetProperty(guiElements["buy"], "NormalTextColour", "FFAAAAAA")
	--CLOSE BUTTON--
	x,y = absoluteToRelativ2(13+260,575)
	width,height = absoluteToRelativ2(242,38)
	guiElements["close"] = guiCreateButton(x,y,width,height, "Cancel - Close", false,gui)
	guiSetProperty(guiElements["close"], "NormalTextColour", "FFAAAAAA")
	--BACK BUTTON--
	x,y = absoluteToRelativ2(13+525,575)
	width,height = absoluteToRelativ2(242,38)
	guiElements["back"] = guiCreateButton(x,y,width,height, "Back to main", false,gui)
	guiSetProperty(guiElements["back"], "NormalTextColour", "FFAAAAAA")
	--GRIDLIST--
	x,y = absoluteToRelativ2(13,100)
	width,height = absoluteToRelativ2(769,448)
	guiElements["grid"] = guiCreateGridList(x,y,width,height, false,gui)
	ID = guiGridListAddColumn(guiElements["grid"], "ID", 0.05)
	ITEM = guiGridListAddColumn(guiElements["grid"], "Item", 0.2)
	PRICE = guiGridListAddColumn(guiElements["grid"], "Price (credits)", 0.1)
	DISCRIPTION = guiGridListAddColumn(guiElements["grid"], "Discription", 0.5)
	STOCK = guiGridListAddColumn(guiElements["grid"], "Stock", 0.12)
	
	guiSetVisible(gui,false)
end
addEventHandler("onClientResourceStart",resourceRoot,createGUI)

addEventHandler("onClientGUIClick",root,
function(button,state)
	if button == "left" and state == "up" then
		if (source == guiElements["buy"]) then
			outputDebugString("Buy button clicked.")
			itemID = guiGridListGetItemText(guiElements["grid"],guiGridListGetSelectedItem(guiElements["grid"]),ID)
			if (itemID) then
				triggerServerEvent("onStorePurchase",localPlayer,itemID)
			end
		elseif (source == guiElements["back"]) then
			outputDebugString("back button hitted.")
			if (visible == true) then
				guiGridListClear(guiElements["grid"])
				removeEventHandler("onClientRender",root,drawBackground)
				guiSetVisible(gui,false) --label visiblility
				showCursor(false)
				visible = false
			end
			triggerServerEvent("toggleCreditsMain",root,localPlayer)
		elseif (source == guiElements["close"]) then
			outputDebugString("close button pressed.")
			if (visible == true) then
				guiGridListClear(guiElements["grid"])
				removeEventHandler("onClientRender",root,drawBackground)
				guiSetVisible(gui,false)
				visible = false
				showCursor(false)
			end
		end
	end
end)

function drawBackground() --background
	--Dark Background
	x,y = absoluteToRelativ2(232,39)
	width,height = absoluteToRelativ2(793,621)
	dxDrawRectangle(x,y,width,height, tocolor(3, 0, 0, 158), false)
	--TEXT--
	x,y = absoluteToRelativ2(243,49)
	width,height = absoluteToRelativ2(1014,111)
	dxDrawText("CSG ~ Store", x,y,width,height, tocolor(255, 255, 255, 255), 2, "bankgothic", "center", "center", false, false, true, false, false)
	--LINE--
	x,y = absoluteToRelativ2(238,105)
	width,height = absoluteToRelativ2(1020,105)
	dxDrawLine(x,y,width,height, tocolor(255, 255, 255, 255), 1, true)
end

function toggleStoreView()
	if (visible == false) then
		guiSetVisible(gui,true)
		visible = true
		showCursor(true)
		addEventHandler("onClientRender",root,drawBackground)
		collectStoreItems(localPlayer)
	else
		guiSetVisible(gui,false)
		visible = false
		showCursor(false)
		removeEventHandler("onClientRender",root,drawBackground)
		guiGridListClear(guiElements["grid"])
	end
end
addCommandHandler("store",toggleStoreView)

function placeStoreItems(table)
	if table then
		outputDebugString("Table sent, storing data on gridlist...",0,0,255,0)
		guiGridListClear(guiElements["grid"])
		for k,v in ipairs(table) do
			row = guiGridListAddRow(guiElements["grid"])
			guiGridListSetItemText(guiElements["grid"],row,ID,v.id,false,false)
			guiGridListSetItemText(guiElements["grid"],row,ITEM,tostring(v.item),false,false)
			guiGridListSetItemText(guiElements["grid"],row,PRICE,v.price.." Credits",false,false)
			guiGridListSetItemText(guiElements["grid"],row,DISCRIPTION,v.description,false,false)
			if (v.stock == 0) then
				guiGridListSetItemText(guiElements["grid"],row,STOCK,"OUT OF STOCK",false,false)
			elseif (v.stock == -1) then
				guiGridListSetItemText(guiElements["grid"],row,STOCK,"INF",false,false)
			else
				guiGridListSetItemText(guiElements["grid"],row,STOCK,v.stock,false,false)
			end
		end
		outputDebugString("Data stored on gridlist.",0,0,255,0)
	end
end
addEvent("sendStoreData",true)
addEventHandler("sendStoreData",root,placeStoreItems)

function collectStoreItems(player)
	triggerServerEvent("getStoreData",player)
	outputDebugString("Calling server-side to collect all store items...",0,255,255,0)
end