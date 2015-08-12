function navy_window()
	Navy_Wnd = guiCreateWindow(179,250,488,281,"Navy Panel - This panel you can use to open/close door or up/down lifts",false)

	open = guiCreateButton(39,176,74,28,"Open",false,Navy_Wnd)

	close = guiCreateButton(39,217,74,28,"Close",false,Navy_Wnd)

	up_1 = guiCreateButton(153,176,74,28,"Up",false,Navy_Wnd)

	down_1 = guiCreateButton(153,217,74,28,"Down",false,Navy_Wnd)

	up_2 = guiCreateButton(265,176,74,28,"Up",false,Navy_Wnd)

	down_2 = guiCreateButton(265,217,74,28,"Down",false,Navy_Wnd)

	up_3 = guiCreateButton(378,176,74,28,"Up",false,Navy_Wnd)

	down_3 = guiCreateButton(378,217,74,28,"Down",false,Navy_Wnd)

	quit_btn = guiCreateButton(380,32,100,28,"Close Window",false,Navy_Wnd)	

	exp_label = guiCreateLabel(42,32,155,18,"Explain of what button do ",false,Navy_Wnd)


	guiLabelSetColor(exp_label,255,255,0)

	guiLabelSetVerticalAlign(exp_label,"top")

	guiLabelSetHorizontalAlign(exp_label,"left",false)


	Memo_ = guiCreateMemo(40,47,326,101,"",false,Navy_Wnd)

	
	owned = guiCreateLabel(406,260,82,11,"Created by Smith",false,Navy_Wnd)

	guiLabelSetColor(owned,255,0,0)

	guiLabelSetVerticalAlign(owned,"top")

	guiLabelSetHorizontalAlign(owned,"left",false)

	guiSetFont(owned,"default-small")

	
	guiSetVisible ( Navy_Wnd, false )
	guiWindowSetSizable(Navy_Wnd, false)
        guiMemoSetReadOnly(Memo_,true)
	
	guiSetEnabled(close, false)
	guiSetEnabled(up_1, false)
	guiSetEnabled(up_2, false)
	guiSetEnabled(up_3, false)
	
	addEventHandler( "onClientGUIClick", quit_btn, close_window )

	addEventHandler( "onClientGUIClick", open, going_open )
	addEventHandler( "onClientGUIClick", close, going_close )
	
	addEventHandler( "onClientGUIClick", up_1, up_1_ )
	addEventHandler( "onClientGUIClick", down_1, down_1_ )
	
	addEventHandler( "onClientGUIClick", up_2, up_2_ )
	addEventHandler( "onClientGUIClick", down_2, down_2_ )
	
	addEventHandler( "onClientGUIClick", up_3, up_3_)
	addEventHandler( "onClientGUIClick", down_3, down_3_)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), navy_window )

function close_window()
	guiSetVisible (Navy_Wnd, false )
	showCursor ( false )
end


function navy_open()
	guiSetVisible ( Navy_Wnd, true )
	guiBringToFront ( Navy_Wnd)
	showCursor ( true )
end
addEvent("navy_open", true)
addEventHandler("navy_open", getLocalPlayer(), navy_open)



function going_open()
	guiSetEnabled(open, false)
	guiSetEnabled(close, true)
	guiSetText (Memo_,"You clicked button Open.\n\n This button take effect to open door from back of Navy Ship.\n\n Make sure to close it after it!")
  	triggerServerEvent ("open_door",getRootElement(),thePlayer);	
end

function going_close()
	guiSetEnabled(close, false)
	guiSetEnabled(open, true)
	guiSetText (Memo_,"You clicked button Close.\n\n This button take effect to Close door from back of Navy Ship.")
  	triggerServerEvent ("close_door",getRootElement(),thePlayer);	
end


function up_1_()
	guiSetEnabled(up_1, false)
	guiSetEnabled(down_1, true)
	guiSetText (Memo_,"You clicked button Up.\n\n This make Main Lift to go up and be in default position.")
  	triggerServerEvent ("up_1_lift",getRootElement(),thePlayer);	
end

function down_1_()
	guiSetEnabled(up_1, true)
	guiSetEnabled(down_1, false)
	guiSetText (Memo_,"You clicked button Down. \n\n This make Main Lift going down.\n\n Make sure to back it in default position !")
  	triggerServerEvent ("down_1_lift",getRootElement(),thePlayer);	
end

function up_2_()
	guiSetEnabled(up_2, false)
	guiSetEnabled(down_2, true)
	guiSetText (Memo_,"You clicked button Up.\n\n This make Second Lift to go up and be in default position.")
  	triggerServerEvent ("up_2_lift",getRootElement(),thePlayer);	
end

function down_2_()
	guiSetEnabled(up_2, true)
	guiSetEnabled(down_2, false)
	guiSetText (Memo_,"You clicked button Down. \n\n This make Second Lift going down.\n\n Make sure to back it in default position it uses for landing of airplanes!")
  	triggerServerEvent ("down_2_lift",getRootElement(),thePlayer);	
end

function up_3_()
	guiSetEnabled(up_3, false)
	guiSetEnabled(down_3, true)
	guiSetText (Memo_,"You clicked button Up.\n\n This make Lift to go up and be in default position.")
  	triggerServerEvent ("up_3_lift",getRootElement(),thePlayer);	
end

function down_3_()
	guiSetEnabled(up_3, true)
	guiSetEnabled(down_3, false)
	guiSetText (Memo_,"You clicked button Down. \n\n This make Lift going down next to the road.\n\n Make sure to back it in default position !")
  	triggerServerEvent ("down_3_lift",getRootElement(),thePlayer);	
end
