local theJobsTable = {
[0] = { "SWAT Team", "SWAT", 285 },
[1] = { "Military Forces", "Military Forces", 287 },
[2] = { "FBI Agent", "Government Agency", 51 },
[3] = { "Police Officer", "Police", 280 },
[4] = { "Pilot", "Civilian Workers", 61 },
[5] = { "Paramedic", "Paramedics", 276 },
[6] = { "Prostitute", "Civilian Workers", 257 },
[7] = { "Mechanic", "Civilian Workers", 305 },
[8] = { "Trucker", "Civilian Workers", 15 },
[9] = { "Firefighter", "Firefighters", 277 },
[10] = { "K-9 Unit Officer", "Police",  283 },
[11] = {"Bus Driver", "Civilian Workers", 255 },
[12] = { "Street Cleaner", "Civilian Workers", 16 },
[13] = { "Electrician", "Civilian Workers", 260 },
[14] = { "Fisherman", "Civilian Workers", 35 }

}



local setjobWindow = guiCreateWindow(854, 329, 248, 399, "CSG ~ Setjob", false)
local cancel = guiCreateButton(132, 353, 83, 36, "Cancel", false, setjobWindow)
local jobsgrid = guiCreateGridList(10, 67, 221, 276, false, setjobWindow)
local column1 = guiGridListAddColumn(jobsgrid,"Occupation",0.5)
local column2 = guiGridListAddColumn(jobsgrid,"Team",0.5)
local name = guiCreateEdit(16, 28, 211, 29, "", false, setjobWindow)
local set_Job = guiCreateButton(30, 353, 83, 36, "Set Job", false, setjobWindow)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(setjobWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(setjobWindow,x,y,false)

guiWindowSetMovable (setjobWindow, true)
guiWindowSetSizable (setjobWindow, false)
guiSetVisible (setjobWindow, false)


for i=0,#theJobsTable do
	local occupation, team = theJobsTable[i][1], theJobsTable[i][2]
	local row = guiGridListAddRow ( jobsgrid )
	guiGridListSetItemText ( jobsgrid, row, column1, occupation, false, false )
	guiGridListSetItemText ( jobsgrid, row, column2, team, false, false )
	guiGridListSetItemData ( jobsgrid, row, column1, i)
end

function togglesetjobWindow ()
	if (getPlayerTeam(localPlayer)) and (getTeamName (getPlayerTeam ( localPlayer )) == "Staff") then
		if (guiGetVisible(setjobWindow)) then
			guiSetVisible(setjobWindow, false)
			showCursor(false)
		else
			guiSetVisible(setjobWindow, true)
			showCursor(true)
		end
	end
end
addCommandHandler("setjob", togglesetjobWindow, false)

function closeWindow ()
	guiSetVisible(setjobWindow, false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", cancel, closeWindow, false)

function setJob() -- check
	local row, column = guiGridListGetSelectedItem ( jobsgrid )
	if ( row ) and ( column ) then
		local jobsID = guiGridListGetItemData ( jobsgrid, row, column )
		if ( jobsID ) then
			local occupation = theJobsTable[jobsID][1]
			local team = theJobsTable[jobsID][2]
			local skin = theJobsTable[jobsID][3]
			local setjobFrom = guiGetText(name)
			if ( setjobFrom == "" ) then
				local thePlayer = localPlayer
				triggerServerEvent("changeJob", localPlayer, thePlayer, occupation, team, skin)
				closeWindow ()
				exports.DENdxmsg:createNewDxMessage("Your job has succesfully been changed to" ..occupation.."" , 220, 0, 0 )
			else
				local thePlayers = getElementsByType("player")
				for i=1, #thePlayers do
					if string.find(getPlayerName(thePlayers[i]):lower(), tostring(setjobFrom):lower(), 1, true) then
						local thePlayer = thePlayers[i]
						triggerServerEvent("changeJob", localPlayer, thePlayer, occupation, team, skin)
						closeWindow ()
						exports.DENdxmsg:createNewDxMessage("The job of" ..thePlayer.. "has succesfully been changed to" ..occupation.."", 220, 0, 0)
						break
					end
				end
			end
		end
	end
end
addEventHandler("onClientGUIClick", set_Job, setJob, false)
