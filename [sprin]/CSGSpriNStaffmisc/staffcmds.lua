crash = {{{{{{{{ {}, {}, {} }}}}}}}}
commandgui = guiCreateWindow(441, 44, 490, 584, "CSG ~ Admin Commands", false)
        guiWindowSetSizable(commandgui, false)
        guiSetAlpha(commandgui, 1.00)
        guiSetProperty(commandgui, "CaptionColour", "FF7F7F7F")

        label1 = guiCreateLabel(10, 47, 260, 536, "/staff\n/invis\n/vehinvis\n/glue\n/dmgproof\n/stream L4+\n/vehfly\n/csg\n/sup\n L\nShift\n/setjob\n/note\n/wp\n/viewwep [name]\n/viewhouseweps [name]\n/forcedoor\n/forcereset\n/csgadmin\n/sbs\n/opendoor33\n/opengate34\n/nfo\n/emr\n/sfo\n/rfo\n/ajail acc time reason \n/amute acc time reason \n/agmute acc time reason ", false, commandgui)
        guiLabelSetColor(label1, 255, 0, 0)
        label2 = guiCreateLabel(167, 48, 289, 535, "Go to staff job\nMakes you invisible\nMakes your car invisible\nTo glue on a vehicle\nMakes your car not getting damaged\nSpawn a speaker for music\nMakes your car flying\nAdmin chat\nSupporters chat\nSpeed boost\nStaff Jump\nSet your job\nAdmin note\nTo warp to some places\nTo check someon's weapons\nTo check someone's house weapons\nBank door fix\nReset bank time\nMake yourself Availble for help\nSuper brake (should be binded\nOpen Maze event gate\nOpen dice event gate\nCreate Event borads\nCountdown\nStart shacking boards\nDelete boards\nTo jail someone who is offline\nTo mute someone who is offline\nTo global mute someone who is offline", false, commandgui)
        guiLabelSetColor(label2, 56, 99, 198)
        label3 = guiCreateLabel(15, 21, 79, 21, "Commands", false, commandgui)
        label4 = guiCreateLabel(167, 21, 93, 16, "Informations", false, commandgui)
        cmdsquit =  guiCreateButton(378, 550, 99, 24, "Close", false, commandgui)
        guiSetProperty(cmdsquit, "NormalTextColour", "FFAAAAAA")    
guiSetVisible(commandgui,false)
showCursor(false)



addEventHandler("onClientGUIClick", root,
function ()
if ( source == cmdsquit ) then
guiSetVisible(commandgui,false)
showCursor(false)
end 
end )


addEventHandler("onClientGUIClick", root,
function ()
if ( source == backbut ) then
guiSetVisible(commandgui,true)
end 
end )

function showcmds()
if (doIHavePermission()) then
 if ( guiGetVisible ( commandgui ) == true ) then            
		guiSetVisible ( commandgui, false) 
		showCursor(false)
    else              
        guiSetVisible ( commandgui, true ) 
		showCursor(true)
	end	
end
end
addCommandHandler("staffcmds",showcmds)

function bind()
	if source == localPlayer then
		bindKey ( "F5", "up", showcmds)
	end
end
addEventHandler("onClientPlayerJoin",getRootElement(),bind)

function bind(started)
	if started == getThisResource() then
		bindKey ( "F5", "up", showcmds)
	end
end
addEventHandler("onClientResourceStart",getRootElement(),bind)

function doIHavePermission()
local team = getTeamFromName("Staff")
		if (getPlayerTeam(localPlayer) == team) then
			return true
			else
			return false
			end
	end
	
