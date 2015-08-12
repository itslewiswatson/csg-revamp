
GUIEditor = {
    tab = {},
    button = {},
    edit = {},
    window = {},
    gridlist = {},
    checkbox = {},
    label = {},
    tabpanel = {},
}
window = guiCreateWindow(403, 196, 473, 335, "Priyen's House", false)
guiWindowSetSizable(window, false)

GUIEditor.label[1] = guiCreateLabel(15, 53, 83, 19, "Market value:", false, window)
guiSetFont(GUIEditor.label[1], "default-bold-small")
guiLabelSetColor(GUIEditor.label[1], 238, 201, 0)
GUIEditor.label[2] = guiCreateLabel(15, 31, 83, 19, "Street name:", false, window)
guiSetFont(GUIEditor.label[2], "default-bold-small")
guiLabelSetColor(GUIEditor.label[2], 238, 201, 0)
GUIEditor.label[3] = guiCreateLabel(14, 66, 450, 14, "------------------------------------------------------------------------------------------------------------", false, window)
GUIEditor.label[4] = guiCreateLabel(128, 31, 185, 19, "street", false, window)
GUIEditor.label[5] = guiCreateLabel(128, 54, 232, 20, "$500 market value", false, window)
GUIEditor.tabpanel[1] = guiCreateTabPanel(9, 89, 455, 237, false, window)

GUIEditor.tab[1] = guiCreateTab("Permissions", GUIEditor.tabpanel[1])

gridPerms = guiCreateGridList(10, 33, 285, 130, false, GUIEditor.tab[1])
guiGridListAddColumn(gridPerms, "Username", 0.3)
guiGridListAddColumn(gridPerms, "Nick", 0.3)
guiGridListAddColumn(gridPerms, "", 0.3)

GUIEditor.label[6] = guiCreateLabel(9, 8, 286, 15, "Who has access to this house?", false, GUIEditor.tab[1])
guiLabelSetColor(GUIEditor.label[6], 238, 201, 0)
btnInsertPerms = guiCreateButton(10, 171, 96, 28, "Insert:", false, GUIEditor.tab[1])
txtPermsName = guiCreateEdit(112, 171, 82, 28, "Username", false, GUIEditor.tab[1])
btnPermsDelete = guiCreateButton(199, 171, 96, 28, "Delete", false, GUIEditor.tab[1])

cbeh = guiCreateCheckBox(301, 15, 150, 15, "Can enter house", false, false, GUIEditor.tab[1])
cbdm = guiCreateCheckBox(301, 32, 141, 15, "Can deposit money", false, false, GUIEditor.tab[1])
cbwm = guiCreateCheckBox(301, 49, 141, 15, "Can withdraw money", false, false, GUIEditor.tab[1])
cbdd = guiCreateCheckBox(301, 66, 141, 15, "Can deposit drugs", false, false, GUIEditor.tab[1])
cbwd = guiCreateCheckBox(301, 83, 141, 15, "Can withdraw drugs", false, false, GUIEditor.tab[1])
cbdw = guiCreateCheckBox(301, 100, 141, 15, "Can deposit weapons", false, false, GUIEditor.tab[1])
cbww = guiCreateCheckBox(301, 117, 150, 15, "Can withdraw weapons", false, false, GUIEditor.tab[1])
cbpm = guiCreateCheckBox(301, 134, 150, 15, "Can control music", false, false, GUIEditor.tab[1])
cbvm = guiCreateCheckBox(301, 151, 150, 15, "Can view money", false, false, GUIEditor.tab[1])
cbvd = guiCreateCheckBox(301, 169, 150, 15, "Can view drugs", false, false, GUIEditor.tab[1])
cbvw = guiCreateCheckBox(301, 186, 150, 15, "Can view weapons", false, false, GUIEditor.tab[1])
cbs = {
  cbeh,cbdm,cbwm,cbdd,cbwd,cbdw,cbww,cbpm,cbvm,cbvd,cbvw
}

GUIEditor.tab[2] = guiCreateTab("Money", GUIEditor.tabpanel[1])

GUIEditor.label[7] = guiCreateLabel(11, 13, 115, 20, "Safe Balance:", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[7], 238, 201, 0)
lblsafebalance = guiCreateLabel(95, 13, 115, 20, "$0", false, GUIEditor.tab[2])
gridMoney = guiCreateGridList(11, 40, 432, 118, false, GUIEditor.tab[2])
guiGridListAddColumn(gridMoney, "Name", 0.4)
guiGridListAddColumn(gridMoney, "Type", 0.15)
guiGridListAddColumn(gridMoney, "Amount", 0.1)
guiGridListAddColumn(gridMoney, "Date", 0.3)
btnwm = guiCreateButton(11, 169, 146, 26, "Withdraw", false, GUIEditor.tab[2])
btndm = guiCreateButton(294, 169, 146, 26, "Deposit", false, GUIEditor.tab[2])
txtamm = guiCreateEdit(161, 169, 129, 28, "", false, GUIEditor.tab[2])

GUIEditor.tab[3] = guiCreateTab("Drugs", GUIEditor.tabpanel[1])

