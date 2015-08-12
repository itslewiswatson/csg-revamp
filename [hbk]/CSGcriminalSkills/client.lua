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

---------------------------- MTA VEHICLES IDS/NAMES------------------------------




-- VEHICLE NAMES BY GROUP --
local AOD = {
[560] = {"Sultan",0,0,0,0,r=0,g=255,b=213,r2=0,g2=0,b2=0},
}





local wolfBase = {
[500] = {"Mesa", 0, 0, 0, 0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[468] = {"Sanchez", 0, 0, 0, 0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[426] = {"Premier", 0, 0, 0, 0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[415] = {"Cheetah", 0, 0, 0, 0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[457] = {"Caddy", 0, 0, 0, 0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[560] = {"Sultan",0,0,0,0,r=0,g=0,b=153,r2=0,g2=0,b2=153},
[495] = {"Jeep / Sandking",0,0,0,0,r=0,g=0,b=153,r2=0,g2=0,b2=153},

}

local wolfAir = {
    [487]={"Maverick",0,0,0,0},
}

local Terrorists = {
[426] = {"Premier", 0, 7, 0, 0,r=255,g=255,b=0,r2=0,g2=0,b2=0 },
[415] = {"Cheetah", 0, 7, 0, 0,r=255,g=255,b=0,r2=0,g2=0,b2=0},
[489] = {"Rancher", 0, 7, 0, 0,r=255,g=255,b=0,r2=0,g2=0,b2=0},
[560] = {"Sultan",0,7,0,0,r=255,g=255,b=0,r2=0,g2=0,b2=0},
[495] = {"Sandking",0,7,0,0,r=255,g=255,b=0,r2=0,g2=0,b2=0},
[541] = {"Bullet",0,7,0,0,r=255,g=255,b=0,r2=0,g2=0,b2=0},
[451] = {"Turismo",0,7,0,0,r=255,g=255,b=0,r2=0,g2=0,b2=0},
[522] = {"NRG-500",0,7,0,0,r=255,g=255,b=0,r2=0,g2=0,b2=0},
}

local TerroristsAir = {
[487]={"Maverick",0,7,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[447]   ={"Seasparrow",0,7,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
}

local smurfs = {

[480]   = {"Comet", 0, 7, 0, 0,r=30,g=144,b=255 },
[468] = {"Sanchez", 0, 7, 0, 0,r=30,g=144,b=255 },
[426] = {"Premier", 0, 7, 0, 0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
[415] = {"Cheetah", 0, 7, 0, 0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
[489] = {"Rancher", 0, 7, 0, 0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
[522] = {"NRG-500",0,7,0,0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
[560] = {"Sultan",0,7,0,0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
[495] = {"Sandking",0,7,0,0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
[541] = {"Bullet",0,7,0,0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
[451] = {"Turismo",0,7,0,0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
}


local smurfsAir = {
[487]={"Maverick",0,7,0,0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
[447]   ={"Seasparrow",0,7,0,0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
}

local TerroristsBoat = {
[493]={"Jetmax",0,7,0,0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
[446]={"Squalo",0,7,0,0,r=0,g=103,b=209,r2=0,g2=0,b2=0 },
}

local vendetaVehs = {
    [400] = {"Landstalker",0,7,0,0,r=46,g=84,b=13,r2=0,g2=0,b2=0 },
    [424]   = {"BF Injection",0,7,0,0,r=46,g=84,b=13,r2=0,g2=0,b2=0 },
    [541] = {"Bullet",0,7,0,0,r=46,g=84,b=13,r2=0,g2=0,b2=0 },
    [422]   = {"Bobcat",0,7,0,0,r=46,g=84,b=13,r2=0,g2=0,b2=0 },
    [506]   = {"Super GT",0,7,0,0,r=46,g=84,b=13,r2=0,g2=0,b2=0 },
    [405]   = {"Sentinel",0,7,0,0,r=46,g=84,b=13,r2=0,g2=0,b2=0 },
    [560] = {"Sultan",0,7,0,0,r=46,g=84,b=13,r2=0,g2=0,b2=0 },
    [495] = {"Sandking",0,7,0,0,r=46,g=84,b=13,r2=0,g2=0,b2=0 },
}

local vendetaHeli = {
[487] = {"Maverick",0,7,0,0,r=46,g=84,b=13,r2=0,g2=0,b2=0 },
}


-- VEHICLE SPAWNERS LOCATIONS /TEAM --

local vehicleMarkers = {

-- Vendetta's spawners

   -- { 2770.0, 1275.84, 10.76, 255, 255, 0, vendetaVehs, "Criminals","Criminal",272,"aGroup",nil,nil,nil," The Vendetta"},
   --   { 2770.0, 1285.05, 10.76 , 255, 255, 0, vendetaVehs, "Criminals","Criminal",272,"aGroup",nil,nil,nil," The Vendetta"},
   --   { 2842.29, 1249.84, 12.93 , 255, 255, 0, vendetaHeli, "Criminals","Criminal",92,"aGroup",nil,nil,nil," The Vendetta"},

-- Sm spawners

    --{2176.15,582.8, 12.16 ,0,103,209,smurfs,"Criminals","Criminal",87,"aGroup",nil,nil,nil,"The Smurfs"},
    ---  {2176.15, 578.07, 12.16 ,0,103,209,smurfs,"Criminals","Criminal",87,"aGroup",nil,nil,nil,"The Smurfs"},
    -- {2125, 524, 0,0,103,209,smurfsBoat,"Criminals","Criminal",267,"aGroup",nil,nil,nil,"The Smurfs"},
    -- {2167.76, 583.82, 25.85 ,0,103,209,smurfsAir,"Criminals","Criminal",87,"aGroup",nil,nil,nil,"The Smurfs"},

-- Wolfenstein's spawners

    {1240.84, 708.38, 20.21,255,0,0, wolfBase,"Criminals", "Criminal",269,"aGroup", nil, nil, nil,"Wolfensteins"},
    {1241.55, 713.95, 20.21,255,0,0, wolfBase,"Criminals", "Criminal",269,"aGroup", nil, nil, nil,"Wolfensteins"},
    {1237.56, 664.97, 56.5,255,0,0,wolfAir,"Criminals","Criminal",269,"aGroup",nil,nil,nil,"Wolfensteins"},

-- The Terrorists' spawners

    {2709.28, 604.0, 14.84 ,255,255,0,Terrorists,"Criminals","Criminal",356,"aGroup",nil,nil,nil,"The Terrorists"},
    {2699.75, 604.0, 14.84 ,255,255,0,Terrorists,"Criminals","Criminal",356,"aGroup",nil,nil,nil,"The Terrorists"},
    {2623.18, 633.95, 60.11 ,255,255,0,TerroristsAir,"Criminals","Criminal",356,"aGroup",nil,nil,nil,"The Terrorists"},
    {2664.49, 567.6, -0.56  ,255,255,0,TerroristsAir,"Criminals","Criminal",185,"aGroup",nil,nil,nil,"The Terrorists"},
-- AOD's spawners

--{2835.92, 1827.50, 14.61,0,255,213,AOD,"Criminals","Criminal",0,"aGroup",nil,nil,nil,"angels of death"},
--{2845.76, 1827.50, 14.61,0,255,213,AOD,"Criminals","Criminal",0,"aGroup",nil,nil,nil,"angels of death"},
}










                                                                                             -------------------------------------------------------------------------------------------------
                                                                                                -------------- CHANGE ONLY STUFF BETWEEN THIS AND ABOVE ------------
                                                                                                         --------------------------------------------------------------------

--SCRIPT--

local JobsToTables = {

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
                                if not(getElementData(localPlayer,"Group")) then
                                    exports.DENdxmsg:createNewDxMessage("You are not allowed to use this vehicle marker!", 225 ,0 ,0)
                                    return
                                end
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

--[[400: Landstalker
401: Bravura
402 : Buffalo
403 : Linerunner
404 : Perenail
405 : Sentinel
406 : Dumper
407 : Firetruck
408 : Trashmaster
409 : Stretch
410 : Manana
411 : Infernus
412 : Voodoo
413 : Pony
414 : Mule
415 : Cheetah
416 : Ambulance
417 : Levetian
418 : Moonbeam
419 : Esperanto
420 : Taxi
421 : Washington
422 : Bobcat
423 : Mr Whoopee
424 : BF Injection
425 : Hunter
426 : Premier
427 : Enforcer
428 : Securicar
ID  : Actual name
429 : Banshee
430 : Predator
431 : Bus
432 : Rhino
433 : Barracks
434 : Hotknife
435 : Artic trailer 1
436 : Previon
437 : Coach
438 : Cabbie
439 : Stallion
440 : Rumpo
441 : RC Bandit
442 : Romero
443 : Packer
444 : Monster
445 : Admiral
446 : Squalo
447 : Seasparrow
448 : Pizza boy
449 : Tram
450 : Artic trailer 2
451 : Turismo
452 : Speeder
453 : Reefer
454 : Tropic
455 : Flatbed
456 : Yankee
457 : Caddy
ID  : Actual name
458 : Solair
459 : Top fun
460 : Skimmer
461 : PCJ 600
462 : Faggio
463 : Freeway
464 : RC Baron
465 : RC Raider
466 : Glendale
467 : Oceanic
468 : Sanchez
469 : Sparrow
470 : Patriot
471 : Quad
472 : Coastgaurd
473 : Dinghy
474 : Hermes
475 : Sabre
476 : Rustler
477 : ZR 350
478 : Walton
479 : Regina
480 : Comet
481 : BMX
482 : Burriro
483 : Camper
484 : Marquis
485 : Baggage
486 : Dozer
487 : Maverick
488 : VCN Maverick
489 : Rancher
490 : FBI Rancher
491 : Virgo
492 : Greenwood
493 : Jetmax
494 : Hotring
495 : Sandking
496 : Blistac
497 : Police maverick
498 : Boxville
499 : Benson
500 : Mesa
501 : RC Goblin
502 : Hotring A
503 : Hotring B
504 : Blood ring banger
505 : Rancher (lure)
506 : Super GT
507 : Elegant
508 : Journey
509 : Bike
510 : Mountain bike
511 : Beagle
512 : Cropduster
513 : Stuntplane
514 : Petrol
515 : Roadtrain
ID  : Actual name
516 : Nebula
517 : Majestic
518 : Buccaneer
519 : Shamal
520 : Hydra
521 : FCR 900
522 : NRG 500
523 : HPV 1000
524 : Cement
525 : Towtruck
526 : Fortune
527 : Cadrona
528 : FBI Truck
529 : Williard
530 : Fork lift
531 : Tractor
532 : Combine
533 : Feltzer
534 : Remington
535 : Slamvan
536 : Blade
537 : Freight
538 : Streak
539 : Vortex
540 : Vincent
541 : Bullet
542 : Clover
543 : Sadler
544 : Firetruck LA
545 : Hustler
546 : Intruder
547 : Primo
548 : Cargobob
549 : Tampa
550 : Sunrise
551 : Merit
552 : Utility van
553 : Nevada
554 : Yosemite
555 : Windsor
556 : Monster A
557 : Monster B
558 : Uranus
559 : Jester
560 : Sultan
561 : Stratum
562 : Elegy
563 : Raindance
564 : RC Tiger
565 : Flash
566 : Tahoma
567 : Savanna
568 : Bandito
569 : Freight flat
570 : Streak
571 : Kart
572 : Mower
573 : Duneride
ID  : Actual name
574 : Sweeper
575 : Broadway
576 : Tornado
577 : AT 400
578 : DFT 30
579 : Huntley
580 : Stafford
581 : BF 400
582 : News van
583 : Tug
584 : Petrol tanker
585 : Emperor
586 : Wayfarer
587 : Euros
588 : Hotdog
589 : Club
590 : Freight box
591 : Artic trailer 3
592 : Andromada
593 : Dodo
594 : RC Cam
595 : Launch
596 : Cop car LS
597 : Cop car SF
598 : Cop car LV
599 : Ranger
600 : Picador
601 : Swat tank
602 : Alpha
ID  : Actual name
603 : Phoenix
604 : Glendale (damage)
605 : Sadler (damage)
606 : Bag box A
607 : Bag box B
608 : Stairs
609 : Boxville (black)
610 : Farm trailer
611 : Utility van trailer
 ]]
