-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: -f 0 -l ;;;;;;; C:\Users\Sensei\Documents\luadec\hitman.luac 

local hitmanPositions = {{1775.45, -1898.4960000000001, 13.385999999999999}, {1243.896, -2038.5540000000001, 59.887}, {2817.511, -1848.3340000000001, 11.154999999999999}, {2817.511, -1848.3340000000001, 11.154999999999999}, {2817.511, -1848.3340000000001, 11.154999999999999}, {2817.511, -1848.3340000000001, 11.154999999999999}, {2550.0360000000001, -1042.8520000000001, 69.028999999999996}, {1378.617, -862.60000000000002, 40.790999999999997}, {2402.3499999999999, -1383.1179999999999, 23.731999999999999}, {2402.3499999999999, -1383.1179999999999, 23.731999999999999}, {1945.8389999999999, 726.61099999999999, 10.853999999999999}, {1945.8389999999999, 726.61099999999999, 10.853999999999999}, {1945.8389999999999, 726.61099999999999, 10.853999999999999}, {1945.8389999999999, 726.61099999999999, 10.853999999999999}, {1945.8389999999999, 726.61099999999999, 10.853999999999999}, {-2216.8690000000001, 606.99800000000005, 35.203000000000003}, {-2335.4110000000001, -139.75299999999999, 35.590000000000003}, {-2203.5030000000002, 61.811999999999998, 35.347999999999999}}
isPlayerCriminal = function(l_1_0)
  if getElementData(l_1_0, "Occupation") == "Criminal" then
    return true
  else
    return false
  end
end

startHitman = function()
  if isElement(hitmanPed) then
    return 
  end
  if isPlayerCriminal(localPlayer) then
    if isTimer(triggerTimer) then
      killTimer(triggerTimer)
    end
    local index = math.random(#hitmanPositions)
    local posX, posY, posZ = hitmanPositions[index][1], hitmanPositions[index][2], hitmanPositions[index][3]
    local x, y, z = getElementPosition(localPlayer)
    money = math.floor(getDistanceBetweenPoints3D(posX, posY, posZ, x, y, z)) / 2
    cancelHitTimer = setTimer(cancelHit, 600000, 1)
    hitmanPed = createPed(math.random(1, 300), posX, posY, posZ)
    hitmanBlip = createBlipAttachedTo(hitmanPed, 41)
    hitmanMarker = createMarker(posX, posY, posZ + 2.5, "arrow", 1, 225, 0, 0)
    exports.DENdxmsg:createNewDxMessage("A hit has been placed on a ped located in " .. getZoneName(posX, posY, posZ) .. ", " .. getZoneName(posX, posY, posZ, true), 225, 0, 0)
    if not hitmanPed then
      hitmanPed = createPed(1, posX, posY, posZ)
    end
  end
end

addEvent("CSGhitman.startHitman", true)
addEventHandler("CSGhitman.startHitman", root, startHitman)
onHitmanPedWasted = function(l_3_0)
  if source == hitmanPed then
    if isElement(hitmanPed) then
      destroyElement(hitmanPed)
    end
    if isElement(hitmanBlip) then
      destroyElement(hitmanBlip)
    end
    if isElement(hitmanMarker) then
      destroyElement(hitmanMarker)
    end
    triggerServerEvent("CSGhitman.hitmanPedDead", l_3_0, money)
  end
end

addEventHandler("onClientPedWasted", root, onHitmanPedWasted)
cancelHit = function()
  if isElement(hitmanPed) then
    if isTimer(cancelHitTimer) then
      killTimer(cancelHitTimer)
    end
    if isElement(hitmanPed) then
      destroyElement(hitmanPed)
    end
    if isElement(hitmanBlip) then
      destroyElement(hitmanBlip)
    end
    if isElement(hitmanMarker) then
      destroyElement(hitmanMarker)
    end
    triggerTimer = setTimer(startHitman, 300000, 1)
    exports.DENdxmsg:createNewDxMessage("The time ran out and you didn't kill the ped.", 225, 0, 0)
  end
end

triggerHitman = function()
  for index,players in ipairs(getElementsByType("player")) do
    triggerEvent("CSGhitman.startHitman", players)
  end
end

setTimer(triggerHitman, 50000, 0)
onPlayerChangeJob = function(l_6_0, l_6_1)
  if l_6_1 == "Criminal" and l_6_0 ~= "Criminal" and isElement(hitmanPed) then
    if isElement(hitmanPed) then
      destroyElement(hitmanPed)
    end
    if isElement(hitmanBlip) then
      destroyElement(hitmanBlip)
    end
    if isElement(hitmanMarker) then
      destroyElement(hitmanMarker)
    end
  end
end

addEventHandler("onClientElementDataChange", root, onPlayerChangeJob)

