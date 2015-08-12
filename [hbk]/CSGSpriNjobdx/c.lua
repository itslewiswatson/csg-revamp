crash = {{{{{{{{ {}, {}, {} }}}}}}}}
local dxlabel = {
[1] = {1178.61, -1319.42, 14.12, "Medic", 0, 225, 225},
--[2] = {1253.16, 328.22, 19.75, "Medic", 0, 225, 225},
[3] = {-2641.51, 636.4, 14.45, "Medic", 0, 225, 225},
--[4] = {-323.25, 1055.37, 19.74, "Medic", 0, 225, 225},
--[5] = {-1510.04, 2520.85, 55.87, "Medic", 0, 225, 225},
[6] = {-2204.52, -2312.74, 30.61, "Medic", 0, 225, 225},
[7] = {1600.54, 1818.96, 10.82, "Medic", 0, 225, 225},
[8] = {2036.27, -1404.07, 17.26, "Medic", 0, 225, 225},
[9] = {-2204.52, -2312.74, 30.61, "Medic", 0, 225, 225},
[10] = {1404.45, -1300.74, 13.54, "Criminal Special Skills", 176, 23, 31},
[11] = {1756.19, 775.67, 10.82, "Criminal Special Skills", 176, 23, 31},
[12] = {-2160.73, 649.15, 52.36, "Criminal Special Skills", 176, 23, 31},
[13] = {2130.87, 2378.6, 10.82, "Criminal Special Skills", 176, 23, 31},
[14] = {2531.62, -1666.45, 15.16, "Criminal", 176, 23, 31},
[15] = {1407.56, -1300.06, 13.55, "Criminal", 176, 23, 31},
[16] = {-2159.34, 654.18, 52.36, "Criminal", 176, 23, 31},
[17] = {1753.87, 777.93, 10.82, "Criminal", 176, 23, 31},
[18] = {2127.69, 2377.1, 10.82, "Criminal", 176, 23, 31},
[19] = {2348.09, 2455.07, 14.97, "Police Officer", 67, 156, 252},
[20] = {-215.8, 973.69, 19.32, "Police Officer", 67, 156, 252},
[21] = {-1395.03, 2646.44, 55.85, "Police Officer", 67, 156, 252},
[22] = {-2161.64, -2385.5, 30.62, "Police Officer", 67, 156, 252},
[23] = {1575.39, -1634.34, 13.55, "Police Officer", 67, 156, 252},
[24] = {630.84, -569.06, 16.33, "Police Officer", 67, 156, 252},
[25] = {-1622.52, 686.91, 7.18, "Police Officer", 67, 156, 252},
[26] = {1601.24, -1634.94, 13.71, "Traffic Officer", 67, 156, 252},
[27] = {619.01, -584.65, 17.22, "Traffic Officer", 67, 156, 252},
[28] = {-1619.49, 692.34, 7.18, "Traffic Officer", 67, 156, 252},
[29] = {-226.3, 985.22, 19.59, "Traffic Officer", 67, 156, 252},
[30] = {-2425.43, 2320.3, 5, "Fisherman", 225, 225, 0},
[31] = {1623.75, 605.32, 7.78, "Fisherman", 225, 225, 0},
[32] = {979.92, -2086.91, 4.8, "Fisherman", 225, 225, 0},
[33] = {-1542.99, -437.79, 6, "Pilot", 225, 225, 0},
[34] = {1895.26, -2246.88, 13.54, "Pilot", 225, 225, 0},
[35] = {1712.99, 1615.86, 10.15, "Pilot", 225, 225, 0},
--[36] = {2425.92, -1222.26, 25.39, "Hooker", 225, 225, 0},
--[37] = {-2628.85, 1403.44, 7.09, "Hooker", 225, 225, 0},
--[38] = {788.28, -1550.94, 13.56, "Hooker", 225, 225, 0},
--[39] = {2104.58, 2198.14, 10.82, "Hooker", 225, 225, 0}
}

function showTextOnTopOfPed()
    local x, y, z = getElementPosition(localPlayer)
	for ID in ipairs(dxlabel) do
		local mX, mY, mZ = dxlabel[ID][1], dxlabel[ID][2], dxlabel[ID][3]
		local jobb = dxlabel[ID][4]
		local r, g, b = dxlabel[ID][5], dxlabel[ID][6], dxlabel[ID][7]
			local sx, sy = getScreenFromWorldPosition(mX, mY, mZ+1)
			if (sx) and (sy) then
		    	local distance = getDistanceBetweenPoints3D(x, y, z, mX, mY, mZ)
				if (distance < 30) then
					dxDrawText(jobb, sx+2, sy+2, sx, sy, tocolor(r, g, b, 255), 1-(distance/20), "pricedown", "center", "center")
				end
			end
	end
end




