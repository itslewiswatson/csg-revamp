-- Anti compiller
local CSGSecurity = {{{{{ {}, {}, {} }}}}}

-- The Vehicle Spawn Gui
vehiclesWindow = guiCreateWindow(395,237,241,413,"CSG ~ Vehicles",false)
vehiclesGrid = guiCreateGridList(9,26,221,307,false,vehiclesWindow)
guiGridListSetSelectionMode(vehiclesGrid,0)
spawnVehicleSystemButton = guiCreateButton(9,337,220,30,"Spawn Vehicle",false,vehiclesWindow)
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
[513] = {"Stuntplane", 6, 1, 1, 1},
}

local allPilotJobVehicles = {
[511] = {"Beagle", 6, 1, 1, 1},
[593] = {"Dodo", 6, 1, 1, 1},
[417] = {"Leviathan", 6, 1, 1, 1},
[519] = {"Shamal", 6, 1, 1, 1},
[553] = {"Nevada", 6, 1, 1, 1},
[487] = {"Maverick", 6, 1, 1, 1},
[513] = {"Stuntplane", 6, 1, 1, 1},
[583] = {"Tug",6,1,1,1},
}

local pilotTug = {
[583] = {"Tug",6,1,1,1},
}

local criminalJobVehicles = {
[468] = {"Sanchez", 0, 0, 1, 1},
[466] = {"Glendale", 0, 0, 1, 1}
}

local copLV = {
[596] = {"Police Car (LS)", 0, 1, 1, 1},
[597] = {"Police Car (SF)", 0, 1, 1, 1},
[598] = {"Police Car (LV)", 0, 1, 1, 1},
[523] = {"HPV1000", 0, 1, 1, 1},
--[497] = {"Police Maverick", 0, 1, 1, 1},
[426] = {"Premier", 23, 1, 1, 1}
}


