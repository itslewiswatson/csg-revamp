local jailPoints = {
{1535.93, -1670.89, 13, "LS1"},
{638.95, -571.69, 15.81, "LS2"},
{-2166.05, -2390.38, 30.04, "LS3"},
{-1606.34, 724.44, 11.53, "SF1"},
{-1402.04, 2637.7, 55.25, "SF2"},
{2290.46, 2416.55, 10.3, "LV1"},
{-208.63, 978.9, 18.73, "LV2"}
}
--[[
GUIEditor = {
    button = {},
    label = {},
    window = {},
}
GUIEditor.window[1] = guiCreateWindow(464, 235, 420, 214, "CSG ~ Jail", false)
guiWindowSetSizable(GUIEditor.window[1], false)

GUIEditor.label[1] = guiCreateLabel(10, 29, 405, 33, "Your arrested person(s) are authorized to be taken to CSG's federal prison. You have 2 options as the jailer of these felons.", false, GUIEditor.window[1])
guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
GUIEditor.button[1] = guiCreateButton(9, 72, 164, 32, "1) Accept offer", false, GUIEditor.window[1])
GUIEditor.button[2] = guiCreateButton(9, 111, 164, 32, "2) Deny offer", false, GUIEditor.window[1])
GUIEditor.label[2] = guiCreateLabel(181, 73, 245, 29, "Transport these criminals to the federal prison for 35% bonus. 3 Minutes Max.", false, GUIEditor.window[1])
guiLabelSetHorizontalAlign(GUIEditor.label[2], "left", true)
GUIEditor.label[3] = guiCreateLabel(181, 108, 245, 45, "Let them be transported by the government instead. Get paid the regular salary.", false, GUIEditor.window[1])
guiLabelSetHorizontalAlign(GUIEditor.label[3], "left", true)
GUIEditor.label[4] = guiCreateLabel(8, 151, 418, 20, "-----------------------------------------------------------------------------------------------------------------", false, GUIEditor.window[1])
GUIEditor.label[5] = guiCreateLabel(9, 174, 415, 56, "> If you accept and do not transport them in 3 minutes, they will be transferred automatically and you will not be paid.", false, GUIEditor.window[1])
guiLabelSetHorizontalAlign(GUIEditor.label[5], "left", true)

pos to be transported to  884.56, -2566.88, 23.16

--]]

local theColBlips = {}

function onColJailMakrerHit ( thePlayer )
	if getElementData ( thePlayer, "isPlayerArrested" ) then
		local theJailPoint = getElementData ( source, "jailPoint" )
		local theOfficer = getElementData ( thePlayer, "arrestedBy" )
		triggerServerEvent ( "onJailArrestedPlayers", theOfficer, theJailPoint, localPlayer )
	end
end

for ID in pairs(jailPoints) do
	local x, y, z = jailPoints[ID][1], jailPoints[ID][2], jailPoints[ID][3]
	local jailPoint = jailPoints[ID][4]
	theColShape = createColSphere ( x, y, z, 6 )
	setElementData ( theColShape, "jailPoint", jailPoint )
	addEventHandler ( "onClientColShapeHit", theColShape, onColJailMakrerHit)
end

addEvent("onCreateJailPoints", true)
function onCreateJailPoints ()
	onRemoveJailPoints ()
	for i=1,7 do
		local x, y, z = jailPoints[i][1], jailPoints[i][2], jailPoints[i][3]
		theColBlips[i] = createBlip ( x, y, z, 30, 3, 0, 0, 255, 255, 50 )
	end
end
addEventHandler("onCreateJailPoints", root, onCreateJailPoints)

addEvent("onPlayerSetArrested", true)
function onPlayerSetArrested ()
	triggerEvent( "onPlayerArrest", localPlayer )
end
addEventHandler("onPlayerSetArrested", root, onPlayerSetArrested)

addEvent("onRemoveJailPoints", true)
function onRemoveJailPoints ()
	for i=1,7 do
		if ( theColBlips[i] ) then
			destroyElement(theColBlips[i])
		end
	end
	theColBlips = {}
