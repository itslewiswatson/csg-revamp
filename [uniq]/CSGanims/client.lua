local anims = {
-- {SHOWN ANIM CATO, SHOWN ANIM NAME, BLOCK, ANIM}
{"Dancing", "Ddance", "DANCING", "dnce_M_d"},
{"Dancing", "Edance", "DANCING", "dnce_M_e"},
{"Dancing", "Adance", "DANCING", "dnce_M_a"},
{"Dancing", "Bdance", "DANCING", "dnce_M_b"},
{"Dancing", "Clap", "DANCING", "bd_clap1"},
{"Dancing", "Lopdance", "DANCING", "DAN_Loop_A"},
{"Relaxing", "Sunbathe1", "BEACH", "ParkSit_W_loop"},
{"Relaxing", "Sunbathe2", "BEACH", "SitnWait_loop_W"},
{"Relaxing", "SleepL", "INT_HOUSE", "BED_Loop_L"},
{"Relaxing", "SleepR", "INT_HOUSE", "BED_Loop_R"},
{"Relaxing", "SmokeL", "SMOKING", "M_smkstnd_loop"},
{"Relaxing", "SmokeA", "SMOKING", "M_smk_in"},
{"Relaxing", "SitTalk", "MISC", "Seat_talk_01"},
{"Relaxing", "SitWatch", "INT_OFFICE", "OFF_Sit_Watch"},
{"Emergency", "Policetactic1", "SWAT", "swt_breach_02"},
{"Emergency", "Policetactic2", "SWAT", "swt_breach_01"},
{"Emergency", "Watchleft", "SWAT", "swt_wllpk_L"},
{"Emergency", "Watchright", "SWAT", "swt_wllpk_R"},
{"Emergency", "Breach", "GANGS", "shake_carK"},
{"Emergency", "CPR", "MEDIC", "CPR"},
{"Emergency", "Handsup", "ROB_BANK", "SHP_HandsUp_Scr"},
{"Emergency", "JumpCover", "DODGE", "Crush_Jump"},
{"Illegal", "Accept", "GANGS", "Invite_Yes"},
{"Illegal", "Reject", "Gangs", "Invite_No"},
{"Illegal", "Gangsign1", "GHANDS", "gsign4"},
{"Illegal", "Gangsign2", "GHANDS", "gsign2LH"},
{"Illegal", "Weedsmoke", "GANGS", "smkcig_prtl_F"},
{"Illegal", "Gangtalk", "GANGS", "prtial_gngtlkC"},
{"Illegal", "Dealeridle", "GANGS", "DEALER_IDLE"},
{"Illegal", "Gangrap", "RAPPING", "RAP_A_Loop"},
{"Illegal", "Laugh" , "Rapping", "Laugh_01"},
{"Food", "eatjunk", "FOOD", "EAT_Vomit_P"},
{"Food", "Eat1", "FOOD", "EAT_Chicken"},
{"Food", "Eat2", "FOOD", "EAT_Pizza"},
{"Food", "SitEat1", "FOOD", "FF_Sit_Eat1"},
{"Food", "SitEat2", "FOOD", "FF_Sit_Eat2"},
{"Death", "Wounded", "CRACK", "crckdeth4"},
{"Death", "Insensible", "CRACK", "crckidle2"},
{"Death", "Dead", "CRACK", "crckidle1"},
{"Robbing", "Cracksafe1", "ROB_BANK", "CAT_Safe_Open"},
{"Robbing", "Plantbomb", "BOMBER", "BOM_Plant"},
{"18+", "Strip1", "STRIP", "STR_C1"},
{"18+", "Strip2", "STRIP", "STR_C2"},
{"18+", "Piss", "PAULNMAC", "Piss_in"},
{"18+", "Wank", "PAULNMAC", "wank_loop"},
}

local setAnim = {false,false}

local AnimationWindow = guiCreateWindow(584,226,262,421,"CSG ~ Animations",false)
local stop = guiCreateButton(9,387,122,25,"Stop Animation",false,AnimationWindow)
local close = guiCreateButton(133,387,120,25,"Close window",false,AnimationWindow)
local animgrid = guiCreateGridList(9,22,244,358,false,AnimationWindow)
local column1 = guiGridListAddColumn(animgrid,"Categories",0.35)
local column2 = guiGridListAddColumn(animgrid,"Animation",0.5)

