sx,sy = guiGetScreenSize()
function wantNeon(state)
	if state == true then
		addEventHandler("onClientPreRender",root,loop)
	else
		removeEventHandler("onClientPreRender",root,loop)
	end
end

function loop()
	for i,veh in ipairs(getElementsByType("vehicle")) do
		x,y,z = getElementPosition(veh)
		a,b,c = getElementPosition(getLocalPlayer())
		dis = getDistanceBetweenPoints3D(x,y,z,a,b,c)
		vis = isElementOnScreen(veh)
		if vis and dis < 50 then
			x,y,rot = getElementRotation(veh)
			if x < 50 or x > 310 then
				if y < 50 or y > 310 then
					if getElementData(veh,"neonlight") ~= "off" then
						drawIt(veh,rot)
					end
				end
			end
		end
	end
end
addEventHandler("onClientPreRender",root,loop)

function drawIt(veh,rot)
	x,y,z = getElementPosition(veh)
	az = getGroundPosition(x,y,z)
	dis = getDistanceBetweenPoints3D(x,y,z,x,y,az)
	if dis < 2 then
		a = 100
		model = getElementModel(veh)
		data = getElementData(veh,"neonlight")
		if data then
			r = tonumber(gettok(data,1,string.byte(",")))
			g = tonumber(gettok(data,2,string.byte(",")))
			b = tonumber(gettok(data,3,string.byte(",")))
			ck = tonumber(gettok(data,4,string.byte(",")))
			--if ck and ck <= 255 and ck >= 0 then a = ck end
			rot = rot
			if 1 == 1 then
				rx,ry,rz = getElementRotation(veh)
				x,y,z = getElementPosition(veh)
				r3 = rz-30
				r4 = rz-150
				r3 = math.abs(r3-360)
				r4 = math.abs(r4-360)
				r1 = r3-60
				r2 = r4-300
				r1 = math.rad(r1)
				r2 = math.rad(r2)
				r3 = math.rad(r3)
				r4 = math.rad(r4)
				cr1 = math.cos(r1)
				sr1 = math.sin(r1)
				cr2 = math.cos(r2)
				sr2 = math.sin(r2)
				cr3 = math.cos(r3)
				sr3 = math.sin(r3)
				cr4 = math.cos(r4)
				sr4 = math.sin(r4)
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)
				cr1 = 1.03*cr1
				sr1 = 1.03*sr1
				cr2 = 1.03*cr2
				sr2 = 1.03*sr2
				cr3 = 1.03*cr3
				sr3 = 1.03*sr3
				cr4 = 1.03*cr4
				sr4 = 1.03*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+x
				y3 = cr3+y
				x4 = sr4+x
				y4 = cr4+y
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)
				--factor
				ffactor,bfactor = 1.65,1.5 
				--front
				_,_,rz = getElementRotation(veh)
				rb = math.abs(rz-360)
				rb = rb-180
				rb = math.rad(rb)
				crb = bfactor*math.cos(rb)
				srb = bfactor*math.sin(rb)
				xb,yb = srb+x,crb+y
				azb = getGroundPosition(xb,yb,az+2)
				--back
				rf = math.abs(rz-360)
				rf = math.rad(rf)
				crf = ffactor*math.cos(rf)
				srf = ffactor*math.sin(rf)
				xf,yf = srf+x,crf+y
				azf = getGroundPosition(xf,yf,az+2)
				--draw front
				x,y,z = xf,yf,azf 
				x1,y1,z1 = xb,yb,azb
				rz = rz-90
				r3 = rz-30
				r4 = rz-150
				r3 = math.abs(r3-360)
				r4 = math.abs(r4-360)
				r1 = r3-60
				r2 = r4-300
				r1 = math.rad(r1)
				r2 = math.rad(r2)
				r3 = math.rad(r3)
				r4 = math.rad(r4)
				cr1 = 0.7*math.cos(r1)
				sr1 = 0.7*math.sin(r1)
				cr2 = 0.7*math.cos(r2)
				sr2 = 0.7*math.sin(r2)
				cr3 = 0.7*math.cos(r3)
				sr3 = 0.7*math.sin(r3)
				cr4 = 0.7*math.cos(r4)
				sr4 = 0.7*math.sin(r4)
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)
				cr1 = 1.03*cr1
				sr1 = 1.03*sr1
				cr2 = 1.03*cr2
				sr2 = 1.03*sr2
				cr3 = 1.03*cr3
				sr3 = 1.03*sr3
				cr4 = 1.03*cr4
				sr4 = 1.03*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

				cr1 = 1.02*cr1
				sr1 = 1.02*sr1
				cr2 = 1.02*cr2
				sr2 = 1.02*sr2
				cr3 = 1.02*cr3
				sr3 = 1.02*sr3
				cr4 = 1.02*cr4
				sr4 = 1.02*sr4
				x1 = sr1+x
				y1 = cr1+y
				x2 = sr2+x
				y2 = cr2+y
				x3 = sr3+xb
				y3 = cr3+yb
				x4 = sr4+xb
				y4 = cr4+yb
				az1 = getGroundPosition(x1,y1,z+2)
				az2 = getGroundPosition(x2,y2,z+2)
				az3 = getGroundPosition(x3,y3,z+2)
				az4 = getGroundPosition(x4,y4,z+2)
				dxDrawLine3D(x1,y1,az1,x2,y2,az2,tocolor(r,g,b,a),3)
				dxDrawLine3D(x3,y3,az3,x4,y4,az4,tocolor(r,g,b,a),3)

			end
		end
	end
end