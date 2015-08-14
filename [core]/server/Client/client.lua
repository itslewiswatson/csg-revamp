-- Some drawing things
local screenX, screenY = guiGetScreenSize()
local scaleMain = 2
local scaleGeneral = 1.5
local startX, startY = 80.0, 98.0
local sizeHeight = 150

if ( screenX == 1024 ) then 	
	scaleMain = 1.5	
	scaleGeneral = 1 
	sizeHeight = 125
elseif ( screenX == 800 ) then
	scaleMain = 1.5
	scaleGeneral = 1
	sizeHeight = 100
	startY = 98		
elseif ( screenX == 600 ) then	
	scaleMain = 1.1
	scaleGeneral = 0.8	
	sizeHeight = 70		
end

-- When the player pressed login
function onClientPlayerLogin ()
	local username, password, usernameTick, passwordTick = getLoginWindowData()
	if ( username:match( "^%s*$" ) ) then
		setWarningLabelText ( "The accountname field is empty!", "loginWindow", 225, 0, 0 )
	elseif ( password:match( "^%s*$" ) ) then
		setWarningLabelText ( "The password field is empty!", "loginWindow", 225, 0, 0 )
	else
		setWarningLabelText ( "Attempting to login...", "loginWindow", 225, 165, 0 )
		triggerServerEvent( "doPlayerLogin", localPlayer, username, password, usernameTick, passwordTick )
	end
end

-- When the player pressed register
function onClientPlayerRegister ()
	local username, password1, password2, email, genderMale, genderFemale = getRegisterWindowData ()
	if ( username:match( "^%s*$" ) ) then
		setWarningLabelText ( "The accountname field is empty!", "registerWindow", 225, 0, 0 )
	elseif ( password1:match( "^%s*$" ) ) or ( password2:match( "^%s*$" ) ) then
		setWarningLabelText ( "The password field is empty!", "registerWindow", 225, 0, 0 )
	elseif ( password1 ~= password2 ) then
		setWarningLabelText ( "The passwords don't match!", "registerWindow", 225, 0, 0 )
	elseif ( string.len( password1 ) < 8 ) then
		setWarningLabelText ( "Your password is too short!", "registerWindow", 225, 0, 0 )
	elseif not ( genderMale ) and not ( genderFemale ) then
		setWarningLabelText ( "You didn't select a gender!", "registerWindow", 225, 0, 0 )
	elseif ( ( string.match( email, "^.+@.+%.%a%a%a*%.*%a*%a*%a*") ) ) then
		setWarningLabelText ( "Creating a new account...", "registerWindow", 225, 165, 0 )
		triggerServerEvent( "doAccountRegister", localPlayer, username, password1, password2, email, genderMale, genderFemale )
	else
		setWarningLabelText ( "You didn't enter a vaild email adress!", "registerWindow", 225, 0, 0 )
	end
end

-- When player requests a new password
function onClientPlayerPasswordRequest ()
	local username, email = getPasswordWindowData ()
	if ( email:match("^%s*$") ) then
		setWarningLabelText ( "You didn't enter a email adress!", "passwordWindow", 225, 0, 0 )
	elseif ( username:match("^%s*$") ) then
		setWarningLabelText ( "You didn't enter a accountname!", "passwordWindow", 225, 0, 0 )
	elseif not ( string.match(email, "^.+@.+%.%a%a%a*%.*%a*%a*%a*") )then
		setWarningLabelText ( "You didn't enter a vaild email adress!", "passwordWindow", 225, 0, 0 )
	else
		triggerServerEvent( "doPlayerPasswordReset", localPlayer, email, username, exports.server:randomString( 10 ) )
	end
end

-- Function to update the password
function updatePlayerPasswords ()
	local password1, password2 = getNewPasswordWindowData ()
	if ( password1:match( "^%s*$" ) ) or ( password2:match( "^%s*$" ) ) then
		setWarningLabelText ( "The password field is empty!", "newPasswordWindow", 225, 0, 0 )
	elseif ( password1 ~= password2 ) then
		setWarningLabelText ( "The passwords don't match!", "newPasswordWindow", 225, 0, 0 )
	elseif ( string.len( password1 ) < 8 ) then
		setWarningLabelText ( "Your password is too short!", "newPasswordWindow", 225, 0, 0 )
	elseif ( md5( password1 ) == getElementData( source, "temp:UsernameData" ) ) then
		setWarningLabelText ( "You can't use the same password as your current!", "newPasswordWindow", 225, 0, 0 )
	else
		setWarningLabelText ( "Updating password...", "newPasswordWindow", 225, 80, 0 )
		triggerServerEvent( "onPlayerUpdatePasswords", localPlayer, password1 )
	end
end

-- Convert a timeStamp to a date
function timestampConvert (timeStamp)
	local time = getRealTime(timeStamp)
	local year = time.year + 1900
	local month = time.month + 1
	local day = time.monthday
	local hour = time.hour
	local minute = time.minute

	return "" .. hour ..":" .. minute .." - " .. month .."/" .. day .."/" .. year ..""
