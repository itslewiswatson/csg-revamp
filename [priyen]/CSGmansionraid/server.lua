local spawnPositions = {
--[[{1305.01953125,-787.185546875,1084.0078125,173.57836914062},
{1296.3984375,-792.056640625,1084.0078125,324.6591796875},
{1290.62109375,-783.6337890625,1084.0148925781,27.952392578125},
{1276.501953125,-783.001953125,1084.0148925781,27.952392578125},
{1270.32421875,-774.419921875,1084.0078125,264.81024169922},

{1276.7236328125,-768.6953125,1084.0078125,189.60768127441},
{1263.9677734375,-765.12890625,1084.0078125,179.26940917969},
{1260.98828125,-773.5234375,1084.0078125,269.2707824707},
{1248.1142578125,-765.7109375,1084.015625,217.49690246582},
{1253.486328125,-769.2021484375,1084.0078125,262.49758911133},

{1249.8759765625,-774.130859375,1084.0078125,179.89562988281},
{1242.2001953125,-776.9375,1084.0078125,253.81826782227},
{1246.3505859375,-776.533203125,1084.0078125,163.82238769531},
{1249.662109375,-786.25390625,1084.0078125,178.30810546875},
{1249.3623046875,-789.759765625,1084.0078125,358.30532836914},
{1250.3896484375,-789.5419921875,1084.0078125,268.30395507812},
{1253.5078125,-794.671875,1084.234375,303.64202880859},
{1259.4189453125,-794.7626953125,1084.234375,33.637908935547},
{1265.5322265625,-794.2294921875,1084.0078125,303.64202880859},
{1268.875,-788.4619140625,1084.0078125,123.63928222656},

{1275,-788.0537109375,1084.0078125,213.64064025879},
{1284.4404296875,-787.7275390625,1084.0078125,134.12588500977},
{1283.1123046875,-792.79296875,1084.0148925781,179.12658691406},
{1283.607421875,-801.4228515625,1084.0078125,44.12451171875},
{1274.3212890625,-799.75390625,1084.0078125,101.2268371582},

{1270.3095703125,-805.638671875,1084.0078125,88.378112792969},

{1267.9677734375,-804.693359375,1084.0078125,252.23071289062},

{1244.158203125,-812.5390625,1084.0078125,96.502624511719},
{1226.6435546875,-817.7421875,1084.0078125,186.50401306152},
{1228.06640625,-836.931640625,1084.0078125,267.96887207031},
{1244.9326171875,-837.4833984375,1084.0078125,287.00845336914},
{1253.5400390625,-832.4873046875,1084.0148925781,287.00845336914},
{1257.6875,-830.181640625,1084.0148925781,90.092010498047},
{1257.8828125,-826.015625,1084.0078125,172.54565429688},

{1246.921875,-825.095703125,1084.0078125,217.54635620117},

 {1246.921875,-825.095703125,1084.0078125,217.54635620117},

{1294.1484375,-833.4189453125,1085.6328125,177.60491943359},

{1291.2705078125,-829.3544921875,1085.6328125,108.50537109375},

{1283.791015625,-819.287109375,1085.6328125,170.30444335938},

{1278.5263671875,-811.79296875,1085.6328125,150.82537841797},

{1271.6181640625,-829.5419921875,1085.6328125,218.84823608398},
{1282.291015625,-836.50390625,1089.9816894531,95.777526855469},
{1282.31640625,-828.0234375,1089.9375,358.73928833008},

{1274.298828125,-819.9970703125,1089.9375,310.17349243164},
{1288.9912109375,-804.861328125,1089.9375,130.52780151367},
{1277.759765625,-808.390625,1089.9375,3.150390625},

{1291.5166015625,-796.58984375,1089.9375,86.499420166016},
{1290.9345703125,-788.505859375,1089.9375,179.0771484375},
{1274.1259765625,-789.6298828125,1089.9317626953,357.75051879883},
{1273.2333984375,-793.36328125,1089.9301757812,302.36209106445},

{1281.8115234375,-781.39453125,1089.9375,80.835876464844},

{1266.99609375,-780.443359375,1091.90625,277.12609863281},
{1263.4560546875,-772.9423828125,1091.90625,201.75875854492},
{1285.6123046875,-775.056640625,1091.90625,151.62738037109},--]]
{1284.7861328125,-781.845703125,1084.0078125,89.691009521484},
{1263.892578125,-769.5361328125,1084.0078125,85.933624267578},
{1249.8505859375,-788.9677734375,1084.0078125,183.69694519043},
{1265.8759765625,-795.158203125,1084.0078125,355.23461914062},
{1283.2607421875,-788.9775390625,1084.0148925781,168.96954345703},
{1273.0322265625,-789.0029296875,1084.0078125,89.696502685547},
{1262.1904296875,-800.19140625,1084.0078125,195.60081481934},
{1266.78515625,-808.091796875,1084.0078125,95.310607910156},
{1226.240234375,-836.8720703125,1084.0078125,177.40716552734},
{1256.90625,-835.888671875,1084.0078125,274.25863647461},
{1233.7158203125,-812.8369140625,1084.0078125,163.619140625},
{1277.2265625,-835.05859375,1085.6328125,289.7331237793},
{1278.5888671875,-812.3212890625,1085.6328125,167.52484130859},
{1282.2919921875,-811.326171875,1089.9375,1.6012878417969},
{1274.4521484375,-773.7744140625,1091.90625,192.39825439453},
{1254.142578125,-794.263671875,1084.234375,267.04052734375},
{1279.208984375,-786.734375,1084.0148925781,142.33279418945},
}

