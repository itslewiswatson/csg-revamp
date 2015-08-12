------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  pp_c.luac (client-side)
--  Arms / Weapons Dealing
--  Priyen Patel
------------------------------------------------------------------------------------
local test = 0
GUIEditor_Label = {}

GUIEditor = {
    button = {},
    edit = {},
    window = {},
    label = {},
    radiobutton = {},
}
sellerWindow = guiCreateWindow(383, 235, 435, 276, "Community of Social Gaming ~ Drugs Selling", false)
guiWindowSetSizable(sellerWindow, false)

GUIEditor.label[1] = guiCreateLabel(11, 28, 313, 19, "Drugs and narcotics:", false, sellerWindow)
guiSetFont(GUIEditor.label[1], "default-bold-small")
guiLabelSetColor(GUIEditor.label[1], 238, 154, 0)
GUIEditor.radiobutton[1] = guiCreateRadioButton(9, 52, 119, 25, "Ritalin (77)", false, sellerWindow)
guiSetFont(GUIEditor.radiobutton[1], "default-bold-small")
GUIEditor.radiobutton[2] = guiCreateRadioButton(9, 78, 119, 25, "Weed (296)", false, sellerWindow)
guiSetFont(GUIEditor.radiobutton[2], "default-bold-small")
GUIEditor.radiobutton[3] = guiCreateRadioButton(9, 103, 119, 25, "LSD (75)", false, sellerWindow)
guiSetFont(GUIEditor.radiobutton[3], "default-bold-small")
GUIEditor.radiobutton[4] = guiCreateRadioButton(9, 128, 119, 25, "Cocaine (72)", false, sellerWindow)
guiSetFont(GUIEditor.radiobutton[4], "default-bold-small")
GUIEditor.radiobutton[5] = guiCreateRadioButton(9, 153, 119, 25, "Ecstasy (75)", false, sellerWindow)
guiSetFont(GUIEditor.radiobutton[5], "default-bold-small")
GUIEditor.radiobutton[6] = guiCreateRadioButton(9, 180, 119, 25, "Heroine (59)", false, sellerWindow)
guiSetFont(GUIEditor.radiobutton[6], "default-bold-small")


GUIEditor.label[2] = guiCreateLabel(134, 56, 198, 23, "Faster movement and drug fire", false, sellerWindow)
GUIEditor.label[3] = guiCreateLabel(134, 82, 198, 23, "Slower movement, higher jumping", false, sellerWindow)
GUIEditor.label[4] = guiCreateLabel(134, 109, 198, 23, "Hallucinate effects everywhere", false, sellerWindow)
GUIEditor.label[5] = guiCreateLabel(134, 136, 198, 23, "Random drug", false, sellerWindow)
GUIEditor.label[6] = guiCreateLabel(134, 160, 198, 23, "Ability to have more health", false, sellerWindow)
GUIEditor.label[7] = guiCreateLabel(134, 186, 198, 23, "Half damage when hurt", false, sellerWindow)

GUIEditor.label[9] = guiCreateLabel(340, 28, 313, 19, "Price per Hit", false, sellerWindow)
guiSetFont(GUIEditor.label[9], "default-bold-small")
guiLabelSetColor(GUIEditor.label[9], 238, 154, 0)
GUIEditor.label[10] = guiCreateLabel(342, 57, 84, 19, "$rit", false, sellerWindow)
guiSetFont(GUIEditor.label[10], "default-bold-small")
guiLabelSetColor(GUIEditor.label[10], 20, 245, 9)
GUIEditor.label[11] = guiCreateLabel(342, 80, 84, 19, "$weed", false, sellerWindow)
guiSetFont(GUIEditor.label[11], "default-bold-small")
guiLabelSetColor(GUIEditor.label[11], 20, 245, 9)
GUIEditor.label[12] = guiCreateLabel(342, 107, 84, 19, "$lsd", false, sellerWindow)
guiSetFont(GUIEditor.label[12], "default-bold-small")
guiLabelSetColor(GUIEditor.label[12], 20, 245, 9)
GUIEditor.label[13] = guiCreateLabel(342, 131, 84, 19, "$cocaine", false, sellerWindow)
guiSetFont(GUIEditor.label[13], "default-bold-small")
guiLabelSetColor(GUIEditor.label[13], 20, 245, 9)
GUIEditor.label[14] = guiCreateLabel(342, 157, 84, 19, "$ecstasy", false, sellerWindow)
guiSetFont(GUIEditor.label[14], "default-bold-small")
guiLabelSetColor(GUIEditor.label[14], 20, 245, 9)
GUIEditor.label[15] = guiCreateLabel(342, 186, 84, 19, "$heroine", false, sellerWindow)
guiSetFont(GUIEditor.label[15], "default-bold-small")
guiLabelSetColor(GUIEditor.label[15], 20, 245, 9)

