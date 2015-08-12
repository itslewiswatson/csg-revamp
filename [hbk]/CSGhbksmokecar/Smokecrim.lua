local cd = {}
addEventHandler("onPlayerQuit",root,function() if (cd[source]) then cd[source]=nil end end)
local allowedTeamss = {
		["Staff"] = true,
    }
       function smokesystem(player)
       if (allowedTeamss[getTeamName(getPlayerTeam(player))]) then
    if (isElement(player)) then
        if (getPedOccupiedVehicle(player)) then
            local driver = getPedOccupiedVehicle(player,0)
			if getVehicleController(getPedOccupiedVehicle(player)) == player then
            if ( driver ) then
                mmoney = getPlayerMoney (player)
             --   if (mmoney >= 2000) then
                    if (cd[player]) then
                        if getTickCount() - cd[player] <= 300000 then
                            exports.dendxmsg:createNewDxMessage(player,"Please wait before trying to buy smoke system again",255,0,0)
                            return
                        end
                    else
                        cd[player] = getTickCount()
                    end
                    cd[player] = getTickCount()
               --     takePlayerMoney(player,4000)
                    x,y,z = getElementPosition(driver)
                    smokesys = createObject(2780,x,y,z)
                    attachElements(smokesys,driver,0,-2,-0.5)
                    setElementCollisionsEnabled(smokesys,false)
                    setElementAlpha(smokesys,0) --hide this for a better effect
                    setTimer(destroyElement,50000,1,smokesys)
               -- else
                 --   exports.dendxmsg:createNewDxMessage(player,"You dont have enough Money for a smoke system.",255,0,0)
                 --   return false
                end
            else
                return false --return if the driver isn't found for some strange reason
            end
        else
            return false --return if the player isn't in a vehicle
        end
    else
        return false --return if the player isn't even found at all
    end
end
end

addCommandHandler("cs",smokesystem)
