
local sx,sy = guiGetScreenSize()
lp = getLocalPlayer()
markersCity = {}
--testt
local starts = {
	{1604.8479003906,-1620.5067138672,12.517609596252,"LS"},
	{1259.12, -1672.43, 12.54,"LS"},
	{-1636.2523193359,666.08770751953,6.1875,"SF"},
	{185.43, -1796.69, 3.68,"LS"},
}

local dests = {
	{1531.3452148438,-1631.5815429688,13.627583503723},
	{2004.3118896484,-1442.8776855469,13.562582969666,"LS"},
	{2150.640625,-1293.8365478516,23.978977203369,"LS"},
	{1603.1121826172,-1036.9809570313,23.914047241211,"LS"},
	{957.00476074219,-1632.6430664063,13.540469169617,"LS"},
	{1726.6306152344,-1632.5029296875,20.215179443359,"LS"},
	{1325.7783203125,-1279.9487304688,12.993987083435,"LS"},
	{1257.4794921875,-1280.3414306641,12.913123130798,"LS"},
	{1205.25,-1279.9801025391,12.998148918152,"LS"},
	{1060.3488769531,-1269.8489990234,13.396063804626,"LS"},
	{944.69012451172,-1227.373046875,16.379028320313,"LS"},
	{916.95092773438,-1322.5111083984,13.107110977173,"LS"},
	{818.32952880859,-1339.0447998047,13.142149925232,"LS"},
	{1041.1795654297,-1745.6037597656,13.014188766479,"LS"},
	{1086.3431396484,-1779.8048095703,13.195708274841,"LS"},
	{1151.0877685547,-1617.8758544922,13.396173477173,"LS"},
	{1300.2083740234,-1664.1832275391,13.3828125,"LS"},
	{1329.8410644531,-1477.9383544922,12.989696502686,"LS"},
	{1304.8502197266,-1823.0179443359,13.546875,"LS"},
	{2014.7495117188,-1518.5422363281,3.4064054489136,"LS"},
	{2734.0595703125,-1655.7940673828,13.0703125,"LS"},
	{-2570.0771484375,598.10968017578,14.457198143005,"SF"},
	{-2387.8029785156,564.27185058594,24.7421875,"SF"},
	{-2245.2370605469,539.90460205078,35.102420806885,"SF"},
	{-2277.833984375,387.52853393555,34.590209960938,"SF"},
	{-2320.1105957031,106.86109924316,35.3125,"SF"},
	{-2100.5187988281,-339.61273193359,35.310813903809,"SF"},
	{-2100.5187988281,-339.61273193359,35.310813903809,"SF"},
	{-1652.5079345703,304.09429931641,7.1875,"SF"},
	{-1551.3200683594,519.26379394531,7.03125,"SF"},
	{-1513.3707275391,740.54931640625,7.1875,"SF"},
	{-1620.1619873047,1213.5648193359,7.0390625,"SF"},
	{-1978.4417724609,1314.5832519531,7.0390625,"SF"},
	{-2429.8723144531,672.04699707031,35.053630828857,"SF"},
	{-2704.9035644531,349.67541503906,4.4140625,"SF"},
	{-2684.6208496094,-50.810901641846,4.3359375,"SF"},
	{-2696.3071289063,-259.84286499023,7.07204246521,"SF"},
	{-2516.4477539063,-309.77017211914,39.287727355957,"SF"},
	{-1976.9837646484,483.57766723633,35.166126251221,"SF"},
	{-1923.6595458984,585.35144042969,35.271991729736,"SF"},

}

local p1 = {
	"Bob","Marie","Johny","Ifemufuna","Harriat"
}

local p2 = {
	"Minor Car Accident.",
	"1 on 1 Fight.",
	"Gang Fight In Progress.",
	"Robbery.",
	"Public Disturbance.",
	"Drug Dealing.",
	"Public Misconduct"
}

local p3 = {
	"Some casulties reported.",
	"No casulties reported.",
	"Devestating sight.",
	"The witness is in panic.",
}