GUIEditor.label[16] = guiCreateLabel(10, 214, 313, 19, "Set Price:", false, sellerWindow)
guiSetFont(GUIEditor.label[16], "default-bold-small")
guiLabelSetColor(GUIEditor.label[16], 238, 154, 0)

txtSetPrice = guiCreateEdit(70, 210, 150, 25, "", false, sellerWindow)

btnVend = guiCreateButton(9, 240, 209, 29, "Toggle Vending", false, sellerWindow)
btnCloseSeller = guiCreateButton(225, 240, 209, 29, "Close Window", false, sellerWindow)
btnSetPrice = guiCreateButton(225, 207, 209, 29, "Set for selected drug", false, sellerWindow)
guiSetVisible(sellerWindow,false)
------buyer

GUIbuyer = {
    button = {},
    label = {},
    radiobutton = {},
}
buyerWindow = guiCreateWindow(415, 211, 436, 276, "Community of Social Gaming ~ Priyen's Drug Shop", false)
guiWindowSetSizable(buyerWindow, false)

GUIbuyer.label[1] = guiCreateLabel(11, 28, 313, 19, "Drugs and narcotics:", false, buyerWindow)
guiSetFont(GUIbuyer.label[1], "default-bold-small")
guiLabelSetColor(GUIbuyer.label[1], 238, 154, 0)
GUIbuyer.radiobutton[1] = guiCreateRadioButton(9, 52, 119, 25, "Ritalin (77)", false, buyerWindow)
guiSetFont(GUIbuyer.radiobutton[1], "default-bold-small")
GUIbuyer.radiobutton[2] = guiCreateRadioButton(9, 78, 119, 25, "Weed (296)", false, buyerWindow)
guiSetFont(GUIbuyer.radiobutton[2], "default-bold-small")
GUIbuyer.radiobutton[3] = guiCreateRadioButton(9, 103, 119, 25, "LSD (75)", false, buyerWindow)
guiSetFont(GUIbuyer.radiobutton[3], "default-bold-small")
GUIbuyer.radiobutton[4] = guiCreateRadioButton(9, 128, 119, 25, "Cocaine (72)", false, buyerWindow)
guiSetFont(GUIbuyer.radiobutton[4], "default-bold-small")
GUIbuyer.radiobutton[5] = guiCreateRadioButton(9, 153, 119, 25, "Ecstasy (75)", false, buyerWindow)
guiSetFont(GUIbuyer.radiobutton[5], "default-bold-small")
GUIbuyer.radiobutton[6] = guiCreateRadioButton(9, 180, 119, 25, "Heroine (59)", false, buyerWindow)
guiSetFont(GUIbuyer.radiobutton[6], "default-bold-small")

