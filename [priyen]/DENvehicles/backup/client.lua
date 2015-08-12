-- Anti compiller
local CSGSecurity = {{{{{ {}, {}, {} }}}}}

-- The Vehicle Spawn Gui
vehiclesWindow = guiCreateWindow(395,237,241,413,"CSG ~ Vehicles",false)
vehiclesGrid = guiCreateGridList(9,26,221,307,false,vehiclesWindow)
guiGridListSetSelectionMode(vehiclesGrid,0)
spawnVehicleButton = guiCreateButton(9,337,220,30,"Spawn Vehicle",false,vehiclesWindow)
closeWindowButton = guiCreateButton(9,373,220,30,"Close Window",false,vehiclesWindow)
guiGridListSetSortingEnabled ( vehiclesGrid, false )

vehicleName = guiGridListAddColumn( vehiclesGrid, " Vehiclename:", 0.80 )

addEventHandler("onClientGUIClick", closeWindowButton, function() guiSetVisible(vehiclesWindow, false) showCursor(false,false) guiGridListClear ( vehiclesGrid ) end, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(vehiclesWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(vehiclesWindow,x,y,false)

guiWindowSetMovable (vehiclesWindow, true)
guiWindowSetSizable (vehiclesWindow, false)
guiSetVisible (vehiclesWindow, false)

local pilotJobVehicles = {
[511] = {"Beagle", 6, 1, 1, 1},
[593] = {"Dodo", 6, 1, 1, 1},
[417] = {"Leviathan", 6, 1, 1, 1},
[519] = {"Shamal", 6, 1, 1, 1},
[553] = {"Nevada", 6, 1, 1, 1},
[487] = {"Maverick", 6, 1, 1, 1},
[513] = {"Stuntplane", 6, 1, 1, 1}
}

local criminalJobVehicles = {
[468] = {"Sanchez", 0, 0, 1, 1},
[466] = {"Glendale", 0, 0, 1, 1}
}

local dodJobVehicles = {
[596] = {"Police Car (LS)", 0, 1, 1, 1},
[597] = {"Police Car (SF)", 0, 1, 1, 1},
[598] = {"Police Car (LV)", 0, 1, 1, 1},
[523] = {"HPV1000", 0, 1, 1, 1},
[497] = {"Police Maverick", 0, 1, 1, 1},
[426] = {"Premier", 23, 1, 1, 1}
}

local fbiJobVehicles = {
[490] = {"FBI Rancher",131,131,131,131},
[528] = {"FBI Truck",131,131,131,131},
[427] = {"Enforcer",131,131,131,131},
[596] = {"Police Car (LS)",131,131,131,131},
[597] = {"Police Car (SF)",131,131,131,131},
[598] = {"Police Car (LV)",131,131,131,131},
[599] = {"Police Ranger",131,131,131,131},
[415] = {"Cheetah", 131,131,131,131},
[551] = {"Merit",131,131,131,131},
[579] = {"Huntley",131,131,131,131},
[426] = {"Premier",131,131,131,131},
[523] = {"HPV1000",131,131,131,131},
[497] = {"Police Maverick",131,131,131,131},
}

local fbiAir = {
[497] = {"Police Maverick", 53, 1, 1, 1},
}

local swatJobVehicles = {
[596] = {"Police Car (LS)", 53, 1, 1, 1},
[597] = {"Police Car (SF)", 53, 1, 1, 1},
[598] = {"Police Car (LV)", 53, 1, 1, 1},
[599] = {"Police Ranger", 53, 1, 1, 1},
[523] = {"HPV1000", 53, 1, 1, 1},
[601] = {"S.W.A.T", 53, 1, 1, 1},
[427] = {"Enforcer", 53, 1, 1, 1},
[415] = {"Cheetah", 53, 1, 1, 1},
[426] = {"Premier", 53, 1, 1, 1},
[428] = {"Securicar", 53, 1, 1, 1},
[468] = {"Sanchez", 53, 1, 1, 1},
[497] = {"Police Maverick", 53, 1, 1, 1},
[490] = {"FBI Rancher", 53, 1, 1, 1},
}


local medicJobVehicles = {
[416] = {"Ambulance", 1, 3, 0, 0}
}

local freeVehicles = {
[481] = {"BMX", 1, 1, 0, 0},
[510] = {"Mountain Bike", 1, 1, 0, 0},
[509] = {"Bike", 1, 1, 0, 0},
[462] = {"Faggio", 1, 1, 0, 0}
}

local mechanicJobVehicles = {
[554] = {"Yosemite", 0, 6, 0, 0},
[525] = {"Towtruck", 0, 6, 0, 0},
[422] = {"Bobcat", 0, 6, 0, 0},
[589] = {"Club", 6, 6, 0, 0}
}

local policeJobVehicles = {
[596] = {"Police Car (LS)", 106, 1, 1, 1},
[597] = {"Police Car (SF)", 106, 1, 1, 1},
[598] = {"Police Car (LV)", 106, 1, 1, 1},
[599] = {"Police Ranger", 106, 1, 1, 1}
}

local fireFighterVehicles = {
[407] = {"Fire Truck",3,1,1,1},
[544] = {"Fire Truck (Ladder)",3,1,1,1}
}

local policeTrafficJobVehicles = {
[523] = {"HPV1000", 106, 1, 1, 1},
[415] = {"Cheetah", 106, 1, 1, 1},
[426] = {"Premier", 106, 1, 1, 1},
[596] = {"Police Car (LS)", 106, 1, 1, 1},
[597] = {"Police Car (SF)", 106, 1, 1, 1},
[598] = {"Police Car (LV)", 106, 1, 1, 1},
[599] = {"Police Ranger", 106, 1, 1, 1}
}

local policeDogJobVehicles = {
[523] = {"HPV1000", 106, 1, 1, 1},
[415] = {"Cheetah", 106, 1, 1, 1},
[426] = {"Premier", 106, 1, 1, 1},
[596] = {"Police Car (LS)", 106, 1, 1, 1},
[597] = {"Police Car (SF)", 106, 1, 1, 1},
[598] = {"Police Car (LV)", 106, 1, 1, 1},
[599] = {"Police Ranger", 106, 1, 1, 1}
}

local militaryVehicles = {
[520] = {"Hydra", 1, 1, 1, 1},
[432] = {"Rhino", 1, 1, 1, 1},
[425] = {"Hunter", 1, 1, 1, 1},
[470] = {"Patriot", 1, 1, 1, 1},
[497] = {"Police Maverick", 44, 1 , 1, 1},
[468] = {"Sanchez", 44, 1 , 1, 1},
[433] = {"Barracks", 44, 1 , 1, 1},
[428] = {"Securicar", 44, 1 , 1, 1},
[476] = {"Rustler", 44, 1 , 1, 1},
[519] = {"Shamal", 44, 1 , 1, 1},
[426] = {"Premier", 44, 1 , 1, 1},
[548] = {"Cargobob", 1, 1, 1, 1},
[447] = {"Seasparrow", 1, 1, 1, 1},
[596] = {"Police Car (LS)", 44, 1, 1, 1},
[597] = {"Police Car (SF)", 44, 1, 1, 1},
[598] = {"Police Car (LV)", 44, 1, 1, 1},
[599] = {"Police Ranger", 44, 1, 1, 1},
[500] = {"Mesa", 44, 1, 1, 1},
[579] = {"Huntley", 44, 1, 1, 1}
}

local truckerJobVehicles = {
[403] = {"Linerunner", 0, 6, 0, 0},
[514] = {"Tanker", 0, 6, 0, 0},
[515] = {"Roadtrain", 0, 6, 0, 0},
}

local busJobVehicles = {
[431] = {"Bus", 0, 6, 0, 0},
[437] = {"Coach", 0, 6, 0, 0},
}

local streetcleanVehicles = {
[574] = {"Sweeper", 0, 6, 0, 0},
}

local electricanVehicles = {
[552] = {"Utility Van", 0, 6, 0, 0},
}

local crimBaseVehicles = {
[500] = {"Mesa", 0, 0, 0, 0},
[468] = {"Sanchez", 0, 0, 0, 0},
[426] = {"Premier", 0, 0, 0, 0},
[415] = {"Cheetah", 0, 0, 0, 0},
[457] = {"Caddy", 0, 0, 0, 0},
}

local dVehicles = {
	[463] = {"Freeway", 0, 0, 0, 0},
	[541] = {"Bullet", 0, 0, 0, 0},
	[429] = {"Banshee", 0, 0, 0, 0},
}

local FishermanVehs = {
    [453] = {"Reefer",1,1,1,1},
    [484] = {"Marquis",1,1,1,1},
}

local vehicleMarkers = {
-- SWAT
{1246.35, -1670.37, 13.45, 39, 64, 225, swatJobVehicles, "SWAT", "SWAT Team", 357.57473754883, "noOccupation" },
{1221.16, -1656.29, 13.45, 39, 64, 225, swatJobVehicles, "SWAT", "SWAT Team", 306.5973815918, "noOccupation" },
{1222.29, -1643.87, 13.45, 39, 64, 225, swatJobVehicles, "SWAT", "SWAT Team", 174.99566650391, "noOccupation" },
{1259.8, -1665.44, 34.8, 39, 64, 225, swatJobVehicles, "SWAT", "SWAT Team", 87.598083496094, "noOccupation" },
{1239.66, -1665.55, 34.8, 39, 64, 225, swatJobVehicles, "SWAT", "SWAT Team", 261.49783325195, "noOccupation" },
{1280.89, -1697.33, 39.43, 39, 64, 225, swatJobVehicles, "SWAT", "SWAT Team", 84.15380859375, "noOccupation" },
-- MILITARY
{228.5, 1914.88, 17.64, 107,142, 35,  militaryVehicles, "Military Forces", "Military Forces", 89.65255737304, "noOccupation"  },
{229.71, 1904.33, 17.64, 107,142, 35, militaryVehicles, "Military Forces", "Military Forces", 91.53674316406, "noOccupation"  },
{199.36, 1877.32, 17.64, 107,142, 35, militaryVehicles, "Military Forces", "Military Forces", 358.4975891113, "noOccupation"  },
{274, 1955.63, 17.64, 107,142, 35,    militaryVehicles, "Military Forces", "Military Forces", 269.8255920410, "noOccupation"  },
{275.73, 2023.4, 17.64, 107,142, 35,  militaryVehicles, "Military Forces", "Military Forces", 271.3582153320, "noOccupation"  },
{338.26, 1979.11, 17.64, 107,142, 35, militaryVehicles, "Military Forces", "Military Forces", 89.10324096679, "noOccupation"  },
{361.33, 1916.76, 17.64, 107,142, 35, militaryVehicles, "Military Forces", "Military Forces", 89.41635131835, "noOccupation"  },
-- PARAMEDIC
{1182.08, -1308.27, 13.62, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 264.96408081055 },
{1182.19, -1338.87, 13.66, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 264.96408081055 },
{2001.75, -1415.46, 16.99, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 179.39025878906 },
{2034.02, -1445.4, 17.29, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 92.2783203125 },
{-2654.01, 624.47, 14.45, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 92.25634765625 },
{-2654.01, 588.75, 14.45, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 91.02587890625 },
{1615.95, 1851.26, 10.82, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 180.42846679688 },
{1594.74, 1851.26, 10.82, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 180.42846679688 },
{-304.92, 1032.07, 19.59, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 265.06292724609 },
{-304.92, 1015.68, 19.59, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 273.52255249023 },
{-1525.43, 2526.3, 55.75, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 1.7441101074219 },
{-2187.04, -2307.81, 30.62, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 313.14535522461 },
-- MECHANIC
{2061.17, -1877.93, 13.54, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 273.35775756836 },
{1036.44, -1029.38, 32.1, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 181.33486938477 },
{-1917.28, 283.7, 41.04, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 177.07757568359 },
{708.32, -461.6, 16.33, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 91.492797851562 },
{1958.26, 2170.14, 10.82, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 180.52734375 },
{-81.78, 1133.29, 19.74, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 184.21881103516 },
-- TRUCKER
{2198.68, -2235.25, 13.54, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 223.52848815918 },
{2213.99, -2221.01, 13.54, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 227.86267089844 },
{685.21, 1832.83, 5.24, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 358.33828735352 },
{672.15, 1833.6, 5.17, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 358.40420532227 },
{-1730, -127.85, 3.55, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 135.39483642578 },
{-1734.75, -58.51, 3.54, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 134.98834228516 },
{-2098.97, -2239.55, 30.62, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 142.87112426758 },
{-2105.06, -2235.67, 30.62, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 141.88784790039 },
{-43.45, -1143.88, 1.07, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 76.847778320312 },
{-68.8, -1120.3, 1.07, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 68.574951171875 },
{52.15, -278.15, 1.69, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 353.00436401367 },
{65.92, -278.49, 1.57, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 353.00436401367 },
-- POLICE
{1555.94, -1608.88, 13.38, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 181.35133361816, "Military Forces", "SWAT", "Government Agency" },
{1573.28, -1609.78, 13.38, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 180.41200256348, "Military Forces", "SWAT", "Government Agency" },
{1588.5, -1610.93, 13.38, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 190.43716430664, "Military Forces", "SWAT", "Government Agency" },
{1603.77, -1610.78, 13.5, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 173.8310546875, "Military Forces", "SWAT", "Government Agency" },
{1602.28, -1623.92, 13.49, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 83.906616210938, "Military Forces", "SWAT", "Government Agency" },
{-1587.94, 650.68, 7.18, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 0.18402099609375, "Military Forces", "SWAT", "Government Agency" },
{-1599.62, 650.68, 7.18, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 1.4364929199219, "Military Forces", "SWAT", "Government Agency" },
{-1610.81, 650.68, 7.18, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 1.1233825683594, "Military Forces", "SWAT", "Government Agency" },
{-1622.64, 650.68, 7.18, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 2.3758239746094, "Military Forces", "SWAT", "Government Agency" },
{-1634.44, 650.68, 7.18, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 2.3758239746094, "Military Forces", "SWAT", "Government Agency" },
{2256.18, 2460.13, 10.82, 100, 139, policeJobVehicles, "Police", "Police Officer", 180.19775390625, "Military Forces", "SWAT", "Government Agency" },
{2278.06, 2443.51, 10.82, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 0.70037841796875, "Military Forces", "SWAT", "Government Agency" },
{-224.38, 995.57, 19.57, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 260.17395019531, "Military Forces", "SWAT", "Government Agency" },
{622.25, -588.91, 17.19, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 271.21539306641, "Military Forces", "SWAT", "Government Agency" },
{-2171.07, -2359.86, 30.62, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 44.437622070312, "Military Forces", "SWAT", "Government Agency" },
{-1400.57, 2637.79, 55.68, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 86.208282470703, "Military Forces", "SWAT", "Government Agency" },
-- TRAFFIC cop
{1555.94, -1608.88, 13.38, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 181.35133361816, "noOccupation" },
{1573.28, -1609.78, 13.38, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 180.41200256348, "noOccupation" },
{1588.5, -1610.93, 13.38, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 190.43716430664, "noOccupation" },
{1603.77, -1610.78, 13.5, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 173.8310546875, "noOccupation" },
{1602.28, -1623.92, 13.49, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 83.906616210938, "noOccupation" },
{-1587.94, 650.68, 7.18, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 0.18402099609375, "noOccupation" },
{-1599.62, 650.68, 7.18, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 1.4364929199219, "noOccupation" },
{-1610.81, 650.68, 7.18, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 1.1233825683594, "noOccupation" },
{-1622.64, 650.68, 7.18, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 2.3758239746094, "noOccupation" },
{-1634.44, 650.68, 7.18, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 2.3758239746094, "noOccupation" },
{2256.18, 2460.13, 10.82, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 180.19775390625, "noOccupation" },
{2278.06, 2443.51, 10.82, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 0.70037841796875, "noOccupation" },
{-224.38, 995.57, 19.57, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 260.17395019531, "noOccupation" },
{622.25, -588.91, 17.19, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 271.21539306641, "noOccupation" },
{-2171.07, -2359.86, 30.62, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 44.437622070312, "noOccupation" },
{-1400.57, 2637.79, 55.68, 54, 100, 139, policeTrafficJobVehicles, "Police", "Traffic Officer", 86.208282470703, "noOccupation" },
-- K9 cop vehicles
{1555.94, -1608.88, 13.38, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 181.35133361816, "noOccupation" },
{1573.28, -1609.78, 13.38, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 180.41200256348, "noOccupation" },
{1588.5, -1610.93, 13.38, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 190.43716430664, "noOccupation" },
{1603.77, -1610.78, 13.5, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 173.8310546875, "noOccupation" },
{1602.28, -1623.92, 13.49, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 83.906616210938, "noOccupation" },
{-1587.94, 650.68, 7.18, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 0.18402099609375, "noOccupation" },
{-1599.62, 650.68, 7.18, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 1.4364929199219, "noOccupation" },
{-1610.81, 650.68, 7.18, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 1.1233825683594, "noOccupation" },
{-1622.64, 650.68, 7.18, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 2.3758239746094, "noOccupation" },
{-1634.44, 650.68, 7.18, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 2.3758239746094, "noOccupation" },
{2256.18, 2460.13, 10.82, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 180.19775390625, "noOccupation" },
{2278.06, 2443.51, 10.82, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 0.70037841796875, "noOccupation" },
{-224.38, 995.57, 19.57, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 260.17395019531, "noOccupation" },
{622.25, -588.91, 17.19, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 271.21539306641, "noOccupation" },
{-2171.07, -2359.86, 30.62, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 44.437622070312, "noOccupation" },
{-1400.57, 2637.79, 55.68, 54, 100, 139, policeDogJobVehicles, "Police", "K-9 Unit Officer", 86.208282470703, "noOccupation" },
-- Government Agency
{933.2, -1049.26, 32.05, 139, 137, 137, dodJobVehicles, "Government Agency", "Special Agent", 359.29412841797, "noOccupation" },
{938.42, -1048.77, 32.05, 139, 137, 137, dodJobVehicles, "Government Agency", "Special Agent", 359.29412841797, "noOccupation" },
{903.7, -1020.88, 107.57, 139, 137, 137, dodJobVehicles, "Government Agency", "Special Agent", 359.29412841797, "noOccupation" },
-- Pilot
{1823.96, -2622.38, 13.54, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 355.45434570312 },
{1889.96, -2624.38, 13.54, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 355.45434570312 },
{1986.93, -2382, 13.54, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 86.367584228516 },
{1986.93, -2315.86, 13.54, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 86.367584228516 },
{-1211.6, -149.53, 14.14, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 132.54382324219 },
{-1250.48, -103.51, 14.14, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 137.07574462891 },
{-1339.34, -541.2, 14.14, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 213.01441955566 },
{-1413.88, -580.55, 14.14, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 200.02288818359 },
{1610.52, 1620.44, 10.82, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 3.9853515625 },
{1370.24, 1713.69, 10.82, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 257.50424194336 },
{1369.1, 1755.95, 10.82, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 260.75073242188 },
-- Criminal vehicles
{1753.16, 759.13, 10.82, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 85.741363525391 },
{1421.87, -1307.55, 13.55, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 358.85464477539 },
{2134.84, 2355.31, 10.67, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 91.72900390625 },
{2517.35, -1672.48, 14.04, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 56.072326660156 },
{-2154.13, 649.83, 52.36, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 264.90365600586 },
-- Free vehicles
{1539.47, -1658.61, 13.54, 225, 225, 225, freeVehicles, nil, nil, 89.119689941406},
{2006.59, -1448.51, 13.56, 225, 225, 225, freeVehicles, nil, nil, 83.967041015625},
{1182.56, -1315.32, 13.57, 225, 225, 225, freeVehicles, nil, nil, 262.39321899414},
{634.12, -580.55, 16.33, 225, 225, 225, freeVehicles, nil, nil, 272.56671142578},
{-215.45, 986, 19.4, 225, 225, 225, freeVehicles, nil, nil, 267.08993530273},
{-328.43, 1066.65, 19.74, 225, 225, 225, freeVehicles, nil, nil, 267.42504882812},
{1624.97, 1824.85, 10.82, 225, 225, 225, freeVehicles, nil, nil, 358.63491821289},
{2298.42, 2427.28, 10.82, 225, 225, 225, freeVehicles, nil, nil, 178.20922851562},
{1236.87, 340.18, 19.55, 225, 225, 225, freeVehicles, nil, nil, 332.15197753906},
{-2656.38, 632.33, 14.45, 225, 225, 225, freeVehicles, nil, nil, 178.54431152344},
{-1619.24, 721.17, 14.4, 225, 225, 225, freeVehicles, nil, nil, 353.97665405273},
{-1499.27, 2539.65, 55.84, 225, 225, 225, freeVehicles, nil, nil, 357.30557250977},
{-2194.67, -2306.59, 30.62, 225, 225, 225, freeVehicles, nil, nil, 316.35888671875},
{1682.78, -2263.81, 13.5, 225, 225, 225, freeVehicles, nil, nil, 0.81573486328125},
-- Fire fighter
{1104.01, -1206.79, 17.8, 255, 0, 0, fireFighterVehicles, "Firefighters", "Firefighter", 180},
{1095.53, -1206.79, 17.8, 255, 0, 0, fireFighterVehicles, "Firefighters", "Firefighter", 180},
{1086.96, -1206.79, 17.8, 255, 0, 0, fireFighterVehicles, "Firefighters", "Firefighter", 180},
{-2021.38, 75.04, 28.1, 255, 0, 0, fireFighterVehicles, "Firefighters", "Firefighter", 275},
{-2021.38, 83.94, 28.1, 255, 0, 0, fireFighterVehicles, "Firefighters", "Firefighter", 275},
{-2021.38, 92.93, 28.1, 255, 0, 0, fireFighterVehicles, "Firefighters", "Firefighter", 275},
-- Bus vehicles
{ -2271, 526.69, 35.01, 255, 255, 0, busJobVehicles, "Civilian Workers", "Bus Driver", 270},
{ -2271, 540.83, 35.01, 255, 255, 0, busJobVehicles, "Civilian Workers", "Bus Driver", 270},
{ 1064.23, -1769.7, 13.36, 255, 255, 0, busJobVehicles, "Civilian Workers", "Bus Driver", 270},
{ 1064.23, -1740.19, 13.47, 255, 255, 0, busJobVehicles, "Civilian Workers", "Bus Driver", 270},
{ 1096.72, -1772.59, 13.34, 255, 255, 0, busJobVehicles, "Civilian Workers", "Bus Driver", 90},
-- Street cleaner
{ 2191.42, -1970.7, 13.55, 225, 225, 0, streetcleanVehicles, "Civilian Workers", "Street Cleaner", 183.33988952637},
{ -2095.27, 84.92, 35.31, 225, 225, 0, streetcleanVehicles, "Civilian Workers", "Street Cleaner", 359.70062255859},
-- Electrican
{ -2092.1564941406, 95.542877197266, 35.3203125, 225, 225, 0, electricanVehicles, "Civilian Workers", "Electrician", 90 },
{ 1620.2939453125, -1887.7960205078, 13.547839164734, 225, 225, 0, electricanVehicles, "Civilian Workers", "Electrician", 90 },
-- SM base
{ 2215.38, 584.78, 12.16, 0, 0, 0, crimBaseVehicles, "Criminals", "Criminal", 356.69580078125 , "aGroup", nil, nil, nil, "The Smurfs" },
-- TSF base
{ 855.9, 2174.07, 10.82, 0, 0, 0, crimBaseVehicles, "Criminals", "Criminal", 273.37423706055 , "aGroup", nil, nil, nil, "The Syndicate Family" },
-- Wolfensteins base
{ 987.81, 1465.35, 14.36, 0, 0, 156, crimBaseVehicles, "Criminals", "Criminal", 90 , "aGroup", nil, nil, nil, "Wolfensteins" },
-- LCN base
{ 1252.8, 744.5,13.2989, 68,68,68, crimBaseVehicles, "Criminals", "Criminal", 90 , "aGroup", nil, nil, nil, "La Cosa Nostra" },
-- Champions base
{ 2951.01, 1185.8, 40.81,68,68,68,crimBaseVehicles, "Criminals", "Criminal", 181 , "aGroup", nil, nil, nil, "The Champions" },
-- Fisherman
{ 939.47, -2062.04, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 85},
{ 939.47, -2102.69, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 90},
{ -2417.9, 2302.69, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 267},
{ 1624.54, 571.48, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 270},
--FBI
{996.22, -1435.25, 12.54,131,131,131,fbiJobVehicles,"Government Agency","Federal Agent",180},
{ 1028.8, -1451.31, 13.55,131,131,131,fbiJobVehicles,"Government Agency","Federal Agent",90},
{ 986.7, -1464.88, 28.57,131,131,131,fbiJobVehicles,"Government Agency","Federal Agent",94},
{ 1015.96, -1464.7, 28.59 ,131,131,131,fbiJobVehicles,"Government Agency","Federal Agent",94},

}

local JobsToTables = {
["SWAT Team"] = swatJobVehicles,
["SWAT"] = swatJobVehicles,
["Military Forces"] = militaryVehicles,
["Paramedic"] = medicJobVehicles,
["Police Officer"] = policeJobVehicles,
["Traffic Officer"] = policeTrafficJobVehicles,
["Mechanic"] = mechanicJobVehicles,
["Government Agency"] = fbiJobVehicles,
["Special Agent"] = dodJobVehicles,
["Pilot"] = pilotJobVehicles,
["Trucker"] = truckerJobVehicles,
["Criminal"] = criminalJobVehicles,
["Criminals"] = crimBaseVehicles,
["Firefighter"] = fireFighterVehicles,
["Bus Driver"] = busJobVehicles,
["Street Cleaner"] = streetcleanVehicles,
["Electrician"] = electricanVehicles,
["Fisherman"] = FishermanVehs,
["K-9 Unit Officer"] = policeDogJobVehicles,
}

local asdmarkers = {}

for i,v in pairs(vehicleMarkers) do
	if getPlayerTeam ( localPlayer ) then
		if getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer, "Occupation") == v[9] or
			getTeamName(getPlayerTeam ( localPlayer )) == v[8] and v[11] == "noOccupation" or
			getTeamName(getPlayerTeam ( localPlayer )) == v[11] or getTeamName(getPlayerTeam ( localPlayer )) == v[12] or v[8] == nil and v[9] == nil then

			elref = createMarker(v[1], v[2], v[3] -1, "cylinder", 2.2, v[4], v[5], v[6])
			asdmarkers [elref ] = v[7]
			setElementData(elref, "freeVehiclesSpawnRotation", v[10])
			setElementData(elref, "isMakerForFreeVehicles", true)

			if ( v[11] == "aGroup" ) then setElementData(elref, "groupMarkerName", v[15] ) end
		end
	end
end

local workingWith = {}

addEventHandler("onClientMarkerHit", root, function(hitElement, matchingDimension)
if getElementType ( hitElement ) == "player" and getElementData(source, "isMakerForFreeVehicles") == true and hitElement == localPlayer then
	guiGridListClear ( vehiclesGrid )
	if not isPedInVehicle(localPlayer) then
		if (asdmarkers [source] ) then
			for i,v in pairs( asdmarkers [source] ) do
				if hitElement == localPlayer then
					local px,py,pz = getElementPosition ( hitElement )
					local mx, my, mz = getElementPosition ( source )
						if ( pz-3 < mz ) and ( pz+3 > mz ) then
							if ( getElementData( source, "groupMarkerName" ) ) and ( getElementData( localPlayer, "Group" ) ) and not ( getElementData( source, "groupMarkerName" ) == getElementData( localPlayer, "Group" ) ) then
								exports.DENdxmsg:createNewDxMessage("You are not allowed to use this vehicle marker!", 225 ,0 ,0)
							else
								local row = guiGridListAddRow ( vehiclesGrid )
								workingWith[tostring(v[1])] = tonumber(i)
								guiGridListSetItemText ( vehiclesGrid, row, vehicleName, tostring(v[1]), false, false )
								guiGridListSetItemData ( vehiclesGrid, row, vehicleName, tostring(i) )
								guiSetVisible (vehiclesWindow, true)
								showCursor(true,true)

								theVehicleRoation = getElementData(source, "freeVehiclesSpawnRotation")
								theMarker = source
							end
						end
					end
				end
			end
		end
	end
end)

-- Reload the markers
function reloadFreeVehicleMarkers ()
	for i,v in pairs( asdmarkers ) do
		destroyElement(i)
	end

	asdmarkers = {}

	for i,v in pairs(vehicleMarkers) do
		if getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer, "Occupation") == v[9] or
			getTeamName(getPlayerTeam ( localPlayer )) == v[8] and v[11] == "noOccupation" or
			getTeamName(getPlayerTeam ( localPlayer )) == v[11] or getTeamName(getPlayerTeam ( localPlayer )) == v[12] or v[8] == nil and v[9] == nil then

			elref =  createMarker(v[1], v[2], v[3] -1, "cylinder", 2.2, v[4], v[5], v[6])
			asdmarkers [elref ] = v[7]
			setElementData(elref, "freeVehiclesSpawnRotation", v[10])
			setElementData(elref, "isMakerForFreeVehicles", true)

			if ( v[11] == "aGroup" ) then setElementData(elref, "groupMarkerName", v[15] ) end
		end
	end