local pedSkins = {
    117,118
	}

local enterMarkers = {}
local exitMarkers = {}
local lawSignUp = createMarker(1256.32, -776.17, 92.03-1,"cylinder",4,0,0,255,100)
local crimSignUp = createMarker( 1305.36, -798.32, 84.14-1,"cylinder",4,255,0,0,100)
local lawSignUpCol = createColCircle(1256.32, -776.17,3)
local crimSignUpCol = createColCircle( 1305.36, -798.32,3)
local timeLeft=0
local started=false
local weps = {
    6,7,8,9,25,31,30,33,34,31,30,33,34,31,30,33,34,31,30,33,34,31,30,33,34,31,30,33,34
 }
local eint,edim = 5,1
local peds = {}
local spawnedPlaces = {}
local timeTillEnd = 0
local crimse = {}
local lawse = {}
local entered = {}
local remainingpeds = 1
local team = "crim"
local startseq=false
local startcd = 60
local allowedToJoin={}

setTimer(function()
	for k,v in pairs(allowedToJoin) do
		if (v) and getTickCount() - v > 7200000 then
			allowedToJoin[k]=nil
 		end
	end
end,10000,0)
function msg(a,b,c,d,e)
	exports.DENdxmsg:createNewDxMessage(a,b,c,d,e)
end

local enterPos = {
        --{x,y,z,warptox,warptoy,warptoz,rotation of player after warp}
        {1258.43, -783.07, 92.03 ,1263.13, -785.43, 1091.9,267},
        { 1258.51, -787.86, 92.03,1263.13, -785.43, 1091.9,267},
        {1300.59, -798.41, 84.18,1298.79, -794.23, 1084,350}
    }

local exitPos = {
        {1260.64, -785.37, 1091.9,1254.78, -785.47, 92.03,84},
        {1298.91, -796.9, 1084, 1299.55, -800.94, 84.14,192},

    }

addEventHandler("onMarkerHit",lawSignUp,function(p,dim)
	if dim == false then return end
	if started == true then
		if team == "law" then
			exports.DENdxmsg:createNewDxMessage(p,"The Law Mansion Raid is occuring at the moment",255,255,0)
		else
			exports.DENdxmsg:createNewDxMessage(p,"The Criminal Mansion Raid is occuring at the moment",255,255,0)
		end
	else
		local acc = exports.server:getPlayerAccountName(p)
		if (allowedToJoin[acc]) then

			exports.DENdxmsg:createNewDxMessage(p,"You did this event recently. You can only join this event once per 2 hours",0,0,255)
			return
		end
		exports.DENdxmsg:createNewDxMessage(p,"This is Law Mansion Raid Law Marker (/raidtime)",0,0,255)
		if team == "law" then
			exports.DENdxmsg:createNewDxMessage(p,"The next Mansion Raid is going to be for Law Enforcement",0,0,255)
			if timeLeft > 0 then
				exports.DENdxmsg:createNewDxMessage(p,"Come back here in "..timeLeft.." seconds",0,0,255)
			else
				--exports.DENdxmsg:createNewDxMessage(p,"The event can be started, get 4 Law players in the marker",0,0,255)
				exports.DENdxmsg:createNewDxMessage(p,"Required to Start: "..(getLawMarkerCount()+1).."/4 Law.",0,255,0)
			end
		else
			exports.DENdxmsg:createNewDxMessage(p,"The next Mansion Raid is going to be for Criminals",0,0,255)
			exports.DENdxmsg:createNewDxMessage(p,"This marker only works when the mansion raid is for Law",0,0,255)
		end
		--if getLawCount() < 5 then

		--end
		startCheck()
	end
end)

