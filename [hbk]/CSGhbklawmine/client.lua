addEventHandler("onClientPlayerWeaponFire",localPlayer,function(_, _, _, _, _, _,mine)

        if mine and getElementModel(mine) == 1510 then
            triggerServerEvent("destroy",localPlayer,mine)
        end

end)

addEvent("play",true)
addEventHandler("play",localPlayer,
    function ()
        playSound("sound.wav")
    end )


addEvent("play2",true)
addEventHandler("play2",localPlayer,
    function ()
        playSound("mission.mp3")
    end )
