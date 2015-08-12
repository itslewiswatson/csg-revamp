------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithMFbriefing/client (client-side)
--  MF Briefing
--  [CSG]Smith
------------------------------------------------------------------------------------


SWATWindow_MAP = guiCreateWindow(909,307,327,347,"MF - Map managment",false)

	MoveUP = guiCreateButton(211,220,56,25,"Up",false,SWATWindow_MAP)
		guiSetProperty(MoveUP,"HoverTextColour","FF00FF00")
	MoveDW = guiCreateButton(211,300,56,25,"Down",false,SWATWindow_MAP)
		guiSetProperty(MoveDW,"HoverTextColour","FF00FF00")
	MoveRG = guiCreateButton(257,260,56,25,"Right",false,SWATWindow_MAP)
		guiSetProperty(MoveRG,"HoverTextColour","FF00FF00")
	MoveLF = guiCreateButton(166,260,56,25,"Left",false,SWATWindow_MAP)
		guiSetProperty(MoveLF,"HoverTextColour","FF00FF00")
	SetMarkerVisible = guiCreateButton(16,41,140,23,"Set Visible",false,SWATWindow_MAP)
		guiSetProperty(SetMarkerVisible,"HoverTextColour","FF00FF00")
	SetMarkerInvisible = guiCreateButton(16,77,140,23,"Set Invisible",false,SWATWindow_MAP)
		guiSetProperty(SetMarkerInvisible,"HoverTextColour","FFFF0000")
	Close_wnd = guiCreateButton(233,26,99,21,"Close Window",false,SWATWindow_MAP)
		guiSetProperty(Close_wnd,"HoverTextColour","FFFF0000")
	Size_big = guiCreateButton(239,145,79,27,"Bigger",false,SWATWindow_MAP)
		guiSetProperty(Size_big,"HoverTextColour","FFFF0000")
	Size_small = guiCreateButton(164,150,65,19,"Smaller",false,SWATWindow_MAP)
		guiSetProperty(Size_small,"HoverTextColour","FFFF0000")

	SWATMarkersGrid = guiCreateGridList(14,117,145,213,false,SWATWindow_MAP)
		column = guiGridListAddColumn(SWATMarkersGrid,"Markers Aviable to be used",0.8)
		Marker1 = guiGridListAddRow(SWATMarkersGrid)
		Marker2 = guiGridListAddRow(SWATMarkersGrid)
		Marker3 = guiGridListAddRow(SWATMarkersGrid)
		Marker4 = guiGridListAddRow(SWATMarkersGrid)
			guiGridListSetItemText(SWATMarkersGrid, Marker1, column, "GreenMarker", false, false)
			guiGridListSetItemText(SWATMarkersGrid, Marker2, column, "RedMarker", false, false)
			guiGridListSetItemText(SWATMarkersGrid, Marker3, column, "BlueMarker", false, false)
			guiGridListSetItemText(SWATMarkersGrid, Marker4, column, "YellowMarker", false, false)
			guiGridListSetItemColor ( SWATMarkersGrid, Marker1, column, 0, 250, 0,255 )
			guiGridListSetItemColor ( SWATMarkersGrid, Marker2, column, 250, 0, 0,255 )
			guiGridListSetItemColor ( SWATMarkersGrid, Marker3, column, 0, 0, 250,255 )
			guiGridListSetItemColor ( SWATMarkersGrid, Marker4, column, 250, 250, 0,255 )
			
	guiWindowSetSizable(SWATWindow_MAP, false)
  guiSetVisible(SWATWindow_MAP, false)
showCursor(false)


function SWAT_Wnd_Open(thePlayer)
	guiSetVisible ( SWATWindow_MAP, true )
	guiBringToFront ( SWATWindow_MAP )
	--guiSetInputEnabled(true)
	showCursor ( true )
	

	addEventHandler( "onClientGUIClick", Close_wnd, SWAT_Wnd_Close )
	--addEventHandler( "onClientGUIClick", btnFix, fixVehicles, false )
	--addEventHandler( "onClientGUIClick", btnFreeze, frozzen, false )
