-- Table for the rules pointing to the file
local rulesToFile = {
	["English"] = "Rules/EN.xml",
	["German"] = "Rules/GM.xml",
	["Greece"] = "Rules/GR.xml",
	["Hungarian"] = "Rules/HR.xml",
	["Indonisian"] = "Rules/ID.xml",
	["Dutch"] = "Rules/NL.xml",
	["Portugese"] = "Rules/PT.xml",
	["Russian"] = "Rules/RU.xml",
	["Spanish"] = "Rules/SP.xml",
	["Thai"] = "Rules/TI.xml",
	["Tunisian"] = "Rules/TN.xml",
	["Turkish"] = "Rules/TR.xml",
	["French"] = "Rules/FR.xml",
	["Chinese"] = "Rules/CN.xml",
	["Arabian"] = "Rules/AR.xml",
	["Egyptian"] = "Rules/EG.xml",
	["Swedish"] = "Rules/SE.xml"
}

-- Table size
function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

-- Rules and information window
local CSGInfoWindow = guiCreateWindow(452,164,696,575,"Community of Social Gaming ~ Rules and information",false)
local CSGInfoTabPanel = guiCreateTabPanel(10,25,677,541,false,CSGInfoWindow)
local CSGInfoTab1 = guiCreateTab("Rules",CSGInfoTabPanel)
-- Rules tab
local CSGInfoTab1Memo = guiCreateMemo(1,2,674,513,"",false,CSGInfoTab1)
guiMemoSetReadOnly ( CSGInfoTab1Memo, true )
local CSGInfoTab1Combo = guiCreateComboBox(409,5,264,( table.size ( rulesToFile ) * 20 ),"Other languages",false,CSGInfoTab1)
guiSetText( CSGInfoTab1Memo, xmlNodeGetValue( xmlLoadFile( "Rules/EN.xml" ) ) or "Error while loading file" )
guiSetProperty ( CSGInfoTab1Combo, "AlwaysOnTop", "true" )
-- Commands tab
local CSGInfoTab2 = guiCreateTab("Commands",CSGInfoTabPanel)
local CSGInfoTab2Memo = guiCreateMemo(1,2,674,513,"",false,CSGInfoTab2)
guiSetText( CSGInfoTab2Memo, xmlNodeGetValue( xmlLoadFile( "Others/commands.xml" ) ) or "Error while loading file" )
guiMemoSetReadOnly ( CSGInfoTab2Memo, true )
-- Jobs tab
local CSGInfoTab3 = guiCreateTab("Jobs information",CSGInfoTabPanel)
local CSGInfoTab3Memo = guiCreateMemo(1,2,674,513,"",false,CSGInfoTab3)
guiSetText( CSGInfoTab3Memo, xmlNodeGetValue( xmlLoadFile( "Others/jobs.xml" ) ) or "Error while loading file" )
guiMemoSetReadOnly ( CSGInfoTab3Memo, true )

guiSetVisible( CSGInfoWindow, false )
guiWindowSetSizable ( CSGInfoWindow, false )

-- Loop to add the rules in a combobox
for i, k in pairs ( rulesToFile ) do
	if ( i == "Commands" ) then break; end
	guiComboBoxAddItem ( CSGInfoTab1Combo, i )
end

-- F1 key bind to open the window
bindKey( "F1", "down",
	function ()
		if ( guiGetVisible( CSGInfoWindow ) ) then
			guiSetVisible( CSGInfoWindow, false )
			showCursor( false )
		else
			guiSetVisible( CSGInfoWindow, true )
			showCursor( true )
		end
	end
)

-- When a combo is selected
addEventHandler ( "onClientGUIComboBoxAccepted", root,
    function ( theCombo )
        if ( theCombo == CSGInfoTab1Combo ) then
            local theItem = guiComboBoxGetSelected ( theCombo )
            local theLang = tostring ( guiComboBoxGetItemText ( theCombo , theItem ) )
			if ( rulesToFile[theLang] ) then
				guiSetText( CSGInfoTab1Memo, xmlNodeGetValue( xmlLoadFile( rulesToFile[theLang] ) ) or "Error while loading file" )
			end
        end
    end
)