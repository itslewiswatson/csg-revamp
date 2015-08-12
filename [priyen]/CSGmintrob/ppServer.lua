local warps = {
	--x,y,z,dim,int,todim,toint,tox,toy,toz,to rz
	{ 2206.51, 1552.11, 1007.92,1,1,0,0,-2445.14, 522.76, 29.92 ,270},
	{ -2447.37, 523.17, 30.35,0,0,1,1,2206.51, 1552.11, 1007.92,270},
}

local markers = {}
local cd = {}

function start()
	for k,v in pairs(warps) do
		local x,y,z,dim,int,ti,td,tx,ty,tz,rz = unpack(v)
		local m = createMarker(x,y,z,"arrow",2,255,255,0)
		setElementInterior(m,int)
		setElementDimension(m,dim)
		addEventHandler("onMarkerHit",root,function(p)
			if (cd[p]) then return end
			if isElement(p) and getElementType(p) == "player" and not isPedInVehicle(p) then
				setElementInterior(p,ti,tx,ty,tz)
				setElementRotation(p,0,0,rz)
				setElementDimension(p,td)
				cd[p] = true
				setTimer(function() cd[p]=nil end,1000,1)
			end
		end)
	end
end
