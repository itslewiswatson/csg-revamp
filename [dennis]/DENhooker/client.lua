function askForBlowjob(hooker)
	myhooker = hooker
	showCursor ( true )
	if not blowjobWindow then
		blowjobWindow = guiCreateWindow(603,349,301,136,"Hooker Services",false)
		label1 = guiCreateLabel(10,31,282,17,"This hooker want to give you a blowjob.",false,blowjobWindow)
		guiSetFont(label1 ,"default-bold-small")
		label2 = guiCreateLabel(10,49,282,17,"Using hooker services will give you health.",false,blowjobWindow)
		guiSetFont(label2,"default-bold-small")
		button1 = guiCreateButton(9,91,144,34,"Accept ($750)",false,blowjobWindow)
		button2 = guiCreateButton(157,91,135,34,"No Thanks",false,blowjobWindow)
		addEventHandler( "onClientGUIClick", button2, cancelBlow )
		addEventHandler( "onClientGUIClick", button1, startBlow)
	else
		guiSetVisible( blowjobWindow, true )
	end
	guiBringToFront( blowjobWindow )
end
addEvent( "askForBlowjob", true )
addEventHandler( "askForBlowjob", getLocalPlayer(), askForBlowjob )

function startBlow()
	local thePlayer = getLocalPlayer()
	guiSetVisible( blowjobWindow, false )
	showCursor ( false )
	triggerServerEvent ( "acceptBlowjob", getLocalPlayer(), myhooker, thePlayer )
end

function cancelBlow()
	local thePlayer = getLocalPlayer()
	triggerServerEvent ( "cancelBlowJob", getLocalPlayer(), myhooker, thePlayer )
	showCursor ( false )
	guiSetVisible( blowjobWindow, false )
end