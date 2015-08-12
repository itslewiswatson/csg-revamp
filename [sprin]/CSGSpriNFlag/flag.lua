local pickupT = {
	{2577.3095703125, 2733.6640625, 10.8203125},
	{1498.7255859375, 721.623046875, 10.8203125},
	{1665.47265625, 1423.3603515625, 10.783618927002},
	{943.0888671875, 1733.2734375, 8.8515625},
	{1486.9326171875, 2773.982421875, 10.8203125},
	{2880.8017578125, 2523.0654296875, 10.8203125},
	{2318.6923828125, 1261.4091796875, 67.46875},
	{2617.1005859375, 717.099609375, 14.739588737488},
	{2193.6787109375, 1677.2421875, 12.3671875},
	{2476.1513671875, 1876.45703125, 10.315457344055},
	{1865.462890625, 2071.6962890625, 11.0625}
}

local deliverT = {
	{2630.802734375, 1824.3828125, 10.0234375},
	{2184.5078125, 2805.859375, 9.8203125},
	{1097.6328125, 1601.888671875, 11.546875},
	{1918.73828125, 664.7099609375, 13.2734375},
	{1087.7451171875, 1076.703125, 9.838157653809},
	{2182.9580078125, 1115.119140625, 11.6484375},
	{2451.8359375, 1223.9072265625, 9.8203125},
	{2329.740234375, 1436.3671875, 41.8203125},
	{1091.53515625, 2119.6787109375, 14.350400924683},
	{2005.9912109375, 2310.5322265625, 9.8203125},
	{2225.2021484375, 1964.65234375, 30.779651641846},
	{2026.419921875, 1916.4453125, 11.337824821472},
	{1383.40625, 2183.7421875, 10.0234375},
	{1418.59375, 2773.5654296875, 9.8203125},
	{2291.869140625, 2451.37109375, 9.8203125},
	{1704.822265625, 1025.646484375, 9.8203125},
	{1600.3994140625, 2220.3740234375, 10.0625}
}
local crimTeams = {
	"Criminals",
}


function warnCriminal(msg,r,g,b)
	local list = getPlayersInTeam(getTeamFromName("Criminals"))
	for k,v in pairs(list) do
		exports.dendxmsg:createNewDxMessage(v,msg,r,g,b)
	end
end

function setVisisbleTo(element)
   local teamPlayers = getPlayersInTeam(getTeamFromName("Criminals"))
        for k, v in ipairs(teamPlayers) do
          setElementVisibleTo ( element, getRootElement(), false )
          setElementVisibleTo ( element, v, true )
        end
end