for i=1,#anims do
	local cato, name = anims[i][1], anims[i][2]
	local row = guiGridListAddRow ( animgrid )
	guiGridListSetItemText ( animgrid, row, column1, cato, false, false )
	guiGridListSetItemText ( animgrid, row, column2, name, false, false )
	guiGridListSetItemData ( animgrid, row, column1, {anims[i][3],anims[i][4]} )
end

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(AnimationWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(AnimationWindow,x,y,false)

guiWindowSetMovable (AnimationWindow, true)
guiWindowSetSizable (AnimationWindow, false)
guiSetVisible (AnimationWindow, false)

function commandBasedAnim(block,anim)
	if not isPedInVehicle(localPlayer) then
		triggerServerEvent("startAnim", localPlayer, tostring(block), tostring(anim))
	end
end

for k,v in ipairs(anims) do
	addCommandHandler(string.lower(v[2]),function()
		commandBasedAnim(v[3],v[4])
	end)
	addCommandHandler(v[2],function()
		commandBasedAnim(v[3],v[4])
	end)
end

function toggleAnimationWindow ()
	if (guiGetVisible(AnimationWindow)) then
		guiSetVisible(AnimationWindow, false)
		showCursor(false)
	else
		guiSetVisible(AnimationWindow, true)
		showCursor(true)
	end
end
bindKey("F7", "down", toggleAnimationWindow)
addEventHandler("onClientGUIClick", close, toggleAnimationWindow, false)

function sendAnim()
	local row, _ = guiGridListGetSelectedItem ( animgrid )
	if ( row and row ~= -1 ) then
		local animData = guiGridListGetItemData ( animgrid, row, column1 )
		if ( animData ) then
			local block, anim = unpack(animData)
			if not isPedInVehicle(localPlayer) then
				local curBlock,curAnim = getPedAnimation(localPlayer)
				if ( not curBlock and not curAnim ) then
					triggerServerEvent("startAnim", localPlayer, tostring(block), tostring(anim))
					setAnim = animData
				else				
					exports.dendxmsg:createNewDxMessage("You can't start an animation now, stop your old one first.",255,0,0)
				end
			else
				exports.dendxmsg:createNewDxMessage("You can't start an animation now, get out of your vehicle first.",255,0,0)
			end
		end
	end
end
addEventHandler("onClientGUIDoubleClick", animgrid, sendAnim)

function stopAnim ()
	if getPlayerWantedLevel() > 0 then
		if getElementData(localPlayer,"tazed") then
			exports.DENdxmsg:createNewDxMessage("You can't use /stopanim while tazed",255,0,0)
			return
		end
	end
	local block,anim = getPedAnimation(localPlayer)
	if block ~= false then
		if (block == "ROCKET" and anim == "idle_rocket") or (block == "CRACK" and anim == "crckidle2") or (block == "BOMBER" and anim == "BOM_Plant") or (block == "ROB_BANK" and anim == "CAT_Safe_Open") then
			return
		end
	end
	local storBlock, storAnim = unpack(setAnim)
	if ( storBlock and block and storBlock:lower() == block:lower() ) and ( storAnim and anim and storAnim:lower() == anim:lower() ) then -- same anim as player set
		triggerServerEvent ("stopAnim", localPlayer)
		setAnim = {false,false}
	else
		exports.DENdxmsg:createNewDxMessage("You can't stop your animation right now.",255,0,0)
	end
end
addEventHandler("onClientGUIClick", stop, stopAnim, false)
addCommandHandler("stopanim", stopAnim)

function handsup ()
	if not isPedInVehicle(localPlayer) then
		triggerServerEvent("startAnim", localPlayer, "ped", "handsup")
	end
end
addCommandHandler("handsup", handsup)
addCommandHandler("hu", handsup)

addEvent ( "onPlayerArrest", true )
function onPlayerGetArrest ()
	if ( source == localPlayer ) then
		triggerServerEvent ("stopAnim", localPlayer)
	end
end
addEventHandler ( "onPlayerArrest", root, onPlayerGetArrest )