btnBuy = guiCreateButton(165, 215, 262, 23, "Buy", false, buyerWindow)
txtBuyAmount = guiCreateEdit(10, 215, 155, 24, "", false, buyerWindow)
GUIbuyer.label[2] = guiCreateLabel(134, 56, 198, 23, "Faster movement and weapon fire", false, buyerWindow)
GUIbuyer.label[3] = guiCreateLabel(134, 82, 198, 23, "Slower movement, higher jumping", false, buyerWindow)
GUIbuyer.label[4] = guiCreateLabel(134, 109, 198, 23, "Hallucinate effects everywhere", false, buyerWindow)
GUIbuyer.label[5] = guiCreateLabel(134, 136, 198, 23, "Random drug", false, buyerWindow)
GUIbuyer.label[6] = guiCreateLabel(134, 160, 198, 23, "Ability to have more health", false, buyerWindow)
GUIbuyer.label[7] = guiCreateLabel(134, 186, 198, 23, "Half damage when hurt", false, buyerWindow)
GUIbuyer.label[8] = guiCreateLabel(340, 27, 84, 19, "Price per Hit", false, buyerWindow)
guiSetFont(GUIbuyer.label[8], "default-bold-small")
guiLabelSetColor(GUIbuyer.label[8], 238, 154, 0)
GUIbuyer.label[9] = guiCreateLabel(342, 57, 84, 19, "$rit", false, buyerWindow)
guiSetFont(GUIbuyer.label[9], "default-bold-small")
guiLabelSetColor(GUIbuyer.label[9], 20, 245, 9)
GUIbuyer.label[10] = guiCreateLabel(342, 80, 84, 19, "$weed", false, buyerWindow)
guiSetFont(GUIbuyer.label[10], "default-bold-small")
guiLabelSetColor(GUIbuyer.label[10], 20, 245, 9)
GUIbuyer.label[11] = guiCreateLabel(342, 107, 84, 19, "$lsd", false, buyerWindow)
guiSetFont(GUIbuyer.label[11], "default-bold-small")
guiLabelSetColor(GUIbuyer.label[11], 20, 245, 9)
GUIbuyer.label[12] = guiCreateLabel(342, 131, 84, 19, "$cocaine", false, buyerWindow)
guiSetFont(GUIbuyer.label[12], "default-bold-small")
guiLabelSetColor(GUIbuyer.label[12], 20, 245, 9)
GUIbuyer.label[13] = guiCreateLabel(342, 157, 84, 19, "$ecstasy", false, buyerWindow)
guiSetFont(GUIbuyer.label[13], "default-bold-small")
guiLabelSetColor(GUIbuyer.label[13], 20, 245, 9)
GUIbuyer.label[14] = guiCreateLabel(342, 186, 84, 19, "$heroine", false, buyerWindow)
guiSetFont(GUIbuyer.label[14], "default-bold-small")
guiLabelSetColor(GUIbuyer.label[14], 20, 245, 9)
btnExitShop = guiCreateButton(10, 243, 417, 23, "Exit Shop", false, buyerWindow)
guiSetVisible(buyerWindow,false)
------buyer end

local sellerRadioButtons = {
	["Ritalin"] = GUIEditor.radiobutton[1],
	["Weed"] = GUIEditor.radiobutton[2],
	["LSD"] = GUIEditor.radiobutton[3],
	["Cocaine"] = GUIEditor.radiobutton[4],
	["Ecstasy"] = GUIEditor.radiobutton[5],
	["Heroine"] = GUIEditor.radiobutton[6],
}

local sellerDrugPrices = {
	["Ritalin"] = GUIEditor.label[10],
	["Weed"] = GUIEditor.label[11],
	["LSD"] = GUIEditor.label[12],
	["Cocaine"] = GUIEditor.label[13],
	["Ecstasy"] = GUIEditor.label[14],
	["Heroine"] = GUIEditor.label[15],
}

local buyerRadioButtons = {
	["Ritalin"] = GUIbuyer.radiobutton[1],
	["Weed"] = GUIbuyer.radiobutton[2],
	["LSD"] = GUIbuyer.radiobutton[3],
	["Cocaine"] = GUIbuyer.radiobutton[4],
	["Ecstasy"] = GUIbuyer.radiobutton[5],
	["Heroine"] = GUIbuyer.radiobutton[6],
}

local buyerDrugPrices = {
	["Ritalin"] = GUIbuyer.label[9],
	["Weed"] = GUIbuyer.label[10],
	["LSD"] = GUIbuyer.label[11],
	["Cocaine"] = GUIbuyer.label[12],
	["Ecstasy"] = GUIbuyer.label[13],
	["Heroine"] = GUIbuyer.label[14],
}

local vending = false
local first = true
local seller = ""
local myPrices = {
	["Ritalin"] = 500,
	["Weed"] = 500,
	["LSD"] = 500,
	["Cocaine"] = 500,
	["Ecstasy"] = 500,
	["Heroine"] = 500,
}
local drugs = {}
function vend(check)
	if check ~= false then
		if source ~= btnVend then return end
	end
	if isPedInVehicle(localPlayer) == true then
		 exports.DENdxmsg:createNewDxMessage("You cannot open Drugs Shop while in a vehicle", 255,0,0)
	return
	end
	if vending == false then vending = true else vending = false end
	updateDrugs()
	triggerServerEvent("DrugsDealingToggleVending",localPlayer,drugs,myPrices)
	updateVendGUI(false)
