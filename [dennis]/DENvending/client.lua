local vendingLocations = {
{-2420.22, 984.578, 44.2969},
{316.875, -140.352, 998.586},
{2225.2, -1153.42, 1025.91},
{2155.91, 1606.77, 1000.05},
{2576.7, -1284.43, 1061.09},
{2222.2, 1606.77, 1000.05},
{-19.0391, -57.8359, 1003.63},
{-16.1172, -91.6406, 1003.63},
{-32.4453, -186.695, 1003.63},
{-35.7266, -140.227, 1003.63},
{495.969, -24.3203, 1000.73},
{501.828, -1.42969, 1000.73},
{373.828, -178.141, 1000.73},
{330.68, 178.5, 1020.07},
{331.922, 178.5, 1020.07},
{350.906, 206.086, 1008.48},
{361.562, 158.617, 1008.48},
{371.594, 178.453, 1020.07},
{374.891, 188.977, 1008.48},
{2155.84, 1607.88, 1000.06},
{2202.45, 1617.01, 1000.06},
{2209.24, 1621.21, 1000.06},
{2222.37, 1602.64, 1000.06},
{-36.1484, -57.875, 1003.63},
{-17.5469, -91.7109, 1003.63},
{-16.5312, -140.297, 1003.63},
{-33.875, -186.766, 1003.63},
{500.562, -1.36719, 1000.73},
{379.039, -178.883, 1000.73},
{1634.11, -2237.53, 12.8906},
{2480.86, -1959.27, 12.9609},
{2139.52, -1161.48, 23.3594},
{2153.23, -1016.15, 62.2344},
{-1350.12, 493.859, 10.5859},
{-2229.19, 286.414, 34.7031},
{1659.46, 1722.86, 10.218},
{2647.7, 1129.66, 10.2188},
{1398.84, 2222.61, 10.4219},
{-1455.12, 2591.66, 55.2344},
{-76.0312, 1227.99, 19.125},
{-253.742, 2599.76, 62.2422},
{662.43, -552.164, 15.7109},
{1789.21, -1369.27, 15.1641},
{1729.79, -1943.05, 12.9453},
{2060.12, -1897.64, 12.9297},
{1928.73, -1772.45, 12.9453},
{2325.98, -1645.13, 14.2109},
{2352.18, -1357.16, 23.7734},
{1154.73, -1460.89, 15.1562},
{-1350.12, 492.289, 10.5859},
{-2118.97, -423.648, 34.7266},
{-2118.62, -422.414, 34.7266},
{-2097.27, -398.336, 34.7266},
{-2092.09, -490.055, 34.7266},
{-2063.27, -490.055, 34.7266},
{-2005.65, -490.055, 34.7266},
{-2034.46, -490.055, 34.7266},
{-2068.56, -398.336, 34.7266},
{-2039.85, -398.336, 34.7266},
{-2011.14, -398.336, 34.7266},
{-1980.79, 142.664, 27.0703},
{2319.99, 2532.85, 10.2188},
{-862.828, 1536.61, 21.9844},
{-14.7031, 1175.36, 18.9531},
{-253.742, 2597.95, 62.2422},
{1546.06, -1637.25, 12.6},
{201.016, -107.617, 0.898438}
}

local vendingMachineMarkers = {}

-- When the player hits the vending machine bind the H key
function onVendingMachineHit ( hitElement, matchingDimension )
	if ( hitElement == localPlayer ) and ( getElementType ( hitElement ) == "player" ) and ( matchingDimension ) then
		bindKey ( "H", "down", onBuyVendingMachineProduct )
		exports.DENdxmsg:createNewDxMessage( "Press H to buy a refreshing sprunk for 5$", 238, 154, 0 )
	end
end

-- When the user leaves the vending machine unbind the H key
function onVendingMachineLeave ( leaveElement, matchingDimension )
	if ( leaveElement == localPlayer ) and ( getElementType ( leaveElement ) == "player" ) and ( matchingDimension ) then
		unbindKey ( "H", "down", onBuyVendingMachineProduct )
	end
end

-- When the user pressed the H button to buy a product
function onBuyVendingMachineProduct ()
	local isElementNearVending = false
	for markerID, markerElement in ipairs ( vendingMachineMarkers ) do
		if ( isElementWithinColShape ( localPlayer, markerElement ) ) and not ( isElementNearVending ) then
			isElementNearVending = true
		end
	end
	
	if ( isElementNearVending ) then
		unbindKey ( "H", "down", onBuyVendingMachineProduct )
		triggerServerEvent ( "onServerBuyVendingProduct", localPlayer )
	end
end

-- Remake the bind after the player bought a product
addEvent ("onResetVendingMachineBind", true)
function onResetVendingMachineBind ()
	bindKey ( "H", "down", onBuyVendingMachineProduct )
end
addEventHandler ("onResetVendingMachineBind", root, onResetVendingMachineBind)

-- Create all the vending machines
for i=1,#vendingLocations do
	local x, y, z = vendingLocations[i][1], vendingLocations[i][2], vendingLocations[i][3]
	vendingMachineMarkers[i] = createColTube ( x, y, z, 1, 2 )
	addEventHandler ( "onClientColShapeHit", vendingMachineMarkers[i], onVendingMachineHit )
	addEventHandler ( "onClientColShapeLeave", vendingMachineMarkers[i], onVendingMachineLeave )
end