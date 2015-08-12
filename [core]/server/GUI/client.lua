local crasher = {{{{{ {}, {{{}}}, {{{{{{{},{}}}}}}}}}}}}

-- Get the username and/or password is saved
function getAccountXMLData ()
	local theFile = xmlLoadFile ( "@account.xml" )
	if not ( theFile ) then
		theFile = xmlCreateFile( "@account.xml","accounts" )
		xmlCreateChild( theFile, "username" )
		xmlCreateChild( theFile, "password" )
		xmlSaveFile( theFile )
		return "", ""
	else
		usernameNode = xmlFindChild( theFile, "username", 0 )
		username = xmlNodeGetValue ( usernameNode )
		passwordNode = xmlFindChild( theFile, "password", 0 )
		password = xmlNodeGetValue ( passwordNode )
		return username, password
	end
	xmlUnloadFile(theFile)
end

-- Update the XML file with the new data
addEvent ( "updateAccountXMLData", true )
addEventHandler( "updateAccountXMLData", root,
	function ( username, password, usernameTick, passwordTick )
		local theFile = xmlLoadFile ( "@account.xml" )
		if not ( theFile ) then
			theFile = xmlCreateFile( "@account.xml","accounts" )
			xmlCreateChild( theFile, "username" )
			xmlCreateChild( theFile, "password" )
			xmlSaveFile( theFile )
		else
			usernameNode = xmlFindChild( theFile, "username", 0 )
			xmlNodeSetValue( usernameNode, username )
			passwordNode = xmlFindChild( theFile, "password", 0 )
			xmlNodeSetValue( passwordNode, password )
			
			if not ( usernameTick ) then
				usernameNode = xmlFindChild( theFile, "username", 0 )
				xmlNodeSetValue( usernameNode, "" )
			end
				
			if not ( passwordTick ) then
				passwordNode = xmlFindChild( theFile, "password", 0 )
				xmlNodeSetValue( passwordNode, "" )
			end
			xmlSaveFile( theFile )
			xmlUnloadFile(theFile)
		end
	end
)