local fbiJobVehicles = {
[490] = {"FBI Rancher",131,131,131,131,r=0,g=0,b=0,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[528] = {"FBI Truck",131,131,131,13,r=0,g=0,b=0,r2=255,g2=255,b2=2551},
[427] = {"Enforcer",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[596] = {"Police Car (LS)",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[597] = {"Police Car (SF)",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[598] = {"Police Car (LV)",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[599] = {"Police Ranger",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[415] = {"Cheetah", 131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[551] = {"Merit",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[579] = {"Huntley",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[426] = {"Premier",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[523] = {"HPV1000",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[468] = {"Sanchez",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[451] = {"Turismo",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
}

local fbiAir = {
[497] = {"Police Maverick",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[519] = {"Shamal",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[447] = {"Seasparrow",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
}

local fbiSea = {
[472] = {"Coastguard",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[595] = {"Launch",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
[430] = {"Predator",131,131,131,131,r=0,g=0,b=0,r2=255,g2=255,b2=255},
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
[451] = {"Turismo",53,1,1,1},

[490] = {"FBI Rancher", 53, 1, 1, 1},

}

local swatAir = {
[447] = {"Seasparrow",53, 1 , 1, 1},
[519] = {"Shamal", 53, 1 , 1, 1},

}

local dodCars = {
[426] = {"Premier",0,0,0,0},
[596] = {"LSPD",0,0,0,0},
[597] = {"SFPD",0,0,0,0},
[598] = {"LVPD",0,0,0,0},
[599] = {"Police Ranger",0,0,0,0},
[490] = {"FBI Rancher",0,0,0,0},
[579] = {"Huntley",0,0,0,0},
[523] = {"HPV1000",0,0,0,0},
[468] = {"Sanchez",0,0,0,0},
[415] = {"Cheetah",0,0,0,0},
[551] = {"Merit",0,0,0,0},
[470] = {"Patriot",0,0,0,0},
[433] = {"Barracks",0,0,0,0},
[428] = {"Securicar",0,0,0,0},
[427] = {"Enforcer",0,0,0,0},
[528] = {"FBI Truck",0,0,0,0},
[407] = {"Fire Truck",0,0,0,0}
}

local swatHeli = {
[497] = {"Police Maverick", 53, 1, 1, 1},
[563] = {"Raindance",53,1,1,1},
}

local swatBoat = {
[472] = {"Coastguard",53, 1 , 1, 1 },
[595] = {"Launch",53, 1 , 1, 1},
[430] = {"Predator",53, 1 , 1, 1 },
[493] = {"Jetmax",53, 1 , 1, 1 },
}

local medicJobVehicles = {
[416] = {"Ambulance", 1, 3, 0, 0}
}

local freeVehicles = {
[481] = {"BMX", 1, 1, 0, 0},
[510] = {"Mountain Bike", 1, 1, 0, 0},
[509] = {"Bike", 1, 1, 0, 0},
--[559] = {"Jester", 1, 1, 0, 0},
[462] = {"Faggio", 1, 1, 0, 0}
}

local freeBoat = {
    [473] = {"Dinghy",1,1,0,0},
}

local mechanicJobVehicles = {
[554] = {"Yosemite", 0, 6, 0, 0},
[525] = {"Towtruck", 0, 6, 0, 0},
[422] = {"Bobcat", 0, 6, 0, 0},
[589] = {"Club", 6, 6, 0, 0}
}


local delieveryMan = {
[440] = {"Rumpo", 0, 6, 0, 0},
[413] = {"Delievery Van", 0, 6, 0, 0},

}
local policeJobVehicles = {
[596] = {"Police Car (LS)", 106, 1, 1, 1},
[597] = {"Police Car (SF)", 106, 1, 1, 1},
[598] = {"Police Car (LV)", 106, 1, 1, 1},
[599] = {"Police Ranger", 106, 1, 1, 1}
}

local ciaVehs = {
    [596] = {"Police Car (LS)", 106, 1, 1, 1},
    [597] = {"Police Car (SF)", 106, 1, 1, 1},
    [598] = {"Police Car (LV)", 106, 1, 1, 1},
    [599] = {"Police Ranger", 106, 1, 1, 1},
    [415] = {"Cheetah", 106, 1, 1, 1},
    [523] = {"HPV1000",106, 1, 1, 1},
    [426] = {"Premier", 106, 1, 1, 1},
}

local ciaAir = {
    [497] = {"Police Maverick",106, 1 , 1, 1},
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
[596] = {"Police Car (LS)", 44, 1, 1, 1},
[597] = {"Police Car (SF)", 44, 1, 1, 1},
[598] = {"Police Car (LV)", 44, 1, 1, 1},
[599] = {"Police Ranger", 44, 1, 1, 1},
[470] = {"Patriot", 1, 1, 1, 1},
[468] = {"Sanchez", 44, 1 , 1, 1},
[433] = {"Barracks", 44, 1 , 1, 1},
[428] = {"Securicar", 44, 1 , 1, 1},
[426] = {"Premier", 44, 1 , 1, 1},
[500] = {"Mesa", 44, 1, 1, 1},
[432] = {"Rhino", 1, 1, 1, 1},
[476] = {"Rustler", 44, 1 , 1, 1},
[579] = {"Huntley", 44, 1, 1, 1},
[519] = {"Shamal", 44, 1 , 1, 1},
[520] = {"Hydra", 1, 1, 1, 1},
[548] = {"Cargobob", 1, 1, 1, 1},
[563] = {"Raindance",53,1,1,1},
[497] = {"Police Maverick", 44, 1 , 1, 1},
[447] = {"Seasparrow", 1, 1, 1, 1},
[425] = {"Hunter", 1, 1, 1, 1}
}

local trashCollectorJobVehicles = {
[408] = {"Trash Collector",0,6,0,0},
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

local dtVehs = {
[500] = {"Mesa", 0, 0, 0, 0},
[468] = {"Sanchez", 0, 0, 0, 0},
[426] = {"Premier", 0, 0, 0, 0},
[415] = {"Cheetah", 0, 0, 0, 0},
[457] = {"Caddy", 0, 0, 0, 0},
[522] = {"NRG-500",0,0,0,0},
[411] = {"Infernus",0,0,0,0 },
[560] = {"Sultan",0,0,0,0 },
}

local dtAir = {
[487]={"Maverick",0,0,0,0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
}

local terrorists = {
[500] = {"Mesa", 0, 0, 0, 0},
[468] = {"Sanchez", 0, 0, 0, 0},
[426] = {"Premier", 0, 0, 0, 0},
[415] = {"Cheetah", 0, 0, 0, 0},
[457] = {"Caddy", 0, 0, 0, 0},
[541] = {"Bullet", 0, 0, 0,0},
[522] = {"NRG-500",0,0,0,0},
[411] = {"Infernus",0,0,0,0 },
[560] = {"Sultan",0,0,0,0 },
[579] = {"Huntley",0,0,0,0 },
[580] = {"Stafford",0,0,0,0 },
}

local terroristsAir = {
[487] = {"Maverick", 0,0,0,0},
}

local terroristsBoat = {
    [493]={"Jetmax",0,7,0,0},
}

local legBase = {
[500] = {"Mesa", 0, 0, 0, 0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
[468] = {"Sanchez", 0, 0, 0, 0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
[426] = {"Premier", 0, 0, 0, 0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
[415] = {"Cheetah", 0, 0, 0, 0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
[457] = {"Caddy", 0, 0, 0, 0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
[579] = {"Huntley",131,131,131,131,r=130,g=9,b=9,r2=0,g2=0,b2=0},
[541] = {"Bullet", 0, 0, 0, 0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
[580] = {"Stafford", 0, 0, 0, 0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
[424] = {"BF Injection", 0, 0, 0, 0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
[522] = {"NRG-500",0,0,0,0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
[411] = {"Infernus",0,0,0,0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
--[560] = {"Sultan",0,0,0,0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
}

local legAir = {
    [487]={"Maverick",0,0,0,0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
}

local legBoat = {
    [446]={"Squalo",0,0,0,0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
    [595]={"Launch",0,0,0,0,r=130,g=9,b=9,r2=0,g2=0,b2=0},
}


local drugdetective = {
    [475]={"Sabre",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=255},
}



local tlaVehs = {
[500] = {"Mesa", 0, 0, 0, 0},
[468] = {"Sanchez", 0, 0, 0, 0},
[426] = {"Premier", 0, 0, 0, 0},
[415] = {"Cheetah", 0, 0, 0, 0},
[457] = {"Caddy", 0, 0, 0, 0},
[522] = {"NRG-500",0,0,0,0},
}


local tlaAir = {
    [487]={"Maverick",0,0,0,0},
}

local wolfBase = {
[500] = {"Mesa", 0, 0, 0, 0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[468] = {"Sanchez", 0, 0, 0, 0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[426] = {"Premier", 0, 0, 0, 0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[415] = {"Cheetah", 0, 0, 0, 0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[457] = {"Caddy", 0, 0, 0, 0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[560] = {"Sultan",0,0,0,0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[411] = {"Infernus",0,0,0,0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[522] = {"NRG-500",0,0,0,0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[495] = {"Jeep / Sandking",0,0,0,0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[451] = {"Turismo",0,0,0,0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
}

local limoveh = {
 [409] = {"Stretch",131,131,131,131,r=255,g=255,b=255,r2=255,g2=255,b2=255},
  }

local rescveh = {
 [472] = {"Coastguard",131,131,131,131,r=255,g=255,b=255,r2=255,g2=255,b2=255},
 }

local LCNbase = {
[500] = {"Mesa", 0,22,0, 0,r=255,g=100,b=10},
[468] = {"Sanchez", 0,22,0, 0,r=255,g=100,b=10},
[426] = {"Premier", 0,22,0, 0,r=255,g=100,b=10},
[415] = {"Cheetah", 0,22,0, 0,r=255,g=100,b=10},
[457] = {"Caddy", 0,22,0, 0,r=255,g=100,b=10},
}

local LCNair = {
    [487]={"Maverick",0,0,0,0,r=255,g=100,b=10},
}

local invBase = {
[500] = {"Mesa", 0,22,0, 0},
[468] = {"Sanchez", 0,22,0, 0},
[426] = {"Premier", 0,22,0, 0},
[415] = {"Cheetah", 0,22,0, 0},
[457] = {"Caddy", 0,22,0, 0},
--[522] = {"NRG-500",0,22,0,0},
}

local invAir = {
    [487]={"Maverick",0,22,0,0},
}

local wolfAir = {
    [487]={"Maverick",0,0,0,0},
}

local coAir = {
    [487]={"Maverick",0,0,0,0,r=0,g=250,b=250,r2=0,g2=250,b2=250},
}

local coBase = {

[500] = {"Mesa", 0, 0, 0, 0,r=0,g=250,b=250,r2=0,g2=250,b2=250},
[468] = {"Sanchez", 0, 0, 0, 0,r=0,g=250,b=250,r2=0,g2=250,b2=250},
[426] = {"Premier", 0, 0, 0, 0,r=0,g=250,b=250,r2=0,g2=250,b2=250},
[415] = {"Cheetah", 0, 0, 0, 0,r=0,g=250,b=250,r2=0,g2=250,b2=250},
[457] = {"Caddy", 0, 0, 0, 0,r=0,g=250,b=250,r2=0,g2=250,b2=250},
[411] = {"Infernus",0,0,0,0,r=0,g=250,b=250,r2=0,g2=250,b2=250},


}

local cobBase = {

[500] = {"Mesa", 0, 0, 0, 0},
[468] = {"Sanchez", 0, 0, 0, 0},
[426] = {"Premier", 0, 0, 0, 0},
[415] = {"Cheetah", 0, 0, 0, 0},
[457] = {"Caddy", 0, 0, 0, 0},
[522] = {"NRG-500",0,0,0,0},
[560] = {"Sultan",0,0,0,0},
[482] = {"Burrito",0,0,0,0},
[541] = {"Bullet", 0, 0, 0, 0},

}

local cobAir = {
    [487]={"Maverick",0,0,0,0},
}

local exoBase = {


[415] = {"Cheetah", 0, 0, 0, 0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
[457] = {"Caddy", 0, 0, 0, 0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
[522] = {"NRG-500",0,0,0,0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
[560] = {"Sultan",0,7,0,0,r=255,g=10,b=10,r2=255,g2=10,b2=10 },
[468] = {"Sanchez", 0, 7, 0, 0,r=225,g=60,b=0,r2=255,g2=255,b2=255},
[411] = {"Infernus",0,0,0,0,r=255,g=10,b=10,r2=255,g2=10,b2=10},

}

local exoAir = {


[487]={"Maverick",0,0,0,0,r=255,g=10,b=10,r2=255,g2=10,b2=10},

}

local sparBase = {

[500] = {"Mesa", 0, 0, 0, 0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
[468] = {"Sanchez", 0, 0, 0, 0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
[426] = {"Premier", 0, 0, 0, 0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
[415] = {"Cheetah", 0, 0, 0, 0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
[457] = {"Caddy", 0, 0, 0, 0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
[522] = {"NRG-500",0,0,0,0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
[411] = {"Infernus",0,0,0,0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
}

local sparAir = {
    [487]={"Maverick",0,0,0,0,r=255,g=10,b=10,r2=255,g2=10,b2=10},
}

local smurfs = {
--[500] = {"Mesa", 0, 7, 0, 0,r=30,g=144,b=255 },
--[468] = {"Sanchez", 0, 7, 0, 0,r=30,g=144,b=255 },
[426] = {"Premier", 0, 7, 0, 0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
[415] = {"Cheetah", 0, 7, 0, 0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
--[457] = {"Caddy", 0, 7, 0, 0,r=30,g=144,b=255 },
[489] = {"Rancher", 0, 7, 0, 0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
[560] = {"Sultan",0,7,0,0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
[495] = {"Sandking",0,7,0,0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
[411] = {"Infernus",0,7,0,0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
[522] = {"NRG-500",0,7,0,0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
[541] = {"Bullet",0,7,0,0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
[451] = {"Turismo",0,7,0,0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
}

local smurfsAir = {
[487]={"Maverick",0,7,0,0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
}

local smurfsBoat = {
[493]={"Jetmax",0,7,0,0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
[539]={"Vortex",0,7,0,0,r=14,g=140,b=255,r2=0,g2=0,b2=0 },
}

local yakuzaCars = {
[451]={"Turismo",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[541]={"Bullet",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[415]={"Cheetah",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[411]={"Infernus",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[495]={"Sandking",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[555]={"Windsor",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[434]={"Hotknife",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[579]={"Huntley",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[482]={"Burrito",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[400]={"Landstalker",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[559]={"Jester",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[560]={"Sultan",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[522]={"NRG-500",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[468]={"Sanchez",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[409]={"Stretch (Limo)",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
}

local yakuzaAir = {
[519]={"Shamal",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[513]={"Stuntplane",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
}

local yakuzaHeli = {
[487]={"Maverick",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
[548]={"Cargobob",0,0,0,0,r=184,g=0,b=255,r2=255,g2=255,b2=255},
}

local tsfVehs = {
    [411]={"Infernus",0, 7, 0, 0,r=225,g=60,b=0,r2=255,g2=255,b2=255},
    [541] = {"Bullet", 0, 7, 0, 0,r=225,g=60,b=0,r2=255,g2=255,b2=255},
    [429] = {"Banshee", 0, 7, 0, 0,r=225,g=60,b=0,r2=255,g2=255,b2=255},
    [522] = {"NRG-500",0,7,0,0,r=225,g=60,b=0,r2=255,g2=255,b2=255 },
    [560]={"Sultan",0,7,0,0,r=225,g=60,b=0,r2=255,g2=255,b2=255 },
    [409]={"Stretch (Limo)",0,0,0,0,r=225,g=60,b=0,r2=255,g2=255,b2=255},
    [579]={"Huntley",0,7,0,0,r=225,g=60,b=0,r2=255,g2=255,b2=255 },

}

local tsfAir = {
    [487]={"Maverick",0,0,0,0,r=225,g=60,b=0,r2=255,g2=255,b2=255},
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

local newsVehicles = {
    [582] = {"News Van",0,6,0,0},
    [488] = {"News Chopper",0,6,0,0},
}

local fuelTankers = {
    [514] = {"Tanker",0,6,0,0},
}

local taxiVehs = {
    [420] = {"Taxi",0,6,0,0,r=255,g=255,b=0,r2=255,g2=255,b2=0},
    [438] = {"Taxi Cab",0,6,0,0,r=255,g=255,b=0,r2=255,g2=255,b2=0},
}

local mailVehs = {
    [462] = {"Faggio",0,6,0,0,r=255,g=255,b=0,r2=255,g2=255,b2=0},
}

local pizzaVehs = {
    [448] = {"Pizza Bike",0,6,0,0,r=255,g=255,b=0,r2=255,g2=255,b2=0},
}

local foodVehs = {
    [423] = {"Ice-Cream Truck",0,6,0,0},
}

local abagVehs = {
    [485] = {"Baggage",1,1,1,1},
 }

local lumber = {
    [443] = {"Packer",0,0,0,0},
    --[447] = {"2",0,0,0,0}
}


local vehicleMarkers = {
-- SWAT Base
{1232.1, -1625.67, 14.64 , 39, 64, 225, swatJobVehicles, "SWAT", "SWAT Team", 93, "noOccupation" },
{1232.1, -1616.09, 14.64, 39, 64, 225, swatJobVehicles, "SWAT", "SWAT Team", 93, "noOccupation" },
{1232.1, -1620.73, 14.64, 39, 64, 225, swatJobVehicles, "SWAT", "SWAT Team",93, "noOccupation" },
{1232.1, -1610.91, 14.64 , 39, 64, 225, swatJobVehicles, "SWAT", "SWAT Team", 93, "noOccupation" },
{1198.6, -1596.89, 76.11,39,64,225,swatHeli,"SWAT", "SWAT Team", 88, "noOccupation" },
{ 1278.8, -1693.16, 21.51 , 39, 64, 225, swatAir, "SWAT", "SWAT Team",86, "noOccupation" },
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
{ 1260.74, 329.73, 19.9, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 338.14535522461 },
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
{1555.94, -1608.88, 13.38, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 181.35133361816, "Military Forces", "seeSWATPDs", "Government Agency" },
{1573.28, -1609.78, 13.38, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 180.41200256348, "Military Forces", "seeSWATPDs", "Government Agency" },
{1588.5, -1610.93, 13.38, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 190.43716430664, "Military Forces", "seeSWATPDs", "Government Agency" },
{1603.77, -1610.78, 13.5, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 173.8310546875, "Military Forces", "seeSWATPDs", "Government Agency" },
{1602.28, -1623.92, 13.49, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 83.906616210938, "Military Forces", "seeSWATPDs", "Government Agency" },
{-1587.94, 650.68, 7.18, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 0.18402099609375, "Military Forces", "seeSWATPDs", "Government Agency" },
{-1599.62, 650.68, 7.18, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 1.4364929199219, "Military Forces", "seeSWATPDs", "Government Agency" },
{-1610.81, 650.68, 7.18, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 1.1233825683594, "Military Forces", "seeSWATPDs", "Government Agency" },
{-1622.64, 650.68, 7.18, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 2.3758239746094, "Military Forces", "seeSWATPDs", "Government Agency" },
{-1634.44, 650.68, 7.18, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 2.3758239746094, "Military Forces", "seeSWATPDs", "Government Agency" },
{2256.18, 2460.13, 10.82, 100, 139, policeJobVehicles, "Police", "Police Officer", 180.19775390625, "Military Forces", "seeSWATPDs", "Government Agency" },
{2278.06, 2443.51, 10.82, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 0.70037841796875, "Military Forces", "seeSWATPDs", "Government Agency" },
{-224.38, 995.57, 19.57, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 260.17395019531, "Military Forces", "seeSWATPDs", "Government Agency" },
{622.25, -588.91, 17.19, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 271.21539306641, "Military Forces", "seeSWATPDs", "Government Agency" },
{-2171.07, -2359.86, 30.62, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 44.437622070312, "Military Forces", "seeSWATPDs", "Government Agency" },
{-1400.57, 2637.79, 55.68, 54, 100, 139, policeJobVehicles, "Police", "Police Officer", 86.208282470703, "Military Forces", "seeSWATPDs", "Government Agency" },
--DRUG DETECTIVE
{ 1584.73, -1667.38, 5.89, 54, 100, 139, drugdetective, "Police", "Drug Detective", 270.208282470703, "noOccupation" },
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
--SWAT PD's
{1555.94, -1608.88, 13.38, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 181.35133361816, "noOccupation" },
{1573.28, -1609.78, 13.38, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 180.41200256348, "noOccupation" },
{1588.5, -1610.93, 13.38, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 190.43716430664, "noOccupation" },
{1603.77, -1610.78, 13.5, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 173.8310546875, "noOccupation" },
{1602.28, -1623.92, 13.49, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 83.906616210938, "noOccupation" },
{-1587.94, 650.68, 7.18, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 0.18402099609375, "noOccupation" },
{-1599.62, 650.68, 7.18, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 1.4364929199219, "noOccupation" },
{-1610.81, 650.68, 7.18, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 1.1233825683594, "noOccupation" },
{-1622.64, 650.68, 7.18, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 2.3758239746094, "noOccupation" },
{-1634.44, 650.68, 7.18, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 2.3758239746094, "noOccupation" },
{2256.18, 2460.13, 10.82, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 180.19775390625, "noOccupation" },
{2278.06, 2443.51, 10.82, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 0.70037841796875, "noOccupation" },
{-224.38, 995.57, 19.57, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 260.17395019531, "noOccupation" },
{622.25, -588.91, 17.19, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 271.21539306641, "noOccupation" },
{-2171.07, -2359.86, 30.62, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 44.437622070312, "noOccupation" },
{-1400.57, 2637.79, 55.68, 54, 100, 139, swatJobVehicles, "SWAT","SWAT Team", 86.208282470703, "noOccupation" },
--FBI PD's
{1555.94, -1608.88, 13.38, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 181.35133361816, "noOccupation" },
{1573.28, -1609.78, 13.38, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 180.41200256348, "noOccupation" },
{1588.5, -1610.93, 13.38, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 190.43716430664, "noOccupation" },
{1603.77, -1610.78, 13.5, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 173.8310546875, "noOccupation" },
{1602.28, -1623.92, 13.49, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 83.906616210938, "noOccupation" },
{-1587.94, 650.68, 7.18, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 0.18402099609375, "noOccupation" },
{-1599.62, 650.68, 7.18, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 1.4364929199219, "noOccupation" },
{-1610.81, 650.68, 7.18, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 1.1233825683594, "noOccupation" },
{-1622.64, 650.68, 7.18, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 2.3758239746094, "noOccupation" },
{-1634.44, 650.68, 7.18, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 2.3758239746094, "noOccupation" },
{2256.18, 2460.13, 10.82, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 180.19775390625, "noOccupation" },
{2278.06, 2443.51, 10.82, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 0.70037841796875, "noOccupation" },
{-224.38, 995.57, 19.57, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 260.17395019531, "noOccupation" },
{622.25, -588.91, 17.19, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 271.21539306641, "noOccupation" },
{-2171.07, -2359.86, 30.62, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 44.437622070312, "noOccupation" },
{-1400.57, 2637.79, 55.68, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 86.208282470703, "noOccupation" },
--MF PD's
{1555.94, -1608.88, 13.38, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 181.35133361816, "noOccupation" },
{1573.28, -1609.78, 13.38, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 180.41200256348, "noOccupation" },
{1588.5, -1610.93, 13.38, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 190.43716430664, "noOccupation" },
{1603.77, -1610.78, 13.5, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 173.8310546875, "noOccupation" },
{1602.28, -1623.92, 13.49, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 83.906616210938, "noOccupation" },
{-1587.94, 650.68, 7.18, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 0.18402099609375, "noOccupation" },
{-1599.62, 650.68, 7.18, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 1.4364929199219, "noOccupation" },
{-1610.81, 650.68, 7.18, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 1.1233825683594, "noOccupation" },
{-1622.64, 650.68, 7.18, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 2.3758239746094, "noOccupation" },
{-1634.44, 650.68, 7.18, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 2.3758239746094, "noOccupation" },
{2256.18, 2460.13, 10.82, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 180.19775390625, "noOccupation" },
{2278.06, 2443.51, 10.82, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 0.70037841796875, "noOccupation" },
{-224.38, 995.57, 19.57, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 260.17395019531, "noOccupation" },
{622.25, -588.91, 17.19, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 271.21539306641, "noOccupation" },
{-2171.07, -2359.86, 30.62, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 44.437622070312, "noOccupation" },
{-1400.57, 2637.79, 55.68, 54, 100, 139, fbiJobVehicles, "Military Forces","Military Forces", 86.208282470703, "noOccupation" },
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
{1895.09, -2243.45, 13, 238, 201, 0, pilotTug, "Civilian Workers", "Pilot", 272 },
{1718.86, 1614.22, 9.5, 238, 201, 0, pilotTug, "Civilian Workers", "Pilot", 162 },
{-1546.43, -441.99, 5.5, 238, 201, 0, pilotTug, "Civilian Workers", "Pilot", 48 },
-- Criminal vehicles
{1753.16, 759.13, 10.82, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 85.741363525391 },
{1421.87, -1307.55, 13.55, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 358.85464477539 },
{2134.84, 2355.31, 10.67, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 91.72900390625 },
{2517.35, -1672.48, 14.04, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 56.072326660156 },
{-2154.13, 649.83, 52.36, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 264.90365600586 },
-- Free vehicles
{1537.9, -1658.67, 13.1, 225, 225, 225, freeVehicles, nil, nil, 89.119689941406},
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
{ 895.69, -2362.82, 13.24,255,255,255,freeVehicles,nil,nil,213},
{-1946.33, 2407.68, 50.01, 225, 225, 225, freeVehicles, nil, nil, 280.81573486328125},
{2295.28, 515.88, -0.56,255,255,255,freeBoat,nil,nil,269},
{ 3131.78, 2061.46, -0.56,255,255,255,freeBoat,nil,nil,184},
{ 3116.34, 2061.19, -0.56,255,255,255,freeBoat,nil,nil,175},
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
--[[terror squad
{2780.27, 2676.99, 14.64,0,0,0,legBase,"Criminals","Criminal",0,"aGroup",nil,nil,nil,"Terror Squad"},
{2786.2, 2677.75, 14.64 ,0,0,0,legBase,"Criminals","Criminal",0,"aGroup",nil,nil,nil,"Terror Squad"},
{2743.22, 2996.75, 0.1 ,0,0,0,legBoat,"Criminals","Criminal",12,"aGroup",nil,nil,nil,"Terror Squad"},
{2792.55, 2677.71, 14.64,0,0,0,legBase,"Criminals","Criminal",0,"aGroup",nil,nil,nil,"Terror Squad"},

{ 2862.17, 2689.02, 36.92,0,0,0,legAir,"Criminals","Criminal",85,"aGroup",nil,nil,nil,"Terror Squad"},
--]]

--Exo
--{1108.79, 2529.15, 14.71, 255, 255, 255, exoBase, "Criminals", "Criminal",  355 , "aGroup", nil, nil, nil, "Exotic Family" },
--{1097.48, 2534.55, 23.6, 255, 255, 255, exoAir, "Criminals", "Criminal", 271 , "aGroup", nil, nil, nil, "Exotic Family" },



--TLA
--{ 2794.64, 1295.95, 10.75,255,0,0,tlaVehs, "Criminals", "Criminal", 177.6 , "aGroup", nil, nil, nil, "The Legendary Assassin" },
--{2835.56, 1247.33, 26.76,255,0,0,tlaAir, "Criminals", "Criminal", 1, "aGroup", nil, nil, nil, "The Legendary Assassin" },
-- Fisherman
{ 939.47, -2062.04, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 85},
{ 939.47, -2102.69, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 90},
{ -2417.9, 2302.69, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 267},
{ 1624.54, 571.48, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 270},
--airport attendant
{1653.06, -2260.5, 13.5,255,255,0,abagVehs,"Civilian Workers", "Airport Attendant", 0},
-- Fuel tank driver
{ 2599.85, -2199.13, 13.24, 255, 255, 0, fuelTankers, "Civilian Workers", "Fuel Tank Driver", 180},
-- Taxi driver
{1799.83, -1934.73, 13.0, 255, 255, 0, taxiVehs, "Civilian Workers", "Taxi Driver", 0},
--limo
{ 1034.26, -1124.67, 22.89, 255, 255, 0, limoveh, "Civilian Workers", "Limo Driver", 270},
--FBI Base Spawners
{1991.38, -112.16, 35.47, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 87.548645019531, "noOccupation" },
{1991.38, -105.76, 35.47, 54, 100, 139, fbiJobVehicles, "Government Agency","Federal Agent", 87.548645019531, "noOccupation" },
{2047.35, -180.46, 36.61, 54, 100, 139, fbiAir, "Government Agency","Federal Agent", 268.380859375, "noOccupation" },
{2006.16, -181.31, 58.84, 54, 100, 139, fbiAir, "Government Agency","Federal Agent", 356.69030761719, "noOccupation" },
{1996.61, -114.32, -0.56 , 54, 100, 139, fbiSea, "Government Agency","Federal Agent", 268.64453125, "noOccupation" },
--Trash Collector
{ 2184.35, -1988.25, 13.55, 225, 225, 0, trashCollectorJobVehicles, "Civilian Workers", "Trash Collector", 355},
--News Reporter
{751.45, -1341.09, 13.52,255,255,0,newsVehicles,"Civilian Workers", "News Reporter",270},
--Mail Officer
{1710.56, -1610.41, 13.25, 255, 255, 0, mailVehs, "Civilian Workers", "Mail Officer", 270},
--Pizza Boy
{2096.26, -1817.62, 13.0,255,255,0,pizzaVehs, "Civilian Workers", "Pizza Boy", 95},
--Foods Vendor
--{1984.2, -1995.6, 13.2,255,255,0,foodVehs, "Civilian Workers", "Foods Vendor", 1},
{ 2697.37, -1108.09, 69.54,255,255,0,delieveryMan,"Civilian Workers","Delievery Man",88.8},

{ 184.11, -1938.87, -0.56, 255, 255, 0, rescveh, "Civilian Workers", "Rescuer Man",  184.41107177734},

--lumber
{ -566.38, -177.19, 78.4, 255, 255, 0, lumber, "Civilian Workers", "Lumberjack",  87},
{ -503.74, -202.06, 78.4, 255, 255, 0, lumber, "Civilian Workers", "Lumberjack",  4},

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
["Federal Agent"] = fbiJobVehicles,
["Special Agent"] = dodJobVehicles,
["Pilot"] = allPilotJobVehicles,
["Trucker"] = truckerJobVehicles,
["Criminal"] = criminalJobVehicles,
["Criminals"] = crimBaseVehicles,
["Firefighter"] = fireFighterVehicles,
["Bus Driver"] = busJobVehicles,
["Street Cleaner"] = streetcleanVehicles,
["Electrician"] = electricanVehicles,
["Fisherman"] = FishermanVehs,
["K-9 Unit Officer"] = policeDogJobVehicles,
["Trash Collector"] = trashCollectorJobVehicles,
["News Reporter"] = newsVehicles,
["Fuel Tank Driver"] = fuelTankers,
["Taxi Driver"] = taxiVehs,
}

local asdmarkers = {}
local workingWithTable=false
for i,v in pairs(vehicleMarkers) do
    if getPlayerTeam ( localPlayer ) then
        local overRide=false
        if v[8] ~= nil and v[8] == "Police" then
            if getTeamName(getPlayerTeam ( localPlayer )) == "Police" or getTeamName(getPlayerTeam ( localPlayer )) == "Government Agency" or getTeamName(getPlayerTeam ( localPlayer )) == "SWAT" or getTeamName(getPlayerTeam ( localPlayer )) == "Military Forces" then
                overRide=true
            end
        end
        if overRide==false and getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer, "Occupation") == v[9] or
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
            workingWithTable=asdmarkers [source]
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
            if ( getElementData( localPlayer, "wantedPoints" ) >= 20 ) then
                exports.DENdxmsg:createNewDxMessage("You can't spawn free vehicles when having more then 1 wanted stars!", 225 ,0 ,0)
            else
                local getTable = workingWithTable --JobsToTables[getElementData(localPlayer, "Occupation")] or JobsToTables[getTeamName(getPlayerTeam ( localPlayer ))]
            local vehicle,color1,color2,color3,color4 = getTable[theVehicleID][1],getTable[theVehicleID][2],getTable[theVehicleID][3],getTable[theVehicleID][4],getTable[theVehicleID][5]--unpack( getTable[tonumber( theVehicleID )] )
            local r,g,b=nil,nil,nil
            local r2,g2,b2=nil,nil,nil
            if getTable[theVehicleID].r ~= nil then
                r,g,b=getTable[theVehicleID].r,getTable[theVehicleID].g,getTable[theVehicleID].b
            end
            if getTable[theVehicleID].r2 ~= nil then
                r2,g2,b2=getTable[theVehicleID].r2,getTable[theVehicleID].g2,getTable[theVehicleID].b2
            end
            triggerServerEvent("spawnVehicleSystem", localPlayer, x, y, z, theVehicleID, color1, color2, color3, color4, theVehicleRoation,r,g,b,r2,g2,b2)
                guiSetVisible (vehiclesWindow, false)
                showCursor(false,false)
                guiGridListClear ( vehiclesGrid )
            end
        elseif doesPlayerHaveLiceForVehicle(tonumber(theVehicleID)) then
            local getTable = workingWithTable --JobsToTables[getElementData(localPlayer, "Occupation")] or JobsToTables[getTeamName(getPlayerTeam ( localPlayer ))]
            local vehicle,color1,color2,color3,color4 = getTable[theVehicleID][1],getTable[theVehicleID][2],getTable[theVehicleID][3],getTable[theVehicleID][4],getTable[theVehicleID][5]--unpack( getTable[tonumber( theVehicleID )] )
            local r,g,b=nil,nil,nil
            local r2,g2,b2=nil,nil,nil
            if getTable[theVehicleID].r ~= nil then
                r,g,b=getTable[theVehicleID].r,getTable[theVehicleID].g,getTable[theVehicleID].b
            end
            if getTable[theVehicleID].r2 ~= nil then
                r2,g2,b2=getTable[theVehicleID].r2,getTable[theVehicleID].g2,getTable[theVehicleID].b2
            end
            triggerServerEvent("spawnVehicleSystem", localPlayer, x, y, z, theVehicleID, color1, color2, color3, color4, theVehicleRoation,r,g,b,r2,g2,b2)
            guiSetVisible (vehiclesWindow, false)
            showCursor(false,false)
            guiGridListClear ( vehiclesGrid )
        else
            exports.DENdxmsg:createNewDxMessage("You don't have a licence for this type of vehicle!", 225 ,0 ,0)
        end
    end
end
addEventHandler("onClientGUIClick", spawnVehicleSystemButton, spawnTheVehicle, false)

function doesPlayerHaveLiceForVehicle (vehicleID)
    local playtime = getElementData(localPlayer,"playTime")
    if getVehicleType ( vehicleID ) == "Automobile" or getVehicleType ( vehicleID ) == "Monster Truck"
    or getVehicleType ( vehicleID ) == "Quad" or getVehicleType ( vehicleID ) == "Trailer" then
        if playtime == false or playtime==nil then return true end
        if math.floor((tonumber(playtime)/60)) < 10 then return true end
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

swatShader = dxCreateShader ("texrep.fx")
swatTexture = dxCreateTexture("swat.png")
dxSetShaderValue (swatShader, "gTexture", swatTexture)

mfShader = dxCreateShader ("texrep.fx")
mfTexture = dxCreateTexture("mf.png")
dxSetShaderValue (mfShader, "gTexture", mfTexture)

fbiShader = dxCreateShader ("texrep.fx")
fbiTexture = dxCreateTexture("fbi.png")
dxSetShaderValue (fbiShader, "gTexture", fbiTexture)

function recShaderUpdate(t)
    for k,v in pairs(t) do
        if v[2] == "swat" then
            engineApplyShaderToWorldTexture (swatShader, "vehiclepoldecals128",v[1])
        elseif v[2] == "mf" then
            engineApplyShaderToWorldTexture (mfShader, "vehiclepoldecals128",v[1])
        elseif v[2] == "fbi" then
            engineApplyShaderToWorldTexture (fbiShader, "vehiclepoldecals128",v[1])
        end
    end
end
addEvent("recShaderUpdate",true)
addEventHandler("recShaderUpdate",localPlayer,recShaderUpdate)


local dff = engineLoadDFF ( "polmav.dff", 497 )
engineReplaceModel ( dff, 497 )

