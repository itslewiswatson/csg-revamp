createHouseWindow = guiCreateWindow(575,304,272,421,"CSG ~ Create New House",false)
interiorLabel = guiCreateLabel(13,27,140,20,"Interior ID: (1/32)",false,createHouseWindow)
priceLabel = guiCreateLabel(13,94,171,20,"House Price: (Max 8.000.000!)",false,createHouseWindow)
streetLabel = guiCreateLabel(13,161,186,20,"Street Name: (Ex: Grove Street)",false,createHouseWindow)
priceEdit = guiCreateEdit(9,113,254,30,"",false,createHouseWindow)
streetEdit = guiCreateEdit(9,181,254,30,"",false,createHouseWindow)
interiorEdit = guiCreateEdit(9,48,254,30,"",false,createHouseWindow)
createButton = guiCreateButton(12,220,251,32,"Create New House",false,createHouseWindow)
closeButton = guiCreateButton(11,259,252,32,"Close Window",false,createHouseWindow)
-- Note
noteLabel = guiCreateLabel(13,310,186,20,"NOTE: To all house mappers",false,createHouseWindow)
guiLabelSetColor(noteLabel,225,0,0)
noteMemo = guiCreateMemo(11,329,252,83,"Before mapping houses your should first read the forum! Here you find all information you need to start mapping houses. For example on the forum you can see all the interiors with pictures, read the mapping rules, examples of street names and much more information.",false,createHouseWindow)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(createHouseWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(createHouseWindow,x,y,false)

guiWindowSetMovable (createHouseWindow, true)
guiWindowSetSizable (createHouseWindow, false)
guiSetVisible (createHouseWindow, false)


function closeTheScreen ()
guiSetVisible(createHouseWindow, false) 
	showCursor(false)
		removeEventHandler("onClientGUIClick", createButton, createNewHouse, false)
end
addEventHandler("onClientGUIClick", closeButton, closeTheScreen, false)

function showTheCreateGui ()
if getElementData(getLocalPlayer(), "isPlayerStaff") == true then
	if getElementData(getLocalPlayer(), "houseMapper") == true then
			guiSetVisible(createHouseWindow,true)
			showCursor(true,true)
			guiSetInputMode("no_binds_when_editing")
		addEventHandler("onClientGUIClick", createButton, createNewHouse, false)
		end
	end
end
addCommandHandler ( "createhouse", showTheCreateGui )

function createNewHouse ()
local id = guiGetText ( interiorEdit )
	local price = guiGetText ( priceEdit )
		local street = guiGetText ( streetEdit )
	
		if id == "" or price == "" or street == "" then
	outputChatBox("Not all fields are filled in!", 225, 0, 0)
		elseif tonumber(price) < 1 or tonumber(price) > 8000000 then
	outputChatBox("Price of the house is to high or to low!", 225, 0, 0)
		elseif tonumber(price) < 8000 then
	outputChatBox("You cant create a house with a price under the $8000.", 225, 0, 0)
		elseif tonumber(id) < 1 or tonumber(id) > 32 then
	outputChatBox("Invaild interior id! Read the forum!", 225, 0, 0)
		else
	triggerServerEvent ( "createTheNewHouse", getLocalPlayer(), id, price, street )
		outputChatBox ("Floppy added, house will be visable on next resource restart!", 225, 225, 0)
			guiSetVisible(createHouseWindow,false)
		showCursor(false,false)
	removeEventHandler("onClientGUIClick", createButton, createNewHouse, false)
	end
end