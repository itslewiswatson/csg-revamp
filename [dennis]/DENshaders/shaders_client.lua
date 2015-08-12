local switch = function (state)
	if state then
		EnableCarReflect()
		enableDetail()
		enableWaterEffect()
	else
		DisableCarReflect()
		disableDetail()
		disableWaterEffect()
	end
end

addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,function (setting,state) if setting == "shaders" then switch(state) end end)

function checkSetting()
	outputDebugString(tostring(getResourceRootElement(getResourceFromName("DENsettings"))))
	if getResourceRootElement(getResourceFromName("DENsettings")) then
		local setting = exports.densettings:getPlayerSetting("shaders")
		switch(setting)
	else
		setTimer(checkSetting,5000,1)
	end
end
addEventHandler("onClientResourceStart",resourceRoot,checkSetting)