setTimer(function()
	if timeLeft > 0 then timeLeft=timeLeft-1 end
	if timeTillEnd > 0 then
		timeTillEnd=timeTillEnd-1
		if timeTillEnd==0 then
			checkDone()
		end
	end
	if startcd > 0 then
		startcd=startcd-1
	end
end,1000,0)

picked={}
function endIt(winner)
	if started==false then return end
	for k,v in pairs(peds) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	peds={}
	if (winner) then
		if winner=="crims" then
			for k,v in pairs(crimse) do
				msg(v,"MD Mansion has been successfully raided. Go to the safe for money!",0,255,0)
				msg(v,"You have 1 minute to steal the money!",0,255,0)
			end
			for k,v in pairs(getElementsByType("player")) do
				msg(v,"The Criminal Forces have successfully raided MD Mansion!",0,255,0)
			end
		elseif winner=="laws" then
			for k,v in pairs(lawse) do
				msg(v,"MD Mansion has been cleared of hostile forces. Go to the safe and collect the illegal money!",0,255,0)
				msg(v,"You have 1 minute to collect the money!",0,255,0)
			end
			for k,v in pairs(getElementsByType("player")) do
				msg(v,"The Law Forces have successfully raided MD Mansion!",0,255,0)
			end
		else
			if team == "law" then
				for k,v in pairs(lawse) do
					msg(v,"Mansion Raid has failed!",255,0,0)
					msg(v,"The Mafia Men have taken over, too much time has past!",255,0,0)
					--killPed(v)
					triggerClientEvent(v,"onResetmansionraidStats",v)
				end
			else
				for k,v in pairs(crimse) do
					msg(v,"Mansion Raid has failed!",255,0,0)
					msg(v,"The Security Guards have taken over, too much time has past!",255,0,0)
					triggerClientEvent(v,"onResetmansionraidStats",v)
					--killPed(v)
				end
			end
		end
		local t = {}
		local x2,y2,z2 = 1230.76, -807.18, 1084
		local obj = createObject(1550,x2,y2,z2)
		table.insert(t,obj)
		local m = createMarker(x2,y2,z2-1,"cylinder",2)
		setElementInterior(m,eint)
		setElementDimension(m,edim)
		setElementInterior(obj,eint)
		setElementDimension(obj,edim)
		addEventHandler("onMarkerHit",m,hitbag)
		setTimer(function() destroyElement(obj) end,60000,1)
		setTimer(function() destroyElement(m) picked={} end,60000,1)

		for k,v in pairs(crimse) do
			triggerClientEvent(v,"CSGmansionRecBags",v,t,60000)
		end

		for k,v in pairs(lawse) do
			triggerClientEvent(v,"CSGmansionRecBags",v,t,60000)
		end
		offwinner=winner
	end
	timeTillEnd=0
	timeLeft=3600
	if team == "law" then team = "crim" else team = "law" end
	started=false
	picked={}
	entered={}
	startedseq=false

end

function hitbag(p,dim )
	if dim == false then return end
	if offwinner == "crims" then
		if getTeamName(getPlayerTeam(p)) == "Criminals" then
			if picked[p] ~= nil then return end
			local m = math.random(10000,15000)
			givePlayerMoney(p,m)
			msg(p,"Picked up $"..m.."!",0,255,0)
			picked[p]=true
		end
	elseif offwinner=="laws" then
		if isLaw(p) then
			if picked[p] ~= nil then return end
			local m = math.random(10000,15000)
			givePlayerMoney(p,m)
			msg(p,"Picked up $"..m.."!",0,255,0)
			picked[p]=true
		end
	end
	triggerClientEvent(p,"CSGmd.getKC",p)
