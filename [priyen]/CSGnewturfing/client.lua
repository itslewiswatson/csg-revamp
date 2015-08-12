local turfSpawnTable = {
[1] = { 1678.14, 2331.15, 10.82, 273.35775756836 },
[2] = { 1880.89, 2339.45, 10.97, 269.00161743164 },
[3] = { 2245.16, 2005.47, 10.82, 0.21148681640625 },
[4] = { 2237.48, 2125.49, 10.82, 356.15197753906 },
[5] = { 2029.36, 1933.53, 12.23, 266.12313842773 },
[6] = { 1417.09, 2091.61, 11.01, 82.934326171875 },
[7] = { 1635.65, 1038.43, 10.82, 264.73333740234 },
[8] = { 1980.15, 1798.95, 12.34, 176.65460205078 },
[9] = { 2010.08, 1177.31, 10.82, 215.78851318359 },
[10] = { 1955.01, 1343.09, 15.37, 267.49645996094 },
[11] = { 1452.9, 2368.78, 10.82, 263.83795166016 },
[12] = { 1164.08, 1336.63, 10.81, 88.367126464844 },
[13] = { 943.93, 1733.04, 8.85, 265.27719116211 },
[14] = { 966.79, 2072.79, 10.82, 278.10940551758 },
[15] = { 1047.33, 2161.22, 10.82, 267.41955566406 },
[16] = { 1069.38, 1887.18, 10.82, 267.08993530273 },
[17] = { 1086.41, 1610.5, 5.82, 12.428466796875 },
[18] = { 1629.91, 994.05, 10.82, 268.82580566406 },
[19] = { 1947.96, 1625.71, 22.76, 274.81344604492 },
[20] = { 2609.26, 2392.2, 17.82, 17.487762451172 },
[21] = { 2341.51, 2805.07, 10.82, 181.4172668457 },
[22] = { 2496.23, 2320.42, 10.82, 92.833129882812 },
[23] = { 2855.62, 2418.89, 10.82, 228.46691894531 },
[24] = { 2368.26, 2311.21, 8.14, 349.74685668945 },
[25] = { 2456.51, 2020.87, 11.06, 109.5491027832 },
[26] = { 2470.94, 2127.92, 10.82, 356.69580078125 },
[27] = { 2580.6, 2185.06, 10.82, 351.66400146484 },
[28] = { 2600.43, 2085.82, 10.81, 268.26000976562 },
[29] = { 2629.76, 1716.96, 11.02, 90.789642333984 },
[30] = { 2443.15, 1655.06, 10.82, 232.93293762207 },
[31] = { 2440.58, 1750.76, 10.82, 357.9153137207 },
[32] = { 2408.78, 1866.87, 6.01, 357.9153137207 },
[33] = { 2220.33, 1839.7, 10.82, 89.756927490234 },
[34] = { 2161.98, 1643.88, 11.11, 12.340576171875 },
[35] = { 2484.99, 1529.75, 10.84, 321.74227905273 },
[36] = { 2565.13, 1442.24, 11.03, 87.570617675781 },
[37] = { 2576.65, 1221.56, 10.82, 87.345397949219 },
[38] = { 2542.75, 1279.4, 10.82, 81.357757568359 },
[39] = { 2588.68, 1324.5, 10.82, 177.04461669922 },
[40] = { 2483.38, 1363.89, 10.81, 1.6122741699219 },
[41] = { 2479.25, 1291.08, 10.81, 265.03549194336 },
[42] = { 2507.62, 1210.74, 10.82, 179.81323242188 },
[43] = { 2467.91, 1405.13, 10.82, 277.16458129883 },
[44] = { 2283.97, 1388.91, 10.82, 356.69030761719 },
[45] = { 2136.67, 1493.05, 10.82, 0.00274658203125 },
[46] = { 2096.24, 1284.98, 10.82, 179.21997070312 },
[47] = { 2257.51, 1286.12, 19.16, 88.119934082031 },
[48] = { 2551.48, 1169.08, 18.71, 181.14259338379 },
[49] = { 2552.76, 1054.41, 10.82, 266.17807006836 },
[50] = { 2393.09, 1003.33, 10.82, 91.262084960938 },
[51] = { 2491.58, 1149.32, 22.02, 182.23025512695 },
[52] = { 2466.65, 1065.37, 10.82, 0.00274658203125 },
[53] = { 2476.44, 992.23, 10.82, 269.96292114258 },
[54] = { 2883.68, 894.57, 10.75, 89.537200927734 },
[55] = { 2575.47, 724.07, 10.82, 359.99176025391 },
[56] = { 2361.69, 694.46, 11.44, 4.79833984375 },
[57] = { 2221.24, 694.27, 11.45, 355.48181152344 },
[58] = { 2056.33, 730.03, 11.46, 358.47561645508 },
[59] = { 1533.66, 751.34, 11.02, 262.45364379883 },
[60] = { 1634.18, 759.18, 10.82, 181.89517211914 },
[61] = { 1917.02, 703.28, 11.13, 86.691680908203 },
[62] = { 2269.87, 965.09, 10.81, 353.1471862793 },
[63] = { 1904.34, 974.14, 10.82, 177.90155029297 },
[64] = { 2177.31, 1117.87, 12.64, 60.390014648438 },
[65] = { 1074.09,664.92,10.79,357},
[66] = { 1010.55,942.94,11,328},
[67] = { 2496.79, 2772.79, 10.82,79},
[68] = { 1493.52, 2773.69, 10.82, 275},
}

