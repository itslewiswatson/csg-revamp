-- Toggle the vehicle controls
function setVehicleControls ( state )
	toggleControl ( "vehicle_fire", state )
	toggleControl ( "vehicle_secondary_fire", state )
	toggleControl ( "vehicle_left", state )
	toggleControl ( "vehicle_right", state )
	toggleControl ( "steer_forward", state )
	toggleControl ( "steer_back", state )
	toggleControl ( "accelerate", state )
	toggleControl ( "brake_reverse", state )
end

-- On client render
addEventHandler("onClientPreRender", root,
	function ()
		for k, theVehicle in ipairs ( getElementsByType ( "vehicle" ) ) do
			if ( getElementData( theVehicle, "vehicleType" ) == "playerVehicle" ) and ( getElementHealth( theVehicle ) ) then
				if ( math.floor( getElementHealth( theVehicle ) ) <= 250 ) then
					setElementHealth( theVehicle, 250 )
					setVehicleDamageProof( theVehicle, true )
					setVehicleEngineState ( theVehicle, false )
					if ( getVehicleController( theVehicle ) == localPlayer ) then
						setVehicleControls ( false )
					end
				elseif ( math.floor( getElementHealth( theVehicle ) ) > 250 ) then
					if ( getVehicleController( theVehicle ) == localPlayer ) then
						setVehicleControls ( true )
					end
				end
			end
		end
	end
)

-- When player exist the vehicle
addEventHandler("onClientVehicleExit", root,
	function ( thePlayer )
		if ( thePlayer == localPlayer ) then
			setVehicleControls ( true )
		end
	end
)

-- When the player stats entering the vehicle
addEventHandler("onClientVehicleStartEnter", root,
	function ( thePlayer )
		if ( thePlayer == localPlayer ) then
			if ( math.floor( getElementHealth( source ) ) <= 250 ) then
				setVehicleControls ( false )
				setVehicleEngineState( source, false )
			end
		end
	end
)
