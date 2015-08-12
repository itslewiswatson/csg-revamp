addEvent ( "onPlayerSettingChange", true )

local theFile = xmlLoadFile ( "settings.xml" )
if not ( theFile ) then
	theFile = xmlCreateFile( "settings.xml","settings" )
	xmlSaveFile( theFile )
end


function getPlayerSetting ( theSetting )
	local theNode = xmlFindChild( theFile, tostring( theSetting ), 0 )
	if ( theNode ) and ( theFile ) then
		local theNodeValue = xmlNodeGetValue ( theNode )
		if ( theNodeValue ) then
			if ( theNodeValue == "true" ) then
				return true
			elseif ( theNodeValue == "false" ) then
				return false
			else
				return theNodeValue
			end
		else
			return false
		end
	else
		return false
	end
end

function setPlayerSetting ( theSetting, value )
	local oldValue = getPlayerSetting ( theSetting )
	local theNode = xmlFindChild( theFile, tostring( theSetting ), 0 )
		outputDebugString('attempt to set setting')
	if ( theNode ) and ( value ) and ( theFile ) then
		xmlNodeSetValue( theNode, tostring( value ) )
		outputDebugString ( "Player setting edited (Setting: ".. tostring(theSetting) ..") (Value: ".. tostring(value) ..")", 3 )
		triggerEvent ( "onPlayerSettingChange", localPlayer, theSetting, getPlayerSetting ( theSetting ), oldValue )
		outputDebugString("trigered")
		xmlSaveFile( theFile )
		return true
	else
		addPlayerSetting ( theSetting, value )
		outputDebugString ( "Player setting edited ( added first ) (Setting: ".. tostring(theSetting) ..") (Value: ".. tostring(value) ..")", 3 )
		return true
	end

end

function addPlayerSetting ( theSetting, value )
	if ( theSetting ) and ( value ) and ( theFile ) then
		local theNode = xmlFindChild( theFile, tostring( theSetting ), 0 )
		if ( theNode ) then
			return false
		else
			xmlNodeSetValue( xmlCreateChild( theFile, tostring( theSetting ) ), tostring ( value ) )
			outputDebugString ( "Player setting added (Setting: ".. tostring(theSetting) ..") (Value: ".. tostring(value) ..")", 3 )
			xmlSaveFile( theFile )
			return true
		end
	else
		return false
	end
end