end

addEvent("CSGmd.recKC",true)
addEventHandler("CSGmd.recKC",root,function(kills)
	if kills > 0 then
		givePlayerMoney(source,kills*500)
		msg(p,"Picked up $"..(kills*500).." for "..kills.." kills",0,255,0)
	end
end)

addEventHandler("onMarkerHit",crimSignUp,function(p,dim)
	if dim == false then return end
	if started == true then
		if team == "crim" then
			exports.DENdxmsg:createNewDxMessage(p,"The Criminal Mansion Raid is occuring at the moment",255,255,0)
		else
			exports.DENdxmsg:createNewDxMessage(p,"The Law Enforcement Mansion Raid is occuring at the moment",255,255,0)
		end
	else
		if (allowedToJoin[acc]) then

			exports.DENdxmsg:createNewDxMessage(p,"You did this event recently. You can only join this event once per 2 hours",0,0,255)
			return
		end
		exports.DENdxmsg:createNewDxMessage(p,"This is Criminal Mansion Raid Law Marker (/raidtime)",0,0,255)
		if team == "crim" then
			exports.DENdxmsg:createNewDxMessage(p,"The next Mansion Raid is going to be for Criminals",0,0,255)
			if timeLeft > 0 then
				exports.DENdxmsg:createNewDxMessage(p,"Come back here in "..timeLeft.." seconds",0,0,255)
			else
				--exports.DENdxmsg:createNewDxMessage(p,"The event can be started, get 4 Law players in the marker",0,0,255)
				exports.DENdxmsg:createNewDxMessage(p,"Required to Start: "..(getCrimMarkerCount()+1).."/5 Criminals.",0,255,0)
			end
		else
			exports.DENdxmsg:createNewDxMessage(p,"The next Mansion Raid is going to be for Law Enforcement",0,0,255)
			exports.DENdxmsg:createNewDxMessage(p,"This marker only works when the mansion raid is for Criminals",0,0,255)
		end
		--if getLawCount() < 5 then

		--end
		startCheck()
	end
end)


function startCheck()
	if timeLeft==0 then
		if started==false and startseq==false then

			if (team=="law" and getLawMarkerCount()+1 >= 4) or (team=="crim" and getCrimMarkerCount()+1 >= 5) then --edit here the rquirements
				startseq=true
				started=false
				loadEnters()
				loadExits()
				spawnPeds(8)
				startcd=60
				if team == "crim" then
				setTimer(function()
				local _,crims = getCrimMarkerCount()
				local cx,cy,cz,crz = 1298.79, -794.23, 1084,350
				for k,v in pairs(crims) do
					setElementInterior(v,eint)
					setElementDimension(v,edim)
					setElementPosition(v,cx+math.random(-1,1),cy+math.random(-1,1),cz)
					setElementRotation(v,0,0,crz)
					triggerClientEvent(v,"onTogglemansionraidStats",v,true)
					table.insert(crimse,v)
					entered[v]=true
					setElementFrozen(v,true)
					setTimer(function() setElementFrozen(v,false) end,3000,1)
					setElementHealth(v,100)
					setPedArmor(v,100)
					allowedToJoin[exports.server:getPlayerAccountName(v)] = getTickCount()
				end
				end,60000,1)
				end
				if team == "law" then
				setTimer(function()
				local _,laws = getLawMarkerCount()
				local lx,ly,lz,lrz =  1271.68, -778.57, 1091.9 ,267
				for k,v in pairs(laws) do
					setElementInterior(v,eint)
					setElementDimension(v,edim)
					setElementPosition(v,lx+math.random(-1,1),ly+math.random(-1,1),lz)
					setElementRotation(v,0,0,lrz)
					triggerClientEvent(v,"onTogglemansionraidStats",v,true)
					table.insert(lawse,v)
					entered[v]=true
					setElementFrozen(v,true)
					setTimer(function() setElementFrozen(v,false) end,3000,1)
					setElementHealth(v,100)
					setPedArmor(v,100)
					allowedToJoin[exports.server:getPlayerAccountName(v)] = getTickCount()
				end
				end,60000,1)
				end
				for k,v in pairs(getElementsByType("player")) do
					if team == "law" then
						msg(v,"Mansion Raid (Law) start sequence initiated. Be in the marker within 60 seconds!",0,255,0)
					else
						msg(v,"Mansion Raid (Criminals) start sequence initiated. Be in the marker within 60 seconds!",0,255,0)
					end
				end
				setTimer(function()
				started=true
				startseq=false
				local _,allLaws=getLawCount()
				local _,allCrims=getCrimCount()
				remainingpeds=0
				if team == "law" then
					for k,v in pairs(lawse) do
						msg(v,"MD Mansion Raid has started! Take down all criminals",0,255,0)
						remainingpeds=remainingpeds+16
					end

				else
					for k,v in pairs(crimse) do
						msg(v,"MD Mansion Raid has started! Take down all security guards!",0,255,0)
						remainingpeds=remainingpeds+16
					end

				end
				timeTillEnd=900
				for k,v in pairs(getElementsByType("player")) do
					triggerClientEvent(v,"CSGmraid.started",v,timeTillEnd)
				end
				sendUpdatedStats()
				end,60000,1)
			end
		end
	end
