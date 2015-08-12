marker1 = createMarker (2378.2, 2019.94, 9.82 ,"cylinder",2,255,0,0)
--marker2 = createMarker (2632.15, 1664.92, 9.82 ,"cylinder",2,255,0,0)
--marker3 = createMarker (2851.71, 2413.53, 9.82 ,"cylinder",2,255,0,0)
marker4 = createMarker (-1811.82, 614.98, 34.17 ,"cylinder",2,255,0,0)
marker5 = createMarker ( -2663.92, 262.49, 3.33 ,"cylinder",2,255,0,0)
marker6 = createMarker (-2163.9, -2461.27, 29.62  ,"cylinder",2,255,0,0)
marker7 = createMarker (-1210, 1841.46, 40.71  ,"cylinder",2,255,0,0)
marker8 = createMarker ( 171.14, 1181.25, 13.75 ,"cylinder",2,255,0,0)
marker9 = createMarker (951.23, -1376.59, 12.34  ,"cylinder",2,255,0,0)
marker10 = createMarker (2377.44, -1908.82, 12.38 ,"cylinder",2,255,0,0)
marker11 = createMarker (2409.38, -1488.94, 22.82 ,"cylinder",2,255,0,0)
--marker12 = createMarker (2364.29, 2081.52, 9.81 ,"cylinder",2,255,0,0)
marker13 = createMarker (2486.19, 2021.92, 9.82  ,"cylinder",2,255,0,0)
marker14 = createMarker (1859.19, 2082.29, 9.82 ,"cylinder",2,255,0,0)
marker15 = createMarker (1167.51, 2082.78, 9.82 ,"cylinder",2,255,0,0)
--marker16 = createMarker (-1909.77, 819.56, 34.17 ,"cylinder",2,255,0,0)
marker17 = createMarker (-2345.53, 1023.93, 49.69 ,"cylinder",2,255,0,0)
marker18 = createMarker (-2352.66, -155.04, 34.32 ,"cylinder",2,255,0,0)
marker19 = createMarker (1212.41, -904.42, 41.92 ,"cylinder",2,255,0,0)
marker20 = createMarker (799.31, -1629.13, 12.38 ,"cylinder",2,255,0,0)
marker21 = createMarker (2632.54, 1842.63, 9.82 ,"cylinder",2,255,0,0)
marker22 = createMarker (2371.04, 2533.82, 9.82 ,"cylinder",2,255,0,0)
--marker23 = createMarker (2760.01, 2463.31, 9.82 ,"cylinder",2,255,0,0)
--marker24 = createMarker (-1804.5, 951.65, 23.89 ,"cylinder",2,255,0,0)
--marker25 = createMarker (-1716.83, 1350.52, 6.17 ,"cylinder",2,255,0,0)
marker26 = createMarker (199.69, -172.01, 0.57 ,"cylinder",2,255,0,0)
marker27 = createMarker (1374.86, 268.72, 18.56 ,"cylinder",2,255,0,0)
marker28 = createMarker (2328.19, 84.55, 25.48 ,"cylinder",2,255,0,0)
marker29 = createMarker (2108.61, -1784.78, 12.38 ,"cylinder",2,255,0,0)



function enterCluckin(hp,dim)
	if dim==false then return end
	if hp ~= localPlayer then return end
    if ( getPedOccupiedVehicle (localPlayer) ) then
		local x,y,z = getElementPosition(source)
		local x2,y2,z2 = getElementPosition(hp)
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 4 then return end
	    cluckinMarkerHit(localPlayer,true)
	else
	    exports.DENdxmsg:createNewDxMessage ("This is a drive thru, please use a vehicle or go inside the store", 255,0,0)
	end
end
addEventHandler ("onClientMarkerHit", marker1, enterCluckin, false)
--addEventHandler ("onClientMarkerHit", marker2, enterCluckin, false)
--addEventHandler ("onClientMarkerHit", marker3, enterCluckin, false)
addEventHandler ("onClientMarkerHit", marker4, enterCluckin, false)
addEventHandler ("onClientMarkerHit", marker5, enterCluckin, false)
addEventHandler ("onClientMarkerHit", marker6, enterCluckin, false)
addEventHandler ("onClientMarkerHit", marker7, enterCluckin, false)
addEventHandler ("onClientMarkerHit", marker8, enterCluckin, false)
addEventHandler ("onClientMarkerHit", marker9, enterCluckin, false)
addEventHandler ("onClientMarkerHit", marker10, enterCluckin, false)
addEventHandler ("onClientMarkerHit", marker11, enterCluckin, false)


function exitCluckin(hp,dim)
	if dim==false then return end
	if hp ~= localPlayer then return end
	cluckinHide()
