--[[************************************************************************************
*       |---------------------------------------------|
* |------      Multi Theft Auto - Limo Job By SpriN'  ----------|
*       |---------------------------------------------|
**************************************************************************************]]


chauffeurSkins = { [253]=true, [255]=true, [61]=true }
Limos = { [409]=true}
playerClients = { }
playerCols = { }
playerBlips = { }
jobClients = { }
playerJobLocation = {  }
local drawing 
money = 0
timee = 0
--[[setTimer(function()
	local occc = exports.server:getPlayerOccupation(localPlayer)
    if ( occc == "Limo Driver") and ( getTeamName( getPlayerTeam( localPlayer) ) == "Civilian Workers") then
		pass = getElementData(localPlayer, "limo")
	end	
end,50,0)]]

function panell()
panel = guiCreateWindow(434, 137, 591, 372, "CSG  ~  Limo Job", false)
guiWindowSetSizable(panel, false)
guiSetVisible ( panel, false )

grid = guiCreateGridList(9, 42, 564, 208, false, panel)
guiGridListAddColumn(grid, "Rank", 0.3)
guiGridListAddColumn(grid, "Points Needed", 0.2)
guiGridListAddColumn(grid, "Nearly Payment", 0.2)
guiGridListAddColumn(grid, "Promotion Bonus", 0.2)

ranks = {
{"Limo Driver In Training",0,"1800$", "3k + 1 score"},
{"New Limo Driver",15,"2300$", "3k + 1 score"},
{"Trained Limo Driver",50,"2800$", "3k + 1 score"},
{"Experienced Limo Driver",150,"3500$", "5k + 3 score"},
{"Senior Limo Driver",250,"4300$", "5k + 3 score"},
{"Lead Limo Driver",350,"5300$", "10k + 3 score"},
{"Head Limo Driver",500,"6500$", "20k + 5 score"},
}

for i,v in pairs(ranks) do
        local row = guiGridListAddRow(grid)
        guiGridListSetItemText(grid, row, 1, tostring(v[1]), false, false )
        guiGridListSetItemText(grid, row, 2, tostring(v[2]), false, false )
        guiGridListSetItemText(grid, row, 3, tostring(v[3]), false, false )
        guiGridListSetItemText(grid, row, 4, tostring(v[4]), false, false )
end

currentRank = getElementData(localPlayer, "Rank")
--pass = getElementData(localPlayer, "limo")

jobInfo = guiCreateButton(521, 260, 60, 47, "Job info", false, panel)
guiSetProperty(jobInfo, "NormalTextColour", "FFAAAAAA")
close = guiCreateButton(521, 315, 60, 47, "Close", false, panel)
guiSetProperty(close, "NormalTextColour", "FFAAAAAA")
Voice = guiCreateCheckBox(25, 343, 101, 20, "Voice", true, false, panel)
gps = guiCreateCheckBox(184, 347, 108, 15, "GPS", true, false, panel)
dx = guiCreateCheckBox(318, 347, 121, 16, "Show simple panel", true, false, panel)
a = guiCreateLabel(9, 269, 248, 39, "Current Rank: " ..tostring(currentRank), false, panel)
b = guiCreateLabel(10, 307, 215, 40, "Current Points: " ..tostring(pass), false, panel)

info = guiCreateWindow(494, 149, 273, 308, "Job info", false)
guiWindowSetSizable(info, false)
guiSetVisible ( info, false )
memo = guiCreateMemo(9, 30, 254, 238, "As Limo Driver, you have missions.\nMissions are taking some important persons to any place they want, currently only Los Santos.\n\n When you spawn a limo (Stretch) a blip will appears on your map, you have to go there to pick up the passenger, you can follow the arrows of the GPS system, also the voice system will tells you where to go.\n\n You can disable the voice system or the gps system or the simple panel that appears under your HUD, on F5.", false, info)
clos = guiCreateButton(178, 272, 85, 26, "Close", false, info)    
end
addEventHandler("onClientResourceStart", resourceRoot, panell)
--addEventHandler("onClientPlayerJoin", getRootElement(), panel)

--[[function onElementDataChange( dataName, oldValue )
        if dataName == "Occupation" and getElementData(localPlayer,dataName) == "Limo Driver" then
                panel() 
pass = getElementData(localPlayer, "limo")				
        end
end
addEventHandler ( "onClientElementDataChange", localPlayer, onElementDataChange, false )]]


