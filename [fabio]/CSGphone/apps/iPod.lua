local ipodGUI = {}
local volume = nil
local soundURL = nil
local showStartSong = false
local updateStations = true
local iPodSound=false
exports.DENsettings:addPlayerSetting( "iPodTitle", "true" )

local iPodRadio = {
	["Pop/Top 40"] =  {
		{"CSG Radio", "http://188.165.208.28:8000"},
		{"Power 181 Hitradio", "http://www.181.fm/asx.php?station=181-power&style=&description=Power 181 (Top 40)"},
	},

	["Dance/Trance and Techno"] =  {
		{"Energy 93", "http://www.181.fm/asx.php?station=181-energy93&style=&description="},
		{"Club Techno", "http://www.181.fm/asx.php?station=181-technoclub&style=&description="},
		{"Energy 98", "http://www.181.fm/asx.php?station=181-energy98&style=&description="},
		{"DI Dance", "http://listen.di.fm/public3/club.pls"},
	},

	["Hardstyle/Hardcore"] =  {

	},

	["Rock/Hardrock"] =  {

	},

	["HipHop and R&B"] =  {
		{"Olschool HipHop/RnB", "http://www.181.fm/asx.php?station=181-oldschool&style=&description="},
	},

	["80's and 90's"] =  {
		{"Awesome 80's", "http://www.181.fm/asx.php?station=181-awesome80s&style=&description=Awesome 80's"},
	},

	["Soul"] =  {

	},

	["Others"] =  {
		{"Apres SKI", "http://82.201.100.10:8000/WEB16.m3u"},
		{"Party Radio 181", "http://www.181.fm/asx.php?station=181-party&style=&description="},
		{"The Heart Radio", "http://www.181.fm/asx.php?station=181-heart&style=&description=The Heart (Love Songs)"},
	},
}


function openiPod()
	if not ipodGUI[1] then ipodGUI[1] = guiCreateGridList ( BGX, BGY, 0.99770569801331*BGWidth, 0.77*BGHeight, false ) end
	if not ipodGUI[2] then ipodGUI[2] = guiCreateButton ( BGX+(BGWidth*0.65), BGY+(0.930*BGHeight), 0.35*BGWidth, 0.068*BGHeight, "Stop", false ) end
	if not ipodGUI[3] then ipodGUI[3] = guiCreateButton ( BGX+(BGWidth*0.30), BGY+(0.930*BGHeight), 0.35*BGWidth, 0.068*BGHeight, "Play", false ) end
	if not ipodGUI[4] then ipodGUI[4] = guiCreateButton ( BGX+(BGWidth*0.0), BGY+(0.930*BGHeight), 0.15*BGWidth, 0.068*BGHeight, "+", false ) end
	if not ipodGUI[5] then ipodGUI[5] = guiCreateButton ( BGX+(BGWidth*0.15), BGY+(0.930*BGHeight), 0.15*BGWidth, 0.068*BGHeight, "-", false ) end
	if not ipodGUI[6] then ipodGUI[6] = guiCreateLabel ( BGX, BGY+(0.85*BGHeight), BGWidth, 0.048*BGHeight,"Radio volume: 50%", false) end
	if not ipodGUI[7] then ipodGUI[7] = guiGridListAddColumn ( ipodGUI[1], "  Station name:", 0.9 ) end
	if not ipodGUI[8] then ipodGUI[8] = guiCreateCheckBox ( BGX, BGY+(0.78*BGHeight), BGWidth, 0.058*BGHeight, "Show song title when song changes", false, false ) end

	for i=1, #ipodGUI do
		if i ~= 7 then
			guiSetVisible ( ipodGUI[i], true )
			guiSetProperty ( ipodGUI[i], "AlwaysOnTop", "True" )
		end
	end

	guiCheckBoxSetSelected( ipodGUI[8], exports.DENsettings:getPlayerSetting ( "iPodTitle" ) )

	guiLabelSetHorizontalAlign ( ipodGUI[6], "center" )
	loadRadioStations()

	addEventHandler ( "onClientGUIClick", ipodGUI[3], onStartMusic )
	addEventHandler ( "onClientGUIClick", ipodGUI[2], onStopMusic )
	addEventHandler ( "onClientGUIClick", ipodGUI[4], onAddVolume )
	addEventHandler ( "onClientGUIClick", ipodGUI[5], onLowerVolume )
	addEventHandler ( "onClientGUIClick", ipodGUI[8], onShowSongTitleSetting )

	apps[3][7] = true

end
apps[3][8] = openiPod

