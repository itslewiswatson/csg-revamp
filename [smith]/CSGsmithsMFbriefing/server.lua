------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithMFbriefing/server (server-side)
--  MF Briefing
--  [CSG]Smith
------------------------------------------------------------------------------------


--Marker1 = createMarker (1213.5735351563, -1652.7731933594, 16.296875, 'ring',0.2, 0,255,0,150)
Marker1 = createMarker (199.95, 1992.29, 21.55, 'ring',0.2, 0,255,0,150)
Marker2 = createMarker (199.95, 1992.29, 21.55, 'ring',0.2, 255,0,0,150)
Marker3 = createMarker (199.95, 1992.29, 21.55, 'ring',0.2, 0,0,255,150)
Marker4 = createMarker (199.95, 1992.29, 21.55, 'ring',0.2, 255,255,0,150)

function rotation()
	--local rx, ry, rz = getElementRotation(Marker)
	setElementVisibleTo ( Marker1, getRootElement (), false )
	setElementVisibleTo ( Marker2, getRootElement (), false )
	setElementVisibleTo ( Marker3, getRootElement (), false )
	setElementVisibleTo ( Marker4, getRootElement (), false )
end
addEventHandler("onResourceStart",getRootElement(),rotation)


addEvent("MarkerSizeBG", true) 
addEventHandler("MarkerSizeBG", getRootElement(), function() 
	Size1 = getMarkerSize ( Marker1 )
	setMarkerSize (Marker1, Size1+0.05)
end)

addEvent("MarkerSizeBR", true) 
addEventHandler("MarkerSizeBR", getRootElement(), function() 
	Size2 = getMarkerSize ( Marker2 )
	setMarkerSize (Marker2, Size2+0.05)
end)

addEvent("MarkerSizeBB", true) 
addEventHandler("MarkerSizeBB", getRootElement(), function() 
	Size3 = getMarkerSize ( Marker3 )
	setMarkerSize (Marker3, Size3+0.05)
end)

addEvent("MarkerSizeBY", true) 
addEventHandler("MarkerSizeBY", getRootElement(), function() 
	Size4 = getMarkerSize ( Marker4 )
	setMarkerSize (Marker4, Size4+0.05)
end)



addEvent("MarkerSizeLG", true) 
addEventHandler("MarkerSizeLG", getRootElement(), function() 
	Size1 = getMarkerSize ( Marker1 )
	setMarkerSize (Marker1, Size1-0.05)
end)

addEvent("MarkerSizeLR", true) 
addEventHandler("MarkerSizeLR", getRootElement(), function() 
	Size2 = getMarkerSize ( Marker2 )
	setMarkerSize (Marker2, Size2-0.05)
end)

addEvent("MarkerSizeLB", true) 
addEventHandler("MarkerSizeLB", getRootElement(), function() 
	Size3 = getMarkerSize ( Marker3 )
	setMarkerSize (Marker3, Size3-0.05)
end)

addEvent("MarkerSizeLY", true) 
addEventHandler("MarkerSizeLY", getRootElement(), function() 
	Size4 = getMarkerSize ( Marker4 )
	setMarkerSize (Marker4, Size4-0.05)
end)



--Set Markers Visible
addEvent("MarkerVisibleG", true) 
addEventHandler("MarkerVisibleG", getRootElement(), function() 
	setElementVisibleTo ( Marker1, getRootElement (), true )
end)

addEvent("MarkerVisibleR", true) 
addEventHandler("MarkerVisibleR", getRootElement(), function() 
	setElementVisibleTo ( Marker2, getRootElement (), true )
end)

addEvent("MarkerVisibleB", true) 
addEventHandler("MarkerVisibleB", getRootElement(), function() 
	setElementVisibleTo ( Marker3, getRootElement (), true )
end)

addEvent("MarkerVisibleY", true) 
addEventHandler("MarkerVisibleY", getRootElement(), function() 
	setElementVisibleTo ( Marker4, getRootElement (), true )
end)

addEvent("MarkerInVisibleG", true) 
addEventHandler("MarkerInVisibleG", getRootElement(), function() 
	setElementVisibleTo ( Marker1, getRootElement (), false )
end)


