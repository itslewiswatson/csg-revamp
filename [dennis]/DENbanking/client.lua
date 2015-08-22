crash = {{{{{{{{ {}, {}, {} }}}}}}}}
local bankingSpam = {}

local bankingMarkers = {
	[1] = {562.79998779297, -1254.5999755859, 16.89999961853, 284},
	[2] = {1001.700012207, -929.40002441406, 41.799999237061, 278.74658203125},
	[3] = {1019.4000244141, -1030, 31.700000762939, 358.49505615234},
	[4] = {926.79998779297, -1359.3000488281, 13, 272.49487304688},
	[5] = {1193.3994140625, -916.599609375, 42.799999237061, 6.492919921875},
	[6] = {485.39999389648, -1733.5999755859, 10.800000190735, 172.49389648438},
	[7] = {812.3994140625, -1618.7998046875, 13.199999809265, 90.488891601563},
	[8] = {1367, -1289.6999511719, 13.199999809265, 270},
	[9] = {1742.1999511719, -2284.3999023438, 13.199999809265, 270},
	[10] = {2105.5, -1804.3000488281, 13.199999809265, 270},
	[11] = {1760.099609375, -1940.099609375, 13.199999809265, 91.99951171875},
	[12] = {2404.1999511719, -1934.5999755859, 13.199999809265, 90},
	[13] = {1928.599609375, -1767.099609375, 13.199999809265, 91.99951171875},
	[14] = {2419.8999023438, -1506, 23.60000038147, 90},
	[15] = {2758.2998046875, -1824.3994140625, 11.5, 19.9951171875},
	[16] = {2404.3999023438, -1237.5, 23.5, 90},
	[17] = {2136.3000488281, -1154.1999511719, 23.60000038147, 152},
	[18] = {1182.5999755859, -1347.3000488281, 13.79999961853, 87.995849609375},
	[19] = {2027.19921875, -1401.8994140625, 16.89999961853, 359.99450683594},
	[20] = {1512.3000488281, -1583, 13.199999809265, 359.99499511719},
	[21] = {-2330.3000488281, -163.89999389648, 35.200000762939, 359.99450683594},
	[22] = {-1410.2998046875, -296.7998046875, 13.800000190735, 307.99072265625},
	[23] = {-2121.19921875, -451.2998046875, 35.180000305176, 279.99206542969},
	[24] = {-2708.5, -308.10000610352, 6.8000001907349, 225.98901367188},
	[25] = {-2695.5, 260.10000610352, 4.3000001907349, 179.98876953125},
	[26] = {-2672, 634.65002441406, 14.10000038147, 359.98352050781},
	[27] = {-2767.6000976563, 790.29998779297, 52.400001525879, 89.977996826172},
	[28] = {-2636.3000488281, 1399.1999511719, 6.6999998092651, 13.972534179688},
	[29] = {-2417.8999023438, 1028.8000488281, 50, 179.96911621094},
	[30] = {-2414.8999023438, 352.89999389648, 34.799999237061, 51.967041015625},
	[31] = {-1962, 123.40000152588, 27.299999237061, 269.96533203125},
	[32] = {-2024.7998046875, -102, 34.799999237061, 177.96203613281},
	[33] = {-1675.8000488281, 434, 6.8000001907349, 136},
	[34] = {-1967.19921875, 291.5, 34.799999237061, 269.96154785156},
	[35] = {-1813.8000488281, 618.40002441406, 34.799999237061, 357.99975585938},
	[36] = {-1911.1999511719, 824.40002441406, 34.799999237061, 87.994995117188},
	[37] = {-1571.0999755859, 697.29998779297, 6.8000001907349, 89.989501953125},
	[38] = {-1648.2998046875, 1214.19921875, 6.8000001907349, 135.98876953125},
	[39] = {-1872.0999755859, 1137.9000244141, 45.099998474121, 270},
	[40] = {-1806.19921875, 955.7998046875, 24.5, 89.989013671875},
	[41] = {2841.6000976563, 1270, 11, 269.75},
	[42] = {1437.599609375, 2647.7998046875, 11, 270},
	[43] = {2159.5, 939.29998779297, 10.5, 269.74731445313},
	[44] = {2020.1999511719, 999.20001220703, 10.5, 90},
	[45] = {2227.7998046875, 1402.7998046875, 10.699999809265, 90},
	[46] = {1590.8000488281, 703.29998779297, 10.5, 270},
	[47] = {1075.5999755859, 1596.6999511719, 12.199999809265, 212},
	[48] = {1591.6999511719, 2217.8999023438, 10.699999809265, 1},
	[49] = {997.8994140625, 2175.7998046875, 10.5, 87.994995117188},
	[50] = {1146.099609375, 2075, 10.699999809265, 0.999755859375},
	[51] = {1464.599609375, 2251.69921875, 10.699999809265, 178.99475097656},
	[52] = {1582.6999511719, 1758.5, 10.5, 268.99975585938},
	[53] = {1948.8000488281, 2062.1000976563, 10.699999809265, 268.99096679688},
	[54] = {2187.8000488281, 2464.1000976563, 10.89999961853, 88.989288330078},
	[55] = {2833.3000488281, 2402.8000488281, 10.699999809265, 44.9892578125},
	[56] = {2539.3999023438, 2080.1999511719, 10.5, 270.98901367188},
	[57] = {2179.5, 1702.8000488281, 10.699999809265, 272},
	[58] = {2102.2998046875, 2232.099609375, 10.699999809265, 90},
	[59] = {2638.3999023438, 1675.4000244141, 10.699999809265, 269.99951171875},
	[60] = {1381, 259.70001220703, 19.200000762939, 153.99450683594},
	[61] = {2334.2998046875, 67.69921875, 26.10000038147, 87.989501953125},
	[62] = {196.30000305176, -202, 1.2000000476837, 359.98986816406},
	[63] = {-2090, -2467.8000488281, 30.299999237061, 141.98904418945},
	[64] = {693.599609375, -520.3994140625, 16, 359.98901367188},
	[65] = {-2256.3999023438, 2376.3999023438, 4.5999999046326, 311.9873046875},
	[66] = {-2206.099609375, -2291.599609375, 30.299999237061, 139.98229980469},
	[67] = {-1511.4000244141, 2610.1999511719, 55.5, 359.98425292969},
	[68] = {-259.89999389648, 2605.8999023438, 62.5, 179.98352050781},
	[69] = {-1212.0999755859, 1833.5, 41.599998474121, 45.983520507813},
	[70] = {-856.29998779297, 1529, 22.200000762939, 89.983276367188},
	[71] = {-306.39999389648, 1054, 19.39999961853, 181.97805786133},
	[72] = {178.60000610352, 1173.1999511719, 14.39999961853, 323.9775390625},
	[73] = {-95.300003051758, 1110.6999511719, 19.39999961853, 359.97583007813},
	[74] = {776.8994140625, 1869.599609375, 4.5, 89.972534179688},
	[75] = {1212.93, -1816.11, 16.09, 84.675659179688},
	[76] = {-1943.1109082031, 2385.9528808594, 49.3753125, 112.00}
}

