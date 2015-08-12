 ----------------------------------------------------------------------------------------------------------------------------------
    --Tug TABLE
    ----------------------------------------------------------------------------------------------------------------------------------
    local tugTable = {
    [1]={1733, -2245.0244140625, -2.3},
    [2]={1642, -2330.1755371094, -2.3},
    [3]={1640, -2330.1293945313, 12.8},
    [4]={1730, -2244.5991210938, 12.8},
    [5]={1506, -2361.099609375, 13},
    [6]={1571, -2299.552734375, 13.8},
    [7]={1642, -2201.6306152344, 12.8},
    [8]={1729, -2371.5637207031, 12.8},

    }
    mark = {
    [1]={1892,-2256.9919433594,11.8},
    [2]={1894,-2342.236328125,11.8},
    [3]={1674,-2433.2919921875,11.8},
    [4]={2106,-2421.6901855469,11.8},
    [5]={1614,-2636.1843261719,11.8},
    [6]={1750,-2630.5576171875,11.8},
    [7]={1890,-2636.8181152344,11.8},
    [8]={1890,-2636.8181152344,11.8},

    }

    ----------------------------------------------------------------------------------------------------------------------------------
    markerrequest = createMarker(1646,-2247.5236816406,11.8,"cylinder",2, 225, 100, 0, 150 )

    ------------------------------

    --------------------------------
myveh=false
    --Reward
        addEventHandler("onClientMarkerHit",root,
        function (player)
        if (source == mar and player == localPlayer) and getElementData(player,"Occupation") == "Airport Attendant" and getTeamName(getPlayerTeam(player)) == "Civilian Workers" then
                if getElementModel ( player ) == 50 then
				if not getVehicleTowedByVehicle(myveh) then
						exports.DENdxmsg:createNewDxMessage ("Your tug does not have the bag carrier / trailer attached, you can't pickup the bug",255,0,0)
					return
				end
				local x,y,z = getElementPosition(player)
                local data = getElementData(mar,"num")
                local data = tonumber(data)
                destroyElement(mar)
                destroyElement(bag)
                destroyElement(blips)
                destroyElement(pedcargo)

                setElementData(player,"bag1",true)
				marker = createMarker(mark[area][1],mark[area][2],mark[area][3],"checkpoint",1.5,255,255,0,255,player)
				marBli = createBlipAttachedTo(marker,0,4,255,0,0,255,0,99999.0,player)
				bag1 = createPickup ( x, y, z, 0, 1210 )
				exports.bone_attach:attachElementToBone(bag1,player,12,0,0.05,0.27,0,180,0)
				exports.DENdxmsg:createNewDxMessage ("Picked up bag. Go to the red blip on your map and take it inside the airport",0,255,0)
            end
            end
            end )


    ----------------------------------------------------------------------------------------------------------------------------------
   addEventHandler("onClientMarkerHit",root,
        function (player)
        if (source == marker and player == localPlayer) and getElementData(player,"Occupation") == "Airport Attendant" and getTeamName(getPlayerTeam(player)) == "Civilian Workers" then
    	if isPedInVehicle(player)==false then return end
		    local theVehicle = getPedOccupiedVehicle (player)
    local id = getElementModel(theVehicle)
    if id == 485 then
                local x,y,z = getElementPosition(player)
                local data = getElementData(marker,"num")
                local data = tonumber(data)
                destroyElement(marker)
                destroyElement(marBli)
                destroyElement(bag1)
                setElementData(player,"bag1",true)
                triggerServerEvent("onShowMoney",localPlayer)
								setTimer ( TimerOfSpawn, 5000, 1 )

            end
            end
			end )
            -------------------------------

    ----------------------------------------------------------------------------------------------------------------------------------
    addEventHandler("onClientVehicleEnter",getRootElement(),
    function (player)
    if player ~= localPlayer then return end
    local boggo = getPedOccupiedVehicle (player)
    local id = getElementModel(boggo)
        if getElementModel(player) == 485 then
               exports.DENdxmsg:createNewDxMessage ("Go to pick cargo bag near airport, big blue blip",255,255,0)
end
    end)
    -----------------------------------------------------------------------------------------------------------------------------
      --          area = math.random ( 1, #tugTable )
--    x,y,z = unpack ( tugTable[area] )
  --  bag = createPickup ( x, y, z, 3, 1210 )
  --  local blips = createBlipAttachedTo(bag,19,2,10,235,250,225)
    -----------------------------------------------------------------------------------------------------------------------------
        addEventHandler ( "onClientMarkerHit", getRootElement(),
    function (player)
    if player ~= localPlayer or isPedInVehicle(player)==false then return end
    if getElementModel ( player ) == 50 then
    local theVehicle = getPedOccupiedVehicle (player)
    local id = getElementModel(theVehicle)
    if id == 485 then
    if ( source == markerrequest and getElementData(player,"Occupation") == "Airport Attendant" and getTeamName(getPlayerTeam(player)) == "Civilian Workers") then
    triggerServerEvent ( "CSGairportbag.trailer", localPlayer)
	   if isElement(bag) then destroyElement(bag) end
    if isElement(mar) then destroyElement(mar) end
    if isElement(blips) then destroyElement(blips) end
    if isElement(pedcargo) then destroyElement(pedcargo) end
    area = math.random ( 1, #tugTable )
    x,y,z = unpack ( tugTable[area] )
    bag = createPickup ( x, y, z, 3, 1210 )
     local id = math.random( 10, 250 )
	 pedcargo = createPed ( tonumber( id ), x, y-1, z, 0 )
    mar = createMarker (tugTable[area][1],tugTable[area][2],tugTable[area][3],"checkpoint",0.2,255,100,0,40)
    blips = createBlipAttachedTo(bag,0,4,10,235,250,225)
	myveh=getPedOccupiedVehicle(localPlayer)
	exports.DENdxmsg:createNewDxMessage ("Go pickup a bag at the big blue blip",0,255,0)
    end

    end
    end
	end )
    --------------------------
function spawnBag ()
        area = math.random ( 1, #tugTable )
        x,y,z = unpack ( tugTable[area] )
        bag = createPickup ( x, y, z, 3, 1210 )
		blips = createBlipAttachedTo(bag,0, 4,10,235,250,225)
		mar = createMarker (tugTable[area][1],tugTable[area][2],tugTable[area][3],"checkpoint",0.2,255,100,0,40)
		local id = math.random( 10, 250 )
	    pedcargo = createPed ( tonumber( id ), x+1, y, z, 0 )
		exports.DENdxmsg:createNewDxMessage ("Go pickup a bag at the big blue blip",0,255,0)
		end

		function TimerOfSpawn ()
        spawnBagTimer=setTimer ( spawnBag, 5000, 1 )
    end

  function kill(e)
    if isElement(e) then destroyElement(e) end
  end

  function destroy()

            if isTimer(spawnBagTimer) then killTimer(spawnBagTimer) end
             kill(marker)
                    kill(marBli)
                    kill(bag1)
                    kill(pedcargo)
                    kill(blips)
                    kill(mar)
                    kill(bag)
					setElementAlpha(markerrequest,0)
    end
  addEventHandler("onClientPlayerWasted",localPlayer,destroy)

 addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
    if oldJob == "Airport Attendant" then
        destroy()
	elseif nJob == "Airport Attendant" then
		setElementAlpha(markerrequest,100)
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)
setElementAlpha(markerrequest,0)
