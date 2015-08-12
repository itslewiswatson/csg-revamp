-- Get the player his account id
function getPlayerAccountId ( thePlayer )
	return getPlayerAccountID ( thePlayer )
end

-- Function for the old server ID exported function
function playerID ( thePlayer )
	return getPlayerAccountID ( thePlayer )
end

-- New function, all exports should move to this one
function getPlayerAccountID ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if ( userID ) then
			return tonumber(userID)
		else
			return false
		end
	else
		return false
	end
end

-- Get player accountname
function getPlayerAccountName ( thePlayer )
	local thePlayer = thePlayer or localPlayer
	local username = getElementData( thePlayer, "playerAccount" )
	if ( username ) then
		return tostring(username)
	else
		return false
	end
end

-- Check if the player is loggedin
function isPlayerLoggedIn ( thePlayer )
	local thePlayer = thePlayer or localPlayer
	local username = getElementData( thePlayer, "playerAccount" )
	if ( username ) then
		return true
	else
		return false
	end
end

-- Get the player his groupID
function getPlayerGroupID ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local groupID = getElementData( thePlayer, "GroupID" )
		if ( groupID ) then
			return groupID
		else
			return false
		end
	else
		return false
	end
end

-- Get a player from a account name
function getPlayerFromAccountname ( theName )
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if ( getElementData( thePlayer, "playerAccount" ) == theName ) then
			return thePlayer
		end
	end
end

-- Get the player his email
function getPlayerAccountEmail ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local theEmail = getElementData( thePlayer, "playerEmail" )
		if ( theEmail ) then
			return theEmail
		else
			return false
		end
	else
		return false
	end
end