function showDXt()
    local occc = exports.server:getPlayerOccupation(localPlayer)
    if ( occc == "Limo Driver") and ( getTeamName( getPlayerTeam( localPlayer) ) == "Civilian Workers") then
        local playerVehicle = getPedOccupiedVehicle ( localPlayer )
        if playerVehicle and ( getElementModel ( playerVehicle) == 409 ) then
            pass = getElementData(localPlayer, "limo")
			guiSetText(b, "Current Points: " ..tostring(pass))
            dxDrawRectangle(1077, 189, 252, 175, tocolor(51, 51, 50, 171), true)
            dxDrawText("Time left:                " ..tostring(timee), 1086, 204, 1153, 229, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, true, false, false)
            dxDrawText("Money earned today:             " ..tostring(money).. "$", 1085, 251, 1153, 280, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, true, false, false)
            dxDrawText("People delivered:           " ..tostring(pass), 1085, 307, 1151, 340, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, true, false, false)
            dxDrawLine(1076, 190, 1076, 364, tocolor(255, 255, 255, 255), 1, true)
            dxDrawLine(1077, 364, 1329, 364, tocolor(255, 255, 255, 255), 1, true)
            dxDrawLine(1329, 363, 1329, 187, tocolor(255, 255, 255, 255), 1, true)
            drawing = true
        end
    end
end


function showDX(thePlayer)
    if thePlayer == localPlayer and not drawing then
        addEventHandler("onClientRender", root, showDXt)
        drawing = true
    end
end
addEventHandler ("onClientVehicleEnter", getRootElement(), showDX)

function hideDX(thePlayer)
    if thePlayer == localPlayer and drawing then
        removeEventHandler("onClientRender", root, showDXt)
        drawing = false
        if isTimer(tmr) then killTimer(tmr) end
    end
end
addEventHandler ("onClientVehicleExit", getRootElement(), hideDX)

