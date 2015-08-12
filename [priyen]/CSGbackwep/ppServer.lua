local skins = {
	[285] = -0.11,
	[115] = -0.11,
	[232] = -0.12,
	[225] = -0.05,
	[228] = -0.08,
	[229] = -0.07
}

local wepsData = {}
local closer = {
	226,229,230,231,233,234,235,236,237,238,152,178,194,243,244,245,246,251,218,256,257,263,87, 88, 90, 91, 92, 93, 94,298,101
}

for i=0,300 do if skins[i] == nil then skins[i]=-0.11 end end
for k,v in pairs(closer) do
	if skins[v] ~= -0.11 then
		skins[v] = -0.06
	end
end

local timersP = {

}

local objs = {}
local models = {
[2]=333,
[3]=334,
[4]=335,
[5]=336,
[6]=337,
[7]=338,
[8]=339,
[9]=341,
[25]=349,
[26]=350,
[27]=351,
[28]=352,
[29]=353,
[32]=372,
[30]=355,
[31]=356,
[33]=357,
[34]=358,
[15]=326,
[39]=363
}



local priorities = {}
local enabled = {}
--[[
function getPriorityWeapon(ps)
	if enabled[ps] == nil then
		enabled[ps]=false
		return nil
	end
	if priorities[ps] == nil then
		local t = {}
		for i=1,12 do t[i]=i end
		priorities[ps]=t
	end
	if priorities[ps] ~= nil then
		local priority=0
		local slot=nil
		for k,v in pairs(priorities[ps]) do
			if v > priority then
				slot=k
				priority=v
			end
		end
		--code to get weapon from slot
		return slot
	end
end
--]]
function makeWep(ps,id)
	setElementModel(objs[ps],models[id])
	setElementAlpha(objs[ps],255)
	detachElements(objs[ps])
	exports.bone_attach:attachElementToBone(objs[ps],ps,3,0,skins[getElementModel(ps)],-0.2,355,265,180)
	--[[if objs[ps] == nil then objs[ps]=false end
	if isElement(objs[ps]) then
		if getElementModel(objs[ps]) == models[id] then return end
		setElementModel(objs[ps],models[id])
		return
	end
	destroy(ps)
	if id == nil then return end
	if timersP[ps] == nil then
		timersP[ps]=false
	end
	if timersP[ps]==false or isTimer(timersP[ps]) == false then
		local obj = createObject(models[id],1,1,1)
		setElementInterior(obj,getElementInterior(ps))
		setElementDimension(obj,getElementDimension(ps))
		exports.bone_attach:attachElementToBone(obj,ps,3,0,skins[getElementModel(ps)],-0.2,355,265,180)
		objs[ps]=obj
		timersP[ps]=setTimer(function()
			if isElement(obj) == false then destroy(ps) killTimer(timersP[ps]) end
			setElementInterior(obj,getElementInterior(ps))
			setElementDimension(obj,getElementDimension(ps))
		end,1000,0)
	end--]]

end

addEventHandler("onPlayerWeaponSwitch",root,function(oldID,newID)
	updateForPlayer(source,newID)
end)

addEventHandler("onPlayerQuit",root,function()
   destroy(source)
   destroyElement(objs[source])
   killTimer(timersP[source])
   timersP[source]=nil
end)

addEventHandler("onPlayerLogin",root,function()
	begin(source)
end)

function begin(ps)
	if not isElement(ps) then return false end
	local obj = createObject(331,1,1,1)
		setElementAlpha(obj,0)
		setElementInterior(obj,getElementInterior(ps))
		setElementDimension(obj,getElementDimension(ps))
		exports.bone_attach:attachElementToBone(obj,ps,2,0,skins[getElementModel(ps)],-0.1,355,265,180)
		objs[ps]=obj
		timersP[ps]=setTimer(function()
			if not ( isElement(ps) and isElement(obj) ) then 
				if (isTimer(timersP[ps])) then
					killTimer(timersP[ps]) 			
				end
				if isElement(obj) then destroyElement(obj) end
				return 
			end
			
			if getElementInterior(obj) ~= getElementInterior(ps) then
				setElementInterior(obj,getElementInterior(ps))
			end
			if getElementDimension(obj) ~= getElementDimension(ps) then
				setElementDimension(obj,getElementDimension(ps))
			end
		end,1000,0)
end

function destroy(p)
	setElementAlpha(objs[p],0)
	setElementModel(objs[p],331)
	--[[
	if objs[p] ~= nil and isElement(objs[p]) then
		destroyElement(objs[p])
		if timersP[p] ~= nil and isTimer(timersP[p]) then
			killTimer(timersP[p])
		end
	end--]]
end

function updateForPlayer(p,n)
	if wepsData[p] == nil then return end

	local id = getPedWeapon(p)
	if (n) then id=n end
	local name = getWeaponNameFromID(id)
	if name ~= wepsData[p][1] and wepsData[p][1] ~= "" then
		makeWep(p,getWeaponIDFromName(wepsData[p][1]))
	elseif wepsData[p][2] ~= "" and getElementModel(objs[p]) ~= models[getWeaponIDFromName(wepsData[p][2])]then
		makeWep(p,getWeaponIDFromName(wepsData[p][2]))
	else
		if isElement(objs[p]) then
			local m = getElementModel(objs[p])
			for k,v in pairs(models) do
				if v == m then
					local nam = getWeaponNameFromID(k)
					if (nam==wepsData[p][2] and wepsData[p][1]=="") or (nam ~= wepsData[p][2] and nam ~= wepsData[p][1]) or (nam == wepsData[p][2] and wepsData[p][1] == "") or (nam ~= wepsData[p][1] and nam ~= wepsData[p][2]) or (nam == wepsData[p][1] and wepsData[p][2] == "")  then
						destroy(p)
						break
					end
				end
			end
		end
	end
end

addEvent("recBack",true)
addEventHandler("recBack",root,function(prim,sec)
	if prim == false then prim="" end if sec==false then sec = "" end
	wepsData[source]={prim,sec}
	updateForPlayer(source)
end)

for k,v in ipairs(getElementsByType("player")) do
	begin(v)
end