gridMyDrugs = guiCreateGridList(11, 29, 185, 172, false, GUIEditor.tab[3])
guiGridListAddColumn(gridMyDrugs, "Name", 0.6)
guiGridListAddColumn(gridMyDrugs, "Amount", 0.3)
gridHouseDrugs = guiCreateGridList(259, 29, 185, 172, false, GUIEditor.tab[3])
guiGridListAddColumn(gridHouseDrugs, "Name", 0.6)
guiGridListAddColumn(gridHouseDrugs, "Amount", 0.3)
btndd = guiCreateButton(198, 65, 55, 31, ">>", false, GUIEditor.tab[3])
btnwd = guiCreateButton(198, 134, 55, 31, "<<", false, GUIEditor.tab[3])
txtamd = guiCreateEdit(200, 100, 53, 31, "", false, GUIEditor.tab[3])
GUIEditor.label[9] = guiCreateLabel(11, 7, 185, 17, "My Drugs", false, GUIEditor.tab[3])
guiLabelSetColor(GUIEditor.label[9], 238, 201, 0)
guiLabelSetHorizontalAlign(GUIEditor.label[9], "center", false)
GUIEditor.label[10] = guiCreateLabel(259, 7, 185, 17, "House Drugs", false, GUIEditor.tab[3])
guiLabelSetColor(GUIEditor.label[10], 238, 201, 0)
guiLabelSetHorizontalAlign(GUIEditor.label[10], "center", false)

GUIEditor.tab[4] = guiCreateTab("Weapons", GUIEditor.tabpanel[1])

gridMyWeps = guiCreateGridList(11, 29, 185, 172, false, GUIEditor.tab[4])
guiGridListAddColumn(gridMyWeps, "Name", 0.6)
guiGridListAddColumn(gridMyWeps, "Amount", 0.3)
gridHouseWeps = guiCreateGridList(259, 29, 185, 172, false, GUIEditor.tab[4])
guiGridListAddColumn(gridHouseWeps, "Name", 0.6)
guiGridListAddColumn(gridHouseWeps, "Amount", 0.3)
btndw = guiCreateButton(198, 65, 55, 31, ">>", false, GUIEditor.tab[4])
btnww = guiCreateButton(198, 134, 55, 31, "<<", false, GUIEditor.tab[4])
txtamw = guiCreateEdit(200, 100, 53, 31, "", false, GUIEditor.tab[4])
GUIEditor.label[11] = guiCreateLabel(11, 7, 185, 17, "My Weapons", false, GUIEditor.tab[4])
guiLabelSetColor(GUIEditor.label[11], 238, 201, 0)
guiLabelSetHorizontalAlign(GUIEditor.label[11], "center", false)
GUIEditor.label[12] = guiCreateLabel(259, 7, 185, 17, "House Weapons", false, GUIEditor.tab[4])
guiLabelSetColor(GUIEditor.label[12], 238, 201, 0)
guiLabelSetHorizontalAlign(GUIEditor.label[12], "center", false)

GUIEditor.tab[5] = guiCreateTab("Music", GUIEditor.tabpanel[1])

gridMusic = guiCreateGridList(9, 29, 435, 109, false, GUIEditor.tab[5])
guiGridListAddColumn(gridMusic, "Name", 0.4)
guiGridListAddColumn(gridMusic, "Added by", 0.4)
guiGridListAddColumn(gridMusic, "Link", 0.2)
labelsong = guiCreateLabel(8, 8, 94, 15, "Currently Playing:", false, GUIEditor.tab[5])
guiLabelSetColor(labelsong, 238, 201, 0)
lblplayingsong = guiCreateLabel(111, 8, 200, 15, "None", false, GUIEditor.tab[5])
btnaddsong = guiCreateButton(11, 141, 58, 29, "Add:", false, GUIEditor.tab[5])
GUIEditor.label[16] = guiCreateLabel(74, 147, 36, 22, "Name:", false, GUIEditor.tab[5])
txtsongname = guiCreateEdit(112, 141, 124, 28, "Song name", false, GUIEditor.tab[5])
GUIEditor.label[17] = guiCreateLabel(240, 147, 36, 22, "Link:", false, GUIEditor.tab[5])
txtlink = guiCreateEdit(269, 141, 175, 28, "link", false, GUIEditor.tab[5])
btnplay = guiCreateButton(9, 177, 135, 27, "Play", false, GUIEditor.tab[5])
btnstop = guiCreateButton(159, 177, 135, 27, "Stop", false, GUIEditor.tab[5])
btndeletesong = guiCreateButton(309, 177, 135, 27, "Delete", false, GUIEditor.tab[5])
btnuprad = guiCreateButton(309, 4, 40, 23, "+", false, GUIEditor.tab[5])
btndownrad = guiCreateButton(360, 4, 40, 23, "-", false, GUIEditor.tab[5])
btnhousesettings = guiCreateButton(326, 28, 135, 35, "House Settings", false, window)
local houseData = {}
guiSetVisible(window,false)
local hasAllAccess = false
local houseEDATA = false
local myuser = false
local speaker = false
local sound = false
local posTimer = false
hide = function()
	guiSetVisible(window,false)
	if guiGetVisible(buyWarnWindow) == false and guiGetVisible(housingWindow) == false then
		showCursor(false)
	end
end
setTimer(function() if guiGetVisible(window) == true then showCursor(true) end end,300,0)

ged = function(k)
	if k == "moneyStorage" or k == "drugsStorage" or k == "weaponsStorage" or k == "perms" or k == "music" or k == "speakerpos" then
		return houseData[k]
	else
		return getElementData(houseEDATA,k)
	end
end

disableAll = function()
	guiSetEnabled(GUIEditor.tab[1],false)
end