Pos = {
[1] = {1151.1865234375, -1221.626953125, 17.762107849121, 181.6369934082},
[2] = {1023.9072265625, -1134.9853515625, 23.820327758789, 180.98878479004},
[3] = {1088.9501953125, -1094.2744140625, 25.429988861084, 87.010314941406},
[4] = {961.361328125, -941.08203125, 40.647071838379, 178.19274902344},
[5] = {911.9755859375, -989.8623046875, 37.989589691162, 23.090850830078},
[6] = {644.1708984375, -1216.0654296875, 18.28125, 82.934326171875},
[7] = {683.8740234375, -1275.556640625, 13.564894676208, 82.945068359375},
[8] = {644.474609375, -1355.474609375, 13.56036567688, 88.262756347656},
[9] = {516.8359375, -1442.6953125, 15.177885055542, 29.693756103516},
[10] = {329.0087890625, -1512.076171875, 36.0390625, 226.46739196777},
[11] = {290.56640625, -1631.4482421875, 33.330200195313, 177.90161132813},
[12] = {315.5205078125, -1772.8896484375, 4.6928400993347, 179.46716308594},
[13] = {375.9248046875, -2028.0009765625, 7.8300905227661, 90.168914794922},
[14] = {484.93359375, -1653.228515625, 22.540174484253, 177.87957763672},
[15] = {281.36328125, -1320.1650390625, 53.826961517334, 30.006866455078},
[16] = {262.451171875, -1332.3486328125, 53.222801208496, 31.885559082031},
[17] = {213.0048828125, -1350.5029296875, 50.979682922363, 219.57336425781},
[18] = {218.48828125, -1273.2841796875, 64.06990814209, 248.71502685547},
[19] = {262.0537109375, -1231.462890625, 73.727828979492, 209.54817199707},
[20] = {323.9599609375, -1188.564453125, 76.378784179688, 215.18974304199},
[21] = {689.6650390625, -1054.1376953125, 50.13871383667, 61.966583251953},
[22] = {833.54296875, -886.8623046875, 68.7734375, 311.36004638672},
[23] = {1077.4287109375, -777.4296875, 107.75743865967, 11.49462890625},
[24] = {1003.6328125, -642.8330078125, 121.47063446045, 25.908905029297},
[25] = {1039.66015625, -638.423828125, 120.1171875, 14.944396972656},
[26] = {1241.73046875, -741.9111328125, 95.331443786621, 19.64111328125},
[27] = {1248.31640625, -807.533203125, 84.140625, 173.15539550781},
[28] = {1307.1044921875, -812.7060546875, 77.927635192871, 232.68574523926},
[29] = {1351.8544921875, -618.892578125, 109.1328125, 11.110107421875},
[30] = {1497.2001953125, -694.32421875, 94.75, 182.86747741699},
[31] = {1426.3759765625, -959.9912109375, 36.351356506348, 351.72991943359},
[32] = {1346.001953125, -984.2783203125, 29.460252761841, 265.59030151367},
[33] = {1373.5537109375, -1089.08203125, 25.112733840942, 84.164794921875},
[34] = {1451.13671875, -1153.7080078125, 23.894338607788, 191.32707214355},
[35] = {1534.498046875, -1285.43359375, 15.525014877319, 132.08792114258},
[36] = {1780.7216796875, -1290.6474609375, 13.640537261963, 23.425964355469},
[37] = {1956.064453125, -1160.537109375, 20.930709838867, 66.328216552734},
[38] = {1961.8544921875, -1162.0439453125, 26.078907012939, 269.34768676758},
[39] = {2223.6630859375, -1145.044921875, 25.800037384033, 338.90866088867},
[40] = {2649.0302734375, -1460.7958984375, 30.464109420776, 91.080810546875},
[41] ={2656.1455078125, -1668.9140625, 10.887079238892, 343.94598388672},
[42] ={2744.3037109375, -1648.3330078125, 13.271635055542, 139.65209960938},
[43] ={2807.865234375, -1478.58984375, 17.791688919067, 184.43305969238},
[44] ={2499.662109375, -1684.90234375, 13.437197685242, 14.603790283203},
[45] ={2465.6630859375, -1741.4443359375, 13.546875, 357.99771118164},
[46] ={2421.74609375, -2043.6806640625, 13.546875, 82.599243164063},
[47] ={2430.66796875, -2456.2265625, 13.625, 348.91186523438},
[48] ={1729.189453125, -2326.7685546875, 13.546875, 1.1343688964844},
[49] ={1648.8544921875, -2247.0224609375, -2.678258895874, 182.88945007324},
[50] = {1720.9716796875, -1854.6962890625, 13.579320907593, 268.40832519531},
[51] = {1717.6455078125, -1610.7490234375, 13.546875, 355.82788085938},
[52] = {1484.60546875, -1744.4423828125, 13.546875, 356.76721191406},
[53] = {1241.8212890625, -2035.8623046875, 60.041389465332, 269.99588012695},
[54] = {1264.111328125, -2046.806640625, 59.302909851074, 178.505859375}
}



 
 local vipSkins = {
[1]={ 17 },
[2]={ 43 },
[3]={ 46 },
[4]={ 55 },
[5]={ 57 },
[6]={ 70 },
[7]={ 120 },
[8]={ 165 },
[9]={ 185 },
[10]={ 217 },
[11]={ 228 },
[12]={ 294 },
[13]={ 295 },
}