end
addEvent("reloadFreeVehicleMarkers", true)
addEventHandler("reloadFreeVehicleMarkers", root, reloadFreeVehicleMarkers )

function spawnTheVehicle ()
local x,y,z = getElementPosition(theMarker)
local selectedVehicle = guiGridListGetItemText ( vehiclesGrid, guiGridListGetSelectedItem ( vehiclesGrid ), 1 )
	if selectedVehicle == "" or selectedVehicle == " " then
		exports.DENdxmsg:createNewDxMessage("You didnt select a vehicle!", 225 ,0 ,0)
	else
		local selectedRow, selectedColumn = guiGridListGetSelectedItem(vehiclesGrid)
		local theVehicleID = workingWith[tostring(selectedVehicle)]
		--local theVehicleID = tonumber(guiGridListGetItemData ( vehiclesGrid, selectedRow, selectedColumn ))
		if ( tonumber( theVehicleID) == 481 ) or ( tonumber( theVehicleID) == 510 ) or ( tonumber( theVehicleID) == 509 ) or ( tonumber( theVehicleID) == 462 ) or ( getElementData( localPlayer, "Occupation" ) == "Criminal" ) then
			if ( getElementData( localPlayer, "wantedPoints" ) >= 10 ) then
				exports.DENdxmsg:createNewDxMessage("You can't spawn free vehicles when wanted!", 225 ,0 ,0)
			else
				triggerServerEvent("spawnVehicle", localPlayer, x, y, z, theVehicleID, 0, 0, 0, 0, theVehicleRoation)
				guiSetVisible (vehiclesWindow, false)
				showCursor(false,false)
				guiGridListClear ( vehiclesGrid )
			end
		elseif doesPlayerHaveLiceForVehicle(tonumber(theVehicleID)) then
			local getTable = JobsToTables[getElementData(localPlayer, "Occupation")] or JobsToTables[getTeamName(getPlayerTeam ( localPlayer ))]
			local vehicle,color1,color2,color3,color4 = getTable[theVehicleID][1],getTable[theVehicleID][2],getTable[theVehicleID][3],getTable[theVehicleID][4],getTable[theVehicleID][5]--unpack( getTable[tonumber( theVehicleID )] )
			triggerServerEvent("spawnVehicle", localPlayer, x, y, z, theVehicleID, color1, color2, color3, color4, theVehicleRoation)
			guiSetVisible (vehiclesWindow, false)
			showCursor(false,false)
			guiGridListClear ( vehiclesGrid )
		else
			exports.DENdxmsg:createNewDxMessage("You don't have a licence for this type of vehicle!", 225 ,0 ,0)
		end
	end
end
addEventHandler("onClientGUIClick", spawnVehicleButton, spawnTheVehicle, false)

function doesPlayerHaveLiceForVehicle (vehicleID)
	if getVehicleType ( vehicleID ) == "Automobile" or getVehicleType ( vehicleID ) == "Monster Truck"
	or getVehicleType ( vehicleID ) == "Quad" or getVehicleType ( vehicleID ) == "Trailer" then
		if getElementData(localPlayer, "carLicence") then
			return true
		else
			return false
		end
	elseif getVehicleType ( vehicleID ) == "Plane" then
		if getElementData(localPlayer, "planeLicence") then
			return true
		else
			return false
		end
	elseif getVehicleType ( vehicleID ) == "Helicopter" then
		if getElementData(localPlayer, "chopperLicence") then
			return true
		else
			return false
		end
	elseif getVehicleType ( vehicleID ) == "Bike" or getVehicleType ( vehicleID ) == "BMX" then
		if getElementData(localPlayer, "bikeLicence") then
			return true
		else
			return false
		end
	elseif getVehicleType ( vehicleID ) == "Boat" then
		if getElementData(localPlayer, "boatLicence") then
			return true
		else
			return false
		end
	end
end
