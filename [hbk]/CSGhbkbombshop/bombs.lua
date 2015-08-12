local bombShopMarker1 = createMarker(2006.63,2310,10,"cylinder", 2, 255, 0, 0)
local bombShopMarker2 = createMarker(1846,-1856.1737060547,12,"cylinder", 2, 255, 0, 0)
local bombShopMarker3 = createMarker(-2521.9636230469, 1216, 36,"cylinder", 2, 255, 0, 0)
--blip1 = createBlip ( 2006.63, 2310, 10 , 16 )
--blip2 = createBlip ( 1853.8177490234,-1856.1737060547,12 , 16 )
---blip3 = createBlip ( -2521.9636230469, 1216, 36 , 16 )
--setBlipVisibleDistance(blip1, 2000)
---setBlipVisibleDistance(blip2, 2000)
---setBlipVisibleDistance(blip3, 2000)
function onMarkerHit(hitElement,matchingDimensions)
    if getElementType(hitElement) ~= "vehicle" or not matchingDimensions then return false end
	local driver = getVehicleOccupant(hitElement,0)

--if player have weapon id 40 then	outputChatBox("U planted Bomb on this car Use Detonator to blow it", driver, 255, 0, 0)
	if isElement(driver) then
	money = getPlayerMoney (driver)
       if (money >= 3000) then

		takePlayerMoney(driver,3000)
		exports.DENdxmsg:createNewDxMessage(driver,"A Bomb is being planted into the vehicle..", 255, 0, 0)
        setElementData(driver,"bsv",hitElement)
        giveWeapon(driver,40)
		setElementFrozen ( hitElement, true )
		setTimer(setElementFrozen,5000,1,hitElement,false)
        bindKey(driver,"fire","down",onWeaponFire)
	exports.DENdxmsg:createNewDxMessage(driver,"Use Detonator to bomb this car", 255, 255, 255)
    else
	exports.DENdxmsg:createNewDxMessage(driver,"You don't have enough money to set bomb for this car", 255, 255, 0)
	end
	end
	end

addEventHandler("onMarkerHit",bombShopMarker1,onMarkerHit)
addEventHandler("onMarkerHit",bombShopMarker2,onMarkerHit)
addEventHandler("onMarkerHit",bombShopMarker3,onMarkerHit)
function blowVehicleFromPlayer(player)
    local vehicle = getElementData(player,"bsv")
    if isElement(vehicle) then
        takeWeapon(player,40)
        blowVehicle(vehicle)
		setElementData(player,"bsv",nil)
	end
end








function onWeaponFire(presser)
    local weaponUsed = getPedWeapon(presser)
    if weaponUsed == 40 then
        blowVehicleFromPlayer(presser)
    end
end
