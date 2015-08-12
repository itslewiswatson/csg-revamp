local flashbang = 0
addEventHandler( "onClientResourceStart", resourceRoot,
function()
    flashbang = 0
end
)
addEventHandler("onClientPlayerChoke", getLocalPlayer(),
function (weaponID, responsiblePed)
    if flashbang == 1 then
    if (weaponID==17) then
        cancelEvent()
    end
    end
end
)
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(),
--addEventHandler( "onClientPlayerDamage", getRootElement(),
function ( attacker, weapon, bodypart )
    local rflash, gflash, bflash = math.random (200, 250), math.random (200, 250), math.random (200, 250)
--    if (getPlayerTeam ( localPlayer ) == getPlayerTeam ( attacker )) and (localPlayer ~= attacker) then
    if ( weapon == 17 ) then
 if (getElementData(attacker, "fl") == false) then end
 if (getElementData(attacker, "fl") == true) then
    cancelEvent()
        if (getPlayerTeam ( localPlayer ) == getPlayerTeam ( attacker )) and (localPlayer ~= attacker) then
        --cancelEvent()
        end

        if (getPlayerTeam ( localPlayer ) ~= getPlayerTeam ( attacker )) or (localPlayer == attacker) then
        fadeCamera ( false, 1.5, rflash, gflash, bflash)
        setTimer(function() fadeCamera ( true ) end, 1000, 1)
    --    cancelEvent()
        end

        if not getPlayerTeam ( localPlayer ) then
    --    cancelEvent()
        fadeCamera ( false, 1.5, rflash, gflash, bflash)
        setTimer(function() fadeCamera ( true ) end, 1000, 1)
        end

    end
    end
end  )
addCommandHandler("bang",
function ()
    if flashbang == 0 then
        setElementData(localPlayer, "fl", true)
        flashbang = 1
        exports.DENdxmsg:createNewDxMessage("Flashbang Enabled (On)", 0,255,0)
    elseif flashbang == 1 then
        setElementData(localPlayer, "fl", false)
        exports.DENdxmsg:createNewDxMessage("Flashbang Disabled (Off)", 255,255,0)
        flashbang = 0
    end
end)
--addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), bangftw )
addEventHandler( "onClientResourceStop", resourceRoot,
function()
    flashbang = 0
end
)
