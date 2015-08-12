local paths = {
	{{ 957.48, -2115.76, -0.32},{ 957.32, -2102.96, 0.16 }},
		{{ 957.13, -2093.93, -0.13},{960.16, -2062.28, -0.13}}
	--		{{933,-1992,-1},{930,-2058,-1}}
}
local sharks = {}

local count = {
	1,
	1
}

function hitMarker(e,dim)
	if dim == true then
		if getElementType(e) == "player" then
			if exports.server:isPlayerStaff(e) == true then return end
			killPed(e)
			 exports.DENdxmsg:createNewDxMessage(e,"You got eaten by a shark",255,0,0)
		end
	end
end

function circle(r,s,cx,cy)
	xVals = {}
	yVals = {}
	for i=1,s-1 do
		xVals[i] = (cx+r*math.cos(math.pi*i/s*2-math.pi/2))
		yVals[i] = (cy+r*math.sin(math.pi*i/s*2-math.pi/2))
		--outputChatBox('('..xVals[i]..','..yVals[i]..')')
	end
end
circle(30,200,917,-2078)

function doIt()
	for k,v in pairs(sharks) do
		local i = count[k]
		count[k]=count[k]+1
		i=i+1
		if paths[k][i] == nil then i = 1 count[k]=1 end
		--local i = math.random(1,#xVals)
		--local x,y,z = xVals[i],yVals[i],-1
		local x,y,z = paths[k][i][1],paths[k][i][2],paths[k][i][3]
		local x0,y0 = getElementPosition(v)
		local rx,ry = getElementRotation(v)
		local rz = findRot(x0,y0,x,y)
		setElementRotation(v,rx,ry,rz+90)
		moveObject(v,7500,x,y,z)

	end
end
setTimer(doIt,7500,0)

findRot = function(a, b, c, d)
  local X = math.abs(c - a)
  local Y = math.abs(d - b)
  Rotm = math.deg(math.atan2(Y, X))
  if a <= c and b < d then
    Rotm = 90 - Rotm
  elseif c <= a and b < d then
    Rotm = 270 + Rotm
  elseif a <= c and d <= b then
    Rotm = 90 + Rotm
  elseif c < a and d <= b then
    Rotm = 270 - Rotm
  end
  return 630 - Rotm
end


for k,v in pairs(paths) do
	local o = createObject(1608,v[1][1],v[1][2],v[1][3])
	table.insert(sharks,o)
	local m = createMarker(v[1][1],v[1][2],v[1][3],"cylinder",3,255,255,255,0)
	addEventHandler("onMarkerHit",m,hitMarker)
	attachElements(m,o)
end
