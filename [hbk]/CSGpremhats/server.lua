addEvent("vipHats_changeHat",true)

local hatObjects = {}
local timers = {}
function changeHats(model,scale)

	if model then

		if isElement(hatObjects[source]) then
			destroyElement(hatObjects[source])
			hatObjects[source] = nil
			if isTimer(timers) then killTimer(timers[source]) end
		end
			hatObjects[source] = createObject(model, 0,0,-10 )
			setObjectScale(hatObjects[source],scale)
			exports.bone_attach:attachElementToBone(hatObjects[source],source,1,-0.0050,0.025,0.125,0,4,180)
			local p = source
			timers[p] = setTimer(function()
				local int,dim=getElementInterior(p),getElementDimension(p)
		--		setElementInterior(hatObjects[p],int)
		--		setElementDimension(hatObjects[p],dim)
			end,5000,1)


	else

		if isElement(hatObjects[source]) then destroyElement(hatObjects[source]) end
		if isTimer(timers) then killTimer(timers[source]) end

			hatObjects[source] = nil
			exports.dendxmsg:createNewDxMessage(source,"No longer wearing any hat",0,255,0)
		end



end

addEventHandler("vipHats_changeHat",root,changeHats)

addEventHandler("onPlayerQuit",root,function()
	if isElement(hatObjects[source]) then
		if isTimer(timers[source]) then
			killTimer(timers[source])
		end
			destroyElement(hatObjects[source])
			hatObjects[source] = nil

	end
end)