show = function()
	if houseEDATA == false then return end
	disableAll()
	guiSetVisible(window,true)
	guiSetText(window,ged("2").."'s House")
	updateData()
	showCursor(true)
end

function getFormattedDate(stamp)
	local month = ""
	local year = ""
	local day = ""
	stamp=tostring(stamp)
	for i = 1, #stamp do
		local c = stamp:sub(i,i)
		if i > 0 and i < 5 then
			year = year..""..c..""
		end
		if i == 5 or i == 6 then
			month=month..""..c..""
		end
		if i > 6 then
			day=day..""..c..""
		end
	end
	local formatted = year.."/"..month.."/"..day..""
	return formatted
end

function updateData()
	if houseEDATA == false then return end
	guiSetText(GUIEditor.label[4],ged("7"))
	local amount = ged("13")
	local rate = ged("14")
	if rate >= 0 then
	guiSetText(GUIEditor.label[5],"$"..math.floor((amount+(amount*(rate/100)))+0.5).." (+"..rate.."%)")
	else
	guiSetText(GUIEditor.label[5],"$"..math.floor((amount+(amount*(rate/100)))+0.5).." (-"..rate.."%)")
	end
	hasAllAccess=false
	if ged("2") == myuser then hasAllAccess = true end
	guiGridListClear(gridPerms)
	if myuser == ged("2") then
		local permsT = fromJSON(ged("perms"))
		if permsT ~= nil then
			for k,v in pairs(permsT) do
				local row = guiGridListAddRow(gridPerms)
				for i=1,3 do
					guiGridListSetItemText ( gridPerms, row, i, v[i], false, false )
					if i == 2 then
						if isElement(exports.server:getPlayerFromAccountname(v[1])) then
							guiGridListSetItemText ( gridPerms, row, i, getPlayerName(exports.server:getPlayerFromAccountname(v[1])), false, false )
						end
					end
				end
			end
		end
	end
	canenterhouse=false
	candepositmoney=false
	canwithdrawmoney=false
	candepositdrugs=false
	canwithdrawdrugs=false
	candepositweapons=false
	canwithdrawweapons=false
	cancontrolmusic=false
	canviewmoney=false
	canviewdrugs=false
	canviewweapons=false
	local permsT = fromJSON(ged("perms"))
		for k,v in pairs(permsT) do
		if v[1] == "All Players" then
			local perms = v[4]
			for k,v in pairs(perms) do
				if k == 1 then
					canenterhouse=v
				elseif k == 2 then
					candepositmoney=v
				elseif k == 3 then
					canwithdrawmoney=v
				elseif k == 4 then
					candepositdrugs=v
				elseif k == 5 then
					canwithdrawdrugs=v
				elseif k == 6 then
					candepositweapons=v
				elseif k == 7 then
					canwithdrawweapons=v
				elseif k == 8 then
					cancontrolmusic=v
				elseif k == 9 then
					canviewmoney=v
				elseif k == 10 then
					canviewdrugs=v
				elseif k == 11 then
					canviewweapons=v
				end
			end
			break
		end
	end
	for k,v in pairs(permsT) do
		if v[1] ~= "All Players" and v[1] == myuser then
			local perms = v[4]
			for k,v in pairs(perms) do
				if k == 1 then
					canenterhouse=v
				elseif k == 2 then
					candepositmoney=v
				elseif k == 3 then
					canwithdrawmoney=v
				elseif k == 4 then
					candepositdrugs=v
				elseif k == 5 then
					canwithdrawdrugs=v
				elseif k == 6 then
					candepositweapons=v
				elseif k == 7 then
					canwithdrawweapons=v
				elseif k == 8 then
					cancontrolmusic=v
				elseif k == 9 then
					canviewmoney=v
				elseif k == 10 then
					canviewdrugs=v
				elseif k == 11 then
					canviewweapons=v
				end
			end
		end
	end
	if hasAllAccess == false then
		if candepositmoney == true then guiSetEnabled(btndm,true)	else guiSetEnabled(btndm,false) end
		if canwithdrawmoney == true then guiSetEnabled(btnwm,true) else guiSetEnabled(btnwm,false) end
		if candepositdrugs == true then guiSetEnabled(btndd,true) else guiSetEnabled(btndd,false) end
		if canwithdrawdrugs == true then guiSetEnabled(btnwd,true) else guiSetEnabled(btnwd,false) end
		if candepositweapons == true then guiSetEnabled(btndw,true) else guiSetEnabled(btndw,false) end
		if canwithdrawweapons == true then guiSetEnabled(btnww,true) else guiSetEnabled(btnww,false) end
		if cancontrolmusic == true then
			guiSetEnabled(btnaddsong,true) guiSetEnabled(btnplay,true) guiSetEnabled(btnstop,true) guiSetEnabled(btndeletesong,true) guiSetEnabled(btnuprad,true) guiSetEnabled(btndownrad,true)
			else
			guiSetEnabled(btnaddsong,false) guiSetEnabled(btnplay,false) guiSetEnabled(btnstop,false) guiSetEnabled(btndeletesong,false) guiSetEnabled(btnuprad,false) guiSetEnabled(btndownrad,false)
		end
	end
	--money
	if hasAllAccess == true or canviewmoney == true then
		guiGridListClear(gridMoney)
		local moneyT = fromJSON(ged("moneyStorage"))
		for k,v in pairs(moneyT) do
			if k ~= 1 then
				if v[4] ~= nil then
					local row = guiGridListAddRow(gridMoney)
					for i=1,4 do
						if i == 4 then
							guiGridListSetItemText ( gridMoney, row, i, getFormattedDate(v[i]), false, false )
						else
							guiGridListSetItemText ( gridMoney, row, i, v[i], false, false )
						end
					end
				end
			end
		end
		guiSetText(lblsafebalance,"$"..moneyT[1].."")
	else
		guiSetText(lblsafebalance,"Unauthorized")
		guiGridListClear(gridMoney)
	end
	--weapons
	updateMyWeps()
	guiGridListClear(gridHouseWeps)
	if hasAllAccess == true or canviewweapons == true then
		local weaponsT = fromJSON(ged("weaponsStorage"))
		if weaponsT == nil then weaponsT = {} end
		for k,v in pairs(weaponsT) do
			if v > 0 then
				local name = getWeaponNameFromID(k)
				local ammo = v
				local row = guiGridListAddRow(gridHouseWeps)
				guiGridListSetItemText ( gridHouseWeps, row, 1, name, false, false )
				guiGridListSetItemText ( gridHouseWeps, row, 2, ammo, false, false )
			end
		end
	end
	--drugs
	updateMyDrugs()
	guiGridListClear(gridHouseDrugs)
	if hasAllAccess == true or canviewdrugs == true then
		local t = ged("drugsStorage")
		t=fromJSON(t)
		for k,v in pairs(t) do
			if v > 0 then
				local row = guiGridListAddRow(gridHouseDrugs)
				guiGridListSetItemText ( gridHouseDrugs, row, 1, k, false, false )
				guiGridListSetItemText ( gridHouseDrugs, row, 2, v, false, false )
			end
		end
	end
	--music
	local t = ged("music")
	t=fromJSON(t)
	guiSetText(lblplayingsong,t["Playing"])
	guiGridListClear(gridMusic)
	if hasAllAccess == true or cancontrolmusic == true then
		for k,v in pairs(t) do
			if v[2] ~= nil then
				local name = k
				local adder = v[1]
				local link = v[2]
				local row = guiGridListAddRow(gridMusic)
				guiGridListSetItemText ( gridMusic, row, 1, k, false, false )
				guiGridListSetItemText ( gridMusic, row, 2, adder, false, false )
				guiGridListSetItemText ( gridMusic, row, 3, link, false, false )
				if k == t["Playing"] then
					guiGridListSetItemColor(gridMusic,row,1,0,255,0)
				end
			end
		end
	end
	if hasAllAccess == true then
		guiSetEnabled(GUIEditor.tab[1],true)
		guiSetEnabled(btnhousesettings,true)
	elseif ged("2") ~= myuser then
		guiSetEnabled(GUIEditor.tab[1],false)
		guiSetEnabled(btnhousesettings,false)
	end