end

addEventHandler("onPlayerWasted",root,function(_,killer)
	if isLaw(source) then
		for k,v in pairs(lawse) do
			if v==source then
				table.remove(lawse,k)
				msg(v,"You died during the Mansion Raid! Better luck next time!",255,0,0)
				if (killer) then
		if isElement(killer) then
			local source=killer
			if isLaw(source) then
		givePlayerMoney(source,1500)
		msg(source,"Killed a enemy! Paid $1500 and +0.5 Score!",0,255,0)
		exports.CSGscore:givePlayerScore(source,0.5)
	else
		givePlayerMoney(source,1500)
		msg(source,"Killed a enemy! Paid $1500 and +0.5 Score!",0,255,0)
		exports.CSGscore:givePlayerScore(source,0.5)
	end
	checkDone()
		end
	end
				sendUpdatedStats()
				break
			end
		end
	else
		for k,v in pairs(crimse) do
			if v==source then
				table.remove(crimse,k)
				sendUpdatedStats()
				msg(v,"You died during the Mansion Raid! Better luck next time!",255,0,0)
				if (killer) then
		if isElement(killer) then
			local source=killer
			if isLaw(source) then
		givePlayerMoney(source,1500)
		msg(source,"Killed a enemy! Paid $1500 and +0.5 Score!",0,255,0)
		exports.CSGscore:givePlayerScore(source,0.5)
	else
		givePlayerMoney(source,1500)
		msg(source,"Killed a enemy! Paid $1500 and +0.5 Score!",0,255,0)
		exports.CSGscore:givePlayerScore(source,0.5)
	end
	checkDone()
		end
	end
				break
			end
		end
	end

end)

addEventHandler("onPlayerQuit",root,function(_,killer)
	for k,v in pairs(lawse) do
			if v==source then
				table.remove(lawse,k)
				sendUpdatedStats()
				break
			end
		end
	for k,v in pairs(crimse) do
			if v==source then
				table.remove(crimse,k)
				sendUpdatedStats()
				break
			end
		end
end)