function createAccountingWindows ()
	-- Login window
	local username, password = getAccountXMLData ()
	CSGLoginWindow = guiCreateWindow(433,258,377,406,"Community of Social Gaming ~ Login",false)
	CSGLoginImage = guiCreateStaticImage(23,32,324,91,"Files/logo.png",false,CSGLoginWindow)
	CSGLoginLabel1 = guiCreateLabel(8,127,359,17,"Accountname:",false,CSGLoginWindow)
	guiLabelSetColor(CSGLoginLabel1,238, 154, 0)
	guiLabelSetHorizontalAlign(CSGLoginLabel1,"center",false)
	guiSetFont(CSGLoginLabel1,"default-bold-small")
	CSGLoginUsernameField = guiCreateEdit(46,146,287,22,username,false,CSGLoginWindow)
	CSGLoginLabel2 = guiCreateLabel(8,183,359,17,"Password:",false,CSGLoginWindow)
	guiLabelSetColor(CSGLoginLabel2,238,154,0)
	guiLabelSetHorizontalAlign(CSGLoginLabel2,"center",false)
	guiSetFont(CSGLoginLabel2,"default-bold-small")
	CSGLoginPasswordField = guiCreateEdit(46,203,287,22,password,false,CSGLoginWindow)
	guiEditSetMasked (CSGLoginPasswordField,true)
	CSGLoginUsernameCheckbox = guiCreateCheckBox(74,236,112,23,"Save username",false,false,CSGLoginWindow)
	guiSetFont(CSGLoginUsernameCheckbox,"default-bold-small")
	CSGLoginPasswordCheckbox = guiCreateCheckBox(199,236,111,23,"Save password",false,false,CSGLoginWindow)
	guiSetFont(CSGLoginPasswordCheckbox,"default-bold-small")
	CSGLoginJoinButton = guiCreateButton(47,303,287,23,"Join the game",false,CSGLoginWindow)
	CSGLoginCreateButton = guiCreateButton(47,332,287,23,"Create a new account",false,CSGLoginWindow)
	CSGLoginPasswordButton = guiCreateButton(47,362,287,23,"Request a new password",false,CSGLoginWindow)
	CSGLoginLabel3 = guiCreateLabel(8,273,359,17,"Always read the rules before playing on this server!",false,CSGLoginWindow)
	guiLabelSetColor(CSGLoginLabel3,34,139,34)
	guiLabelSetHorizontalAlign(CSGLoginLabel3,"center",false)
	guiSetFont(CSGLoginLabel3,"default-bold-small")
	if ( username ~= "" ) then guiCheckBoxSetSelected( CSGLoginUsernameCheckbox, true ) end
	if ( password ~= "" ) then guiCheckBoxSetSelected( CSGLoginPasswordCheckbox, true ) end
	centerWindows ( CSGLoginWindow )
	guiWindowSetMovable (CSGLoginWindow, true)
	guiWindowSetSizable (CSGLoginWindow, false)
	guiSetVisible (CSGLoginWindow, false)
	
	-- Register window
	CSGRegisterWindow = guiCreateWindow(495,183,377,492,"Community of Social Gaming ~ Create account",false)
	CSGRegisterImage = guiCreateStaticImage(23,32,324,91,"Files/logo.png",false,CSGRegisterWindow)
	CSGRegisterLabel1 = guiCreateLabel(8,127,359,17,"Accountname:",false,CSGRegisterWindow)
	guiLabelSetColor(CSGRegisterLabel1,238	,154,0)
	guiLabelSetHorizontalAlign(CSGRegisterLabel1,"center",false)
	guiSetFont(CSGRegisterLabel1,"default-bold-small")
	CSGRegisterUsernameField = guiCreateEdit(46,146,287,22,"",false,CSGRegisterWindow)
	CSGRegisterLabel2 = guiCreateLabel(8,183,359,17,"Password:",false,CSGRegisterWindow)
	guiLabelSetColor(CSGRegisterLabel2,238,154,0)
	guiLabelSetHorizontalAlign(CSGRegisterLabel2,"center",false)
	guiSetFont(CSGRegisterLabel2,"default-bold-small")
	CSGRegisterPasswordField = guiCreateEdit(46,203,287,22,"",false,CSGRegisterWindow)
	guiEditSetMasked(CSGRegisterPasswordField,true)
	CSGRegisterLabel3 = guiCreateLabel(10,392,359,17,"Dual accounting is not allowed. Always read the rules.",false,CSGRegisterWindow)
	guiLabelSetColor(CSGRegisterLabel3,34,139,34)
	guiLabelSetHorizontalAlign(CSGRegisterLabel3,"center",false)
	guiSetFont(CSGRegisterLabel3,"default-bold-small")
	CSGRegisterLabel4 = guiCreateLabel(8,238,359,17,"Repeat password:",false,CSGRegisterWindow)
	guiLabelSetColor(CSGRegisterLabel4,238,154,0)
	guiLabelSetHorizontalAlign(CSGRegisterLabel4,"center",false)
	guiSetFont(CSGRegisterLabel4,"default-bold-small")
	CSGRegisterPassword2Field = guiCreateEdit(46,258,287,22,"",false,CSGRegisterWindow)
	guiEditSetMasked(CSGRegisterPassword2Field,true)
	CSGRegisterLabel5 = guiCreateLabel(8,290,359,17,"Email Address:",false,CSGRegisterWindow)
	guiLabelSetColor(CSGRegisterLabel5,238,154,0)
	guiLabelSetHorizontalAlign(CSGRegisterLabel5,"center",false)
	guiSetFont(CSGRegisterLabel5,"default-bold-small")
	CSGRegisterEmailField = guiCreateEdit(46,310,287,22,"",false,CSGRegisterWindow)
	CSGRegisterLabel6 = guiCreateLabel(8,343,359,17,"Gender:",false,CSGRegisterWindow)
	guiLabelSetColor(CSGRegisterLabel6,238,154,0)
	guiLabelSetHorizontalAlign(CSGRegisterLabel6,"center",false)
	guiSetFont(CSGRegisterLabel6,"default-bold-small")
	CSGRegisterMaleGender = guiCreateRadioButton(132,362,45,19,"Male",false,CSGRegisterWindow)
	CSGRegisterFemaleGender = guiCreateRadioButton(181,362,67,19,"Female",false,CSGRegisterWindow)
	CSGRegisterCreateButton = guiCreateButton(47,426,287,23,"Create new account",false,CSGRegisterWindow)
	CSGRegisterReturnButton = guiCreateButton(47,456,287,23,"Return to the login screen",false,CSGRegisterWindow)
	centerWindows ( CSGRegisterWindow )
	guiWindowSetMovable (CSGRegisterWindow, true)
	guiWindowSetSizable (CSGRegisterWindow, false)
	guiSetVisible (CSGRegisterWindow, false)
	
	-- Password request window
	CSGPasswordWindow = guiCreateWindow(495,183,377,350,"Community of Social Gaming ~ Password request",false)
	CSGPasswordImage = guiCreateStaticImage(23,32,324,91,"Files/logo.png",false,CSGPasswordWindow)
	CSGPasswordLabel1 = guiCreateLabel(8,127,359,17,"Accountname:",false,CSGPasswordWindow)
	guiLabelSetColor(CSGPasswordLabel1,238,154,0)
	guiLabelSetHorizontalAlign(CSGPasswordLabel1,"center",false)
	guiSetFont(CSGPasswordLabel1,"default-bold-small")
	CSGPasswordUsernameField = guiCreateEdit(46,146,287,22,"",false,CSGPasswordWindow)
	CSGPasswordCancelButton = guiCreateButton(47,310,287,23,"Return to the login screen",false,CSGPasswordWindow)
	CSGPasswordLabel2 = guiCreateLabel(10,245,359,17,"A new password will be sent to your email!",false,CSGPasswordWindow)
	guiLabelSetColor(CSGPasswordLabel2,34,139,34)
	guiLabelSetHorizontalAlign(CSGPasswordLabel2,"center",false)
	guiSetFont(CSGPasswordLabel2,"default-bold-small")
	CSGPasswordRequestButton = guiCreateButton(47,278,287,23,"Request new password",false,CSGPasswordWindow)
	CSGPasswordEmailField = guiCreateEdit(46,203,287,22,"",false,CSGPasswordWindow)
	CSGPasswordLabel3 = guiCreateLabel(8,181,359,17,"Email Adress:",false,CSGPasswordWindow)
	guiLabelSetColor(CSGPasswordLabel3,238,154,0)
	guiLabelSetHorizontalAlign(CSGPasswordLabel3,"center",false)
	guiSetFont(CSGPasswordLabel3,"default-bold-small")
	centerWindows ( CSGPasswordWindow )
	guiWindowSetMovable (CSGPasswordWindow, true)
	guiWindowSetSizable (CSGPasswordWindow, false)
	guiSetVisible (CSGPasswordWindow, false)
	
	-- Popup window after creating account
	CSGRegisterPopup = guiCreateWindow(495,184,253,157,"Community of Social Gaming",false)
	CSGRegisterPopupLabel1 = guiCreateLabel(8,27,238,17,"Warning:",false,CSGRegisterPopup)
	guiLabelSetColor(CSGRegisterPopupLabel1,34,139,34)
	guiLabelSetHorizontalAlign(CSGRegisterPopupLabel1,"center",false)
	guiSetFont(CSGRegisterPopupLabel1,"default-bold-small")
	CSGRegisterPopupLabel2 = guiCreateLabel(8,52,235,61,"Your account is created and ready to use!\nBefore playing read the rules.\n\nVisit also: www.csgmta.net",false,CSGRegisterPopup)
	guiLabelSetHorizontalAlign(CSGRegisterPopupLabel2,"center",false)
	guiSetFont(CSGRegisterPopupLabel2,"default-bold-small")
	CSGRegisterPopupButton = guiCreateButton(25,121,208,23,"Return to the login screen",false,CSGRegisterPopup)	
	centerWindows ( CSGRegisterPopup )
	guiWindowSetMovable (CSGRegisterPopup, true)
	guiWindowSetSizable (CSGRegisterPopup, false)
	guiSetVisible (CSGRegisterPopup, false)
	
	-- New password window
	CSGNewPasswordWindow = guiCreateWindow(547, 320, 474, 290, "Community of Social Gaming", false)
	CSGNewPasswordLabel1 = guiCreateLabel(10, 30, 456, 92, "CSG improved the account system and security.\nThis means your account will not work untill you changed your password.\nYour password is now secured with one of the better hashing algorithms.\nThis means nobody can see or decrypt your password.\n\nAfter you completed the password change you are able to play again!", false, CSGNewPasswordWindow)
	guiLabelSetHorizontalAlign(CSGNewPasswordLabel1, "center", false)
	CSGNewPasswordLabel2 = guiCreateLabel(200, 138, 90, 16, "New password:", false, CSGNewPasswordWindow)
	guiSetFont(CSGNewPasswordLabel2, "default-bold-small")
	CSGNewPasswordEdit1 = guiCreateEdit(116, 158, 246, 26, "", false, CSGNewPasswordWindow)
	guiEditSetMasked ( CSGNewPasswordEdit1, true )
	CSGNewPasswordLabel3 = guiCreateLabel(179, 194, 133, 15, "Repeat new password:", false, CSGNewPasswordWindow)
	guiSetFont(CSGNewPasswordLabel3, "default-bold-small")
	CSGNewPasswordEdit2 = guiCreateEdit(116, 215, 246, 26, "", false, CSGNewPasswordWindow)
	guiEditSetMasked ( CSGNewPasswordEdit2, true )
	CSGNewPasswordButton = guiCreateButton(116, 256, 248, 24, "Update my password", false, CSGNewPasswordWindow)
	CSGNewPasswordLabel4 = guiCreateLabel(10, 117, 451, 15, "Choose 2 new safe passwords!", false, CSGNewPasswordWindow)
	guiLabelSetHorizontalAlign(CSGNewPasswordLabel4, "center", false)
	centerWindows ( CSGNewPasswordWindow )
	guiWindowSetMovable (CSGNewPasswordWindow, true)
	guiWindowSetSizable (CSGNewPasswordWindow, false)
	guiSetVisible (CSGNewPasswordWindow, false)
	
	--New instructions window
	instructionWindow = guiCreateWindow(547,320,571,371,"CSG ~ Resolution Change Tutorial",false)
		guiSetAlpha(instructionWindow,1)
		guiWindowSetMovable(instructionWindow,false)
		guiWindowSetSizable(instructionWindow,false)
	label1 = guiCreateLabel(88,133,382,24,"Sorry, but your resolution is below our minimum requirements!",false,instructionWindow)
		guiLabelSetColor(label1,255,0,0)
		guiLabelSetVerticalAlign(label1,"center")
		guiLabelSetHorizontalAlign(label1,"center",false)
		guiSetFont(label1,"default-bold-small")
	rX,rY = guiGetScreenSize() --define the player's screen size.
	label2 = guiCreateLabel(5,163,560,201,"At CSG, we require your resolution to be higher than 800 x 600. Yours is: "..rX.." x "..rY..".\nTo proceed to play at CSG, please follow these instructions to change your resolution\n\n\nStep 1: Press ESC and click \"Settings\" on MTA's main menu.\nStep 2: Click on the \"Video\" tab\nStep 3: Change your resolution to be anything above 800 x 600.\n\nOnce thats done, restart your MTA and rejoin to be able to get onto the server.\nThanks for reading, and sorry for this incident!\n\n\n~Community of Social Gaming~",false,instructionWindow)
		guiLabelSetHorizontalAlign(label2,"center",true)
	image = guiCreateStaticImage(207,20,142,116,"Files/disc-logo.png",false,instructionWindow)
	guiWindowSetMovable(instructionWindow,false)
	guiWindowSetSizable(instructionWindow,false)
	guiSetVisible(instructionWindow,false)
	centerWindows(instructionWindow)
	
	addEventHandler( "onClientGUIClick", CSGPasswordRequestButton, onClientPlayerPasswordRequest, false )
	addEventHandler( "onClientGUIClick", CSGRegisterCreateButton, onClientPlayerRegister, false )
	addEventHandler( "onClientGUIClick", CSGLoginJoinButton, onClientPlayerLogin, false )
	addEventHandler( "onClientGUIClick", CSGLoginCreateButton, showRegisterWindow, false )
	addEventHandler( "onClientGUIClick", CSGLoginPasswordButton, showPasswordWindow, false )
	addEventHandler( "onClientGUIClick", CSGRegisterReturnButton, showLoginWindow, false )
	addEventHandler( "onClientGUIClick", CSGPasswordCancelButton, showLoginWindow, false )
	addEventHandler( "onClientGUIClick", CSGRegisterPopupButton, showLoginWindow, false )
	addEventHandler( "onClientGUIClick", CSGNewPasswordButton, updatePlayerPasswords, false )
