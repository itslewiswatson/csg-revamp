
GUIEditor = {
    label = {},
    window = {},
}
window = guiCreateWindow(283, 149, 766, 424, "Community of Social Gaming ~ Law Specialties", false)
guiWindowSetSizable(window, false)

lbljob1 = guiCreateLabel(0.02, 0.08, 0.16, 0.05, "Pick Pocket", true, window)
guiLabelSetColor(lbljob1, 255, 0, 0)
imgjob1 = guiCreateStaticImage(162, 31, 216, 104, "chief.png", false, window)
lbljob1desc = guiCreateLabel(11, 58, 141, 76, "Pick Pockets get less money then Con Artists, but are more successfull in criminal life. (25 Score Required)", false, window)
guiLabelSetHorizontalAlign(lbljob1desc, "left", true)
lbljob2 = guiCreateLabel(14, 142, 123, 23, "Con Artist", false, window)
guiLabelSetColor(lbljob2, 255, 0, 0)
lbljob2desc = guiCreateLabel(11, 167, 141, 76, "Con Artist's are not as succesfull as Pick Pocket's, but when they are, its big. (50 Score Required)", false, window)
guiLabelSetHorizontalAlign(lbljob2desc, "left", true)
imgjob2 = guiCreateStaticImage(162, 141, 216, 104, "chief.png", false, window)
lbljob3 = guiCreateLabel(14, 251, 123, 23, "The Regular Criminal", false, window)
guiLabelSetColor(lbljob3, 91, 250, 4)
lbljob3desc = guiCreateLabel(11, 276, 141, 76, "The Regular Criminal is more successfull in criminal activities then civilians.  ", false, window)
guiLabelSetHorizontalAlign(lbljob3desc, "left", true)
imgjob3 = guiCreateStaticImage(162, 251, 216, 104, "chief.png", false, window)
GUIEditor.label[7] = guiCreateLabel(8, 361, 747, 17, ">> A = Arrests, S = Score. Click on the image to become that type of law officer. <<", false, window)
guiLabelSetColor(GUIEditor.label[7], 0, 255, 255)
guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", true)
lbljob4 = guiCreateLabel(390, 33, 123, 23, "Don of LV", false, window)
guiLabelSetColor(lbljob4, 255, 0, 0)
imgjob4 = guiCreateStaticImage(540, 31, 216, 104, "chief.png", false, window)
lbljob4desc = guiCreateLabel(389, 58, 141, 76, "Don of LV turf at a more efficient rate. Their respect and reputation allow them to turf faster.	(250 Score Required)", false, window)
guiLabelSetHorizontalAlign(lbljob4desc, "left", true)
lbljob5 = guiCreateLabel(390, 142, 123, 23, "Capo", false, window)
guiLabelSetColor(lbljob5, 255, 0, 0)
lbljob5desc = guiCreateLabel(389, 167, 141, 76, "Capo's are not Don's, but better turfer's then other types of criminals. (100 Score Required)", false, window)
guiLabelSetHorizontalAlign(lbljob5desc, "left", true)
lbljob6desc = guiCreateLabel(390, 276, 141, 76, "Burgler's are more successfull in robbing stores and houses. There luck may vary.  (50 Score Required)", false, window)
guiLabelSetHorizontalAlign(lbljob6desc, "left", true)
lbljob6 = guiCreateLabel(391, 251, 123, 23, "Burgler", false, window)
guiLabelSetColor(lbljob6, 255, 0, 0)
imgjob5 = guiCreateStaticImage(540, 141, 216, 104, "chief.png", false, window)
imgjob6 = guiCreateStaticImage(540, 251, 216, 104, "chief.png", false, window)
btnprevious = guiCreateButton(9, 387, 143, 28, "<<< Previous <<<", false, window)
btnforward = guiCreateButton(612, 387, 143, 28, ">>> Forward >>>", false, window)
btnexit = guiCreateButton(300, 387, 143, 28, ">>> Exit <<<", false, window)
guiSetVisible(window,false)
local elements = {
	{lbljob1,lbljob1desc,imgjob1},
	{lbljob2,lbljob2desc,imgjob2},
	{lbljob3,lbljob3desc,imgjob3},
	{lbljob4,lbljob4desc,imgjob4},
	{lbljob5,lbljob5desc,imgjob5},
	{lbljob6,lbljob6desc,imgjob6},
}
local markers = {}

