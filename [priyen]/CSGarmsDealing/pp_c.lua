------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  pp_c.luac (client-side)
--  Arms / Weapons Dealing
--  Priyen Patel
------------------------------------------------------------------------------------
local test = 0
GUIEditor_Label = {}

window = guiCreateWindow(500,362,399,247,"Community of Social Gaming ~ Weapon Dealing",false)
gridWeps = guiCreateGridList(9,23,381,151,false,window)
guiGridListSetSelectionMode(gridWeps,2)
btnSetPrice = guiCreateButton(267,178,121,26,"Set Price",false,window)
txtPrice = guiCreateEdit(133,177,132,27,"",false,window)
GUIEditor_Label[1] = guiCreateLabel(11,183,116,15,"Set Magazine Price:",false,window)
guiSetFont(GUIEditor_Label[1],"default-bold-small")
btnVend = guiCreateButton(9,209,188,26,"Toggle Vending",false,window)

btnExit = guiCreateButton(199,209,190,26,"Close window",false,window)
guiSetVisible(window,false)

guiGridListAddColumn(gridWeps,"Weapon",0.4)
guiGridListAddColumn(gridWeps,"Ammo(Magazines)",0.3)
guiGridListAddColumn(gridWeps,"$ / Mag",0.2)
guiGridListSetSelectionMode(gridWeps,0)

sellWindow = guiCreateWindow(500,362,399,213,"Community of Social Gaming ~ Weapon Dealing",false)
guiWindowSetSizable(sellWindow,false)
gridProducts = guiCreateGridList(9,23,382,151,false,sellWindow)
guiGridListSetSelectionMode(gridProducts,0)
btnBuy = guiCreateButton(143,178,121,26,"Buy Ammo",false,sellWindow)
txtBuyAmount = guiCreateEdit(9,177,132,28,"Amount Of Magazines",false,sellWindow)
btnExitShop = guiCreateButton(267,178,121,26,"Close Window",false,sellWindow)
guiGridListAddColumn(gridProducts,"Weapon",0.4)
guiGridListAddColumn(gridProducts,"Ammo(Magazines)",0.3)
guiGridListAddColumn(gridProducts,"$ / Mag",0.2)
guiSetVisible(sellWindow,false)

local vending = false
local first = true
local prices = {}
local ammo = {}
local seller = ""

local clips = {
	[22]=17,
	[23]=17,
	[24]=7,
	[25]=1,
	[26]=2,
	[27]=7,
	[28]=50,
	[29]=30,
	[32]=50,
	[30]=30,
	[31]=50,
	[33]=1,
	[34]=1
}


function vend(check)
	if check ~= false then
		if source ~= btnVend then return end
	end
	if isPedInVehicle(localPlayer) == true then
		 exports.DENdxmsg:createNewDxMessage("You cannot open Weapon Shop while in a vehicle", 255,0,0)
	return
	end
	if vending == false then
		if getElementData(localPlayer,"ho") == true then
		exports.DENdxmsg:createNewDxMessage("You cannot open Weapon Shop while House Panel is open", 255,0,0)
		return
		end
	vending = true
	else
	vending = false
	end
	updateAmmo()
	triggerServerEvent("ArmsDealingToggleVending",localPlayer,ammo)
	updateVendGUI(false)
end

function updatePrices()
	prices[22] = 65
	prices[23] = 65
	prices[24] = 95
	prices[25] = 200
	prices[26] = 210
	prices[27] = 250
	prices[30] = 450
	prices[31] = 500
	prices[28] = 350
	prices[29] = 400
	prices[32] = 350
	prices[33] = 350
	prices[34] = 500
end

function updateAmmo()
	for i=22,34,1 do
		ammo[i] = -1
	end
	for i=2,6,1 do
		local weapon = getPedWeapon(localPlayer,i)
		if weapon ~= 0 then
			ammo[weapon] = getPedTotalAmmo(localPlayer,i)
		end
	end
end

function setPrice()
	if source ~= btnSetPrice then return end
	if vending == true then
		 exports.DENdxmsg:createNewDxMessage("You cannot change prices while vending!", 255,0,0)
	return
	end
	local d = tonumber(guiGetText(txtPrice))
	local row = guiGridListGetSelectedItem(gridWeps)
	local name = guiGridListGetItemText(gridWeps,row,1)
	if row == nil or row == false or row == -1 or name == nil or name == -1 or name == false then
		 exports.DENdxmsg:createNewDxMessage("Please make sure you selected a weapon!", 255,0,0)
	return
	end

	if type(d) ~= "number" then
		 exports.DENdxmsg:createNewDxMessage("Please make sure there are only numbers in the price box!", 255,0,0)
	return
	end
	local id = getWeaponIDFromName(name)
	if tonumber(d) <= 0 then
		exports.DENdxmsg:createNewDxMessage("Price must be greater then $0", 255,0,0)
		return
	end
	prices[id] = price
	 exports.DENdxmsg:createNewDxMessage("Set Price "..name.." to $"..d.." / Magazine", 0,255,0)
	triggerServerEvent("ArmsDealingSetPrice",localPlayer,id,d)
	if first == true then
		vend(false)
		first = false
		vend(false)
	end
end

function ArmsDealingRecData(price,amm,consumer,selle,justHit)
	prices = price
	ammo = amm
	seller = selle
	if justHit == true then
		guiSetVisible(sellWindow,true)
		showCursor(true)
		if isElement(seller) then
			local sname = getPlayerName(seller)
			guiSetText(sellWindow,"Community of Social Gaming ~ "..sname.."'s Shop")
		end
	end
	updateVendGUI(consumer)
