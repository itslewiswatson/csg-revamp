function getTimeStampYYYYMMDD()
	local time = GetDateTime(GetTimestamp())
	if time.month < 10 then time.month = "0"..(time.month).."" end
	if time.monthday < 10 then time.monthday = "0"..(time.monthday).."" end
	local str = ""..(time.year)..""..(time.month)..""..(time.monthday)..""
	return str
end

function GetTimestamp(year, month, day, hour, minute, second)
    local i
    local timestamp = 0
    local time = getRealTime()
    local monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

    if (not year or year < 1970) then
        year = time.year + 1900
        month = time.month + 1
        day = time.monthday
        hour = time.hour
        minute = time.minute
        second = time.second
    else
        month = month or 1
        day = day or 1
        hour = hour or 0
        minute = minute or 0
        second = second or 0
    end

    for i=1970, year-1, 1 do
        timestamp = timestamp + 60*60*24*365
        if (IsYearALeapYear(i)) then
            timestamp = timestamp + 60*60*24
        end
    end

    if (IsYearALeapYear(year)) then
        monthDays[2] = monthDays[2] + 1
    end

    for i=1, month-1, 1 do
        timestamp = timestamp + 60*60*24*monthDays[i]
    end

    timestamp = timestamp + 60*60*24 * (day - 1) + 60*60 * hour + 60 * minute + second

    return timestamp
end

function GetDateTime(timestamp)
    local i
    local time = {}
    local monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

    time.year = 1970
    while (timestamp >= 60*60*24*365) do
        timestamp = timestamp - 60*60*24*365
        time.year = time.year + 1

        if (IsYearALeapYear(time.year - 1)) then
            if timestamp >= 60*60*24 then
                timestamp = timestamp - 60*60*24
            else
                timestamp = timestamp + 60*60*24*365
                time.year = time.year - 1
                break
            end
        end
    end

    if (IsYearALeapYear(time.year)) then
        monthDays[2] = monthDays[2] + 1
    end

    local month, daycount
    for month, daycount in ipairs(monthDays) do
        time.month = month
        if (timestamp >= 60*60*24*daycount) then
            timestamp = timestamp - 60*60*24*daycount
        else
            break
        end
    end

    time.monthday = math.floor(timestamp / (60*60*24)) + 1
    timestamp = timestamp - 60*60*24 * (time.monthday - 1)

    time.hour = math.floor(timestamp / (60*60))
    timestamp = timestamp - 60*60 * time.hour

    time.minute = math.floor(timestamp / 60)
    timestamp = timestamp - 60 * time.minute

    time.second = timestamp

    local monthcode = time.month - 2
    local year = time.year
    local yearcode

    if (monthcode < 1) then
        monthcode = monthcode + 12
        year = year - 1
    end
    monthcode = math.floor(2.6 * monthcode - 0.2)

    yearcode = year % 100
    time.weekday = time.monthday + monthcode + yearcode + math.floor(yearcode / 4)
    yearcode = math.floor(year / 100)
    time.weekday = time.weekday + math.floor(yearcode / 4) - 2 * yearcode
    time.weekday = time.weekday % 7

    return time
end

function IsYearALeapYear(year)
    if ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0) then
        return true
    else
        return false
    end
end