local p4 = {
	"The main criminal escaped in a car",
	"The criminal escaped on a bike.",
	"The victim reports of no insurance",
	"The witness seems confused."
}
vehMarkers = {}
started=false
inProgress = false
cityToUse = "LS"
lyric = ""
songI = 0
markers = {}
timeleft=5
totalCalls=0
justFailed=false
justFinished=false
hits = {}
sentEffectReq=false
cdTrigger = false
function markerHit(e,bool)
	if e ~= lp then return end
	if bool == false then return end
	if isLaw() == false then return end
	local x,y,z = getElementPosition(source)
	local x2,y2,z2 = getElementPosition(e)
	if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 4 then return end
	for k,v in pairs(markers) do
		if v == source then
			showStartWindow()
			cityToUse = markersCity[source]
			return
		end
	end
end

function barFinish()
	if started == false then return end
	if inProgress == false then return end
	setElementFrozen(localPlayer,false)
	if isElement(workingMarker) then
		setMarkerColor(workingMarker,0,255,0)
	end
	if p2iCheck() == true then reached() end
end
addEvent("CSGpatrolMission.barFinish",true)
addEventHandler("CSGpatrolMission.barFinish",localPlayer,barFinish)

function p2iCheck()
	if p2i == 1 then
		if vehsTicketed() == true and pedsNeutralized() == true then return true else return false end
	elseif p2i == 2 then
		if pedsNeutralized() == true then return true else return false end
	end
end

function monitor()
	if started == true then
		if p2iCheck() == true then reached() end
	end
end
setTimer(monitor,1000,0)

setTimer(function()
		if started==false then return end
		if actualp2i == 5 then
			lyric = getRandomLyric()
		end
	end,3000,0)

lyrics = {
	{"Baby baby baby ohhh","Thought you'd always be minee minee"},
	{"I threw a wish in the well","Don't ask me, I'll never tell","Call me maybe"},
	{"PSY OP Gangnam Style!"},
	{"Im a barbie girl!","In a barbie world!"},
}

songs = {
	"http://k006.kiwi6.com/hotlink/x6vy4g8nk7/baby.mp3",
	"http://k006.kiwi6.com/hotlink/pf1womkn48/callmemaybe.mp3",
	"http://k006.kiwi6.com/hotlink/xtm402yhbo/gangnamstyle.mp3",
	"http://k006.kiwi6.com/hotlink/0zx825xl07/barbie_girl_song.mp3"
}

