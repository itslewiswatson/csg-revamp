local houseData = {
	-- {streetname,zonename,onmap,x,y,z}--
	{"test","test",false,1542.18, 1996.57, 14.73},
}

local blips = {

}

addEvent("CSGphone.recHouseList",true)
addEventHandler("CSGphone.recHouseList",localPlayer,function(t) houseData=t
	for k,v in pairs(t) do
		if isElement(blips[k]) then destroyElement(blips[k]) end
		blips[k] = false
	end
	update()
end)

local housesGUI = {}
function openHouses()
	if not housesGUI[1] then housesGUI[1] = guiCreateButton ( BGX+(BGWidth*0.50), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Show", false ) end
	if not housesGUI[2] then housesGUI[2] = guiCreateButton ( BGX+(BGWidth*0.0), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Hide", false ) end
	if not housesGUI[6] then
		housesGUI[6] = guiCreateGridList ( BGX, BGY, 0.99770569801331*BGWidth, 0.9*BGHeight, false )
		guiGridListAddColumn( housesGUI[6], "ID", 0.19)
		guiGridListAddColumn( housesGUI[6], "Area", 0.9)
	end
	update()

	addEventHandler( "onClientGUIClick", housesGUI[1], showHouse )
	addEventHandler( "onClientGUIClick", housesGUI[2], hideHouse )

	for k,v in pairs(housesGUI) do
		--if i <= 8 then
			guiSetVisible ( v, true )
			guiSetProperty ( v, "AlwaysOnTop", "True" )
		--end
	end

	if ( updateBookmarks ) then uploadGridlistBookmarks () end

	apps[13][7] = true
end
apps[13][8] = openHouses

function closeHouses()
	removeEventHandler( "onClientGUIClick", housesGUI[1], showHouse )
	removeEventHandler( "onClientGUIClick", housesGUI[2], hideHouse )

	for k,v in pairs(housesGUI) do
		--if i <= 8 then
			guiSetVisible ( v, false )
			guiSetProperty ( v, "AlwaysOnTop", "False" )
		--end
	end

	apps[13][7] = false
end
apps[13][9] = closeHouses

function update()
	if not isElement(housesGUI[6]) then return false end
	local oldR = guiGridListGetSelectedItem(housesGUI[6])
	guiGridListClear(housesGUI[6])
	for k,v in pairs(houseData) do
		local row = guiGridListAddRow(housesGUI[6])
		guiGridListSetItemText(housesGUI[6],row,1,v[1],false,false)
		guiGridListSetItemText(housesGUI[6],row,2,v[2],false,false)
		if v[3] == true then
			guiGridListSetItemColor(housesGUI[6],row,1,0,255,0)
			guiGridListSetItemColor(housesGUI[6],row,2,0,255,0)
		end
	end
	if oldR ~= false and oldR ~= nil and oldR ~= -1 then
		guiGridListSetSelectedItem(housesGUI[6],oldR,1)
	end
end

function getI(row)
	local i = nil
	local ID = tonumber(guiGridListGetItemText(housesGUI[6],row,1))
	local area = ""
	for k,v in pairs(houseData) do
		if v[1] == ID then
			i=k
			area=v[2]
			break
		end
	end
	return i,area
end

function showHouse()
	local row = guiGridListGetSelectedItem(housesGUI[6])
	if row ~= false and row ~= nil and row ~= -1 then
		local i,streetName = getI(row)
		if i ~= nil then
			if houseData[i][3] == true then
				--do nothing its already showing
				exports.dendxmsg:createNewDxMessage("This house is already visible on your map",255,255,0)
			else
				if isElement(blips[i]) then destroyElement(blips[i]) end
				blips[i] = createBlip(houseData[i][4],houseData[i][5],houseData[i][6],31)
				houseData[i][3] = true
				update()
				exports.dendxmsg:createNewDxMessage("Your house at '"..streetName.."' is now visible on your map",0,255,0)
			end
		end
	else
		exports.dendxmsg:createNewDxMessage("You didn't select a house!",255,255,0)
	end
end

function hideHouse()
	local row = guiGridListGetSelectedItem(housesGUI[6])
	if row ~= false and row ~= nil and row ~= -1 then
		local i,streetName = getI(row)
		if i ~= nil then
			if houseData[i][3] == false then
				--do nothing its already showing
				exports.dendxmsg:createNewDxMessage("This house is already not visible on your map",255,255,0)
			else
				if isElement(blips[i]) then destroyElement(blips[i]) end
				houseData[i][3] = false
				update()
				exports.dendxmsg:createNewDxMessage("Your house at '"..streetName.."' is no longer visible on your map",0,255,0)
			end
		end
	else
		exports.dendxmsg:createNewDxMessage("You didn't select a house!",255,255,0)
	end
end