function startJob ( thePlayer)
if thePlayer == getLocalPlayer() then
    local occc = exports.server:getPlayerOccupation(thePlayer)
    if ( occc == "Limo Driver") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
        local x, y, z = getElementPosition ( thePlayer )
        local playerVehicle = getPedOccupiedVehicle ( thePlayer )
        if ( getElementModel ( playerVehicle ) == 409 ) then
            if not playerClients[ thePlayer ] then
                local numLocations = #Pos
                if ( numLocations > 0 ) then
                    repeatCount = 0
                    repeat
                        pickupx, pickupy, pickupz, pickupr = unpack ( Pos [ math.random ( #Pos ) ] )
                        local jobDistance = getDistanceBetweenPoints3D ( x, y, z, pickupx, pickupy, pickupz )
                        repeatCount = repeatCount+1
                    until jobDistance > 10 and jobDistance < 40 + repeatCount*100
                    if  playerVehicle  then
                        local skins = unpack ( vipSkins [ math.random ( #vipSkins ) ] )
                        ped = createPed( skins, pickupx, pickupy, pickupz ) 
                        function stopDamage(attacker, weapon, bodypart)
                            cancelEvent()
                        end
                        addEventHandler("onClientPedDamage", ped, stopDamage)
                        setPedRotation ( ped, pickupr )
                        setElementFrozen ( ped, true)

                    end
                    playerClients[ thePlayer ] = {  }
                    table.insert( playerClients[ thePlayer ], ped )
                    table.insert( jobClients, ped )
                
                    local pedBlip = createBlipAttachedTo ( ped, 41, 2, 255, 0, 0, 255, 1, 99999999.0)
                    playerBlips[ thePlayer ] = {  }
                    table.insert( playerBlips[ thePlayer ], pedBlip )
                
                    pedMarker = createMarker ( pickupx, pickupy, 0, cylinder, 6.5, 255, 255, 0, 150)
                    playerCols[ thePlayer ] = {  }
                    table.insert( playerCols[ thePlayer ], pedMarker )
                    local loc = getZoneName ( pickupx, pickupy, pickupz )
                    local cityy = getZoneName ( pickupx, pickupy, pickupz, true )
                    addEventHandler( "onClientMarkerHit", pedMarker, arrivePickup )
                    --names = { "Barack Obama"; "David Cameron"; "Sensei"; "Francois Holland"; "Mario Draghi"; "Vladimir Putin"; "Bill Gates"; "Mark Zuckerberg"; "Timothy Cook"; "Joseph Blatter"}
                    names = { 
                    [1] = {"Barack Obama"},
                    [2] = {"David Cameron"},
                    [3] = {"Sensei"},
                    [4] = {"Francois Holland"},
                    [5] = {"Mario Draghi"},
                    [6] = {"Vladimir Putin"},
                    [7] = {"Bill Gates"},
                    [8] = {"Mark Zuckerberg"},
                    [9] = {"Timothy Cook"},
                    [10] = {"Joseph Blatter"},
                    }
                    passenger = unpack (names [math.random(#names)])
                    if guiCheckBoxGetSelected(Voice) == true then
                    triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Pickup " ..passenger.. " from " ..loc,true)
                    end
                    exports.dendxmsg:createNewDxMessage("Pickup " ..passenger.. " from " ..loc.. ", " ..cityy,0, 255, 0)
                    jobDistance = getDistanceBetweenPoints3D ( x, y, z, pickupx, pickupy, pickupz )
                    if guiCheckBoxGetSelected(gps) == true then
                        exports.CSGgps:resetDestination()
                        exports.CSGgps:setDestination(pickupx, pickupy, pickupz,"Passenger Pickup","None",{false,true,false,true})
                    end
                    timee = round(jobDistance*2)
                    if isTimer(tmr) then killTimer(tmr) end
                        tmr = setTimer( function ()
                        timee = timee - 1 
                        if timee <= 0 and isPedInVehicle(thePlayer) then
                            exports.dendxmsg:createNewDxMessage("Time finished",255, 0, 0)
                            stopJob(thePlayer)
                            startJob(thePlayer)
                        elseif timee <= 0 and not isPedInVehicle(thePlayer) then
                            timee = 0
                            if isTimer(tmr) then killTimer(tmr) end
                        end
                    end , 1000, tonumber(timee))
                else
                    exports.dendxmsg:createNewDxMessage("No passenger pickup points, re-enter your vehicle",0, 255, 0)
                end
            else
                exports.dendxmsg:createNewDxMessage("You already have a mission",0, 255, 0)
            end
        end 
    end
 end
end
addEventHandler ("onClientVehicleEnter", getRootElement(), startJob)


function arrivePickup ( thePlayer )
    if thePlayer == getLocalPlayer() then
        local occc = exports.server:getPlayerOccupation(thePlayer)
        if ( occc == "Limo Driver") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
            if playerClients[ thePlayer ] then
                for k, ped in pairs( playerClients[ thePlayer ] ) do
                    if ped then
                        local x,y,z     = getElementPosition(ped)
                        local tx,ty,tz  = getElementPosition(thePlayer)
                        setPedRotation(ped, findRotation(x,y,tx,ty) )
                        local numLocations = #Pos
                        if ( numLocations > 0 ) then
                            local playerVehicle = getPedOccupiedVehicle ( thePlayer )
                            if playerVehicle and Limos[getElementModel ( playerVehicle )] then
                                local speedx, speedy, speedz = getElementVelocity ( thePlayer )
                                local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
                                if actualspeed < 0.25 then
                                    local occupants = getVehicleOccupants(playerVehicle)
                                    local seats = getVehicleMaxPassengers(playerVehicle)
                                    local freeSeats = 0
                                    for seat = 3, seats do
                                        local occupant = occupants[seat]
                                        if not occupant and tonumber(freeSeats) == 0 then
                                            freeSeats = freeSeats + 1
                                            setElementFrozen(playerVehicle, true )
                                            fadeCamera ( false, 1.0, 0, 0, 0 )  
                                            setTimer ( fadeCamera, 3000, 1,  true, 0.5 )
                                            if ( isPedInVehicle ( thePlayer ) ) then
                                                triggerServerEvent("warp", getLocalPlayer(), ped)
                                            end
                                        end
                                            
                                        local peddVehicle = getPedOccupiedVehicle ( ped )
                                        if peddVehicle ~= playerVehicle then
                                            destroyElement(ped)
                                        end
                                            
                                        if playerBlips[ thePlayer ] then
                                            for k, blip in pairs( playerBlips[ thePlayer ] ) do
                                                if blip then
                                                    destroyElement( blip )
                                                    playerBlips[ thePlayer ] = nil
                                                end
                                            end
                                        end
                                            
                                        if playerCols[ thePlayer ] then
                                            for k, col in pairs( playerCols[ thePlayer ] ) do
                                                if col then
                                                    destroyElement( col )
                                                    playerCols[ thePlayer ] = nil
                                                end
                                            end
                                        end

                                        playerJobLocation[ thePlayer ] = {  }
                                        playerJobLocation[ thePlayer ] = { ["x"]=x, ["y"]=y, ["z"]=z }
 
                                        repeat
                                            dropOffx, dropOffy, dropOffz, dropOffr = unpack ( Pos [ math.random ( #Pos ) ] )
                                            local jobDistance = getDistanceBetweenPoints3D ( x, y, z, dropOffx, dropOffy, dropOffz )
                                        until jobDistance > 200 and jobDistance < 1000
 
                                        local dropOffBlip = createBlip ( dropOffx, dropOffy, dropOffz, 41, 2, 255, 0, 0, 255, 1, 99999.0)
                                        setBlipVisibleDistance(dropOffBlip, 3000)
                                        playerBlips[ thePlayer ] = {  }
                                        table.insert( playerBlips[ thePlayer ], dropOffBlip )

                                        pedMarkerr = createMarker ( dropOffx, dropOffy, 0, cylinder, 6.5, 255, 255, 0, 150)
                                        playerCols[ thePlayer ] = {  }
                                        table.insert( playerCols[ thePlayer ], pedMarkerr )
                                        addEventHandler( "onClientMarkerHit", pedMarkerr, arriveDropOff )
                                        local loc = getZoneName ( dropOffx, dropOffy, dropOffz )
                                        local cityy = getZoneName ( dropOffx, dropOffy, dropOffz, true )
                                        if guiCheckBoxGetSelected(gps) == true then
                                            exports.CSGgps:resetDestination()
                                            exports.CSGgps:setDestination(dropOffx, dropOffy, dropOffz,"Passenger Pickup","None",{false,true,false,true})
                                        end
                                        if guiCheckBoxGetSelected(Voice) == true then
                                        triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Take " ..passenger.. " to " ..loc,true)
                                        end
                                        exports.dendxmsg:createNewDxMessage("Take " ..passenger.. " to " ..loc.. ", " ..cityy,0, 255, 0)
                                        setTimer(setElementFrozen, 3000, 1, playerVehicle, false)
                                        if tonumber(freeSeats) == 0 then
                                            exports.dendxmsg:createNewDxMessage("You don't have an empty seat for the passenger!",255,0,0)
                                        end
                                    end
                                else
                                    exports.dendxmsg:createNewDxMessage("Slow down to pick up the passenger!",230, 25, 0)
                                end
                            else
                                exports.dendxmsg:createNewDxMessage("You don't have a Limo",255,0, 0)
                            end
                        else
                            exports.dendxmsg:createNewDxMessage("No passenger pickup points, re-enter your vehicle",255, 0, 0)
                        end
                    end
                end
            end
        end
    end
end



function arriveDropOff ( thePlayer )
if thePlayer == getLocalPlayer() then
local occc = exports.server:getPlayerOccupation(thePlayer)
if ( occc == "Limo Driver") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
    if playerClients[ thePlayer ] then
        for k, ped in pairs( playerClients[ thePlayer ] ) do
            if ped then
                local playerVehicle = getPedOccupiedVehicle ( thePlayer )
                if playerVehicle and Limos[getElementModel ( playerVehicle )] then
                        local speedx, speedy, speedz = getElementVelocity ( thePlayer )
                        local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
                        if actualspeed < 0.42 then
                            if playerClients[ thePlayer ] then
                                for k, ped in pairs( playerClients[ thePlayer ] ) do
                                    if ped then
                                        destroyElement( ped )
                                        playerClients[ thePlayer ] = nil
                                    end
                                end
                                for k, blip in pairs( playerBlips[ thePlayer ] ) do
                                    if blip then
                                        destroyElement( blip )
                                        playerBlips[ thePlayer ] = nil
                                    end
                                end
                                for k, col in pairs( playerCols[ thePlayer ] ) do
                                    if col then
                                        destroyElement( col )
                                        playerCols[ thePlayer ] = nil
                                    end
                                end
                                
                                    setElementFrozen ( playerVehicle, true )
                                    fadeCamera ( false, 1.0, 0, 0, 0 )  
                                    setTimer ( fadeCamera, 3000, 1, true, 0.5 )
                                    setElementFrozen ( playerVehicle, false )
                                
                                dx = tonumber(playerJobLocation[ thePlayer ]["x"])
                                dy = tonumber(playerJobLocation[ thePlayer ]["y"])
                                dz = tonumber(playerJobLocation[ thePlayer ]["z"])
                                pass = tonumber(pass) + 1
                                if tonumber(pass) >= 0 and tonumber(pass) < 15 then
                                    rankBonus = 300
                                elseif tonumber(pass) >= 15 and tonumber(pass) < 50 then
                                    rankBonus = 800
                                elseif tonumber(pass) >= 50 and tonumber(pass) < 150 then
                                    rankBonus = 1300
                                elseif tonumber(pass) >= 150 and tonumber(pass) < 250 then
                                    rankBonus = 2000
                                elseif tonumber(pass) >= 250 and tonumber(pass) < 350 then
                                    rankBonus = 2800
                                elseif tonumber(pass) >= 350 and tonumber(pass) < 500 then
                                    rankBonus = 3500
                                elseif tonumber(pass) >= 500 then
                                    rankBonus = 5000
                                end
                            
                                local tx,ty,tz  = getElementPosition(thePlayer)
                                local jobDistance = getDistanceBetweenPoints3D ( dx, dy, dz, tx, ty, tz )             
                                local jobDistanceKM = round(jobDistance)
                                local jobReward = rankBonus + round(1500+(jobDistanceKM/2))
                                 
                                for k, jobLocation in pairs( playerJobLocation[ thePlayer ] ) do
                                    if jobLocation then
                                        playerJobLocation[ thePlayer ] = nil
                                    end
                                end
                                
                                triggerServerEvent("giveLimoMoney", getLocalPlayer(),jobReward )
                                setElementData(thePlayer, "limo", tostring(pass))
                                
                                money = money + jobReward
                                triggerServerEvent("giveLimoScore", getLocalPlayer(), 0.5)
                                if guiCheckBoxGetSelected(Voice) == true then
                                    triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Job succesful, you earned "..jobReward.."$ +0.5 score",true)
                                end
                                exports.dendxmsg:createNewDxMessage("Job succesful, you earned "..jobReward.."$ +0.5 score",0, 255, 0)
                                exports.CSGgps:resetDestination()
                                sound()
                                setTimer(startJob, 6000, 1, thePlayer )
                                
                                if pass == 1 then
                                triggerServerEvent("giveLimoMoney", getLocalPlayer(),3000 )
                                triggerServerEvent("giveLimoScore", getLocalPlayer(), 1)
                                if guiCheckBoxGetSelected(Voice) == true then
                                    triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Congratulation! You finished your first mission! 3k + 1 score bonus",true)
                                end
                                exports.dendxmsg:createNewDxMessage("Congratulation! You finished your first mission! 3k + 1 score bonus",0, 255, 0)
                                elseif pass == 15 then
                                triggerServerEvent("giveLimoMoney", getLocalPlayer(),3000 )
                                triggerServerEvent("giveLimoScore", getLocalPlayer(), 1)
                                if guiCheckBoxGetSelected(Voice) == true then
                                    triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Congratulation! You got promoted to New Limo Driver! 3k + 1 score bonus",true)
                                end
                                exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to New Limo Driver! 3k + 1 score bonus",0, 255, 0)
                                elseif pass == 50 then
                                triggerServerEvent("giveLimoMoney", getLocalPlayer(),3000 )
                                triggerServerEvent("giveLimoScore", getLocalPlayer(), 1)
                                if guiCheckBoxGetSelected(Voice) == true then
                                    triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Congratulation! You got promoted to Trained Limo Driver! 3k + 1 score bonus",true)
                                end
                                exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to Trained Limo Driver! 3k + 1 score bonus",0, 255, 0)
                                elseif pass == 150 then
                                triggerServerEvent("giveLimoMoney", getLocalPlayer(),5000 )
                                triggerServerEvent("giveLimoScore", getLocalPlayer(), 3)
                                if guiCheckBoxGetSelected(Voice) == true then
                                    triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Congratulation! You got promoted to Experienced Limo Driver! 5k + 3 score bonus",true)
                                end
                                exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to Experienced Limo Driver! 5k + 3 score bonus",0, 255, 0)
                                elseif pass == 250 then 
                                triggerServerEvent("giveLimoMoney", getLocalPlayer(),5000 )
                                triggerServerEvent("giveLimoScore", getLocalPlayer(), 3)
                                if guiCheckBoxGetSelected(Voice) == true then
                                    triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Congratulation! You got promoted to Senior Limo Driver! 5k + 3 score bonus",true)
                                end
                                exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to Senior Limo Driver! 5k + 3 score bonus",0, 255, 0)
                                elseif pass == 350 then 
                                triggerServerEvent("giveLimoMoney", getLocalPlayer(),10000 )
                                triggerServerEvent("giveLimoScore", getLocalPlayer(), 3)
                                if guiCheckBoxGetSelected(Voice) == true then
                                    triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Congratulation! You got promoted to Lead Limo Driver! 10k + 3 score bonus",true)
                                end
                                exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to Lead Limo Driver! 10k + 3 score bonus",0, 255, 0)
                                elseif pass == 500 then 
                                triggerServerEvent("giveLimoMoney", getLocalPlayer(),20000 )
                                triggerServerEvent("giveLimoScore", getLocalPlayer(), 5)
                                if guiCheckBoxGetSelected(Voice) == true then
                                    triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Congratulation! You got promoted to Head Limo Driver! 20k + 5 score bonus",true)
                                end
                                exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to Head Limo Driver! 20k + 5 score bonus",0, 255, 0)
                                end
                            end
                        else
                        exports.dendxmsg:createNewDxMessage("Slow down to drop off the passenger!",255, 255, 0)
                        end
                else
                exports.dendxmsg:createNewDxMessage("You don't have a Limo!",255, 0, 0)
                end 
            end
        end
    end
end
end
end

function stopJob ( thePlayer )
if thePlayer == getLocalPlayer() then
local occc = exports.server:getPlayerOccupation(thePlayer)
if ( occc == "Limo Driver") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
    if playerClients[ thePlayer ] then
    setElementData(thePlayer, "limo", tostring(pass))
    exports.CSGgps:resetDestination()
    timee = 0
        for k, ped in pairs( playerClients[ thePlayer ] ) do
            if ped then
                destroyElement( ped );
                playerClients[ thePlayer ] = nil;
            end
        end
        for k, blip in pairs( playerBlips[ thePlayer ] ) do
            if blip then
                destroyElement( blip );
                playerBlips[ thePlayer ] = nil;
            end
        end
        for k, col in pairs( playerCols[ thePlayer ] ) do
            if col then
                destroyElement( col );
                playerCols[ thePlayer ] = nil;
            end
        end
        if playerJobLocation[ thePlayer ] then
            for k, jobLocation in pairs( playerJobLocation[ thePlayer ] ) do
                if jobLocation then
                    destroyElement( jobLocation );
                    playerJobLocation[ thePlayer ] = nil;
                end
            end
        end
            exports.dendxmsg:createNewDxMessage("Job canceled.",255, 0, 0)
        else
        exports.dendxmsg:createNewDxMessage("You don't have an assignment!",255, 0, 0)
    
        end
    end
end
end
--addEventHandler ("onClientPlayerWasted",getRootElement(), stopJob)
addEventHandler ("onClientVehicleExit",getRootElement(), stopJob)
addEventHandler ("onClientVehicleExplode",getRootElement(), stopJob)

 
function findRotation(x1,y1,x2,y2)
    local t = -math.deg(math.atan2(x2-x1,y2-y1))
    if t < 0 then t = t + 360 end
    return t
end
 
function round(number, digits)
  local mult = 10^(digits or 0)
  return math.floor(number * mult + 0.5) / mult
end


--panel


addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName )
    if (getElementType ( source ) == "player") and (dataName == "Rank") and (exports.server:getPlayerOccupation(thePlayer) == "Limo Driver") then
        if source == localPlayer then
			currentRank = getElementData(localPlayer, "Rank")
			guiSetText(a, "Current Rank: " ..currentRank)
        end
    end
end)

--job info


function hideGUI()
	if source == close then
    guiSetVisible(panel,false)
    showCursor(false)
	end
end
addEventHandler("onClientGUIClick", root, hideGUI)

function hideiGUI()
	if source == clos then
    guiSetVisible(info,false)
    showCursor(false)
	end
end
addEventHandler("onClientGUIClick", root, hideiGUI)

function showiGUI()
	if source == jobInfo then
    guiSetVisible(info,true)
    guiMoveToBack( panel )
    showCursor(true)
	end
end
addEventHandler("onClientGUIClick", root, showiGUI)

bindKey ( "F5", "up",
function( )        
local occc = exports.server:getPlayerOccupation(localPlayer)
if ( occc == "Limo Driver") and ( getTeamName( getPlayerTeam( localPlayer ) ) == "Civilian Workers") then
 if ( exports.server:isPlayerLoggedIn(localPlayer) == true ) then
    if ( guiGetVisible ( panel ) ) then            
        guiSetVisible(panel,false)
        showCursor(false)
    else              
        guiSetVisible ( panel, true ) 
        showCursor(true)
    end
   end
 end
end)


function gpsCheckBoxChange()
    if source ~= gps then return end
    if guiCheckBoxGetSelected(gps) == true then
        for k, blip in pairs( playerBlips[ thePlayer ] ) do
            if blip then
                x,y,z = getElementPosition( blip )
            end
        end
        if x and y and z then
            exports.CSGgps:setDestination(x,y,z,"Limo Driver Stop","",{false,true,false,true})
        else
            x,y,z = getElementPosition(localPlayer)
            exports.CSGgps:setDestination(x,y,z,"Limo Driver Stop","",{false,true,false,true})
        end
    else
        exports.CSGgps:resetDestination()
    end
end
addEventHandler("onClientGUIClick", root, gpsCheckBoxChange)

function sayVoice(str)

    local x,y,z = getElementPosition(localPlayer)
    currentVoice = playSound(str,x,y,z)
end
addEvent("CSGLimoDriverSayVoiceClient",true)
addEventHandler("CSGLimoDriverSayVoiceClient",getRootElement(),sayVoice)

function dxCheckBoxChange()
    if source ~= dx then return end
    if guiCheckBoxGetSelected(dx) == true then
        showDX(localPlayer)
    else
        hideDX(localPlayer)
    end
end
addEventHandler("onClientGUIClick", root, dxCheckBoxChange)


function sound()
local sound = playSound("mission_accomplished.mp3")
setSoundVolume(sound, 0.5)
end

exports.CSGSpriNJobdx:add(1006.96, -1118.77, 23.9, "Limo Driver", 200, 250, 0)

if fileExists("limo_c.lua") == true then
    fileDelete("limo_c.lua")
end