end
addCommandHandler("mfbriefing",SWAT_Wnd_Open)

function SWAT_Wnd_Close()
	guiSetVisible (SWATWindow_MAP, false )
	showCursor(false)
end


function setMarkerSizeBigger()
		local selectedMarker = guiGridListGetItemText (SWATMarkersGrid, guiGridListGetSelectedItem (SWATMarkersGrid), 1)
		
		if (selectedMarker == "GreenMarker") then
			triggerServerEvent("MarkerSizeBG", getRootElement(), selectedMarker)
		elseif (selectedMarker == "RedMarker") then
			triggerServerEvent("MarkerSizeBR", getRootElement(), selectedMarker)
		elseif (selectedMarker == "BlueMarker") then
			triggerServerEvent("MarkerSizeBB", getRootElement(), selectedMarker)
		elseif (selectedMarker == "YellowMarker") then
			triggerServerEvent("MarkerSizeBY", getRootElement(), selectedMarker)
		else
			--WarningWindow()
			call(getResourceFromName("guiText"),"outputServerGuiText",getRootElement(source), "You have to select first one Marker before take an action! ",250,0,0)
		end
end
addEventHandler("onClientGUIClick", Size_big, setMarkerSizeBigger)


function setMarkerSizeSmaller()
		local selectedMarker = guiGridListGetItemText (SWATMarkersGrid, guiGridListGetSelectedItem (SWATMarkersGrid), 1)
		
		if (selectedMarker == "GreenMarker") then
			triggerServerEvent("MarkerSizeLG", getRootElement(), selectedMarker)
		elseif (selectedMarker == "RedMarker") then
			triggerServerEvent("MarkerSizeLR", getRootElement(), selectedMarker)
		elseif (selectedMarker == "BlueMarker") then
			triggerServerEvent("MarkerSizeLB", getRootElement(), selectedMarker)
		elseif (selectedMarker == "YellowMarker") then
			triggerServerEvent("MarkerSizeLY", getRootElement(), selectedMarker)
		else
			--WarningWindow()
			call(getResourceFromName("guiText"),"outputServerGuiText",getRootElement(source), "You have to select first one Marker before take an action! ",250,0,0)
		end
end
addEventHandler("onClientGUIClick", Size_small, setMarkerSizeSmaller)






function setVisibleMarker()
		local selectedMarker = guiGridListGetItemText (SWATMarkersGrid, guiGridListGetSelectedItem (SWATMarkersGrid), 1)
		
		if (selectedMarker == "GreenMarker") then
			triggerServerEvent("MarkerVisibleG", getRootElement(), selectedMarker)
		elseif (selectedMarker == "RedMarker") then
			triggerServerEvent("MarkerVisibleR", getRootElement(), selectedMarker)
		elseif (selectedMarker == "BlueMarker") then
			triggerServerEvent("MarkerVisibleB", getRootElement(), selectedMarker)
		elseif (selectedMarker == "YellowMarker") then
			triggerServerEvent("MarkerVisibleY", getRootElement(), selectedMarker)
		else
			--WarningWindow()
			call(getResourceFromName("guiText"),"outputServerGuiText",getRootElement(source), "You have to select first one Marker before take an action! ",250,0,0)
		end
end
addEventHandler("onClientGUIClick", SetMarkerVisible, setVisibleMarker)

