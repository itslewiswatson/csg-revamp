local hos = {
	--{x,y,z,name,rot,ax,ay,az,arot,cx,cy,cz}
	{-1514.71, 2528.21, 55.72,"EL QUEBRADOS Medical Center",3, -1490.33, 2565.89, 55.83,137,-1488.94, 2567.31, 74.57,1500},
	{1178.24, -1324.42, 14.11,"All Saints General Hospital",270.81, 1192.27, -1292.83, 13.38,178,1218.27, -1324.49, 33.43,1500},
	{1607.34, 1818.58, 10.82,"Las Venturas Airport Hospital",1,1657.8, 1832.15, 10.85,91,1634.17, 1872.56, 39.34,2000},
	{1244.51, 332.75, 19.55,"Crippen Hospital",335,1289.33, 320.76, 19.4,66,1260.37, 356.91, 35.94,2000},
	{-316.64, 1055.68, 19.74,"Fort Carson Hospital",206,-277.39, 1059.74, 19.59,91, -307.92, 1080.05, 35.59,1500},
	{2027.51, -1420.98, 16.99,"Jefferson County General Hospital",131,1985.51, -1444.65, 13.39,269, 1989.62, -1461.12, 40.18,2000},
	{-2191.13, -2302.95, 30.62,"Angel Pine Medical center",6,-2147.91, -2317.92, 30.46,65.5, -2171.06, -2279.11, 47.87,1500},
	{-2649.67, 633.34, 14.45,"San Fierro Medical Center",181,-2708.49, 606.55, 14.45,299, -2662.16, 591.62, 24.35,1500},
	{ 827.826171875,-2505.640625,12.937484741211,"CSG Federal Prison Medical Center",269,_,_,_,_,884,-2490,39},
	--{159.96, 1904.03, 18.77,"CSG Military Forces Medical Center",270,_,_,_,_,237.38, 1936.16, 47.13},

}

GUIEditor = {
    label = {},
}
window = guiCreateWindow(400, 271, 491, 92, "CSG ~ Respawn", false)
guiWindowSetSizable(window, false)

GUIEditor.label[1] = guiCreateLabel(67, 28, 367, 16, "Where would you like to continue your life..?", false, window)
guiLabelSetColor(GUIEditor.label[1], 2, 252, 2)
guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
btnHos = guiCreateButton(14, 53, 217, 28, "Nearest Hospital", false, window)
btnPlace = guiCreateButton(256, 53, 217, 28, "Nearest Hospital", false, window)

guiSetVisible(window,false)

addEventHandler("onClientGUIClick",root,function()
	if source == btnHos then
		setTimer(function() triggerServerEvent("cancelCustomSpawn",localPlayer) end,1000,5)
		guiSetVisible(window,false)
		showCursor(false)
	end
	if source == btnPlace then
		local teamName=getTeamName(getPlayerTeam(localPlayer))
		if teamName == "SWAT" then
			triggerServerEvent("spawnLawPlayer",localPlayer,1259.27, -1653.44, 13.54,275,"You have been taken to SWAT Base")
		elseif teamName=="Government Agency" then
			triggerServerEvent("spawnLawPlayer",localPlayer,1013.83, -1446.95, 13.55,93,"You have been taken to FBI Base")
		elseif teamName=="Military Forces" then
			triggerServerEvent("spawnLawPlayer",localPlayer,158.7, 1903.4, 18.71,271,"You have been taken to Military Forces Base")
		end
		guiSetVisible(window,false)
		showCursor(false)
	end
end)

collide = function(collider,force, bodyPart, x, y, z, nx, ny, nz)
         if ( source == veh ) then
			if getElementType(collider) == "player" then
				if not isTimer(damTimer) then
					damTimer=setTimer(function()
						fadeCamera(false,1.5,255,0,0)
						setTimer(function() fadeCamera(true,1) end,1000,1)
					end,3000,1)
				end
			end
         end
    end
veh,ped = false
damTimer = false

function isPlayerJailed(p)
	return false
end

local LVcol = createColRectangle(866,656,2100,2300)

