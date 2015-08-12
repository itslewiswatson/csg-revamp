crash = {{{{{{{{ {}, {}, {} }}}}}}}}
local defaultDist = 100
local streamingFrom = false
local radius = 100
local x, y, z = 0, 0, 0
local usingEle = false
local timer = false
local predefined = {
	["DI Dance"] = "http://listen.di.fm/public3/club.pls",
	["Techno"] = "http://www.181.fm/asx.php?station=181-technoclub&style=&description=",
	["Besiktas"] = "http://k003.kiwi6.com/hotlink/opxdkzfrhb/kartal_s_zl_k_-_bir_g_n_de-il_her_g_n_be--kta-_full_version.mp3",
	["PSY-Gentleman"] = "http://samfonibox.org/HADI/2013/April/13/PSY - Gentleman/PSY - Gentleman.mp3",
	["Flo Rida İ cry"] = "http://k003.kiwi6.com/hotlink/sokctfnr35/flo_rida_-_i_cry_official_video_.mp3",
	["Gangam STYLE"] = "http://k003.kiwi6.com/hotlink/g68c9935e8/psy_-_gangnam_style_-----_m_v.mp3",
	["Harlem Shake "] = "http://k003.kiwi6.com/hotlink/7kq259m281/baauer_-_harlem_shake_hq_full_version_.mp3",
	["CSG mix2"] = "http://promodj.com/download/3821452/DJ BAUR - NEW YEAR PARTY MIX 2013 (promodj.com).mp3",
	["CSG mix3"] = "http://hulkshare.com/ap-5l2uuacv3ts0",
	["CSG mix4"] = "http://www.hulkshare.com/ap-tke3d3rkld6o",
	["CSG mix5"] = "http://promodj.com/download/4068716/Dj Rush Extazy - Hot Spring Mix 2013 vol.1 (promodj.com).mp3",
	["CSG mix6"] = "http://promodj.com/download/4076095/new 2013 hit mix boom (promodj.com).mp3",
	["CSG mix7"] = "http://165.palco.fm/1/b/f/7/soremix-forro-remix-2013-avioes-remix.mp3",
	["CSG mix8"] = "http://trckr.hulkshare.com/hulkdl/9vjmnm09zaio/my name is nani remix..Songs Andhra...mp3?z=1",
	["Power181"] = "http://www.181.fm/winamp.pls?station=181-power&style=mp3&description=Power%20181%20(Top%2040)&file=181-power.pls"
	
	
}



streamWindow1 = guiCreateWindow(368, 101, 582, 300, "CSG Stream", false)
        guiWindowSetSizable(streamWindow1, false)
streamButton1 = guiCreateButton(204, 92, 369, 34, "Start Stream", false, streamWindow1)
streamButton2 = guiCreateButton(204, 140, 369, 34, "Stop Stream", false, streamWindow1)
streamButton4 = guiCreateButton(204, 191, 369, 34, "Clear", false, streamWindow1)
streamButton5 = guiCreateButton(9, 245, 564, 40, "Close", false, streamWindow1)
streamGrid1 = guiCreateGridList(13, 27, 181, 208, false, streamWindow1)
guiGridListSetSelectionMode(streamGrid1,1)
streamCol = guiGridListAddColumn(streamGrid1, "URLs", 0.9)
streamEdit1 = guiCreateEdit(272, 31, 301, 31, "", false, streamWindow1)
streamLabel1 = guiCreateLabel(199, 34, 70, 26, "URL:", false, streamWindow1)
guiLabelSetHorizontalAlign(streamLabel1, "center", false)
guiLabelSetVerticalAlign(streamLabel1, "center")
guiSetVisible(streamWindow1, false)

for a,b in pairs(predefined) do
	local row = guiGridListAddRow(streamGrid1)
	guiGridListSetItemText(streamGrid1, row, streamCol, a, false, false)
end

function openWindow()
	if (getTeamName(getPlayerTeam(localPlayer)) ~= "Staff") then return false end
	if (guiGetVisible(streamWindow1)) then
		guiSetVisible(streamWindow1, false)
		showCursor(false)
		guiSetInputMode("allow_binds")
	else
		guiSetVisible(streamWindow1, true)
		showCursor(true)
		guiSetInputMode("no_binds_when_editing")
	end
end
addEvent("Guistr", true)
addEventHandler("Guistr", localPlayer, openWindow)

function clearFunc()
	guiSetText(streamEdit1, "")
end
addEventHandler("onClientGUIClick", streamButton4, clearFunc, false)
addEventHandler("onClientGUIClick", streamButton5, openWindow, false)


function startStream()
	local url = tostring(guiGetText(streamEdit1)) or ""
	local gridUrl = guiGridListGetItemText(streamGrid1, guiGridListGetSelectedItem(streamGrid1), 1)
	local low = string.lower(url)
	if (url ~= "" and not string.find(low, ".mp3") and not string.find(low, ".pls") and not string.find(low, ".asx") and not string.find(low, ".m3u") and not string.find(low, ".wav") and not string.find(low, ".ogg") and not string.find(low, ".riff") and not string.find(low, ".mod") and not string.find(low, ".xm") and not string.find(low, ".it") and not string.find(low, ".s3m")) then
		outputChatBox("The only supported streams are: mp3 - pls - m3u - wav - ogg - riff - mod - xm - it - s3m")
		return false
	end
	if (url ~= "") then
		triggerServerEvent("streamStart", localPlayer, url)
	elseif (gridUrl ~= "") then
		triggerServerEvent("streamStart", localPlayer, predefined[gridUrl])
	else
		return false
	end
end
addEventHandler("onClientGUIClick", streamButton1, startStream, false)

function stopStream()
	triggerServerEvent("streamStop", localPlayer)
end
addEventHandler("onClientGUIClick", streamButton2, stopStream, false)

function startStreameam(streamm, radius, x, y, z, int, dim, veh2)
	setCameraClip (false, false)
	if (stream) then return end
	stream = playSound3D(streamm, x, y, z, true)
	setElementInterior(stream, int)
	setElementDimension(stream, dim)
	setSoundVolume(stream, 1.0)
	setSoundMaxDistance(stream, radius)
	if (veh2) then
		veh = veh2
		timer = setTimer(updatePos, 100, 0)
	end
end
addEvent("startClientStream", true)
addEventHandler("startClientStream", localPlayer, startStreameam)


function stopStreameam()
	if (stream) then
		if (isElement(stream)) then
			destroyElement(stream)
		end
		stream = nil
		if (isElement(timer)) then
			killTimer(timer)
		end
		veh = nil
		x,y,z = 0, 0, 0
	end
end
addEvent("streamClientStop", true)
addEventHandler("streamClientStop", localPlayer, stopStreameam)

function moveStream(x2, y2, z2)
	if (stream and isElement(stream)) then
		setElementPosition(stream, x2, y2, z2)
		x = x2
		y = y2
		z = z2
	end
end
addEvent("updateClientStream", true)
addEventHandler("updateClientStream", localPlayer, moveStream)

function updatePos()
	if (not stream) then killTimer(timer) return end
	if (not isElement(veh)) then killTimer(timer) return end
	if (not isElement(veh)) then return false end
	if (not isElement(stream)) then return false end
	x2,y2,z2 = getElementPosition(veh)
	int = getElementInterior(veh)
	dim = getElementDimension(veh)
	setElementPosition(stream, x2, y2, z2)
	setElementInterior(stream, int)
	setElementDimension(stream, dim)
	x = x2
	y = y2
	z = z2
end