local job = {
	{1013.06, -1028.97, 32.1, "Mechanic", 225, 225, 0},
	{2070.31, -1865.53, 13.54, "Mechanic", 225, 225, 0},
	--{708.79, -474.49, 16.33, "Mechanic", 225, 225, 0},
	{-1895.93, 276.32, 41.04, "Mechanic", 225, 225, 0},
	--{-89.71, 1115.7, 19.74, "Mechanic", 225, 225, 0},
	{1966.14, 2143.93, 10.82, "Mechanic", 225, 225, 0},
	{2197.26, 552.37, 12.16 , "The Smurfs", 176, 23, 31},
	{7120.6, -1526.83, 43.12 , "Terror Squad", 176, 23, 31},
	{942.38, 1312.18, 31.06 , "The Yakuza Family", 176, 23, 31},
	{2942.85, -1906.86, 11.02, "SWAT", 61, 89, 251},
	{2942.8, -1910.93, 11.02, "SWAT Special Skills", 61, 89, 251},
	{125.06, 1933.92, 19.26, "Military Forces", 0, 100, 0},
	{1993.33, -196.81, 35.58, "FBI", 139, 137, 137},
	{1543.21, -1643.92, 5.89, "K-9 Unit Officer", 67, 156, 252},
	{2200.2, -1972.6, 13.55, "Trash Collector", 225, 225, 0},
	{46.56, -223.96, 1.59, "Trucker", 225, 225, 0},
	{2225.56, -2210.81, 13.54, "Trucker", 225, 225, 0},
	--{682.5, 1848.21, 5.53, "Trucker", 225, 225, 0},
	{-80.32, -1115.62, 1.08, "Trucker", 225, 225, 0},
	--{-2096.45, -2254.1, 30.62, "Trucker", 225, 225, 0},
	{-1734.64, -101.94, 3.55, "Trucker", 225, 225, 0},
	{-2271, 521.44, 35.01, "Bus driver", 225, 225, 0},
	{1110.47, -1806.08, 16.59, "Bus driver", 225, 225, 0},
	{2195.63, -1973.31, 13.55, "Street cleaners", 225, 225, 0},
	{-2089.74, 84.27, 35.31, "Street cleaners", 225, 225, 0},
	{1112.5, -1201.1, 18.23, "Firefighter", 225, 0, 0},
	{-2025.3, 66.96, 28.46, "Firefighter", 225, 0, 0},
	{-1967.75, 300.25, 35.17, "Car Shop", 255, 225, 0},
	{2131.87, -1149.45, 24.26, "Car Shop", 255, 225, 0},
	{-1656.56, 1211.2, 7.25, "Car Shop", 255, 225, 0},
	{566.73, -1289.55, 17.24, "Car Shop", 255, 225, 0},
	{2200.75, 1393.65, 10.82, "Car Shop", 255, 225, 0},
	{1671.19, 1814.52, 10.82, "Car Shop", 255, 225, 0},
	{-1479.2, -632.14, 14.14, "Plane Shop", 255, 225, 0},
	{2092, -2413.31, 13.54, "Plane Shop", 255, 225, 0},
	--{648.47, -1363.67, 13.6, "News Reporter", 225, 225, 0}
}

function showTextOnTopOfPed1()
    local x1, y1, z1 = getElementPosition(localPlayer)
	for ID in ipairs(job) do
		local mX1, mY1, mZ1 = job[ID][1], job[ID][2], job[ID][3]
		local jobb1 = job[ID][4]
		local r1, g1, b1 = job[ID][5], job[ID][6], job[ID][7]
			local sx1, sy1 = getScreenFromWorldPosition(mX1, mY1, mZ1+1)
			if (sx1) and (sy1) then
		    	local distance1 = getDistanceBetweenPoints3D(x1, y1, z1, mX1, mY1, mZ1)
				if (distance1 < 30) then
					dxDrawText(jobb1, sx1+2, sy1+2, sx1, sy1, tocolor(r1, g1, b1, 255), 1-(distance1/20), "pricedown", "center", "center")
				end
			end
	end
end

