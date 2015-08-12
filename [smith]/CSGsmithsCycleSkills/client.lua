	text = ""
	stat = 0
	r = tonumber(0)
	g = tonumber(255)
	b = tonumber(0)
local cycle = 0
local bike = 0

function drawText()
	sx,sy = guiGetScreenSize()
	dxDrawRectangle((1057/1268)*sx, (619/768)*sy, (183/1268)*sx, (23/768)*sy, tocolor(0, 0, 0, 196), false)
	dxDrawRectangle((1060/1268)*sx, (622/768)*sy, (stat/1268)*sx, (17/768)*sy, tocolor(r, g, b, 196), false)
	dxDrawText(text, (1057/1268)*sx, (570/768)*sy, (1237/1268)*sx, (693/768)*sy, tocolor(255,255,255, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
end

 function setStats(ptext,pstat,rc,gc,bc)
	text = ptext
	stat = tonumber(pstat)
	r = tonumber(rc)
	g = tonumber(gc)
	b = tonumber(bc)
end

addEvent ("setCycleSkillsData", true)
function setCycleSkillsData ( cyclestats )
	local pstat = 1.78 * (cyclestats/10)
	ptext = tostring("Cycle Skills:  "..math.ceil(cyclestats/10).. " % ")
	setStats(ptext,pstat,0,255,0)
end
addEventHandler ("setCycleSkillsData", localPlayer, setCycleSkillsData)


addEvent ("setBikeSkillsData", true)
function setBikeSkillsData ( bikestats )
	local pstat = 1.78 * (bikestats/10)
	ptext = tostring("Bike Skills:  "..math.ceil(bikestats/10).. " % ")
	setStats(ptext,pstat,0,255,0)
end
addEventHandler ("setBikeSkillsData", localPlayer, setBikeSkillsData)

addEventHandler("onClientVehicleExit", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
			removeEventHandler("onClientRender", getRootElement(), drawText)
        end
    end
)

addEventHandler("onClientVehicleEnter",root,function(p)
	if p == localPlayer then
		local typ=getVehicleType(source)
		if typ=="BMX" or typ=="Bike" then
			if getVehicleController(source) == localPlayer then
				addEventHandler("onClientRender", getRootElement(), drawText)
			end
		end
	end
end)

