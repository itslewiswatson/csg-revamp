------------------------
------CSG Commands------
---***Hit&Run***----
function cmdss ()
    commandgui = guiCreateWindow(177, 168, 700, 450, "CSG ~ Cmd's Panel", false)
    guiWindowSetSizable(commandgui, false)
	guiSetProperty(commandgui, "CaptionColour", "FFF80607")
    lable1 = guiCreateLabel(10, 47, 260, 370, "/showhud\n/sellweps\n/selldrugs\n/helpme\n/support (text)\n/ron  \n/ronoff\n/lotto \n/kill \n/hp   \n/housepanel \n/rob   \n/rb \n/housepanel \n/armortime  <--AT time \n/crimes \n/raidtime \n/banktime \n/casinotime \n/drugtime \n/racetime \n/stats \n/engine \n/buyrpg \n/barrier[1-4]    /destroyall   ", false, commandgui)
    guiLabelSetColor(lable1, 255, 225, 0)
	label2 = guiCreateLabel(170, 48, 260, 370, "/payfine   \n/sms (Name) (Text)   \n/reply (Name) (Text)     \n/r (Name) (Text)   \n/cleardx  \n/advert (text) \n/groupchat (text)  \n/clearchat \n/ac (text)  /gc (text)   \n/ircpm (Text)\n/dtype (awd,Rwd)\n/drink\n/smoke\n/gsc       <---------refuel\n/drugmenu \n/stoptrain \n/premium \n/pc  \n/pchat /togglepchat  \n/surr  \n/surrender \n/lmine /cmine /delmine <-exp unit mines \n/dropweps \n/cs  <--- Smoke Car System", false, commandgui)
    guiLabelSetColor(label2, 0, 255, 0)
	label3 = guiCreateLabel(390, 49, 260, 370, "/tire    <----------changeWheels\n/updates    \n/punishments\n/me text    \n/medkit    \n/pchief\n/arrt (CopName) (CrimName) <-transfer suspect\n/robstore or /holdup  \n/accbribe name  \n/bribe name  \n/me text \n/riotshield  \n/eventwarp \n/kill \n/flash   <---to open flashlight \n/bang    <---to use flashbang  \n/headlights 255 0 0  <---car lights red color \n/magup /magdown  <- to move Cargobo doors \n/cogo /cocome /costop /comove <-CopsAnim \n/hands <--CrimsAnim  \n/od [1-6] /cd [1-6]  <--Open/Close CarDoors \n/showscore   /hidescore  /myscore  ", false, commandgui)
    guiLabelSetColor(label3, 255, 150, 0)
	cmdsquit = guiCreateButton(650, 400, 40, 40, "Close.", false, commandgui)
	cmdsinfo = guiCreateButton(600, 400, 40, 40, "Info.", false, commandgui)
	guiSetFont(cmdsquit, "default-bold-small")
	guiSetAlpha(commandgui, 1.00)
   showCursor(false)
   guiSetProperty(cmdsquit, "NormalTextColour", "FFEC0000")
   guiSetVisible(commandgui,false)


cmdinfo = guiCreateWindow(492, 302, 304, 239, "Info", false)
guiWindowSetSizable(cmdinfo, false)

infolab = guiCreateLabel(10, 29, 285, 159, "Command Panel Made By Hitman & HBK  \n You can check all commands", false, cmdinfo)
guiSetFont(infolab, "sa-header")
guiLabelSetHorizontalAlign(infolab, "left", true)
backbut = guiCreateButton(226, 194, 68, 35, "Back", false, cmdinfo)
   guiSetVisible(cmdinfo,false)

end
addEventHandler("onClientResourceStart", resourceRoot, cmdss)



addEventHandler("onClientGUIClick", root,
function (localPlayer)
if ( source == cmdsquit ) then
guiSetVisible(commandgui,false)
showCursor(false)
end
end )

addEventHandler("onClientGUIClick", root,
function (localPlayer)
if ( source == cmdsinfo ) then
guiSetVisible(cmdinfo,true)
showCursor(true)
guiSetVisible(commandgui,false)

end
end )

addEventHandler("onClientGUIClick", root,
function (localPlayer)
if ( source == backbut ) then
guiSetVisible(commandgui,true)
guiSetVisible(cmdinfo,false)
end
end )

function showcmds(localPlayer)

	guiSetVisible(commandgui,true)
	showCursor(true)

end
addCommandHandler("cmds",showcmds)

