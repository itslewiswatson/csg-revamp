local data = {
	{
		{
			{x=684.7509765625,y=848.8125,z=-40.036594390869,rx=0,ry=0,rz=34.066375732422},
			{x=654.1142578125,y=866.58984375,z=-33.793701171875,rx=0,ry=0,rz=21.920806884766}
		},
		{
			{x=654.1142578125,y=866.58984375,z=-33.793701171875,rx=0,ry=0,rz=21.920806884766},
			{x=653.0205078125,y=867.513671875,z=-36.076290130615,rx=0,ry=0,rz=241.63973999023},
		},
		{
			{x=653.0205078125,y=867.513671875,z=-36.076290130615,rx=0,ry=0,rz=241.63973999023},
			{x=619.982421875,y=886.5263671875,z=-29.839939117432,rx=0,ry=0,rz=57.692840576172},
		},
	}

}

local markers = {}
local moveToData = {}
addCommandHandler("gpos",function(ps)
	local x,y,z = getElementPosition(ps)
	--local z = getGroundPosition(x,y,z)
	local r1,r2,r3 = getElementRotation(ps)
	local v = {x,y,z,r1,r1,r3}
	outputChatBox("{x="..v[1]..",y="..v[2]..",z="..v[3]..",rx="..v[4]..",ry="..v[5]..",rz="..v[6].."},",ps)
end)

addCommandHandler("startquarry",function()
	setTimer(doQuarry,3000,0)
end)

function doQuarry()
	local obj = createObject(1305,684.7509765625,848.8125,-40.036594390869)
	local past=20000
	for k,v in pairs(data) do
		past=past+20000
	end
	setObjectScale(obj,0.3)
	moveObject(obj, 654.1142578125, 866.58984375, -33.793701171875,20000)

end


function start()
	for k,v in pairs(data) do
		for k2,v2 in pairs(v) do
			local m = createMarker(v2[1].x,v2[1].y,v2[1].z-0.7,"cylinder",2)
			addEventHandler("onMarkerHit",m,function(e)
				if getElementType(e) ~= "player" and getElementType(e) ~= "vehicle" then
					moveObject(e,v2[2].x,v2[2].y,v2[2].z,10000)
				end
			end)
			local m2 = createMarker(v2[2].x,v2[2].y,v2[2].z-0.7,"cylinder",2)
		end
	end
end
start()