end
addEventHandler("onRemoveJailPoints", root, onRemoveJailPoints)

local officer = false
local arrestedPerson=false
-- When the player got arrested make him follow the cop
addEvent("onClientFollowTheCop", true)
function onClientFollowTheCop ( cop, pri )
	officer=cop
	arrestedPerson=source or pri
	follow()
end
addEventHandler("onClientFollowTheCop", root, onClientFollowTheCop)

function follow()
	if ( officer ) then
		local prisoner = arrestedPerson
		local officerX, officerY, officerZ = getElementPosition ( officer )
		local prisonerX, prisonerY, prisonerZ = getElementPosition ( prisoner )
		local distance = getDistanceBetweenPoints3D ( officerX, officerY, officerZ, prisonerX, prisonerY, prisonerZ )
		if ( getElementData ( prisoner, "isPlayerArrested" ) ) then
			local officerRotation = ( 360 - math.deg ( math.atan2 ( ( officerX - prisonerX ), ( officerY - prisonerY ) ) ) ) % 360
			setPedRotation ( prisoner, officerRotation )

			if ( getElementDimension( prisoner ) ~= getElementDimension( officer ) ) then
				exports.server:setClientPlayerDimension( prisoner, getElementDimension( officer ) )
			end

			if ( getElementInterior( prisoner ) ~= getElementInterior( officer ) ) then
				exports.server:setClientPlayerInterior( prisoner, getElementInterior( officer ) )
			end

			if ( distance > 9 ) and ( isPedInVehicle ( officer ) ) and not ( isPedInVehicle ( prisoner ) ) then
				triggerServerEvent( "onReleasePlayerFromArrest", prisoner, officer )
				setControlState ( "sprint", true )
				setControlState ( "walk", false )
				setControlState ( "forwards", true )
				setControlState ( "jump", true )
			elseif ( distance > 15 ) then
				setControlState ( "sprint", true )
				setControlState ( "walk", false )
				setControlState ( "forwards", true )
				setControlState ( "jump", true )
				setElementPosition (prisoner, officerX + 1, officerY + 1, officerZ)
				setTimer ( follow, 500, 1, officer, prisoner )
			elseif ( distance > 9 ) then
				setControlState ( "sprint", true )
				setControlState ( "walk", false )
				setControlState ( "forwards", true )
				setTimer ( follow, 500, 1, officer, prisoner )
			elseif ( distance > 6 ) then
				setControlState ( "sprint", false )
				setControlState ( "walk", false )
				setControlState ( "forwards", true )
				setTimer ( follow, 500, 1, officer, prisoner )
			elseif ( distance > 1.5 ) then
				setControlState ( "sprint", false )
				setControlState ( "walk", true )
				setControlState ( "forwards", true )
				setTimer ( follow, 500, 1, officer, prisoner )
			elseif ( distance < 1.5 ) then
				setControlState ( "sprint", false )
				setControlState ( "walk", false )
				setControlState ( "forwards", false )
				setTimer ( follow, 500, 1, officer, prisoner )
			end

			if ( isControlEnabled ( "fire" ) ) then
				toggleAllControls ( false, true, false )
			end

			if not ( isPedInVehicle ( prisoner ) ) then
				setCameraTarget ( prisoner, prisoner )
			end

			if ( isPedInVehicle ( officer ) ) then
				if not ( isPedInVehicle( prisoner ) ) then
					triggerServerEvent("warpPrisonerIntoVehicle", prisoner, officer)
				end
			end

			if ( isPedInVehicle ( prisoner ) ) and not ( isPedInVehicle( officer ) ) then
				triggerServerEvent("removePrisonerOutVehicle", prisoner, officer)
			end
		end
	end
end
-- The tazer script with checks
local tazerTable = {}

