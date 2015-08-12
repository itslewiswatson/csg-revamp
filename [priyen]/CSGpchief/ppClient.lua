GUIEditor = {
    memo = {},
    label = {},
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        window = guiCreateWindow(387, 178, 460, 401, "CSG Police Chief - Panel", false)
        guiWindowSetSizable(window, false)

        list = guiCreateGridList(10, 29, 441, 231, false, window)
        guiGridListAddColumn(list, "Log", 1.2)
		guiGridListAddColumn(list, "Date", 0.3)
        guiGridListAddColumn(list, "Chief", 0.5)
        GUIEditor.memo[1] = guiCreateMemo(12, 286, 436, 78, "Police Chief Commands:\n\nYou must be in a law job to use the commands. 2 Warnings automatically kicks a player from the job. Do not double warn on purpose and be considerate. Your goal is to help police have a better attitude towards their jobs, not punish players. Punishment should always be the final resort. \n /pchiefprintroster - Shows the roster\n\n /pchiefsetlevel username level - Level 5 Chiefs only\n\nLevel 1: /pwarn name reason\nLevel 2: /pwarn name reason, /pkick name reason\nLevel 3: /pwarn name reason, /pkick name reason, /pban name reason (if level 3, 60 minutes)\nLevel 4: /pwarn name reason, /pkick name reason, /pban name reason time <-- minutes\nLevel 5: /pwarn name reason, /pkick name reason, /pban name reason time, /punban name reason\n\nGuidelines:\nWarn before other actions, tell the player what they are doing that is \nunethical and then proceed.\n\nBe aware and be considerate.\n\nFor rank inquiry's, please contact [CSG]Fatal via Forum, do not ask ingame!\nForum message only.\n", false, window)
        GUIEditor.label[1] = guiCreateLabel(12, 267, 82, 16, "My Rank:", false, window)
        guiLabelSetColor(GUIEditor.label[1], 67, 251, 2)
        lblRank = guiCreateLabel(70, 267, 131, 15, "Not a Police Chief", false, window)
        guiLabelSetColor(lblRank, 3, 9, 249)
        btnClose = guiCreateButton(12, 370, 437, 22, "Close", false, window)
		addEventHandler("onClientGUIClick",btnClose,function()
			if source == btnClose then
				guiSetVisible(window,false)
				showCursor(false)
			end
		end)
		guiSetVisible(window,false)
    end
)

addEvent("pchiefLogT",true)
addEventHandler("pchiefLogT",localPlayer,function(t)
	guiGridListClear(list)
	for k,v in ipairs(t) do
		local row = guiGridListInsertRowAfter(list,-1)
		guiGridListSetItemText(list,row,1,v[1],false,false)
		guiGridListSetItemText(list,row,2,v[3],false,false)
		guiGridListSetItemText(list,row,3,v[2],false,false)
	end
end)

addEvent("pchiefLogAction",true)
addEventHandler("pchiefLogAction",localPlayer,function(v1,v2,v3)
	local row = guiGridListInsertRowAfter(list,-1)
	guiGridListSetItemText(list,row,1,v1,false,false)
	guiGridListSetItemText(list,row,2,v3,false,false)
	guiGridListSetItemText(list,row,3,v2,false,false)
end)

addEvent("pchiefRecRank",true)
addEventHandler("pchiefRecRank",localPlayer,function(rank)
	guiSetText(lblRank,"Level "..rank.."")
end)

function tog()
	guiSetVisible(window,not guiGetVisible(window))
	if guiGetVisible(window) then showCursor(true) else showCursor(false) end
end

addCommandHandler("pchief",tog)