end
addEvent("ArmsDealingRecData",true)
addEventHandler("ArmsDealingRecData",localPlayer,ArmsDealingRecData)

function updateVendGUI(consumer)
	if consumer == true then grid = gridProducts else grid = gridWeps end
	guiGridListClear(grid)
	for k,v in pairs(prices) do
		if ammo[k] ~= -1 then
			local row = guiGridListAddRow(grid)
			local nam = getWeaponNameFromID(k)
			local totalAmmo = ammo[k]
			local mags = math.modf(totalAmmo/clips[k])

			guiGridListSetItemText ( grid, row, 1, nam, false, false )
			guiGridListSetItemText ( grid, row, 2, ""..totalAmmo.."("..mags..")", false, false )
			guiGridListSetItemText ( grid, row, 3, v, false, false )
		end
	end
end

function buy()
	if source ~= btnBuy then return end
	local d = guiGetText(txtBuyAmount)
	local row = guiGridListGetSelectedItem(gridProducts)
	if row == nil or row == false or row == -1 then
		 exports.DENdxmsg:createNewDxMessage("Please make sure you selected a weapon!", 255,0,0)
	return
	end
	d = tonumber(d)
	if type(d) ~= "number" then
		 exports.DENdxmsg:createNewDxMessage("Please make sure there are only numbers in the amount box!", 255,0,0)
	return
	end
	d=math.floor(d)
	if d <= 0 then
		exports.DENdxmsg:createNewDxMessage("Minimum purchase amount is 1", 255,0,0)
		return
	end

	local id = getWeaponIDFromName(guiGridListGetItemText(gridProducts,row,1))
	local name = guiGridListGetItemText(gridProducts,row,1)
	local stock = ammo[id]
	if stock < d*clips[id] then
		 exports.DENdxmsg:createNewDxMessage("The seller doesn't have the amount of ammo you want to buy", 255,0,0)
	return
	end
	local totalCost = d * tonumber(guiGridListGetItemText(gridProducts,row,3))
	if getPlayerMoney() < totalCost then
		 exports.DENdxmsg:createNewDxMessage("You can't afford "..d.." Magazines of "..name.."", 255,0,0)
	return
	end
	triggerServerEvent("ArmsDealingBuyingAmmo",localPlayer,id,d,seller)
end

function ArmsDealingSellerQuit()
	guiSetVisible(sellWindow,false)
	showCursor(false)
	 exports.DENdxmsg:createNewDxMessage("Weapon Shop has Closed, Dealer : left / quit / arrested / closed", 255,255,0)
end
addEvent("ArmsDealingSellerQuit",true)
addEventHandler("ArmsDealingSellerQuit",localPlayer,ArmsDealingSellerQuit)

function exitSellMenu(check)
	if check ~= false then
		if source ~= btnExit then return end
	end
	if vending == true then
		 exports.DENdxmsg:createNewDxMessage("Stop Vending before closing the menu!", 255,0,0)
		return
	end
	guiSetVisible(window,false)
	showCursor(false)
end

function wasted()
	if vending == true then
		vend(false)
	end
	guiSetVisible(window,false)
	guiSetVisible(sellWindow,false)
	showCursor(false)
end
addEventHandler("onClientPlayerWasted",localPlayer,wasted)

function exitShop(check)

	if source ~= btnExitShop then return end

	triggerServerEvent("ArmsDealingClosedShop",localPlayer)
	guiSetVisible(sellWindow,false)
	showCursor(false)
end

function sell()
	if guiGetVisible(window) == false then
		if isPedInVehicle(localPlayer) == true then
			 exports.DENdxmsg:createNewDxMessage("You cannot open Weapon Shop while in a vehicle", 255,0,0)
		return
		end
		if getElementData(localPlayer,"isPlayerArrested") == true then  exports.DENdxmsg:createNewDxMessage("You cannot open Weapon Shop while arrested!", 255,0,0) return end
		guiSetVisible(window,true)
		showCursor(true)
		updateAmmo()
		updateVendGUI(false)
	else
		exitSellMenu(false)
	end
end


addEventHandler("onClientGUIClick",btnSetPrice,setPrice)
addEventHandler("onClientGUIClick",btnVend,vend)
addEventHandler("onClientGUIClick",btnExit,exitSellMenu)
addEventHandler("onClientGUIClick",btnExitShop,exitShop)
addEventHandler("onClientGUIClick",btnBuy,buy)

--Waiting for Server to send Data
function start2()
	triggerServerEvent("armsDealingClientLoaded",localPlayer)
	addCommandHandler("sellweps",sell)
	addCommandHandler("sell",function()
		exports.dendxmsg:createNewDxMessage("Selling: Use /selldrugs to sell drugs, /sellweps to sell weapons",0,255,0)
	end)
end
setTimer(start2,6000,1)

function monitor()
	if vending == true then
		if getElementData(localPlayer,"isPlayerArrested") == true then
			if vending == false then vending = true else vending = false end
			updateAmmo()
			triggerServerEvent("ArmsDealingToggleVending",localPlayer,ammo)
		end
	end
end
setTimer(monitor,1000,0)

if fileExists("pp_c.lua") == true then
	fileDelete("pp_c.lua")
end
