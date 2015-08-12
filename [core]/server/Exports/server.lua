-- set player database position
function updatePlayerDatabasePosition ( thePlayer, x, y, z, int, dimension )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if x and y and z then
			local updatePosition = exports.DENmysql:exec( "UPDATE accounts SET x=?, y=?, z=? WHERE id=?", x, y, z, userID  )
			if ( updatePosition ) then
				if ( int ) and tostring(int):match("^%s*$") then
					local updateInt = exports.DENmysql:exec( "UPDATE accounts SET interior=? WHERE id=?", tonumber(int), userID  )
				end
				if ( dimension ) and tostring(dimension):match("^%s*$") then
					local updateDim = exports.DENmysql:exec( "UPDATE accounts SET dimension=? WHERE id=?", tonumber(dimension), userID  )
				end
				return true
			end
		else
			return false
		end
	else
		return false
	end
end

-- Check if the player is loggedin
function isPlayerLoggedIn ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local username = getElementData( thePlayer, "playerAccount" )
		if ( username ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Get the player his account id
function getPlayerAccountId ( thePlayer )
	outputDebugString ( "This export 'getPlayerAccountId' should be replaced with 'getPlayerAccountID'!", 3 )
	return getPlayerAccountID ( thePlayer )
end

-- Function for the old server ID exported function
function playerID ( thePlayer )
	outputDebugString ( "This export 'playerID' should be replaced with 'getPlayerAccountID'!", 3 )
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

-- Set player interior
addEvent( "setServerPlayerInterior", true )
addEventHandler( "setServerPlayerInterior", root,
	function ( theInterior )
		local x, y, z = getElementPosition( source )
		setElementInterior( source, theInterior, x, y, z )
	end
)

-- Set player interior
addEvent( "setServerPlayerDimension", true )
addEventHandler( "setServerPlayerDimension", root,
	function ( theDimension )
		setElementDimension( source, theDimension )
	end
)

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

-- Get the player his account name
function getPlayerAccountName ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local username = getElementData( thePlayer, "playerAccount" )
		if ( username ) then
			return tostring(username)
		else
			return false
		end
	else
		return false
	end
end

local emailSpam = {}

-- Change the email of the player
function updatePlayerEmail ( thePlayer, theEmail, thePassword )
	if ( emailSpam[thePlayer] ) and ( getTickCount()-emailSpam[thePlayer] < 300000 ) then
		exports.DENdxmsg:createNewDxMessage(thePlayer, "Due spamming you need to wait 5 minutes to change your password again!", 225, 0, 0)
		return false
	elseif ( thePlayer ) and ( theEmail ) and ( thePassword ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		local getUserData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ? LIMIT 1", userID )
		if ( getUserData.password == string.lower( sha512(thePassword) ) ) or ( getUserData.password == sha512(thePassword) ) then
			if ( string.match(theEmail, "^.+@.+%.%a%a%a*%.*%a*%a*%a*") )then
				local updateEmail = exports.DENmysql:exec( "UPDATE accounts SET email = ? WHERE id = ?", theEmail, userID )
				if ( updateEmail ) then
					exports.DENdxmsg:createNewDxMessage(thePlayer, "Your email is successfully changed!", 0, 225, 0)
					triggerClientEvent( thePlayer, "resetSettingsEditFields", thePlayer )
					emailSpam[thePlayer] = getTickCount()
					return true
				else
					exports.DENdxmsg:createNewDxMessage(thePlayer, "We couldn't change your email, try again!", 225, 0, 0)
					return false
				end
			else
				exports.DENdxmsg:createNewDxMessage(thePlayer, "You didn't enter a vaild email adress!", 225, 0, 0)
				return false
			end
		else
			exports.DENdxmsg:createNewDxMessage(thePlayer, "The password of your account isn't correct!", 225, 0, 0)
			return false
		end
	else	
		return false
	end
end

local passwordSpam = {}

-- Change the password of the player
function updatePlayerPassword ( thePlayer, newPassword, newPassword2, oldPassword )
	if ( passwordSpam[thePlayer] ) and ( getTickCount()-passwordSpam[thePlayer] < 300000 ) then
		exports.DENdxmsg:createNewDxMessage(thePlayer, "Due spamming you need to wait 5 minutes to change your email again!", 225, 0, 0)
		return false
	elseif ( thePlayer ) and ( newPassword ) and ( newPassword2 ) and ( oldPassword ) then
		if ( newPassword == newPassword2 ) then
			local userID = getElementData( thePlayer, "accountUserID" )
			local getUserData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ?", userID )
			if ( getUserData.password == string.lower( sha512(oldPassword) ) ) or ( getUserData.password == sha512(oldPassword) ) then
				if not ( string.match(newPassword, "^%s*$") ) and ( string.len( newPassword ) > 8 ) then
					if ( exports.DENmysql:exec( "UPDATE accounts SET password=? WHERE id = ?", sha512(newPassword), userID ) ) then
						exports.DENdxmsg:createNewDxMessage(thePlayer, "Your password is successfully changed!", 0, 225, 0)
						triggerClientEvent( thePlayer, "resetSettingsEditFields", thePlayer )
						passwordSpam[thePlayer] = getTickCount()
						return true
					else
						exports.DENdxmsg:createNewDxMessage(thePlayer, "We couldn't change your password, try again!", 225, 0, 0)
						return false
					end
				else
					exports.DENdxmsg:createNewDxMessage(thePlayer, "Your password contains illegal characters, is empty or to short!", 225, 0, 0)
					return false
				end
			else
				exports.DENdxmsg:createNewDxMessage(thePlayer, "Your old password doesn't match!", 225, 0, 0)
				return false
			end
		else
			exports.DENdxmsg:createNewDxMessage(thePlayer, "The passwords don't match!", 225, 0, 0)
			return false
		end
	else	
		return true
	end
end

-- Get the playtime of the player
function getPlayerPlayTime ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local playtime = getElementData ( thePlayer, "playTime" )
		if ( playtime ) then
			return tonumber(playtime)
		else
			return false
		end
	else
		return false
	end
end

-- Get the zone of the user
function getPlayChatZone ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local theZone = calculatePlayerChatZone( thePlayer )
		if ( theZone ) then
			return tostring(theZone)
		else
			return false
		end
	else
		return false
	end
end

function calculatePlayerChatZone( thePlayer )
	local x, y, z = getElementPosition(thePlayer)
	if x < -920 then
		return "SF"
	elseif y < 420 then
		return "LS"
	else
		return "LV"
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

-- Get player premium hour
function getPlayerPremiumHours ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if getElementData(thePlayer, "isPlayerPremium" ) then
			local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=?", userID )
			if ( playerData ) and ( playerData.premium ) then
				return tonumber(playerData.premium)
			else
				return false
			end
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

-- Get player vehicles (returns table)
function getPlayerVehicles ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		local playerVehicles = exports.DENmysql:query( "SELECT * FROM vehicles WHERE ownerid = ?", userID )
		if playerVehicles and #playerVehicles > 0 then
			return playerVehicles
		else
			return false
		end
	else
		return false
	end
end

-- Get player group name
function getPlayerGroupName ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local playerGroup = getElementData( thePlayer, "Group" )
		if ( playerGroup ) then
			return tostring(playerGroup)
		else
			return false
		end
	else
		return false
	end
end

-- Get player bank money
function getPlayerBankBalance ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		local accountBalance = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ? LIMIT 1", userID )
		if ( accountBalance ) then
			return tonumber(accountBalance.balance)
		else
			return false
		end
	else
		return false
	end
end

-- Give player bank money
function givePlayerBankMoney ( thePlayer, money )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if tostring(money):match("^%s*$") and not ( userID) then
			return false
		else
			if string.match(tostring(money),'^%d+$') then
			local bankMoney = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ? LIMIT 1", userID )
				if ( bankMoney ) then
					local bankBalance = (tonumber(bankMoney.balance) + tonumber(money))
					local updateBank = exports.DENmysql:exec( "UPDATE banking SET balance = ? WHERE userid = ?", bankBalance, userID )
					if ( updateBank ) then
						return true
					else
						return false
					end
				else
					return false
				end
			else
				return false
			end
		end
	else
		return false
	end
end

-- Take player bank money
function takePlayerBankMoney ( thePlayer, money)
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if tostring(money):match("^%s*$") and not ( userID) then
			return false
		else
			if string.match(tostring(money),'^%d+$') then
			local bankMoney = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", userID )
				if ( bankMoney ) then
					local bankBalance = (tonumber(bankMoney.balance) - tonumber(money))
					local updateBank = exports.DENmysql:exec( "UPDATE banking SET balance = ? WHERE userid = ?", bankBalance, userID)
					if ( updateBank ) then
						return true
					else
						return false
					end
				else
					return false
				end
			else
				return false
			end
		end
	else
		return false
	end
end

-- Does player have a creditcard
function doesPlayerHaveCreditcard ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local getCreditcard = getElementData( thePlayer, "creditcard" )
		if ( tonumber(getCreditcard) == 1 ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

local colorCache = {}
function getGroupColor(groupName)
	if groupName then
		if colorCache[groupName] then
			return colorCache[groupName]
		end
		local groupTable = exports.DENmysql:query("SELECT turfcolor FROM groups WHERE groupname = ? LIMIT 1",groupName)
		if groupTable and #groupTable == 1 then
			colorCache[groupName] = groupTable[1].turfcolor
			return groupTable[1].turfcolor
		end
	end
	return false
end

function setGroupColor(groupName,color)
	if groupName and color then
		colorCache[groupName] = color
	end
end

-- Get player bank transactions (return a table)
function getPlayerBankTransactions ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		local playerTransactions = exports.DENmysql:query( "SELECT * FROM banking_transactions WHERE userid = ?", userID )
		if playerTransactions and #playerTransactions > 0 then
			return playerTransactions
		else
			return false
		end
	else
		return false
	end
end

function updatePlayerJobSkin(plr, skin)
	if (not isElement(plr)) then
		return false
	end
	local id = getElementData(plr, "accountUserID")
	exports.DENmysql:exec("UPDATE `accounts` SET `jobskin` =? WHERE `id` =?", skin, id)
	return true
end

-- Get player occupation
function getPlayerOccupation ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local playerOccupation = getElementData(thePlayer, "Occupation")
		if ( playerOccupation ) then
			return tostring(playerOccupation)
		else
			return false
		end
	else
		return false
	end
end

function isPlayerArrested ( thePlayer )
	if ( isElement( thePlayer ) ) then
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

-- Get the player his wanted points
function getPlayerWantedPoints ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local wantedPoints = getElementData( thePlayer, "wantedPoints" )
		if ( wantedPoints ) then
			return tonumber(wantedPoints)
		else
			return false
		end
	else
		return false
	end
end

-- Set the player his wanted points
function setPlayerWantedPoints ( thePlayer, points )
	if ( isElement( thePlayer ) ) then
		local setWantedPoints = setElementData( thePlayer, "wantedPoints", tonumber( points ) )
		if ( setWantedPoints ) and ( points ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Get the player his wanted points
function givePlayerWantedPoints ( thePlayer, points )
	if ( isElement( thePlayer ) ) then
		local wantedPoints = getElementData( thePlayer, "wantedPoints" )
		local setWantedPoints = setElementData( thePlayer, "wantedPoints", tonumber( ( wantedPoints + points ) ) )
		if ( setWantedPoints ) and ( points ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Remove the player his wanted points
function removePlayerWantedPoints ( thePlayer, points )
	if ( isElement( thePlayer ) ) then
		local wantedPoints = getElementData( thePlayer, "wantedPoints" )
		local setWantedPoints = setElementData( thePlayer, "wantedPoints", tonumber( ( wantedPoints - points ) ) )
		if ( setWantedPoints ) and ( points ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Remove all the wanted points off the player
function removeAllPlayerWantedPoints ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local setWantedPoints = setElementData( thePlayer, "wantedPoints", 0 )
		if ( setWantedPoints ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Convert numbers into a number with commas
function convertNumber ( theNumber )
	if ( theNumber ) then
		local convertedNumber = cvtNumber( theNumber )  
		if ( convertedNumber ) then
			return tostring(convertedNumber)
		else
			return false
		end
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

-- Add vehicle into vehicle system and database
function addPlayerVehicle ( thePlayer, vehicleID, ownerID, vehicleHealth, boughtPrice, color1, color2, x, y, z, rotation )
	if ( thePlayer) and ( vehicleID ) and ( ownerID ) and ( vehicleHealth ) and ( boughtPrice ) and ( color1 ) and ( x ) and ( y ) and ( z ) and  ( rotation ) then
		local createVehicle = exports.DENmysql:exec("INSERT INTO vehicles SET vehicleid=?, ownerid=?, vehiclehealth=?, boughtprice=?, color1=?, color2=?, x=?, y=?, z=?, rotation=?"
			,vehicleID
			,ownerID
			,vehicleHealth
			,boughtPrice
			,color1
			,color2
			,x
			,y
			,z
			,rotation)
		if ( createVehicle ) then
			local getVehicleTheID = exports.DENmysql:querySingle( "SELECT * FROM vehicles WHERE color1 = ? AND color2 = ? AND ownerid = ?", color1, color2, ownerID)
			if ( getVehicleTheID ) then
				local addVehicleIntoVehicleSystem = exports.DENvehicles:onPlayerBoughtVehicle( thePlayer, vehicleID, x, y, z, rotation, getVehicleTheID.uniqueid, color1, color2 )
				if ( addVehicleIntoVehicleSystem ) then
					return true
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
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

function getPlayerGroup(player)
	if (isElement(player)) then
		if (exports.server:isPlayerLoggedIn(player) == true) then
			local group = getElementData(player,"Group")
			if group then
				return group --should be string
			else
				return false
			end
		else
			return false
		end
	end
end

function getPlayerGroupRank(player)
	if (isElement(player)) then
		if (exports.server:isPlayerLoggedIn(player) == true) then
			if (getPlayerGroup(player)) then
				local rank = getElementData(player,"GroupRank")
				if rank then
					return rank
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function getPlayerFPS(player)
	if (isElement(player)) then
		return getElementData(player,"FPS")
	else
		return false
	end
end

function isPlayerJailed(player)
	if (isElement(player)) then
		return getElementData(player,"FPS")
	else
		return false
	end
end