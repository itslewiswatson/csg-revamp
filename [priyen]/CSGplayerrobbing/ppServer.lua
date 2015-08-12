local robCD = {}
local blockedPlayers = {}
--/rob

function isPlayerJailed(localPlayer)
		local dim = getElementDimension(localPlayer)
		local x,y,z = getElementPosition(localPlayer)
		local x2,y2,z2 = 1561.75, -822.47, 350.84
		if dim == 2 then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 100 then
				return true
			end
		end
		return false
end

function tuFindNearestElement(to,elementType,maxDistance)
    local x,y,z = getElementPosition(to)
    local bestD = maxDistance + 1
    local bv = nil

    for _,av in pairs(getElementsByType(elementType)) do
        if av ~= to then
            local vx,vy,vz = getElementPosition(av)
            local d = getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)
            if d < bestD then
                bestD = d
                bv = av
            end
        end
    end
	return bv
end

function rob(p,commandName,vic)
	if blockedPlayers[p] == true then exports.DENdxmsg:createNewDxMessage(p,"Bind suspected! You've been blocked from the feature! Remove the bind to use robbing.",255,0,0) return false end
    if isPedDead(p) then exports.dendxmsg:createNewDxMessage(p,"You cannot use this command when you are dead.",255,0,0) return end
	if isPlayerJailed(p) == true then return false end
	if getElementData(p,"isPlayerArrested") == true then exports.dendxmsg:createNewDxMessage(p,"You cannot rob when arrested.",255,0,0) return end
    if robCD[p] == nil then
		robCD[p] = 0
    end

    if robCD[p] > 0 then
		exports.dendxmsg:createNewDxMessage(p,"You are too tired to rob again",255,0,0)
		return false
    end

	if getElementInterior(p) == 1 or getElementDimension(p) == 1 then
		exports.dendxmsg:createNewDxMessage(p,"You cannot rob someone here.",255,0,0)
		return
	end

    if (vic) then
        if isElement(exports.server:getPlayerFromNamePart(vic)) then
            local vicElement = exports.server:getPlayerFromNamePart(vic)
			if isPedDead(vicElement) == true then return end
			vic = getPlayerName(vicElement)
            if getPlayerTeam(vicElement) == getTeamFromName("Staff") then exports.dendxmsg:createNewDxMessage(p,"You cannot rob staff on duty!",255,0,0) return end
            local x1,y1,z1 = getElementPosition(p)

            local x2,y2,z2 = getElementPosition(vicElement)
            local dist = getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
            if dist > 2 then
				exports.dendxmsg:createNewDxMessage(p,""..vic.." is too far away.",255,0,0)
				return
            end

            if isPedInVehicle(vicElement) == true then
                local vicVeh = getPedOccupiedVehicle(vicElement)
                if vicVeh ~= getPedOccupiedVehicle(p) then
					exports.dendxmsg:createNewDxMessage(p,""..vic.." is in a vehicle",255,0,0)
					return false
                end
            else
				if isPedInVehicle(p) == true then
					local pVeh = getPedOccupiedVehicle(p)
					if pveh ~= getPedOccupiedVehicle(vicElement) then
						exports.dendxmsg:createNewDxMessage(p,""..vic.." is not in the same vehicle as you",255,0,0)
						return false
					end
				end
			end
			doTheRob(vic,vicElement,p)
		else
			exports.dendxmsg:createNewDxMessage(p,""..vic.." cannot be found or doesn't exist.",255,0,0)
		end
    else
		local vicElement = tuFindNearestElement(p,"player",2)
		if isElement(vicElement) == false then
			if vicElement == nil then  exports.dendxmsg:createNewDxMessage(p,"There is no one near enough to rob",255,0,0) return     end
        else
			if isPedDead(vicElement) == true then return end
            if getPlayerTeam(vicElement) == getTeamFromName("Staff") then exports.dendxmsg:createNewDxMessage(p,"You cannot rob staff on duty!",255,0,0,true) return end
            if isElement(vicElement) then
				local vic = getPlayerName(vicElement)
				doTheRob(vic,vicElement,p)
			else
				exports.dendxmsg:createNewDxMessage(p,"There is no one near enough to rob",255,0,0)
            end
        end
    end
end
addCommandHandler("rob", rob)
addCommandHandler("rb", rob)