end

-- Create the GUI on connect or start
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function ()
		guiSetInputMode("no_binds_when_editing")
		createAccountingWindows()
		screenX, screenY = guiGetScreenSize()
		if ( screenX >= 800 ) and ( screenY >= 600 ) then
			triggerServerEvent( "doSpawnPlayer", localPlayer )
		else
			openInstructionsWindow() --open instructions window.
		end
	end
)

function openInstructionsWindow()
	guiSetVisible(instructionWindow,true)
	showCursor(true)
end

-- Effect when the player enters a button with the mouse
addEventHandler( "onClientMouseEnter", root, 
    function()
        if ( getElementType ( source ) == "gui-button" ) then
			guiSetProperty( source, "HoverTextColour", "FFEE9A00" )
		end
    end
)

addEventHandler( "onClientMouseLeave", root, 
    function()
        if ( getElementType ( source ) == "gui-button" ) then
			guiSetProperty( source, "HoverTextColour", "FFFFFFFF" )
		end
    end
)

-- Clear all fields
function clearEditFields ()
	guiSetText( CSGPasswordUsernameField, "" )
	guiSetText( CSGPasswordEmailField, "" )
	guiSetText( CSGRegisterUsernameField, "" )
	guiSetText( CSGRegisterPasswordField, "" )
	guiSetText( CSGRegisterPassword2Field, "" )
	guiSetText( CSGRegisterEmailField, "" )
