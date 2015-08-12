playerTrailers = {}

function getPointFromDistanceRotation(x, y, dist, angle)

    local a = math.rad(angle-90);

    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;

    return x+dx, y+dy;

end

trailers =
{
435,
450,
591,
584
}

addEvent ( "trucking_CreatePlayerTrailer", true )

function createPlayerTrailer()

	if isElement(playerTrailers[source]) then destroyElement(playerTrailers[source]) end
	local playerVeh = getPedOccupiedVehicle ( source )
	local x,y,z = getElementPosition(playerVeh)
	local rx,ry,rz = getElementRotation(playerVeh)
	local endX, endY = getPointFromDistanceRotation ( x,y, 8, rz )
	local trailer = createVehicle ( trailers[ math.random(1,#trailers) ], endX,endY,z+0.5 )
	attachTrailerToVehicle ( playerVeh, trailer )
	triggerClientEvent ( source, "trailerAttached", trailer )
	playerTrailers[source] = trailer

end

addEventHandler ( "trucking_CreatePlayerTrailer", root, createPlayerTrailer )

addEvent ( "trucking_DestroyTrailer", true )

function destroyTrailer()

	destroyElement(source)
	if isElement(playerTrailers[source]) then destroyElement(playerTrailers[source]) end

end

addEventHandler("trucking_DestroyTrailer",root,destroyTrailer)

addEvent ( "trucking_GiveReward", true )

function giveReward(price,dist)
	local score = 0.2
	if dist > 1000 then score=0.4 end
	if dist > 1500 then score = 0.5 end
	if dist > 2000 then score = 0.6 end
	if dist > 3500 then score=1 end
	exports.CSGaccounts:addPlayerMoney(source,price)
	exports.CSGscore:givePlayerScore(source,score)
end

addEventHandler("trucking_GiveReward",root,giveReward)

function onQuit()

	if isElement(playerTrailers[source]) then destroyElement(playerTrailers[source]) end
	local stops = getElementData ( source, "trucking_stopsDone" )
	exports.DENstats:setPlayerAccountData( source, "trucking", stops )

end

addEventHandler ( "onPlayerQuit", root, onQuit )

function onLogin()

	local stops = exports.DENstats:getPlayerAccountData(source,"trucking")
	setElementData ( source, "trucking_stopsDone", stops or 0 )

end

addEventHandler ( "onServerPlayerLogin", root, onLogin )
