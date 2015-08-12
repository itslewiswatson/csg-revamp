--[[************************************************************************************
*       |---------------------------------------------|
* |------      Multi Theft Auto - Rescuer Job By SpriN'  ----------|
*       |---------------------------------------------|
**************************************************************************************]]

local chauffeurSkins = { [18]=true, [35]=true, [45]=true }
local Rescuers = { [472]=true}
local playerClients = { }
local playerCols = { }
local playerBlips = { }
local jobClients = { }
local playerJobLocation = {  }
local drawing 
money = 0
timee = 0

function resPanel()
panel = guiCreateWindow(434, 137, 591, 372, "CSG  ~  Rescuer Job", false)
guiWindowSetSizable(panel, false)
guiSetVisible ( panel, false )

grid = guiCreateGridList(9, 42, 564, 208, false, panel)
guiGridListAddColumn(grid, "Rank", 0.3)
guiGridListAddColumn(grid, "Points Needed", 0.2)
guiGridListAddColumn(grid, "Nearly Payment", 0.2)
guiGridListAddColumn(grid, "Promotion Bonus", 0.2)

local ranks = {
[1] = {"Rescuer Man In Training",0,"1200$", "3k + 1 score"},
[2] = {"New Rescuer Man",15,"1400$", "3k + 1 score"},
[3] = {"Trained Rescuer Man",50,"1800$", "3k + 1 score"},
[4] = {"Experienced Rescuer Man",150,"2400$", "5k + 3 score"},
[5] = {"Senior Rescuer Man",250,"2800$", "5k + 3 score"},
[6] = {"Lead Rescuer Man",350,"3400$", "10k + 3 score"},
[7] = {"Head Rescuer Man",500,"3800$", "20k + 5 score"}
}

for i,v in pairs(ranks) do
		local row = guiGridListAddRow(grid)
		guiGridListSetItemText(grid, row, 1, tostring(v[1]), false, false )
		guiGridListSetItemText(grid, row, 2, tostring(v[2]), false, false )
		guiGridListSetItemText(grid, row, 3, tostring(v[3]), false, false )
		guiGridListSetItemText(grid, row, 4, tostring(v[4]), false, false )
end

currentRank = getElementData(localPlayer, "Rank")
currentPoints = getElementData(localPlayer, "limo")

jobInfo = guiCreateButton(521, 260, 60, 47, "Job info", false, panel)
guiSetProperty(jobInfo, "NormalTextColour", "FFAAAAAA")
close = guiCreateButton(521, 315, 60, 47, "Close", false, panel)
guiSetProperty(close, "NormalTextColour", "FFAAAAAA")
Voice = guiCreateCheckBox(25, 343, 101, 20, "Voice", true, false, panel)
gps = guiCreateCheckBox(184, 347, 108, 15, "disabled", true, false, panel)
dx = guiCreateCheckBox(318, 347, 121, 16, "Show simple panel", true, false, panel)
a = guiCreateLabel(9, 269, 248, 39, "Current Rank: " ..tostring(currentRank), false, panel)
b = guiCreateLabel(10, 307, 215, 40, "Current Points: " ..tostring(pass), false, panel)

info = guiCreateWindow(494, 149, 273, 308, "Job info", false)
guiWindowSetSizable(info, false)
guiSetVisible ( info, false )
memo = guiCreateMemo(9, 30, 254, 238, "As Rescuer Man, you have missions.\nMissions are rescuing drown people on the sea, currently only Los Santos.\n\n When you spawn a boat a blip will appears on your map, you have to go there to pick up the drown guy,  the voice system will tells you where to go.\n\n You can disable the voice system or the simple panel that appears under your HUD, on F5.", false, info)
clos = guiCreateButton(178, 272, 85, 26, "Close", false, info)
end
addEventHandler("onClientResourceStart", resourceRoot, resPanel)

addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName )
	if (getElementType ( source ) == "player") and (dataName == "Rank") then
		if source == localPlayer then
		currentRank = getElementData(localPlayer, "Rank")
		guiSetText(a, "Current Rank: " ..tostring(currentRank))
		end
	end
end)

function showDXt()
	local occc = exports.server:getPlayerOccupation(localPlayer)
	if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( localPlayer ) ) == "Civilian Workers") then
