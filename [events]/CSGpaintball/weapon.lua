local sound = false
local state = false
local tags = {}

function onWeaponFire(weapon,_,_,x,y,z,hitElement)
	if(sound == true) then
		stopSound(sound)
	end
	if (getElementInterior(source) == 1) and (getElementDimension(source) == 100) then
		if (isElement(hitElement)) then
			outputDebugString("Element hit")
			if (type(hitElement) == "userdata") then
				triggerServerEvent("paintball:hit",localPlayer,hitElement)
				return true --make sure no other markers are created
			end
		end
		
		pX,pY,pZ = getElementPosition(source)
		sound = playSound3D("gun/sound.mp3",pX,pY,pZ)
		setElementInterior(sound,1)
		setElementDimension(sound,100)
		
		marker = createMarker(x,y,z,"corona",0.2,math.random(255),math.random(255),math.random(255),255)
		setElementInterior(marker,1)
		setElementDimension(marker,100)
		setTimer(fadePaintball,3000,1,marker)
	end
end
addEventHandler("onClientPlayerWeaponFire",root,onWeaponFire)

function fadePaintball(paintball)
	if (isElement(paintball)) then
		r,g,b,a = getMarkerColor(paintball)
		--outputDebugString(a)
		if not (a <= 0) then
			setMarkerColor(paintball,r,g,b,a-10)
			setTimer(fadePaintball,200,1,paintball)
		else
			destroyElement(paintball)
		end
	end
end

function loadGun()
	if (state == false) then
		local txd = engineLoadTXD("models/ak47.txd")
		local dff = engineLoadDFF("models/ak47.dff",356)
		engineImportTXD(txd,356)
		engineReplaceModel(dff,356)
		state = true
	else
		engineRestoreModel(356)
		state = false
	end
end
addCommandHandler("paintball",loadGun)