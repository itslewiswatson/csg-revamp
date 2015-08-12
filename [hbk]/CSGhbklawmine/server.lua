local mines=  {}
local timers = {}
local allowedTeams = {
        ["Military Forces"] = true,
        ["Government Agency"] = true,
        ["SWAT"] = true,
		["Staff"] = true,
    }
local playerMines = {}
function mine (source)
    if getElementData(source,"skill") == "Explosives Unit" then
    if isElement(source) then
        --local data = getElementData(mar)
        local x,y,z = getElementPosition(source)
        if playerMines[source] == nil then playerMines [source] = 0 end
        if playerMines[source] == 1 then
            exports.DENdxmsg:createNewDxMessage ( "You already placed a Mine!", source, 255, 255, 0 )
        return
         end
       money = getPlayerMoney (source)
       if (money >= 2500) then
		 takePlayerMoney(source, 2500)
        playerMines [source]=playerMines [source]+1
        local landmine = createObject ( 1510, x,y,z - .999, 0, 0, 3.18 )
        local landmineCol = createColSphere( x,y,z, 3 )
        setPedAnimation(source,"BOMBER","BOM_Plant",3000,false,true)
        mar = createMarker(x,y,z+0.2,"corona",0.5,0,0,90,120)
        mines[landmine] =  {landmineCol,mar}
        attachElements ( mar, landmine )
        triggerClientEvent(source,"play",source)
        setElementData ( landmine, "owner",source)
        setElementData ( landmine, "team", getPlayerTeam(source))
        setElementData ( landmine, "col", landmineCol)
        setElementData(landmineCol,"lm",landmine)
                timers[landmine] = setTimer(function()
            if landmine ~= nil and isElement(landmine) then
                destroyElement(mines[landmine][1])
                destroyElement(mines[landmine][2])
                mines[landmine]=nil
                destroyElement(landmine)
            end
        end,300000,1)
        exports.DENdxmsg:createNewDxMessage ( "Mine has been planted!", source, 0, 0, 255 )
        else
		        exports.DENdxmsg:createNewDxMessage ( "You do not have enough money!", source, 255, 0, 0 ) return end

        -- setElementData(landmine,"number",
        end
    end
    end
addCommandHandler( "lmine", mine )
addCommandHandler("delmine",function(source)
    if isElement(source) then
        for k,v in pairs(mines) do
            if isElement(k) then
                if getElementData(k,"owner") == source then
                    if isElementWithinColShape(source,v[1]) then
                        playerMines[source]=playerMines[source]-1
                        destroyElement(mines[k][1])
                        destroyElement(mines[k][2])
                        mines[k]=nil
                        destroyElement(k)
					    destroyElement(mar)
                    end
                end
            end
        end
    end
end)
addEventHandler("onColShapeHit",root,function(hitElement)
    if getElementType(hitElement) == "player" then
      if getPlayerWantedLevel(hitElement) == 0 then return end
        if getElementData(source,"type") == "lmine" then
            setElementData(hitElement,"sourceMine",source)
            local landmine = getElementData(source,"lm")
            if getPlayerTeam(hitElement) ~= getElementData(landmine,"team") then
                local x,y,z = getElementPosition ( source )
                                            local owner = getElementData(landmine,"owner")
                if playerMines[owner] ~= nil then
                    playerMines[owner]=playerMines[owner]-1
                end
                if isElement(owner) then
                    triggerClientEvent(owner,"play2",owner)
                end
                  if timers[landmine] ~= nil then
                    if isTimer(timers[landmine]) then killTimer(timers[landmine]) end
                end
                local mar = mines[landmine][2]
				createExplosion (x,y,z,8,owner)
                destroyElement(landmine)
                destroyElement(source)
                destroyElement(mar)
                removeElementData(hitElement,"sourceMine")

            end
            end
        end
    end )

addEvent("destroy",true)
addEventHandler("destroy",root,function(mine)
	if not(mines[mine]) then return end
    local x,y,z = getElementPosition(mine)
    local lmCol = getElementData(mine,"col")
	local owner = getElementData(mine,"owner")
    createExplosion(x,y,z,8,owner)

	local mar = mines[mine][2]
	if playerMines[owner] ~= nil then
		playerMines[owner]=playerMines[owner]-1
	end
    destroyElement(mar)
    destroyElement(mine)
    destroyElement(lmCol)
    triggerClientEvent(source,"play2",source)
end)
