addEvent("CSGStaff.basemod.start",true)
addEvent("CSGStaff.basemod.restart",true)
addEvent("CSGStaff.basemod.stop",true)

local baseModRes = function (res)
	if not isPlayerBaseMod(source) then return false end
	if not baseModResList[res] then return false end
	local res = getResourceFromName(res)
	if res then
		if eventName == "CSGStaff.basemod.start" and getResourceState(res) ~= "running" then
			startResource(res)
		elseif eventName == "CSGstaff.basemod.restart" and getResourceState(res) == "running" then
			restartResource(res)
		elseif eventName == "CSGStaff.basemod.stop" and getResourceState(res) == "running" then
			stopResource(res)
		end
	else
		exports.DENdxmsg:createNewDxMessage(source,"This resource could not be found",255,0,0)
	end
end

addEventHandler("CSGStaff.basemod.start",root,baseModRes)
addEventHandler("CSGStaff.basemod.restart",root,baseModRes)
addEventHandler("CSGStaff.basemod.stop",root,baseModRes)
