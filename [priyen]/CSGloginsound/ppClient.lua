sound=playSound("intro.mp3")

camTimer = setTimer(function()
	local t = getElementsByType("player")
	local i = math.random(#t)
	setCameraTarget(t[i])

end,3000,0)

addEvent("CSGintro.login",true)
addEventHandler("CSGintro.login",localPlayer,function()
	if isElement(sound) then stopSound(sound) end
	killTimer(camTimer)
	setCameraTarget(localPlayer)
end)

triggerServerEvent("lcheck",localPlayer)
