--[[
Any unauthorized reprint or use of this material is prohibited.
No part of this script may be reproduced or transmitted in any form or by
Any means, electronic or mechanical, including photocopying, recording,
Or by any information storage and retrieval system without express written
Permission from the author / publisher.

(C) Jesseunit AkA. Achille,
ALL RIGHTS RESERVED
]]--







maxRockets = get("maxRockets")
command = get("command")



addCommandHandler("fl09", function(player)
        local x, y, z = getElementPosition(player)
        flare = createObject(1337, x, y, z)
        l1 = createMarker(x, y, z, "corona", 5, 255, 0, 0, 160, root)
        l2 = createMarker(x, y, z, "corona", 5, 255, 0, 0, 160, root)
        setElementCollisionsEnabled(flare, false)
        setTimer(destroyElement, 60000, 1, flare)
        setTimer(destroyElement, 60000, 1, l1)
        setTimer(destroyElement, 60000, 1, l2)
        setObjectScale(flare, 0.5)
    end)

addEventHandler("onResourceStart", resourceRoot, function()
        for i, thePlayer in ipairs(getElementsByType("player")) do
            setElementData(thePlayer, "rocket", 0)
        end
    end)

addEventHandler("onPlayerJoin", root, function()
    setElementData(source, "rocket", 0)
end)