function isLaw(p)
	local tName = getTeamName(getPlayerTeam(p))
	if tName == "Police" or tName == "SWAT" or tName == "Military Forces" or tName == "Government Agency" then
		return true
	end
	return false
end

local gangName=""
GUIEditor = {
    button = {},
    label = {},
    window = {},
}
window = guiCreateWindow(398, 70, 487, 180, "Community of Social Gaming ~ Respawn", false)
guiWindowSetSizable(window, false)

GUIEditor.label[1] = guiCreateLabel(4, 119, 464, 22, "Where would you like to respawn?", false, window)
guiLabelSetColor(GUIEditor.label[1], 246, 137, 8)
guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
btnHos = guiCreateButton(9, 29, 219, 29, "Nearest Hospital", false, window)
btnTurf = guiCreateButton(251, 29, 219, 29, "Nearest "..gangName.." Turf", false, window)
guiSetVisible(window,false)

local spawnTime = 10000
local LVcol = createColRectangle(866,656,2100,2300)
local myCol = createColCircle(1,1,60)
attachElements(myCol,localPlayer)
-- When player dies spawn him in the nearest turf of his own group
addEvent ("onClientTurferDied", true)
function onClientTurferDied ( theTable )
	gangName=getElementData ( localPlayer, "Group" )
	if ( getElementData( source, "isPlayerVip" ) ) then
		spawnTime = 5000
	end
	local copNear=false
	if tonumber(getElementData(localPlayer,"wantedPoints")) >= 9 then
		local t = getElementsWithinColShape(myCol)
		for k,v in pairs(t) do
			if isLaw(v) then
				copNear=true
				break
			end
		end
	end

	if copNear == true then

	end

	local turfDistance = nil
	local turfID = nil
	local px, py, pz = getElementPosition ( localPlayer )

	if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Criminals" ) then
		if isElementWithinColShape(localPlayer,LVcol) == true then
			for i=1,#theTable do
					local x, y, z = theTable[i][1], theTable[i][2], theTable[i][3]
					if not ( turfDistance ) or ( getDistanceBetweenPoints3D ( x, y, z, px, py, pz  ) < turfDistance ) then
						turfDistance = getDistanceBetweenPoints2D ( x, y, px, py  )
						turfID = v[4]
					end
			end
		else
			return
		end
	end

	if ( turfDistance ) and ( turfID ) then
		setTimer( respawnPlayer, spawnTime, 1, source, turfSpawnTable[turfID][1], turfSpawnTable[turfID][2], turfSpawnTable[turfID][3], turfSpawnTable[turfID][4] )
	end
end
addEventHandler ("onClientTurferDied", root, onClientTurferDied)

-- Trigger the gespawn
function respawnPlayer ( thePlayer, x, y, z, rotation )
	exports.DENdxmsg:createNewDxMessage( "You respawned in the nearest turf of your group!", 0, 225, 0)
	triggerServerEvent ( "spawnTurfingPlayer", thePlayer, x, y, z, rotation )
end

function AbsoluteToRelativ2( X, Y )
    local rX, rY = guiGetScreenSize()
    local x = math.floor(X*rX/1280)
    local y = math.floor(Y*rY/768)
    return x, y
end


currentTurfData = nil
local barTimer = false
addEvent("recTurfData",true)
addEventHandler("recTurfData",localPlayer,function(t) currentTurfData=t
	if isTimer(barTimer) then killTimer(barTimer) end
	if t == nil then return end
	myGroup=getElementData(localPlayer,"Group")
	if t.attackinggroup ~= myGroup and t.owner ~= myGroup then
		currentTurfData.text = "You are attacking this turf!"
		textr,textg,textb = 255,0,0
	elseif t.owner == myGroup then
		currentTurfData.text = "You are defending this turf!"
		textr,textg,textb = 0,255,0
		if t.health < 100 and t.health > t.oldHealth then
			triggerServerEvent("CSGturfing.reqDefendingMoney",localPlayer)
		end
	else
		currentTurfData.text = "You are attempting to take this turf!"
		textr,textg,textb = 255,255,0
	end
	local change = t.health - t.oldHealth
	change=change/100
	barTimer=setTimer(function() currentTurfData.health = currentTurfData.health + change end,50,100)
end)

