-- Hospitals
local hospitalTable = {
	{ "Los Santos All Saints hospital", 1179.1, -1324.4, 14.15, 270.12222290039, 1215.4975585938, -1343.1850585938, 35.528800964355, 1214.7266845703, -1342.7204589844, 35.093036651611, 0, 70 },
	{ "Los Santos Country Central hospital", 2030.31, -1406.77, 17.2, 178.76403808594, 2012.4608154297, -1440.1544189453, 33.239101409912, 2012.8569335938, -1439.3461914063, 32.803337097168, 0, 70 },
	{ "Los Santos Crippen Memorial hospital", 1245.22, 334.22, 19.55, 335.55230712891, 1275.6314697266, 348.43908691406, 37.013999938965, 1274.9337158203, 347.95013427734, 36.490543365479, 0, 7 },
	{ "Las Venturas Fort Carson hospital", -319.24, 1057.76, 19.74, 343.53948974609, -307.31741333008, 1085.3322753906, 37.267700195313, -307.63153076172, 1084.5151367188, 36.784400939941, 0, 70 },
	{ "Las Venturas General hospital", 1607.87, 1823, 10.82, 1.5188903808594, 1631.53125, 1867.3415527344, 25.293199539185, 1631.1346435547, 1866.4654541016, 25.018928527832, 0, 70 },
	{ "Las Venturas El Quebrados hospital", -1514.85, 2528.23, 55.72, 358.66787719727, -1499.2265625, 2558.5263671875, 66.142501831055, -1499.6668701172, 2557.7001953125, 65.791000366211, 0, 70 },
	{ "San Fierro General hospital", -2647.62, 631.2, 14.45, 176.91278076172, -2627.0493164063, 582.10327148438, 28.898700714111, -2627.5827636719, 582.89117431641, 28.591079711914, 0, 70 },
	{ "San Fierro Angel pine hospital", -2199.24, -2310.78, 30.62, 319.53399658203, -2178.7451171875, -2288.4621582031, 41.820098876953, -2179.4353027344, -2289.0139160156, 41.352130889893, 0, 70 }
}

-- Event triggerd when the player dies
addEventHandler ( "onClientPlayerWasted", localPlayer, 
function ()
	if not ( getElementHealth( localPlayer ) > 0 ) then
		local hospitalDist = false
		local nearestHospital = false
		for i=1,#hospitalTable do
			local px, py, pz = getElementPosition( localPlayer )
			local hx, hy, hz = hospitalTable[i][2], hospitalTable[i][3], hospitalTable[i][4]
			local distance = getDistanceBetweenPoints3D ( px, py, pz, hx, hy, hz )
			if not ( hospitalDist ) or ( distance < hospitalDist ) then
				hospitalDist = distance
				nearestHospital = i
			end
		end
		
		if ( nearestHospital ) then
			local ID = nearestHospital
			local hx, hy, hz, rotation, hospitalName = hospitalTable[ID][2], hospitalTable[ID][3], hospitalTable[ID][4], hospitalTable[ID][5], hospitalTable[ID][1]
			local mx, my, mz, lx, ly, lz = hospitalTable[ID][6], hospitalTable[ID][7], hospitalTable[ID][8], hospitalTable[ID][9], hospitalTable[ID][10], hospitalTable[ID][11]
			setTimer( function () triggerServerEvent( "respawnDeadPlayer", localPlayer, hx, hy, hz, rotation, mx, my, mz, lx, ly, lz, hospitalName ) end, 4000, 1 )
		end
		
		-- Spawn protection
		setTimer(
			function ()
				setElementData( localPlayer, "spawnProtection", true )
				toggleControl ( "fire", false )
				toggleControl ( "next_weapon", false )
				toggleControl ( "previous_weapon", false )
				setPlayerCollidable ( localPlayer, false )
				setElementAlpha( localPlayer, 170 )
				
				setTimer( setElementData, 15000, 1, localPlayer, "spawnProtection", false )
				setTimer( toggleControl, 15000, 1, "fire", true )
				setTimer( toggleControl, 15000, 1, "next_weapon", true )
				setTimer( toggleControl, 15000, 1, "previous_weapon", true )
				setTimer( setPlayerCollidable, 15000, 1, localPlayer, true )
				setTimer( setElementAlpha, 15000, 1, localPlayer, 255)
			end, 9000, 1 
		)
	end
end
)

-- Set the element colidable with other players
function setPlayerCollidable ( thePlayer, state )
	if not ( state ) then state = false end
	for k, i in ipairs ( getElementsByType( "player" ) ) do
		setElementCollidableWith( i, thePlayer, state )
	end
end

-- Spawn protection damage control
addEventHandler( "onClientPlayerDamage", root,
function()
	if ( getElementData( localPlayer, "spawnProtection" ) ) then
		cancelEvent()
	end
end
)

-- Show the AFK window
addEvent( "onClientShowAFK", true )
addEventHandler( "onClientShowAFK", root,
	function ( state ) 
		if ( state ) then
			addEventHandler( "onClientRender", root, onDrawAFKWindow )
		else
			removeEventHandler( "onClientRender", root, onDrawAFKWindow )
		end
	end
)

local sx,sy = guiGetScreenSize()

-- Draw the AFK window
function onDrawAFKWindow ()
	if ( sx == 1152 ) and ( sy == 864 ) then scale = 1.2 elseif ( sx == 1024 ) and ( sy == 768 ) then scale = 1.1 elseif ( sx <= 800 ) and ( sy <= 600 ) then scale = 1.0 else scale = 1.3 end
	dxDrawRectangle(sx*(342.0/1440),sy*(392.0/900),sx*(789.0/1440),sy*(41.0/900),tocolor(0,0,0,180),false)
    dxDrawText("You where AFK while spawning and moved to another dimension. Move to get back in the normal world.",sx*(355.0/1440),sy*(402.0/900),sx*(1124.0/1440),sy*(424.0/900),tocolor(225,0,0,225),scale,"default","left","top",false,false,false)
end