function doTheRob(vic,vicElement,p)
			if p == vicElement then return end
			if isPedInVehicle(p) or isPedInVehicle(vicElement) then
				local veh = getPedOccupiedVehicle(vicElement)
				local veh2 = getPedOccupiedVehicle(p)
				if veh == false or (veh ~= veh2) or veh2 == false then
					exports.dendxmsg:createNewDxMessage(p,"You cannot rob a person when not in the same vehicle or both not on foot!",255,255,0)
					return
				end
			end
            local chance = math.random(1,100)
            local pjob = getElementData(p,"Rank")
            local maxRobPercent = 5
            local chanceToRob = 95
            if pjob == "Con Artist" then
            chanceToRob = 80
            elseif pjob == "Pick Pocket" then
            chanceToRob = 65
            end
            local maxRobCash = 10000
			local tName = getTeamName(getPlayerTeam(vicElement))
				if tName == "SWAT" or tName == "Military Forces" then
					if math.random(1,100) <= 60 then
						chance=1
					end
				elseif tName == "Police" then
					if math.random(1,100) <= 40 then
						chance=1
					end
				end
            if chance > chanceToRob then


              --  local teamName = getPlayerTeam(getTeamName(vicElement))
				local vicMoney = getPlayerMoney(vicElement)
                if vicMoney > 50000 then
                   maxRobPercent = 10
                elseif vicMoney > 200000 then
                   maxRobPercent = 12
                elseif vicMoney > 300000 then
                   maxRobPercent = 14
                end
                if pjob == "Pick Pocket" then
                maxRobPercent = maxRobPercent * 2
                maxRobCash = 45000
                elseif pjob == "Con Artist" then
                maxRobPercent = maxRobPercent * 4
                maxRobCash = 60000
                end
                local toRobPercent = math.random(1,maxRobPercent)
                local toRobMoney = vicMoney * (toRobPercent/100)
                if toRobMoney > maxRobCash then
                toRobMoney = (math.random(80,100)/100) * maxRobCash
				if toRobMoney < 0 then toRobMoney = 0 end
                end
				exports.CSGscore:givePlayerScore(p,1)
				exports.CSGscore:takePlayerScore(vic,0.5)
                givePlayerMoney(p,toRobMoney,"robbed "..vic.."")
                takePlayerMoney(vicElement,toRobMoney,"robbed by "..getPlayerName(p).."")
                exports.dendxmsg:createNewDxMessage(p,"Robbed $"..toRobMoney.." from "..vic.."",0,255,0)
				exports.DENstats:setPlayerAccountData(p,"moneyRobbed",exports.DENstats:getPlayerAccountData(p,"moneyRobbed")+toRobMoney)
				exports.DENstats:setPlayerAccountData(vicElement,"moneyGotRobbed",exports.DENstats:getPlayerAccountData(vicElement,"moneyGotRobbed")+toRobMoney)
				if getElementData(p,"Rank") == "Pick Pocket" then
					exports.DENstats:setPlayerAccountData(p,"moneyRobbedAsPick",exports.DENstats:getPlayerAccountData(p,"moneyRobbedAsPick")+toRobMoney)
				elseif getElementData(p,"Rank") == "Con Artist" then
					exports.DENstats:setPlayerAccountData(p,"moneyRobbedAsCon",exports.DENstats:getPlayerAccountData(p,"moneyRobbedAsCon")+toRobMoney)
				end
                exports.dendxmsg:createNewDxMessage(vicElement,""..getPlayerName(p).." stole $"..toRobMoney.." from you!",255,255,0)
                outputChatBox(""..getPlayerName(p).." has robbed you of $"..toRobMoney.."",vicElement,255,0,0,true)
                outputChatBox("Robbed $"..toRobMoney.." off "..vic.."",p,255,255,0,true)
				local x,y,z = getElementPosition(p)
				exports.CSGwanted:addWanted(p,30,vicElement)
				local tName = getTeamName(getPlayerTeam(vicElement))
				if tName == "SWAT" or tName == "Police" or tName == "Military Forces" then
					exports.CSGwanted:addWanted(p,30,vicElement)
				end
               --[[ if toRobMoney >= 30000 then
                    for k,v in pairs(getElementsByType("player")) do
                        exports.dendxmsg:createNewDxMessage(v,""..getPlayerName(p).." has robbed $"..toRobMoney.." from "..vic.. "",255,255,255,255,v)
                    end
                end --]]
                robCD[p] = 30
            else
				exports.CSGscore:takePlayerScore(p,0.3)
				exports.CSGwanted:addWanted(p,31,vic)
                exports.dendxmsg:createNewDxMessage(p,"Attempt to Rob "..vic.." failed!",255,0,0)
                exports.dendxmsg:createNewDxMessage(vicElement,"You noticed "..getPlayerName(p).." trying to rob you!",255,255,0)
                outputChatBox("You noticed "..getPlayerName(p).." trying to rob you",vicElement,255,255,0,true)
				robCD[p] = 15
            end
end

function robcdManage()
    for k,v in pairs(robCD) do
       -- if isElement(k) == true then
             if v > 0 then
                robCD[k] = v-1
            end
      --  else
      --     table.remove(robCD,k)
      --  end
    end
end
setTimer(robcdManage,1000,0)

function pos(ps)
    local x,y,z = getElementPosition(ps)
    outputChatBox("general: x="..x..", y="..y..", z="..z.."",ps,0,255,0,true)
    z=z-1
    outputChatBox("markers: x="..x..", y="..y..", z="..z.."",ps,0,255,0,true)
    local rx,ry,rz = getElementRotation(ps)
    outputChatBox("rot: rx="..rx..", ry="..ry..", rz="..rz.."",ps,0,255,0,true)
end
addCommandHandler("poss",pos)

function bpos(ps)
    local x,y,z = getElementPosition(ps)
    outputChatBox("{"..x..","..y..","..z.."},",ps)
    z=z-1
    outputChatBox("{"..x..","..y..","..z.."}, (Z = Z - 1)",ps)
end
addCommandHandler("bpos",bpos)

function getElementsInRadius( Radius,toEl,el )
    if type( Radius ) == "number" and type( toEl ) == "userdata" then
        local Table = { }
        local x,y,_ = getElementPosition( toEl )
        local shape = createColCircle ( x,y,Radius )

        local function _getElementsWithinColShape ( shape,el )
            if not el then
                return getElementsWithinColShape( shape )
            end
            return getElementsWithinColShape( shape,el )
        end

        for _,v in ipairs( _getElementsWithinColShape( shape,el ) ) do
            table.insert( Table,v )
        end
        return Table
    end
    return false
end

addEvent("toggleRob",true)
addEventHandler("toggleRob",root,
function(state)
	if (state == true or state == false) then
		blockedPlayers[source] = state
		--outputDebugString(tostring(state)..", Player: "..getPlayerName(source))
	end
end)
