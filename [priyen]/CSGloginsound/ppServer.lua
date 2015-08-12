addEvent("lcheck",true)
addEventHandler("lcheck",root,function()
	if exports.server:isPlayerLoggedIn(source) then
		triggerClientEvent(source,"CSGintro.login",source)
	end
end)

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	triggerClientEvent(source,"CSGintro.login",source)
end)
