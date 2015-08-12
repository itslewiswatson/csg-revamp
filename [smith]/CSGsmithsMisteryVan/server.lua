------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithsMisteryVan/server (server-side)
--  Mistery Van Event!
--  [CSG]Smith
------------------------------------------------------------------------------------
_resroot = getResourceRootElement ( getThisResource ( ) )

Drugs = {
{"Ritalin"},
{"Weed"},
{"LSD"},
{"Cocaine"},
{"Ecstasy"},
{"Heroine"},
}

VanLocations = {
{296, -1540, 25, 54},
{2060, -2320, 14, 180},
{2328, -1272, 23, 271},
{1306, -854, 40, 181},
{1394, -1894, 14, 90},
{2355, 1399, 43, 360},
{1262, 1213, 11, 268},
{2625, 1139, 11, 181},
{1740, 2259, 11, 180},
{945, 1733, 9, 270},
{-2151, -106, 36, 269},
{-1781, 1315, 60, 89},
{-2794, 236, 8, 272},
{-1719, 395, 8, 224},
{-2790, -368, 8, 2},
}



addEventHandler ( "onResourceStart" , _resroot ,
	function ( )
		MisteryVan()
		setTimer(MisteryVan,900000,0)
	end
)


function MisteryVan()
	for k, v in ipairs(getElementsByType("player")) do
		exports.dendxmsg:createNewDxMessage(v,"*** Mystery Van ***",0,255,0)
		exports.dendxmsg:createNewDxMessage(v,"Go first to Mystery Van within 3 minutes and get a random reward!",0,255,0)
		exports.dendxmsg:createNewDxMessage(v,"You can search for '?' blip on the map (F11)!",0,255,0)
	end
	local x, y, z, r = unpack ( VanLocations [ math.random ( #VanLocations ) ] )
	theVan = createVehicle ( 609, x, y, z + 0.2 )
	setElementRotation(theVan,0,0,r)
	theVanBlip = createBlipAttachedTo ( theVan, 37 )
	desTimer = setTimer(function ()
								destroyMisteryVan ()
								end,180000,1)
end

function destroyMisteryVan()
	if theVan and theVanBlip then
		destroyElement(theVan)
		destroyElement(theVanBlip)
	end
end





function enterVehicle ( vehicle, seat, jacked )
    if ( (vehicle == theVan) and (seat == 0)) then
		drugType = unpack ( Drugs [ math.random ( #Drugs ) ] )
		drugAmoo = math.random(10,30)
		Money = math.random(900,1400)
		ID = math.random(1,2)
		wepID = 0
		wepAmoo = math.random (250,500)
		scores = math.random(1,3)
		if ID == 1 then
			wepID = 27
		else
			wepID = 31
		end
		giveWeapon(source, wepID, wepAmoo)
		givePlayerMoney(source,Money)
		for k, v in ipairs(getElementsByType("player")) do
			exports.dendxmsg:createNewDxMessage(v,"'"..getPlayerName(source).."' has entered the Mystery Van!",0,255,0)
		end
		exports.csgscore:givePlayerScore(source,scores)
		exports.CSGdrugs:giveDrug(source,drugType,drugAmoo)
		exports.dendxmsg:createNewDxMessage(source,"*** Mystery Van ***",0,255,0)
		exports.dendxmsg:createNewDxMessage(source,"You got "..wepAmoo.." ammo of "..getWeaponNameFromID(wepID).."!",0,255,0)
		exports.dendxmsg:createNewDxMessage(source,"You got $"..Money.." !",0,255,0)
		exports.dendxmsg:createNewDxMessage(source,"You got "..drugAmoo.." hits of "..drugType.."!",0,255,0)
		exports.dendxmsg:createNewDxMessage(source,"You got +"..scores.." Score!",0,255,0)
		if isTimer ( desTimer ) then killTimer ( desTimer ) end
		destroyMisteryVan ()
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle )
