cameraObj=false
local lx,ly,lz
local hunter
local tx,ty,tz = 1817.88, -1614.57, 14.38  --tank spawn rz=79.9
local tanks = {}
function startSeq()
	setCameraMatrix(1441.36, -1548.84, 93.39,1721.84, -1591.5, 45.32)
	cameraObj=createObject(2239,1441.36, -1548.84, 93.39)
	setElementAlpha(cameraObj,0)
	moveObject(cameraObj,10000,1643.88, -1530.81, 69.18)
	lx,ly,lz =  1746.08, -1627.87, 33.17
	addEventHandler("onClientRender",root,doUp)
	exports.DENdxmsg:createNewDxMessage("The Law Enforcement are on there way!",255,0,0)
	setTimer(function()
		setTimer(function()
			table.insert(tanks,createVehicle(432,tx,ty,tz,0,0,79.9))
			local ped = createPed(0,0,0,0)
			warpPedIntoVehicle(ped,tanks[#tanks])
			setPedControlState(ped,"accelerate",true)
		end,2222,0)
		--hunter = createVehicle(425,1749.26+math.random(-15,15), -1567.36+math.random(-15,15), 131.57+math.random(15),0,0,math.random(360))
		--setElementHealth(hunter,200)
		--setHelicopterRotorSpeed(hunter,0.2)
	end,5000,1)

end

addCommandHandler("startseq",startSeq)

function doUp()
	local x,y,z = getElementPosition(cameraObj)
	setCameraMatrix(x,y,z,lx,ly,lz)
end