function startTable()
        random = math.random(#pickupT)
        x, y, z = pickupT[random][1], pickupT[random][2], pickupT[random][3]
        flagPickup1 = createPickup ( x,y,z, 3, 2993 )
		flagBlip1 = createBlipAttachedTo (flagPickup1, 19)
		
		setBlipVisibleDistance ( flagBlip1, 15000 )
		setVisisbleTo(flagPickup1)
		setVisisbleTo(flagBlip1)
		local loc = getElementZoneName ( flagPickup1 )
		local cityy = getElementZoneName ( flagPickup1, true )
		warnCriminal("A flag appeared and needs to be delivered! Get it from " ..loc.. ", " ..cityy,0,255,0)
		addEventHandler( "onPickupHit", flagPickup1, rec )
end
setTimer(startTable, 300000, 1)

function rec ( thePlayer )
if ( getTeamName( getPlayerTeam( thePlayer ) ) == "Criminals") then
if not ( getTeamName( getPlayerTeam( flagHolder ) ) == "Staff") then
    if (source ~= flagPickup1) then 
		return 
	end
	if (isPedInVehicle(thePlayer)) then 
		return 
	end
	flagHolder = thePlayer
	random1 = math.random(#deliverT)
	x1, y1, z1 = deliverT[random1][1], deliverT[random1][2], deliverT[random1][3] 
	px, py, pz = getElementPosition ( thePlayer )
	if (getDistanceBetweenPoints2D ( px, py, x1, y1 ) >= (1650.60) or getDistanceBetweenPoints2D (px,py,x1,y1) <= 400) then 
		rec(thePlayer) 
		return 
	end 
	flagDeliver1 = createMarker ( x1, y1, z1, "cylinder", 2.0, 0, 200,0, 150)
	dropoffpos(flagDeliver1)
	flagDBlip1 = createBlipAttachedTo (flagDeliver1, 19)
	flaga = createObject ( 2993, 0, 0, -50 )
	elblip = createBlipAttachedTo ( flaga, 19 )
	
	plaName = getPlayerName ( thePlayer )
	setVisisbleTo(flagDeliver1)
	setVisisbleTo(elblip)
	exports.bone_attach:attachElementToBone(flaga,thePlayer,12,0,0,0,0,-90,0)
	destroyElement ( flagPickup1 )
	destroyElement ( flagBlip1 )
	local loc = getElementZoneName ( flagHolder )
	local cityy = getElementZoneName ( flagHolder, true )
	local loc1 = getElementZoneName ( flagDeliver1 )
	local cityy1 = getElementZoneName ( flagDeliver1, true )
	if isTimer(a) then killTimer(a) end
	a = setTimer(function ()
		speedx, speedy, speedz = getElementVelocity ( flagHolder )
		if speedx == false then return end
		actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
		kmh = actualspeed * 180
		if kmh > 60 then
			local dx, dy, dz = getElementPosition(flagHolder)
			destroyElement ( flaga )
			destroyElement ( elblip )
			destroyElement ( flagDBlip1 )
			destroyElement ( flagDeliver1 )
			flagPickup1 = createPickup ( dx, dy+2.5, dz, 3, 2993 )
			flagBlip1 = createBlipAttachedTo (flagPickup1, 19)
			setVisisbleTo(flagPickup1)
			setVisisbleTo(flagBlip1)
			if isTimer(a) then killTimer(a) end
			addEventHandler( "onPickupHit", flagPickup1, afterdrop )
			exports.dendxmsg:createNewDxMessage(thePlayer,"You are running so fast",255, 0, 0)
		end	
	end,1000,0)	
	exports.dendxmsg:createNewDxMessage(thePlayer,"Deliver the flag to " ..loc1.. ", " ..cityy1.." before you get killed!",255, 255, 0)
	exports.dendxmsg:createNewDxMessage(thePlayer,"You can drop the flag with /dropflag",255, 255, 0)
	warnCriminal(""..plaName.." has the flag! Go to the flag icon at "..loc.. ", " ..cityy.. ", and kill him!",255, 250, 0)
	setElementVisibleTo ( flagDBlip1, root, false )
	setElementVisibleTo ( flagDBlip1, thePlayer, true )
	setElementVisibleTo ( flagDeliver1, root, false )
	setElementVisibleTo ( flagDeliver1, thePlayer, true )
	addEventHandler("onMarkerHit", flagDeliver1, deliverflag1)
else 
	exports.dendxmsg:createNewDxMessage(thePlayer,"Abuser! you can't get the flag while on staff mode",255, 0, 0)
end
end
end	


function playerWasted ( ammo, attacker )
	if (exports.bone_attach:isElementAttachedToBone(flaga) == true) then
	if ( getTeamName( getPlayerTeam( source ) ) == "Criminals") then
		if source == flagHolder then
			if ( getElementType ( attacker ) == "player" ) then
				local dx, dy, dz = getElementPosition(source)
				destroyElement ( flaga )
				destroyElement ( elblip )
				flagPickup1 = createPickup ( dx, dy, dz, 3, 2993 )
				flagBlip1 = createBlipAttachedTo (flagPickup1, 19)
				
				setVisisbleTo(flagPickup1)
				setVisisbleTo(flagBlip1)
				destroyElement ( flagDBlip1 )
				destroyElement ( flagDeliver1 )
				addEventHandler( "onPickupHit", flagPickup1, afterdrop )
			else
				local dx, dy, dz = getElementPosition(source)
				destroyElement ( flaga )
				destroyElement ( elblip )
				flagPickup1 = createPickup ( dx, dy, dz, 3, 2993 )
				flagBlip1 = createBlipAttachedTo (flagPickup1, 19)
				
				setVisisbleTo(flagPickup1)
				setVisisbleTo(flagBlip1)
				destroyElement ( flagDBlip1 )
				destroyElement ( flagDeliver1 )
				addEventHandler( "onPickupHit", flagPickup1, afterdrop )
			end
		end

	end
end
end
addEventHandler("onPlayerWasted", root, playerWasted)

function vehicle(source)
if (exports.bone_attach:isElementAttachedToBone(flaga) == true) then
if ( getTeamName( getPlayerTeam( source ) ) == "Criminals") then
	if source == flagHolder then
	local dx, dy, dz = getElementPosition(source)
	destroyElement ( flaga )
	destroyElement ( elblip )
	flagPickup1 = createPickup ( dx, dy, dz, 3, 2993 )
	flagBlip1 = createBlipAttachedTo (flagPickup1, 19)
	
	setVisisbleTo(flagPickup1)
	setVisisbleTo(flagBlip1)
	destroyElement ( flagDBlip1 )
	destroyElement ( flagDeliver1 )
	addEventHandler( "onPickupHit", flagPickup1, afterdrop )
	end

	end
end
end
addEventHandler("onVehicleEnter", root, vehicle)

function afterdrop(thePlayer)
if ( getTeamName( getPlayerTeam( thePlayer ) ) == "Criminals") then
flagHolder = thePlayer
if not ( getTeamName( getPlayerTeam( flagHolder ) ) == "Staff") then
    if (source ~= flagPickup1) then 
		return 
	end
if (isPedInVehicle(thePlayer)) then 
		return 
	end
	x,y,z = unpack(preEventPosition)
	flagDeliver1 = createMarker ( x, y, z, "cylinder", 2.0, 0, 200,0, 150)
	flagDBlip1 = createBlipAttachedTo (flagDeliver1, 19)
	flaga = createObject ( 2993, 0, 0, -50 )
	elblip = createBlipAttachedTo ( flaga, 19 )
	setBlipColor(elblip, 0, 255,0)
	plaName = getPlayerName ( thePlayer )
	setVisisbleTo(flagDeliver1)
	setVisisbleTo(elblip)
	exports.bone_attach:attachElementToBone(flaga,thePlayer,12,0,0,0,0,-90,0)
	destroyElement ( flagPickup1 )
	destroyElement ( flagBlip1 )
	local loc = getElementZoneName ( flagHolder )
	local cityy = getElementZoneName ( flagHolder, true )
	local loc1 = getElementZoneName ( flagDeliver1 )
	local cityy1 = getElementZoneName ( flagDeliver1, true )
	if isTimer(a) then killTimer(a) end
	a = setTimer(function ()
		speedx, speedy, speedz = getElementVelocity ( flagHolder )
		if speedx == false then return end
		actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
		kmh = actualspeed * 180
		if kmh > 60 then
			local dx, dy, dz = getElementPosition(flagHolder)
			destroyElement ( flaga )
			destroyElement ( elblip )
			destroyElement ( flagDBlip1 )
			destroyElement ( flagDeliver1 )
			flagPickup1 = createPickup ( dx, dy+2.5, dz, 3, 2993 )
			flagBlip1 = createBlipAttachedTo (flagPickup1, 19)
			setVisisbleTo(flagPickup1)
			setVisisbleTo(flagBlip1)
			if isTimer(a) then killTimer(a) end
			addEventHandler( "onPickupHit", flagPickup1, afterdrop )
			exports.dendxmsg:createNewDxMessage(thePlayer,"You are running so fast",255, 0, 0)
		end	
	end,1000,0)	
	exports.dendxmsg:createNewDxMessage(thePlayer,"Deliver the flag to " ..loc1.. ", " ..cityy1.." before you get killed!",255, 255, 0)
	exports.dendxmsg:createNewDxMessage(thePlayer,"You can drop the flag with /dropflag",255, 255, 0)
	warnCriminal(""..plaName.." has the flag! Go to the flag icon at "..loc.. ", " ..cityy.. ", and kill him!",255, 250, 0)
	setElementVisibleTo ( flagDBlip1, root, false )
	setElementVisibleTo ( flagDBlip1, thePlayer, true )
	setElementVisibleTo ( flagDeliver1, root, false )
	setElementVisibleTo ( flagDeliver1, thePlayer, true )
	addEventHandler("onMarkerHit", flagDeliver1, deliverflag1)
end
end
end

function dropoffpos(marker)
local xx,yy,zz = getElementPosition(marker)
	preEventPosition = {xx,yy,zz}
end	

function drop(source)
if (exports.bone_attach:isElementAttachedToBone(flaga) == true) then
if ( getTeamName( getPlayerTeam( source ) ) == "Criminals") then
	if source == flagHolder then
		local dx, dy, dz = getElementPosition(source)
		destroyElement ( flaga )
		destroyElement ( elblip )
		flagPickup1 = createPickup ( dx, dy+2.5, dz, 3, 2993 )
		flagBlip1 = createBlipAttachedTo (flagPickup1, 19)
		
		setVisisbleTo(flagPickup1)
		setVisisbleTo(flagBlip1)
		destroyElement ( flagDBlip1 )
		destroyElement ( flagDeliver1 )
		addEventHandler( "onPickupHit", flagPickup1, afterdrop )
	end

end
end
end
addCommandHandler("dropflag", drop)

function playerDC ()
if (exports.bone_attach:isElementAttachedToBone(flaga) == true) then
if ( getTeamName( getPlayerTeam( source ) ) == "Criminals") then
	if source == flagHolder then
	local dx, dy, dz = getElementPosition(source)
	destroyElement ( flaga )
	destroyElement ( elblip )
	flagPickup1 = createPickup ( dx, dy+2, dz, 3, 2993 )
	flagBlip1 = createBlipAttachedTo (flagPickup1, 19)
	
	setVisisbleTo(flagPickup1)
	setVisisbleTo(flagBlip1)
	destroyElement ( flagDBlip1 )
	destroyElement ( flagDeliver1 )
	local loc1 = getElementZoneName ( flagPickup1 )
	local cityy1 = getElementZoneName ( flagPickup1, true )
	warnCriminal("The flag holder disconnected! The flag is on " ..loc1.. ", " ..city,0, 255, 0)
	addEventHandler( "onPickupHit", flagPickup1, afterdrop )
	end
	end
end
end
addEventHandler("onPlayerQuit", getRootElement(), playerDC)

function deliverflag1 ( hitElement, mDim )
if (exports.bone_attach:isElementAttachedToBone(flaga) == true) then
if ( getTeamName( getPlayerTeam( hitElement ) ) == "Criminals") then
		if isPedInVehicle ( hitElement ) == false then
			totalDist = getDistanceBetweenPoints3D ( px, py, pz, x1, y1, z1)
			team = getTeamFromName("Criminals")
			plaCount = countPlayersInTeam(team)
			healthh = getElementHealth(flagHolder)
			paycheck = math.floor ( 10000+(healthh*10)+(totalDist*3)+(plaCount*10))
			totalPay = givePlayerMoney ( hitElement, (paycheck) ) 
			exports.CSGscore:givePlayerScore(hitElement, 0.5)
			warnCriminal(""..plaName.." delivered the flag and earned $"..paycheck.." + 0.5 score",255, 250, 0)
			setElementDimension ( flagDeliver1, 555 )
			destroyElement ( flaga )
			destroyElement ( elblip )
			destroyElement ( flagDBlip1 )
			warnCriminal("Next Flag will appears after 5 mins",0, 250, 0)
			if isTimer(a) then killTimer(a) end
			local thisResource = getThisResource()
			restartResource(thisResource) 
	else
		end
	end
	end
end
	
	
setTimer(function()
local thisResource = getThisResource()
restartResource(thisResource)
end, 43200000,0)