local poses = {
	{1569.63, -1634.14, 12.55,352},
	{ 2347.94, 2452.33, 13.97,79},
	{-1622.93, 690.29, 6.18,44},
	{2943.51, -1910.86, 10.02,270,skin=285,group="SWAT Team"},
	{ 88.89, 1910.92, 16.83,81,skin=97,group="Military Forces"},
	--{225.91, -1792.15, 3.34,274.38497924805,skin=286,group="FBI"},
	--{2873.84, -1764.5, 10,79,skin=62,group="Department of Defense"},
}

local data = {
	{
		{"Regular Officer","The regular officer has no extra perks or bonuses.","sapd.png",0},--done
		{"Drug Squad","The Drug Squad can find more drugs easily, extra points at DS","k9.png",0},--drug event
		{"Support Unit","Specialized Medics for the law, has some medical equipment","supportunit.png",300},--den medic
		{"Explosives Unit","Specializes in the field of explosives, ++ Damage! Also /lmine usage!","explosives.png",350},--csgwanted
		{"Bomb Squad","Specialized personnel which take less damage from explosives.","bombsquad.png",350},--csgwanted
		{"The Tank","Access to reinforced / tougher law vehicles. Look for license plate 'Re-enfor to identify.","tank.png",380},--csg law skills




	},
	{
		{"Task Force","Task Force units have stronger influence on radio tower locations then normal police.","taskforce.png",400}, --csg new turfing
		{"Range Unit","Specialized in the use of ranged weapons. Extra sniper/country rifle strength.","rangeunit.png",500},--csg wanted

		{"Riot Squad","The final backup. They have the strongest influence, best at regulating the criminals of CSG.",":CSGbillboards2/law.jpg",600}, --csg new turfing


		{"The Mechanic","Has additional materials in his law vehicle. Eg. more pilons, barriers.","mechanic.png",600},--den vehicles and csg veh inv
		{"To be determined","To be determined","chief.png",999999},
		{"High Speed Unit","Access to Law Vehicles with optimized, faster engines and greater efficency.","highspeed.png",600},
	}
}

currPage = 1

function isLaw(p)
	local t = getPlayerTeam(p)
	if t==false then return false end
	local name = getTeamName(getPlayerTeam(p))
	if name == "Police" or name == "Government Agency" or name == "SWAT" or name == "Military Forces" then return true end
	return false
end

addEventHandler("onClientPlayerDamage",localPlayer,function(atker,wep,body,per)
	if getElementData(localPlayer,"isPlayerArrested") then return end
	if isLaw(atker) == true and isLaw(localPlayer) == true then return end
	if (wep >= 35 and wep <= 39) or (wep >= 16 and wep <= 18) then
		local r = getElementData(localPlayer,"skill")
		if r == "Bomb Squad" then
			local giveBack = per*0.25
			local he=getElementHealth(localPlayer)
			setElementHealth(localPlayer,he+giveBack)
			if he+giveBack > 100 then setElementHealth(localPlayer,100) end
		end
	end
	if (wep >= 35 and wep <= 39) or (wep >= 16 and wep <= 18) then
		local r = getElementData(atker,"skill")
		if r == "Explosives Unit" then
			local giveBack = per*0.25*-1
			local he=getElementHealth(localPlayer)
			if he+giveBack <= 100 then triggerServerEvent("CSGlawskills.exploKill",localPlayer,atker,wep,body)  end
		end
	end
end)

