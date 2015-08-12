aeh=addEventHandler
ae=addEvent
tce=triggerClientEvent
local tazedT = {}
function tazed(p)
	if tazedT[p] == nil then
		tazedT[p]=false
	end
	if tazedT[p]==true then return end
	tazedT[p]=true
	tce(p,"tazed",p)
	setTimer(function()
		toggleControl(p,"jump",false)
		toggleControl(p,"sprint",false)
		setControlState(p,"walk",true)
	end,2000,1)
	setTimer(function()
		tce(p,"tazed",p)
		setPedAnimation(p, "CRACK", "crckidle2")
		setTimer(setPedAnimation, 3000, 1, p)
		toggleControl(p,"jump",false)
		toggleControl(p,"sprint",false)
		setControlState(p,"walk",true)
	end,5000,1)
	setTimer(function()
		toggleControl(p,"jump",true)
		toggleControl(p,"sprint",true)
		setControlState(p,"walk",false)
		tazedT[p]=false
	end,8000,1)
end
addCommandHandler("tazme",tazed)

local  tazDrawPos = {}

addEvent("tazDraw",true)
addEventHandler("tazDraw",root,function(x,y,z,x2,y2,z2,p)
	tazDrawPos[p] = {x,y,z,x2,y2,z2}

end)
addEventHandler("onPlayerQuit",root,function() tazDrawPos[source] = nil end)

-- Serverside part when player got tazerd, source is the officer
--addEvent("onWantedPlayerGotTazerd", true)
function onWantedPlayerGotTazerd ( p )

	if tazDrawPos[p] ~= nil then
		local x,y,z = tazDrawPos[p][1],tazDrawPos[p][2],tazDrawPos[p][3]
		local x2,y2,z2 = tazDrawPos[p][4],tazDrawPos[p][5],tazDrawPos[p][6]
		for k,v in pairs(getElementsByType("player")) do
			triggerClientEvent(v,"tazDrawC",v,x,y,z,x2,y2,z2,p)
		end
		tazDrawPos[p]=nil
	end
end
addEvent("serverDrawTaz",true)
addEventHandler("serverDrawTaz",root,onWantedPlayerGotTazerd)
