

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
    function()
		taxiSkins = { [20]=true }
		taxis = { [420]=true, [438]=true }
		playerClients = { }
		playerCols = { }
		playerBlips = { }
		jobClients = { }
		playerJobLocation = {  };
		local XMLTaxiLocations = xmlLoadFile ( "taxi_locations.xml" )
		if ( not XMLTaxiLocations ) then
			local XMLTaxiLocations = xmlCreateFile ( "taxi_locations.xml", "taxi_locations" )
			xmlSaveFile ( XMLTaxiLocations )
		end

		local taxi_locations = xmlNodeGetChildren(XMLTaxiLocations)
        taxiLocations = {}
        for i,node in ipairs(taxi_locations) do
			taxiLocations[i] = {}
			taxiLocations[i]["x"] = xmlNodeGetAttribute ( node, "posX" )
			taxiLocations[i]["y"] = xmlNodeGetAttribute ( node, "posY" )
			taxiLocations[i]["z"] = xmlNodeGetAttribute ( node, "posZ" )
			taxiLocations[i]["r"] = xmlNodeGetAttribute ( node, "rot" )
        end
        xmlUnloadFile ( XMLTaxiLocations )
    end
)

--function enterVehicle ( thePlayer, seat, jacked )
 --   if ( taxis[getElementModel ( source )] ) and ( not taxiSkins[getElementModel ( thePlayer )] ) and (seat == 0) then
	--	cancelEvent()
--
 --   end
--end
--addEventHandler ( "onVehicleStartEnter", getRootElement(), enterVehicle )

function taxipick ( playerSource )
	local x, y, z = getElementPosition ( playerSource )
	if ( taxiSkins[getElementModel ( playerSource )] ) then
		if not playerClients[ playerSource ] then
			local numLocations = #taxiLocations
			if ( numLocations > 0 ) then
				repeatCount = 0;
				repeat
					local pickupPoint = math.random(numLocations)
					pickupx = taxiLocations[pickupPoint]["x"]
					pickupy = taxiLocations[pickupPoint]["y"]
					pickupz = taxiLocations[pickupPoint]["z"]
					pickupr = taxiLocations[pickupPoint]["r"]
					local jobDistance = getDistanceBetweenPoints3D ( x, y, z, pickupx, pickupy, pickupz );
					repeatCount = repeatCount+1
				until jobDistance > 100 and jobDistance < 800 + repeatCount*100

				repeat
					local id = math.random( 10, 270 )
					ped = createPed( tonumber( id ), pickupx, pickupy, pickupz )
					setPedRotation ( ped, pickupr )
				until ped

				playerClients[ playerSource ] = {  };
				table.insert( playerClients[ playerSource ], ped );
				table.insert( jobClients, ped );

				local pedBlip = createBlipAttachedTo ( ped, 61, 2, 255, 0, 0, 255, 1, 99999.0, playerSource)
				playerBlips[ playerSource ] = {  };
				table.insert( playerBlips[ playerSource ], pedBlip );
				exports.DENdxmsg:createNewDxMessage(playerSource,"Go to the person blip on your map to pickup a passenger",0,255,0)
				pedMarker = createMarker ( pickupx, pickupy, pickupz, "arrow", 4, 0, 255, 0, 200, playerSource)
				playerCols[ playerSource ] = {  };
				table.insert( playerCols[ playerSource ], pedMarker );
				addEventHandler( "onMarkerHit", pedMarker, arrivePickup )
			end
			end
	end
end
addCommandHandler ("ped", taxipick);

