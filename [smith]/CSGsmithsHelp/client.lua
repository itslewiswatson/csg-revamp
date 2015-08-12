crash = {{{{{{{{ {}, {}, {} }}}}}}}}

addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( )
-- RULES
-- local rules_ _file = fileOpen("Rules/rules_ .txt", true)
local rules_albanian_file = fileOpen("Rules/rules_albanian.txt", true)
local rules_arabic_file = fileOpen("Rules/rules_arabic.txt", true)
local rules_azerbaijan_file = fileOpen("Rules/rules_azerbaijan.txt", true)
local rules_egyptian_file = fileOpen("Rules/rules_egyptian.txt", true)
local rules_english_file = fileOpen("Rules/rules_english.txt", true)
local rules_greek_file = fileOpen("Rules/rules_greek.txt", true)
local rules_italian_file = fileOpen("Rules/rules_italian.txt", true)
local rules_portuguese_file = fileOpen("Rules/rules_portuguese.txt", true)
local rules_romanurdu_file = fileOpen("Rules/rules_romanurdu.txt", true)
local rules_russian_file = fileOpen("Rules/rules_russian.txt", true)
local rules_sweedish_file = fileOpen("Rules/rules_sweedish.txt", true)
local rules_tunisian_file = fileOpen("Rules/rules_tunisian.txt", true)
local rules_turkish_file = fileOpen("Rules/rules_turkish.txt", true)

-- local _Rules = fileRead(rules_ _file, 5000)
local Albanian_Rules = fileRead(rules_albanian_file, 5000)
local Arabic_Rules = fileRead(rules_arabic_file, 5000)
local Azerbaijan_Rules = fileRead(rules_azerbaijan_file, 5000)
local Egyptian_Rules = fileRead(rules_egyptian_file, 5000)
local English_Rules = fileRead(rules_english_file, 5000)
local Greek_Rules = fileRead(rules_greek_file, 5000)
local Italian_Rules = fileRead(rules_italian_file, 5000)
local Portuguese_Rules = fileRead(rules_portuguese_file, 5000)
local RomanUrdu_Rules = fileRead(rules_romanurdu_file, 5000)
local Russian_Rules = fileRead(rules_russian_file, 5000)
local Sweedish_Rules = fileRead(rules_sweedish_file, 5000)
local Tunisian_Rules = fileRead(rules_tunisian_file, 5000)
local Turkish_Rules = fileRead(rules_turkish_file, 5000)



-- OTHERS
-- local other_ _file = fileOpen("Other/ .txt", true)

local other_csginfo_file = fileOpen("Other/CSGinfo.txt", true)
local other_events_file = fileOpen("Other/Events.txt", true)
local other_faq_file = fileOpen("Other/FAQ.txt", true)
local other_staff_duties_file = fileOpen("Other/Staff_duties.txt", true)
local other_staff_roster_file = fileOpen("Other/Staff_roster.txt", true)
local other_updates_file = fileOpen("Other/Updates.txt", true)

--local _Info = fileRead(other_ _file, 5000)
local CSGinfo_Info = fileRead(other_csginfo_file, 5000)
local Events_Info = fileRead(other_events_file, 5000)
local FAQ_Info = fileRead(other_faq_file, 5000)
local Staff_D_Info = fileRead(other_staff_duties_file, 5000)
local Staff_R_Info = fileRead(other_staff_roster_file, 5000)
local Updates_Info = fileRead(other_updates_file, 5000)
    end
)

Options = {
{"Rules"},
{"Commands"},
{"Informations"},
{"Updates"},
{"Staff Roster"},
{"About CSG"},
}

CSGhelp_window = guiCreateWindow(302,86,701,585,"CSG ~ Extensive Documentation",false)
CSGhelp_image = guiCreateStaticImage(200,30,340,80,"images/logo.png",false,CSGhelp_window)
CSGhelp_Label = guiCreateLabel(155,110,500,50,"Extensive Documentation",false,CSGhelp_window)
	guiLabelSetColor(CSGhelp_Label,235,136,9)
	guiLabelSetVerticalAlign(CSGhelp_Label,"top")
	guiLabelSetHorizontalAlign(CSGhelp_Label,"left",false)
	guiSetFont(CSGhelp_Label,"sa-header")
CSGhelp_Credits = guiCreateLabel(490,566,220,20,"© Smith 2013 CSG ~ Extensive Documentation",false,CSGhelp_window)
	guiLabelSetColor(CSGhelp_Credits,255,250,250)
	guiLabelSetVerticalAlign(CSGhelp_Credits,"top")
	guiLabelSetHorizontalAlign(CSGhelp_Credits,"left",false)
	guiSetFont(CSGhelp_Credits,"default-small")