function loadRadioStations ()
	guiGridListClear(ipodGUI[1])
	for theName, theCategory in pairs( iPodRadio ) do
		local row = guiGridListAddRow( ipodGUI[1] )
		guiGridListSetItemText( ipodGUI[1], row, 1, theName, true, false )

		for theIndex, theStation in pairs( theCategory ) do
			local row = guiGridListAddRow( ipodGUI[1] )
			guiGridListSetItemText( ipodGUI[1], row, 1, theStation[1], false, false )
			guiGridListSetItemData ( ipodGUI[1], row, 1, theStation[2] )
		end
	end
	if ( iPodSound ) and (  volume ) then guiSetText ( ipodGUI[6], "Radio volume: " .. math.floor((volume/1*100)) .. "%" ) end
end

function closeiPod()

	removeEventHandler ( "onClientGUIClick", ipodGUI[3], onStartMusic )
	removeEventHandler ( "onClientGUIClick", ipodGUI[2], onStopMusic )
	removeEventHandler ( "onClientGUIClick", ipodGUI[4], onAddVolume )
	removeEventHandler ( "onClientGUIClick", ipodGUI[5], onLowerVolume )
	removeEventHandler ( "onClientGUIClick", ipodGUI[8], onShowSongTitleSetting )

	for i=1,#ipodGUI do
		if i ~= 7 then
			guiSetVisible ( ipodGUI[i], false )
			guiSetProperty ( ipodGUI[i], "AlwaysOnTop", "False" )
		end
	end

	apps[3][7] = false

end
apps[3][9] = closeiPod

function onStartMusic ()
	local row, column = guiGridListGetSelectedItem ( ipodGUI[1] )
	if ( row ) then
		if ( iPodSound ) then stopSound( iPodSound ) end
		local stationURL = guiGridListGetItemData( ipodGUI[1], row, column )
		iPodSound = playSound( stationURL )
		soundURL = stationURL
		if ( volume ) then setSoundVolume(iPodSound, volume) else setSoundVolume(iPodSound, 0.5) end

		showStartSong = true
	end
end

function onStopMusic ()
	if ( iPodSound ) then
		stopSound( iPodSound )
		soundURL = nil
	end
end

function onAddVolume ()
	if ( iPodSound ) then
		if ( tonumber( string.format( "%.1f", getSoundVolume ( iPodSound ) +0.1 ) ) <= 1 ) then
			volume = tonumber( string.format( "%.1f", getSoundVolume ( iPodSound ) +0.1 ) )
			setSoundVolume(iPodSound, volume )
			guiSetText ( ipodGUI[6], "iPod volume: " .. math.floor((volume/1*100)) .. "%" )
		end
	end
end

function onLowerVolume ()
	if ( iPodSound ) then
		if ( tonumber( string.format( "%.1f", getSoundVolume ( iPodSound ) -0.1 ) ) >= 0 ) then
			volume = tonumber( string.format( "%.1f", getSoundVolume ( iPodSound ) -0.1 ) )
			setSoundVolume(iPodSound, volume )
			guiSetText ( ipodGUI[6], "iPod volume: " .. math.floor((volume/1*100)) .. "%" )
		end
	end
end

function onShowSongTitleSetting ()
	if ( source == ipodGUI[8] ) then
		exports.DENsettings:setPlayerSetting( "iPodTitle", tostring( guiCheckBoxGetSelected( ipodGUI[8] ) ) )
	end
end

addEventHandler( "onClientSoundChangedMeta", root,
	function( theStream )
		if ( iPodSound ) and ( exports.DENsettings:getPlayerSetting ( "iPodTitle" ) ) and ( iPodSound == source ) then
			local aTable = getSoundMetaTags ( source )
			if ( tostring( aTable.stream_title ) ~= "nil" ) then exports.DENdxmsg:createNewDxMessage( "iPod current song: " .. tostring( aTable.stream_title ) .."", 0, 225, 0 ) end
		end
	end
)

addEventHandler( "onClientSoundStream", root,
	function( state, length, theStream )
		if ( state ) and ( exports.DENsettings:getPlayerSetting ( "iPodTitle" ) ) and ( iPodSound ) and ( showStartSong ) then
			local aTable = getSoundMetaTags ( iPodSound )
			if ( tostring( aTable.stream_title ) ~= "nil" ) then exports.DENdxmsg:createNewDxMessage( "iPod current song: " .. tostring( aTable.stream_title ) .."", 0, 225, 0 ) end
			showStartSong = false
		end
	end
)
