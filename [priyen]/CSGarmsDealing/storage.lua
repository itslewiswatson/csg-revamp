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
guiGridListAddColumn(gridPerms, "Last Entered House", 0.3)

GUIEditor.label[6] = guiCreateLabel(9, 8, 286, 15, "Who has access to this house?", false, GUIEditor.tab[1])
guiLabelSetColor(GUIEditor.label[6], 238, 201, 0)
btnInsertPerms = guiCreateButton(10, 171, 96, 28, "Insert:", false, GUIEditor.tab[1])
txtPermsName = guiCreateEdit(112, 171, 82, 28, "name", false, GUIEditor.tab[1])
txtPermsDelete = guiCreateButton(199, 171, 96, 28, "Delete", false, GUIEditor.tab[1])
cbdm = guiCreateCheckBox(301, 35, 141, 15, "Can deposit money", false, false, GUIEditor.tab[1])
cbwm = guiCreateCheckBox(301, 54, 141, 15, "Can withdraw money", false, false, GUIEditor.tab[1])
cbdd = guiCreateCheckBox(301, 73, 141, 15, "Can deposit drugs", false, false, GUIEditor.tab[1])
cbwd = guiCreateCheckBox(301, 92, 141, 15, "Can withdraw drugs", false, false, GUIEditor.tab[1])
cbdw = guiCreateCheckBox(301, 111, 141, 15, "Can deposit weapons", false, false, GUIEditor.tab[1])
cbww = guiCreateCheckBox(301, 130, 150, 15, "Can withdraw weapons", false, false, GUIEditor.tab[1])
cbpm = guiCreateCheckBox(301, 149, 150, 15, "Can play music", false, false, GUIEditor.tab[1])
cbeh = guiCreateCheckBox(301, 15, 150, 15, "Can enter house", false, false, GUIEditor.tab[1])

GUIEditor.tab[2] = guiCreateTab("Money", GUIEditor.tabpanel[1])

GUIEditor.label[7] = guiCreateLabel(11, 13, 115, 20, "Safe Balance:", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[7], 238, 201, 0)
lblsafebalance = guiCreateLabel(95, 13, 115, 20, "$0", false, GUIEditor.tab[2])
GUIEditor.gridlist[2] = guiCreateGridList(11, 40, 432, 118, false, GUIEditor.tab[2])
guiGridListAddColumn(GUIEditor.gridlist[2], "", 0.1)
guiGridListAddColumn(GUIEditor.gridlist[2], "", 0.1)
guiGridListAddColumn(GUIEditor.gridlist[2], "", 0.1)
guiGridListAddColumn(GUIEditor.gridlist[2], "", 0.1)
guiGridListAddColumn(GUIEditor.gridlist[2], "", 0.1)
guiGridListAddColumn(GUIEditor.gridlist[2], "", 0.1)
guiGridListAddColumn(GUIEditor.gridlist[2], "", 0.1)
guiGridListAddColumn(GUIEditor.gridlist[2], "", 0.1)
btnwm = guiCreateButton(11, 169, 146, 26, "Withdraw", false, GUIEditor.tab[2])
btndm = guiCreateButton(294, 169, 146, 26, "Deposit", false, GUIEditor.tab[2])
txtm = guiCreateEdit(161, 169, 129, 28, "money am", false, GUIEditor.tab[2])

GUIEditor.tab[3] = guiCreateTab("Drugs", GUIEditor.tabpanel[1])

GUIEditor.gridlist[3] = guiCreateGridList(11, 29, 185, 172, false, GUIEditor.tab[3])
guiGridListAddColumn(GUIEditor.gridlist[3], "", 0.4)
guiGridListAddColumn(GUIEditor.gridlist[3], "", 0.4)
GUIEditor.gridlist[4] = guiCreateGridList(259, 29, 185, 172, false, GUIEditor.tab[3])
guiGridListAddColumn(GUIEditor.gridlist[4], "", 0.4)
guiGridListAddColumn(GUIEditor.gridlist[4], "", 0.4)
GUIEditor.button[5] = guiCreateButton(198, 65, 55, 31, ">>", false, GUIEditor.tab[3])
GUIEditor.button[6] = guiCreateButton(198, 134, 55, 31, "<<", false, GUIEditor.tab[3])
GUIEditor.edit[3] = guiCreateEdit(200, 100, 53, 31, "drug am", false, GUIEditor.tab[3])
GUIEditor.label[9] = guiCreateLabel(11, 7, 185, 17, "My Drugs", false, GUIEditor.tab[3])
guiLabelSetColor(GUIEditor.label[9], 238, 201, 0)
guiLabelSetHorizontalAlign(GUIEditor.label[9], "center", false)
GUIEditor.label[10] = guiCreateLabel(259, 7, 185, 17, "House Drugs", false, GUIEditor.tab[3])
guiLabelSetColor(GUIEditor.label[10], 238, 201, 0)
guiLabelSetHorizontalAlign(GUIEditor.label[10], "center", false)

GUIEditor.tab[4] = guiCreateTab("Weapons", GUIEditor.tabpanel[1])