addCommandHandler("secretfw", function(player)
     if (getElementData(player, "rocket") < 10) then

        rand = math.random(40,60)
        local pX, pY, pZ = getElementPosition(player)
        rocket = createObject(1636, pX, pY, pZ-0.2, 90, 0, 0)
        smoke1 = createObject(1337, pX, pY, pZ-0.4, 0, 0, 0)
        rSmoke = createObject(2057, pX, pY, pZ-0.4, 0, 0, 0)

        light = createMarker(pX, pY, pZ, "corona", 0.4, 255, 0, 0, 140, root)
        light2 = createMarker(pX, pY, pZ, "corona", 0.5, 0, 255, 0, 140, root)

        attachElements(light, rocket)
        attachElements(light2, rocket)

        attachElements(smoke1, rocket, 0, 0, 0, 90, 0, 0)

        setElementCollisionsEnabled(smoke1, false)

        setElementCollisionsEnabled(rocket, true)
        setElementData(player, "rocket", getElementData(player, "rocket")+1)


        setTimer(moveObject, 5000, 1, rocket, 3000, pX, pY, pZ+rand)
        setTimer(moveObject, 8000, 1, rocket, 2000, pX-math.random(5, 10), pY+math.random(5, 10), pZ-0.66, math.random(10, 90), math.random(10, 90), math.random(10, 90))

        setTimer(setElementCollisionsEnabled, 8000, 1, rocket, false)
        setTimer(destroyElement, 8000, 1, light)
        setTimer(destroyElement, 8000, 1, light2)
        setTimer(destroyElement, 8000, 1, smoke1)
        setTimer(destroyElement, 17000, 1, rocket)
        setTimer(destroyElement, 6000, 1, rSmoke)

        flowerpot = createVehicle(594, pX, pY, pZ, 0, 0, 0)
        setElementAlpha ( flowerpot, 0 )
        attachElements(flowerpot, rocket, 0, 0, 0, 0, -90, 0)
        setElementCollisionsEnabled(flowerpot, true)
        setTimer(destroyElement, 8000, 1, flowerpot)
        setVehicleDamageProof(flowerpot, true)
        setVehicleOverrideLights ( flowerpot, 1 )

        setTimer(function()
            boom1 = createObject(1338, pX, pY, pZ+30)
            boom2 = createObject(1338, pX, pY+math.random(3, 9), pZ+rand)
            boom3 = createObject(1338, pX, pY+math.random(3, 8), pZ+rand)
            boom4 = createObject(1338, pX, pY+math.random(3, 6), pZ+rand)
            boom5 = createObject(1338, pX, pY+math.random(3, 4), pZ+rand)

            boom6 = createObject(1338, pX+math.random(3, 4), pY, pZ+rand)
            boom7 = createObject(1338, pX+math.random(3, 6), pY, pZ+rand)
            boom8 = createObject(1338, pX+math.random(3, 9), pY, pZ+rand)
            boom9 = createObject(1338, pX+math.random(3, 12), pY, pZ+rand)

            col1 = createMarker(pX+math.random(1, 5), pY+math.random(1, 5), pZ+rand, "corona", 1, math.random(0, 255), math.random(0, 255), math.random(0, 255), 160, root)
            col2 = createMarker(pX+math.random(1, 5), pY+math.random(1, 5), pZ+rand, "corona", 2, math.random(0, 255), math.random(0, 255), math.random(0, 255), 160, root)
            col3 = createMarker(pX+math.random(1, 5), pY+math.random(1, 5), pZ+rand, "corona", 4, math.random(0, 255), math.random(0, 255), math.random(0, 255), 160, root)
            col4 = createMarker(pX+math.random(1, 5), pY+math.random(1, 5), pZ+rand, "corona", 5, math.random(0, 255), math.random(0, 255), math.random(0, 255), 160, root)
            col5 = createMarker(pX+math.random(1, 5), pY+math.random(1, 5), pZ+rand, "corona", 3, math.random(0, 255), math.random(0, 255), math.random(0, 255), 160, root)

                    function flashMark()
                            if col1 and col2 and col3 and col4 and col5 and flashTimer then
                                setMarkerColor(col1, math.random(0, 255), math.random(0, 255), math.random(0, 255), 160)
                                setMarkerColor(col2, math.random(0, 255), math.random(0, 255), math.random(0, 255), 160)
                                setMarkerColor(col3, math.random(0, 255), math.random(0, 255), math.random(0, 255), 160)
                                setMarkerColor(col4, math.random(0, 255), math.random(0, 255), math.random(0, 255), 160)
                                setMarkerColor(col5, math.random(0, 255), math.random(0, 255), math.random(0, 255), 160)
                                else
                                killTimer(flashTimer)
                            end
                        end
                    flashTimer = setTimer(flashMark, 100, 7)

            setObjectScale(boom1, 2)
            setElementCollisionsEnabled(boom1, false)
            setObjectScale(boom2, 2)
            setElementCollisionsEnabled(boom2, false)
            setObjectScale(boom3, 2)
            setElementCollisionsEnabled(boom3, false)
            setObjectScale(boom4, 2)
            setElementCollisionsEnabled(boom4, false)
            setObjectScale(boom5, 2)
            setElementCollisionsEnabled(boom5, false)
            setObjectScale(boom6, 2)
            setElementCollisionsEnabled(boom6, false)
            setObjectScale(boom7, 2)
            setElementCollisionsEnabled(boom7, false)
            setObjectScale(boom8, 2)
            setElementCollisionsEnabled(boom8, false)
            setObjectScale(boom9, 2)
            setElementCollisionsEnabled(boom9, false)

            setTimer(destroyElement, 4000, 1, boom1)
            setTimer(destroyElement, 4000, 1, boom2)
            setTimer(destroyElement, 4000, 1, boom3)
            setTimer(destroyElement, 4000, 1, boom4)
            setTimer(destroyElement, 4000, 1, boom5)
            setTimer(destroyElement, 4000, 1, boom6)
            setTimer(destroyElement, 4000, 1, boom7)
            setTimer(destroyElement, 4000, 1, boom8)
            setTimer(destroyElement, 4000, 1, boom9)
            setTimer(destroyElement, 1000, 1, col1)
            setTimer(destroyElement, 1000, 1, col2)
            setTimer(destroyElement, 1000, 1, col3)
            setTimer(destroyElement, 1000, 1, col4)
            setTimer(destroyElement, 1000, 1, col5)

            local x, y, z = getElementPosition(boom1)
            triggerClientEvent("playBoom", root, x, y, z)

            setElementData(player, "rocket", getElementData(player, "rocket")-1)
        end, 7999, 1)


        else
        outputChatBox("* You already have "..tostring(maxRockets).." rocket(s)!", player, 255, 0, 0, false)
    end
end)