addEventHandler("onClientPlayerWasted",root,function()
	if source ~= localPlayer then return end
	smallestDist=99999999
	local x,y,z = getElementPosition(source)
	if getElementInterior(localPlayer) ~= 0 then
		x,y,z = posint0x,posint0y,posint0z
	end
	local i=0
	for k,v in pairs(hos) do
		local dist = getDistanceBetweenPoints3D(x,y,z,v[1],v[2],v[3])
		if dist < smallestDist then smallestDist = dist i = k end
		if isPlayerJailed(localPlayer) == true then i = 9 break end
	end
	if isElement(veh) == false and isPlayerJailed(localPlayer) == false then
		setTimer(function() veh=createVehicle(416,hos[i][6],hos[i][7],hos[i][8],0,0,hos[i][9])
		ped=createPed(0,hos[i][1],hos[i][2],hos[i][3])
		warpPedIntoVehicle(ped,veh)
		setPedControlState(ped,"accelerate",true) setTimer(function() setPedControlState(ped,"accelerate",false)  end,hos[i][13],1) end,5000,1)
		setTimer(function() destroyElement(veh) destroyElement(ped) end,13100,1)
	end

	setElementDimension(localPlayer,0)
	setElementInterior(localPlayer,0)
	fadeCamera(false,5,0,0,0)
	setTimer(function() exports.dendxmsg:createNewDxMessage("You have have been taken to "..hos[i][4].."",255,255,0)
	end,5000,1)
	local m = getPlayerMoney()
	if m == 0 then
		fees=0
	elseif m > 1000 and m < 5000 then
		fees=math.random(1,75)
	else
		fees=math.random(50,150)
	end
	if isPlayerJailed(localPlayer) == true then fees = 0 end
	addEventHandler("onClientVehicleCollision", root,collide)
	triggerServerEvent("rs.spawnSequence",localPlayer,localPlayer,i,fees)
	setTimer(function() setCameraMatrix( hos[i][10],hos[i][11],hos[i][12],hos[i][1],hos[i][2],hos[i][3])
	fadeCamera(true,5)
	end,5000,1)
	count = 5
	local tname = getTeamName(getPlayerTeam(localPlayer))
	if tname == "Criminals" then
		if getElementData(localPlayer,"wantedPoints") > 9 and isElementWithinColShape(localPlayer,LVcol) == true then
			guiSetEnabled(btnHos,false)
			guiSetEnabled(btnPlace,true)
		elseif getElementData(localPlayer,"wantedPoints") <= 9 and isElementWithinColShape(localPlayer,LVcol) == true then
			guiSetEnabled(btnHos,true)
			guiSetEnabled(btnPlace,true)
			guiSetText(btnPlace,"Nearest "..getElementData(localPlayer,"Group").." Turf ("..count..")")
		else
			if isElementWithinColShape(localPlayer,LVcol) == true then guiSetEnabled(btnPlace,true) else guiSetEnabled(btnPlace,false) end
			guiSetEnabled(btnHos,true)
			guiSetText(btnHos,"Nearest Hospital")
			guiSetText(btnPlace,"Nearest "..getElementData(localPlayer,"Group").." Turf ("..count..")")
		end
	else
		guiSetEnabled(btnHos,true)
	end
	if tname == "Government Agency" then guiSetText(btnPlace,"FBI Base") end
	if tname == "SWAT" then guiSetText(btnPlace,"SWAT Base") end
	if tname == "Military Forces" then guiSetText(btnPlace,"MF Base") end

	if tname == "Criminals" or tname == "Government Agency" or tname == "SWAT" or tname == "Military Forces" then
	setTimer(function() guiSetVisible(window,true) showCursor(true) setTimer(function()
		if tname == "Criminals" then
			guiSetText(btnPlace,"Nearest "..getElementData(localPlayer,"Group").." Turf ("..count..")")
		else
			guiSetText(btnHos,"Nearest Hospital ("..count..")")
		end
		count=count-1
		if count == -2 then
			guiSetVisible(window,false)
			showCursor(false)
		end
	end,1000,7) end,5000,1)
	end
	setTimer(function() setCameraTarget(localPlayer)

		removeEventHandler("onClientVehicleCollision", root,collide)

	end,13000,1)
end)

setTimer(function()
	if getElementInterior(localPlayer) == 0 then
		posint0x,posint0y,posint0z=getElementPosition(localPlayer)
	end
end,1000,0)

function saveSpawn ( )
  startSaveSpawn()
end
addEventHandler ( "onClientPlayerSpawn", localPlayer, saveSpawn )

function startSaveSpawn ()
setElementAlpha(localPlayer, 100)
 setElementData(localPlayer, "sp_prot", true );
  setTimer(removeSaveSpawn,12000,1)
end

function removeSaveSpawn ()
setElementData(localPlayer, "sp_prot", false );
setElementAlpha(localPlayer, 255)
end

addEventHandler("onClientPlayerDamage",localPlayer,function()
	if getElementData(source,"sp_prot") == true then cancelEvent() end
end)
