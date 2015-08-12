local switch = function (state)
	if state then
		enableDetail()
	else
		disableDetail()
	end
end

addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,function (setting,state) if setting == "shaders" then switch(state) end end)


addEventHandler("onClientResourceStart",resourceRoot,
	function ()
		if getResourceRootElement(getResourceFromName("DENsettings")) then
			local setting = exports.densettings:getPlayerSetting("shaders")
			switch(setting)
		end
	end
)