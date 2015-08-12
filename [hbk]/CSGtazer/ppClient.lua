
aeh=addEventHandler
ae=addEvent
tse=triggerServerEvent

function tazed(p)
	fadeCamera(false,2,0,0,0)
	toggleControl("sprint",false)
	setTimer(fadeCamera,2000,1,true)
	setTimer(function() toggleControl("sprint",true) end,2000,1)
end
ae("tazed",true)
aeh("tazed",localPlayer,tazed)
sx,sy = guiGetScreenSize()
sy=sy/2
sx=sx/2
enabled=true
x,y,z,x2,y2,z2=0,0,0,0,0,0
local pos = {}
local doingEffect=false
function doEffect(xx,yy,zz,xx2,yy2,zz2,p)

	if enabled==false then return end
	table.insert(pos,{xx,yy,zz,xx2,yy2,zz2,p})
	local num = xx
	addEventHandler("onClientRender",root,draw)
	setTimer(function() removeEventHandler("onClientRender",root,draw)
		for k,v in pairs(pos) do
			if v[1] == num then
				table.remove(pos,k)
				return
			end
		end

	end,500,1)
end
addEvent("tazDrawC",true)
addEventHandler("tazDrawC",localPlayer,doEffect)

function draw()
		for k,v in pairs(pos) do
		local x,y,z = v[1],v[2],v[3]
		local x2,y2,z2 = getPedBonePosition(v[7],2)

		dxDrawLine3D(x,y,z,x2+math.random(-2,2)/3,y2+math.random(-2,2)/3,z2+math.random(-2,2)/3,tocolor(255,255,0,255))
		dxDrawLine3D(x,y,z,x2+math.random(-2,2)/3,y2+math.random(-2,2)/3,z2+math.random(-2,2)/3,tocolor(255,255,0,255))
		dxDrawLine3D(x,y,z,x2+math.random(-2,2)/3,y2+math.random(-2,2)/3,z2+math.random(-2,2)/3,tocolor(255,255,0,255))
		dxDrawLine3D(x,y,z,x2+math.random(-2,2)/3,y2+math.random(-2,2)/3,z2+math.random(-2,2)/3,tocolor(255,255,0,255))
		dxDrawLine3D(x,y,z,x2+math.random(-2,2)/3,y2+math.random(-2,2)/3,z2+math.random(-2,2)/3,tocolor(255,255,0,255))
		dxDrawLine3D(x,y,z,x2+math.random(-2,2)/3,y2+math.random(-2,2)/3,z2+math.random(-2,2)/3)
		dxDrawLine3D(x,y,z,x2+math.random(-2,2)/3,y2+math.random(-2,2)/3,z2+math.random(-2,2)/3,tocolor(255,255,0,255))
		dxDrawLine3D(x,y,z,x2+math.random(-2,2)/3,y2+math.random(-2,2)/3,z2+math.random(-2,2)/3,tocolor(255,255,0,255))
		dxDrawLine3D(x,y,z,x2+math.random(-2,2)/3,y2+math.random(-2,2)/3,z2+math.random(-2,2)/3,tocolor(255,255,0,255))
		end
end

addEventHandler("onClientPlayerWeaponFire",root,function(wep,ammo,clip,hx,hy,hz,he)
	if isElement(he) == false then return end
	if getElementType(he) == "player" then
		if wep == 23 then
			if source==localPlayer then
				local tName=getTeamName(getPlayerTeam(localPlayer))
				if tName == "Police" or tName=="Military Forces" or tName=="SWAT" or tName=="Government Agency" then

				else
					return
				end
				setElementFrozen(localPlayer,true) setTimer(setElementFrozen,750,1,localPlayer,false)
				x,y,z=getWorldFromScreenPosition(sx,sy,3)
				z=z+0.2
				x2,y2,z2 = hx,hy,hz
				triggerServerEvent("tazDraw",localPlayer,x,y,z,x2,y2,z2,he)
			end
		end
	end
end)

tazerTXD = engineLoadTXD ( "silenced.txd" )
engineImportTXD ( tazerTXD, 347 )
tazerDFF = engineLoadDFF ( "silenced.dff", 347 )
engineReplaceModel ( tazerDFF, 347 )