function hitMarker(p)
	if p ~= localPlayer then return end
	local px,py,pz = getElementPosition(localPlayer)
	local mx,my,mz = getElementPosition(source)
	if (math.abs(pz-mz) > 2) then
		return -- too high
	end
	if isPedInVehicle(p) == true then
		exports.dendxmsg:createNewDxMessage("Exit your vehicle first before entering the marker",255,0,0)
		return
	else
		if isLaw(p) == false then exports.dendxmsg:createNewDxMessage("This marker is for Law Enforcement only!",255,255,0) return end
		if poses[markers[source]].group ~= nil then
			if getElementData(p,"Group") ~= poses[markers[source]].group then
				exports.dendxmsg:createNewDxMessage("This law skills marker is restricted to "..poses[markers[source]].group.." only",255,255,0)
				return
			end
		end
		exports.dendxmsg:createNewDxMessage("Welcome to CSG's Law Specialties Shop",0,0,200)
		exports.dendxmsg:createNewDxMessage("Click on the picture of the type of officer you want to become!",0,0,200)
		guiSetVisible(window,true)
		showCursor(true)
		updateGUI(currPage)
	end
end

addEventHandler("onClientPlayerWasted",localPlayer,function() guiSetVisible(window,false) showCursor(false) end)

for k,v in pairs(poses) do
	local x,y,z = v[1],v[2],v[3]
	local m = createMarker(x,y,z,"cylinder",2,0,0,0,110)
	addEventHandler("onClientMarkerHit",m,hitMarker)
	local ped = createPed(265,x,y,z+1,v[4])
	if v.skin ~= nil then setElementModel(ped,v.skin) end
	setElementFrozen(ped,true)
	markers[m]=k
	setElementData(ped,"showModelPed",true,true)
end

function updateGUI(pg)
	for k,v in pairs(data[pg]) do
		guiSetText(elements[k][1],v[1])
		local arr = (v[4])/3
		arr=math.floor(arr)
		local score=math.floor(v[4]/4)
		guiSetText(elements[k][2],v[2].."(A: "..arr..". S: "..score..")")
		guiStaticImageLoadImage(elements[k][3],v[3])
		if tonumber(getElementData(localPlayer,"playerScore")) > v[4] then
			guiLabelSetColor(elements[k][1],0,255,255)
		else
			guiLabelSetColor(elements[k][1],255,0,0)
		end
		if getElementData(localPlayer,"skill") == v[1] then
			guiLabelSetColor(elements[k][1],91,250,4)
		end
	end
	if currPage == 1 then guiSetEnabled(btnprevious,false) guiSetEnabled(btnforward,true) end
	if currPage == 2 then guiSetEnabled(btnprevious,true) guiSetEnabled(btnforward,false) end
end

function click()
	for k,v in pairs(elements) do
		if source == v[3] then
			myscore=tonumber(getElementData(localPlayer,"playerScore"))
				updateGUI(currPage)
			local arr = (data[currPage][k][4])/3
			arr=math.floor(arr)
			local score=math.floor(data[currPage][k][4]/4)
			if exports.denstats:getPlayerAccountData(localPlayer,"arrests") < arr then
				exports.dendxmsg:createNewDxMessage("You don't have enough arrests to become a "..data[currPage][k][1]..". You need "..arr.." or more.",0,255,0)
				return
			end
			if myscore >= score then
				triggerServerEvent("CSGlawskills.changed",localPlayer,data[currPage][k][1])
			else
				exports.dendxmsg:createNewDxMessage("You don't have enough score to become a "..data[currPage][k][1]..". You need "..score.." or more.",0,255,0)
				return
			end
		end
	end
	if source == btnexit then

		guiSetVisible(window,false)
		showCursor(false)
	elseif source == btnforward then
		if currPage+1 < 3 then
			currPage=currPage+1
			updateGUI(currPage)
		end
	elseif source == btnprevious then
		if currPage-1 > 0 then
			currPage=currPage-1
			updateGUI(currPage)
		end
	end
end
addEventHandler("onClientGUIClick",root,click)

addEvent("CSGlawskills.updateGUI",true)
addEventHandler("CSGlawskills.updateGUI",localPlayer,function() updateGUI(currPage) end)