function online(ps)
	local t = getElementsByType("player")
	exports.DENdxmsg:createNewDxMessage(ps,"There are "..#t.." players online!",0,255,0)
end
addCommandHandler("players",online)

---santaevent
local original = {}
local allowed = true
local allowedForMe = {}
function returnme(ps)
	if original[ps] == nil then return end
	setElementInterior(ps,original[ps][5])
	setElementDimension(ps,original[ps][4])
	setElementPosition(ps,original[ps][1],original[ps][2],original[ps][3])
	original[ps] = nil
end
addCommandHandler("returnme",returnme)

addCommandHandler("santaevent",function(ps)
	if allowed == false then return end
	if isPedInVehicle(ps) == true then return end
	local x,y,z = getElementPosition(ps)
	local dim = getElementDimension(ps)
	local int = getElementInterior(ps)
	if allowedForMe[ps] ~= nil then return end
	if int ~= 15 then
		original[ps] = {x,y,z,dim,int}
	end
	setElementInterior(ps,15,-1394,987,1025)
	if allowedForMe[ps] == nil then allowedForMe[ps] = false end
 end)

 local weps = {
	6,7,8,9,25,31,30,33,34
 }
 addCommandHandler("startsantaevent",function()

	function circle(r,s,cx,cy)
	allowed=false
	xVals = {}
	yVals = {}
	for i=1,s-1 do
		xVals[i] = (cx+r*math.cos(math.pi*i/s*2-math.pi/2))
		yVals[i] = (cy+r*math.sin(math.pi*i/s*2-math.pi/2))
		--outputChatBox('('..xVals[i]..','..yVals[i]..')')
	end
	end
	circle(50,38,-1400.72,996.19)
	size = #xVals

	for k,v in pairs(xVals) do
		local x = v
		local y = yVals[k]
		local z = 1026
		local ped = ""
		ped = exports.slothbot:spawnBot(x,y,z,50,50,15,0,getTeamFromName("Staff"),weps[math.random(1,#weps)])
	end

 end)

 addEventHandler("onPlayerLogin",root,function()
 --------- load weapon skills
  local playerID = exports.server:getPlayerAccountID(source)
 local playerStatus = exports.DENmysql:querySingle( "SELECT * FROM playerstats WHERE userid=?", playerID )
		local thePlayer=source
		if ( playerStatus ) then
			local wepSkills = fromJSON( playerStatus.weaponskills )
			if ( wepSkills ) then
				for skillint, valueint in pairs( wepSkills ) do
					if ( tonumber(valueint) > 950 ) then
						if tonumber(skillint) == 73 or tonumber(skillint) == 75 then
						setTimer(function() if isElement(thePlayer) then setPedStat ( thePlayer, tonumber(skillint), 995 ) end end,1000,10)
						else
						setTimer(function() if isElement(thePlayer) then setPedStat ( thePlayer, tonumber(skillint), 1000 ) end end,1000,10)
						end
					else
						setTimer(function() if isElement(thePlayer) then setPedStat ( thePlayer, tonumber(skillint), tonumber(valueint) ) end end,1000,10)
					end
				end
			end
			apply()
		end
end)

addEventHandler("onPlayerSpawn",root,function()
	local playerID = exports.server:getPlayerAccountID(source)
	local playerStatus = exports.DENmysql:query("SELECT weaponskills FROM playerstats WHERE userid=? LIMIT 1",playerID)
	if playerStatus and playerStatus[1] then
		local wepSkills = fromJSON(playerStatus[1].weaponskills)
		if wepSkills then
			for skillint,valueint in pairs(wepSkills) do
				if tonumber(valueint) > 950 then
					if tonumber(skillint) == 73 or tonumber(skillint) == 75 then
						setTimer(function() if isElement(thePlayer) == false then return end setPedStat ( thePlayer, tonumber(skillint), 995 ) end,1000,5)
					else
						setTimer(function() if isElement(thePlayer) == false then return end setPedStat ( thePlayer, tonumber(skillint), 1000 ) end,1000,5)
					end
				else
					setTimer(function() if isElement(thePlayer) == false then return end setPedStat ( thePlayer, tonumber(skillint), tonumber(valueint) ) end,1000,5)
				end
			end
		end
	end
	apply()
end)

addCommandHandler("jrgates",function(ps)
	if exports.server:getPlayerAccountName(ps) == "jockedabaws" then
		restartResource(getResourceFromName("CSGgates"))
	end
end)

addCommandHandler("jrbases",function(ps)
	if exports.server:getPlayerAccountName(ps) == "jockedabaws" then
		restartResource(getResourceFromName("CSGbases"))
	end
end)

addCommandHandler("jrpickups",function(ps)
	if exports.server:getPlayerAccountName(ps) == "jockedabaws" then
		restartResource(getResourceFromName("CSGpickups"))
	end
end)

addCommandHandler("jrinteriors",function(ps)
	if exports.server:getPlayerAccountName(ps) == "jockedabaws" then
		restartResource(getResourceFromName("CSGinteriors"))
	end
end)

addCommandHandler("jrpaynspray",function(ps)
	if exports.server:getPlayerAccountName(ps) == "jockedabaws" then
		restartResource(getResourceFromName("DENpaynspray"))
	end
end)

--anti lag on connect
addEventHandler("onPlayerJoin",root,function()
	local p = source
	setTimer(function()
		if isElement(p) then
			setCameraMatrix(p, 930.92657470703, -2324.7670898438, 49.806098937988, 931.46881103516, -2323.9365234375, 49.6796875, 0, 70)
		end
	end,1000,1)
end)

function apply()
	 --[[ for _,weaponSkill in ipairs({"poor","std","pro"}) do
			if getWeaponProperty (27,"pro","flags") == 28673 then
				return
				--setWeaponProperty ( 27, weaponSkill, "flags", 0x000020 )
			end
			-- MP5 move, aim and fire at the same time and crouching when aim
			if getWeaponProperty (29,weaponSkill,"flags") ~= 0x002000 then
				setWeaponProperty ( 29, weaponSkill, "flags", 0x002000 )
			end
			if getWeaponProperty (29,weaponSkill,"flags") ~= 0x000020 then
				setWeaponProperty ( 29, weaponSkill, "flags", 0x000020 )
			end
			if getWeaponProperty (29,weaponSkill,"flags") ~= 0x000010 then
				setWeaponProperty ( 29, weaponSkill, "flags", 0x000010 )
			end

			-- AK47 move, aim and fire at the same time and crouching when aim
			if getWeaponProperty (30,weaponSkill,"flags") ~= 0x002000 then
				setWeaponProperty ( 30, weaponSkill, "flags", 0x002000 )
			end
			if getWeaponProperty (30,weaponSkill,"flags") ~= 0x000020 then
				setWeaponProperty ( 30, weaponSkill, "flags", 0x000020 )
			end
			if getWeaponProperty (30,weaponSkill,"flags") ~= 0x000010 then
				setWeaponProperty ( 30, weaponSkill, "flags", 0x000010 )
			end

			-- SHOTGUN move, aim and fire at the same time

			if getWeaponProperty (25,weaponSkill,"flags") ~= 0x000020 then
				setWeaponProperty ( 25, weaponSkill, "flags", 0x000020 )
			end
			if getWeaponProperty (25,weaponSkill,"flags") ~= 0x000010 then
				setWeaponProperty ( 25, weaponSkill, "flags", 0x000010 )
			end
			-- UZI move, aim and fire at the same time
			if getWeaponProperty (28,weaponSkill,"flags") ~= 0x002000 then
				setWeaponProperty ( 28, weaponSkill, "flags", 0x002000 )
			end
			if getWeaponProperty (28,weaponSkill,"flags") ~= 0x000020 then
				setWeaponProperty ( 28, weaponSkill, "flags", 0x000020 )
			end
			if getWeaponProperty (28,weaponSkill,"flags") ~= 0x000010 then
				setWeaponProperty ( 28, weaponSkill, "flags", 0x000010 )
			end
			-- TEC9 move, aim and fire at the same time
			if getWeaponProperty (32,weaponSkill,"flags") ~= 0x002000 then
				setWeaponProperty ( 32, weaponSkill, "flags", 0x002000 )
			end
			if getWeaponProperty (32,weaponSkill,"flags") ~= 0x000020 then
				setWeaponProperty ( 32, weaponSkill, "flags", 0x000020 )
			end
			if getWeaponProperty (32,weaponSkill,"flags") ~= 0x000010 then
				setWeaponProperty ( 32, weaponSkill, "flags", 0x000010 )
			end
			-- DESSERT EAGLE move, aim and fire at the same time
			if getWeaponProperty (24,weaponSkill,"flags") ~= 0x002000 then
				setWeaponProperty ( 24, weaponSkill, "flags", 0x002000 )
			end
			if getWeaponProperty (24,weaponSkill,"flags") ~= 0x000020 then
				setWeaponProperty ( 24, weaponSkill, "flags", 0x000020 )
			end
			if getWeaponProperty (24,weaponSkill,"flags") ~= 0x000010 then
				setWeaponProperty ( 24, weaponSkill, "flags", 0x000010 )
			end
			-- SPAS move, aim and fire at the same time
			if getWeaponProperty (27,weaponSkill,"flags") ~= 0x000020 then
				setWeaponProperty ( 27, weaponSkill, "flags", 0x000020 )
			end
			if getWeaponProperty (27,weaponSkill,"flags") ~= 0x000010 then
				setWeaponProperty ( 27, weaponSkill, "flags", 0x000010 )
			end
			-- SAWNOFF move, aim and fire at the same time
			if getWeaponProperty (26,weaponSkill,"flags") ~= 0x000020 then
				setWeaponProperty ( 26, weaponSkill, "flags", 0x000020 )
			end
			if getWeaponProperty (26,weaponSkill,"flags") ~= 0x000010 then
				setWeaponProperty ( 26, weaponSkill, "flags", 0x000010 )
			end
			-- PISTOL move, aim and fire at the same time and crouching when aim
			if getWeaponProperty (22,weaponSkill,"flags") ~= 0x002000 then
				setWeaponProperty ( 22, weaponSkill, "flags", 0x002000 )
			end
			if getWeaponProperty (22,weaponSkill,"flags") ~= 0x000020 then
				setWeaponProperty ( 22, weaponSkill, "flags", 0x000020 )
			end
			if getWeaponProperty (22,weaponSkill,"flags") ~= 0x000010 then
				setWeaponProperty ( 22, weaponSkill, "flags", 0x000010 )
			end
			-- SILENCED move, aim and fire at the same time and crouching when aim
			if getWeaponProperty (23,weaponSkill,"flags") ~= 0x002000 then
				setWeaponProperty ( 23, weaponSkill, "flags", 0x002000 )
			end
		end
	--]]
end

apply()
for k,v in ipairs(getElementsByType("player")) do
	local playerID = exports.server:getPlayerAccountID(v)
	local playerStatus = exports.DENmysql:query( "SELECT weaponskills FROM playerstats WHERE userid=?", playerID )
	local thePlayer=v
	if playerStatus and playerStatus[1] then
		local wepSkills = fromJSON( playerStatus[1].weaponskills )
		if ( wepSkills ) then
			for skillint, valueint in pairs( wepSkills ) do
				if ( tonumber(valueint) > 950 ) then
					if tonumber(skillint) == 73 or tonumber(skillint) == 75 then
					setPedStat(v,skillint,995)
					setTimer(function() setPedStat ( thePlayer, tonumber(skillint), 995 ) end,1000,5)
					else
					setPedStat(v,skillint,1000)
					--outputDebugString(getPlayerName(v).." "..skillint.." "..valueint.."")
					setTimer(function() setPedStat ( thePlayer, tonumber(skillint), 1000 ) end,1000,5)
					end
				else
					setPedStat(v,skillint,valueint)
					setTimer(function() setPedStat ( thePlayer, tonumber(skillint), tonumber(valueint) ) end,1000,5)
				end
			end
		end
	end
end
apply()

--double acc login fix
addEventHandler("onPlayerLogin",root,function()
	local accName = exports.server:getPlayerAccountName(source)
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(v) == true then
			local an = exports.server:getPlayerAccountName(v)
			if an == accName and v ~= source then
				kickPlayer(source,"This user is already logged in!")
			end
		end
	end
	apply()
end)


setFPSLimit(69) -- to prevent weapons skills bug

