-- Supporters GUI
supporterWindow = guiCreateWindow(598, 372, 369, 227, "Community of Social Gaming ~ Community Supporters", false)
guiWindowSetSizable(supporterWindow, false)
supporterLabel1 = guiCreateLabel(150, 24, 77, 15, "Playername:", false, supporterWindow)
guiSetFont(supporterLabel1, "default-bold-small")
supporterEdit = guiCreateEdit(81, 44, 215, 23, "", false, supporterWindow)
supporterLabel2 = guiCreateLabel(160, 73, 47, 15, "Reason:", false, supporterWindow)
guiSetFont(supporterLabel2, "default-bold-small")
supporterCombo1 = guiCreateComboBox(80, 93, 216, 88, "", false, supporterWindow)
guiComboBoxAddItem(supporterCombo1, "#08 - Support channel misuse")
guiComboBoxSetSelected (supporterCombo1, 0)
supporterLabel3 = guiCreateLabel(135, 119, 104, 15, "Punishment time:", false, supporterWindow)
guiSetFont(supporterLabel3, "default-bold-small")
supporterCombo2 = guiCreateComboBox(80, 140, 216, 91, "", false, supporterWindow)
guiComboBoxAddItem(supporterCombo2, "5 Minutes")
guiComboBoxAddItem(supporterCombo2, "10 Minutes")
guiComboBoxAddItem(supporterCombo2, "15 Minutes")
guiComboBoxSetSelected (supporterCombo2, 0)
supporterButton1 = guiCreateButton(80, 171, 214, 23, "Punish Player", false, supporterWindow)
supporterButton2 = guiCreateButton(80, 198, 214, 23, "Close Window", false, supporterWindow)

-- Make the GUI movable and center it
guiWindowSetMovable ( supporterWindow, true )
guiWindowSetSizable ( supporterWindow, false )
guiSetVisible ( supporterWindow, false )

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(supporterWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(supporterWindow,x,y,false)

-- Open the window
addEvent( "openSupportersWindow", true )
addEventHandler( "openSupportersWindow", root,
	function ()
		guiSetVisible ( supporterWindow, true )
		showCursor ( true )
	end
)

-- Close button
addEventHandler( "onClientGUIClick", supporterButton2,
	function ()
		guiSetVisible ( supporterWindow, false )
		showCursor ( false )
	end, false
)

-- Punish player
addEventHandler( "onClientGUIClick", supporterButton1,
	function ()
		if ( guiGetText( supporterEdit ) == "" ) or ( guiGetText( supporterEdit ) ==  " " ) then
			outputChatBox( "You didn't enter a playername!", 225, 0, 0 )
		else
			local thePlayer = getPlayerFromNamePart( guiGetText( supporterEdit ) )
			if ( thePlayer ) then
				local theReason = guiComboBoxGetItemText ( supporterCombo1, guiComboBoxGetSelected ( supporterCombo1 ) )
				local theTime = guiComboBoxGetItemText ( supporterCombo2, guiComboBoxGetSelected ( supporterCombo2 ) )
				if ( theTime == "5 Minutes" ) then muteTime = 300 elseif ( theTime == "10 Minutes" ) then muteTime = 600 else muteTime = 900 end
				triggerServerEvent( "onSupportMutePlayer", localPlayer, thePlayer, theReason, muteTime )
			else
				outputChatBox( "No player found with this name, please try again!", 225, 0, 0 )
			end
		end
	end, false
)

-- Get player from a part of the name
function getPlayerFromNamePart( namePart )
	local result = false
    if ( namePart ) then
        for i, thePlayer in ipairs(getElementsByType("player")) do
            if ( string.find( getPlayerName( thePlayer ):lower(), tostring( namePart ):lower(), 1, true ) ) then
				if ( result ) then return false end
					result = thePlayer 
				end
			end
		end
    return result
end

-- isPlayerSupporter
function isPlayerSupporter ( thePlayer )
	if not ( isElement( thePlayer ) ) then
		return false
	else
		return getElementData( thePlayer, "isPlayerSupporter" )
	end
end