GUIEditor_Label = {}

window = guiCreateWindow(0.268,0.263,0.4578,0.3854,"~ Welcome to Community of Social Gaming ~",true)
guiWindowSetSizable(window,false)
theGrid = guiCreateGridList(0.0188,0.2736,0.9625,0.5946,true,window)
guiGridListSetSelectionMode(theGrid,2)

guiGridListAddColumn(theGrid,"Entry",0.75)

--guiGridListAddColumn(theGrid,"Date",0.2)

guiGridListAddColumn(theGrid,"Developer",0.2)

for i = 1, 1 do
    guiGridListAddRow(theGrid)
end
GUIEditor_Label[1] = guiCreateLabel(0.3891,0.0912,0.1195,0.0574,"CSG Version: ",true,window)
guiLabelSetColor(GUIEditor_Label[1],255,165,0)
lblVersion = guiCreateLabel(0.5119,0.0912,0.2048,0.0574,"V 1.0.3",true,window)
guiLabelSetColor(lblVersion,255,255,0)
btnClose = guiCreateButton(0.0188,0.8851,0.9608,0.0845,"Close",true,window)
lblMessage = guiCreateLabel(0.0222,0.1588,0.9573,0.1081,""..getPlayerName(localPlayer)..", since your last visit (November 27th, 2012 at 5:03 pm), CSG was updated. Please see below for the latest changes. The green indicates changes you might not be aware of.",true,window)
guiLabelSetColor(lblMessage,255,250,255)
guiLabelSetHorizontalAlign(lblMessage,"left",true)
guiSetVisible(window,false)
guiGridListSetSelectionMode(theGrid,1)

somethingNew = false
function show()
	guiSetVisible(window,true)
	if somethingNew == true then
		guiSetEnabled(btnClose,false)
		enableTime = 6
		guiSetText(btnClose,"Close("..enableTime..")")
		setTimer(function() enableTime=enableTime-1 guiSetText(btnClose,"Close("..enableTime..")") if enableTime == 0 then guiSetEnabled(btnClose,true) guiSetText(btnClose,"Close") somethingNew = false end end,1000,6)
	end
	showCursor(true)
end

function check()
	if tonumber(myVersion) ~= theLatestVersion then
		xmlNodeSetValue(xmlFindChild(xmlHudBranch,"myVersion",0),tostring(theLatestVersion))
		xmlSaveFile(xmlRootTree)
		show()
	end
end
addEvent("CSGupdates.loggedIn",true)
addEventHandler("CSGupdates.loggedIn",localPlayer,check)

function hide()
	guiSetVisible(window,false)
	showCursor(false)
end


addCommandHandler("updates",show)

function click()
	if source == btnClose then
		hide()
	end
end
addEventHandler("onClientGUIClick",root,click)

function rec(theTable,myVersion,latestVersion,lastVisit)
	guiSetText(lblMessage,""..getPlayerName(localPlayer)..", you were last on CSG, "..lastVisit..". Please see below for the latest changes. The green indicates changes you might not be aware of.",true,window)
	for cat,v in pairs(theTable) do
		local catRow = guiGridListAddRow( theGrid )
		guiGridListSetItemText( theGrid, catRow, 1, ""..v[2].." ("..v[3]..")", true, false )
		if myVersion < v[1] then
			somethingNew = true
			guiGridListSetItemColor(theGrid,catRow,1,0,255,0)
		end
		if v[1] == latestVersion then
			guiSetText(lblVersion,v[2])
		end
		for k,data in pairs(v[4]) do
			local desc = data[1]
			local dev = data[2]
			local theRow = guiGridListAddRow( theGrid )
			guiGridListSetItemText( theGrid, theRow, 1, desc, false, false)
			guiGridListSetItemText( theGrid, theRow, 2, dev, false, false)
			if myVersion < v[1] then
				guiGridListSetItemColor(theGrid,theRow,1,0,255,0)
				guiGridListSetItemColor(theGrid,theRow,2,0,255,0)
			end
		end
	end
end

local months = {
	"January","February","March","April","May","June","July","August","September","October","November","December"
}

function getFormattedDate(stamp)
	local month = ""
	local year = ""
	local day = ""
	stamp=tostring(stamp)
	for i = 1, #stamp do
		local c = stamp:sub(i,i)
		if i > 0 and i < 5 then
			year = year..""..c..""
		end
		if i == 5 or i == 6 then
			month=month..""..c..""
		end
		if i > 6 then
			day=day..""..c..""
		end
	end
	local mName=months[tonumber(month)]
	local formatted = mName.." "..day..", "..year..""
	return formatted
end

function ClientResourceStart ()
	if source ~= getResourceRootElement() then return end --This event will happen with any resource start, isolate it to this resource
	xmlStart()
end
addEventHandler ( "onClientResourceStart", root, ClientResourceStart )

