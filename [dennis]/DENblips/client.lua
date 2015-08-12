-- Tables
local groupBlips = {}
local allianceBlips = {}
local playerBlips = {}

-- Stuff that handles the group blips and tags
local enableGroupTags = false
local enableGroupBlips = true
local enableAllianceBlips = exports.densettings:getPlayerSetting("allianceblips")

addEvent( "onClientSwitchGroupBlips" )
addEventHandler( "onClientSwitchGroupBlips", localPlayer,
	function ( state )
		enableGroupBlips = state
	end
)

addEvent( "onClientSwitchGroupTags" )
addEventHandler( "onClientSwitchGroupTags", localPlayer,
	function ( state )
		enableGroupTags = state
	end
)

-- Create a blip for whenever a player joins
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource() ),
	function ()
		for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
			if not ( playerBlips[thePlayer] ) then
				playerBlips[thePlayer] = createBlipAttachedTo( thePlayer, 0, 2, 0, 0, 0, 500 )
				setBlipVisibleDistance( playerBlips[thePlayer], 99999999 )
			end
		end
	end
)

addEventHandler( "onClientPlayerJoin", root,
	function()
		if not ( playerBlips[source] ) then
			playerBlips[source] = createBlipAttachedTo( source, 0, 2, 0, 0, 0, 500 )
			setBlipVisibleDistance( playerBlips[source], 99999999 )
		end
	end
)

addEvent("onPlayerSettingChange",true)
addEventHandler("onPlayerSettingChange",localPlayer,function(s,v)
	if s == "radar" and v == false then
		for k,v in pairs(playerBlips) do
			setBlipVisibleDistance( v, 500 )
		end
	elseif s == "radar" and v == true then
		for k,v in pairs(playerBlips) do
			setBlipVisibleDistance( v, 99999999 )
		end
	elseif s == "allianceblips" then
		enableAllianceBlips = v
		onAllianceBlipsSettingChange()
	end
end)

function onAllianceBlipsSettingChange()
	local myAlliance = getElementData(localPlayer,"alliance")
	if myAlliance then
		exports.csggroups:alliances_getAllianceSettings(myAlliance)
	end
	outputDebugString("onAllianceBlipsSettingChange:enableAllianceBlips: "..tostring(enableAllianceBlips))
end
addEvent("alliances_receiveAllianceSettings",true)
function receiveAllianceSettings(settings)
	if settings.forceBlips then
		enableAllianceBlips = true
		outputDebugString("receiveAllianceSettings:enableAllianceBlips: "..tostring(enableAllianceBlips))
	end
end
addEventHandler("alliances_receiveAllianceSettings",root,receiveAllianceSettings)
onAllianceBlipsSettingChange()

local custom = {
	--r,g,b,team,skin
	["The Smurfs"] = {142,56,142,"Criminals",261}
}

-- The actual blip stuff
addEventHandler( "onClientRender", root,
	function ()
		local myGroup = getElementData(localPlayer,"Group")
		local myAlliance = getElementData(localPlayer,"alliance")
		for thePlayer, theBlip in pairs( playerBlips ) do
			if ( isElement( thePlayer ) ) and ( thePlayer ~= localPlayer ) then
				if ( getPlayerTeam( thePlayer ) ) then
					local theirGroup = getElementData(thePlayer,"Group")
					local r,g,b = getPlayerNametagColor(thePlayer)
					setBlipColor(theBlip,r,g,b,255)
					--[[if (custom[myGroup]) then
						if getTeamName(getPlayerTeam(localPlayer)) == custom[myGroup][4] and getElementModel(localPlayer) == custom[myGroup][5] then
							setBlipColor(theBlip,139,0,139)
						end
					end--]]
					local theirAlliance = getElementData(thePlayer,"alliance")
					if ( enableGroupBlips ) then
						if ( myGroup ) and ( theirGroup ) then
							if ( myGroup == theirGroup ) then
								if not ( groupBlips[thePlayer] ) then
									groupBlips[thePlayer] = createBlipAttachedTo ( thePlayer, 60, 0, 0, 0, 0, 0, 0, 500 )
									setBlipVisibleDistance( groupBlips[thePlayer], 99999999 )
								end
							end
						end
					else
						if ( isElement( groupBlips[thePlayer] ) ) then
							destroyElement( groupBlips[thePlayer] )
							groupBlips[thePlayer] = nil
						end
					end
					local shouldHaveAllianceBlip = false
					if ( enableAllianceBlips ) then
						if ( myGroup ) and ( theirGroup ) then
							if ( myGroup ~= theirGroup ) then
								if ( myAlliance and theirAlliance ) and ( myAlliance == theirAlliance ) then
									shouldHaveAllianceBlip = true
									if not ( allianceBlips[thePlayer] ) then
										allianceBlips[thePlayer] = createBlipAttachedTo ( thePlayer, 62, 0, 0, 0, 0, 0, 0, 500 )
										setBlipVisibleDistance( allianceBlips[thePlayer], 99999999 )
									end
								end
							end
						end
					end
					if not ( shouldHaveAllianceBlip ) or not ( enableAllianceBlips ) then
						if ( isElement( allianceBlips[thePlayer] ) ) then
							destroyElement( allianceBlips[thePlayer] )
							allianceBlips[thePlayer] = nil
						end
					end
		--			outputDebugString("shouldHaveAllianceBlip: "..tostring(shouldHaveAllianceBlip))

					if ( enableGroupTags ) then
						if ( getElementData( localPlayer, "Group" ) ) and ( getElementData( thePlayer, "Group" ) ) then
							if ( getElementData( localPlayer, "Group" ) == getElementData( thePlayer, "Group" ) ) then
								setPlayerNametagColor ( thePlayer, 142, 56, 142 )
							end
						end
					else
						if getPlayerNametagColor(thePlayer) ~= 139 then
							setPlayerNametagColor ( thePlayer, false )
						end
					end

					if ( getElementAlpha( thePlayer ) == 0 ) then
						setBlipColor( theBlip, 225, 225, 225, 0 )
						if ( isElement( groupBlips[thePlayer] ) ) then
							destroyElement( groupBlips[thePlayer] )
							groupBlips[thePlayer] = nil
						end
					else
						local R, G, B = getTeamColor( getPlayerTeam( thePlayer ) )
						setBlipColor( theBlip, R, G, B, 225 )
					end
				end
			end
		end
	end
)

addEventHandler("onClientPlayerQuit",root,
	function ()
		if ( isElement( groupBlips[source] ) ) then
			destroyElement( groupBlips[source] )
			groupBlips[source] = nil
		end
		if ( isElement( allianceBlips[source] ) ) then
			destroyElement( allianceBlips[source] )
			allianceBlips[source] = nil
		end
		if ( isElement( playerBlips[source] ) ) then
			destroyElement( playerBlips[source] )
			playerBlips[source] = nil
		end
	end
)

addEvent( "deleteGroupBlip", true )
addEventHandler( "deleteGroupBlip", root,
	function ( thePlayer )
		if ( isElement( groupBlips[thePlayer] ) ) then
			destroyElement( groupBlips[thePlayer] )
			groupBlips[thePlayer] = nil
		end
	end
)


