------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithsMisteryVan/server (server-side)
--  Mistery Van Event!
--  [CSG]Smith
------------------------------------------------------------------------------------
_root = getRootElement ( )
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
	exports.dendxmsg:createNewDxMessage(_root,"*** Mistery Van ***",0,255,0)
	exports.dendxmsg:createNewDxMessage(_root,"Go first to Mistery Van and get random reward!",0,255,0)
	exports.dendxmsg:createNewDxMessage(_root,"You can search for '?' blip in map (F11)!",0,255,0)
	local x, y, z, r = unpack ( VanLocations [ math.random ( #VanLocations ) ] )
	theVan = createVehicle ( 609, x, y, z + 0.2 )
	setElementRotation(theVan,0,0,r)
	theVanBlip = createBlipAttachedTo ( theVan, 37 )
	desTimer = setTimer(function ()
								destroyMisteryVan ()
								end,300000,1)
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
		drugAmoo = math.random(10, 30)
		Money = math.random(900,1400)
		ID = math.random(1,2)
		wepID = 0
		wepAmoo = math.random (250,500)
		if math.ceil(ID) == 1 then
			wepID = 27
		elseif math.ceil(wepID) == 2 then
			wepID = 31
		end	
		giveWeapon(source, wepID, wepAmoo)
		givePlayerMoney(source,Money)
		exports.CSGdrugs:giveDrug(source,tostring(drugType),tonumber(drugAmoo))
		exports.dendxmsg:createNewDxMessage(source,"*** Mistery Van ***",0,255,0)
		exports.dendxmsg:createNewDxMessage(source,"You got "..wepAmoo.." Amoo of "..getWeaponNameFromID(wepID).."!",0,255,0)
		exports.dendxmsg:createNewDxMessage(source,"You got $"..Money.."!",0,255,0)
		exports.dendxmsg:createNewDxMessage(source,"You got "..drugAmoo.." hits of "..drugType.."!",0,255,0)
		if isTimer ( desTimer ) then killTimer ( desTimer ) end
		destroyMisteryVan ()
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle )