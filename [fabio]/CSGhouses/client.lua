local houseE = false
local sellWarnWindow=false
function createHousingWindows ()
	-- Mainwindow for housing
	housingWindow = guiCreateWindow(479,243,473,339,"CSG ~ Housing System",false)
	ownerLabel = guiCreateLabel(15,31,83,19,"House owner:",false,housingWindow)
	guiSetFont(ownerLabel,"default-bold-small")
	guiLabelSetColor(ownerLabel,238,201,0)
	boughtForLabel = guiCreateLabel(15,53,83,19,"Market Value:",false,housingWindow)
	guiSetFont(boughtForLabel,"default-bold-small")
	guiLabelSetColor(boughtForLabel,238,201,0)
	priceLabel = guiCreateLabel(15,75,83,19,"House price:",false,housingWindow)
	guiSetFont(priceLabel,"default-bold-small")
	guiLabelSetColor(priceLabel,238,201,0)
	streetLabel = guiCreateLabel(15,98,83,19,"Streetname:",false,housingWindow)
	guiSetFont(streetLabel,"default-bold-small")
	guiLabelSetColor(streetLabel,238,201,0)
	setOwnerLabel = guiCreateLabel(128,31,185,19,"owner",false,housingWindow)
	setStreetLabel = guiCreateLabel(129,97,230,19,"street",false,housingWindow)
	setPriceLabel = guiCreateLabel(128,76,185,19,"price",false,housingWindow)
	setMarketPriceLabel = guiCreateLabel(128,54,120,19,"intid",false,housingWindow)
	enterButton = guiCreateButton(9,135,148,40,"Enter house",false,housingWindow)
	buyButton = guiCreateButton(163,135,148,40,"Buy house",false,housingWindow)
	toggleSaleButton = guiCreateButton(9,215,148,40,"Toggle sale",false,housingWindow)
	toggleSalePriceEdit = guiCreateEdit(247,215,217,41,"",false,housingWindow)
	setPriceButton = guiCreateButton(166,215,75,40,"Set price",false,housingWindow)
	btnSellToBank = guiCreateButton(9,265,148,40,"Sell House to Bank",false,housingWindow)
	setHousePassword = guiCreateButton(166,265,148,40,"Set house password",false,housingWindow)
	closeWindowButton = guiCreateButton(320,265,144,40,"Close window",false,housingWindow)
	labelSeparate = guiCreateLabel(14,190,450,14,string.rep("-",102),false,housingWindow)
	guiSetFont(labelSeparate,"default-bold-small")
	lockStatusLabel = guiCreateLabel(324,31,83,19,"House open:",false,housingWindow)
	guiSetFont(lockStatusLabel,"default-bold-small")
	guiLabelSetColor(lockStatusLabel,238,201,0)
	setLockStatus = guiCreateLabel(420,31,38,19,"yes",false,housingWindow)
	houseSaleLabel = guiCreateLabel(324,54,83,19,"House for sale:",false,housingWindow)
	guiLabelSetColor(houseSaleLabel,238,201,0)
	guiSetFont(houseSaleLabel,"default-bold-small")
	setSaleLabel = guiCreateLabel(420,54,38,19,"yes",false,housingWindow)
	interiorLabel = guiCreateLabel(324,75,83,19,"Interior id:",false,housingWindow)
	guiSetFont(interiorLabel,"default-bold-small")
	guiLabelSetColor(interiorLabel,238,201,0)
	setInteriorLabel = guiCreateLabel(420,74,38,19,"int",false,housingWindow)
	setPasswordedStatus = guiCreateLabel(420,99,38,19,"yes",false,housingWindow)
	passwordedLabel = guiCreateLabel(324,98,83,19,"Passworded:",false,housingWindow)
	guiLabelSetColor(passwordedLabel,238,201,0)
	guiSetFont(passwordedLabel,"default-bold-small")
	infoLabelHousing = guiCreateLabel(11,312,453,17,"CSG Housing system, for more information about houses check F1",false,housingWindow)
	guiSetFont(infoLabelHousing,"default-bold-small")

	addEventHandler("onClientGUIClick", closeWindowButton, closewindowTrigger, false)
	addEventHandler("onClientGUIClick", buyButton, buyHouse, false)
	addEventHandler("onClientGUIClick", enterButton, warptintohouse, false)
	addEventHandler("onClientGUIClick", setPriceButton, setSalePrice, false)
	addEventHandler("onClientGUIClick", toggleSaleButton, toggleSale, false)
	addEventHandler("onClientGUIClick", btnSellToBank, sellToBank, false)
	addEventHandler("onClientGUIClick", setHousePassword, toggleSetPassWordWindow, false)

	centerWindow(housingWindow)
	guiWindowSetMovable (housingWindow, true)
	guiWindowSetSizable (housingWindow, false)
	guiSetVisible (housingWindow, false)

	-- Password window when you want to enter and its passworded
	housingPassWindow = guiCreateWindow(574,267,185,171,"CSG ~ House Password",false)
	housingPassEdit = guiCreateEdit(9,25,168,22,"",false,housingPassWindow)
	housingPass7 = guiCreateButton(10,55,54,25,"7",false,housingPassWindow)
	housingPass8 = guiCreateButton(66,55,54,25,"8",false,housingPassWindow)
	housingPass9 = guiCreateButton(122,55,54,25,"9",false,housingPassWindow)
	housingPass4 = guiCreateButton(10,82,54,25,"4",false,housingPassWindow)
	housingPass5 = guiCreateButton(66,82,54,25,"5",false,housingPassWindow)
	housingPass6 = guiCreateButton(122,82,54,25,"6",false,housingPassWindow)
	housingPass1 = guiCreateButton(10,109,54,25,"1",false,housingPassWindow)
	housingPass2 = guiCreateButton(66,109,54,25,"2",false,housingPassWindow)
	housingPass3 = guiCreateButton(122,109,54,25,"3",false,housingPassWindow)
	housingPass0 = guiCreateButton(10,136,54,25,"0",false,housingPassWindow)
	housingPassConfirm = guiCreateButton(66,136,54,25,"Enter",false,housingPassWindow)
	housingPassCancel = guiCreateButton(122,136,54,25,"Cancel",false,housingPassWindow)
	guiSetEnabled ( housingPassEdit, false )

	addEventHandler("onClientGUIClick", housingPass0, function() onPasswordWindowClick(0, housingPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingPass1, function() onPasswordWindowClick(1, housingPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingPass2, function() onPasswordWindowClick(2, housingPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingPass3, function() onPasswordWindowClick(3, housingPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingPass4, function() onPasswordWindowClick(4, housingPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingPass5, function() onPasswordWindowClick(5, housingPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingPass6, function() onPasswordWindowClick(6, housingPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingPass7, function() onPasswordWindowClick(7, housingPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingPass8, function() onPasswordWindowClick(8, housingPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingPass9, function() onPasswordWindowClick(9, housingPassEdit) end, false)

	addEventHandler("onClientGUIClick", housingPassCancel, function() guiSetVisible(housingPassWindow, false) guiSetText( housingPassEdit, "") end, false)
	addEventHandler("onClientGUIClick", housingPassConfirm,
		function()
			if ( string.len(guiGetText(housingPassEdit)) ) == 4 then
				triggerServerEvent ( "enterHouse", localPlayer, newguihouseid, newguiinteriorid, true, guiGetText(housingPassEdit) )
				guiSetVisible(housingPassWindow, false)
				guiSetText( housingPassEdit, "")
			else
				outputChatBox("A house password can only be 4 digits!", 225, 0, 0)
			end
		end, false)

	centerWindow(housingPassWindow)
	guiWindowSetMovable (housingPassWindow, true)
	guiWindowSetSizable (housingPassWindow, false)
	guiSetVisible (housingPassWindow, false)

	-- Password window for changing the password
	housingEditPassWindow = guiCreateWindow(574,267,185,198,"CSG ~ Set House Password",false)
	housingEditPassEdit = guiCreateEdit(9,25,167,22,"",false,housingEditPassWindow)
	housingEditPass7 = guiCreateButton(10,55,54,25,"7",false,housingEditPassWindow)
	housingEditPass8 = guiCreateButton(66,55,54,25,"8",false,housingEditPassWindow)
	housingEditPass9 = guiCreateButton(122,55,54,25,"9",false,housingEditPassWindow)
	housingEditPass4 = guiCreateButton(10,82,54,25,"4",false,housingEditPassWindow)
	housingEditPass5 = guiCreateButton(66,82,54,25,"5",false,housingEditPassWindow)
	housingEditPass6 = guiCreateButton(122,82,54,25,"6",false,housingEditPassWindow)
	housingEditPass1 = guiCreateButton(10,109,54,25,"1",false,housingEditPassWindow)
	housingEditPass2 = guiCreateButton(66,109,54,25,"2",false,housingEditPassWindow)
	housingEditPass3 = guiCreateButton(122,109,54,25,"3",false,housingEditPassWindow)
	housingEditPass0 = guiCreateButton(10,136,54,25,"0",false,housingEditPassWindow)
	housingEditPassConfirm = guiCreateButton(66,136,54,25,"Set",false,housingEditPassWindow)
	housingEditPassCancel = guiCreateButton(122,136,54,25,"Cancel",false,housingEditPassWindow)
	housingEditPassRemove = guiCreateButton(10,164,166,25,"Remove house password",false,housingEditPassWindow)
	guiSetEnabled ( housingEditPassEdit, false )

	addEventHandler("onClientGUIClick", housingEditPass0, function() onPasswordWindowClick(0, housingEditPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingEditPass1, function() onPasswordWindowClick(1, housingEditPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingEditPass2, function() onPasswordWindowClick(2, housingEditPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingEditPass3, function() onPasswordWindowClick(3, housingEditPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingEditPass4, function() onPasswordWindowClick(4, housingEditPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingEditPass5, function() onPasswordWindowClick(5, housingEditPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingEditPass6, function() onPasswordWindowClick(6, housingEditPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingEditPass7, function() onPasswordWindowClick(7, housingEditPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingEditPass8, function() onPasswordWindowClick(8, housingEditPassEdit) end, false)
	addEventHandler("onClientGUIClick", housingEditPass9, function() onPasswordWindowClick(9, housingEditPassEdit) end, false)

	addEventHandler("onClientGUIClick", housingEditPassCancel, function() guiSetVisible(housingEditPassWindow, false) guiSetText( housingEditPassEdit, "") end, false)
	addEventHandler("onClientGUIClick", housingEditPassRemove,
		function()
			triggerServerEvent ( "removeHousePassword", localPlayer, newguihouseid )
			guiSetVisible(housingEditPassWindow, false)
			guiSetText( housingEditPassEdit, "")
		end, false)
	addEventHandler("onClientGUIClick", housingEditPassConfirm,
		function()
			if ( string.len(guiGetText(housingEditPassEdit)) ) == 4 then
				triggerServerEvent ( "setHousePassword", localPlayer, newguihouseid, guiGetText(housingEditPassEdit) )
				guiSetVisible(housingEditPassWindow, false)
				guiSetText( housingEditPassEdit, "")
			else
				outputChatBox("A house password can only be 4 digits!", 225, 0, 0)
			end
		end, false)

	centerWindow(housingEditPassWindow)
	guiWindowSetMovable (housingEditPassWindow, true)
	guiWindowSetSizable (housingEditPassWindow, false)
	guiSetVisible (housingEditPassWindow, false)

	-- Warning window when buy house
	buyWarnWindow = guiCreateWindow(571,390,269,128,"CSG ~ Housing System",false)
	buyHouseYesButton = guiCreateButton(9,80,125,38,"Yes",false,buyWarnWindow)
	buyHouseNoButton = guiCreateButton(136,80,124,38,"No",false,buyWarnWindow)
	buyHouseLabel1 = guiCreateLabel(19,44,235,22,"Are you sure you want to buy this house?",false,buyWarnWindow)
	guiSetFont(buyHouseLabel1,"default-bold-small")
	buyHouseLabel2 = guiCreateLabel(109,25,57,22,"Warning!",false,buyWarnWindow)
	guiLabelSetColor(buyHouseLabel2,200,0,0)
	guiSetFont(buyHouseLabel2,"default-bold-small")

	centerWindow(buyWarnWindow)
	guiWindowSetMovable (buyWarnWindow, true)
	guiWindowSetSizable (buyWarnWindow, false)
	guiSetVisible (buyWarnWindow, false)

	addEventHandler("onClientGUIClick", buyHouseNoButton, function() guiSetVisible(buyWarnWindow, false) end, false)
	addEventHandler("onClientGUIClick", buyHouseYesButton, acceptBuyHouse, false)
end

-- Create the windows onResourceStart
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function ()
		createHousingWindows()
	end
)
 screenW,screenH=guiGetScreenSize()
 local sx,sy = screenW/3,screenH/3
function draw()

	dxDrawText("Press H to open House system GUI", sx,sy,screenW,screenH,tocolor ( 0, 0, 0, 255 ), 1, "pricedown","center", "center", false, false, false) -- Counting DX
	dxDrawText("Press H to open House system GUI", sx,sy,screenW,screenH,tocolor ( 255, 255, 0, 255 ), 1, "pricedown","center", "center", false, false, false)-- Counting DX
	--dxDrawText("Press B to open House system GUI", sx,sy,screenW,screenH,tocolor ( 255, 255, 0, 255 ), 1, "pricedown","center", "center", false, false, false)-- Counting DX

end


-- Center the windows
function centerWindow(center_window)

    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

-- When the user clicks the password window
function onPasswordWindowClick ( key, theLabel )
	local currentText = guiGetText( theLabel )
	local newText = currentText.."".. key ..""
	if ( tonumber(newText) == nil ) then
		guiSetText( theLabel, newText)
	else
		if ( tonumber(newText) > 9999 ) then
			outputChatBox("A house password can only be 4 digits!", 225, 0, 0)
			guiSetText( theLabel, "")
		else
			guiSetText( theLabel, newText)
		end
	end
end

-- Set house password
function toggleSetPassWordWindow ()
	if guiGetEnabled(setHousePassword) == true then
		guiSetVisible(housingEditPassWindow,true)
		guiBringToFront ( housingEditPassWindow )
	end
end


function sellToBank()
	if guiGetEnabled(btnSellToBank) == true then
		if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
		marketvalue = getElementData(houseE,"13") --mapped price
		marketvalue=math.floor((marketvalue+marketvalue*(houseRate/100))+0.5)
		--if isElement(sellWarnWindow) then return end
		sellWarnWindow = guiCreateWindow(571,390,269,128,"CSG ~ Housing System",false)
		sellHouseYesButton = guiCreateButton(9,80,125,38,"Yes",false,sellWarnWindow)
		sellHouseNoButton = guiCreateButton(136,80,124,38,"No",false,sellWarnWindow)
		sellHouseLabel1 = guiCreateLabel(19,44,235,22,"[75% of Market Value] = $"..(marketvalue*0.75).."",false,sellWarnWindow)
		showCursor(true)
		guiSetFont(sellHouseLabel1,"default-bold-small")
		sellHouseLabel2 = guiCreateLabel(50,25,200,22,"Sell house to Bank?",false,sellWarnWindow)
		guiLabelSetColor(sellHouseLabel2,200,0,0)
		guiSetFont(sellHouseLabel2,"default-bold-small")

		centerWindow(sellWarnWindow)
		guiWindowSetMovable (sellWarnWindow, true)
		guiWindowSetSizable (sellWarnWindow, false)
		guiSetVisible (sellWarnWindow, true)

		addEventHandler("onClientGUIClick", sellHouseNoButton, function() if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end end, false)
		addEventHandler("onClientGUIClick", sellHouseYesButton, function()
			if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
			exports.dendxmsg:createNewDxMessage("You have sold your house for 75% of its Market Value to the bank!",0,255,0)
			exports.dendxmsg:createNewDxMessage("Market Value: $"..marketvalue..". Sold for $"..(marketvalue*0.75).."",0,255,0)
			triggerServerEvent("sellToBank",localPlayer,newguihouseid,marketvalue)
			if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
			--guiSetVisible(sellWarnWindow, false)
			showCursor(false) guiSetEnabled(btnSellToBank,false) 
			end
		)
	end
end

addEvent("CSGhousing.leftHouse",true)
addEventHandler("CSGhousing.leftHouse",localPlayer,function()
	if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
end)


-- Toggle house sale
function toggleSale ()
	if guiGetEnabled(toggleSaleButton) == true then
		triggerServerEvent ( "toggleSale", localPlayer, newguihouseid, newguiinteriorid )
	end
end

-- Set house sale price
function setSalePrice()
	if string.match(guiGetText(toggleSalePriceEdit),'^%d+$') then
		if guiGetEnabled(setPriceButton) == true then
		local value = tonumber(guiGetText ( toggleSalePriceEdit ))
			if value == 0 then
				outputChatBox ("The minimal price to sell your house is $1", 225,0,0)
				guiSetText ( toggleSalePriceEdit, "" )
			--elseif value >  6000000 then
			--	outputChatBox ("The maximal price to sell you house is $6,000,000", 225,0,0)
			--	guiSetText ( toggleSalePriceEdit, "" )
			else
				triggerServerEvent ( "toggleSalePrice", localPlayer, newguihouseid, value )
				guiSetText ( toggleSalePriceEdit, "" )
			end
		end
	end
end

local canBreakIn = true
function warptintohouse()
	if getElementInterior(localPlayer) ~= 0 and getElementDimension(localPlayer) ~= 0 then
		closeAllHousingWindows()
		return
	end
	if ( guiGetEnabled(enterButton) == true ) then
		if ( getElementData( localPlayer, "isPlayerArrested" ) ) or ( getElementData( localPlayer, "isPlayerJailed" ) ) then
			guiSetVisible ( housingWindow, false )
			guiSetVisible ( housingPassEdit, false )
			guiSetVisible ( buyWarnWindow, false )
			guiSetVisible ( housingEditPassWindow, false )
			showCursor( false )
		else
			if guiGetText(enterButton) == "Attempt Break-In" then
				if canBreakIn == true then
					canBreakIn=false
					alarmLevel=1
					local needed = 75+(alarmLevel*12)
					local num = math.random(1,needed)
					if num >= alarmLevel then
						triggerServerEvent("CSGhousing.brokeIn",localPlayer,"Success")
						triggerServerEvent ( "enterHouse", localPlayer, newguihouseid, newguiinteriorid,"","",true )
						exports.dendxmsg:createNewDxMessage("You have broken into the house!",0,255,0)
						if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
						--broke in
					else
						--failed
						exports.dendxmsg:createNewDxMessage("Attempted house break-in failed!",255,0,0)
						triggerServerEvent("CSGhousing.brokeIn",localPlayer,"Fail")
					end
					setTimer(function() canBreakIn=true end,10000,1)
				else
					exports.dendxmsg:createNewDxMessage("Your tired from your preview attempts, wait a few seconds before trying to break in again",255,255,0)
				end
			else
				triggerServerEvent ( "enterHouse", localPlayer, newguihouseid, newguiinteriorid )
				if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
			end
		end
	end
end

-- Buying of the house
function buyHouse()
	if guiGetEnabled(buyButton) == true then
		guiSetVisible(buyWarnWindow,true)
		guiBringToFront ( buyWarnWindow )
	end
end

-- When the user accepts the buy window
function acceptBuyHouse ()
	triggerServerEvent ( "buyHouse", localPlayer, newguihouseid )
	tempHE=houseE
	setTimer(function()
		if tempHE == houseE then
			if getElementData(houseE,"2") == exports.server:getPlayerAccountName(localPlayer) then
				guiSetText(enterButton,"Enter")
			end
		end
	end,1000,2)
end

-- Function that get trigger serverside to close the window
function closewindowTrigger()
	guiSetVisible(housingWindow, false)
	showCursor(false)
	guiSetText ( toggleSalePriceEdit, "" )
	if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
end

houseRate = 0
ready=false

bindKey("h","down",function()
	if ready==false then return end
	guiSetVisible(housingWindow,true)
	showCursor(true,true)
	ready=false
	removeEventHandler("onClientRender",root,draw)
end)

local oldtick=getTickCount()
-- Show the housing GUI
addEvent ("showHousingGui", true)
function showHousingGui (he,currRate,playerid, houseid, houseOwner, ownerid, interiorid, housesale, houseprice, housename, houselocked, boughtprice, passwordlocked, viewingSettings, permsT)
	if canOpen == false then return end
	houseE=he
	houseRate=currRate
	guiSetInputMode("no_binds_when_editing")
	guiSetText(infoLabelHousing, "CSG Housing system, for more information check F1 (House ID: ".. houseid ..")")
	addEventHandler("onClientRender",root,draw)
	ready=true
	--guiSetVisible(housingWindow,true)
	--showCursor(true,true)
	local playersName = getPlayerName ( source )
	guiSetText(setOwnerLabel, houseOwner)
	guiSetText(setInteriorLabel, interiorid)

	if housesale == 1 then
		guiSetText(setSaleLabel, "Yes")
	else
		guiSetText(setSaleLabel, "No")
	end
	if currRate >= 0 then
	guiSetText(setMarketPriceLabel, "$ "..cvtNum(boughtprice).." (+"..currRate.."%)" )
	else
	guiSetText(setMarketPriceLabel, "$ "..cvtNum(boughtprice).." (-"..currRate.."%)" )
	end
	guiSetText(setPriceLabel, "$ "..cvtNum(houseprice))
	guiSetText(setStreetLabel, housename)

	if houselocked == 1 then
		guiSetText(setLockStatus, "Yes")
	else
		guiSetText(setLockStatus, "No")
	end

	if ( houselocked == 1 ) or ( getElementData( localPlayer, "isPlayerStaff" ) ) then
		guiSetEnabled ( enterButton, true )
	else
		guiSetEnabled ( enterButton, false )
	end

	if housesale == 1 then
		guiSetEnabled ( buyButton, true )
	else
		guiSetEnabled ( buyButton, false )
	end

	if passwordlocked == 1 then
		guiSetText(setPasswordedStatus, "Yes")
	else
		guiSetText(setPasswordedStatus, "No")
	end

	if playerid == ownerid then
		if viewingSettings == nil or viewingSettings == false then
			guiSetEnabled ( enterButton, true )
		else
			guiSetEnabled(enterButton,false)
		end
		guiSetText(enterButton,"Enter")
		guiSetEnabled ( toggleSaleButton, true )
		guiSetEnabled ( setPriceButton, true )
		guiSetEnabled ( setHousePassword, true )
		guiSetEnabled ( btnSellToBank, true )
		guiEditSetReadOnly ( toggleSalePriceEdit, false )
		guiSetEnabled ( buyButton, false )
	else
		local containsPermToEnter = false
		permsT=fromJSON(permsT)
		local user = exports.server:getPlayerAccountName(localPlayer)
		for k,v in pairs(permsT) do
			if v[1] == "All Players" then
				if v[4][1] == true then
					containsPermToEnter=true
				end
			end
		end
		for k,v in pairs(permsT) do
				if v[1] == user then
					if v[4][1] == true then
						containsPermToEnter=true
					else
						containsPermToEnter=false
					end
				end
		end
		guiSetEnabled ( enterButton, true )
		if tonumber(getElementData(houseE,"8")) == 0 or containsPermToEnter == true then
			guiSetText(enterButton,"Enter")
		else
			guiSetText(enterButton,"Attempt Break-In")
		end
		guiSetEnabled ( toggleSaleButton, false )
		guiEditSetReadOnly ( toggleSalePriceEdit, true )
		guiSetEnabled ( btnSellToBank, false )
		guiSetEnabled ( setPriceButton, false )
		guiSetEnabled ( setHousePassword, false )
	end
	newguihouseid = houseid
	newguiinteriorid = interiorid
	--guiSetEnabled ( btnSellToBank, false )
end
addEventHandler ("showHousingGui", root, showHousingGui)

-- Update the labels
addEvent ("updateLabels", true)
function updateLabels (ownerid, interiorid, housesale, houseprice, housename, houselocked, boughtprice, passwordlocked)
	guiSetText(setInteriorLabel, interiorid)

	if housesale == 1 then
		guiSetText(setSaleLabel, "Yes")
	else
		guiSetText(setSaleLabel, "No")
	end

	if passwordlocked == 1 then
		guiSetText(setPasswordedStatus, "Yes")
	else
		guiSetText(setPasswordedStatus, "No")
	end
	if houseRate >= 0 then
	guiSetText(setMarketPriceLabel, "$ "..cvtNum(houseprice).." (+"..houseRate.."%)" )
	else
	guiSetText(setMarketPriceLabel, "$ "..cvtNum(houseprice).." (-"..houseRate.."%)" )
	end
	guiSetText(setPriceLabel, "$ "..cvtNum(houseprice))
--	guiSetText(setMarketPriceLabel, "$ "..cvtNum(boughtprice))
	guiSetText(setStreetLabel, housename)

	if houselocked == 1 then
		guiSetText(setLockStatus, "Yes")
	else
		guiSetText(setLockStatus, "No")
	end
	if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
end
addEventHandler ("updateLabels", root, updateLabels)

-- Update the labels when user buys a house
addEvent ("updateLabelsOnBuy", true)
function updateLabelsOnBuy (playerid, houseid, houseOwner, ownerid, interiorid, housesale, houseprice, housename, houselocked, boughtprice)
	guiSetText(setOwnerLabel, houseOwner)
	guiSetText(setInteriorLabel, interiorid)

	if housesale == 1 then
		guiSetText(setSaleLabel, "Yes")
	else
		guiSetText(setSaleLabel, "No")
	end

	guiSetText(setPriceLabel, "$ "..cvtNum(houseprice))
	guiSetText(setMarketPriceLabel, "$ "..cvtNum(boughtprice))
	guiSetText(setStreetLabel, housename)

	if houselocked == 1 then
		guiSetText(setLockStatus, "Yes")
	else
		guiSetText(setLockStatus, "No")
	end

	if ( houselocked == 1 ) or ( getElementData( localPlayer, "isPlayerStaff" ) ) then
		guiSetEnabled ( enterButton, true )
	else
		guiSetEnabled ( enterButton, false )
	end

	if housesale == 1 then
		guiSetEnabled ( buyButton, true )
	else
		guiSetEnabled ( buyButton, false )
	end

	if playerid == ownerid then
		guiSetEnabled ( enterButton, true )
		guiSetEnabled ( toggleSaleButton, true )
		guiSetEnabled ( setPriceButton, true )
		guiSetEnabled ( btnSellToBank, true )
		guiSetEnabled ( setHousePassword, true )
		guiEditSetReadOnly ( toggleSalePriceEdit, false )
		guiSetEnabled ( buyButton, false )
	else
		guiSetEnabled ( toggleSaleButton, false )
		guiEditSetReadOnly ( toggleSalePriceEdit, true )
		guiSetEnabled ( btnSellToBank, false )
		guiSetEnabled ( setPriceButton, false )
		guiSetEnabled ( setHousePassword, false )
	end
end
addEventHandler ("updateLabelsOnBuy", root, updateLabelsOnBuy)

-- Close the buy window
addEvent ("closeBuyWindow", true)
function closeBuyWindow ()
	guiSetVisible(buyWarnWindow,false)
	guiBringToFront ( housingWindow )
end
addEventHandler ("closeBuyWindow", root, closeBuyWindow)

-- Close all windows
addEvent ("closeAllHousingWindows", true)
function closeAllHousingWindows ()
	ready=false
	canOpen=false
	guiSetVisible( buyWarnWindow,false )
	guiSetVisible( housingWindow,false )
	if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
	if guiGetVisible(window) == false then
		showCursor(false)
	end
	if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
end
addEventHandler ("closeAllHousingWindows", root, closeAllHousingWindows)
addEventHandler("onClientPlayerWasted",localPlayer,closeAllHousingWindows)
-- Change the locked status of the house
function toggleLockedTrigger()
	triggerServerEvent ( "toggleClosed", localPlayer, newguihouseid, newguiinteriorid )
end

-- Show the password window
addEvent ("showPasswordWindow", true)
function showPasswordWindow()
	guiSetVisible (housingPassWindow, true)
	guiBringToFront(housingPassWindow)
end
addEventHandler ("showPasswordWindow", root, showPasswordWindow)

-- Converting the house price with comma's
function cvtNum(amount)
local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
			if (k==0) then
				break
			end
		end
	return formatted
end

-- When the player leaves the house object
addEventHandler("onClientPickupLeave", root,
	function ( thePlayer, matchingDimension )
		if ( matchingDimension ) and ( thePlayer == localPlayer ) then
			if ( getElementModel( source ) == 1272 ) or ( getElementModel( source ) == 1273 ) then
				if isElement(sellWarnWindow) then destroyElement(sellWarnWindow) end
				removeEventHandler("onClientRender",root,draw)
				ready=false
				canOpen=false
				guiSetVisible ( housingWindow, false )
				guiSetVisible ( housingPassEdit, false )
				guiSetVisible ( buyWarnWindow, false )
				guiSetVisible ( housingEditPassWindow, false )
				showCursor( false )
			end
		end
	end
)

addEventHandler("onClientPickupHit", root,
	function ( thePlayer, matchingDimension )
		if ( matchingDimension ) and ( thePlayer == localPlayer ) then
			if ( getElementModel( source ) == 1272 ) or ( getElementModel( source ) == 1273 ) then
				canOpen=true
			end
		end
	end
)