function setInVisibleMarker()
		local selectedMarker = guiGridListGetItemText (SWATMarkersGrid, guiGridListGetSelectedItem (SWATMarkersGrid), 1)
		
		if (selectedMarker == "GreenMarker") then
			triggerServerEvent("MarkerInVisibleG", getRootElement(), selectedMarker)
		elseif (selectedMarker == "RedMarker") then
			triggerServerEvent("MarkerInVisibleR", getRootElement(), selectedMarker)
		elseif (selectedMarker == "BlueMarker") then
			triggerServerEvent("MarkerInVisibleB", getRootElement(), selectedMarker)
		elseif (selectedMarker == "YellowMarker") then
			triggerServerEvent("MarkerInVisibleY", getRootElement(), selectedMarker)
		else
			--WarningWindow()
			call(getResourceFromName("guiText"),"outputServerGuiText",getRootElement(source), "You have to select first one Marker before take an action! ",250,0,0)
		end
end
addEventHandler("onClientGUIClick", SetMarkerInvisible, setInVisibleMarker)

function MoveMarkerUp()
		local selectedMarker = guiGridListGetItemText (SWATMarkersGrid, guiGridListGetSelectedItem (SWATMarkersGrid), 1)
		
		if (selectedMarker == "GreenMarker") then
			triggerServerEvent("MoveUP1", getRootElement(), selectedMarker)
		elseif (selectedMarker == "RedMarker") then
			triggerServerEvent("MoveUP2", getRootElement(), selectedMarker)
		elseif (selectedMarker == "BlueMarker") then
			triggerServerEvent("MoveUP3", getRootElement(), selectedMarker)
		elseif (selectedMarker == "YellowMarker") then
			triggerServerEvent("MoveUP4", getRootElement(), selectedMarker)
		end
end
addEventHandler("onClientGUIClick", MoveUP, MoveMarkerUp)

function MoveMarkerDw()
		local selectedMarker = guiGridListGetItemText (SWATMarkersGrid, guiGridListGetSelectedItem (SWATMarkersGrid), 1)
		
		if (selectedMarker == "GreenMarker") then
			triggerServerEvent("MoveDW1", getRootElement(), selectedMarker)
		elseif (selectedMarker == "RedMarker") then
			triggerServerEvent("MoveDW2", getRootElement(), selectedMarker)
		elseif (selectedMarker == "BlueMarker") then
			triggerServerEvent("MoveDW3", getRootElement(), selectedMarker)
		elseif (selectedMarker == "YellowMarker") then
			triggerServerEvent("MoveDW4", getRootElement(), selectedMarker)
		end
end
addEventHandler("onClientGUIClick", MoveDW, MoveMarkerDw)

function MoveMarkerRg()
		local selectedMarker = guiGridListGetItemText (SWATMarkersGrid, guiGridListGetSelectedItem (SWATMarkersGrid), 1)
		
		if (selectedMarker == "GreenMarker") then
			triggerServerEvent("MoveRG1", getRootElement(), selectedMarker)
		elseif (selectedMarker == "RedMarker") then
			triggerServerEvent("MoveRG2", getRootElement(), selectedMarker)
		elseif (selectedMarker == "BlueMarker") then
			triggerServerEvent("MoveRG3", getRootElement(), selectedMarker)
		elseif (selectedMarker == "YellowMarker") then
			triggerServerEvent("MoveRG4", getRootElement(), selectedMarker)
		end
end
addEventHandler("onClientGUIClick", MoveRG, MoveMarkerRg)

function MoveMarkerLf()
		local selectedMarker = guiGridListGetItemText (SWATMarkersGrid, guiGridListGetSelectedItem (SWATMarkersGrid), 1)
		
		if (selectedMarker == "GreenMarker") then
			triggerServerEvent("MoveLF1", getRootElement(), selectedMarker)
		elseif (selectedMarker == "RedMarker") then
			triggerServerEvent("MoveLF2", getRootElement(), selectedMarker)
		elseif (selectedMarker == "BlueMarker") then
			triggerServerEvent("MoveLF3", getRootElement(), selectedMarker)
		elseif (selectedMarker == "YellowMarker") then
			triggerServerEvent("MoveLF4", getRootElement(), selectedMarker)
		end
end
addEventHandler("onClientGUIClick", MoveLF, MoveMarkerLf)