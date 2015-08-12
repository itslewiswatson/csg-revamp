
local LSTrainMarkerSF = createMarker(1689.9011230469,-1950,13,"cylinder",1.5,255,255,255,255)
local LStoSFstop = createColCircle(-1948.5400390625, 74, 24.5)
local SFtoLVstop = createColCircle(1404.5518798828, 2633, 11)
local LVtoLSstop = createColCircle(1718.66, -1955.61,8)

local SFTrainMarkerLS = createMarker(-1975.2877197266,119,26.5,"cylinder",1.5,255,255,255,255)
local LVTrainMarkerSF = createMarker(1437.1431884766,2620,10,"cylinder",1.5,255,255,255,255)

local LSblips = createBlip( 1689, -1950, 1, 42 )
local SFblips = createBlip( -1975,119,26, 42 )
local LVblips = createBlip( 1437,2620,9.5, 42 )
setBlipVisibleDistance(LSblips, 350)
setBlipVisibleDistance(SFblips, 350)
setBlipVisibleDistance(LVblips, 350)
--------------------------------------
local LSforLV = createMarker(1689.5035400391,-1961,13,"cylinder",1.5,255,255,255,255)
local LSforLVstop = createColCircle(1404.5518798828, 2633, 11)
----------------------
local SFforLS = createMarker(-1974.8603515625,122,26.5,"cylinder",1.5,255,255,255,255)
local SFforLSstop = createColCircle(1718.66, -1955.61,8)
-----------------------
local LVforSF = createMarker(1429.4295654297,2620,10,"cylinder",1.5,255,255,255,255)
local LVforSFstop = createColCircle(-1948.5400390625, 74, 24.5)




---------------------------------------
local trains = {}

addEventHandler("onPlayerQuit",root,function()
	if trains[source] then destroyElement(trains[source]) trains[source] = nil end
end)

addEventHandler("onMarkerHit", root,
function (thePlayer)

	if source == LSTrainMarkerSF or source == SFTrainMarkerLS or source == LVTrainMarkerSF then

	else
		return
	end
	if getElementType(thePlayer) ~= "player" then return end
	if getPlayerWantedLevel(thePlayer) > 0 then
		exports.dendxmsg:createNewDxMessage(thePlayer,"You must have 0 wanted points to use the train system",255,0,0)
		return
	end
	local myTrain=false
    local LStmoney = getPlayerMoney(thePlayer)
	if (LStmoney >= 1000) then
		if source == LSTrainMarkerSF then
		trains[thePlayer] = createVehicle(538,1785,-1949,13)
		elseif source == SFTrainMarkerLS then
		trains[thePlayer] = createVehicle(538,-1944.7864990234, 196, 26.5, 0, 0, 280)
		elseif source == LVTrainMarkerSF then
		trains[thePlayer] = createVehicle(537,1415.6517333984, 2633, 11, 0, 0, 0)
		end
		myTrain = trains[thePlayer]
		takePlayerMoney(thePlayer, 1000)
		setTrainDerailable(myTrain, false)
		setElementFrozen(thePlayer, true)
	exports.dendxmsg:createNewDxMessage(thePlayer,"Train is arriving, please be patient. Use /stoptrain to stop the train", 255, 100, 0)
		if source == LSTrainMarkerSF then
	exports.dendxmsg:createNewDxMessage(thePlayer,"Paid $1000 for a train ride (LS to SF)", 255, 100, 0)
		elseif source == SFTrainMarkerLS then
		exports.dendxmsg:createNewDxMessage(thePlayer,"Paid $1000 for a train ride (SF to LV)", 255, 100, 0)
		elseif source == LVTrainMarkerSF then
		exports.dendxmsg:createNewDxMessage(thePlayer,"Paid $1000 for a train ride (LV to LS)", 255, 100, 0)
		end
	setTimer(
	function ()
	if isElement(myTrain) and isElement(thePlayer) then
		setElementFrozen(thePlayer, false)
		warpPedIntoVehicle(thePlayer, myTrain)
		setTrainSpeed(myTrain, 0.5)
		toggleControl ( thePlayer, "brake_reverse", false )
		toggleControl ( thePlayer, "accelerate", false )
		setTrainDerailable(myTrain, false)
    end
	end, 5000, 1 )

		setTimer(
		function ()
if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, 1.2)
	setTrainDerailable(myTrain, false)
    end
	end, 15000, 1 )


			setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, 1.5)
	setTrainDerailable(myTrain, false)
    end
	end, 25000, 1 )

	setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, 1.8)
	setTrainDerailable(myTrain, false)
    end
	end, 30000, 1 )

				setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, 2)
	setTrainDerailable(myTrain, false)
    end
	end, 40000, 1 )

					setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, 3)
	setTrainDerailable(myTrain, false)
    end
	end, 50000, 1 )

	else
	exports.dendxmsg:createNewDxMessage(thePlayer,"You don't have enough Money, you need $1000", 255, 0, 0)
	end
end )