labels = {}
buttons = {}
edits = {}

function createBankWindow()
	-- Banking Window
	bankWindow = guiCreateWindow(402,65,628,396,"CSG ~ Banking System (V2)",false)
	guiWindowSetSizable(bankWindow,false)
	guiSetAlpha(bankWindow,1)

	--gridlist
	gridlist = guiCreateGridList(328,20,291,367,false,bankWindow)
	transCol = guiGridListAddColumn(gridlist,"Transaction",0.8)
	dateCol = guiGridListAddColumn(gridlist,"Date",0.6)

	labels[1] = guiCreateLabel(84,23,172,22,"Current Balance:",false,bankWindow)
	guiSetFont(labels[1],"default-bold-small")
	guiLabelSetHorizontalAlign(labels[1],"center",true)
	guiLabelSetVerticalAlign(labels[1],"center")
	labels[2] = guiCreateLabel(84,45,172,22,"$",false,bankWindow)
	guiSetFont(labels[2],"default-bold-small")
	guiLabelSetColor(labels[2],0,255,0)
	guiLabelSetHorizontalAlign(labels[2],"center",true)
	guiLabelSetVerticalAlign(labels[2],"center")

	edits[1] = guiCreateEdit(17,67,303,34,"",false,bankWindow)
	buttons[1] = guiCreateButton(18,102,148,28,"Withdraw",false,bankWindow)
	buttons[2] = guiCreateButton(172,102,148,28,"Deposit",false,bankWindow)
	guiSetProperty(buttons[1],"NormalTextColour","FFAAAAAA")
	guiSetProperty(buttons[2],"NormalTextColour","FFAAAAAA")
	labels[3] = guiCreateLabel(18,137,302,18,string.rep("-",77),false,bankWindow)
	labels[4] = guiCreateLabel(90,155,168,15,"Send other players bank money",false,bankWindow)
	labels[5] = guiCreateLabel(90,180,168,15,"Receiver:",false,bankWindow)
	guiLabelSetHorizontalAlign(labels[5],"center",false)
	guiLabelSetVerticalAlign(labels[5],"center")
	edits[2] = guiCreateEdit(15,195,303,34,"Username or Nickname if online",false,bankWindow)
	labels[6] = guiCreateLabel(90,239,168,15,"Amount of money:",false,bankWindow)
	guiLabelSetHorizontalAlign(labels[6],"center",false)
	guiLabelSetVerticalAlign(labels[6],"center")
	edits[3] = guiCreateEdit(15,254,303,34,"Money to Transfer",false,bankWindow)
	buttons[3] = guiCreateButton(15,291,303,29,"Send Money",false,bankWindow)
	guiSetProperty(buttons[3],"NormalTextColour","FFAAAAAA")
	labels[7] = guiCreateLabel(15,320,302,18,string.rep("-",77),false,bankWindow)
	buttons[4] = guiCreateButton(15,324,303,29,"Reset PIN Number",false,bankWindow)
	guiSetProperty(buttons[4],"NormalTextColour","FFAAAAAA")
	buttons[5] = guiCreateButton(15,359,303,29,"Close",false,bankWindow)
	--guiSetEnabled(buttons[3],false)
	--guiSetEnabled(buttons[4],false)


	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(bankWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(bankWindow,x,y,false)

	guiWindowSetMovable(bankWindow, true)
	guiWindowSetSizable(bankWindow, false)
	guiSetVisible(bankWindow, false)

	addEventHandler("onClientGUIClick", buttons[5], function () guiSetVisible(bankWindow, false) showCursor(false, false) guiGridListClear(gridlist) end, false)
	addEventHandler ("onClientGUIClick", buttons[1], withdrawMoney, false)
	addEventHandler ("onClientGUIClick", buttons[2], depositMoney, false)
	addEventHandler ("onClientGUIClick", buttons[3], sendPlayerMoney, false)
	addEventHandler ("onClientGUIClick", buttons[4], function () outputChatBox("This feature is not available yet.", 255, 0, 0) end, false)
end

addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		createBankWindow()
	end
)

addEvent("insertTransactions", true)
function insertTransactions(datum, transaction)
	local row = guiGridListAddRow(gridlist)
	guiGridListSetItemText(gridlist, row, dateCol, datum, false, false)
	guiGridListSetItemText(gridlist, row, transCol, transaction, false, false)
end
addEventHandler("insertTransactions", root, insertTransactions)

addEvent("showBankingGui", true)
function showBankingGui (balance)
	local vehicle = getPedOccupiedVehicle (localPlayer)
	local creditcard = getElementData(localPlayer, "creditcard")
    if not (vehicle) then
		guiSetVisible(bankWindow, true)
		showCursor(true, true)
		guiSetText(labels[2], "$"..balance)
		guiSetInputMode("no_binds_when_editing")
	end
	guiGridListClear(gridlist)
	triggerServerEvent("requestTransactions", localPlayer)

end
addEventHandler("showBankingGui", root, showBankingGui)

addEvent("updateBalanceLabel", true)
function updateBalanceLabel(newBalance)
	local convertedBalance = exports.server:convertNumber(tonumber(newBalance))
	guiSetText(labels[2], "$"..convertedBalance)
	playerBalance = newBalance
end
addEventHandler("updateBalanceLabel", root, updateBalanceLabel)

function sendPlayerMoney ()
	if not (onSpamProtection()) then
		exports.DENdxmsg:createNewDxMessage("To prevent spamming the bank system, you can't transfer money for 30 seconds.", 200, 0, 0)
		guiSetText (edits[2], "Username or Nickname if online") guiSetText (edits[3], "Money to Transfer")
	elseif string.match(guiGetText(edits[3]),'^%d+$') then
		local reciever = guiGetText (edits[2])
		local money = guiGetText (edits[3])
		if tonumber(money) < 1 then
			exports.DENdxmsg:createNewDxMessage("The minimum transfer amount is $1", 200, 0, 0)
			guiSetText (edits[2], "Username or Nickname if online") guiSetText (edits[3], "Money to Transfer")
		return
		end
		if reciever == "" then
			exports.DENdxmsg:createNewDxMessage("Enter the account you want to send money to.",200,0,0)
			guiSetText (edits[2], "Username or Nickname if online") guiSetText (edits[3], "Money to Transfer")
		elseif reciever == exports.server:getPlayerAccountName(localPlayer) then
			exports.DENdxmsg:createNewDxMessage("Why do you want to send money to yourself?...", 200,0,0)
			guiSetText (edits[2], "Username or Nickname if online") guiSetText (edits[3], "Money to Transfer")
		elseif tonumber(money) > tonumber(playerBalance) or tonumber(playerBalance) == 0 then
			exports.DENdxmsg:createNewDxMessage("You dont have enough money on your bank account!", 200,0,0)
			guiSetText (edits[2], "Username or Nickname if online") guiSetText (edits[3], "Money to Transfer")
		else
			local localPlayerMoney = playerBalance
			local recieverElement=false
			recieverElement = exports.server:getPlayerFromAccountname(reciever)
			if isElement(recieverElement) then else recieverElement = exports.server:getPlayerFromNamePart(reciever) end
			triggerServerEvent("CSGbanking.SPM", localPlayer, localPlayer,reciever, money, localPlayerMoney, recieverElement)
			guiSetText (edits[2], "Username or Nickname if online") guiSetText (edits[3], "Money to Transfer")
		end
	else
		exports.DENdxmsg:createNewDxMessage("Bad money input! Please enter only valid numbers",200,0,0)
	end
end

function withdrawMoney()
	if (not onSpamProtection()) then
		exports.DENdxmsg:createNewDxMessage("To prevent spamming the bank system, you can't transfer money for 30 seconds.", 200, 0, 0)
		guiSetText(edits[1], "")
	elseif (string.match(guiGetText(edits[1]),'^%d+$')) then
		local value = guiGetText(edits[1])
		if tonumber(value) > tonumber(playerBalance) then
			exports.DENdxmsg:createNewDxMessage("You do not have sufficient funds in your bank account!", 200, 0, 0)
		elseif (tonumber(playerBalance) == 0) then 
			exports.DENdxmsg:createNewDxMessage("You have no money in your bank account. You cannot withdraw any money.", 200, 0, 0)
		else
			triggerServerEvent("withdrawMoney", localPlayer, value)
			guiSetText(edits[1], "")
		end
	end
end

function depositMoney()
	if (not onSpamProtection()) then
		exports.DENdxmsg:createNewDxMessage("To prevent spamming the bank system, you can't transfer money for 30 seconds.", 200, 0, 0)
		guiSetText(edits[1], "")
	elseif string.match(guiGetText(edits[1]),'^%d+$') then
	
		local value = guiGetText(edits[1])
		local playerMoney = getPlayerMoney(localPlayer)
		
		if (tonumber(value) > tonumber(playerMoney)) then
			exports.DENdxmsg:createNewDxMessage("You can't deposit this much money, because you don't have it!", 200, 0, 0)
		elseif (playerMoney == 0) then
			exports.DENdxmsg:createNewDxMessage("You have nothing on hand. You can't deposit anything into the bank.", 200, 0, 0)
		elseif tonumber(guiGetText(edits[1])) <= 100 then
			exports.DENdxmsg:createNewDxMessage("The minimum deposit is $100", 200, 0, 0)
			guiSetText(edits[1], "")
		else
			triggerServerEvent("depositMoney", localPlayer, value)
			guiSetText(edits[1], "")
		end
	end
end

local theSpam = {}

function onSpamProtection ()
	if not (theSpam[localPlayer]) then
		theSpam[localPlayer] = 1
		return true
	elseif (theSpam[localPlayer] >= 4) then
		return false
	else
		theSpam[localPlayer] = theSpam[localPlayer] +1
		if (theSpam[localPlayer] >= 4) and not (isTimer(clearTimer)) then clearTimer = setTimer(clearSpamProtection, 40000, 1) end
		return true
	end
end

function clearSpamProtection ()
	if (theSpam[localPlayer]) then
		theSpam[localPlayer] = 0
	end
end

function bankMarkerHit(hitElement, matchingDimension)
	if (isPlayerNearAtmFromAir()) then
		triggerServerEvent("onBankMarkerHit", hitElement)
	end
end

for ID in pairs(bankingMarkers) do
	local x, y, z = bankingMarkers[ID][1], bankingMarkers[ID][2], bankingMarkers[ID][3]
	local rotation = bankingMarkers[ID][4]

	local bankMarker = createMarker(x,y,z -1,"cylinder",1,0, 104, 0 ,170)
	--outputDebugString(getZoneName(x,y,z))
	local createATM = createObject (2942, x, y, z, 0, 0, rotation)
	setObjectBreakable(createATM, false)
	setElementFrozen(createATM, true)

	addEventHandler("onClientMarkerHit", bankMarker, bankMarkerHit)
end

function isPlayerNearAtmFromAir ()
	local x, y, z = getElementPosition(localPlayer)
	for ID in pairs(bankingMarkers) do
		if (getDistanceBetweenPoints3D (x, y,z, bankingMarkers[ID][1], bankingMarkers[ID][2], bankingMarkers[ID][3]) < 2) then
			return true
		end
	end
	return false
end

function isPlayerNearATM()
	local x, y, z = getElementPosition(localPlayer)
	for ID in pairs(bankingMarkers) do
		if (getDistanceBetweenPoints2D (x, y, bankingMarkers[ID][1], bankingMarkers[ID][2]) < 1) then
			return true
		end
	end
	return false
end

function onPlayerHackATM ()
	if (isPlayerNearATM ()) then
		triggerServerEvent("onPlayerHackedATM", localPlayer, reward)
	else
		exports.DENdxmsg:createNewDxMessage("How do you want to hack a ATM if you're not near one!?", 255, 0, 0)
	end
end
addCommandHandler("hackatm", onPlayerHackATM)
