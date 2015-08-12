
addEvent("gasconsN",true)
addEventHandler("gasconsN",root,
    function ()
    if isPedInVehicle(source)==true then return end
	local x,y,z = getElementPosition(source)
	for k,v in ipairs(getElementsByType("vehicle")) do
	local vX,vY,vZ = getElementPosition(v)

	if (getDistanceBetweenPoints3D(x,y,z,vX,vY,vZ) < 2.5) then
    local oldFuel = getElementData(v,'vehicleFuel')
            if oldFuel < 100 then
                    setElementData(v,'vehicleFuel',math.min(100,oldFuel+10))
	local gascons = createObject(1010, x, y, z)
	setObjectScale ( gascons, 0.6)
	exports.bone_attach:attachElementToBone(gascons,source,12,0,0.05,0.27,0,180,0)
	setPedAnimation( source, "ROCKET", "idle_rocket", 5000, 1, false, false, false, false)
	exports.DENdxmsg:createNewDxMessage(source,"Refueling...",255,255,0)
	setTimer(
	function()
	if isElement(gascons) then destroyElement(gascons) end
	end,5000,1)
	else
	exports.DENdxmsg:createNewDxMessage(source,"No vehicle nearby, fuel can wasted",255,0,0)
		return
	    end
	    end
		end

	end
		)

addEvent("givegasconsmoney",true)
addEventHandler("givegasconsmoney",root,
    function ()
        kitmoney = getPlayerMoney (source)
       if (kitmoney >= 100) then
		if exports.DENstats:getPlayerAccountData(source,"gsc") < 0 then
			exports.DENstats:setPlayerAccountData(source,"gsc",0)
		end
		exports.DENstats:setPlayerAccountData(source,"gsc",exports.DENstats:getPlayerAccountData(source,"gsc")+1)
		takePlayerMoney(source,100)
		fadeCamera ( source, false, 1 )
        setTimer( fadeCamera, 500, 1, source, true, 1 )


end
end )

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	triggerClientEvent(source,"recgsc",source,exports.DENstats:getPlayerAccountData(source,"gsc"))
end)

addEvent("usedgsc",true)
addEventHandler("usedgsc",root,function()
	exports.DENstats:setPlayerAccountData(source,"gsc",exports.DENstats:getPlayerAccountData(source,"gsc")-1)
end)

setTimer(function()
	for k,source in pairs(getElementsByType("player")) do
		triggerClientEvent(source,"recgsc",source,exports.DENstats:getPlayerAccountData(source,"gsc"))
	end
end,5000,1)