function spawnPeds(amount)
        for count=1,amount do
                local i = math.random(1,#spawnPositions)
				while (spawnedPlaces[i]~=nil) do
					i = math.random(1,#spawnPositions)
				end
				spawnedPlaces[i]=true
				local x,y,z,rz = unpack(spawnPositions[i])
                local ped = exports.slothbot:spawnBot(x,y,z,rz,pedSkins[math.random(1,#pedSkins)],eint,edim,getTeamFromName("Staff"),weps[math.random(1,#weps)])
				table.insert(peds,ped)
            end
		spawnedPlaces={}
    end

function loadEnters()
    for k,v in pairs(enterPos) do
            local x,y,z = unpack(v)
            local m = createMarker(x,y,z+1,"arrow",2)
            enterMarkers[m] = k
            addEventHandler("onMarkerHit",m,hitEnter)
        end
    end

function loadExits()
    for k,v in pairs(exitPos) do
            local x,y,z = unpack(v)
            local m = createMarker(x,y,z+1,"arrow",2)
            exitMarkers[m]=k
            setElementDimension(m,edim)
            setElementInterior(m,eint)
            addEventHandler("onMarkerHit",m,hitLeave)
        end
    end

 function hitEnter(player,dim)
	if 1+1 == 2 then return end --no use at the moment
    if dim == false then return end
    if isPedInVehicle(player) then
        return
    else
		if started==false then
			msg(player,"MD Mansion Raid is not occuring rightnow. You can't enter.",255,0,0)
			return
		end
        if isLaw(player) == true or getTeamName(getPlayerTeam(player)) == "Criminals" then
			if entered[player] ~= nil then
				msg(player,"You died! You can't re-enter the mansion again during the same raid!",255,0,0)
				return
			end
			entered[player]=true
            local _,_,_,tx,ty,tz,rz = unpack(enterPos[enterMarkers[source]])
            setElementPosition(player,tx,ty,tz)
            setElementInterior(player,eint)
            setElementDimension(player,edim)
            setElementRotation(player,0,0,rz)
			triggerClientEvent(player,"onTogglemansionraidStats",player,true)
			if isLaw(player) then
				table.insert(player,lawse)
			else
				table.insert(player,crimse)
			end
			sendUpdatedStats()
        end
    end
end

function sendUpdatedStats()
	for k,v in pairs(getElementsByType("player")) do
		triggerClientEvent(v,"onChangeMansionCount",v,#lawse,#crimse,remainingpeds+(#peds))
	end
end

 function hitLeave(player,dim)

    if dim == false then return end
	if getElementType(player) ~= "player" then return end
    if isPedInVehicle(player) then
        return
    else
		if timeTillEnd == 0 then
       -- if isLaw(player) == true or getTeamName(getPlayerTeam(player)) == "Criminals" then
            local _,_,_,tx,ty,tz,rz = unpack(exitPos[exitMarkers[source]])

            setElementInterior(player,0)
    		setElementPosition(player,tx,ty,tz)
            setElementDimension(player,0)
            setElementRotation(player,0,0,rz)
			triggerClientEvent(player,"onTogglemansionraidStats",player,false)
       -- end
		else
			msg(player,"You can't leave while the Mansion Raid is in progress! Fight!",255,0,0)
		end
    end
end

addEvent("CSGmraid.payme",true)
addEventHandler("CSGmraid.payme",root,function(ped)

	for k,v in pairs(peds) do
		if v == ped then table.remove(peds,k) end
	end
		if remainingpeds > 0 then
			remainingpeds=remainingpeds-1
		end
		if remainingpeds == 0 and #peds == 0 then
			for k,v in pairs(lawse) do
				exports.DENdxmsg:createNewDxMessage(v,"All the Mafia bots have beed killed!",0,255,0)
				exports.DENdxmsg:createNewDxMessage(v,"Kill off remaining criminals to take over the mansion!",0,255,0)
			end
			for k,v in pairs(crimse) do
				exports.DENdxmsg:createNewDxMessage(v,"All the Mafia bots have beed killed!",0,255,0)
				exports.DENdxmsg:createNewDxMessage(v,"Kill off remaining law forces to take over the mansion!",0,255,0)
			end
		elseif remainingpeds == 5 then
			for k,v in pairs(lawse) do
				exports.DENdxmsg:createNewDxMessage(v,""..(5+(#peds)).." More Mafia men remaining only!",0,255,0)

			end
			for k,v in pairs(crimse) do
				exports.DENdxmsg:createNewDxMessage(v,""..(5+(#peds)).." More Mafia men remaining only",0,255,0)
			end
		elseif remainingpeds > 0 then
			spawnPeds(1)
		end

	if isLaw(source) then
		givePlayerMoney(source,1500)
		msg(source,"Killed a enemy! Paid $1500 and +0.5 Score!",0,255,0)
		exports.CSGscore:givePlayerScore(source,0.5)
	else
		givePlayerMoney(source,1500)
		msg(source,"Killed a enemy! Paid $1500 and +0.5  Score!",0,255,0)
		exports.CSGscore:givePlayerScore(source,0.5)
	end
	sendUpdatedStats()
	checkDone()
end)

function checkDone()
	if team == "law" then
		if #peds == 0 or (remainingpeds+(#peds) == 5) then
			endIt("laws")
		elseif #lawse == 0 then
			endIt()
		end
	elseif team =="crim" then
		if #peds == 0 or (remainingpeds+(#peds) == 5) then
			endIt("crims")
		elseif #crimse == 0 then
			endIt()
		end
	end
	if timeTillEnd==0 then
		endIt()
	end
end

function isLaw(e)
    local n = getTeamName(getPlayerTeam(e))
    if n == "Police" or n == "Government Agency" or n == "SWAT" or n == "Military Forces" then return true else return false end
end

function getLawMarkerCount()
	local t = getElementsWithinColShape(lawSignUpCol,"player")
	if t==false then t = {} end
	for k,v in pairs(t) do
		if isLaw(v) == false or (allowedToJoin[exports.server:getPlayerAccountName(v)]) then table.remove(t,k) end
	end
	return #t,t
end

function getCrimMarkerCount()
	local t = getElementsWithinColShape(crimSignUpCol,"player")
	if t==false then t = {} end
	for k,v in pairs(t) do
		if getTeamName(getPlayerTeam(v)) ~= "Criminals" or (allowedToJoin[exports.server:getPlayerAccountName(v)]) then table.remove(t,k) end
	end
	return #t,t
end

function getLawCount()
	local t = getLawTable()
	if t==false or t==nil then t = {} end
	return #t,t
end

function getCrimCount()
	local t = getElementsByType("player")
	if t==false then t = {} end
	for k,v in pairs(t) do
		if getTeamName(getPlayerTeam(v)) ~= "Criminals" then table.remove(t,k) end
	end
	return #t,t
end

local lawTeams = {
	"Military Forces",
	"SWAT",
	"Police",
	"Government Agency"
}

function getLawTable()
	local law = {}
	for k,v in pairs (lawTeams) do
		local list = getPlayersInTeam(getTeamFromName(v))
		for k,v in pairs(list) do
			table.insert(law,v)
		end
	end
	return law
end
addCommandHandler("mypos",function(ps)
        local x,y,z = getElementPosition(ps)
        local rx,ry,rz = getElementRotation(ps)
        outputChatBox('{'..x..','..y..','..z..','..rz..'},',ps)
    end)

addCommandHandler("raidtime",function(ps)
		if started==true or startseq==true then
			if startseq and started then
				if team == "law" then
					msg(ps,"MD Mansion Raid (Law Enforcement) is occuring rightnow!",0,255,0)
				else
					msg(ps,"MD Mansion Raid (Criminals) is occuring rightnow!",0,255,0)
				end

			elseif startseq and not started then
				if team == "law" then
					msg(ps,"MD Mansion Raid (Law Enforcement) is going to start in "..startcd.." Seconds",0,255,0)
				else
					msg(ps,"MD Mansion Raid (Criminals) is going to start in "..startcd.." Seconds",0,255,0)
				end
			else
				if team == "law" then
					msg(ps,"MD Mansion Raid (Law Enforcement) is occuring rightnow!",0,255,0)
				else
					msg(ps,"MD Mansion Raid (Criminals) is occuring rightnow!",0,255,0)
				end
			end
		else
			if timeLeft > 0 then
				if team == "law" then
					exports.DENdxmsg:createNewDxMessage(ps,"MD Mansion Raid (Law Enforcement) can be started in "..timeLeft.." Seconds",0,255,0)
				else
					exports.DENdxmsg:createNewDxMessage(ps,"MD Mansion Raid (Criminals) can be started in "..timeLeft.." Seconds",0,255,0)
				end

			else
				if team == "law" then
					exports.DENdxmsg:createNewDxMessage(ps,"MD Mansion Raid (Law Enforcement) can be now be started!",0,255,0)
				else
					exports.DENdxmsg:createNewDxMessage(ps,"MD Mansion Raid (Criminals) can be now be started!",0,255,0)
				end
			end
		end
	end)

loadEnters()
loadExits()











