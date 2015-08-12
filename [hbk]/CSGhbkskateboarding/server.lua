local skateboardCars = {}
local antiSpamTimers = {}
function boardjup(thePlayer)
    if isElement(skateboardCars[thePlayer] ) then
        vx, vy, vz = getElementVelocity(skateboardCars[thePlayer] )
        if vz > 0 and vz < 0.2 then
            if not isTimer(antiSpamTimers[thePlayer]) then
                setElementVelocity(skateboardCars[thePlayer] , vx, vy, 0.27)
                antiSpamTimers[thePlayer] = setTimer(function () end, 3000,1)
            end
        end
    end
end



addEvent( "onFxSkate", true )
addEventHandler( "onFxSkate", getRootElement(),
function (thePlayer)
 local sklevel = getPlayerWantedLevel ( thePlayer ) -- get the wanted level of the player
    if ( sklevel >= 1 ) then exports.dendxmsg:createNewDxMessage(thePlayer,"You aren't allowed to spawn Skate while you'r wanted",255,0,0) return end
    if isElement(skateboardCars[thePlayer]) then exports.dendxmsg:createNewDxMessage(thePlayer,"You already have skateboard. use /delskate  to remove it",255,100,0) return end
	--destroyElement(skateboardCars[thePlayer]) return false end
    takePlayerMoney(thePlayer,100)
	local x,y,z = getElementPosition( thePlayer )
    prot = getPedRotation(thePlayer)
    local skateboardCar = createVehicle ( 441, x, y, z+.05, 0, 0, prot)
    skateboardCars[thePlayer] = skateboardCar
    local Skateboard = createObject ( 2410, x, y, z+5, 0, 0, prot )
    setObjectScale( Skateboard, 2 )
    setElementData ( skateboardCar, "purpose", "Skateboard" )
    attachElements ( Skateboard, skateboardCar, 0, 0, 1.05, -358, 0, 0)

    setElementAlpha(skateboardCar, 0)
    setElementParent ( Skateboard, skateboardCar)
    addEventHandler("onVehicleExplode",skateboardCar, function () destroyElement(source) end )

	triggerEvent("EnterSkateBoardingg", thePlayer)
    addVehicleUpgrade( skateboardCar, 1087 )
    addVehicleUpgrade( skateboardCar, 1009 )
    triggerClientEvent ( "Skateboardcreated", getRootElement(), Skateboard )
    bindKey ( thePlayer, "lshift", "down", boardjup )
    bindKey ( thePlayer, "Rshift", "down", boardjup )
	setTimer(
	function ()
		warpPedIntoVehicle(thePlayer, skateboardCar)
		setPedAnimation(thePlayer, "bikeleap", "bk_blnce_in", -1, false, false, false)
		setTimer ( Skateanim, 800, 1, source )
    end,1000,1)
		setTimer(
		function ()
		if isElement(skateboardCars[thePlayer]) then destroyElement(skateboardCars[thePlayer])
		exports.dendxmsg:createNewDxMessage(thePlayer,"You'r time is over . SkateBoard Destroyed",255,255,0)
		end
		end,(60000*10),1)

end )


addCommandHandler ( "delskate",
function (thePlayer)
if isElement(skateboardCars[thePlayer]) then destroyElement(skateboardCars[thePlayer]) exports.dendxmsg:createNewDxMessage(thePlayer,"SkateBoard Destroyed",0,255,0) end end )

addEvent("EnterSkateBoardingg", true)
function EnterSkateBoarding ( vehicle, seat, jacked )
    if isElement(vehicle) then
	if (getElementData( vehicle, "purpose" ) == "Skateboard") then
	local sklevel = getPlayerWantedLevel ( source ) -- get the wanted level of the player
    if ( sklevel >= 1 ) then removePedFromVehicle(source) exports.dendxmsg:createNewDxMessage(thePlayer,"You aren't allowed to spawn Skate while you'r wanted",255,0,0) return end
		setPedAnimation(source, "bikeleap", "bk_blnce_in", -1, false, false, false)
		setTimer ( Skateanim, 800, 1, source )
		exports.dendxmsg:createNewDxMessage(thePlayer,"SkateBoard will be destroyed after 5min's . /lshift for jump   also u can use nitro",0,255,0)

		triggerClientEvent ( "SKm", getRootElement(), thePlayer )
	else return false
	end
end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), EnterSkateBoarding )
addEventHandler ( "EnterSkateBoardingg", getRootElement(), EnterSkateBoarding )

function Skateanim ( thePlayer )
	if (isElement(thePlayer)) then
 local theVehicle = getPedOccupiedVehicle ( thePlayer )
	if ( theVehicle ) then
	 if (getElementData( theVehicle, "purpose" ) == "Skateboard") then

		setPedAnimation(thePlayer, "bikeleap", "bk_blnce_in", -1, false, false, false)
	else
		setPedAnimation(thePlayer)
	end
	end
	end
end

addEventHandler("onVehicleDamage", getRootElement(),
function (loss)
	if (getElementData( source, "purpose" ) == "Skateboard") then
		if loss > 5 then
			local thePlayer = getVehicleOccupant(source)
			if thePlayer then
            removePedFromVehicle(thePlayer)
            triggerClientEvent ( "SKw", getRootElement(), Skateboard )

			end

		end
	end
end )


addEventHandler('onPlayerQuit',root, function ()
if isElement(skateboardCars[source]) then destroyElement(skateboardCars[source]) end end)

addEventHandler('onPlayerWasted',root, function ()
if isElement(skateboardCars[source]) then destroyElement(skateboardCars[source]) end end)