--[[	guiGridListSetSelectedItem ( gridPerms, 0, 0)
	for k,v in pairs(cbs) do
		guiCheckBoxSetSelected(v,false)
	end --]]
end

function updateMyWeps()
	myWeps = {}
	guiGridListClear(gridMyWeps)
	for i=1,11 do
		if i ~= 9 and i ~= 11 then
			local ammo = getPedTotalAmmo(localPlayer,i)
			local name = getWeaponNameFromID(getPedWeapon(localPlayer,i))
			if i == 1 or i == 11 then if ammo ~= 0 then ammo = 1 end end
			table.insert(myWeps,{name,ammo})
		end
	end
	for k,v in pairs(myWeps) do
		if tonumber(v[2]) > 0 then
			local row = guiGridListAddRow(gridMyWeps)
			for i=1,2 do
				guiGridListSetItemText ( gridMyWeps, row, i, v[i], false, false )
			end
		end
	end
end

waitingForReply=false

function updateMyDrugs()
	guiGridListClear(gridMyDrugs)
	local drugsTable,drugNames = exports.CSGdrugs:getDrugsTable()
	if not drugsTable then return end
	for a,b in pairs(drugsTable) do
		local a = tostring(a)
		local a2 = tonumber(a)
		if (drugNames[a2]) then
			local row = guiGridListAddRow(gridMyDrugs)
			guiGridListSetItemText ( gridMyDrugs, row, 1, drugNames[a2], false, false )
			guiGridListSetItemText ( gridMyDrugs, row, 2, b, false, false )
		end
	end
end

local oldTick=getTickCount()
local waitingForReply = false
function click()


	if source == btnInsertPerms then
		if waitingForReply==true then return end
	----if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	--if waitingForReply==true then return end
		if type(tostring(guiGetText(txtPermsName))) == "string" then
			local t = {tostring(guiGetText(txtPermsName)),"","",{true,false,false,false,false,false,false,false,true,true,true}}
			local permsT = ged("perms")
			permsT = fromJSON(permsT)
			if permsT == nil or permsT == false then permsT = {{"All Players","Public","",{false,false,false,false,false,false,false,false,true,true,true}}} triggerServerEvent("CSGhousing.syncTableKey",localPlayer,houseEDATA,"perms",toJSON(permsT)) end
			local user =  tostring(guiGetText(txtPermsName))
			local permsT = fromJSON(ged("perms"))
			for k,v in pairs(permsT) do
				if v[1] == user then
					exports.dendxmsg:createNewDxMessage("This player already exists in your permissions list, user: "..user.."",255,255,0)
					return
				end
			end
			table.insert(permsT,t)
			triggerServerEvent("CSGhousing.syncTableKey",localPlayer,houseEDATA,"perms",toJSON(permsT))
			waitingForReply=true
			show()
		else
			exports.dendxmsg:createNewDxMessage("Please make sure your input is valid",255,255,0)
			return
		end
	elseif source == gridPerms then
		--if waitingForReply==true then return end
	--if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
		--if waitingForReply==true then return end
		local row = guiGridListGetSelectedItem(gridPerms)
		if row ~= -1 and row ~= false and row ~= nil then
			local user =  guiGridListGetItemText(gridPerms,row,1)
			local permsT = fromJSON(ged("perms"))
			for k,v in pairs(permsT) do
				if v[1] == user then
					local usersPerms = v[4]
					for k,v in pairs(usersPerms) do
						guiCheckBoxSetSelected(cbs[k],v)
						--if v == true then guiSetColor(cbs[k],0,255,0) else guiSetColor(cbs[k],255,0,0) end
					end
				return
				end
			end
		end
	elseif source == btnPermsDelete then
		if waitingForReply==true then return end
	--if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	if waitingForReply==true then return end
		local row = guiGridListGetSelectedItem(gridPerms)
		if row ~= -1 and row ~= false and row ~= nil then
			local user = guiGridListGetItemText(gridPerms,row,1)
			local permsT = fromJSON(ged("perms"))
			local iToRemove = false
			for k,v in pairs(permsT) do
				if v[1] == user then
					if user ~= "All Players" then
						iToRemove=k
						break
					else
						exports.dendxmsg:createNewDxMessage("You cannot delete your houses' public settings",255,255,0)
						return
					end
				end
			end
			table.remove(permsT,iToRemove)
			waitingForReply=true
			triggerServerEvent("CSGhousing.syncTableKey",localPlayer,houseEDATA,"perms",toJSON(permsT))
			exports.dendxmsg:createNewDxMessage("Successfully deleted user "..user.." from your permissions list",0,255,0)
			return
		else
			exports.dendxmsg:createNewDxMessage("Select a player first to delete them from your permissions list",255,255,0)
			return
		end
	elseif source == btndm or source == btnwm then
	if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	oldTick=getTickCount()
	if waitingForReply==true then return end
		local text = guiGetText(txtamm)
		text=tonumber(text)
		if type(text) == "number" then
			if text < 1 then
				exports.dendxmsg:createNewDxMessage("Please make sure the amount is greater then $0",255,255,0)
				return
			end
			local typ=""
			if source == btndm then
				typ = "Deposit"
			elseif source == btnwm then
				typ = "Withdraw"
			end
				waitingForReply=true
				triggerServerEvent("CSGhousing.moneyStorageTrans",localPlayer,houseEDATA,text,typ)
		else
			exports.dendxmsg:createNewDxMessage("Please make sure your input is valid",255,255,0)
			return
		end
	elseif source == btndw then
	if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	oldTick=getTickCount()
	if waitingForReply==true then return end
		local row = guiGridListGetSelectedItem(gridMyWeps)
		if row ~= -1 and row ~= false and row ~= nil then
			local text = guiGetText(txtamw)
			text=tonumber(text)
			if type(text) ~= "number" then exports.dendxmsg:createNewDxMessage("Please make sure your input is valid",255,255,0) return end
			if text < 1 then exports.dendxmsg:createNewDxMessage("You can't deposit negative ammo!",255,255,0) return end
			local id = getWeaponIDFromName(guiGridListGetItemText(gridMyWeps,row,1))
			id=tonumber(id)

			local weaponsT = fromJSON(ged("weaponsStorage"))
			if weaponsT == nil then weaponsT = {} end
			if weaponsT[id] == nil then weaponsT[id] = 0 end
			for k,v in pairs(myWeps) do
				if getWeaponIDFromName(v[1]) == id then
					if tonumber(v[2]) < text or getPedTotalAmmo(localPlayer,getSlotFromWeapon(id)) < text then
						exports.dendxmsg:createNewDxMessage("You don't have "..text.." "..guiGridListGetItemText(gridMyWeps,row,1).." ammo, you only have "..guiGridListGetItemText(gridMyWeps,row,2).."",255,255,0)
						return
					end
				end
			end
			--outputDebugString("old "..weaponsT[id].."")
			weaponsT[id]=weaponsT[id]+text
			--outputDebugString("new "..weaponsT[id].."")
			waitingForReply=true
			triggerServerEvent("CSGhousing.weaponsTrans",localPlayer,id,text,"","","Deposit",toJSON(weaponsT),houseEDATA)
		else
			exports.dendxmsg:createNewDxMessage("You didn't select a weapon",255,255,0)
			return
		end
	elseif source == btnww then
	if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	oldTick=getTickCount()
	if waitingForReply==true then return end
		local row = guiGridListGetSelectedItem(gridHouseWeps)
		if row ~= -1 and row ~= false and row ~= nil then
			local text = guiGetText(txtamw)
			text=tonumber(text)
			if type(text) ~= "number" then exports.dendxmsg:createNewDxMessage("Please make sure your input is valid",255,255,0) return end
			if text < 1 then exports.dendxmsg:createNewDxMessage("You can't withdraw negative ammo!",255,255,0) return end
			local id = getWeaponIDFromName(guiGridListGetItemText(gridHouseWeps,row,1))
			local ammo = tonumber(guiGridListGetItemText(gridHouseWeps,row,2))
			if ammo == nil then
				return
			end
			id=tonumber(id)
			local weaponsT = fromJSON(ged("weaponsStorage"))
			if weaponsT == nil then weaponsT = {} end
			if weaponsT[id] == nil then
				weaponsT[id] = ammo
			else
				if weaponsT[id] ~= ammo then
					updateData()
					return
				end
			end
			if ammo < text then
				exports.dendxmsg:createNewDxMessage("The house storage doesn't have "..text.." "..guiGridListGetItemText(gridHouseWeps,row,1).." ammo, only "..ammo.."",255,255,0)
				return
			end
			--outputDebugString("old "..weaponsT[id].."")
			weaponsT[id]=weaponsT[id]-text
			--outputDebugString("new "..weaponsT[id].."")
			local slot = getSlotFromWeapon(id)
			local currID = getPedWeapon(localPlayer,slot)
			local totalAmmoInSlot = getPedTotalAmmo(localPlayer,slot)
			waitingForReply=true
			triggerServerEvent("CSGhousing.weaponsTrans",localPlayer,id,text,totalAmmoInSlot,currID,"Withdraw",toJSON(weaponsT),houseEDATA)
		else
			exports.dendxmsg:createNewDxMessage("You didn't select a weapon",255,255,0)
			return
		end
	elseif source == btnwd then
	if getElementData(localPlayer,"drugsOpen") == true then
		exports.dendxmsg:createNewDxMessage("Please close F4 / Drugs Menu, you cannot use house deposit or withdraw while it is open!",255,255,0)
		return
	end
	if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	oldTick=getTickCount()
	if waitingForReply==true then return end
		local row = guiGridListGetSelectedItem(gridHouseDrugs)
		if row ~= -1 and row ~= false and row ~= nil then
			local text = tonumber(guiGetText(txtamd))
			if type(text) ~= "number" then exports.dendxmsg:createNewDxMessage("Please make sure your input is valid",255,255,0) return end
			if text < 1 then exports.dendxmsg:createNewDxMessage("You can't withdraw negative drugs!",255,255,0) return end
			local name = guiGridListGetItemText(gridHouseDrugs,row,1)
			local houseAmount = tonumber(guiGridListGetItemText(gridHouseDrugs,row,2))
			if houseAmount < text then
				exports.dendxmsg:createNewDxMessage("The house storage doesn't have "..text.." "..name..", only "..houseAmount.."",255,255,0)
				return
			end
			local houseDrugs = fromJSON(ged("drugsStorage"))
			if houseDrugs[name] == nil then houseDrugs[name]=houseAmount end
			houseDrugs[name]=houseDrugs[name]-text
			waitingForReply=true
			triggerServerEvent("CSGhousing.drugsTrans",localPlayer,name,text,"Withdraw",toJSON(houseDrugs),houseEDATA)
		else
			exports.dendxmsg:createNewDxMessage("You didn't select a drug",255,255,0)
			return
		end
	elseif source == btndd then
	if getElementData(localPlayer,"drugsOpen") == true then
		exports.dendxmsg:createNewDxMessage("Please close F4 / Drugs Menu, you cannot use house deposit or withdraw while it is open!",255,255,0)
		return
	end
	if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	oldTick=getTickCount()
	if waitingForReply==true then return end
		local row = guiGridListGetSelectedItem(gridMyDrugs)
		if row ~= -1 and row ~= false and row ~= nil then
			local text = tonumber(guiGetText(txtamd))
			if type(text) ~= "number" then exports.dendxmsg:createNewDxMessage("Please make sure your input is valid",255,255,0) return end
			if text < 1 then exports.dendxmsg:createNewDxMessage("You can't deposit negative drugs!",255,255,0) return end
			local name = guiGridListGetItemText(gridMyDrugs,row,1)
			local drugsTable,drugNames = exports.CSGdrugs:getDrugsTable()
			local drugID
			if not ( drugsTable and drugNames ) then return end
			for id,drugName in pairs(drugNames) do
				if name == drugName then drugID = id end
			end
			if not drugID then return end
			local myAm = drugsTable[ID]
			if myAm < text then
				exports.dendxmsg:createNewDxMessage("You don't have "..text.." "..name..", you only have "..myAm.."",255,255,0)
				return
			end
			local houseDrugs = fromJSON(ged("drugsStorage"))
			if houseDrugs[name] == nil then houseDrugs[name]=0 end
			houseDrugs[name]=houseDrugs[name]+text
			waitingForReply=true
			triggerServerEvent("CSGhousing.drugsTrans",localPlayer,name,text,"Deposit",toJSON(houseDrugs),houseEDATA)
		else
			exports.dendxmsg:createNewDxMessage("You didn't select a drug",255,255,0)
			return
		end
	elseif source == btnaddsong then
	--if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	if waitingForReply==true then return end
		local name = guiGetText(txtsongname)
		if name == "" then exports.dendxmsg:createNewDxMessage("You didn't enter a song name",255,255,0) return end
		if name == "None" or name == "none" then exports.dendxmsg:createNewDxMessage("This song name is forbidden. Please use a differnet name.",255,255,0) return end
		local link = guiGetText(txtlink)
		if link == "" then exports.dendxmsg:createNewDxMessage("You didn't enter a link to the song",255,255,0) return end
		local musicT = fromJSON(ged("music"))
		if musicT[name] ~= nil then
			exports.dendxmsg:createNewDxMessage("A song with the same name already exists in the music list",255,255,0)
			return
		end
		for k,v in pairs(musicT) do
			if v[2] ~= nil then
				if v[2] == link then
					exports.dendxmsg:createNewDxMessage("The song named "..k.." has the same link, this song already exists in the music list",255,255,0)
					return
				end
			end
		end
		waitingForReply=true
		exports.dendxmsg:createNewDxMessage("Added the song "..name.." to the house music list",0,255,0)
		musicT[name] = {""..myuser.."("..getPlayerName(localPlayer)..")",link}
		triggerServerEvent("CSGhousing.updatedMusicTable",localPlayer,toJSON(musicT),houseEDATA)
	elseif source == btndeletesong then
	--if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	if waitingForReply==true then return end
		local row = guiGridListGetSelectedItem(gridMusic)
		if row ~= -1 and row ~= false and row ~= nil then
			local name = guiGridListGetItemText(gridMusic,row,1)
			local musicT = fromJSON(ged("music"))
			if musicT["Playing"] == name then
				exports.dendxmsg:createNewDxMessage("You can't delete the song while its playing",255,255,0)
				exports.dendxmsg:createNewDxMessage("Stop the song first, then delete it.",255,255,0)
				return
			end
			musicT[name] = nil
			exports.dendxmsg:createNewDxMessage("Deleted the song "..name.." from the house music list",0,255,0)
			waitingForReply=true
			triggerServerEvent("CSGhousing.updatedMusicTable",localPlayer,toJSON(musicT),houseEDATA)
		else
			exports.dendxmsg:createNewDxMessage("You didn't select a song to delete",255,255,0)
			return
		end
	elseif source == btnplay then
	--if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	if waitingForReply==true then return end
		local row = guiGridListGetSelectedItem(gridMusic)
		if row ~= -1 and row ~= false and row ~= nil then
			local link = guiGridListGetItemText(gridMusic,row,3)
			local musicT = fromJSON(ged("music"))
			musicT["Playing"] = guiGridListGetItemText(gridMusic,row,1)
			waitingForReply=true
			triggerServerEvent("CSGhousing.updatedMusicTable",localPlayer,toJSON(musicT),houseEDATA)
			triggerServerEvent("CSGhousing.playSound",localPlayer,link,houseEDATA)
		else
			exports.dendxmsg:createNewDxMessage("You didn't select a song to play",255,255,0)
			return
		end
	elseif source == btnstop then
	--if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	if waitingForReply==true then return end
		local musicT = fromJSON(ged("music"))
		musicT["Playing"] = "None"
		triggerServerEvent("CSGhousing.updatedMusicTable",localPlayer,toJSON(musicT),houseEDATA)
		triggerServerEvent("CSGhousing.stopSound",localPlayer,houseEDATA)
	elseif source == btnhousesettings then
	--if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	if waitingForReply==true then return end
		triggerServerEvent("CSGhousing.showHouseSettings",localPlayer,houseEDATA)
	elseif source == btndownrad then
	--if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	if waitingForReply==true then return end
		local musicT = fromJSON(ged("music"))
		if musicT["Playing"] ~= "None" then
			triggerServerEvent("CSGhousing.volChange",localPlayer,houseEDATA,"down")
		else
			exports.dendxmsg:createNewDxMessage("You can't control volume when there is no song playing!",255,255,0)
			return
		end
	elseif source == btnuprad then
	--if getTickCount() - oldTick < 3000 then exports.dendxmsg:createNewDxMessage("Do not spam click!",255,255,0) return end
	if waitingForReply==true then return end
		local musicT = fromJSON(ged("music"))
		if musicT["Playing"] ~= "None" then
			triggerServerEvent("CSGhousing.volChange",localPlayer,houseEDATA,"up")
		else
			exports.dendxmsg:createNewDxMessage("You can't control volume when there is no song playing!",255,255,0)
			return
		end
	else
		myWeps = {}
		local oldrow = guiGridListGetSelectedItem(gridMyWeps)
		updateMyWeps()
		if oldrow ~= -1 and oldrow ~= false and oldrow ~= nil then
			guiGridListSetSelectedItem(gridMyWeps,oldrow,1)
		end
		myDrugs = {}
		local oldrow2 = guiGridListGetSelectedItem(gridMyDrugs)
		updateMyDrugs()
		if oldrow2 ~= -1 and oldrow2 ~= false and oldrow2 ~= nil then
			guiGridListSetSelectedItem(gridMyDrugs,oldrow2,1)
		end
		for kmain,v in pairs(cbs) do
			if source == v then
				local row = guiGridListGetSelectedItem(gridPerms)
				if row ~= -1 and row ~= false and row ~= nil then
					local user =  guiGridListGetItemText(gridPerms,row,1)
					local permsT = fromJSON(ged("perms"))
					for k,v in pairs(permsT) do
						if v[1] == user then
							local usersPerms = v[4]
							permsT[k][4][kmain] = guiCheckBoxGetSelected(source)
							waitingForReply=true
							triggerServerEvent("CSGhousing.syncTableKey",localPlayer,houseEDATA,"perms",toJSON(permsT))
							triggerServerEvent("CSGhousing.updatedAccess",localPlayer,exports.server:getPlayerFromAccountname(user),k,permsT[k][4][kmain])
							exports.dendxmsg:createNewDxMessage("Successfully updated permissions for user "..user.."",0,255,0)
							for k,v in pairs(usersPerms) do
								guiCheckBoxSetSelected(cbs[k],v)
								--if v == true then guiSetColor(cbs[k],0,255,0) else guiSetColor(cbs[k],255,0,0) end
							end
						return
						end
					end
				else
					exports.dendxmsg:createNewDxMessage("Select a player first before changing permissions",255,255,0)
					guiCheckBoxSetSelected(v,false)
					return
				end
			end
		end
	end
	guiGridListSetSelectedItem ( gridPerms, 0, 0)
	for k,v in pairs(cbs) do
		guiCheckBoxSetSelected(v,false)
	end