function ColShapeHit( colShapeHit )
    if colShapeHit == LStoSFstop or colShapeHit == SFtoLVstop or colShapeHit == LVtoLSstop then -- if element entered the created colshape
        for k,v in pairs(trains) do
			if source == v then
				if getTrainSpeed(v) > 0.5 then else return end
				local thePlayer = k
				if colShapeHit == LStoSFstop then
				exports.dendxmsg:createNewDxMessage(thePlayer,"Completed Train Ride, arrived at SF train station", 255, 100, 0)
				exports.dendxmsg:createNewDxMessage(thePlayer,"Thank You for riding VIA Rail CSG", 255, 100, 0)
				elseif colShapeHit == SFtoLVstop then
			exports.dendxmsg:createNewDxMessage(thePlayer,"Completed Train Ride, arrived at LV train station", 255, 100, 0)
					exports.dendxmsg:createNewDxMessage(thePlayer,"Thank You for riding VIA Rail CSG", 255, 100, 0)
				elseif colShapeHit == LVtoLSstop then
					exports.dendxmsg:createNewDxMessage(thePlayer,"Completed Train Ride, arrived at LS train station", 255, 100, 0)
					exports.dendxmsg:createNewDxMessage(thePlayer,"Thank You for riding VIA Rail CSG", 255, 100, 0)
				end
				destroyElement(v)
				trains[k] = nil
				return
			end
		end
	end
end
addEventHandler( "onElementColShapeHit", getRootElement(), ColShapeHit )

function vehquit(thePlayer)
	if trains[thePlayer] and isElement(trains[thePlayer]) then destroyElement(trains[thePlayer]) exports.dendxmsg:createNewDxMessage(thePlayer,"You have Left / Exited the Train", 255, 100, 0) end

end
	   addEventHandler("onVehicleExit", root, vehquit)
addCommandHandler("stoptrain", vehquit)




-----------------------------

addEventHandler("onMarkerHit", root,
function (thePlayer)

	if source == LSforLV or source == SFforLS or source == LVforSF then

	else
		return
	end
	if getElementType(thePlayer) ~= "player" then return end
	if getPlayerWantedLevel(thePlayer) > 0 then
		exports.dendxmsg:createNewDxMessage(thePlayer,"You must have 0 wanted points to use the train system",255,0,0)
		return
	end
	local myTrain=false
    local LSVtmoney = getPlayerMoney(thePlayer)
	if (LSVtmoney >= 1000) then
		if source == LSforLV then
		trains[thePlayer] = createVehicle(537,1833.786,-1954.3293,13.69)
		elseif source == SFforLS then
		trains[thePlayer] = createVehicle(538,-1944.7864990234, 196, 26.5, 0, 0, 280)
		elseif source == LVforSF then
		trains[thePlayer] = createVehicle(537,1415.6517333984, 2633, 11, 0, 0, 0)
		end
		myTrain = trains[thePlayer]
		takePlayerMoney(thePlayer, 1000)
		setTrainDerailable(myTrain, false)
		setElementFrozen(thePlayer, true)
	exports.dendxmsg:createNewDxMessage(thePlayer,"Train is arriving, please be patient. Use /stoptrain to stop the train", 255, 100, 0)
		if source == LSTrainMarkerSF then
		exports.dendxmsg:createNewDxMessage(thePlayer,"Paid $1000 for a train ride (LS to SF)", 255, 100, 0)
		elseif source == SFTrainMarkerLS then
		exports.dendxmsg:createNewDxMessage(thePlayer,"Paid $1000 for a train ride (SF to LV)", 255, 100, 0)
		elseif source == LVTrainMarkerSF then
		exports.dendxmsg:createNewDxMessage(thePlayer,"Paid $1000 for a train ride (LV to LS)", 255, 100, 0)
		end
	setTimer(
	function ()
	if isElement(myTrain) and isElement(thePlayer) then
		setElementFrozen(thePlayer, false)
		warpPedIntoVehicle(thePlayer, myTrain)
		setTrainDirection ( myTrain, false )
		setTrainSpeed(myTrain, -0.5)
		toggleControl ( thePlayer, "brake_reverse", false )
		toggleControl ( thePlayer, "accelerate", false )
		setTrainDerailable(myTrain, false)
    end
	end, 5000, 1 )

		setTimer(
		function ()
if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, -1)
	setTrainDerailable(myTrain, false)
    end
	end, 15000, 1 )


			setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, -0.5)
	setTrainDerailable(myTrain, false)
    end
	end, 25000, 1 )

	setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, -0.5)
	setTrainDerailable(myTrain, false)
    end
	end, 30000, 1 )

				setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, -1.2)
	setTrainDerailable(myTrain, false)
    end
	end, 40000, 1 )

					setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, -1)
	setTrainDerailable(myTrain, false)
    end
	end, 50000, 1 )

						setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, -1.5)
	setTrainDerailable(myTrain, false)
    end
	end, 60000, 1 )

							setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, -2)
	setTrainDerailable(myTrain, false)
    end
	end, 65000, 1 )

							setTimer(
		function ()
		if isElement(myTrain) and isElement(thePlayer) then
	setTrainSpeed(myTrain, -2.5)
	setTrainDerailable(myTrain, false)
    end
	end, 70000, 1 )


	else
	exports.dendxmsg:createNewDxMessage(thePlayer,"You don't have enough Money, you need $1000", 255, 0, 0)
	end
end )
