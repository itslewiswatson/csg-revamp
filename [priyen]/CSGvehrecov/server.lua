    local ca3 = { { 0, 0, 3 }, { 0, 0, 3 }, { 0, 0, 3 }, { 0, 0, 3 } }
     
    local marker = {
        { 2795, -2456.76171875, 12.9 },
		{ -2751.3845214844, 205, 7.0088057518005 },
		
    }
     
    local vehicle_ = {}
    local blip = {}
    local rand = {}
    local Markers = {}
     
    function CreatCarRandom ()
        rand.random = ca3[math.random(#ca3)]
		vehicle_.car = createVehicle(482, 1969.2115478516, 2729.0832519531, 10.8)
		blip.blip1Car = createBlipAttachedTo(vehicle_.car, 53)
        outputChatBox("#ff000f automobile has been requsted and placed on your map , get it first !!", root, 255, 255, 255, true)
    end
    addEventHandler("onResourceStart", root, CreatCarRandom)
     
    function CreatCar2 ()
        rand.random = ca3[math.random(#ca3)]
		vehicle_.car = createVehicle(482, -282, 2661.2211914063, 62)
		blip.blip1Car = createBlipAttachedTo(vehicle_.car, 53)
        outputChatBox("#ff000f automobile has been requsted and placed on your map , get it first !!", root, 255, 255, 255, true)
    end
	 
    addEventHandler("onPlayerVehicleEnter", root,
        function(vehicle)
            if(isElement(vehicle_.car))then
                if (vehicle == vehicle_.car) then  
                    local x,y,z = unpack(marker[math.random(#marker)])
                    Markers.Marker = createMarker(x, y, z, "cylinder", 5, 255, 0, 0, 70)
                    blip.blipCar2 = createBlipAttachedTo(Markers.Marker, 51)
                    setElementVisibleTo(Markers.Marker, root, false)
                    setElementVisibleTo(Markers.Marker, source, true)
                end
            end
        end
    )
       
    addEventHandler( "onMarkerHit", root,
        function(hitElement)
            if ( getElementType( hitElement ) == "player" ) then
                if( isPedInVehicle( hitElement ) )then
                    givePlayerMoney ( hitElement, math.random(3000,4000) )
                    for i,v in pairs(vehicle_) do
                        destroyElement(v)
                    end
                    for i,v in pairs(Markers) do
                        destroyElement(v)
                    end
                    for i,v in pairs(blip) do
                        destroyElement(v)
                    end
                    CreatCar2 ()           
                end
            end
        end
		
    )
 
    addEventHandler("onPlayerVehicleExit", root,
        function(vehicle)
            if( isElement( vehicle_.car ) )then
                if( vehicle == vehicle_.car )then
                    for i,v in pairs(Markers) do
                        destroyElement(v)
                    end
                    for i,v in pairs(blip) do
                        destroyElement(v)
                end
            end
        end
		end
    )