CSGhelp_memo = guiCreateMemo(165,174,527,392,"Please, Select one of current Options found in GridList 1.",false,CSGhelp_window)
CSGhelp_grid1 = guiCreateGridList(10,175,147,130,false,CSGhelp_window)
	guiGridListSetSelectionMode(CSGhelp_grid1,2)
	CSGhelp_grid1_Column = guiGridListAddColumn(CSGhelp_grid1,"Possible Options",0.81)
		for k, v in ipairs(Options) do
			local row = guiGridListAddRow ( CSGhelp_grid1 )
				guiGridListSetItemText ( CSGhelp_grid1 , row, CSGhelp_grid1_Column, v[1], false, false )
		end
CSGhelp_grid2 = guiCreateGridList(11,312,146,255,false,CSGhelp_window)
	guiGridListSetSelectionMode(CSGhelp_grid2,2)
	CSGhelp_grid2_Column = guiGridListAddColumn(CSGhelp_grid2,"Option(s)",0.81)
guiMemoSetReadOnly(CSGhelp_memo, true)
guiWindowSetSizable(CSGhelp_window,false)
guiSetVisible(CSGhelp_window,false)
showCursor(false)

bindKey('f1','down',
function()
guiSetVisible(CSGhelp_window, not guiGetVisible(CSGhelp_window))
showCursor(not isCursorShowing())
end
)


