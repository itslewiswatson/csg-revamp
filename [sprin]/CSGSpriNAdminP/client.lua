crash = {{{{{{{{ {}, {}, {} }}}}}}}}
--main panel

main = guiCreateWindow(386, 209, 659, 309, "CSG ~ Admin Protection", false)
guiWindowSetSizable(main, false)
guiSetVisible(main,false)
grid = guiCreateGridList(9, 25, 542, 274, false, main)
ac1 = guiGridListAddColumn(grid, "Account", 0.3)
sr1 = guiGridListAddColumn(grid, "Serial", 0.5)
addbut = guiCreateButton(555, 25, 94, 48, "Add", false, main)
guiSetProperty(addbut, "NormalTextColour", "FFAAAAAA")
delbut = guiCreateButton(556, 78, 93, 50, "Remove", false, main)
guiSetProperty(delbut, "NormalTextColour", "FFAAAAAA")
closebut = guiCreateButton(555, 253, 94, 46, "Close", false, main)
guiSetProperty(closebut, "NormalTextColour", "FFAAAAAA")    
refreshbut = guiCreateButton(556, 192, 93, 49, "Refresh", false, main)
guiSetProperty(refreshbut, "NormalTextColour", "FFAAAAAA")  
serialrem = guiCreateButton(556, 133, 93, 49, "Serial remove", false, main)
guiSetProperty(serialrem, "NormalTextColour", "FFAAAAAA")    

addEvent("cRequestAdP",true)
function protectreq(data)
	guiGridListClear(grid)
	for i,v in pairs(data) do
        local row = guiGridListAddRow(grid)
        guiGridListSetItemText(grid, row, 1, tostring(v.account), false, false )
		guiGridListSetItemText(grid, row, 2, tostring(v.serial), false, false )
	end	
end
addEventHandler("cRequestAdP",root,protectreq)
--add panel
window2 = guiCreateWindow(503, 164, 434, 236, "Add", false)
guiWindowSetSizable(window2, false)
guiSetVisible(window2,false)
acc = guiCreateEdit(9, 48, 415, 36, "", false, window2)
ser = guiCreateEdit(10, 125, 414, 34, "", false, window2)
act = guiCreateLabel(11, 23, 75, 25, "Account:", false, window2)
srt = guiCreateLabel(11, 106, 49, 19, "Serial:", false, window2)
ad = guiCreateButton(11, 188, 108, 38, "Add", false, window2)
guiSetProperty(ad, "NormalTextColour", "FFAAAAAA")
can = guiCreateButton(316, 189, 98, 37, "Cancel", false, window2)
guiSetProperty(can, "NormalTextColour", "FFAAAAAA")   
--serial remove panel
window3 = guiCreateWindow(503, 164, 434, 236, "Remove", false)
guiWindowSetSizable(window2, false)
guiSetVisible(window3,false)
acc3 = guiCreateEdit(9, 48, 415, 36, "", false, window3)
ser3 = guiCreateEdit(10, 125, 414, 34, "", false, window3)
act3 = guiCreateLabel(11, 23, 75, 25, "Account:", false, window3)
srt3 = guiCreateLabel(11, 106, 49, 19, "Serial:", false, window3)
ad3 = guiCreateButton(11, 188, 108, 38, "Remove", false, window3)
guiSetProperty(ad3, "NormalTextColour", "FFAAAAAA")
can3 = guiCreateButton(316, 189, 98, 37, "Cancel", false, window3)
guiSetProperty(can3, "NormalTextColour", "FFAAAAAA")    


addCommandHandler("adminp",
function ()
if (exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 4) then
	guiSetVisible(main,true)
	showCursor(true)
	guiGridListClear(grid)
	triggerServerEvent( "requestAdP", localPlayer)
end	
end)

addEventHandler("onClientGUIChanged", acc, function(text)
account = guiGetText(text)
end)

addEventHandler("onClientGUIChanged", acc3, function(text)
account3 = guiGetText(text)
end)

addEventHandler("onClientGUIChanged", ser, function(text)
serial = guiGetText(text)
end)

addEventHandler("onClientGUIChanged", ser3, function(text)
serial3 = guiGetText(text)
end)

addEventHandler("onClientGUIClick",root,
function ()
	if source == addbut then
		guiSetVisible(window2,true)
		guiMoveToBack( main )
	end
end)

addEventHandler("onClientGUIClick",root,
function ()
	if source == serialrem then
		guiSetVisible(window3,true)
		guiMoveToBack( main )
	end
end)

addEventHandler("onClientGUIClick",root,
function ()
	if source == refreshbut then
		triggerServerEvent( "requestAdP", localPlayer)
	end
end)	

addEventHandler("onClientGUIClick",root,
function ()
	if source == ad then
		if account then
			if serial then
				guiSetVisible(window3,false)
				guiSetVisible(main,true)
				triggerServerEvent("add", getLocalPlayer(), account, serial)
				guiGridListClear(grid)
				triggerServerEvent( "requestAdP", localPlayer)
			else	
				cancelEvent()
			end
		else	
			cancelEvent()
		end	
	end
end)

addEventHandler("onClientGUIClick",root,
function ()
	if source == ad3 then
		if account3 then
			if serial3 then
				guiSetVisible(window2,false)
				guiSetVisible(main,true)
				triggerServerEvent("del", getLocalPlayer(), account3, serial3)
				guiGridListClear(grid)
				triggerServerEvent( "requestAdP", localPlayer)
			else	
				cancelEvent()
			end
		else	
			cancelEvent()
		end	
	end
end)

addEventHandler("onClientGUIClick",root,
function ()
	if source == can then
		guiSetVisible(window2,false)
		guiSetVisible(main,true)
	end	
end)

addEventHandler("onClientGUIClick",root,
function ()
	if source == can3 then
		guiSetVisible(window3,false)
		guiSetVisible(main,true)
	end	
end)

addEventHandler("onClientGUIClick",root,
function ()
	if source == closebut then
		guiSetVisible(main,false)
		showCursor(false)
	end	
end)

addEventHandler("onClientGUIClick",root,
function ()
	if source == delbut then
		accountdel = guiGridListGetItemText ( grid, guiGridListGetSelectedItem ( grid ), 1 )
		if accountdel then
			triggerServerEvent("del", getLocalPlayer(), accountdel)
			guiGridListClear(grid)
			triggerServerEvent( "requestAdP", localPlayer)
		end	
	end	
end)

--playerName = guiGridListGetItemText ( playerList, guiGridListGetSelectedItem ( playerList ), 1 )
addCommandHandler("del",
function (cmd, account, serial)
if (exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 4) then
	if (account) and not (serial) then
		triggerServerEvent("del", getLocalPlayer(), account)
	elseif (account) and (serial) then
		triggerServerEvent("del", getLocalPlayer(), account, serial)
	end
end	
end)

function find(name)
if name then
triggerServerEvent("find", getLocalPlayer(), name)
end
end

if fileExists("client.lua") == true then
	fileDelete("client.lua")
end