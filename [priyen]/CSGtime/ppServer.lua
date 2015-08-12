local day = 1
local h = 0
days = {
	"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"
}

function  upTime()
	h=h+1
	if h == 24 then
		h=0
		day=day+1
		if day == 8 then day = 1 end
		newDay()
		setTime(0,0)
	else
		setTime(h,0)
	end
end
setTimer(upTime,60000,0)

function newDay()
	triggerClientEvent(root,"CSGtime.newDay",root,day)
end
setMinuteDuration( 1000 )
setTime(0,0)

addEventHandler("onPlayerLogin",root,function()
	local h,m = getTime()
	setTime(h,m)
	triggerClientEvent(source,"CSGtime.newDay",source,day)
end)
