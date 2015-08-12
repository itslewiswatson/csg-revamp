local wepData = {

}

local blips = {

}
local prim = ""
local sec = ""

local backwepGUI = {}
function openbackwep()

	if not backwepGUI[1] then backwepGUI[1] = guiCreateButton ( BGX+(BGWidth*0.50), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Toggle Secondary", false ) end
	if not backwepGUI[2] then backwepGUI[2] = guiCreateButton ( BGX+(BGWidth*0.0), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Toggle Primary", false ) end
	if not backwepGUI[6] then
		backwepGUI[6] = guiCreateGridList ( BGX, BGY, 0.99770569801331*BGWidth, 0.9*BGHeight, false )
		guiGridListAddColumn( backwepGUI[6], "Weapon", 0.9)
	end
	--updateWeps(true)

	--addEventHandler( "onClientGUIClick", backwepGUI[2], togPrim )
	--addEventHandler( "onClientGUIClick", backwepGUI[1], togSec )

	for k,v in pairs(backwepGUI) do
		--if i <= 8 then
			guiSetVisible ( v, true )
			guiSetProperty ( v, "AlwaysOnTop", "True" )
		--end
	end

	if ( updateWepsBookmarks ) then uploadGridlistBookmarks () end

	apps[16][7] = true
		--updateWeps(true)
end
apps[16][8] = openbackwep

function closebackwep()
	--removeEventHandler( "onClientGUIClick", backwepGUI[2], togPrim )
	--removeEventHandler( "onClientGUIClick", backwepGUI[1], togSec )

	for k,v in pairs(backwepGUI) do
		--if i <= 8 then
			guiSetVisible ( v, false )
			guiSetProperty ( v, "AlwaysOnTop", "False" )
		--end
	end

	apps[16][7] = false
end
apps[16][9] = closebackwep

local allowed = {
2,3,4,5,6,7,8,9,25,26,27,28,29,32,30,31,33,34,15,39
}

function updateWeps(dontsend)
	wepData = {}
	guiGridListClear(backwepGUI[6])
	for i=1,11 do
		--if i ~= 9 and i ~= 11 then
		local id = getPedWeapon(localPlayer,i)
		for k,v in pairs(allowed) do
			if v == id then
			local slot = getSlotFromWeapon(id)
				if getPedTotalAmmo(localPlayer,slot) > 0 then
					local name = getWeaponNameFromID(id)
					table.insert(wepData,name)
				end
			end

		end
		--end
	end
	for k,v in pairs(wepData) do
		local row = guiGridListAddRow(backwepGUI[6])
		guiGridListSetItemText ( backwepGUI[6], row, 1,v, false, false )
		if v == prim then
			guiGridListSetItemColor(backwepGUI[6],row,1,0,255,0)
		elseif v == sec then
			guiGridListSetItemColor(backwepGUI[6],row,1,255,255,0)
		end
	end
	if dontsend == nil then
		sendUpdated()
	end
end


function togPrim()
	if 1+1==2 then
		exports.dendxmsg:createNewDxMessage("Temporarly disabled due to some reporting FPS problems, will be looked into.",0,255,0)
		return
	end
	local row = guiGridListGetSelectedItem(backwepGUI[6])
	if row ~= false and row ~= nil and row ~= -1 then
		local name = guiGridListGetItemText(backwepGUI[6],row,1)
		if name == sec then
			exports.dendxmsg:createNewDxMessage("Set "..name.." as the primary option for your back",0,255,0)
			sec=""
			prim=name
			updateWeps()
			return
		end
		if name == prim then
		exports.dendxmsg:createNewDxMessage(""..name.." no longer your primary option for your back",0,255,0)
		prim=""
		updateWeps()
		return
		end
		prim=name
		exports.dendxmsg:createNewDxMessage("Set "..name.." as the primary option for your back",0,255,0)
		updateWeps()
	else
		exports.dendxmsg:createNewDxMessage("You didn't select a weapon!",255,255,0)
	end
end

function togSec()
	if 1+1==2 then
		exports.dendxmsg:createNewDxMessage("Temporarly disabled due to some reporting FPS problems, will be looked into.",0,255,0)
		return
	end
	local row = guiGridListGetSelectedItem(backwepGUI[6])
	if row ~= false and row ~= nil and row ~= -1 then

		local name = guiGridListGetItemText(backwepGUI[6],row,1)
		if name == prim then
			exports.dendxmsg:createNewDxMessage("Set "..name.." as the secondary option for your back!",0,255,0)
			prim=""
			sec=name
			updateWeps()
			return
		end
		if name == sec then
		exports.dendxmsg:createNewDxMessage(""..name.." no longer your secondary option for your back",0,255,0)
		sec=""
		updateWeps()
		return
		end
		sec=name
		exports.dendxmsg:createNewDxMessage("Set "..name.." as the secondary option for your back!",0,255,0)
		updateWeps()
	else
		exports.dendxmsg:createNewDxMessage("You didn't select a weapon!",255,255,0)
	end
end

function sendUpdated()
	-- triggerServerEvent("recBack",localPlayer,prim,sec)
end

function checkk ( prevSlot, newSlot )
wepData = {}
	if 1+1==2 then return end
	for i=1,11 do
		--if i ~= 9 and i ~= 11 then
		local id = getPedWeapon(localPlayer,i)
		for k,v in pairs(allowed) do
			if v==id then
				local slot = getSlotFromWeapon(id)
				if getPedTotalAmmo(localPlayer,slot) > 0 then
					local name = getWeaponNameFromID(id)
					table.insert(wepData,name)
				end
			end

		end
		--end
	end
	local hasprim=false
	local hassec=false
	for k,v in pairs(wepData) do
		if v == prim then
			hasprim=true
		elseif v == sec then
			hassec=true
		end
	end
	local up=false
	if hasprim==false then prim="" up=true end
	if hassec==false then sec="" up=true end
	if up == true then
		updateWeps()
		sendUpdated()
	end

end
--addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), checkk )