GUIEditor.gridlist[5] = guiCreateGridList(11, 29, 185, 172, false, GUIEditor.tab[4])
guiGridListAddColumn(GUIEditor.gridlist[5], "", 0.4)
guiGridListAddColumn(GUIEditor.gridlist[5], "", 0.4)
GUIEditor.gridlist[6] = guiCreateGridList(259, 29, 185, 172, false, GUIEditor.tab[4])
guiGridListAddColumn(GUIEditor.gridlist[6], "", 0.4)
guiGridListAddColumn(GUIEditor.gridlist[6], "", 0.4)
GUIEditor.button[7] = guiCreateButton(198, 65, 55, 31, ">>", false, GUIEditor.tab[4])
GUIEditor.button[8] = guiCreateButton(198, 134, 55, 31, "<<", false, GUIEditor.tab[4])
GUIEditor.edit[4] = guiCreateEdit(200, 100, 53, 31, "weps am", false, GUIEditor.tab[4])
GUIEditor.label[11] = guiCreateLabel(11, 7, 185, 17, "My Weapons", false, GUIEditor.tab[4])
guiLabelSetColor(GUIEditor.label[11], 238, 201, 0)
guiLabelSetHorizontalAlign(GUIEditor.label[11], "center", false)
GUIEditor.label[12] = guiCreateLabel(259, 7, 185, 17, "House Weapons", false, GUIEditor.tab[4])
guiLabelSetColor(GUIEditor.label[12], 238, 201, 0)
guiLabelSetHorizontalAlign(GUIEditor.label[12], "center", false)

GUIEditor.tab[5] = guiCreateTab("Music", GUIEditor.tabpanel[1])

GUIEditor.gridlist[7] = guiCreateGridList(9, 29, 435, 109, false, GUIEditor.tab[5])
guiGridListAddColumn(GUIEditor.gridlist[7], "Name", 0.3)
guiGridListAddColumn(GUIEditor.gridlist[7], "Link", 0.3)
guiGridListAddColumn(GUIEditor.gridlist[7], "Link", 0.3)
GUIEditor.label[14] = guiCreateLabel(8, 8, 94, 15, "Currently Playing:", false, GUIEditor.tab[5])
guiLabelSetColor(GUIEditor.label[14], 238, 201, 0)
GUIEditor.label[15] = guiCreateLabel(111, 8, 94, 15, "playing this song", false, GUIEditor.tab[5])
GUIEditor.button[9] = guiCreateButton(11, 141, 58, 29, "Add:", false, GUIEditor.tab[5])
GUIEditor.label[16] = guiCreateLabel(74, 147, 36, 22, "Name:", false, GUIEditor.tab[5])
GUIEditor.edit[5] = guiCreateEdit(112, 141, 124, 28, "song name", false, GUIEditor.tab[5])
GUIEditor.label[17] = guiCreateLabel(240, 147, 36, 22, "Link:", false, GUIEditor.tab[5])
GUIEditor.edit[6] = guiCreateEdit(269, 141, 175, 28, "link", false, GUIEditor.tab[5])
GUIEditor.button[10] = guiCreateButton(9, 177, 206, 27, "Play", false, GUIEditor.tab[5])
GUIEditor.button[11] = guiCreateButton(237, 177, 206, 27, "Stop", false, GUIEditor.tab[5])


GUIEditor.button[12] = guiCreateButton(326, 28, 135, 35, "House Settings", false, window)
guiSetVisible(window,false)
local hasAllAccess = false
local houseEDATA = false
local myuser = false
hide = function()
	guiSetVisible(window,false)
	showCursor(false)
end

ged = function(k)
	return getElementData(houseEDATA,k)
end

disableAll = function()
	guiSetEnabled(GUIEditor.tab[1],false)
end

show = function()
	disableAll()
	if houseEDATA == false then return end
	if ged("ownername") == myuser then hasAllAccess = true end
	guiSetVisible(window,true)
	guiSetText(window,ged("ownername").."'s House")
	guiGridListClear(gridPerms)
	if myuser == ged("ownername") then
		local permsT = fromJSON(ged("perms"))
		if permsT ~= nil then
			for k,v in permsT do
				local row = guiGridListAddRow(gridPerms)
				for i=1,3 do
					guiGridListSetItemText ( gridPerms, row, i, v[i], false, false )
				end
			end
		end
	end
	if hasAllAccess == true then
		guiSetEnabled(GUIEditor.tab[1],true)
	end
	showCursor(true)
end

function click()
	if source == btnInsertPerms then
		if type(tostring(guiGetText(txtPermsName))) == "string" then
			local t = {tostring(guiGetText(txtPermsName)),"",""}
			local permsT = ged("perms")
			permsT = fromJSON(permsT)
			if permsT == nil or permsT == false then permsT = {} end
			table.insert(permsT,t)
			saveElementData(houseEDATA,"perms",toJSON(permsT),true)
			show()
		else
			--warn bad input
			return
		end
	end
end
addEventHandler("onClientGUIClick",root,click)

function toggle()
	if guiGetVisible(window) then
		hide()
	else
		show()
	end
end
addCommandHandler("mi",toggle)

addEvent("CSGhousing.enteredHouse",true)
addEventHandler("CSGhousing.enteredHouse",localPlayer,function(e,acc) houseEDATA = e myuser=acc end)


