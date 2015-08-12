function pedSkills( ped, skill )
	setPedStat( ped, 69, skill )
	setPedStat( ped, 70, skill )
	setPedStat( ped, 71, skill )
	setPedStat( ped, 72, skill )
	setPedStat( ped, 73, skill )
	setPedStat( ped, 74, skill )
	setPedStat( ped, 75, skill )
	setPedStat( ped, 76, skill )
	setPedStat( ped, 77, skill )
	setPedStat( ped, 78, skill )
	setPedStat( ped, 79, skill )
end

function resourceStart( )
	local players = getElementsByType( "player" )
	
	for theKey, thePlayer in ipairs( players ) do
	   pedSkills( thePlayer, 999 )
	end
end

function resourceStop( )
	local players = getElementsByType( "player" )
	
	for theKey, thePlayer in ipairs( players ) do
	   pedSkills( thePlayer, 0 )
	end
end

function playerJoin( )
	pedSkills( source, 999 )
end

addEventHandler( "onResourceStart", resourceRoot, resourceStart )
addEventHandler( "onResourceStop", resourceRoot, resourceStop )
addEventHandler( "onPlayerJoin", root, playerJoin )