local job1 = {
[1] = {1305.22, 1623.07, 10.82, "Plane Shop", 255, 225, 0},
[2] = {-1959.32, -2480.71, 30.62, "Truck Shop", 255, 225, 0},
[3] = {591.72, 1638.54, 6.99, "Truck Shop", 255, 225, 0},
[4] = {2282.21, -2364.03, 13.54, "Truck Shop", 255, 225, 0},
[5] = {-2071.73, -92.88, 35.19 , "Bike Shop", 255, 225, 0},
[6] = {1947.58, 2068.79, 10.82 , "Bike Shop", 255, 225, 0},
[7] = {701.68, -519.25, 16.33 , "Bike Shop", 255, 225, 0},
[8] = {1841.66, -1856.41, 14.38 , "Bomb Shop", 255, 225, 0},
[9] = {2006.06, 2301.11, 11.82 , "Bomb Shop", 255, 225, 0},
[10] = {-2519.55, 1215.66, 38.42 , "Bomb Shop", 255, 225, 0},
[11] = {1181.84, -1331.14, 13.58 , "Medic Kits", 90, 0, 200},
[12] = {1591.72, 1817.91, 10.82 , "Medic Kits", 90, 0, 200},
[13] = {1259.95, 326.74, 19.75 , "Medic Kits", 90, 0, 200},
[14] = {-326.02, 1051.69, 20.34 , "Medic Kits", 90, 0, 200},
[15] = {-2675.23, 631.22, 14.45 , "Medic Kits", 90, 0, 200},
[16] = {-2193.21, -2306.54, 30.62  , "Medic Kits", 90, 0, 200},
[17] = {2039.98, -1425.51, 17.17 , "Medic Kits", 90, 0, 200},
--[18] = {1990.72, -196.58, 35.58, "FBI Special Skills", 139, 137, 137},
--[19] = {1987.7, -189.14, 35.58, "FBI Dog", 139, 137, 137},
--[20] = {8125.23, 1936.09, 19.27, "MF Special Skills", 0, 100, 0},
--[21] = {125.23, 1936.09, 19.27, "MF Special Skills", 0, 100, 0},
[22] = {1930.9294433594, -1776.9, 13.5, "Fuel Canisters",90,0,200},
[23] = {1006, -930.46, 42, "Fuel Canisters",90,0,200},
[24] = {661, -569, 15, "Fuel Canisters",90,0,200},
[25] = {1385.8944091797, 463, 20, "Fuel Canisters",90,0,200},
[26] = {2120.95, 898.49, 11, "Fuel Canisters",90,0,200},
[27] = {2188.77, 2469.1, 11.24, "Fuel Canisters",90,0,200},
[28] = {60.339897155762, 1214, 19, "Fuel Canisters",90,0,200},
[29] = {-1458.1853027344, 1872.67, 32.5, "Fuel Canisters",90,0,200},
[30] = {-2419.2963867188, 970, 45, "Fuel Canisters",90,0,200},
[31] = {-1694, 413, 7, "Fuel Canisters",90,0,200},
[32] = {2068.611328125, -1883.1304931641, 13.5, "Wheels Tires",255,100,0},
[33] = {1016, -1029.5, 31.9, "Wheels Tires",255,100,0},
[34] = {1964, 2150.8, 8.8, "Wheels Tires",255,100,0},
[35] = {-1910.4847412109, 286.6, 41, "Wheels Tires",255,100,0},
[36] = {7120.6, -1526.83, 43.12, "The Terrorists", 176, 23, 31},
[37] = {1569.57, -1633.44, 13.5, "Police Skills", 67, 156, 252},
--[38] = {7120.6, -1526.83, 43.12 , "Drug Detective", 67, 156, 252},
[39] = {1536.3, -1634.42, 13.54, "Police Officer", 67, 156, 252},
[40] = {147.11, -1941.75, 3.77, "Rescuer Man", 225, 225, 0}
}

function showTextOnTopOfPed11()
    local xx, yy, zz = getElementPosition(localPlayer)
	for ID in ipairs(job1) do
		local mXX, mYY, mZZ = job1[ID][1], job1[ID][2], job1[ID][3]
		local jobbb = job1[ID][4]
		local rr, gg, bb = job1[ID][5], job1[ID][6], job1[ID][7]
			local sxx, syy = getScreenFromWorldPosition(mXX, mYY, mZZ+1)
			if (sxx) and (syy) then
		    	local distancee = getDistanceBetweenPoints3D(xx, yy, zz, mXX, mYY, mZZ)
				if (distancee < 30) then
					dxDrawText(jobbb, sxx+2, syy+2, sxx, syy, tocolor(rr, gg, bb, 255), 1-(distancee/20), "pricedown", "center", "center")
				end
			end
	end
end
addEventHandler("onClientRender", getRootElement(), showTextOnTopOfPed11)
addEventHandler("onClientRender", getRootElement(), showTextOnTopOfPed1)
addEventHandler("onClientRender", getRootElement(), showTextOnTopOfPed)

local draw = true
addCommandHandler("jobdx", function(cmd,state)
if (state == "on") and (draw == false) then
	addEventHandler("onClientRender", getRootElement(), showTextOnTopOfPed11)
	addEventHandler("onClientRender", getRootElement(), showTextOnTopOfPed1)
	addEventHandler("onClientRender", getRootElement(), showTextOnTopOfPed)
	draw = true
elseif (state == "off") and (draw == true) then
	removeEventHandler("onClientRender", getRootElement(), showTextOnTopOfPed11)
	removeEventHandler("onClientRender", getRootElement(), showTextOnTopOfPed1)
	removeEventHandler("onClientRender", getRootElement(), showTextOnTopOfPed)
	draw = false
end
end)

function add(x,y,z,text,r,g,b)
	table.insert(dxlabel,{x,y,z,tostring(text),r,g,b})
end