end

-- Show the ban screen when trigger serverside
addEvent( "drawClientBanScreen", true )
addEventHandler( "drawClientBanScreen", root,
	function ( banSerial, banReason, banBantime, bannedby ) 
		TheBanSerial = banSerial
		TheBanReason = banReason
		TheBanBantime = timestampConvert( banBantime )
		TheBanBanner = bannedby
		addEventHandler("onClientRender", root, drawBanScreen )
		toggleAllControls(source,false,false,false,false)
	end
)

-- Draw the ban screen window
function drawBanScreen ()
	dxDrawText("This serial is banned from the server!",startX, startY,796.0,157,tocolor(200,0,0,230),scaleMain,"pricedown","left","top",false,false,false)
	dxDrawText("Reason: "..TheBanReason,startX,startY+(sizeHeight*1)+15,796.0,sizeHeight,tocolor(238,118,0,230),scaleGeneral,"pricedown","left","top",false,false,false)
	if(banBantime ~= 0) then
		dxDrawText("Banned till: "..TheBanBantime,startX,startY+(sizeHeight*2)+5,796.0,sizeHeight,tocolor(238,118,0,230),scaleGeneral,"pricedown","left","top",false,false,false)
	else
		dxDrawText("Permanently Banned",startX,startY+(sizeHeight*2)+5,796.0,sizeHeight,tocolor(238,118,0,230),scaleGeneral,"pricedown","left","top",false,false,false)
	end
	dxDrawText("Banned By: "..TheBanBanner ,startX,startY+(sizeHeight*3)+5,796.0,sizeHeight,tocolor(0,120,0,230),scaleGeneral,"pricedown","left","top",false,false,false)
	dxDrawText("Serial: "..TheBanSerial,startX,startY+(sizeHeight*4)+5,796.0,sizeHeight,tocolor(0,120,0,230),scaleGeneral,"pricedown","left","top",false,false,false)
end

-- Some data for the scoreboard
setTimer (
	function ()
		setElementData ( localPlayer, "WL", getPlayerWantedLevel( localPlayer ) )
		setElementData ( localPlayer, "Money", "$ "..exports.server:convertNumber( getPlayerMoney( localPlayer ) ) )
		setElementData ( localPlayer, "City", exports.server:getPlayChatZone() )	
	end, 1000, 0 
)

-- Event when the client player logged in
addEvent( "clientPlayerLogin", true )
addEventHandler( "clientPlayerLogin", root,
	function ( userid, username )
		triggerEvent( "onSetPlayerSettings", root, source )
		triggerEvent( "onClientPlayerLogin", root, source, userid, username )
	end
)

-- Playtime of a user
setTimer (
	function ()
		if ( getElementData ( localPlayer, "playTime" ) ) then
			local theTime = ( getElementData ( localPlayer, "playTime" ) + 5 )
			setElementData( localPlayer, "playTime", math.floor( theTime ) )
			setElementData( localPlayer, "Play Time", math.floor( theTime / 60 ).." Hours" )
		else
			setElementData( localPlayer, "playTime", 0 )
			setElementData( localPlayer, "Play Time", 0 )
		end
	end, 60000*5, 0 
)

-- When the player login set playtime
addEvent( "onClientPlayerLogin" )
addEventHandler( "onClientPlayerLogin", localPlayer,
	function ()
		if ( getElementData ( localPlayer, "playTime" ) ) then
			local theTime = ( getElementData ( localPlayer, "playTime" ) )
			setElementData( localPlayer, "Play Time", math.floor( theTime / 60 ).." Hours" )
		else
			setElementData( localPlayer, "playTime", 0 )
			setElementData( localPlayer, "Play Time", 0 )
		end
	end
)

-- Settings from the CSG Phone
addEventHandler( "onPlayerSettingChange", root,
	function ( theSetting, newValue, oldValue )
		if ( newValue ~= nil ) then
			if ( theSetting == "blur" ) then
				if ( newValue == true ) then
					setBlurLevel ( 36 )
				else
					setBlurLevel ( 0 )
				end
			elseif ( theSetting == "heathaze" ) then
				if ( newValue == true ) then
					setHeatHaze ( 100 )
				else
					setHeatHaze ( 0 )
				end
			elseif ( theSetting == "fpsmeter" ) then
				if ( newValue == true ) then
					drawStates(true)
				else
					drawStates(false)
				end
			elseif ( theSetting == "clouds" ) then
				setCloudsEnabled ( newValue )
			elseif ( theSetting == "chatbox" ) then
				showChat ( newValue )
			elseif ( theSetting == "sms" ) then
				setElementData( localPlayer, "SMSoutput", newValue )
			elseif ( theSetting == "shaders" ) then
				triggerEvent( "onClientSwitchDetail", localPlayer, newValue )
			elseif ( theSetting == "speedmeter" ) then
				triggerEvent( "onClientSwitchSpeedMeter", localPlayer, newValue )
			elseif ( theSetting == "damagemeter" ) then
				triggerEvent( "onClientSwitchDamageMeter", localPlayer, newValue )
			elseif ( theSetting == "fuelmeter" ) then
				triggerEvent( "onClientSwitchFuelMeter", localPlayer, newValue )
			elseif ( theSetting == "groupblips" ) then
				triggerEvent( "onClientSwitchGroupBlips", localPlayer, newValue )
			elseif ( theSetting == "grouptags" ) then
				triggerEvent( "onClientSwitchGroupTags", localPlayer, newValue )
			end
		end
	end
)