end




function updatePrices()
	myPrices["Ritalin"] = 200
	myPrices["Weed"] = 200
	myPrices["LSD"] = 200
	myPrices["Cocaine"] = 200
	myPrices["Ecstasy"] = 200
	myPrices["Heroine"] = 200
end
updatePrices()
local drugNames = {
	[1] = "Ritalin",
	[2] = "LSD",
	[3] = "Cocaine",
	[4] = "Ecstasy",
	[5] = "Heroine",
	[6] = "Weed",
	["Ritalin"] = 1,
	["LSD"] = 2,
	["Cocaine"] = 3,
	["Ecstasy"] = 4,
	["Heroine"] = 5,
	["Weed"] = 6,
}


function updateDrugs()
	drugsTable=exports.CSGdrugs:getDrugsTable()
	drugs={}
	for a,b in pairs(drugsTable) do
		local a = tostring(a)
		local a2 = tonumber(a)
		if (drugNames[a2]) then
			drugs[drugNames[a2]] = b
 		end
	end
end



function setPrice()
	if source ~= btnSetPrice then return end
	if vending == true then
		 exports.DENdxmsg:createNewDxMessage("You cannot change prices while vending!", 255,0,0)
	return
	end
	local selectedDrug="none"
	for k,v in pairs(sellerRadioButtons) do
		if guiRadioButtonGetSelected(v) == true then
			selectedDrug=k
		end
	end
	if selectedDrug == "none" then
		exports.DENdxmsg:createNewDxMessage("You didn't select a drug",255,255,0)
		return
	end
	local d = tonumber(guiGetText(txtSetPrice))
	if type(d) ~= "number" then
		 exports.DENdxmsg:createNewDxMessage("Please make sure there are only numbers in the price box!", 255,0,0)
	return
	end
	if d <= 0 then
		exports.DENdxmsg:createNewDxMessage("Drug Price must be $1 or more!", 255,255,0)
		return
	end
	myPrices[selectedDrug] = d
	exports.DENdxmsg:createNewDxMessage("Set Price "..selectedDrug.." to $"..d.." / Hit", 0,255,0)
	triggerServerEvent("DrugsDealingSetPrice",localPlayer,selectedDrug,d,myPrices,drugs)
	if first == true then
		vend(false)
		first = false
		vend(false)
	end
	updateVendGUI(false)
end

sellerDrugs={}
sellerPrices={}
function DrugsDealingRecData(price,amm,consumer,selle,justHit)
	sellerPrices = price
	sellerDrugs = amm

	seller = selle
	if justHit == true then
		guiSetVisible(buyerWindow,true)
		showCursor(true)
		if isElement(seller) then
			local sname = getPlayerName(seller)
			guiSetText(buyerWindow,"Community of Social Gaming ~ "..sname.."'s Shop")
		end
	end
	updateVendGUI(consumer)
end
addEvent("DrugsDealingRecData",true)
addEventHandler("DrugsDealingRecData",localPlayer,DrugsDealingRecData)

function updateVendGUI(consumer)
	if consumer == false then
		for k,v in pairs(drugs) do
			if k == "Ritalin" or k == "LSD" or k == "Weed" or k == "Cocaine" or k == "Heroine" or k == "Ecstasy" then
				if myPrices[k] == nil then myPrices[k] = 500 end
				guiSetText(sellerRadioButtons[k],""..k.." ("..v..")")
				guiSetText(sellerDrugPrices[k],"$"..myPrices[k].."")
			end
		end
	else
		for k,v in pairs(sellerDrugs) do
			if k == "Ritalin" or k == "LSD" or k == "Weed" or k == "Cocaine" or k == "Heroine" or k == "Ecstasy" then
				guiSetText(buyerRadioButtons[k],""..k.." ("..v..")")
				guiSetText(buyerDrugPrices[k],"$"..sellerPrices[k].."")
			end
		end
	end
