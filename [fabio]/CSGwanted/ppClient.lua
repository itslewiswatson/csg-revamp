
GUIEditor = {
    label = {},
    window = {},
}
window = guiCreateWindow(283, 149, 766, 424, "Community of Social Gaming ~ Criminal Specialties", false)
guiWindowSetSizable(window, false)

lbljob1 = guiCreateLabel(0.02, 0.08, 0.16, 0.05, "Pick Pocket", true, window)
guiLabelSetColor(lbljob1, 255, 0, 0)
imgjob1 = guiCreateStaticImage(162, 31, 216, 104, "regular.png", false, window)
lbljob1desc = guiCreateLabel(11, 58, 141, 76, "Pick Pockets get less money then Con Artists, but are more successfull in criminal life. (25 Score Required)", false, window)
guiLabelSetHorizontalAlign(lbljob1desc, "left", true)
lbljob2 = guiCreateLabel(14, 142, 123, 23, "Con Artist", false, window)
guiLabelSetColor(lbljob2, 255, 0, 0)
lbljob2desc = guiCreateLabel(11, 167, 141, 76, "Con Artist's are not as succesfull as Pick Pocket's, but when they are, its big. (50 Score Required)", false, window)
guiLabelSetHorizontalAlign(lbljob2desc, "left", true)
imgjob2 = guiCreateStaticImage(162, 141, 216, 104, "regular.png", false, window)
lbljob3 = guiCreateLabel(14, 251, 123, 23, "The Regular Criminal", false, window)
guiLabelSetColor(lbljob3, 91, 250, 4)
lbljob3desc = guiCreateLabel(11, 276, 141, 76, "The Regular Criminal is more successfull in criminal activities then civilians.  ", false, window)
guiLabelSetHorizontalAlign(lbljob3desc, "left", true)
imgjob3 = guiCreateStaticImage(162, 251, 216, 104, "regular.png", false, window)
GUIEditor.label[7] = guiCreateLabel(8, 361, 747, 17, ">> See F1 for further information. Click on the image to become that type of criminal. <<", false, window)
guiLabelSetColor(GUIEditor.label[7], 254, 0, 0)
guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", true)
lbljob4 = guiCreateLabel(390, 33, 123, 23, "Don of LV", false, window)
guiLabelSetColor(lbljob4, 255, 0, 0)
imgjob4 = guiCreateStaticImage(540, 31, 216, 104, "regular.png", false, window)
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
imgjob5 = guiCreateStaticImage(540, 141, 216, 104, "regular.png", false, window)
imgjob6 = guiCreateStaticImage(540, 251, 216, 104, "regular.png", false, window)
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

local poses = {
	{1404.34, -1301.84, 12.55,270},
	{1755.55, 775.37, 09.82,113},
	{-2160.15, 649.58, 51.36,305},
	{ 2130.81, 2377.9, 9.82, 176 },
}

local data = {
	{
		{"Petty Criminal","The Regular Criminal is more successfull in criminal activities then civilians.  ","regular.png",0},--done
		{"Pick Pocket","Specialized thiefs. Pickpockets rob less, but are much more successfull.  ","pickpocket.png",0},--done
		{"Con Artist","Specialized thiefs. Conartists are less successfull, but rob much more.  ","conartist.png",0},--done
		{"Burgler","Burglers are thiefs. They are More successfull at store robberies than others. ","burgler.png",75},--done
		{"Car Jacker","(***To be added***)","regular.png",99999},
		{"Drug Smuggler","The Drug Smuggler's are favored at the drug factory. They make drugs faster.","regular.png",75},--done
	},
	{
		{"Smooth Talker ","The Smooth Talker is has a way with words, less trouble with the Law.","smoothtalker.png",125},--done

		{"Hood Rat","(***To be added***)  ","regular.png",99999},
		{"Capo","The Wannabe Don of LV. Not as good as the don, but better then the rest at turfing.  ","capo.png",200},--done
		{"Don of LV","The Don of LV rules's LV's streets. Reputation, faster and better turfing.  ","donoflv.png",250},--done
		{"Butcher ","Stealth Kill + used to working with knifes, etc. Strong and Extra melee damage.","butcher.png",800},--done
		{"Assassin","The master of killing. Extra damage with sniper and country rifle. ","assassin.png",1500},--done
	}
}

currPage = 1
function hitMarker(p)
	if p ~= localPlayer then return end
	if isPedInVehicle(p) == true then
		exports.dendxmsg:createNewDxMessage("Exit your vehicle first before entering the marker",255,0,0)
		return
	else
		if getTeamName(getPlayerTeam(localPlayer)) ~= "Criminals" then exports.dendxmsg:createNewDxMessage("This marker is for criminals only!",255,255,0) return end
		exports.dendxmsg:createNewDxMessage("Welcome to CSG's Criminal Specialties Shop",0,255,0)
		exports.dendxmsg:createNewDxMessage("Click on the picture of the type of criminal you want to become!",0,255,0)
		guiSetVisible(window,true)
		showCursor(true)
		updateGUI(currPage)
	end
end

addEventHandler("onClientPlayerWasted",localPlayer,function() guiSetVisible(window,false) showCursor(false) end)

for k,v in pairs(poses) do
	local x,y,z = v[1],v[2],v[3]
	local m = createMarker(x,y,z,"cylinder",2,255,0,0,110)
	addEventHandler("onClientMarkerHit",m,hitMarker)
	local ped = createPed(223,x,y,z+1,v[4])
	setElementFrozen(ped,true)
	setElementData(ped,"showModelPed",true,true)
end

function updateGUI(pg)
	for k,v in pairs(data[pg]) do
		guiSetText(elements[k][1],v[1])
		guiSetText(elements[k][2],v[2].."("..v[4].." Score Required)")
		guiStaticImageLoadImage(elements[k][3],v[3])
		if tonumber(getElementData(localPlayer,"playerScore")) > v[4] then
			guiLabelSetColor(elements[k][1],0,255,255)
		else
			guiLabelSetColor(elements[k][1],255,0,0)
		end
		if getElementData(localPlayer,"Rank") == v[1] then
			guiLabelSetColor(elements[k][1],91,250,4)
		end
	end
	if currPage == 1 then guiSetEnabled(btnprevious,false) guiSetEnabled(btnforward,true) end
	if currPage == 2 then guiSetEnabled(btnprevious,true) guiSetEnabled(btnforward,false) end
end

function click()

	for k,v in pairs(elements) do
		if source == v[3] then
			updateGUI(currPage)
			myscore=tonumber(getElementData(localPlayer,"playerScore"))
			if myscore >= data[currPage][k][4] then
				triggerServerEvent("CSGcriminalskills.changed",localPlayer,data[currPage][k][1])
			else
				exports.dendxmsg:createNewDxMessage("You don't have enough score to become a "..data[currPage][k][1]..". You need "..data[currPage][k][4].." or more.",0,255,0)
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

addEvent("CSGcriminalskills.updateGUI",true)
addEventHandler("CSGcriminalskills.updateGUI",localPlayer,function() updateGUI(currPage) end)