-- FPS drawing
local x, y = guiGetScreenSize ( )
r,g,b=0,212,14
alpha=150

local root = getRootElement()
local player = localPlayer
--local ping = getPlayerPing(player)
local counter = 0
local starttick
local currenttick
local toggle = false
--FPS Counter, this runs in the background even if its enabled / disabled.
addEventHandler("onClientRender",root,
	function ()
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			setElementData(player, "FPS", counter - 1)
			counter = 0
			starttick = false
		end
	end
)

function collectPing()
	local ping = setElementData(localPlayer, "Ping", getPlayerPing(localPlayer))
end
setTimer(collectPing, 1000, 0)

function drawStates ()
    addEventHandler("onClientRender", root, pingState)
	addEventHandler("onClientRender", root, fpsState)
end
addEventHandler("onClientResourceStart", resourceRoot, drawStates)

function pingState()
    posx= x-30
    posy= 20

    dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r, g, b, alpha ) )
    dxDrawRectangle ( posx+5, posy-4, 4,8, tocolor ( r, g, b, alpha ) )
    dxDrawRectangle ( posx+10, posy-8, 4,12, tocolor ( r, g, b, alpha ) )
    dxDrawRectangle ( posx+15, posy-12, 4,16, tocolor ( r, g, b, alpha ) )
    dxDrawRectangle ( posx+20, posy-16, 4,20, tocolor ( r, g, b, alpha ) )

    r2,g2,b2=0,212,14
    r3,g3,b3=0,212,14
    r4,g4,b4=255,99,71
    r5,g5,b5=255,165,0
    alpha2=255
    
	local ping = getPlayerPing(localPlayer)
	if (ping <= 100) then
		dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r2, g2, b2, alpha2 ) )
		dxDrawRectangle ( posx+5, posy-4, 4,8, tocolor ( r2, g2, b2, alpha2 ) )
		dxDrawRectangle ( posx+10, posy-8, 4,12, tocolor ( r2, g2, b2, alpha2 ) )
		dxDrawRectangle ( posx+15, posy-12, 4,16, tocolor ( r2, g2, b2, alpha2 ) )
		dxDrawRectangle ( posx+20, posy-16, 4,20, tocolor ( r2, g2, b2, alpha2 ) )

	elseif (ping > 101) and (ping <= 200) then
		dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r2, g2, b2, alpha2 ) )
		dxDrawRectangle ( posx+5, posy-4, 4,8, tocolor ( r2, g2, b2, alpha2 ) )
		dxDrawRectangle ( posx+10, posy-8, 4,12, tocolor ( r2, g2, b2, alpha2 ) )
		dxDrawRectangle ( posx+15, posy-12, 4,16, tocolor ( r2, g2, b2, alpha2 ) )

	elseif (ping > 201) and (ping <= 300) then
		dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r3, g3, b3, alpha2 ) )
		dxDrawRectangle ( posx+5, posy-4, 4,8, tocolor ( r3, g3, b3, alpha2 ) )
		dxDrawRectangle ( posx+10, posy-8, 4,12, tocolor ( r3, g3, b3, alpha2 ) )

	elseif (ping >= 301) and (ping <= 400) then
		dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r4, g4, b4, alpha2 ) )
		dxDrawRectangle ( posx+5, posy-4, 4,8, tocolor ( r4, g4, b4, alpha2 ) )

	elseif (ping > 401) then
		dxDrawRectangle ( posx, posy, 4, 4, tocolor ( r5,g5,b5, alpha2 ) )

	end
end

function fpsState()
    posx2= x-55
    posy2= 13
	
	if getElementData(localPlayer,"FPS") and ( getElementData(localPlayer,"FPS") <= 15 ) then
		local r,g,b = 255,0,0
	else
		local r,g,b = 0,212,14
	end
    dxDrawText ( getElementData(localPlayer,"FPS"), posx2-12, posy2-6, x, y, tocolor ( r,g,b, 255 ), 1.4, "default-bold" )

    dxDrawText ( "FPS", posx2-13, posy2+10, x, y, tocolor ( r,g,b, 255 ), 1.0, "default-bold" )
    dxDrawText ( "PING", posx2+23, posy2+10, x, y, tocolor ( 19,166,50, 255 ), 1.0, "default-bold" )
end
