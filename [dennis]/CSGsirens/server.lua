addEventHandler( "onVehicleEnter", root,
	function ( thePlayer, theSeat )
		if ( theSeat == 0 ) then
			if ( getElementModel( source ) == 415 )  and ( getPlayerTeam( thePlayer ) ) then
				if ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Police" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Staff" ) then
					-- Police cheetah
					addVehicleSirens ( source, 2, 3, true, false, true, false ) 
					-- Left top
					setVehicleSirens ( source, 1, -0.400, 0.000, 0.549, 255, 0, 0, 65, 65 )
					-- Right top
					setVehicleSirens ( source, 2, 0.400, 0.000, 0.549, 0, 0, 255, 65, 65 )
					exports.DENdxmsg:createNewDxMessage( thePlayer, "This vehicle has custom sirens! Press 'H' to enable them.", 0, 225, 0 )
				end
			elseif ( getElementModel( source ) == 426 ) and ( getPlayerTeam( thePlayer ) ) then
				if ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Police" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Staff" ) then
					-- Police premier
					addVehicleSirens ( source, 2, 3, true, false, true, false ) 
					-- Left top
					setVehicleSirens ( source, 1, -0.602, 0.200, 0.800, 255, 0, 0, 65, 65 )
					-- Right top
					setVehicleSirens ( source, 2, 0.500, 0.200, 0.800, 0, 0, 255, 65, 65 )
					exports.DENdxmsg:createNewDxMessage( thePlayer, "This vehicle has custom sirens! Press 'H' to enable them.", 0, 225, 0 )
				end
			elseif ( getElementModel( source ) == 525 ) then
				addVehicleSirens ( source, 2, 2, true, false, false, true ) 
				-- Left top
				setVehicleSirens ( source, 1, 0.600, -0.500, 1.500, 238, 154, 0, 95, 97 )
				-- Right top
				setVehicleSirens ( source, 2, -0.600, -0.500, 1.500, 238, 154, 0, 95, 97 )
				exports.DENdxmsg:createNewDxMessage( thePlayer, "This vehicle has custom sirens! Press 'H' to enable them.", 0, 225, 0 )
			elseif ( getElementModel( source ) == 574 ) then
				addVehicleSirens ( source, 2, 2, true, false, false, true ) 
				-- Left top
				setVehicleSirens ( source, 1, 0.300, 0.500, 1.400, 238, 154, 0, 44, 44 )
				-- Right top
				setVehicleSirens ( source, 2, -0.300, 0.500, 1.400, 238, 154, 0, 44, 44 )
				exports.DENdxmsg:createNewDxMessage( thePlayer, "This vehicle has custom sirens! Press 'H' to enable them.", 0, 225, 0 )
			elseif ( getElementModel( source ) == 485 ) then
				addVehicleSirens ( source, 1, 2, true, false, true, true ) 
				-- Top light
				setVehicleSirens ( source, 1, 0.500, -1.100, 1.100, 238, 154, 0, 54, 54 )
				exports.DENdxmsg:createNewDxMessage( thePlayer, "This vehicle has custom sirens! Press 'H' to enable them.", 0, 225, 0 )
			elseif ( getElementModel( source ) == 428 ) then
				addVehicleSirens ( source, 4, 2, true, false, true, true ) 
				-- Top left front
				setVehicleSirens ( source, 1, -1.100, 1.400, 1.300, 238, 154, 0, 62, 62 )
				-- Top right front
				setVehicleSirens ( source, 2, 0.900, 1.400, 1.300, 238, 154, 0, 62, 62 )
				-- Top left back
				setVehicleSirens ( source, 3, 0.900, -3.000, 1.400, 238, 154, 0, 62, 62 )
				-- Top right back
				setVehicleSirens ( source, 4, -1.000, -3.000, 1.400, 238, 154, 0, 62, 62 )
				exports.DENdxmsg:createNewDxMessage( thePlayer, "This vehicle has custom sirens! Press 'H' to enable them.", 0, 225, 0 )
			end
		end
	end
)