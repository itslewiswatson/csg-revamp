function WindowRules()
	window = guiCreateWindow(482, 152, 350, 408, "CSG~CJ Muscle", false)
	guiWindowSetSizable(window, false)
	guiSetAlpha(window, 1.00)
	guiSetVisible( window, false )
	guiMemoSetReadOnly(guiCreateMemo(120,40,200,130,"CJ Muscle :: The price to increase muscle is $500,750,1500,2500, and 3500 (in this order). Muslce only works on CJ skin (model 0). Start from the top -> bottom to increase. Rest Mode resets your muscle to 0.",false,window),true)
	button1 = guiCreateButton(10, 103, 89, 42, "100/200%", false, window)
	guiSetFont(button1, "default-bold-small")
	guiSetProperty(button1, "NormalTextColour", "FFC9B907")
	button2 = guiCreateButton(10, 164, 89, 42, "300/400%", false, window)
	guiSetFont(button2, "default-bold-small")
	guiSetProperty(button2, "NormalTextColour", "FFC5620A")
	button3 = guiCreateButton(10, 222, 89, 42, "500/600%", false, window)
	guiSetFont(button3, "default-bold-small")
	guiSetProperty(button3, "NormalTextColour", "FFC71007")
	button4 = guiCreateButton(10, 279, 89, 42, "700/900%", false, window)
	guiSetFont(button4, "default-bold-small")
	guiSetProperty(button4, "NormalTextColour", "FFBE0F4D")
	button0 = guiCreateButton(10, 44, 89, 42, "0/50%", false, window)
	guiSetFont(button0, "default-bold-small")
	guiSetProperty(button0, "NormalTextColour", "FF1EBA12")
	button6 = guiCreateButton(230, 279, 89, 42, "Close", false, window)
	guiSetFont(button6, "default-bold-small")
	guiSetProperty(button6, "NormalTextColour", "FF1727BB")
	button7 = guiCreateButton(230, 179, 89, 42, "RestMode", false, window)
	guiSetFont(button7, "default-bold-small")
	guiSetProperty(button7, "NormalTextColour", "FF1EBA12")
	somebar = guiCreateProgressBar(12, 331, 321, 61, false, window)
	guiSetAlpha(somebar, 0.50)

end
addEventHandler("onClientResourceStart", resourceRoot, WindowRules)
local CJmarker = createMarker(771.80700683594, 14.5, 999.5,"cylinder", 1.5, 90, 0, 200)

setElementInterior ( CJmarker, 5 )

function CJmuscle(p)
	if p ~= localPlayer then return end
	if getElementModel(p) ~= 0 then
		exports.dendxmsg:createNewDxMessage("This is the CJ muscle training marker, you need CJ Skin to use this!",255,0,0)
		return
	end
	guiSetVisible ( window, not guiGetVisible ( window ) )
	showCursor ( not isCursorShowing( ) )
end
addEventHandler("onClientMarkerHit", CJmarker, CJmuscle)
addEventHandler ( "onClientGUIClick", root,
function ()

	if ( source == button6 ) then
		guiSetVisible( window, false )
		showCursor ( false )
	end

end )


addEventHandler ( "onClientGUIClick", root,
function ()
	if ( source == button7 ) then
		local musclm = getPlayerMoney ( localPlayer )
		if ( musclm >= 500) then
			if ( somebar ) then
				progress = guiProgressBarGetProgress(somebar)
				if progress >= 10 then
					triggerServerEvent("Restmode", localPlayer)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 690, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 1400, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 2100, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 2800, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 3500, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 4200, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 4900, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 5600, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 6300, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0 ) end, 6910, 1)
					exports.dendxmsg:createNewDxMessage("Rest mode for your muscle skills",255,255,0)
				end
			end
		else
			exports.dendxmsg:createNewDxMessage("You Don't have enough money to use rest mode for your muscle stats",255,255,0)

		end
	end

end )


addEventHandler ( "onClientGUIClick", root,
function ()
	if ( source == button4 ) then
		local musclm = getPlayerMoney ( localPlayer )
		if ( musclm >= 3500) then
			if ( somebar ) then
				progress = guiProgressBarGetProgress(somebar)
				if progress == 88 then

					triggerServerEvent("moneymuscle5", localPlayer)
					setTimer (function() guiProgressBarSetProgress ( somebar, 89.5 ) end, 690, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 90 ) end, 1400, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 91.6 ) end, 2100, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 92.2 ) end, 2800, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 93 ) end, 3500, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 94.7 ) end, 4200, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 95.0 ) end, 4900, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 96.5 ) end, 5600, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 96.9 ) end, 6300, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 97.6 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 98.1 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 99.8 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 100 ) end, 6910, 1)
					triggerServerEvent("mus5", localPlayer)
				else
					if progress >= 100 then
						exports.dendxmsg:createNewDxMessage("You are already have this skill of your muscle",255,0,0)
					end
				end
			end
		else
				exports.dendxmsg:createNewDxMessage("You Don't have enough money to upgrade your muscle stats",255,0,0)
			end

	end
