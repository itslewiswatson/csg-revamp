CWmarker = createMarker ( 1911.2,-1776,12, "cylinder", 3, 255, 255, 0, 255 )
--CWmarker2 = createMarker ( 2455,-1461,23, "cylinder", 2, 255, 255, 0, 255 )
function onwashed(hitElement,matchingDimensions)
    if getElementType(hitElement) ~= "vehicle" or not matchingDimensions then return false end
    local driver = getVehicleOccupant(hitElement,0)
	       local x,y,z = getElementPosition(hitElement)
		   if isElement ( washerped ) then
		   destroyElement ( washerped )
            elseif isElement(driver) then
              mmoney = getPlayerMoney (driver)
           if (mmoney >= 150) then
           setElementFrozen ( hitElement, true )
    ----       setVehicleFrozen ( hitElement, false )
	----	   washerped = createPed ( 22, 1912.4, -1775.5, 14, 90 )
		   washerped = createPed ( 22, x-1.5,y,z, -90 )
		   CWmarkers1 = createObject ( 2780, 1911.2,-1776,13 )
		   setElementCollisionsEnabled (CWmarkers1, false)
		   setElementAlpha(CWmarkers1,0)
		     setPedAnimation ( washerped, "OTB", "betslp_loop", 10000, true,true,true )
             mymoney = math.random (150,200)
             takePlayerMoney(driver,mymoney)
             triggerClientEvent("onservershader", hitElement)
             exports.DENdxmsg:createNewDxMessage(driver,"Your car has been washed", 0, 255, 0)
			 setTimer(setElementFrozen,10000,1,hitElement,false)
			 setTimer(destroyElement,10000,1,washerped,false)
			 setTimer(destroyElement,10000,1,CWmarkers1,false)

			  else
           exports.DENdxmsg:createNewDxMessage(driver,"You don't have enough money to wash your car", 255, 0, 0)
end
end
end

addEventHandler("onMarkerHit", CWmarker, onwashed)
--addEventHandler("onMarkerHit", CWmarker2, onwashedd)
CWmarker2 = createMarker ( 2455,-1461,23, "cylinder", 3, 255, 255, 0, 255 )
--CWmarker3 = createMarker ( 2162.9028320313,2474,10, "cylinder", 2, 255, 255, 0, 255 )

function onwashedd(hitElement,matchingDimensions)
    if getElementType(hitElement) ~= "vehicle" or not matchingDimensions then return false end
    local driver = getVehicleOccupant(hitElement,0)
	       local x,y,z = getElementPosition(hitElement)
		   if isElement ( washerped ) then
		   destroyElement ( washerped )
            elseif isElement(driver) then
              mmoney = getPlayerMoney (driver)
           if (mmoney >= 150) then
           setElementFrozen ( hitElement, true )
        --   setVehicleFrozen ( hitElement, false )
	--	   washerped = createPed ( 22, 1912.4, -1775.5, 14, 90 )
		   washerped = createPed ( 22, x,y-1.5,z, 360 )
		    CWmarkers2 = createObject ( 2780, 2455,-1461,23 )
		   setElementCollisionsEnabled (CWmarkers2, false)
		    setPedAnimation ( washerped, "OTB", "betslp_loop", 10000, true,true,true )
             mymoney = math.random (150,200)
             takePlayerMoney(driver,mymoney)
             triggerClientEvent("onservershader", hitElement)
            exports.DENdxmsg:createNewDxMessage(driver,"Your car has been washed", 0, 255, 0)
			 setTimer(setElementFrozen,10000,1,hitElement,false)
			 setTimer(destroyElement,10000,1,washerped,false)
			 setTimer(destroyElement,10000,1,CWmarkers2,false)
			  else
           exports.DENdxmsg:createNewDxMessage(driver,"You don't have enough money to wash your car", 200, 0, 0)
end
end
end
addEventHandler("onMarkerHit", CWmarker2, onwashedd)
----------------------------
CWmarker3 = createMarker ( 2162.9028320313,2474,10, "cylinder", 2, 255, 255, 0, 255 )

function onwashedd2(hitElement,matchingDimensions)
    if getElementType(hitElement) ~= "vehicle" or not matchingDimensions then return false end
    local driver = getVehicleOccupant(hitElement,0)
	       local x,y,z = getElementPosition(hitElement)
		   if isElement ( washerped ) then
		   destroyElement ( washerped )
            elseif isElement(driver) then
              mmoney = getPlayerMoney (driver)
           if (mmoney >= 150) then
           setElementFrozen ( hitElement, true )
        --   setVehicleFrozen ( hitElement, false )
	--	   washerped = createPed ( 22, 1912.4, -1775.5, 14, 90 )
		   washerped = createPed ( 22, x-1,y,z, -100 )
		   CWmarkers3 = createObject ( 2780, 2162.9028320313,2474,10 )
		   setElementCollisionsEnabled (CWmarkers3, false)
		    setPedAnimation ( washerped, "OTB", "betslp_loop", 10000, true,true,true )
             mymoney = math.random (150,200)
             takePlayerMoney(driver,mymoney)
             triggerClientEvent("onservershader", hitElement)
              exports.DENdxmsg:createNewDxMessage(driver,"Your car has been washed", 0, 255, 0)
			 setTimer(setElementFrozen,10000,1,hitElement,false)
			 setTimer(destroyElement,10000,1,washerped,false)
			  setTimer(destroyElement,10000,1,CWmarkers3,false)
			  else
            exports.DENdxmsg:createNewDxMessage(driver,"You don't have enough money to wash your car", 200, 0, 0)
end
end
end
addEventHandler("onMarkerHit", CWmarker3, onwashedd2)