function arrivePickup ( playerSource )
	if playerClients[ playerSource ] then
		for k, ped in pairs( playerClients[ playerSource ] ) do
			if ped then
				local x,y,z 	= getElementPosition(ped);
				local tx,ty,tz 	= getElementPosition(playerSource);
				setPedRotation(ped, findRotation(x,y,tx,ty) );
				local numLocations = #taxiLocations
				if ( numLocations > 0 ) then
					local playerVehicle = getPedOccupiedVehicle ( playerSource );
					if playerVehicle and taxis[getElementModel ( playerVehicle )] then
						local speedx, speedy, speedz = getElementVelocity ( playerSource );
						local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5);
						if actualspeed < 0.25 then
							local occupants = getVehicleOccupants(playerVehicle);
							local seats = getVehicleMaxPassengers(playerVehicle);
							local freeSeats = 0;
							for seat = 0, seats do
								local occupant = occupants[seat];
								if not occupant and tonumber(freeSeats) == 0 then
									freeSeats = freeSeats + 1;
									warpPedIntoVehicle ( ped, playerVehicle, seat );
									if playerBlips[ playerSource ] then
										for k, blip in pairs( playerBlips[ playerSource ] ) do
											if blip then
												destroyElement( blip );
												playerBlips[ playerSource ] = nil;
											end
										end
									end
									if playerCols[ playerSource ] then
										for k, col in pairs( playerCols[ playerSource ] ) do
											if col then
												destroyElement( col );
												playerCols[ playerSource ] = nil;
											end
										end
									end

									playerJobLocation[ playerSource ] = {  };
									playerJobLocation[ playerSource ] = { ["x"]=x, ["y"]=y, ["z"]=z };

									repeat
										local dropOffPoint = math.random(numLocations)
										dropOffx = taxiLocations[dropOffPoint]["x"]
										dropOffy = taxiLocations[dropOffPoint]["y"]
										dropOffz = taxiLocations[dropOffPoint]["z"]
										local jobDistance = getDistanceBetweenPoints3D ( x, y, z, dropOffx, dropOffy, dropOffz );
									until jobDistance > 1000 and jobDistance < 35000

									local dropOffBlip = createBlip ( dropOffx, dropOffy, dropOffz, 0, 4, 0, 255, 0, 255, 1, 9999999.0, playerSource)
									playerBlips[ playerSource ] = {  };
									table.insert( playerBlips[ playerSource ], dropOffBlip );
									exports.DENdxmsg:createNewDxMessage(playerSource,"Take this passenger to the big green blip on your map",0,255,0)
									exports.DENdxmsg:createNewDxMessage(playerSource,"If you do not see the destination, press F11 for a big map view",0,255,0)
									  pedMarker = createMarker ( dropOffx, dropOffy, dropOffz, "corona", 4, 255, 0, 0, 200, playerSource)
									playerCols[ playerSource ] = {  };
									table.insert( playerCols[ playerSource ], pedMarker );
									addEventHandler( "onMarkerHit", pedMarker, arriveDropOff )

							end
							if tonumber(freeSeats) == 0 then
end
end
end
				end
			end
		end
	end
end
end

function arriveDropOff ( playerSource )
	if playerClients[ playerSource ] then
		for k, ped in pairs( playerClients[ playerSource ] ) do
			if ped then
				local pedVehicle = getPedOccupiedVehicle ( ped );
				local playerVehicle = getPedOccupiedVehicle ( playerSource );
				if playerVehicle and taxis[getElementModel ( playerVehicle )] then
					if pedVehicle == playerVehicle then
						local speedx, speedy, speedz = getElementVelocity ( playerSource );
						local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5);
						if actualspeed < 0.22 then
							removePedFromVehicle ( ped );
							if playerClients[ playerSource ] then
								for k, ped in pairs( playerClients[ playerSource ] ) do
									if ped then
										destroyElement( ped );
										playerClients[ playerSource ] = nil;
									end
								end
								for k, blip in pairs( playerBlips[ playerSource ] ) do
									if blip then
										destroyElement( blip );
										playerBlips[ playerSource ] = nil;
									end
								end
								for k, col in pairs( playerCols[ playerSource ] ) do
									if col then
										destroyElement( col );
										playerCols[ playerSource ] = nil;
									end
								end
								dx = tonumber(playerJobLocation[ playerSource ]["x"]);
								dy = tonumber(playerJobLocation[ playerSource ]["y"]);
								dz = tonumber(playerJobLocation[ playerSource ]["z"]);
								local tx,ty,tz 	= getElementPosition(playerSource);
								local jobDistance = getDistanceBetweenPoints3D ( dx, dy, dz, tx, ty, tz );
								local jobDistanceKM = round(jobDistance/2000,3);
								local jobReward = round(600+(jobDistanceKM^3)*60);
								givePlayerMoney ( playerSource, jobReward );
								exports.DENdxmsg:createNewDxMessage(playerSource,"Successfull : Earned $"..jobReward.."",0,255,0)
								for k, jobLocation in pairs( playerJobLocation[ playerSource ] ) do
									if jobLocation then
										playerJobLocation[ playerSource ] = nil;
									end
								end
								end
								end
								end
				end
			end
		end
	end
end

function quitJob ( playerSource )
	if playerClients[ playerSource ] then
		for k, ped in pairs( playerClients[ playerSource ] ) do
			if ped then
				destroyElement( ped );
				playerClients[ playerSource ] = nil;
			end
		end
		for k, blip in pairs( playerBlips[ playerSource ] ) do
			if blip then
				destroyElement( blip );
				playerBlips[ playerSource ] = nil;
			end
		end
		for k, col in pairs( playerCols[ playerSource ] ) do
			if col then
				destroyElement( col );
				playerCols[ playerSource ] = nil;
			end
		end
		if playerJobLocation[ playerSource ] then
			for k, jobLocation in pairs( playerJobLocation[ playerSource ] ) do
				if jobLocation then
					destroyElement( jobLocation );
					playerJobLocation[ playerSource ] = nil;
				end
			end
		end
end
	end
addCommandHandler ("delped", quitJob)

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if oldJob == "Taxi Driver" then
		quitJob(source)
	elseif nJob == "Taxi Driver" then
		--newJob(source)
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)


function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end;
	return t;
end

function round(number, digits)
  local mult = 10^(digits or 0)
  return math.floor(number * mult + 0.5) / mult
end
