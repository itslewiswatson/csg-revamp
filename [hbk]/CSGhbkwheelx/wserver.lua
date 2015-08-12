
addEvent("tireN",true)
addEventHandler("tireN",root,
    function ()
    if isPedInVehicle(source)==true then return end
	local x,y,z = getElementPosition(source)
	for k,v in ipairs(getElementsByType("vehicle")) do
	local vX,vY,vZ = getElementPosition(v)

	if (getDistanceBetweenPoints3D(x,y,z,vX,vY,vZ) < 2.5) then setVehicleWheelStates(v,0,0,0,0)
	local wheel = createObject(1096, x, y, z)
	setObjectScale ( wheel, 0.5)
	exports.bone_attach:attachElementToBone(wheel,source,12,0,0.05,0.27,0,180,0)
	setPedAnimation( source, "ROB_BANK", "CAT_Safe_Rob", 12000, 1, false, true, false, true)
	exports.DENdxmsg:createNewDxMessage(source,"Changing tire...",255,255,0)
	setTimer(
	function()
	if isElement(wheel) then destroyElement(wheel) end
	end,8000,1)

	    end
	    end
exports.DENdxmsg:createNewDxMessage(source,"No vehicle nearby, tire wasted",255,0,0)
	    end )

addEvent("givetiremoney",true)
addEventHandler("givetiremoney",root,
    function ()
        kitmoney = getPlayerMoney (source)
       if (kitmoney >= 30) then
		if exports.DENstats:getPlayerAccountData(source,"tw") < 0 then
			exports.DENstats:setPlayerAccountData(source,"tw",0)
		end
		exports.DENstats:setPlayerAccountData(source,"tw",exports.DENstats:getPlayerAccountData(source,"tw")+1)
		takePlayerMoney(source,30)
		fadeCamera ( source, false, 1 )
        setTimer( fadeCamera, 500, 1, source, true, 1 )


end
end )

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	triggerClientEvent(source,"recTW",source,exports.DENstats:getPlayerAccountData(source,"tw"))
end)

addEvent("usedTW",true)
addEventHandler("usedTW",root,function()
	exports.DENstats:setPlayerAccountData(source,"tw",exports.DENstats:getPlayerAccountData(source,"tw")-1)
end)

setTimer(function()
	for k,source in pairs(getElementsByType("player")) do
		triggerClientEvent(source,"recTW",source,exports.DENstats:getPlayerAccountData(source,"tw"))
	end
end,5000,1)