--Set Markers Invisible
addEvent("MarkerInVisibleR", true) 
addEventHandler("MarkerInVisibleR", getRootElement(), function() 
	setElementVisibleTo ( Marker2, getRootElement (), false )
end)

addEvent("MarkerInVisibleB", true) 
addEventHandler("MarkerInVisibleB", getRootElement(), function() 
	setElementVisibleTo ( Marker3, getRootElement (), false )
end)

addEvent("MarkerInVisibleY", true) 
addEventHandler("MarkerInVisibleY", getRootElement(), function() 
	setElementVisibleTo ( Marker4, getRootElement (), false )
end)


--Move markers Up
addEvent("MoveUP1", true) 
addEventHandler("MoveUP1", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker1)
	
	x=px
	y=py
	z=pz+0.05
	setElementPosition(Marker1,x,y,z)
end)

addEvent("MoveUP2", true) 
addEventHandler("MoveUP2", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker2)
	
	x=px
	y=py
	z=pz+0.05
	setElementPosition(Marker2,x,y,z)
end)

addEvent("MoveUP3", true) 
addEventHandler("MoveUP3", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker3)
	
	x=px
	y=py
	z=pz+0.05
	setElementPosition(Marker3,x,y,z)
end)

addEvent("MoveUP4", true) 
addEventHandler("MoveUP4", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker4)
	
	x=px
	y=py
	z=pz+0.05
	setElementPosition(Marker4,x,y,z)
end)


--Move markers Down
addEvent("MoveDW1", true) 
addEventHandler("MoveDW1", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker1)
	
	x=px
	y=py
	z=pz-0.05
	setElementPosition(Marker1,x,y,z)
end)

addEvent("MoveDW2", true) 
addEventHandler("MoveDW2", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker2)
	
	x=px
	y=py
	z=pz-0.05
	setElementPosition(Marker2,x,y,z)
end)

addEvent("MoveDW3", true) 
addEventHandler("MoveDW3", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker3)
	
	x=px
	y=py
	z=pz-0.05
	setElementPosition(Marker3,x,y,z)
end)

addEvent("MoveDW4", true) 
addEventHandler("MoveDW4", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker4)
	
	x=px
	y=py
	z=pz-0.05
	setElementPosition(Marker4,x,y,z)
end)


--Move markers Right
addEvent("MoveRG1", true) 
addEventHandler("MoveRG1", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker1)
	
	x=px
	y=py+0.05
	z=pz
	setElementPosition(Marker1,x,y,z)
end)

addEvent("MoveRG2", true) 
addEventHandler("MoveRG2", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker2)
	
	x=px
	y=py+0.05
	z=pz
	setElementPosition(Marker2,x,y,z)
end)

addEvent("MoveRG3", true) 
addEventHandler("MoveRG3", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker3)
	
	x=px
	y=py+0.05
	z=pz
	setElementPosition(Marker3,x,y,z)
end)

addEvent("MoveRG4", true) 
addEventHandler("MoveRG4", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker4)
	
	x=px
	y=py+0.05
	z=pz
	setElementPosition(Marker4,x,y,z)
end)



--Move markers Left
addEvent("MoveLF1", true) 
addEventHandler("MoveLF1", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker1)
	
	x=px
	y=py-0.05
	z=pz
	setElementPosition(Marker1,x,y,z)
end)

addEvent("MoveLF2", true) 
addEventHandler("MoveLF2", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker2)
	
	x=px
	y=py-0.05
	z=pz
	setElementPosition(Marker2,x,y,z)
end)

addEvent("MoveLF3", true) 
addEventHandler("MoveLF3", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker3)
	
	x=px
	y=py-0.05
	z=pz
	setElementPosition(Marker3,x,y,z)
end)

addEvent("MoveLF4", true) 
addEventHandler("MoveLF4", getRootElement(), function() 
	local px, py, pz = getElementPosition(Marker4)
	
	x=px
	y=py-0.05
	z=pz
	setElementPosition(Marker4,x,y,z)
end)