addEventHandler("onClientGUIClick", getRootElement(),
function()
if source == CSGhelp_grid1 then
	local selectedOption = guiGridListGetItemText (CSGhelp_grid1, guiGridListGetSelectedItem (CSGhelp_grid1), 1)
	if selectedOption ~= nil then
		if selectedOption == "Rules" then
			guiSetText(CSGhelp_memo,"Now that you selected your option, please select the one of the languages ??found in the following list.")
			guiGridListClear(CSGhelp_grid2)
			for k, v in ipairs(Rules) do
			local row = guiGridListAddRow ( CSGhelp_grid2 )
				guiGridListSetItemText(CSGhelp_grid2, row, CSGhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "Commands" then
			guiSetText(CSGhelp_memo,"Now that you selected your option, please select the one of the options ??found in the following list.")
			guiGridListClear(CSGhelp_grid2)
			for k, v in ipairs(Commands) do
			local row = guiGridListAddRow ( CSGhelp_grid2 )
				guiGridListSetItemText ( CSGhelp_grid2, row, CSGhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "Informations" then
			guiSetText(CSGhelp_memo,"Now that you selected your option, please select the one of the options ??found in the following list.")
			guiGridListClear(CSGhelp_grid2)
			for k, v in ipairs(Informations) do
			local row = guiGridListAddRow ( CSGhelp_grid2 )
				guiGridListSetItemText ( CSGhelp_grid2, row, CSGhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "Updates" then
			guiSetText(CSGhelp_memo,"Now that you selected your option, please select the one of the options ??found in the following list.")
			guiGridListClear(CSGhelp_grid2)
			for k, v in ipairs(Updates) do
			local row = guiGridListAddRow ( CSGhelp_grid2 )
				guiGridListSetItemText ( CSGhelp_grid2, row, CSGhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "Staff Roster" then
			guiSetText(CSGhelp_memo,"Now that you selected your option, please select the one of the options ??found in the following list.")
			guiGridListClear(CSGhelp_grid2)
			for k, v in ipairs(Roster) do
			local row = guiGridListAddRow ( CSGhelp_grid2 )
				guiGridListSetItemText ( CSGhelp_grid2, row, CSGhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "About CSG" then
			guiSetText(CSGhelp_memo,"Now that you selected your option, please select the one of the options ??found in the following list.")
			guiGridListClear(CSGhelp_grid2)
			for k, v in ipairs(About) do
			local row = guiGridListAddRow ( CSGhelp_grid2 )
				guiGridListSetItemText ( CSGhelp_grid2, row, CSGhelp_grid2_Column, v[1], false, false )
			end
		else
		guiSetText(CSGhelp_memo,"Warning: You have to select one of options found in GridList1!")
		end
	end
elseif source == CSGhelp_grid2 then
	local selectedOption = guiGridListGetItemText (CSGhelp_grid1, guiGridListGetSelectedItem (CSGhelp_grid1), 1)
	local selectedOption2 = guiGridListGetItemText (CSGhelp_grid2, guiGridListGetSelectedItem (CSGhelp_grid2), 1)
	if selectedOption == "Rules" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "Albanian" then
				guiSetText(CSGhelp_memo,Albanian_Rules)
			elseif selectedOption2 == "Arabic" then
				guiSetText(CSGhelp_memo,Arabic_Rules)
			elseif selectedOption2 == "Azerbaijan" then
				guiSetText(CSGhelp_memo,Azerbaijan_Rules)
			elseif selectedOption2 == "Egyptian" then
				guiSetText(CSGhelp_memo,Egyptian_Rules)
			elseif selectedOption2 == "English" then
				guiSetText(CSGhelp_memo,English_Rules)
			elseif selectedOption2 == "Greek" then
				guiSetText(CSGhelp_memo,Greek_Rules)
			elseif selectedOption2 == "Italian" then
				guiSetText(CSGhelp_memo,Italian_Rules)
			elseif selectedOption2 == "Portuguese" then
				guiSetText(CSGhelp_memo,Portuguese_Rules)
			elseif selectedOption2 == "Roman Urdu" then
				guiSetText(CSGhelp_memo,RomanUrdu_Rules)
			elseif selectedOption2 == "Russian" then
				guiSetText(CSGhelp_memo,Russian_Rules)
			elseif selectedOption2 == "Sweedish" then
				guiSetText(CSGhelp_memo,Sweedish_Rules)
			elseif selectedOption2 == "Tunisian" then
				guiSetText(CSGhelp_memo,Tunisian_Rules)
			elseif selectedOption2 == "Turkish" then
				guiSetText(CSGhelp_memo,Turkish_Rules)
			else
				guiSetText(CSGhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	elseif selectedOption == "Commands" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "Function Binds" then
				guiSetText(CSGhelp_memo,"Function key binds: \n\nF1 - Extensive Documentation such as Rules, Informations and so on.\nF2 - Job window, here you can quit your job or end/start your shift.\nF3 - Vehicle system, manage all your personal vehicles here.\nF4 - Animations windows.\nF5 - Inventory, here you find all your items like drugs, food and other things.\nF6 - Group system, manage your group or the group your currently in.\nF8 or ` - Console window\nF11 - Map window, in this windown you can see all blips for Jobs, Players, Stores and so on.\nF12 - Taking screenshot of your screen and save it in your MTA San Andreas/screenshoot folder.\n N - CSG Phone (SMSs, Money, Games etc).")
			elseif selectedOption2 == "Chat Binds" then
				guiSetText(CSGhelp_memo,"Chat related commands and binds: \n\nT - To talk to someone in MainChat.\nY - To talk to someone in TeamChat.\nU - Talk with people near your position, you get also a text baloon above your head.\nJ - Open CSG Chat system.\n\n\nCommands that can also be used to chat:\n\n/say  - To talk to someone in MainChat.\n/teamsay  - Talk with people in the same team.\n/local or /localchat  - Talk with people near your position, you get also a text baloon above your head.\n/group or /groupchat or /gc - Talk with people in your group.\n/law - To talk with people in Official Laws Team.\n/advert  - When you have something to advertise for example house for sell, one message cost $500 (1 minute spam protection).\n/clearchat  - Clear the whole chat.\n\n\nNOTE: You can bind all these commands by using /bind [KEYBOARD KEY] chatbox [COMMANDNAME]")
			elseif selectedOption2 == "Other Binds" then
				guiSetText(CSGhelp_memo,"Other commands:\n\n/payfine - When you have 1 wanted star you can pay a fine, this will remove your wanted star\n/bribe [COPNAME] [AMOUNT MONEY] - When you have less that 4 wanted stars you can bribe a cop, if the cop accepts the bribe your stars get removed\n/911 [SERVICE] (Police, Paramedic) - Call the emergency services to your current location\n/latestchanges - See the latest updates on the server\n/punishments - See all your serial and account punishments\n/showfps - Enable the FPS meter\n/showhud [0 OR 1] - Disable or enable the MTA hud\n/screenshot or F12 - Take a screenshot (will be saved on your PC)\n/shownametags [0 OR 1] - Disabled or enable the nametags\n/showchat [0 OR 1] - Disabled or enable the chatbox\nSWAT and Military Forces can use /riotshield to use a riotshield (THIS KEY NEED TO BE BINDED!)\n\n\nNOTE: You can bind all these command by using /bind [KEYBOARD KEY] [COMMANDNAME]\nNOTE: Use /help to see all MTA commands (output is in the console (F8))")
			else
				guiSetText(CSGhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	elseif selectedOption == "Informations" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "FAQ" then
				guiSetText(CSGhelp_memo,FAQ_Info)
			elseif selectedOption2 == "Events" then
				guiSetText(CSGhelp_memo,Events_Info)
			else
				guiSetText(CSGhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	elseif selectedOption == "Updates" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "Recently Updates" then
				guiSetText(CSGhelp_memo,Updates_Info)
			else
				guiSetText(CSGhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	elseif selectedOption == "Staff Roster" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "Staff Duties" then
				guiSetText(CSGhelp_memo, Staff_D_Info)
			elseif selectedOption2 == "Staff Roster" then
				guiSetText(CSGhelp_memo, Staff_R_Info)
			else
				guiSetText(CSGhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	elseif selectedOption == "About CSG" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "CSG info" then
				guiSetText(CSGhelp_memo,CSGinfo_Info)
			else
				guiSetText(CSGhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	else
		guiSetText(CSGhelp_memo,"Warning: You have to select one of options found in GridList1!")
	end
end
end
)