local playerVehicle = getPedOccupiedVehicle ( localPlayer )
	if playerVehicle and ( getElementModel ( playerVehicle) == 472 ) then
		pass = getElementData(localPlayer, "rescuer")
		guiSetText(b, "Current Points: " ..tostring(pass))
        dxDrawRectangle(1077, 189, 252, 175, tocolor(51, 51, 50, 171), true)
        dxDrawText("Time left:                " ..tostring(timee), 1086, 204, 1153, 229, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        dxDrawText("Money earned:             " ..tostring(money).. "$", 1085, 251, 1153, 280, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        dxDrawText("People rescued:           " ..tostring(pass), 1085, 307, 1151, 340, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, true, false, false)
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
    end
end
addEventHandler ("onClientVehicleExit", getRootElement(), hideDX)

local RescuerLocations = {
[1]={ 170.98 ,-2422.04 ,-0.56 },
[2]={ 153.51 ,-2612.05 ,-0.56},
[3]={ 175.74 ,-2606.12 ,-0.21 },
[4]={ 305.77 ,-2608.96 ,-0.56 },
[5]={ 305.07 ,-2536.87 ,-0.39 },
[6]={ 443 ,-2519.46 ,-0.56 },
[7]={ 430.58 ,-2613.17 ,-0.56 },
[8]={ 586.75 ,-2585.64 ,-0.56 },
[9]={ 570.76 ,-2505.61 ,-0.52 },
[10]={ 668.81 ,-2415.14 ,-0.28 },
[11]={ 668.52 ,-2568.22 ,-0.56 },
[12]={ 541.37 ,-2668.3 ,-0.56 },
[13]={ 541.17 ,-2668.42 ,-0.45 },
[14]={ 472.68 ,-2714.36 ,-0.4 },
[15]={ 436.46 ,-2758.92 ,-0.31 },
[16]={ 334.1 ,-2742.74 ,-0.56 },
[17]={ 258.35 ,-2737.31 ,-0.81 },
[18]={ 272.33 ,-2781.64 ,-0.56 },
[19]={ 321.81 ,-2752.86 ,-0.66 },
[20]={ 531.91 ,-2690.15 ,-0.21 },
[21]={ 430.91 ,-2030.58 ,-0.21 },
[22]={ 317.88 ,-2276.54 ,-0.21 },
[23]={ 218.42 ,-2332.18 ,-0.3 },
[24]={ 215.01 ,-2448.52 ,-0.35 },
[25]={ 207.5 ,-2264.21 ,-0.63 }
}

local dropoffs = {
[1]={ 267.28, -1908.23, -0.56  },
[2]={ 350.86, -1913.29, -0.37 },
[3]={ 405.25, -1915.08, -0.56 },
[4]={ 468.08, -1904.69, -0.57  },
[5]={ 545.63, -1920.09, -0.56 },
[6]={ 623.67, -1926.33, -0.56},
[7]={ 678.44, -1930.2, -0.56}
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
[13]={ 295 }
}

function startJob ( thePlayer)
if thePlayer == getLocalPlayer() then
local occc = exports.server:getPlayerOccupation(thePlayer)
if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
	local x, y, z = getElementPosition ( thePlayer )
	local playerVehicle = getPedOccupiedVehicle ( thePlayer )
	if ( getElementModel ( playerVehicle ) == 472 ) then
		pass = getElementData(thePlayer, "rescuer")
		if not playerClients[ thePlayer ] then
			local numLocations = #RescuerLocations
			if ( numLocations > 0 ) then
				repeatCount = 0
				repeat
					pickupx, pickupy, pickupz = unpack ( RescuerLocations [ math.random ( #RescuerLocations ) ] )
					local jobDistance = getDistanceBetweenPoints3D ( x, y, z, pickupx, pickupy, pickupz )
					repeatCount = repeatCount+1
				until jobDistance > 10 and jobDistance < 20 + repeatCount*100
				if  playerVehicle  then
					local skins = unpack ( vipSkins [ math.random ( #vipSkins ) ] )
					ped = createPed( skins, pickupx, pickupy, pickupz ) 
					
					function stopDamage(attacker, weapon, bodypart)
						cancelEvent()
					end
					addEventHandler("onClientPedDamage", ped, stopDamage)
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
				exports.dendxmsg:createNewDxMessage("Someone is drown! Go rescue him at " ..loc.. ", " ..cityy,0, 255, 0)
				if guiCheckBoxGetSelected(Voice) == true then
					triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Someone is drown! Go rescue him",true)
				end
				jobDistance = getDistanceBetweenPoints3D ( x, y, z, pickupx, pickupy, pickupz )
				timee = round(jobDistance/2)
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
				end , 1000,	tonumber(timee))
			else
				exports.dendxmsg:createNewDxMessage("No one is drown, re-enter your vehicle",0, 255, 0)
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
if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
    if playerClients[ thePlayer ] then
        for k, ped in pairs( playerClients[ thePlayer ] ) do
            if ped then
                local x,y,z     = getElementPosition(ped)
                local tx,ty,tz  = getElementPosition(thePlayer)
                setPedRotation(ped, findRotation(x,y,tx,ty) )
                local numLocations = #dropoffs
                if ( numLocations > 0 ) then
				local playerVehicle = getPedOccupiedVehicle ( thePlayer )
                    if playerVehicle and Rescuers[getElementModel ( playerVehicle )] then
                        local speedx, speedy, speedz = getElementVelocity ( thePlayer )
                        local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
                        if actualspeed < 0.25 then
									setElementFrozen ( playerVehicle, true )
									fadeCamera ( false, 1.0, 0, 0, 0 )  
									setTimer ( fadeCamera, 3000, 1,  true, 0.5 )
									setElementFrozen ( playerVehicle, false)
									attachElements ( ped, playerVehicle, 0, -1, 1 )
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
                                        dropOffx, dropOffy, dropOffz = unpack ( dropoffs [ math.random ( #dropoffs ) ] )
                                        local jobDistance = getDistanceBetweenPoints3D ( x, y, z, dropOffx, dropOffy, dropOffz )
                                    until jobDistance > 200 and jobDistance < 3000
 
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
										if guiCheckBoxGetSelected(Voice) == true then
										triggerServerEvent("CSGLimoDriverSayVoice",localPlayer,"Good Job! Now take him to " ..loc,true)
										end
									exports.dendxmsg:createNewDxMessage(playerSource,"Good Job! Now take him to " ..loc.. ", " ..cityy,0, 255, 0)
                        else
							exports.dendxmsg:createNewDxMessage("Slow down to pick up him!",230, 25, 0)
                        end
                    else
						exports.dendxmsg:createNewDxMessage("You don't have the correct boat",255,0, 0)
                    end
                else
					exports.dendxmsg:createNewDxMessage("No one is drown, re-enter your vehicle",255, 0, 0)
                 end
            end
        end
    end
end
end


function arriveDropOff ( thePlayer )
if thePlayer == getLocalPlayer() then
local occc = exports.server:getPlayerOccupation(thePlayer)
if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
    if playerClients[ thePlayer ] then
        for k, ped in pairs( playerClients[ thePlayer ] ) do
            if ped then
				local playerVehicle = getPedOccupiedVehicle ( thePlayer )
                if playerVehicle and Rescuers[getElementModel ( playerVehicle )] then
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
									rankBonus = 100
								elseif tonumber(pass) >= 15 and tonumber(pass) < 50 then
									rankBonus = 250
								elseif tonumber(pass) >= 50 and tonumber(pass) < 150 then
									rankBonus = 500
								elseif tonumber(pass) >= 150 and tonumber(pass) < 250 then
									rankBonus = 1000
								elseif tonumber(pass) >= 250 and tonumber(pass) < 350 then
									rankBonus = 1500
								elseif tonumber(pass) >= 350 and tonumber(pass) < 500 then
									rankBonus = 2000
								elseif tonumber(pass) >= 500 then
									rankBonus = 2500
								end	
								
								guiSetText(b, "Current Points: " ..tostring(pass))
								
								local tx,ty,tz  = getElementPosition(thePlayer)
								local jobDistance = getDistanceBetweenPoints3D ( dx, dy, dz, tx, ty, tz )             
								local jobDistanceKM = round(jobDistance)
								local jobReward = rankBonus + round(1000+(jobDistanceKM/2))
								 
								for k, jobLocation in pairs( playerJobLocation[ thePlayer ] ) do
									if jobLocation then
										playerJobLocation[ thePlayer ] = nil
									end
								end
								
								triggerServerEvent("giveRescuerMoney", getLocalPlayer(),  jobReward )
								
								setElementData(thePlayer, "rescuer", tostring(pass))
								
								money = money + jobReward
								triggerServerEvent("giveRescuerScore", getLocalPlayer(), 0.5)
								if guiCheckBoxGetSelected(Voice) == true then
									triggerServerEvent("rescuerManVoice",localPlayer,"Job succesful, you earned "..jobReward.."$ +0.5 score",true)
								end
								exports.dendxmsg:createNewDxMessage("Job succesful, you earned "..jobReward.."$ +0.5 score",0, 255, 0)
								exports.CSGgps:resetDestination()
								sound()
								setTimer(startJob, 6000, 1, thePlayer )
								
								if pass == 1 then
								triggerServerEvent("giveRescuerMoney", getLocalPlayer(),  3000 )
								triggerServerEvent("giveRescuerScore", getLocalPlayer(), 1)
								if guiCheckBoxGetSelected(Voice) == true then
									triggerServerEvent("rescuerManVoice",localPlayer,"Congratulation! You finished your first mission! 3k + 1 score bonus",true)
								end
								exports.dendxmsg:createNewDxMessage("Congratulation! You finished your first mission! 3k + 1 score bonus",0, 255, 0)
								elseif pass == 15 then
								triggerServerEvent("giveRescuerMoney", getLocalPlayer(),  3000 )
								triggerServerEvent("giveRescuerScore", getLocalPlayer(), 1)
								if guiCheckBoxGetSelected(Voice) == true then
									triggerServerEvent("rescuerManVoice",localPlayer,"Congratulation! You got promoted to New Rescuer Man! 3k + 1 score bonus",true)
								end
								exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to New Rescuer Man! 3k + 1 score bonus",0, 255, 0)
								elseif pass == 50 then
								triggerServerEvent("giveRescuerMoney", getLocalPlayer(),  3000 )
								triggerServerEvent("giveRescuerScore", getLocalPlayer(), 1)
								if guiCheckBoxGetSelected(Voice) == true then
									triggerServerEvent("rescuerManVoice",localPlayer,"Congratulation! You got promoted to Trained Rescuer Man! 3k + 1 score bonus",true)
								end
								exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to Trained Rescuer Man! 3k + 1 score bonus",0, 255, 0)
								elseif pass == 150 then
								triggerServerEvent("giveRescuerMoney", getLocalPlayer(),  5000 )
								triggerServerEvent("giveRescuerScore", getLocalPlayer(), 3)
								if guiCheckBoxGetSelected(Voice) == true then
									triggerServerEvent("rescuerManVoice",localPlayer,"Congratulation! You got promoted to Experienced Rescuer Man! 5k + 3 score bonus",true)
								end
								exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to Experienced Rescuer Man! 5k + 3 score bonus",0, 255, 0)
								elseif pass == 250 then 
								triggerServerEvent("giveRescuerMoney", getLocalPlayer(),  5000 )
								triggerServerEvent("giveRescuerScore", getLocalPlayer(), 3)
								if guiCheckBoxGetSelected(Voice) == true then
									triggerServerEvent("rescuerManVoice",localPlayer,"Congratulation! You got promoted to Senior Rescuer Man! 5k + 3 score bonus",true)
								end
								exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to Senior Rescuer Man! 5k + 3 score bonus",0, 255, 0)
								elseif pass == 350 then 
								triggerServerEvent("giveRescuerMoney", getLocalPlayer(),  10000 )
								triggerServerEvent("giveRescuerScore", getLocalPlayer(), 3)
								if guiCheckBoxGetSelected(Voice) == true then
									triggerServerEvent("rescuerManVoice",localPlayer,"Congratulation! You got promoted to Lead Rescuer Man! 10k + 3 score bonus",true)
								end
								exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to Lead Rescuer Man! 10k + 3 score bonus",0, 255, 0)
								elseif pass == 500 then 
								triggerServerEvent("giveRescuerMoney", getLocalPlayer(),  20000 )
								triggerServerEvent("giveRescuerScore", getLocalPlayer(), 5)
								if guiCheckBoxGetSelected(Voice) == true then
									triggerServerEvent("rescuerManVoice",localPlayer,"Congratulation! You got promoted to Head Rescuer Man! 20k + 5 score bonus",true)
								end
								exports.dendxmsg:createNewDxMessage("Congratulation! You got promoted to Head Rescuer Man! 20k + 5 score bonus",0, 255, 0)
								end
							end
						else
						exports.dendxmsg:createNewDxMessage("Slow down to drop him",255, 255, 0)
						end
				else
				exports.dendxmsg:createNewDxMessage("You don't have the correct boat!",255, 0, 0)
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
		if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
			if playerClients[ thePlayer ] then
				setElementData(thePlayer, "rescuer", tostring(pass))
				if isTimer(tmr) then killTimer(tmr) end
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


function hideGUI()
	if source == close then
	guiSetVisible(panel,false)
	showCursor(false)
	end
end
addEventHandler("onClientGUIClick", root, hideGUI)

--job info
 

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
if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( localPlayer ) ) == "Civilian Workers") then
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


function sayVoice(str)

	local x,y,z = getElementPosition(localPlayer)
	currentVoice = playSound(str,x,y,z)
end
addEvent("rescuerManVoiceClient",true)
addEventHandler("rescuerManVoiceClient",localPlayer,sayVoice)

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


if fileExists("Rescuer_c.lua") == true then
	fileDelete("Rescuer_c.lua")
end
