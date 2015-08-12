local radio = false

function RadioOn()
	local vehicle = getPedOccupiedVehicle( getLocalPlayer() )
	local id = getVehicleID(vehicle)
	if (id == 497 or id == 597 or id == 598 or id == 599 or id == 490 or id == 427 or id == 433 or id == 528 or id == 601 or id == 523 or id == 426 or id == 415) then
		exports.dendxmsg:createNewDxMessage ("Connection with Polce Department Approved - Use /ron and /roff for CSG Police Radio", 0,50,255)
		setRadioChannel(0)
		--if isElement(radio) then stopSound(radio) end
		--radio = playSound( "http://www.radioreference.com/scripts/playlists/1/1189/0-5307950048.m3u" )
	end

end
addEventHandler("onClientPlayerVehicleEnter",getLocalPlayer(), RadioOn)

function turnRadioOff()
	if radio then
		stopSound( radio )
		exports.dendxmsg:createNewDxMessage ("Connection with Polce Department has been turned OFF", 0,50,255)
	end
end
addCommandHandler ( "roff", turnRadioOff )
addEventHandler("onClientPlayerVehicleExit",getLocalPlayer(),turnRadioOff)
addEventHandler("onClientPlayerWasted",getLocalPlayer(),turnRadioOff)

function turnRadioOn()
	 if isElement(radio) then stopSound(radio) end
	setRadioChannel(0)
		radio = playSound( "http://www.radioreference.com/scripts/playlists/1/1189/0-5307950048.m3u" )
	exports.dendxmsg:createNewDxMessage ("Connection with Polce Department has been turned ON", 0,50,255)

end
addCommandHandler ( "ron", turnRadioOn )