function getRandomLyric()
	local lyricsT = lyrics[songI]
	return lyrics[songI][math.random(1,#lyricsT)]
end

function vehsTicketed()
	local valid = true
	for k,v in pairs(vehMarkers) do
		local r,g,b = getMarkerColor(v)
		if r==255 then
			valid = false
		end
	end
	return valid
end

function pedsNeutralized()
	local valid = true
	if peds == nil or peds == {} or #peds < 1 then valid=false end
	for k,v in pairs(hits) do
		if getElementType(k) == "ped" then
			if v < 4 then valid = false end
		end
	end
	return valid
end

function click()
	if source == btnStart then
		if started == true then
			 exports.DENdxmsg:createNewDxMessage("You already started the patrol mission!",255,255,0)
			return
		end
		if inProgress == true then
			 exports.DENdxmsg:createNewDxMessage("Your currently responding to a call!",255,255,0)
			 exports.DENdxmsg:createNewDxMessage("Go to the blip on your map to respond to the call",255,255,0)
			 exports.DENdxmsg:createNewDxMessage("Press TAB to show the mission information",255,255,0)
			return
		end
		if cdTrigger == false then
			triggerServerEvent("CSGpatrolMission.canClientStart",localPlayer)
			cdTrigger=true
			setTimer(function() cdTrigger=false end,6000,1)
		else
			 exports.DENdxmsg:createNewDxMessage("Please wait before clicking start again!",255,255,0)
		end
	elseif source == btnCancel then
		failed()
	elseif source == btnExit then
		hideStartWindow()
	end
end
addEventHandler("onClientGUIClick",root,click)

peds = {}
vehs = {}
secsLeft = {}
function cancel()
	totalCalls=0
	clearEffect()
	sentEffectReq=false
	setElementFrozen(localPlayer,false)
	inProgress=false
	exports.CSGprogressbar:cancelProgressBar()
	workingMarker=""
	started=false
	exports.CSGgps:resetDestination()
	killPeds()
	triggerServerEvent("CSGpatrolMission.endAll",localPlayer)
	for k,v in pairs(vehs) do
		destroyElement(v)
	end
	if isElement(destM) then destroyElement(destM) end
	setTimer(function() guiSetVisible(window,false) end,3000,1)
end

function canStart(bool)
	if bool == true then
		maxCalls = math.random(2,6)
		sentEffectReq=false
		justFailed=false
		timeSpared=0
		started=true
		totalDist=0
		setTimer(readyToCall,5000,1)
		guiSetText(lblTarget,"Waiting for call...")
		guiSetText(lblDesc,"Waiting for call...")
		guiSetText(lblTimeLeft,"Time Left: N/A")
		 exports.DENdxmsg:createNewDxMessage("Started the Patrol Mission! Stand By Officer "..getPlayerName(lp)..".",0,255,0)
	else
		 exports.DENdxmsg:createNewDxMessage("You've attempted the Patrol Mission 3 times already for this hour.",255,255,0)
		 exports.DENdxmsg:createNewDxMessage("Come back later",255,255,0)
	end
end
addEvent("CSGpatrolMission.recCanStart",true)
addEventHandler("CSGpatrolMission.recCanStart",localPlayer,canStart)

function showStartWindow()
	guiSetVisible(startWindow,true)
	showCursor(true)
end

function hideStartWindow()
	guiSetVisible(startWindow,false)
	showCursor(false)
end

local streams = {}
function stream(p,si,bool,x,y,z)
	if streams[p] == nil then streams[p] = "" end
	if bool == true then
		if isElement(streams[p]) then destoryElement(streams[p]) end
		streams[p] = playSound3D(songs[si],x,y,z)
		setSoundVolume(streams[p], 1.0)
		setSoundMaxDistance(streams[p], 80)
	else
		if isElement(streams[p]) then stopSound(streams[p]) end
	end
end
addEvent("CSGpatrolMission.stream",true)
addEventHandler("CSGpatrolMission.stream",localPlayer,stream)

function toggleMission()
	if guiGetVisible(window) == true then
		guiSetVisible(window,false)
	else
		if started==false then return end
		guiSetVisible(window,true)
	end
end
bindKey("lshift","down",toggleMission)

function doCall()
	p1i = math.random(1,#p1)
	p2i = math.random(1,#p2)
	actualp2i=p2i

	sentEffectReq=false
	p3i = math.random(1,#p3)
	p4i = math.random(1,#p4)
	desc = "Caller "..p1[p1i].." reports of a "..p2[p2i].." "..p3[p3i].." "..p4[p4i]..""
	guiSetText(lblDesc,desc)
	inProgress=true
	local i = 0
	local validI = false
	while(validI==false) do
		i = math.random(1,#dests)
		if dests[i][4] == cityToUse then
			validI = true
		end
	end
	local x,y,z = dests[i][1],dests[i][2],dests[i][3]
	dx,dy,dz = x,y,z
	local px,py,pz = getElementPosition(localPlayer)
	local dist = getDistanceBetweenPoints3D(px,py,pz,x,y,z)
	totalDist=totalDist+dist
	timeleft=dist/12
	timeleft=timeleft+10
	timeleft=math.floor(timeleft+0.5)
	justFinished=false
	guiSetText(lblTarget,getZoneName(x,y,z))
	exports.CSGgps:setDestination ( x,y,z,"Police Patrol Mission Call", "", {false,true,false,true},"")
	destM = createMarker(x,y,z,"cylinder",20,255,255,0,0)
	--doEffect()
	guiSetVisible(window,true)
	if p2i == 5 then
		--songI=4
		songI = math.random(1,#songs)
	end
end

function hitMarker(e,dim)
	if dim == false then return end
	if e ~= localPlayer then return end
	if destM == nil then return end
	if source == destM then
		if p2i == 4 then
			msg = "The criminals are long gone! Stand by"
			 exports.DENdxmsg:createNewDxMessage(msg,255,255,0)
			reached()
			return
		end
		if sentEffectReq == false then sendEffectReq = true doEffect()  end
		local msg = ""
		if actualp2i == 2 then
			msg = "Quick! Neutrailize the criminals fighting by hitting them with your night stick!"
		end
		if actualp2i == 3 then
			msg = "Quick! Neutrailize the gang fighting by hitting them with your night stick!"
		end
		if actualp2i == 1 then
			msg = "Ticket the vehicles of interest! Neutrailize the driver by hitting them with your night stick!"
		end
		if actualp2i == 6 then
			msg = "Quick! Neutrailize the drug dealing criminals by hitting them with your night stick!"
		end
		if actualp2i == 5 then
			msg = "Quick! Stop the criminals from infecting CSG with bad songs!"
		end
		if actualp2i == 7 then
			msg = "Quick! Stop the hobo's misconduct!"
		end
		if msg ~= "" then
			 exports.DENdxmsg:createNewDxMessage(msg,255,255,0)
		end
		return
	end
	if p2i == 1 then
		for k,v in pairs(vehMarkers) do
			if v == source then
				workingMarker = source
				local r,g,b = getMarkerColor(workingMarker)
				if r==255 and g==0 and b==0 then
					exports.CSGprogressbar:createProgressBar("Ticketing...",50,"CSGpatrolMission.barFinish") -- 5 secs to finish
					setElementFrozen(localPlayer,true)
				end
			end
		end
	end
end
addEventHandler("onClientMarkerHit",root,hitMarker)

function doEffect()
	--if p2i == 2 then
		sentEffectReq = true
		triggerServerEvent("CSGpatrolMission.doEffect",lp,p2i,dx,dy,dz,songI)
		if p2i == 3 then p2i = 1 end
		if p2i == 6 or p2i == 7 or p2i == 5 then p2i = 2 end
	--end
end

function createText()
	if justFailed == true then
		dxDrawText("Mission Failed!",sx/2.7,sy/2.6,sx,sy,tocolor(255,255,0,255),2.5,"pricedown")
	elseif justFinished == true then
		dxDrawText("Mission Passed!",sx/2.7,sy/2.6,sx,sy,tocolor(0,255,0,255),2.5,"pricedown")
	end
end
addEventHandler("onClientRender",root,createText)

hits = {}
function recPeds(t)
	peds = t
	timeleft=timeleft+(#t*8)
	if p2i == 2 then
		for k,v in pairs(t) do
			hits[v] = 0
		end
	end
	attachElements(t[1],destM)
	if p2i == 1 or p2i == 2 then
		for k,v in pairs(t) do
			if getElementType(v) == "ped" then
				hits[v] = 0
			end
		end
	end
	if p2i == 1 then
		for k,v in pairs(t) do
			if getElementType(v) == "vehicle" then
				local x,y,z = getElementPosition(v)
				local m = createMarker(x,y,z,"cylinder",1,255,0,0)
				table.insert(vehMarkers,m)
				attachElements(m,v)
			end
		end
	end
end
addEvent("CSGpatrolMission.recPeds",true)
addEventHandler("CSGpatrolMission.recPeds",localPlayer,recPeds)

addEvent("onClientPedDamage",true)
addEventHandler("onClientPedDamage",root,function (atker,wep)
	if atker ~= localPlayer then return end
	if peds == nil then return end
	local valid = false
	for k,v in pairs(peds) do
		if v == source then valid = true cancelEvent() end
	end
	if valid == false then return end
	if wep ~= 3 then return end
	hits[source]=hits[source]+1
	if actualp2i == 6 then
		if hits[source] == 1 then
			triggerServerEvent("CSGpatrolMission.attackedDealingPed",localPlayer,source)
		end
	end
	if hits[source] == 5 then triggerServerEvent("CSGpatrolMission.neutrailizedPed",localPlayer,source) end
	if p2iCheck() == true then reached() end
end)

addEventHandler("onClientVehicleCollision", root,
    function(collider,force, bodyPart, x, y, z, nx, ny, nz)
		if force < 10 then return end
		-- exports.DENdxmsg:createNewDxMessage(force)
    end
)

function reached()
	triggerServerEvent("CSGpatrolMission.success",localPlayer,p2i)
	killPeds()
	destroyElement(destM)
	--removeEventHandler("onClientRender",root,createText)
	inProgress=false
	totalCalls=totalCalls+1
	timeSpared=timeSpared+timeleft
	 exports.DENdxmsg:createNewDxMessage("Successfully responded to the call. "..totalCalls.."/"..maxCalls.." Done.",0,255,0)
	if totalCalls == maxCalls then
		exports.CSGpriyenmisc:playCustomSound("complete.mp3")
		justFinished = true
		setTimer(function()  exports.DENdxmsg:createNewDxMessage("Completed the Patrol Mission.",0,255,0) end,1000,1)
		setTimer(function()  exports.DENdxmsg:createNewDxMessage("You Successfully responded to all calls in time.",0,255,0) end,2500,1)
		setTimer(function()  exports.DENdxmsg:createNewDxMessage("CSG's Civilians Thank you for your service!",0,255,0) end,5000,1)
		--addEventHandler("onClientRender",root,createText)
		setTimer(function() justFinished=false  --removeEventHandler("onClientRender",root,createText)
		end,8000,1)
		pay=totalDist*1.5
		local timeBonus=(timeSpared*25)
		tPay=pay+timeBonus
		pay=math.floor(pay+0.5)
		guiSetText(lblTarget,"Responded to "..maxCalls.."")
		guiSetText(lblDesc,"Time Spared: "..timeSpared.." Seconds")
		guiSetText(lblTimeLeft,"$"..pay.." + $"..timeBonus.." Time Bonus.")
		setTimer(function()  exports.DENdxmsg:createNewDxMessage("Paid $"..pay.." + $"..timeBonus.." Time Bonus",0,255,0)  end,5000,1)
		triggerServerEvent("CSGpatrolMission.success",localPlayer,p2i,true,tPay,maxCalls)
		cancel()
	else
		 exports.DENdxmsg:createNewDxMessage("Waiting for next call...",255,255,0)
		guiSetText(lblTarget,"Waiting for call...")
		guiSetText(lblDesc,"Waiting for call...")
		guiSetText(lblTimeLeft,"Time Left: N/A")
		setTimer(readyToCall,math.random(3000,10000),1)
		exports.CSGgps:resetDestination()
	end

end
--addEvent("CSGpatrolMission.reachedDest",true)
--addEventHandler("CSGpatrolMission.reachedDest",localPlayer,reached)

function readyToCall()
	if started == true then
		if inProgress == false then
			if isLaw() == true then
				doCall()
			else
				finish()
			end
		end
	end
end

local tms = {
	"Police","SWAT","Military Forces","Government Agency"
}

function isLaw()
	local myT = getPlayerTeam(localPlayer)
	if myT == false then return false end
	local myTN = getTeamName(myT)
	for k,v in pairs(tms) do
		if v == myTN then return true end
	end
	return false
end

function clearEffect()

end

function finish()
	totalCalls = 0
end

function killPeds()
	for k,v in pairs(vehMarkers) do
		destroyElement(v)
	end
	vehMarkers={}
	for k,v in pairs(peds) do
		destroyElement(v)
	end
	peds = {}
	hits = {}
end

function failed()
	if started == false then return end
	cancel()
	exports.CSGpriyenmisc:playCustomSound("fail.mp3")
	justFailed=true
	setTimer(function() justFailed=false end,8000,1)
	setTimer(function()  exports.DENdxmsg:createNewDxMessage("Failed the Patrol Mission.",255,0,0) end,1000,1)
	setTimer(function()  exports.DENdxmsg:createNewDxMessage("You failed to Successfully respond to the call in time!",255,0,0) end,2500,1)
	setTimer(function()  exports.DENdxmsg:createNewDxMessage("The streets of CSG need Police that can do the job! Try again next time.",255,0,0) end,5000,1)
	setTimer(function() justFailed=false  --removeEventHandler("onClientRender",root,createText)
	end,8000,1)
end
addEventHandler("onClientPlayerWasted",localPlayer,failed)
addEvent("CSGpatrolMission.servFailed",true)
addEventHandler("CSGpatrolMission.servFailed",localPlayer,failed)
addCommandHandler("cancel",failed)
addCommandHandler("Cancel",failed)

function updateGUI()
	if inProgress == true then
		timeleft=timeleft-1
		if timeleft == 0 then
			failed()
		end
		guiSetText(lblTimeLeft,"Time Left: "..timeleft.." Seconds")
	end
end
setTimer(updateGUI,1000,0)

addEventHandler("onClientResourceStart",resourceRoot,
    function()
        GUIEditor_Label = {}

        window = guiCreateWindow(0.0266,0.2839,0.2734,0.2956,"CSG Police Patrol",true)
        guiWindowSetSizable(window,false)
        GUIEditor_Label[1] = guiCreateLabel(0.0286,0.0661,0.94,0.1806,"Patrol Mission",true,window)
        guiLabelSetColor(GUIEditor_Label[1],0,255,0)
        guiLabelSetHorizontalAlign(GUIEditor_Label[1],"center",false)
        guiSetFont(GUIEditor_Label[1],"sa-header")
        GUIEditor_Label[2] = guiCreateLabel(0.1971,0.2731,0.6,0.0925,"Responding To Call:",true,window)
        guiLabelSetColor(GUIEditor_Label[2],255,255,0)
        guiLabelSetHorizontalAlign(GUIEditor_Label[2],"center",false)
        lblTarget = guiCreateLabel(0.2,0.348,0.6,0.0925,"Chinatown",true,window)
        guiLabelSetColor(lblTarget,255,250,255)
        guiLabelSetHorizontalAlign(lblTarget,"center",false)
        lblDesc = guiCreateLabel(0.2,0.4361,0.6,0.2555,"Domestic Violence Call. 22:21 Received Call. Struggling Man, bleeding, car crash",true,window)
        guiLabelSetColor(lblDesc,255,250,255)
        guiLabelSetHorizontalAlign(lblDesc,"center",true)
        lblTimeLeft = guiCreateLabel(0.1629,0.6652,0.6457,0.0925,"Time Left: 25 Seconds",true,window)
        guiLabelSetColor(lblTimeLeft,0,255,0)
        guiLabelSetHorizontalAlign(lblTimeLeft,"center",false)
        GUIEditor_Label[3] = guiCreateLabel(0.0286,0.7489,0.9514,0.0925,"-----------------------------------------------------------------------------------",true,window)
        guiLabelSetColor(GUIEditor_Label[3],255,250,255)
        GUIEditor_Label[4] = guiCreateLabel(0.0286,0.8062,0.9514,0.0925,"Type /cancel to cancel the mission",true,window)
        guiLabelSetColor(GUIEditor_Label[4],255,250,255)
        GUIEditor_Label[5] = guiCreateLabel(0.0286,0.8899,0.9514,0.0925,"Press Left Shift to toggle this window",true,window)
        guiLabelSetColor(GUIEditor_Label[5],255,250,255)
		guiSetVisible(window,false)
    end
)

addEventHandler("onClientResourceStart",resourceRoot,
    function()
        GUIEditor_Memo = {}

        startWindow = guiCreateWindow(0.075,0.2799,0.2734,0.3477,"CSG Patrol Mission",true)
        guiWindowSetSizable(startWindow,false)
        GUIEditor_Memo[1] = guiCreateMemo(0.0657,0.1199,0.8657,0.5243,"Sometimes the streets of CSG are not safe. We need law constantly around and ready to respond. During the mission, you simply have to patrol the streets and respond to any calls given. You are paid after you respond to 3-5 Calls. Failure to respond to any will result in no payment. By starting this mission you hereby dedicate 100% of yourself to protecting the citizens of CSG.",true,startWindow)
        guiMemoSetReadOnly(GUIEditor_Memo[1],true)
        btnStart = guiCreateButton(0.0629,0.6704,0.4086,0.1236,"Start",true,startWindow)
        btnCancel = guiCreateButton(0.5229,0.6704,0.4086,0.1236,"Cancel",true,startWindow)
        btnExit = guiCreateButton(0.0629,0.8315,0.8743,0.1236,"Exit",true,startWindow)
		guiSetVisible(startWindow,false)
    end
)

markers = {}
made=false
function makeMarkers()
	if made == false then
		for k,v in pairs(starts) do
			local m = createMarker(v[1],v[2],v[3],"cylinder",2,30,144,255,100)
			markers[m] = k
			markers[k] = m
			markersCity[m] = v[4]
			addEventHandler("onClientMarkerHit",m,markerHit)
		end
		made=true
	end
end


function killMarkers()
	if made==true then
		for k,v in pairs(markers) do
			if isElement(v) == true then
				removeEventHandler("onClientMarkerHit",v,markerHit)
				destroyElement(v)
			end
		end
		markers = {}
		markersCity={}
		made=false
	end
end

function manageMarkers()
	if isLaw() == true then makeMarkers() else killMarkers() end
end
setTimer(manageMarkers,2000,0)

addEventHandler( "onClientRender",root,
   function( )
      local px, py, pz, tx, ty, tz, dist
      px, py, pz = getCameraMatrix( )
      for _, v in ipairs( peds ) do
		-- if getElementType(v) == "ped" then
         tx, ty, tz = getElementPosition( v )
         dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
         if dist < 30.0 then
            if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
               local sx, sy, sz = 0,0,0
			   local x = false
			   if getElementType(v) == "ped" then
					sx, sy, sz = getPedBonePosition( v, 5 )
					x,y = getScreenFromWorldPosition( sx, sy, sz + 0.3 )
				else
					sx, sy, sz = getElementPosition( v )
					x,y = getScreenFromWorldPosition( sx, sy, sz + 1.2 )
			   end


               if x then -- getScreenFromWorldPosition returns false if the point isn't on screen
			   local r,g,b = 255,0,0
			   local txt = ""
			   	if p2i == 2 then
				if hits[v] >=5 then
					txt = ">> Criminal - Neutrailized <<" r,g,b = 0,255,0
				else
					if getElementType(v) ~= "ped" then
						txt = ">> Speaker: "..lyric.." <<"  r,g,b = 255,0,0
					else
						txt = ">> Criminal - Neutrailize <<"  r,g,b = 255,0,0
					end
				end
			end
			if p2i == 1 then
				if getElementType(v) == "marker" then
					txt = ">> Ticket <<"
					r,g,b = getMarkerColor(vehMarkers[k])
					if g == 255 then
						txt = ">> Ticketed <<"
					end
				elseif getElementType(v) == "ped" then
					if hits[v] >=5 then txt = ">> Criminal - Neutrailized <<" r,g,b = 0,255,0 else  txt = ">> Criminal - Neutrailize <<"  r,g,b = 255,0,0 endtxt = ">> Criminal - Neutrailize <<" end
				end
			end
                dxDrawText( txt, x, y, x, y, tocolor(r,g,b), 0.85 + ( 15 - dist ) * 0.03)
               end
            end
         end
		-- end
      end
   end
)

addEventHandler("onClientResourceStart",resourceRoot,makeMarkers)
