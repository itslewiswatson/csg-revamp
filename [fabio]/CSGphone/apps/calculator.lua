local calculation

local copyTable = function (tab)
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") then ret[key] = table.copy(value)
        else ret[key] = value end
    end
    return ret
end
-- GUI variables

local GUIInfo
local GUIs = {}

local resetCopyTextTimer

addEventHandler ( "onClientResourceStart", resourceRoot,
function ()

	GUIInfo = 
	{
	{ guiCreateMemo, BGX, BGY, BGWidth, BGHeight*0.5, "", false },
	{ guiCreateLabel, BGX, BGY+(BGHeight*0.5), BGWidth, BGHeight*0.25, "", false },
	{ guiCreateButton, BGX, BGY+(BGHeight*0.8), BGWidth, (BGHeight*0.1), "Copy outcome", false },
	{ guiCreateButton, BGX, BGY+(BGHeight*0.9), BGWidth, (BGHeight*0.1), "Clear", false }
	}
	
	apps[14][8] = openCalculator
	apps[14][9] = closeCalculator	
	
end
)

function openCalculator ()

	calculation = ""
	if not GUIs[1] then
	
		for i=1, #GUIInfo do
	
			local args = copyTable( GUIInfo[i] )
			table.remove ( args, 1 )
			local element = GUIInfo[i][1]( unpack( args ) )
			table.insert ( GUIs, element )
			guiSetProperty( element, "AlwaysOnTop", "True" )
		
		end
		
		guiLabelSetVerticalAlign ( GUIs[2], "center" )
		guiLabelSetHorizontalAlign ( GUIs[2], "center" )
		
	else
	
		for i=1, #GUIs do
		
			if isElement ( GUIs[i] ) then guiSetVisible ( GUIs[i], true ) end
			guiSetProperty( GUIs[i], "AlwaysOnTop", "True" )
		end
		
	end
	
	addEventHandler ( "onClientGUIChanged", GUIs[1], onCalculationChange, false )
	addEventHandler ( "onClientGUIClick", GUIs[3], onCalculationCopy, false )
	addEventHandler ( "onClientGUIClick", GUIs[4], onCalculationClear, false )
	
	apps[14][7] = true
	
end

function onCalculationClear()

	guiSetText ( GUIs[1], "" )
	guiSetText ( GUIs[2], "" )

end

function onCalculationCopy()

	setClipboard ( guiGetText( GUIs[2] ) )
	
	if not isTimer( resetCopyTextTimer ) then
	
		guiSetText ( GUIs[3], "Copied!" )
		resetCopyTextTimer = setTimer ( guiSetText, 1000, 1, GUIs[3], "Copy outcome" )
		
	end
	
end

function onCalculationChange()

	calculation = string.gsub( guiGetText ( GUIs[1] ), " ", "" ) 
	calculation = string.gsub( calculation, "%a", "" ) 
	
	if calculation and calculation ~= "" then
	
		local func = loadstring("return ".. calculation)
		if func then
		
			local outcome = func()
			if outcome and type(outcome) == "number" then
		
				guiSetText( GUIs[2], tostring( outcome ) )
				return
				
			end
			
		end
		
		guiSetText( GUIs[2], tostring( "Mathmatical error." ) )
		
	end
	
end

function closeCalculator ()

	apps[14][7] = false
	for i=1,#GUIs do
	
		if isElement ( GUIs[i] ) then guiSetVisible ( GUIs[i], false ) end
		guiSetProperty( GUIs[i], "AlwaysOnTop", "False" )

	end

	removeEventHandler ( "onClientGUIChanged", GUIs[1], onCalculationChange, false )
	removeEventHandler ( "onClientGUIClick", GUIs[3], onCalculationCopy, false )
	removeEventHandler ( "onClientGUIClick", GUIs[4], onCalculationClear, false )
	
end