end )



addEventHandler ( "onClientGUIClick", root,
function ()
	if ( source == button3 ) then
		local musclm = getPlayerMoney ( localPlayer )
		if ( musclm >= 2500) then
			if ( somebar ) then
				progress = guiProgressBarGetProgress(somebar)
				if progress == 50 then

					triggerServerEvent("moneymuscle4", localPlayer)
					setTimer (function() guiProgressBarSetProgress ( somebar, 55.5 ) end, 690, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 59 ) end, 1400, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 63.6 ) end, 2100, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 68.2 ) end, 2800, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 72 ) end, 3500, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 73.7 ) end, 4200, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 75.0 ) end, 4900, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 76.5 ) end, 5600, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 78.6 ) end, 6300, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 80.6 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 85.1 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 87.8 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 88 ) end, 6910, 1)
					triggerServerEvent("mus4", localPlayer)
				else
					if progress >= 87.8 then
						exports.dendxmsg:createNewDxMessage("You are already have this skill of your muscle",255,0,0)
					end
				end
			end
		else
				exports.dendxmsg:createNewDxMessage("You Don't have enough money to upgrade your muscle stats",255,0,0)
			end

	end
end )



addEventHandler ( "onClientGUIClick", root,
function ()
	if ( source == button2 ) then
		local musclm = getPlayerMoney ( localPlayer )
		if ( musclm >= 1500) then
			if ( somebar ) then
				progress = guiProgressBarGetProgress(somebar)
				if progress == 25 then

					triggerServerEvent("moneymuscle3", localPlayer)

					setTimer (function() guiProgressBarSetProgress ( somebar, 25.5 ) end, 690, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 26 ) end, 1400, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 28.5 ) end, 2100, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 29.0 ) end, 2800, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 30.1 ) end, 3500, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 32.5 ) end, 4200, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 39.9 ) end, 4900, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 40.0 ) end, 5600, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 45.2 ) end, 6300, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 46.5 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 48.7 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 49.9 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 50 ) end, 6910, 1)
					triggerServerEvent("mus3", localPlayer)
				else
					if progress >= 49.9 then
						exports.dendxmsg:createNewDxMessage("You are already have this skill of your muscle",255,0,0)
					end
				end
			end
		else
				exports.dendxmsg:createNewDxMessage("You Don't have enough money to upgrade your muscle stats",255,0,0)

		end
	end
end )



addEventHandler ( "onClientGUIClick", root,
function ()
	if ( source == button1 ) then
		local musclm = getPlayerMoney ( localPlayer )
		if ( musclm >= 750) then
			if ( somebar ) then
				progress = guiProgressBarGetProgress(somebar)
				if progress == 10 then

					triggerServerEvent("moneymuscle2", localPlayer)

					setTimer (function() guiProgressBarSetProgress ( somebar, 10.5 ) end, 690, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 11 ) end, 1400, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 11.6 ) end, 2100, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 12.2 ) end, 2800, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 13 ) end, 3500, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 14.7 ) end, 4200, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 15.2 ) end, 4900, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 16.1 ) end, 5600, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 16.6 ) end, 6300, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 17.6 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 18.1 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 19.0 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 25 ) end, 6910, 1)
					triggerServerEvent("mus2", localPlayer)
				else
					if progress >= 24 then
						exports.dendxmsg:createNewDxMessage("You are already have this skill of your muscle",255,0,0)
					end
				end
			end
			else
				exports.dendxmsg:createNewDxMessage("You Don't have enough money",255,0,0)
			end

	end
end )



addEvent("onClientGUIClick", true)
addEventHandler ( "onClientGUIClick", root,
function ()
	if ( source == button0 ) then
		local musclm = getPlayerMoney ( localPlayer )
		if ( musclm >= 500) then
			if ( somebar ) then
				progress = guiProgressBarGetProgress(somebar)
				if progress == 0 then

					triggerServerEvent("moneymuscle", localPlayer)

					-- get the progress
					setTimer (function() guiProgressBarSetProgress ( somebar, 0.1 ) end, 690, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 0.8 ) end, 1400, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 1.3 ) end, 2100, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 1.7 ) end, 2800, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 2.3 ) end, 3500, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 3.5 ) end, 4200, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 4.3 ) end, 4900, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 5.7 ) end, 5600, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 6.3 ) end, 6300, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 7.6 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 8.1 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 9.0 ) end, 6910, 1)
					setTimer (function() guiProgressBarSetProgress ( somebar, 10 ) end, 6910, 1)
					triggerServerEvent("mus1", localPlayer)
				else
					if progress >= 9 then
						exports.dendxmsg:createNewDxMessage("You are already have this skill of your muscle",255,0,0)
					end
				end
				end
			else
				exports.dendxmsg:createNewDxMessage("You Don't have enough money to upgrade your muscle stats",255,0,0)
			end

	end
end )


addEvent("recCJmuscle",true)
addEventHandler("recCJmuscle",localPlayer,function(muscle)
guiProgressBarSetProgress(somebar,(muscle/10))
progress = (muscle/10)
end)