end
addEventHandler("onClientGUIClick",root,click)

addEvent("CSGhousing.playSoundC",true)
addEventHandler("CSGhousing.playSoundC",localPlayer,function(link,x,y,z,dim,pos)

	if isTimer(posTimer) then killTimer(posTimer) end
	stopSound(sound)
	if isElement(sound) then destroyElement(sound) end
	sound = playSound3D(link,x,y,z)
	setSoundMaxDistance(sound,50)
	setElementDimension(sound,dim)
	if (pos) then
		--outputDebugString(""..getPlayerName(localPlayer)..". Now attempting to sync you to "..pos.."s")
		posTimer = setTimer(function() setSoundPosition(sound,pos) if getSoundPosition(sound) == pos then killTimer(posTimer) end end,50,0)
	end
end)

addEvent("CSGhousing.stopSoundC",true)
addEventHandler("CSGhousing.stopSoundC",localPlayer,function()
	if isTimer(posTimer) then killTimer(posTimer) end
	stopSound(sound)
	if isElement(sound) then destroyElement(sound) end
end)

function toggle()
	if guiGetVisible(window) then
		hide()
		setElementData(localPlayer,"ho",false,true)
	else
		show()
		setElementData(localPlayer,"ho",true,true)
	end
end
addCommandHandler("housepanel",toggle)
addCommandHandler("Housepanel",toggle)
addCommandHandler("hp",toggle)

