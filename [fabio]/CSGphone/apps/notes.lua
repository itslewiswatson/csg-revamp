local noteFile
local noteText = ""
	if fileExists("apps\\note.txt") then
		noteFile = fileOpen("apps\\note.txt")	
		fileSize = fileGetSize(noteFile)
		if fileSize > 0 then
			noteText = fileRead(noteFile,fileSize)
		end
	else
		noteFile = fileCreate("apps\\note.txt")	
	end

local notesGUI = {}

function openNotes()
	if not notesGUI[1] then notesGUI[1] = guiCreateMemo ( BGX, BGY, 0.99770569801331*BGWidth, 0.92*BGHeight, "", false ) end
	if not notesGUI[2] then notesGUI[2] = guiCreateButton ( BGX+(BGWidth*0.50), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Clear", false ) end
	if not notesGUI[3] then notesGUI[3] = guiCreateButton ( BGX+(BGWidth*0.0), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Save notes", false ) end
	
	guiSetText(notesGUI[1], noteText)
	
	for i=1, #notesGUI do
		guiSetVisible ( notesGUI[i], true )
		guiSetProperty ( notesGUI[i], "AlwaysOnTop", "True" )
	end
	
	addEventHandler ( "onClientGUIClick", notesGUI[2], function() guiSetText( notesGUI[1], "") onSaveMemo() end )
	addEventHandler ( "onClientGUIClick", notesGUI[3], onSaveMemo )
	
	apps[7][7] = true

end

apps[7][8] = openNotes

function closeNotes()

	removeEventHandler ( "onClientGUIClick", notesGUI[2], function() guiSetText( notesGUI[1], "") onSaveMemo() end )
	removeEventHandler ( "onClientGUIClick", notesGUI[3], onSaveMemo )

	for i=1,#notesGUI do
		guiSetVisible ( notesGUI[i], false )
		guiSetProperty ( notesGUI[i], "AlwaysOnTop", "False" )
	end
	
	apps[7][7] = false

end

function onSaveMemo ()
	noteText = guiGetText(notesGUI[1])
	noteFile = fileCreate("apps\\note.txt")	
	fileWrite(noteFile,noteText)
	exports.dendxmsg:createNewDxMessage("Successfully saved!",0,255,0)
end

apps[7][9] = closeNotes