addEventHandler("onClientPlayerDamage", root,
function( attacker, weapon, bodypart )
	if ( isElement( attacker ) ) and ( source == localPlayer) then
		if ( weapon == 23 ) and ( getPlayerTeam( attacker ) ) and not ( getTeamName( getPlayerTeam( attacker ) ) == "Staff" ) then
			if ( getElementData( source, "wantedPoints" ) >= 10 ) then
				if ( canCopTazer ( attacker, source ) ) then
					if not ( getElementData ( source, "isPlayerArrested" ) ) then
						if not ( getElementData ( source, "isPlayerRobbing" ) ) or not ( getElementData ( source, "robberyFinished" ) ) then
							if not ( getElementData ( source, "isPlayerRobbing" ) ) and not ( getElementDimension( source ) == 1 ) or not ( getElementDimension( source ) == 2 ) or not ( getElementDimension( source ) == 3 ) then
								local ax, ay, az = getElementPosition( attacker )
								local bx, by, bz = getElementPosition( source )
								if ( tazerTable[attacker] ) and ( getTickCount()-tazerTable[attacker] < 1500 ) or ( math.floor ( getDistanceBetweenPoints2D( ax, ay, bx, by ) ) > 14 ) then
								--if ( math.floor ( getDistanceBetweenPoints2D( ax, ay, bx, by ) ) > 14 ) then

									cancelEvent()
								elseif ( getElementData( attacker, "Occupation" ) == "K-9 Unit Officer" ) then
									cancelEvent()
									tazerTable[attacker] = getTickCount()
									triggerServerEvent( "onWantedPlayerGotTazerd", attacker, source, true )
								else
									cancelEvent()
									tazerTable[attacker] = getTickCount()
									triggerServerEvent( "onWantedPlayerGotTazerd", attacker, source )
								end
							end
						end
					end
				end
			end
		end
	end
end
)