addEvent("CSGhousing.enteredHouse",true)
addEventHandler("CSGhousing.enteredHouse",localPlayer,function(e,dataa,acc)
exports.dendxmsg:createNewDxMessage("Type /housepanel to toggle House Control Panel",0,255,0)
houseEDATA = e houseData = dataa myuser=acc
end)

addEventHandler("onClientElementDataChange",root,function()
	local rowPerms = guiGridListGetSelectedItem(gridPerms)
	if source == houseEDATA then
		updateData()
	end
	if rowPerms ~= nil and rowPerms ~= false and rowPerms ~= -1 then
		guiGridListSetSelectedItem(gridPerms,rowPerms,1)
	end
	waitingForReply=false
end)

addEvent("CSGhousing.sync",true)
addEventHandler("CSGhousing.sync",localPlayer,function(house,dataa)

	local rowPerms = guiGridListGetSelectedItem(gridPerms)
	houseData=dataa
	houseEDATA=house
	updateData()
	if rowPerms ~= nil and rowPerms ~= false and rowPerms ~= -1 then
		guiGridListSetSelectedItem(gridPerms,rowPerms,1)
	end
end)

addEvent("CSGhousing.leftHouse",true)
addEventHandler("CSGhousing.leftHouse",localPlayer,function() houseData=false houseEDATA=false hide() if isTimer(posTimer) then killTimer(posTimer) end if isElement(sound) then stopSound(sound) destroyElement(sound) end end)