-- Check if a player is premium or not
function isPlayerPremium ( thePlayer )
	if ( isElement( thePlayer ) ) then
		if ( getElementData(thePlayer, "isPlayerPremium" ) ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Check if the player is arrested
function isPlayerArrested ( thePlayer )
	local thePlayer = thePlayer or localPlayer
	if ( isElement( localPlayer ) ) then
		local getArrestStatus = getElementData(thePlayer, "isPlayerArrested")
		if ( getArrestStatus ) then
			return true
		else
			return false
		end
	else
		return false
	end
end


-- Get the playtime of the player
function getPlayerPlayTime ( thePlayer )
	local thePlayer = thePlayer or localPlayer
	local playtime = getElementData ( thePlayer, "playTime" )
	if ( playtime ) then
		return tonumber(playtime)
	else
		return false
	end
end

-- Get the zone of the user
function getPlayChatZone ( thePlayer )
	local thePlayer = thePlayer or localPlayer
	local theZone = calculatePlayerChatZone( thePlayer )
	if ( theZone ) then
		return tostring(theZone)
	else
		return false
	end
end

function calculatePlayerChatZone( thePlayer )
	local x, y, z = getElementPosition(thePlayer)
	if x < -920 then
		return "SF"
	elseif y < 467 then
		return "LS"
	else
		return "LV"
	end
end

-- Get player group name
function getPlayerGroupName ( thePlayer )
	local thePlayer = thePlayer or localPlayer
	local playerGroup = getElementData( thePlayer, "Group" )
	if ( playerGroup ) then
		return tostring(playerGroup)
	else
		return false
	end
end

-- Does player have a creditcard
function doesPlayerHaveCreditcard ( thePlayer )
	local thePlayer = thePlayer or localPlayer
	local getCreditcard = getElementData( thePlayer, "creditcard" )
	if ( tonumber(getCreditcard) == 1 ) then
		return true
	else
		return false
	end
end

-- Set player interior
function setClientPlayerInterior( thePlayer, theInterior )
	if ( isElement( thePlayer ) ) and ( theInterior ) then
		triggerServerEvent( "setServerPlayerInterior", thePlayer, theInterior )
		return true
	else
		return false
	end
end

-- Set player dimension
function setClientPlayerDimension( thePlayer, theDimension )
	if ( isElement( thePlayer ) ) and ( theDimension ) then
		triggerServerEvent( "setServerPlayerDimension", thePlayer, theDimension )
		return true
	else
		return false
	end
end

-- Get player occupation
function getPlayerOccupation ( thePlayer )
	local thePlayer = thePlayer or localPlayer
	local playerOccupation = getElementData(thePlayer, "Occupation")
	if ( playerOccupation ) then
		return tostring(playerOccupation)
	else
		return false
	end
end

-- Get the player his wanted points
function getPlayerWantedPoints ( thePlayer )
	local thePlayer = thePlayer or localPlayer
	local wantedPoints = getElementData( thePlayer, "wantedPoints" )
	if ( wantedPoints ) then
		return tonumber(wantedPoints)
	else
		return false
	end
end

-- Set the player his wanted points
function setPlayerWantedPoints ( thePlayer, points )
	local thePlayer = thePlayer or localPlayer
	local setWantedPoints = setElementData( thePlayer, "wantedPoints", tonumber( points ) )
	if ( setWantedPoints ) and ( points ) then
		return true
	else
		return false
	end
end

-- Get the player his wanted points
function givePlayerWantedPoints ( thePlayer, points )
	local thePlayer = thePlayer or localPlayer
	local wantedPoints = getElementData( thePlayer, "wantedPoints" )
	local setWantedPoints = setElementData( thePlayer, "wantedPoints", tonumber( ( wantedPoints + points ) ) )
	if ( setWantedPoints ) and ( points ) then
		return true
	else
		return false
	end
end

-- Remove the player his wanted points
function removePlayerWantedPoints ( thePlayer, points )
	local thePlayer = thePlayer or localPlayer
	local wantedPoints = getElementData( thePlayer, "wantedPoints" )
	local setWantedPoints = setElementData( thePlayer, "wantedPoints", tonumber( ( wantedPoints - points ) ) )
	if ( setWantedPoints ) and ( points ) then
		return true
	else
		return false
	end
end

-- Remove all the wanted points off the player
function removeAllPlayerWantedPoints ( thePlayer )
	local thePlayer = thePlayer or localPlayer
	local setWantedPoints = setElementData( thePlayer, "wantedPoints", 0 )
	if ( setWantedPoints ) then
		return true
	else
		return false
	end
end

-- Convert numbers into a number with commas
function convertNumber ( theNumber )
	local convertedNumber = cvtNumber( theNumber )  
	if ( convertedNumber ) then
		return tostring(convertedNumber)
	else
		return false
	end
end

function cvtNumber( theNumber )  
	local formatted = theNumber  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
	if (k==0) then      
		break   
		end  
	end  
	return formatted
end

-- Get player from name part
function getPlayerFromNamePart( namePart )
	local result = false
    if namePart then
        for i, player in ipairs(getElementsByType("player")) do
            if string.find(getPlayerName(player):lower(), tostring(namePart):lower(), 1, true) then
				if result then return false end
					result = player 
				end
			end
		end
    return result
end

-- Convert RGB to HEX
function convertRGBToHEX(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

-- Random string
local chars = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z","0","1","2","3","4","5","6","7","8","9"}

function randomString( length )
	local theString = {}
	for i=1,length do
		local case = math.random(1,2)
		local char = math.random(1,#chars)
		if case == 1 then
			x=string.upper(chars[char])
		elseif case == 2 then
			x=string.lower(chars[char])
		end
		table.insert(theString, x)
	end
	return(table.concat(theString))
end

-- String explode
function stringExplode(self, separator)
    Check("stringExplode", "string", self, "ensemble", "string", separator, "separator")
 
    if (#self == 0) then return {} end
    if (#separator == 0) then return { self } end
 
    return loadstring("return {\""..self:gsub(separator, "\",\"").."\"}")()
end

function Check(funcname, ...)
    local arg = {...}
 
    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end
 
    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end
 
        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end

function updateServersideFPS()
	local fps = getElementData(localPlayer,"FPS")
	if fps then
		triggerServerEvent("updatePlayerFPS",localPlayer,fps)
	end
end
setTimer(updateServersideFPS,1000,0) --update every 1 second.

function getPlayerFPS(player)
	if (isElement(player)) then
		return getElementData(player,"FPS")
	else
		return false --player not found
	end
end

function isPlayerJailed(player)
	if (isElement(player)) then
		return getElementData(player,"isPlayerJailed")
	else
		return false
	end
end