-- Check if tazer is allowed
function canCopTazer ( officer, thePrisoner )
	if ( thePrisoner ) and ( officer ) and ( officer ~= thePrisoner ) and ( getTeamName( getPlayerTeam( officer ) ) ) and ( getTeamName( getPlayerTeam( thePrisoner ) ) ) then
		local attackerTeam = (getTeamName(getPlayerTeam(officer)))
		local sourceTeam = (getTeamName(getPlayerTeam(thePrisoner)))
		if getElementData ( thePrisoner, "isPlayerArrested" ) then
			return false
		elseif getElementData ( thePrisoner, "isPlayerJailed" ) then
			return false
		elseif ( getElementData ( thePrisoner, "isPlayerRobbing" ) ) or ( getElementData ( thePrisoner, "robberyFinished" ) ) then
			return false
		elseif ( attackerTeam == "Police" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) or ( sourceTeam == "Police" ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "SWAT" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				return false
			elseif ( sourceTeam == "Police" ) and ( getElementData( thePrisoner, "wantedPoints" ) < 9 ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "Military Forces" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				return false
			elseif ( sourceTeam == "Police" ) and ( getElementData( thePrisoner, "wantedPoints" ) < 9 ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "Government Agency" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				return false
			elseif ( sourceTeam == "Police" ) and ( getElementData( thePrisoner, "wantedPoints" ) < 9 ) then
				return false
			else
				return true
			end
		else
			return false
		end
	end
end

-- Stop damage when jailed or arrested.
function stopArrestPlayerDamage ( attacker, weapon, bodypart )
	if ( source ) and (getElementData ( source, "isPlayerArrested" )) or ( getElementData ( source, "isPlayerJailed" ) ) then
		cancelEvent()
		return
	end

	if ( isElement( attacker ) ) and ( getPlayerTeam( attacker ) ) and ( getElementType( attacker ) == "player" ) and ( source ) and ( attacker ~= source ) and ( getTeamName( getPlayerTeam( attacker ) ) ) and ( getTeamName( getPlayerTeam( source ) ) ) then
		local attackerTeam = (getTeamName(getPlayerTeam(attacker)))
		local sourceTeam = (getTeamName(getPlayerTeam(source)))
		if ( attackerTeam == "Police" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) or ( sourceTeam == "Police" ) then
				cancelEvent()
			end
		elseif ( attackerTeam == "SWAT" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				cancelEvent()
			elseif ( sourceTeam == "Police" ) and ( getElementData( source, "wantedPoints" ) < 9 ) then
				cancelEvent()
			end
		elseif ( attackerTeam == "Military Forces" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				cancelEvent()
			elseif ( sourceTeam == "Police" ) and ( getElementData( source, "wantedPoints" ) < 9 ) then
				cancelEvent()
			end
		elseif ( attackerTeam == "Government Agency" ) then
			if ( sourceTeam == "SWAT" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				cancelEvent()
			elseif ( sourceTeam == "Police" ) and ( getElementData( source, "wantedPoints" ) < 9 ) then
				cancelEvent()
			end
		end
	end
end
addEventHandler ( "onClientPlayerDamage", localPlayer, stopArrestPlayerDamage )

-- Check if the attack is allowed
function isAttackNotAllowed (attacker, victim)
	if getElementData(victim, "wantedPoints") > 9 then
		if (getTeamName(getPlayerTeam(attacker)) == "SWAT") or (getTeamName(getPlayerTeam(attacker)) == "Police") or (getTeamName(getPlayerTeam(attacker)) == "Military Forces") or (getTeamName(getPlayerTeam(attacker)) == "Government Agency") then
			return false
		else
			return true
		end
	else
		return true
	end
end

-- Check if the police are friends
function isActionNotAllowedForLaw ( attacker, victim )
	if ( victim ) and ( attacker ) and ( attacker ~= victim ) then
		if ( getTeamName( getPlayerTeam( attacker ) ) == "SWAT" ) or  ( getTeamName( getPlayerTeam( attacker ) ) == "Military Forces" ) or  ( getTeamName( getPlayerTeam( attacker ) ) == "Government Agency" ) or  ( getTeamName( getPlayerTeam( attacker ) ) == "Police" ) then
			if ( getTeamName( getPlayerTeam( victim ) ) == "SWAT" ) or  ( getTeamName( getPlayerTeam( victim ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( victim ) ) == "Government Agency" ) or  ( getTeamName( getPlayerTeam( victim ) ) == "Police" ) then
				return false
			else
				return true
			end
		else
			return true
		end
	else
		return false
	end
end

-- When player damage let him fall of bike
addEventHandler( "onClientPlayerDamage", root,
function ( attacker, weapon, bodypart )
	if ( isPedInVehicle ( source ) ) then
		if ( source == localPlayer ) then
			local theVehicle = getPedOccupiedVehicle( source )
			local theHealth = getElementHealth( source )
			if ( theHealth < 20 ) then
				if ( getVehicleType ( theVehicle ) == "BMX" ) or ( getVehicleType ( theVehicle ) == "Bike" ) then
					triggerServerEvent( "onRemovePlayerFromBike", source )
				end
			end
		end
	end
end
)

-- Check if a player is a law player
local lawTeams = {
	"Police",
	"Military Forces",
	"SWAT",
	"Government Agency",
}

function isPlayerLawEnforcer ( thePlayer )
	if ( isElement( thePlayer ) ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#lawTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == lawTeams[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end

addEventHandler("onClientElementDataChange",localPlayer,function(k,v)
	if source == localPlayer and k == "isPlayerArrested" then
		if getElementData(localPlayer,"isPlayerArrested") == true then
			addEventHandler("onClientRender",root,draw)
		else
			removeEventHandler("onClientRender",root,draw)
		end
	end
end)


function AbsoluteToRelativ2( X, Y )
    local rX, rY = guiGetScreenSize()
    local x = math.floor(X*rX/1280)
    local y = math.floor(Y*rY/768)
    return x, y
end


function draw()
			x,y=AbsoluteToRelativ2(650, 737)
			x2,y2=AbsoluteToRelativ2(750, 762)
			dxDrawText("You are under arrest. Do NOT quit or reconnect.", x,y,x2,y2, tocolor(255,0,0, 255), 1, "default-bold", "center", "top", false, false, true, false, false)
			x,y=AbsoluteToRelativ2(650, 750)
			x2,y2=AbsoluteToRelativ2(750, 775)
			dxDrawText("You will be jailed and fined 5 Score for intentional disconnection!", x,y,x2,y2, tocolor(255,0,0, 255), 1, "default-bold", "center", "top", false, false, true, false, false)
end