addEvent("CSGhousing.sendSoundLengthUpdate",true)
addEventHandler("CSGhousing.sendSoundLengthUpdate",localPlayer,function()
	if isElement(sound) then
		triggerServerEvent("recSoundLengthUpdate",localPlayer,houseEDATA,getSoundLength(sound))
	end
end)

addEvent("CSGhousing.volChange",true)
addEventHandler("CSGhousing.volChange",localPlayer,function(rad)
	if isElement(sound) == true then
		setSoundMaxDistance(sound,rad)
	end
end)

addEventHandler( "onClientRender",root,
   function( )
	local speakerx,speakery,speakerz=0,0,0
	if houseEDATA ~= false then
		local t = fromJSON(ged("speakerpos"))
		if t[1] ~= nil then
			speakerx,speakery,speakerz = t[1]-0.8,t[2],t[3]+0.4
		else
		return
		end
		local t2 = fromJSON(ged("music"))
		if t2["Playing"] == "None" then return else songName = t2["Playing"] end
	else
		return
	end
	if isElement(sound) == false then return end
      local px, py, pz, tx, ty, tz, dist
      px, py, pz = getCameraMatrix( )
         tx, ty, tz = speakerx,speakery,speakerz

         dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
         if dist < 30.0 then
			if isLineOfSightClear( px, py, pz, tx, ty, tz, false, false, false, true, false, false, false,localPlayer ) then
			   local sx, sy, sz = 0,0,0
			   local x = false
					sx, sy, sz = speakerx,speakery,speakerz
					x,y = getScreenFromWorldPosition( sx, sy, sz + 1.2 )
               if x then -- getScreenFromWorldPosition returns false if the point isn't on screen
					local r,g,b = 0,255,0

					dxDrawText( ">> "..songName.." << :: "..math.floor(getSoundPosition(sound)+0.5).."s/"..math.floor(getSoundLength(sound)+0.5).."s", x, y, x, y, tocolor(r,g,b), 0.85 + ( 15 - dist ) * 0.06)
				end
            end
         end
		-- end
      end
)
