local mines=  {}
local timers = {}
local allowedTeams = {
        ["Criminals"] = true,
    }
local playerMines = {}
LVcol = createColRectangle(866,656,2100,2300)
function mine (source)
    if getElementData(source,"Rank") == "Bomb Expert" then
	if isElementWithinColShape(source,LVcol) == false then
		exports.dendxmsg:createNewDxMessage(source,"You can only plant a mine in LV!",255,0,0)
		return
	end
    if isElement(source) then
    --local data = getElementData(mar)
        local x,y,z = getElementPosition(source)
        if playerMines[source] == nil then playerMines [source] = 0 end
        if playerMines [source] == 1 then
            exports.DENdxmsg:createNewDxMessage ( "You already placed mines!", source, 255, 255, 0 )
        return
         end
		 local money = getPlayerMoney(source)
		if (money >= 3000) then

        playerMines [source]=playerMines [source]+1
        local landmine = createObject ( 1510, x,y,z - .999, 0, 0, 3.18 )
        local landmineCol = createColSphere( x,y,z, 3 )
        setPedAnimation(source,"BOMBER","BOM_Plant",3000,false,true)
        mar = createMarker(x,y,z+0.2,"corona",0.5,100,0,250,120)
        mines[landmine] =  {landmineCol,mar}
        attachElements ( mar, landmine )
		takePlayerMoney (source, 3000)
        triggerClientEvent(source,"playCrim",source)
        setElementData ( landmine, "owner",source)
        setElementData ( landmine, "col", landmineCol)
        setElementData(landmineCol,"type","mine")
        setElementData(landmineCol,"lm",landmine)
                timers[landmine] = setTimer(function()
            if landmine ~= nil and isElement(landmine) then
                destroyElement(mines[landmine][1])
                mines[landmine]=nil
                destroyElement(landmine)
            end
        end,300000,1)

		exports.DENdxmsg:createNewDxMessage ( "Mine has been planted!", source, 100, 0, 250 )

        -- setElementData(landmine,"number",
        else
        exports.DENdxmsg:createNewDxMessage ( "You do not have enough money, you need $3000", source, 255, 0, 0 ) return end
    end
    end
	end
addCommandHandler( "cmine", mine )
addCommandHandler("delmine",function(source)
    if isElement(source) then
        for k,v in pairs(mines) do
            if isElement(k) then
                if getElementData(k,"owner") == source then
                    if isElementWithinColShape(source,v[1]) then
						local mar = v[2]
                        playerMines[source]=playerMines[source]-1
                        destroyElement(mines[k][1])
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
        if getElementData(source,"type") == "mine" then
            setElementData(hitElement,"sourceMine",source)
            local landmine = getElementData(source,"lm")
                local x,y,z = getElementPosition ( source )
                local owner = getElementData(landmine,"owner")
                if playerMines[owner] ~= nil then
                    playerMines[owner]=playerMines[owner]-1
                end
                if isElement(owner) then
                    triggerClientEvent(owner,"play2Crim",owner)
                end
                  if timers[landmine] ~= nil then
                    if isTimer(timers[landmine]) then killTimer(timers[landmine]) end
                end
                createExplosion (x,y,z,8,owner)
                removeElementData(hitElement,"sourceMine")
				destroyElement(mines[landmine][1])
				destroyElement(mines[landmine][2])
				destroyElement(landmine)
            end
            end
        end )

addEvent("destroyCrim",true)
addEventHandler("destroyCrim",root,function(mine)
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
    triggerClientEvent(source,"play2Crim",source)
end)
