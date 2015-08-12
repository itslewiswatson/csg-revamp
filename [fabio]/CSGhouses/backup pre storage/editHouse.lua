houseEditWindow = guiCreateWindow(575,304,272,388,"CSG ~ Edit House",false)
houseIDLabel = guiCreateLabel(13,23,140,20,"House ID:",false,houseEditWindow)
lineLabel = guiCreateLabel(13,84,246,20,"-------------------------------------------------------------",false,houseEditWindow)
priceLabel = guiCreateLabel(13,106,186,20,"House Price: (Max 8.000.000!)",false,houseEditWindow)
streetLabel = guiCreateLabel(13,176,186,20,"Street Name: (Ex: Grove Street)",false,houseEditWindow)
interiorLabel = guiCreateLabel(13,248,186,20,"Interior ID: (1/32)",false,houseEditWindow)
idEdit = guiCreateEdit(9,48,146,30,"",false,houseEditWindow)
priceEdits = guiCreateEdit(9,128,254,30,"",false,houseEditWindow)
streetEdits = guiCreateEdit(9,197,254,30,"",false,houseEditWindow)
interiorEdits = guiCreateEdit(9,268,254,30,"",false,houseEditWindow)
getHouseInfo = guiCreateButton(161,47,102,30,"Get house info",false,houseEditWindow)
updateHouse = guiCreateButton(12,308,251,32,"Update Selected House",false,houseEditWindow)
closeWindow = guiCreateButton(11,347,252,32,"Close Window",false,houseEditWindow)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(houseEditWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(houseEditWindow,x,y,false)

guiWindowSetMovable (houseEditWindow, true)
guiWindowSetSizable (houseEditWindow, false)
guiSetVisible (houseEditWindow, false)

function closeTheScreen ()
guiSetVisible(houseEditWindow, false) 
showCursor(false) 

removeEventHandler("onClientGUIClick", getHouseInfo, getHousingInfo, false)
removeEventHandler("onClientGUIClick", updateHouse, doUpdateHouse, false)
end
addEventHandler("onClientGUIClick", closeWindow, closeTheScreen, false)

function showTheEditGui ()
if getElementData(getLocalPlayer(), "isPlayerStaff") == true then
	if getElementData(getLocalPlayer(), "houseMapper") == true then
			guiSetVisible(houseEditWindow,true)
				showCursor(true,true)
				guiSetInputMode("no_binds_when_editing")
			addEventHandler("onClientGUIClick", getHouseInfo, getHousingInfo, false)					
			addEventHandler("onClientGUIClick", updateHouse, doUpdateHouse, false)
		end
	end
end
addCommandHandler ( "edithouse", showTheEditGui )

function getHousingInfo ()
if getElementData(getLocalPlayer(), "houseMapper") == true then
	local houseID = guiGetText ( idEdit )
		if not houseID or houseID == "" then
			outputChatBox("Enter the house id before you request the information!", 225, 0, 0)
		else
			triggerServerEvent ( "getTheHouseInfo", getLocalPlayer(), houseID )
		end
	end
end

function updateEditGUI (interiorid, houseprice, housename)
guiSetText(priceEdits, houseprice)
	guiSetText(streetEdits, housename)
		guiSetText(interiorEdits, interiorid)
end
addEvent( "updateEditGUI", true )
addEventHandler( "updateEditGUI", getRootElement(), updateEditGUI )

function doUpdateHouse ()
local houseID = guiGetText ( idEdit )
	local int = guiGetText ( interiorEdits )
		local price = guiGetText ( priceEdits)
			local street = guiGetText ( streetEdits )
	
		if id == "" or price == "" or street == "" then
	outputChatBox("Not all fields are filled in!", 225, 0, 0)
		elseif houseID == "" then
	outputChatBox("You didnt enter a house ID!", 225, 0, 0)
		elseif tonumber(price) < 1 or tonumber(price) > 8000000 then
	outputChatBox("Price of the house is to high or to low!", 225, 0, 0)
		elseif tonumber(price) < 8000 then
	outputChatBox("You cant create a house with a price under the $8000.", 225, 0, 0)
		elseif tonumber(int) < 1 or tonumber(int) > 32 then
	outputChatBox("Invaild interior id! Read the forum!", 225, 0, 0)
		else
	triggerServerEvent ( "doEditTheHouse", getLocalPlayer(), int, price, street, houseID )
		outputChatBox ("Trying to change the house... Gimme a sec please :)", 225, 225, 0)
			updateEditGUI ("", "", "")
		end
	-- function to update the house
end

function updateReturn ()
	triggerServerEvent ( "updateThePickup", getLocalPlayer(), id, price, street, houseID )
end
addEvent( "updateReturn", true )
addEventHandler( "updateReturn", getRootElement(), updateReturn )