function xmlStart()
	xmlRootTree = xmlLoadFile ( "userSettings.xml" ) --Attempt to load the xml file
	if xmlRootTree then -- If the xml loaded then...
		xmlHudBranch = xmlFindChild(xmlRootTree,"data",0) -- Find the hud sub-node
	else -- If the xml does not exist then...
		xmlRootTree = xmlCreateFile ( "userSettings.xml", "root" ) -- Create the xml file
		xmlHudBranch = xmlCreateChild ( xmlRootTree, "data" ) -- Create the hud sub-node under the root node
		xmlNodeSetValue (xmlCreateChild ( xmlHudBranch, "myVersion"), "60" ) --Create sub-node values under the hud sub-node
		xmlNodeSetValue (xmlCreateChild ( xmlHudBranch, "lastDate"), "Never" )
		xmlNodeSetValue (xmlCreateChild ( xmlHudBranch, "lastTime"), "Never" )
		xmlSaveFile ( xmlRootTree )
		xmlStart()
		return
	end

	myVersion = tonumber(xmlNodeGetValue (xmlFindChild(xmlHudBranch,"myVersion",0)))
	local myDate = xmlNodeGetValue (xmlFindChild(xmlHudBranch,"lastDate",0))
	local myTime = xmlNodeGetValue (xmlFindChild(xmlHudBranch,"lastTime",0))
	theMainData = {
		{210,"v.1.5.8","February 16th, 2013",
			{
				{"> [Feature] /lights to toggle lights, /od and /cd to close vehicle doors","Frost"},
				{"		/od DOOR# (1-6) /cd DOOR# (1-6)",""},
				{"> [Bug-Fix] Bike skills fixed","[CSG]Priyen"},
				{"> [Bug-Fix] Medic can now heal people even when using ecstasy","[CSG]Priyen"},
				{"> [Bug-Fix] You can't accept a bribe from someone who is jailed","[CSG]Priyen"},
			}
		},
		{209,"v.1.5.7","February 15th, 2013",
			{
				{"> [Bug-Fix] Bug-Fix, knife doesn't work on spawn protected people",""},
				{"> [Change] Butcher can now stealth kill",""},
				{"> [Change] Butcher score requirement -> 800",""},
				{"> [Change] Assassin can no longer stealth kill",""},
				{"> [Change] Assassin's effect only works on headshots",""},
				{"> [Change] Assassin score requirement -> 1500",""},
				{"> [Bug-Fix] Abusable drugs in houses fixed","[CSG]Jack"},
				{"> [Bug-Fix] Refueling is Free fixed","[CSG]Priyen"},
				{"> [Bug-Fix] Dropping full weapon ammo fixed","[CSG]Priyen"},
				{"> [Bug-Fix] Sell other player's house fixed","[CSG]Priyen"},

			}
		},
		{207,"v.1.5.6","February 13th, 2013",
			{
				{"> [Bug-Fix] Abusable infinite wanted level fixed","[CSG]Priyen"},
				{"> [Bug-Fix] You can't rob yourself now","[CSG]Priyen"},
				{"> [Notif.] Monster Build status 44%","Dev. Team"},
				{"> [Bug-Fix] Forum's online players count page fixed","[CSG]Jack"},
				{"> [Bug-Fix] Chat Spam via group deposit fixed","[CSG]Jack"},
				{"> [Bug-Fix] A bug-fix to Bike skills, but needs to be tested more","[CSG]Jack"},
			}
		},
		{204,"v.1.5.4","February 11th, 2013",
			{
				{"> [Feature] Phone Music app now allows upto 10 minutes youtube links",""},
				{"> [Feature] All DX messages now output to console too (Press ~ to see)",""},
				{"> [Change] Lotto changed to #'s 1-30",""},
				{"> [Bug-Fix] One of the scripts that caused FPS loss fixed",""},
				{"> [Bug-Fix] Radio in Phone fixed!",""},
				{"> [Bug-Fix] Respawn @ Hospital, bug fix (you wont get stuck new)",""},
			}
		},
		{202,"v.1.5.3","February 9th, 2013",
			{
				{"> [Feature] House rob enabled and score added to it",""},
				{"> [Feature] Added setting to toggle support chat in phone","[CSG]Priyen"},
				{"     We do not encourage this, but sometimes there is too much",""},
				{"     going on in support chat",""},
				{"> [Feature] MF now get alerated when there is hostile aircraft presence","[CSG]Smith"},
				{"> [Feature] CRIMS: Precious car needs to be stolen! Deliver it for $$$","Prime"},
				{"> [Feature] LAWS: Stolen car needs to be recovered! Recover it for $$$",""},
				{"> [Feature] Added ' See Killcam ' to settings app in Phone","[CSG]Priyen"},
				{"> [Feature] Added ADS to LV Hospital Spawn -- ingame content",""},
				{"> [Bug-Fix] Houses system bug where you can SELL someone else's house","[CSG]Priyen"},
				{"> [Bug-Fix] Houses system bug where you can bug sell for a lot of $$$",""},
				{"> (Any housing transactions from the bug have already been reveresed)",""},
				{"> [Bug-Fix] Jetpack in DS issue",""},
			}
		},
		{199,"v.1.5.2","February 6th, 2013",
			{
				{"> [Bug-Fix] You can't rob dead people now",""},
			}
		},
		{198,"v.1.5.1","February 5th, 2013",
			{
				{"> [Feature] Kill Cam Added! Soon to come a setting for it in phone","[CSG]Priyen"},
				{"> [Feature] Added back weapons! Feel like the master of weapons","[CSG]Priyen"},
				{"     Phone > Back Weapon App > Pick your weapons",""},
				{"     	Primary shows when the weapon is not in use, otherwise secondary",""},
				{"     	Not all skins are calibrated / positioned correctly, but",""},
				{"     	this will be fixed over a few days",""},
			}
		},
		{196,"v.1.5.0","February 3rd, 2013",
			{
				{"> [Feature] Hospital health / medical assistance pickups","Prime"},
				{"> [Bug-Fix] You can no longer fix your vehicle while doing driving test","[CSG]Priyen"},
				{"> [Feature] More Job Locations for Maps App in Phone","[CSG]Priyen"},
				{"> 	Thank You to [CSG]Tzeik for all the positions / data",""},
				{"> [Bug-Fix] You won't get wanted in event dimensions","[CSG]Priyen"},
				{"> [Bug-Fix] Bank Rob / CR related bugs (door, timer, death) fixed","[CSG]Priyen"},
				{"> [Feature] Fisherman > Sell All button","[CSG]Priyen"},
				{"> [Feature] You get 5 times LESS wanted points in LV","[CSG]Priyen"},
				{"  Law Salary for arresting also increased to offset / balance",""},
				{"> [Feature] New Tazer, one you can actually escape from!","[CSG]Priyen"},
				{"> [Feature] Wanted System toughned in LV for trollers.","[CSG]Priyen"},
				{"  Law attacking criminals in LV in attempt to get them to get wanted",""},
				{"  Will notice the difference",""},
				{"> [Notif.] Monster Build Status: 25% ","[CSG]Jack"},
				{"> 	Mainly Jack so far working on it",""},
				{"> [Feature] Music App in Phone!","[CSG]Priyen"},
				{">    Ever wanted to play music but was enable to?",""},
				{">    Always had to go convert it and upload, .mp3 etc?",""},
				{">    CSG's latest edition brings you the ability to",""},
				{">   		*Play Youtube Links! (YES, no work on your part)",""},
				{">   		 eg. http://www.youtube.com/watch?v=Q6IoKnPERrQ",""},
				{">   		 It will even get the title for you!",""},
				{">   		*All other standard MTA file types",""},
				{">   		*Play music in a vehicle, if your the driver",""},
				{">   		*Vehicle music HUD + Sync",""},
				{">   		* Eg. when someone enters your vehicle, they hear",""},
				{">   		  the song from where it really is, not the beginning",""},
			}
		},
		{189,"v.1.4.9","February 1st, 2013",
			{
				{"> [Feature] All animations now have commands, type /animation name","[CSG]Priyen"},
				{">     /stopanim to stop doing an animation.",""}
			}
		},
		{188,"v.1.4.8","January 31st, 2013",
			{
				{"> [Feature] Premium custom hats feature!","Prime"},
				{">     Many cool hats for you to wear!",""},
				{">     /premhat to wear a hat and remove it",""},
			}
		},
		{187,"v.1.4.7","January 30th, 2013",
			{
				{"> [Bug-Fix] Wanted jacking bug in seasparrow fixed","[CSG]Priyen"},
				{"> [Bug-Fix] On reconnect Assassin skill loss fixed","[CSG]Priyen"},
				{"> [Bug-Fix] Weapons skills fixed for all players","[CSG]Priyen"},
				{">     If your fps was over 70, your skills were bugged, now fixed",""},
				{"> [Bug-Fix] Abusable tazer animation bug fixed","[CSG]Priyen"},
				{"> [Feature] Law Computer now has team based color coding","[CSG]Priyen"},
				{">     for all players that are blipped / marked",""},
				{"> [Feature] Law Computer now shows if a wanted player is in jail","[CSG]Priyen"},
				{"> [Feature] Added /togglepchat to enabled and disable premium chat","[CSG]Priyen"},
				{"> [Bug-Fix] Law Computer blip related problems fixed","[CSG]Priyen"},
				{"> [Bug-Fix] When you get 3 stars, you turn criminal + get your skin back","[CSG]Priyen"},
				{"> [Feature] Drug Commands (bindable)",""},
				{">     /takehit name amount",""},
				{">     Amount is automatically 1 if not specified",""},

			}
		},
		{184,"v.1.4.6","January 28th, 2013",
			{
				{"> [Feature] Math Task!","[CSG]Smith"},
				{">     Can you do the math?",""},
				{"> [Feature] Bike Skills!","[CSG]Smith"},
				{">     Upgrade your bike skills as you gain experience",""},
			}
		},
		{183,"v.1.4.5","January 26th, 2013",
			{
				{"> [Feature] Food / Restaurant drive thru's!","Brad"},
				{"> [Bug-Fix] Help messages at top accelertad when there is a lot showing","[CSG]Priyen"},
				{">     (Anti-help spam + Bus driver spam fix)",""},
				{"> [Feature] Drug timers added!","[CSG]Priyen"},
				{">     Phone > Settings > 'See drug timers' to toggle",""},
				{"> [Feature] Drug system changed a little, hits stackable","[CSG]Priyen"},
				{">     (But not infintely)",""},
				{"> [Feature] You now get 0.5 score for killing someone","[CSG]Priyen"},
				{">     (But they still lose 1)",""},
				{"> [Bug-Fix] Mechanic damage proof bug fixed","[CSG]Priyen"},
				{"> [Bug-Fix] Law arresting bug fixed (some law couldn't arrest)","[CSG]Priyen"},
				{"> [Bug-Fix] Drug Shipment jetpack bug fixed","[CSG]Priyen"},
				{"> [Bug-Fix] You can now recover vehicles in water regardless of distance","[CSG]Priyen"},
				{"> [Bug-Fix] Ferrari's Handling fixed and optimized by Kirito",""},
			}
		},
		{179,"v.1.4.4","January 25th, 2013",
			{
				{"> [Feature] Pilot Job now gives score!","[CSG]Priyen"},
				{"> [Feature] Added command /drugs for those with bind problems","[CSG]Priyen"},
				{"> [Change] Score requirements for LAW Skills are now half!","[CSG]Priyen"},
				{"> [Bug-Fix] Pilot Job ranks fixed","[CSG]Priyen"},
				{"> [Bug-Fix] Blank ranks in Tab / Scoreboard","[CSG]Priyen"},
				{"> [Bug-Fix] You couldn't re-enter vehicles with wanted star","[CSG]Priyen"},
				--{"> [Bug-Fix] You no longer get wanted for damaging your own car","[CSG]Priyen"},
				{"> [Bug-Fix] All PD's now have the law skills markers","[CSG]Priyen"},
				{"> [Bug-Fix] Added criminal markers job descriptions","[CSG]Priyen"},
			}
		},
		{178,"v.1.4.3","January 23rd, 2013",
			{
				{"> [Feature] New Tazer Effect","[CSG]Priyen"},
				{"> [Bug-Fix] You can no longer turf in air vehicles","[CSG]Priyen"},
				{"> [Bug-Fix] You no longer get wanted for damaging your own car","[CSG]Priyen"},
				{">     (Both Job and Owned Vehicles)",""},
				{">     Unless the damage causes someone to die..",""},
				{"> [Feature] You no longer lose score for deaths IF,","[CSG]Priyen"},
				{">     You died in the main interior but a different dimension",""},
				{">     You were killed by a staff member",""},
				{"> [Feature] Old tazer added back, new removed.","[CSG]Priyen"},
				{"> [Feature] New Ferrari Model","[CSG]Priyen"},
				{">     Handling will be fixed soon",""},
				{"> [Bug-Fix] House Weapon's Storage enabled again","[CSG]Priyen"},
			}
		},
		{176,"v.1.4.2","January 21st, 2013",
			{
				{"> [Bug-Fix] Anti-weapon training abuse, made by Sathler",""},
				{"> [Bug-Fix] Sometimes criminal ranks don't show in tab fixed","[CSG]Priyen"},
				{"> [Feature] A new tazer! (new animations for gun and being tazerd)","[CSG]Priyen"},
				{"> [Feature] All players are now visible by default","[CSG]Priyen"},
				{">     Uncheck Phone > settings > 'See all players' for old system",""},

				{"> [Feature] Ferrari added to vehicle shops","[CSG]Sensei"},
				{">           $2 Million, Max Speed 341 Km/h",""},


				{"> [Bug-Fix] Cops getting wanted for jacking a criminal fixed","[CSG]Priyen"},
				{"> [Bug-Fix] 'Casino markers on roof bug fixed'","[CSG]Priyen"},
				{"> House Weapons Storage disabled for 24 hours!",""},
				{">           Don't worry, you will NOT lose anything inside.",""},
				{"> [Bug-Fix] 'Your wanted level is too high bug'","[CSG]Priyen"},
				{"> [Bug-Fix] Group banking transactions log fixed","[CSG]Priyen"},
				{"> [Bug-Fix] You can't deposit $0 or less in group bank","[CSG]Priyen"},
			}
		},
		{172,"v.1.4.1","January 19th, 2013",
			{
			{"> [Change]  New payments and score tables for some jobs","HBK"},
			{">           In attempt to balance job salaries + score",""},
			{">           Paramedic, Electrician, and Trash Collector",""},
			--{"> [Change]  Weapons Training now gives 10% instead of 5%",""},
			{"> [Bug-Fix] House System (ALL STORAGES FIXED)","[CSG]Priyen"},
			{"> [Bug-Fix] You can't pickup flag now while arrested","[CSG]Priyen"},
			{"> [Feature] Barriers, Rewrited, added Dx Message on Spawn,","[CSG]Smith"},
			{"            added /flare, removed barrier4 as it same #1",""},
			{"> [Feature] Portguese translation (full) for F1 added!","[CSG]Priyen"},
			{"           > Full Translation provided by (Sathler)! (All Tabs)",""},
			{"> [Feature] First Person view Mode added","[CSG]Priyen"},
			{"           > Press 'V' to toggle your view modes!",""},
			{"           > Works in vehicles and onfoot",""},
			{"> [Feature] You now get score for training your weapons!","[CSG]Smith"},
			{"> [Feature] You can now spawn free-vehicles with upto 1 wanted star","[CSG]Priyen"},
			{"> [Bug-Fix] Abusable score bugged fixed in store robberies","[CSG]Priyen"},
			{"           > Now the score given is based on how much you rob",""},
			{"> [Bug-Fix] Buying food will actually now increase your HP past 100","[CSG]Priyen"},
			{"           > (If your on drugs)",""},
			{"> [Bug-Fix] You now can't get pickups when using jetpack","[CSG]Priyen"},
			{"> [Bug-Fix] Turf Respawn glitches fixed","[CSG]Priyen"},
			{"> [Bug-Fix] Emergency Signal Lights disabled for non-Emergency vehicles","[CSG]Priyen"},
			{"> [Bug-Fix] Most Bad Interiors Fixed (eg. Water in interior)","[CSG]Priyen"},
			{"> [Change] Vehicle Recovery distance increased","[CSG]Priyen"},

			}
		},
		{162,"v.1.4.0","January 16th, 2013",
			{
				{"> [Feature] Bank Rob has been added back!",""},
				{"           > /banktime /casinotime",""},
				{"> [Bug-Fix] You no longer respawn in the sea when you die near jail",""},
				{"> [Feature] PT/BR Chat Added to the chat system!",""},
				{"           > /pt msg, /br msg, OR 'J' chat room",""},
				{"> [Notif.] Jail Preview Topic on FORUM has been updated",""},
			}
		},
		{161,"v.1.3.9","January 15th, 2013",
			{
				{"> [Bug-Fix] Casino Robbery Door will now, automatically open.","[CSG]Priyen"},
				{"> [Bug-Fix] You can no longer recover a car while arrested or jailed",""},
				{"> [Bug-Fix] You can no longer recover a car while your driving it..",""},
				{"> [Bug-Fix] Jail Timer Bug, since  we don't know how to reproduce,",""},
				{"           > Please tell an admin if you still get the bug",""},
				{"> [Change] You can now only get pickups (eg. armor) once per 60 seconds",""},
				{"> [Bug-Fix] A problem with gates opening and closing",""},
			}
		},
		{158,"v.1.3.8","January 13th, 2013",
			{
				{"> [Feature] Job Descriptions for MOST Jobs) ","HBK"},
				{"> [Preview] CSG's New Federal Prison is nearly open to new convicts.) ","[CSG]Priyen"},
			}
		},
		{157,"v.1.3.7","January 11th, 2013",
			{
				{"> [Change] Explosives and Jetpack disabled in Drug Shipment Area","[CSG]Bibou"},
				{"> [Notif.] Anti-Lag Measures Added to current scripts. ","[CSG]Priyen"},
				{"           > Packet Loss decreased nearly 10 times.",""},
				{"           > You should no longer get 'random' network troubles.",""},
				{"           > If you still lag, consider your internet connection first",""},
				{"           > The chance of server causing your lag is now near impossible.",""},
			}
		},
		{155,"v.1.3.6","January 10th, 2013",
			{
				{"> [Feature] Law Skills Added!) ","[CSG]Priyen"},
				{"           > Regular Officer, Drug Squad, Support Unit",""},
				{"           > Explosives Unit, Bomb Squad, The Tank",""},
				{"           > Task Force, Range Unit, Riot Squad, the Mechanic",""},
				{"           > High Speed Unit (not enabled)",""},
				{" Please report bugs, if any to the appropriate section on csgmta.net",""},
				{"> [Change] Fire Fighter fire no longer damages you or your vehicle.",""},
			}
		},
		{154,"v.1.3.5","January 9th, 2012",
			{
				{"> [Update/Notif.] 10 / 12 of the Law Skills are completed.",""},
				{"  ALL beind added in-game on January 10th, 2012",""},
				{"> 1 day delay due to new skill > 'Mechanic'",""},
				{"> [Feature] Additional SWAT Team skin added (now total becomes 2 skins) ",""},
				{"> [Feature] New Premium Skin 'The Rabbit' has been added to the clothes shop.",""},
				{"           > Made by our very own member, Rabbit",""},
				{"> [Feature] Skin 299, Claude, has been updated to GTA3 style",""},
				{"           > Thank You to Thomas for the neccesary stuff",""},
			}
		},
		{153,"v.1.3.4","January 8th, 2013",
			{
				{"> [Feature] Updated, better looking SWAT,MF,FBI car logo's","[CSG]Sensei"},
				{"> [Feature] Car Inventory (for LAW only). Normal cop cars spawn with","[CSG]Priyen"},
				{"  pilon,barriers,stinger,etc, depending on if your normal or official law",""},
			}
		},
		{152,"v.1.3.3","January 6th, 2013",
			{
				{"> [Update/Notif.] Law Skills (similiar to Criminal Skills) Officially being",""},
				{"  added ON or BEFORE January 9th 2012",""},
				{"> [Update/Notif.] New /store design coming soon",""},
				{"> [Change] Your jail time is now HALF, if most of your crimes were in LV",""},
				{"> [Bug-Fix] Turf respawn falling underground fixed","[CSG]Priyen"},
				{"> [Bug-Fix] Occassion bad camera spawn positioning fixed","[CSG]Priyen"},
				{"> [Feature] Credits Update (V3)","[CSG]Jack"},
				{"           > Stability fixes",""},
				{"           > New support for external purchases",""},
				{"> [Bug-Fix] Some false walls fixes added","Sathler"},
				{"> [Bug-Fix] Recover related bugs for vehicle system fixed","[CSG]Priyen"},
			}
		},
		{151,"v.1.3.2","January 5th, 2013",
			{
				{"> [Feature] Street Cleaner Job Added (SCORE enabled Job)","[CSG]Priyen"},
				{"> [Feature] Waste Collector Job + Score with it added","[CSG]Jack+Priyen"},
			}
		},
		{149,"v.1.3.1","January 4th, 2013",
			{

				{"> [Feature] commands /set(swat/mf/fbi)job and /rev(swat/mf/fbi)job Done.","[CSG]Smith"},
				{"           > Updated and fixed",""},
				{"> [Change] Store no longer on cache load, direct load from DB","[CSG]Jack"},
				{" 	         > Credits no longer on a cache load, direct load from DB",""},
				{"> [Feature] Updated Phone, Settings and Job calls","[CSG]FabioGNR"},
				{"> [Feature] Drugs Selling Added, use /selldrugs","[CSG]Priyen"},
				{"> [Feature] Realistic Clouds","[CSG]Jack"},
			}
		},
		{148,"v.1.3.0","January 2nd, 2013",
			{
				{"> [Feature] New Vehicle Shops!","[CSG]FabioGNR"},
				{"           > Choose license plates",""},
				{"           > Test drive before you buy!",""},
				{"> [Feature] New vehicle system with additional features","[CSG]Priyen"},
				{"> [Feature] Credits System added (V2)","[CSG]Jack"},
				{"           > Store system now in a stable state to release ",""},
				{"           > Management system finished ",""},
				{"           > Store management system (50% done) ",""},
				{"> [Bug-Fix] Jail related bugs fixed","[CSG]Priyen"},
				{"> [Bug-Fix] Score related bugs fixed","[CSG]Priyen"},
				{"> [Feature] New vehicle HUD","[CSG]Fabio"},
				{"           > New speedometer, health bar, gps!",""},
				{"> [Feature] Choose where you want to continue your life..respawn","[CSG]Priyen"},
				{"           > Criminals - Hospital or Turf (forced turf if wanted)",""},
				{"           > Law Groups - Hospital or Base ",""},
				{"           > Civilians / anyone else - Hospital ",""},
				{"> [Bug-Fix] Fixed a bug with the patrol mission markers","[CSG]Priyen"},
				{"> [Bug-Fix] Turfing number rounding","[CSG]Priyen"},
				{"> [Bug-Fix] Turfing interior / dimension bug","[CSG]Priyen"},
			--	{"> [Change] Added SWAT Job description",""},
			}
		},
		{144,"v.1.2.9","December 31st, 2012",
			{
				{"> [Feature] You can now transfer money to other's bank accounts via ATM's","[CSG]Jack+Priyen"},
				{"> [Feature]  /setmfjob , /setswatjob and /setfbijob added for leaders of current team","[CSG]Smith"},
				{"> [Bug-Fix] Weapon LOSS - PERMENANTLY FIXED.","[CSG]Priyen"},
				{"> [Feature] *Unread Messages for Phone* ","[CSG]Fabio"},
				{"           > See messages you haven't seen!",""},
				{"> [Feature] Calculator app for Phone* ","[CSG]Fabio"},
				{"           > Those times when you need to calculate...",""},
				{"> [Bug-Fix] All house-permission related problems fixed!","[CSG]Priyen"},
				{"           > Specifically those with ENTER House issues, this is now fixed!",""},
				{"> [Feature] New better respawn system","[CSG]Priyen"},
				{"           > See an ambulance take you to the hospital!",""},
				{"           > Spawn to the hospital thats actually near you!",""},
				{"           > Eg. In a LS interior in LV? no problem! Youll be taken to",""},
				{"           > LV General Hospital, not LS!",""},
				{"> [Temporary Change] Don of LV and Capo are now enabled again!","[CSG]Priyen"},

			}
		},
		{142,"v.1.2.8","December 30th, 2012",
			{
				{"> [Bug-Fix] Weapon Skills - PERMENANTLY FIXED.","[CSG]Priyen"},
				{"> [Temporary Change] Don of LV and Capo still disabled for 12 more hours","[CSG]Priyen"},
				{"> [Bug-Fix] Multiple people can now train their weapons at the same time","[CSG]Priyen"},
				{"> [Feature] New Turfing System! [Law Turfing]","[CSG]Priyen"},
				{"           > 4 Law-enabled Turfs, each has a radio tower",""},
				{"> When law owns a radio tower turf, you WILL get wanted",""},
				{"	for crimes in that zone.",""},
				{"> When criminals owns a radio tower turf, you will NOT ",""},
				{"	get wanted for crimes in that zone..",""},
				{"> When radio tower turf is neutral, 50% chance of getting wanted",""},
				{"  in that zone."},
				{"> Zone based on nearest radio tower to you in LV",""},
				{"> Criminals,staff,Law see radar blips at all times",""},
				{"> Others, only in LV",""},
			}
		},
		{140,"v.1.2.7","December 29th, 2012",
			{
				{"> [Temporary Change] Don of LV and Capo disabled for 24 hours","[CSG]Priyen"},
				{"         			  > Mainly to adjust for the new turfing system.",""},
				{"> [Feature] New Turfing System!","[CSG]Priyen"},
				{"           > Group Influence",""},
				{"           > The more members of your group in a turf, the faster you can take it.",""},
				{"           > You can now 'defend' with reason, get paid in money and score",""},
				{"           > Law Enforcement Turfs [4] -- Each @ Radio Stations",""},
				{"         			  > LAW TURFING being Added prior to, OR ON December 30th 2012",""},
				{" * Report ALL BUGS, if any, of the new turfing system on the forum!",""},
				{" If abusable / major, report only to admins via sms or private message",""},
			}
		},
		{139,"v.1.2.6","December 28th, 2012",
			{
				{"> [Feature] Police Cars for SWAT,MF,FBI have their logos on them!","[CSG]Priyen"},
				{"           > Thank You to Arkeo and Gusolina for help",""},
				{"> [Feature] Pilot job Tug Spawners added!","[CSG]Priyen"},
				{"> [Bug-Fix] You can no longer warp to an event while jailed","[CSG]Bibou"},
				{"> [Bug-Fix] Added staircase to get in / out of the north east LV Turf","[CSG]Priyen"},

			},
		},
		{137,"v.1.2.5","December 26th, 2012",
			{
				{"> [Bug-Fix] Laser is no longer infinite!","[CSG]Priyen"},
				{"           > When Laser battery is done, it will not work anymore",""},
				{"           > Color will now stay! It will not reset to red if you reconnect.",""},
				{"> [Feature] Houses App! N > Phone > Houses to see your houses!","[CSG]Priyen"},
				{"> [Feature] Police Emergency Head Lights!",""},
				{"> [Feature] Barriers added for SWAT (same as MF)","[CSG]Smith"},
				{"> [Feature] Bribe for FBI","[CSG]Priyen"},
				{"> [Bug-Fix] Casino Rob's door fixed! + the money rates for it too","[CSG]Priyen"},
				{"> [Bug-Fix] Your now auto-released when a cop accepts your bribe","[CSG]Priyen"},
			}
		},
		{134,"v.1.2.4","December 24th, 2012",
			{
				{"> [Feature] Official Law Chat added! use /smf msg ","[CSG]Bibou"},
			}
		},
		{133,"v.1.2.3","December 23rd, 2012",
			{
				{"> [Feature] Lottery changed to 1-50 instead of 1-100",""},
				{"           > Changed it's advert to dx Messages",""},
				{"> [Feature] Added barriers and lift for MF!","[CSG]Smith"},
				{"           > /barrier1-4",""},
				{"           > Example, /barrier1 ",""},
				{"           > /destroyall",""},
				{"> [Feature] Gas Masks for MF and SWAT added!","[CSG]Smith"},
				{"> [Bug-Fix] Staff can't be stealth killed now!","[CSG]Smith"},
				{"> [Feature] Fixed Event Panel + new one","[CSG]Bibou"},
				{"> [Feature] Drug Shipment added, use /drugtime","[CSG]Priyen"},
				{"> [Feature] New Dx Messages!","[CSG]Priyen"},
				{"> [Feature] ATM System Updated","[CSG]Jack"},
				{"           > New GUI Layout",""},
				{"> [Feature] Max Robbery Limits Changed;","[CSG]Priyen"},
				{"    > Max 60k --There is banks..storages for a reason.",""},
				{"    > You can no longer ROB anyone in Casino Rob",""},
				{"    > Post in Server Development concerns or opinions",""},
				{"> [Feature] Assassin Criminal Skill disabled in CR;","[CSG]Priyen"},
				{"           > Will be disabled in Drug Shipment",""},
			}
		},
		{126,"v.1.2.2","December 21st, 2012",
			{
			{"> [Feature] Event Panel / Events fixed! (admins can do events now!)","[CSG]Priyen"},
			{"> [Feature] Sell your house to the bank for 75% of its market value!","[CSG]Priyen"},
			{"> [Feature] New Turfs for LV","[CSG]Priyen"},
			{"           > 2 @ Bottom Left LV",""},
			{"           > 1 @ Top Right LV",""},
			{"           > 1 @ Top Left LV",""},
			}
		},
		{123,"v.1.2.1","December 19th, 2012",
			{
			{"> [Feature] Casino Robbery now 1 hour and 10 minutes only!","[CSG]Priyen"},
			{"           > 4k for killing criminal + score!",""},
			{"           > 2k for killing law + score!",""},
			{"           > 18k for successfull rob + score!",""},
			{"> [Bug-Fix] Assassin and Butcher skills fixed","[CSG]Priyen"},
			{"> [Bug-Fix] You can no longer /kill in jail","[CSG]Priyen"},
			}
		},
		{122,"V 1.2.0","December 15th, 2012",
			{
			{"*** Anything showing ==> 'December 16th, 2012' will be added tomorrow",""},
			{"*** Final testing",""},
			{"> [Bug-Fix] You can now actually move+shoot at max weapon skill! Fixed!","[CSG]Priyen"},
			{"> [Feature] Car Crash! A car crash will force the fire department to save you!","[CSG]Smart"},
			{"> [Feature] You like killing people ehh? hitman is perfect for you! Kill the hit!","[CSG]Smart"},
			{"> [Feature] Score System (use to unlock new things!)","[CSG]Jack"},
			{"> [Feature] New Bank Rob ==> December 16th, 2012","[CSG]Psydomin"},
			{"> [Feature] Drug Shipment ==> December 16th, 2012","[CSG]Priyen"},
			{"> [Feature] Over 50 Daily and Weekly Statistics [GAME TIME]","[CSG]Priyen"},
			{"	         > Player records...etc",""},
			{"> [Feature] Updated F1",""},
			{"> [Feature] Arrest Assist payments","[CSG]Smart"},
			{"> [Feature] Lasers [buy at ammunation] ==> December 16th, 2012",""},
			{"> [Feature] New Criminal 'Jobs'","[CSG]Priyen"},
			{"           > Don of LV",""},
			{"           > Drug Smuggler",""},
			{"           > Assassin",""},
			{"           > Butcher",""},
			{"           > Con Artist",""},
			{"           > Pick Pocket",""},
			{"           > Burgler",""},
			{"           > Capo",""},
			{"           > Smooth Talker",""},
			{"           > Petty Criminal",""},
			{"> [Feature] Peak System","[CSG]Jack"},
			{"> [Feature] Upgraded House System","[CSG]Priyen"},
			{"> [Feature] Lottery! /lotto num","[CSG]Priyen"},
			{"> [Feature] Police Ranks","[CSG]Priyen"},
			}
		},
		{115,"v 1.1.0","December 8th, 2012",
			{
				{"> [Bug-Fix] You will be released when a law accepts your bribe now!","[CSG]Priyen"},
				{"> [Bug-Fix] Fixed 24-7 shops, now you can buy the items! ","[CSG]Priyen"},
				{"> [Bug-Fix] Fixed veh engine,type /engine to toggle engine now ","[CSG]Priyen"},
				{"> [Feature] Patrol Mission no longer has a limit!","[CSG]Priyen"},
				{"> [Feature] Barriers for SWAT Team Added!","[CSG]Psydomin"},
				{"            > Press X at the trunk of a valid vehicle",""},
				{"> [Feature] New Store Robberies","[CSG]Priyen"},
				{"            > /holdup or /robstore to rob a store",""},
				{"> [Feature] LAW can get crime reports!","[CSG]Priyen"},
				{"            > /respond ID to respond to a report",""},
				{"            > /rescancel to stop Responding",""},
				{"> [Feature] Staff Panel warp player to, now works!","[CSG]Jack"},
				{"> [Bug-Fix] AFK+reconnect spawns you in wrong dimension, fixed!","[CSG]Jack"},
				{"> [Bug-Fix] Gym marker shows in all interiors, fixed!","[CSG]Psydomin"},
				{"> [Bug-Fix] Staff panel health+armor rounding bug, fixed!","[CSG]Jack"},
				{"> [Bug-Fix] Ability to shoot + aim in drug factory, fixed!","[CSG]Jack"},
				{"> [Bug-Fix] HP loss in jail, fixed!","[CSG]Jack"},
				{"> [Bug-Fix] Limit ATM marker height, fixed!","[CSG]Jack"},
			}
		},
		{110,"v 1.0.3","December 6th, 2012",
			{
				{"> [Feature] New Updates System. To keep you upto date and aware!","[CSG]Priyen"},
				{"            > Will be added to [F1] - Help Menu soon",""},
				{"            > [F1] - Help Menu will also be updated soon",""},
				{"> [Feature] New Wanted Detection System, get jailed to see, /crimes","[CSG]Priyen"},
				{"            > If you find bugs please report on CSG forum",""},
				{"> [Feature] Police Patrol Mission - Updated","[CSG]Priyen"},
				{"            > Now has different crime committers!",""},
				{"> [Bug-Fix] You now only lose stars when there is no LAW nearby","[CSG]Priyen"},
				--{"> [Feature] The next time I relog, only new will be green.","[CSG]Priyen"}}
			},
		},
		{109,"v 1.0.2","December 2nd, 2012",
			{
				{"> [Feature] New Vehicle System.","Dennis"},
				{"            > Recover fixed, can spawn 2 cars, new gui",""},
				{"            > Now see location and health w/ color",""},
				{"> [Feature] > Added fuel points for boats, planes","Dennis"},
				{"> [Bug-Fix] > Disabled fuel decreasing for bicycles","Dennis"},
			}
		}
	}


	theLatestVersion = 210
	rec(theMainData,myVersion,theLatestVersion,""..myDate.." at "..myTime.."")
	local newDate = getFormattedDate(exports.CSGpriyenmisc:getTimeStampYYYYMMDD())
	local theTim = getRealTime()
	local newTime = ""..(theTim.hour)..":"..(theTim.minute)..""
	xmlNodeSetValue(xmlFindChild(xmlHudBranch,"lastDate",0),newDate)
	xmlNodeSetValue(xmlFindChild(xmlHudBranch,"lastTime",0),newTime)
end

function ClientResourceStop ()
	if source ~= getResourceRootElement() then return end --This event will happen with any resource stop, isolate it to this resource
	local newDate = getFormattedDate(exports.CSGpriyenmisc:getTimeStampYYYYMMDD())
	local theTim = getRealTime()
	local newTime = ""..(theTim.hour)..":"..(theTim.minute)..""
	xmlNodeSetValue(xmlFindChild(xmlHudBranch,"lastDate",0),newDate)
	xmlNodeSetValue(xmlFindChild(xmlHudBranch,"lastTime",0),newTime)
	xmlSaveFile ( xmlRootTree ) --Save the xml from memory for use next time
	xmlUnloadFile ( xmlRootTree ) --Unload the xml from memory
end
addEventHandler ( "onClientResourceStop", root, ClientResourceStop )

-- Version number
local version = "1.5.8"

-- onClientRender
local sx, sy = guiGetScreenSize()

addEventHandler( "onClientRender", root,
	function ()
		dxDrawText("CSG: V" .. version .. "", sx*(1355.0/1440),sy*(872.0/900),sx*(1430.0/1440),sy*(885.0/900), tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, true, false, false)
	end
)