end

-- Enable cursor
addEvent ( "setCursorEnabled", true )
function enableCursor ( state )
	if ( state ) then
		showCursor( true )
	else
		showCursor( false )
	end
end
addEventHandler( "setCursorEnabled", root, enableCursor )

-- Center the windows
function centerWindows ( theWindow )
	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(theWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(theWindow,x,y,false)
end

-- Set the login window visable
addEvent ( "setLoginWindowVisable", true )
function showLoginWindow ()
	guiSetVisible (CSGLoginWindow, true)
	guiSetVisible (CSGRegisterWindow, false)
	guiSetVisible (CSGPasswordWindow, false)
	guiSetVisible (CSGRegisterPopup, false)
	guiSetVisible (CSGNewPasswordWindow, false)
	clearEditFields ()
	enableCursor ( true )
end
addEventHandler( "setLoginWindowVisable", root, showLoginWindow )

-- Set the register window visable
addEvent ( "setRegisterWindowVisable", true )
function showRegisterWindow ()
	guiSetVisible (CSGLoginWindow, false)
	guiSetVisible (CSGRegisterWindow, true)
	guiSetVisible (CSGPasswordWindow, false)
	guiSetVisible (CSGRegisterPopup, false)
	guiSetVisible (CSGNewPasswordWindow, false)
	enableCursor ( true )
end
addEventHandler( "setRegisterWindowVisable", root, showRegisterWindow )

-- Set the password window visable
addEvent ( "setPasswordWindowVisable", true )
function showPasswordWindow ()
	guiSetVisible (CSGLoginWindow, false)
	guiSetVisible (CSGRegisterWindow, false)
	guiSetVisible (CSGPasswordWindow, true)
	guiSetVisible (CSGRegisterPopup, false)
	guiSetVisible (CSGNewPasswordWindow, false)
	enableCursor ( true )
end
addEventHandler( "setPasswordWindowVisable", root, showPasswordWindow )

-- Set the poup window visable
addEvent ( "setPopupWindowVisable", true )
function showPopupWindow ()
	guiSetVisible (CSGLoginWindow, false)
	guiSetVisible (CSGRegisterWindow, false)
	guiSetVisible (CSGPasswordWindow, false)
	guiSetVisible (CSGNewPasswordWindow, false)
	guiSetVisible (CSGRegisterPopup, true)
	enableCursor ( true )
end
addEventHandler( "setPopupWindowVisable", root, showPopupWindow )

-- Hide all windows
addEvent ( "setAllWindowsHided", true )
function hideAllWindows ()
	guiSetVisible (CSGLoginWindow, false)
	guiSetVisible (CSGRegisterWindow, false)
	guiSetVisible (CSGPasswordWindow, false)
	guiSetVisible (CSGRegisterPopup, false)
	guiSetVisible (CSGNewPasswordWindow, false)
	enableCursor ( false )
end
addEventHandler( "setAllWindowsHided", root, hideAllWindows )

-- Set the change password window visable
addEvent ( "setNewPasswordWindowVisable", true )
function showNewPasswordWindow ()
	guiSetVisible( CSGLoginWindow, false )
	guiSetVisible( CSGRegisterWindow, false )
	guiSetVisible( CSGPasswordWindow, false )
	guiSetVisible( CSGRegisterPopup, false )
	guiSetVisible( CSGNewPasswordWindow, true )
	enableCursor ( true )
end
addEventHandler( "setNewPasswordWindowVisable", root, showNewPasswordWindow )

-- Get all the fields from the login screen
function getLoginWindowData ()
	return guiGetText ( CSGLoginUsernameField ), guiGetText ( CSGLoginPasswordField ), guiCheckBoxGetSelected ( CSGLoginUsernameCheckbox ), guiCheckBoxGetSelected ( CSGLoginPasswordCheckbox )
end

-- Get all the fields from register window
function getRegisterWindowData ()
	local username = guiGetText ( CSGRegisterUsernameField )
	local password1 = guiGetText ( CSGRegisterPasswordField )
	local password2 = guiGetText ( CSGRegisterPassword2Field )
	local email = guiGetText ( CSGRegisterEmailField )
	local genderMale = guiRadioButtonGetSelected( CSGRegisterMaleGender )
	local genderFemale = guiRadioButtonGetSelected( CSGRegisterFemaleGender )
	return username, password1, password2, email, genderMale, genderFemale
end

-- Get all the data from the password request screen
function getPasswordWindowData ()
	return guiGetText ( CSGPasswordUsernameField ), guiGetText ( CSGPasswordEmailField )
end

-- Get all data rom the new password window
function getNewPasswordWindowData ()
	return guiGetText ( CSGNewPasswordEdit1 ), guiGetText ( CSGNewPasswordEdit2 )
end

-- Set the warning label data
addEvent ( "setWarningLabelText", true )
function setWarningLabelText ( theText, theType, r, g, b )
	if ( theType == "loginWindow" ) then
		guiSetText( CSGLoginLabel3, theText )
		if ( r ) and ( g ) and ( b ) then guiLabelSetColor( CSGLoginLabel3, r, g, b ) end
	elseif ( theType == "registerWindow" ) then
		guiSetText( CSGRegisterLabel3, theText )
		if ( r ) and ( g ) and ( b ) then guiLabelSetColor( CSGRegisterLabel3, r, g, b ) end
	elseif ( theType == "passwordWindow" ) then
		guiSetText( CSGPasswordLabel2, theText )
		if ( r ) and ( g ) and ( b ) then guiLabelSetColor( CSGPasswordLabel2, r, g, b ) end
	elseif ( theType == "newPasswordWindow" ) then
		guiSetText( CSGNewPasswordLabel4, theText )
		if ( r ) and ( g ) and ( b ) then guiLabelSetColor( CSGNewPasswordLabel4, r, g, b ) end
	end
end
addEventHandler( "setWarningLabelText", root, setWarningLabelText )