addEventHandler("onClientRender", root,
    function()
		if currentTurfData == nil then return end
		x,y=AbsoluteToRelativ2(1002,238)
		x2,y2=AbsoluteToRelativ2(212, 21)
		if currentTurfData.attackinggroup == "None" then
			if currentTurfData.owner=="Unoccupied" then
				dxDrawRectangle(x,y,x2*(currentTurfData.health/100),y2, tocolor(255,255,255, 255), true)
			else
				dxDrawRectangle(x,y,x2*(currentTurfData.health/100),y2, tocolor(currentTurfData.colors[currentTurfData.owner][1],currentTurfData.colors[currentTurfData.owner][2],currentTurfData.colors[currentTurfData.owner][3], 255), true)
			end
		else
			dxDrawRectangle(x,y,x2*(currentTurfData.health/100),y2, tocolor(currentTurfData.colors[currentTurfData.attackinggroup][1],currentTurfData.colors[currentTurfData.attackinggroup][2],currentTurfData.colors[currentTurfData.attackinggroup][3], 255), true)
		end

		x,y=AbsoluteToRelativ2(1000, 234)
		x2,y2=AbsoluteToRelativ2(217, 30)
		dxDrawRectangle(x,y,x2,y2, tocolor(19, 0, 0, 100), true)

		x,y=AbsoluteToRelativ2(1120, 234)
		x2,y2=AbsoluteToRelativ2(1120, 262)
		dxDrawLine(x,y,x2,y2, tocolor(9, 130, 0, 255), 1, true)

		x,y=AbsoluteToRelativ2(1041, 234)
		x2,y2=AbsoluteToRelativ2(1041, 262)
		dxDrawLine(x,y,x2,y2, tocolor(129, 2, 20, 255), 1, true)

		x,y=AbsoluteToRelativ2(996, 236)
		x2,y2=AbsoluteToRelativ2(1224, 262)
		dxDrawText(currentTurfData.barText, x,y,x2,y2, tocolor(255, 255, 255, 255), 1, "default", "center", "center", false, false, true, false, false)

		x,y=AbsoluteToRelativ2(1001, 292)
		x2,y2=AbsoluteToRelativ2(1216, 318)
		dxDrawText(">> Turf Influence <<", x,y,x2,y2, tocolor(0, 255, 0, 255), 1, "default", "center", "top", false, true, true, false, false)

		local i=1
		for k,v in pairs(currentTurfData.influences) do
			i=i+1
			local imgY=292+(30*(i-1))
			 _,imgY=AbsoluteToRelativ2(0,imgY-7)
			x,y=AbsoluteToRelativ2(1001, 292+(30*(i-1)))
			x2,y2=AbsoluteToRelativ2(1216, 318)
			v=v/2
			local vpos = v
			local vnum = v

			if v < 0 then vpos=vpos*-1 end
			local timesToDrawFull = math.floor(vpos)
			local timesToDrawHalf = 0
			if vpos-timesToDrawFull > 0 then timesToDrawHalf=1 end
			if v > 0 then v="+"..v..""end
			dxDrawText(""..k.."", x,y,x2,y2, tocolor(currentTurfData.colors[k][1], currentTurfData.colors[k][2], currentTurfData.colors[k][3], 255), 1, "default", "center", "top", false, true, true, false, false)
			for i2=1,timesToDrawFull do
			if vnum > 0 then
				x3,y3=AbsoluteToRelativ2(1161+(30*(i2-1)), 317)
			else
				x3,y3=AbsoluteToRelativ2(1031-(30*(i2-1)), 317)
			end
			x4,y4=AbsoluteToRelativ2(36, 26)
			dxDrawImage(x3,imgY,x4,y4, "full.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
			end
			if timesToDrawHalf > 0 then
			if vnum > 0 then
				x3,y3=AbsoluteToRelativ2(1161+(30*(timesToDrawFull+1-1)), 317)
			else
				x3,y3=AbsoluteToRelativ2(1031-(30*(timesToDrawFull+1-1)), 317)
			end
			dxDrawImage(x3,imgY,x4,y4, "half.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
			end
		end

		x,y=AbsoluteToRelativ2(1001, 265)
		x2,y2=AbsoluteToRelativ2(1216, 291)
		dxDrawText(""..currentTurfData.text.."", x,y,x2,y2, tocolor(textr,textg,textb, 255), 1, "default", "left", "top", false, false, true, false, false)

    end
)