end
addEventHandler ("onClientMarkerLeave", marker1, exitCluckin, false)
--addEventHandler ("onClientMarkerLeave", marker2, exitCluckin, false)
--addEventHandler ("onClientMarkerLeave", marker3, exitCluckin, false)
addEventHandler ("onClientMarkerLeave", marker4, exitCluckin, false)
addEventHandler ("onClientMarkerLeave", marker5, exitCluckin, false)
addEventHandler ("onClientMarkerLeave", marker6, exitCluckin, false)
addEventHandler ("onClientMarkerLeave", marker7, exitCluckin, false)
addEventHandler ("onClientMarkerLeave", marker8, exitCluckin, false)
addEventHandler ("onClientMarkerLeave", marker9, exitCluckin, false)
addEventHandler ("onClientMarkerLeave", marker10, exitCluckin, false)
addEventHandler ("onClientMarkerLeave", marker11, exitCluckin, false)

function enterBurger(hp,dim)
	if dim==false then return end
	if hp ~= localPlayer then return end
    if ( getPedOccupiedVehicle (localPlayer) ) then
			local x,y,z = getElementPosition(source)
		local x2,y2,z2 = getElementPosition(hp)
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 4 then return end
	    burgerMarkerHit(localPlayer,true)
	else
	    exports.DENdxmsg:createNewDxMessage ("This is a drive thru, please use a vehicle or go inside the store", 255,0,0)
	end
end
--addEventHandler ("onClientMarkerHit", marker12, enterBurger, false)
addEventHandler ("onClientMarkerHit", marker13, enterBurger, false)
addEventHandler ("onClientMarkerHit", marker14, enterBurger, false)
addEventHandler ("onClientMarkerHit", marker15, enterBurger, false)
--addEventHandler ("onClientMarkerHit", marker16, enterBurger, false)
addEventHandler ("onClientMarkerHit", marker17, enterBurger, false)
addEventHandler ("onClientMarkerHit", marker18, enterBurger, false)
addEventHandler ("onClientMarkerHit", marker19, enterBurger, false)
addEventHandler ("onClientMarkerHit", marker20, enterBurger, false)

function exitBurger(hp,dim)
	if dim==false then return end
	if hp ~= localPlayer then return end
	burgerHide()
end
addEventHandler ("onClientMarkerLeave", marker13, exitBurger, false)
addEventHandler ("onClientMarkerLeave", marker14, exitBurger, false)
addEventHandler ("onClientMarkerLeave", marker15, exitBurger, false)
--addEventHandler ("onClientMarkerLeave", marker16, exitBurger, false)
addEventHandler ("onClientMarkerLeave", marker17, exitBurger, false)
addEventHandler ("onClientMarkerLeave", marker18, exitBurger, false)
addEventHandler ("onClientMarkerLeave", marker19, exitBurger, false)


function enterPizza(hp,dim)
	if dim==false then return end
	if hp ~= localPlayer then return end
    if ( getPedOccupiedVehicle (localPlayer) ) then
			local x,y,z = getElementPosition(source)
		local x2,y2,z2 = getElementPosition(hp)
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 4 then return end
	   pizzaMarkerHit(localPlayer,true)
	else
	    exports.DENdxmsg:createNewDxMessage ("This is a drive thru, please use a vehicle or go inside the store", 255,0,0)
	end
end
addEventHandler ("onClientMarkerHit", marker21, enterPizza, false)
addEventHandler ("onClientMarkerHit", marker22, enterPizza, false)
--addEventHandler ("onClientMarkerHit", marker23, enterPizza, false)
--addEventHandler ("onClientMarkerHit", marker24, enterPizza, false)
--addEventHandler ("onClientMarkerHit", marker25, enterPizza, false)
addEventHandler ("onClientMarkerHit", marker26, enterPizza, false)
addEventHandler ("onClientMarkerHit", marker27, enterPizza, false)
addEventHandler ("onClientMarkerHit", marker28, enterPizza, false)
addEventHandler ("onClientMarkerHit", marker29, enterPizza, false)

function exitPizza(hp,dim)
	if dim==false then return end
	if hp ~= localPlayer then return end
	burgerHide()
end
addEventHandler ("onClientMarkerLeave", marker21, exitPizza, false)
addEventHandler ("onClientMarkerLeave", marker22, exitPizza, false)
--addEventHandler ("onClientMarkerLeave", marker23, exitPizza, false)
--addEventHandler ("onClientMarkerLeave", marker24, exitPizza, false)
--addEventHandler ("onClientMarkerLeave", marker25, exitPizza, false)
addEventHandler ("onClientMarkerLeave", marker26, exitPizza, false)
addEventHandler ("onClientMarkerLeave", marker27, exitPizza, false)
addEventHandler ("onClientMarkerLeave", marker28, exitPizza, false)
addEventHandler ("onClientMarkerLeave", marker29, exitPizza, false)