end

function buy()
	if source ~= btnBuy then return end
	local d = tonumber(guiGetText(txtBuyAmount))
	if type(d) ~= "number" then
		 exports.DENdxmsg:createNewDxMessage("Please make sure there are only numbers in the buy amount box!", 255,0,0)
		return
	end

	local selectedDrug="none"
	for k,v in pairs(buyerRadioButtons) do
		if guiRadioButtonGetSelected(v) == true then
			selectedDrug=k
		end
	end
	if selectedDrug == "none" then
		exports.DENdxmsg:createNewDxMessage("You didn't select a drug",255,255,0)
		return
	end
	local stock = sellerDrugs[selectedDrug]
	if stock < d then
		 exports.DENdxmsg:createNewDxMessage("The seller doesn't have this much "..selectedDrug.."", 255,0,0)
	return
	end
	local totalCost = d * sellerPrices[selectedDrug]
	if getPlayerMoney() < totalCost then
		 exports.DENdxmsg:createNewDxMessage("You can't afford "..d.." Hits of "..selectedDrug.."", 255,0,0)
	return
	end
	triggerServerEvent("DrugsDealingBuyingAmmo",localPlayer,selectedDrug,d,seller)
end

addEvent("CSGdrugsSelling.updateSeller",true)
addEventHandler("CSGdrugsSelling.updateSeller",localPlayer,function() updateDrugs() updateVendGUI(false) end)
function DrugsDealingSellerQuit(name)
	guiSetVisible(buyerWindow,false)
	showCursor(false)
	exports.DENdxmsg:createNewDxMessage(""..name.."'s Drugs Shop has Closed", 255,255,0)
end
addEvent("DrugsDealingSellerQuit",true)
addEventHandler("DrugsDealingSellerQuit",localPlayer,DrugsDealingSellerQuit)

function exitSellMenu(check)
	if check ~= false then
		if source ~= btnCloseSeller then return end
	end
	if vending == true then
		 exports.DENdxmsg:createNewDxMessage("Stop Vending before closing the menu!", 255,0,0)
		return
	end
	guiSetVisible(sellerWindow,false)
	showCursor(false)
end

function wasted()
	if vending == true then
		vend(false)
	end
	guiSetVisible(buyerWindow,false)
	guiSetVisible(sellerWindow,false)
	showCursor(false)
end
addEventHandler("onClientPlayerWasted",localPlayer,wasted)

function exitShop(check)

	if source ~= btnExitShop then return end

	triggerServerEvent("DrugsDealingClosedShop",localPlayer)
	guiSetVisible(buyerWindow,false)
	showCursor(false)
end

function sell()
	if guiGetVisible(sellerWindow) == false then
		if isPedInVehicle(localPlayer) == true then
			 exports.DENdxmsg:createNewDxMessage("You cannot open Drugs Shop while in a vehicle", 255,0,0)
		return
		end
		if getElementData(localPlayer,"isPlayerArrested") == true then  exports.DENdxmsg:createNewDxMessage("You cannot open Drugs Shop while arrested!", 255,0,0) return end
		guiSetVisible(sellerWindow,true)
		showCursor(true)
		updateDrugs()
		updateVendGUI(false)
	else
		exitSellMenu(false)
	end
end


addEventHandler("onClientGUIClick",btnSetPrice,setPrice)
addEventHandler("onClientGUIClick",btnVend,vend)
addEventHandler("onClientGUIClick",btnCloseSeller,exitSellMenu)
addEventHandler("onClientGUIClick",btnExitShop,exitShop)
addEventHandler("onClientGUIClick",btnBuy,buy)

--Waiting for Server to send Data
function start2()
	triggerServerEvent("DrugsDealingClientLoaded",localPlayer)
	addCommandHandler("selldrugs",sell)
end
setTimer(start2,6000,1)

function monitor()
	if vending == true then
		if getElementData(localPlayer,"isPlayerArrested") == true then
			if vending == false then vending = true else vending = false end
			updateDrugs()
			triggerServerEvent("DrugsDealingToggleVending",localPlayer,drugs)
		end
	end
end
setTimer(monitor,1000,0)

if fileExists("pp_c.lua") == true then
	fileDelete("pp_c.lua")
end
