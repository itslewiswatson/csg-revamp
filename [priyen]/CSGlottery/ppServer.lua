local jackpot = math.random(20000,40000)
local data = {}
local cd = false

function isNumberTaken(num)
    if data[num] == nil then
        return false
    else
        return true
    end
end

function addPlayer(p,num)
    data[num] = p
end
justAD = false
function preDraw()
    local h,m = getTime()
    if h == 16 and justAD == false then
		justAD = true
		exports.dendxmsg:createNewDxMessage(root,"CSG Lotto 720 -- The next jackpot is an estimated $"..jackpot.."",0,255,0)
		exports.dendxmsg:createNewDxMessage(root,"Imagine the possibilities",0,255,0)
		exports.dendxmsg:createNewDxMessage(root,"Type /lotto 1-30 to play today!",0,255,0)
        --triggerClientEvent(root,"CSGlottory.advert",root,jackpot)
		setTimer(function() justAD = false end,60000,1)
    end
end
setTimer(preDraw,500,0)

function check()
    if cd == true then return end
    local h,m = getTime()
    if h == 18 then
        local winningNumber = math.random(1,30)
        if data[winningNumber] == nil then noWinner(winningNumber) cd = true
        setTimer(function() cd = false end,60000,1) return  end
        local p = accToPlayer[data[winningNumber]]
        if isElement(p) and getElementType(p) == "player" then
            winner(p,winningNumber)
        else
            noWinner(winningNumber)
        end
        cd = true
        setTimer(function() cd = false end,60000,1)
    end
end
setTimer(check,5000,0)

accToPlayer = {}
function noWinner(num)
    if jackpot < 200000 then
        jackpot = jackpot + math.random(5000,5000)
    end
        exports.dendxmsg:createNewDxMessage(root,"CSG Lotto 720 -- The Winning Number was : "..num.."",0,255,0)
        exports.dendxmsg:createNewDxMessage(root,"No Lotto Winner -- Jackpot has been increased to $"..jackpot.."",0,255,0)
    data = {}
end

function winner(p,num)
    local winnerName = getPlayerName(p)
	exports.CSGscore:givePlayerScore(p,10)
    exports.CSGhelp:setBottomTextServer(root,"CSG Lotto 720 -- #FFFFFF The Winning Number was : "..num.."",0,255,0)
    exports.CSGhelp:setBottomTextServer(root,"Congraulations to "..winnerName.." For winning the $"..jackpot.." Jackpot!",0,255,0)
 	givePlayerMoney(p,jackpot,"Lotto winner")
    jackpot = math.random(20000,30000)
    data = {}
end

function doesPlayerAlreadyHaveANumber(user)
    for k,v in pairs(data) do
        if v == user then return k end
    end
    return false
end

function doCommandLotto(ps,commandName,arg1)
	if exports.server:isPlayerLoggedIn(ps) == false then return end
    if (arg1) then
        local num = tonumber(arg1)
        if type(num) == "number" then
            if getPlayerMoney(ps) < 500 then  exports.dendxmsg:createNewDxMessage(ps,"You need $500 to order a CSG Lotto 720 Ticket. You only have $"..getPlayerMoney(ps).."",255,0,0) return end
            local i = doesPlayerAlreadyHaveANumber(exports.server:getPlayerAccountID(ps))
            if type(i) == "number" and i ~= nil and i ~= false then
                exports.dendxmsg:createNewDxMessage(ps,"You already have a number ("..i..") in the lottery. The next draw is at 18:00.",255,255,0)
                return
            end
            if num > 0 and num < 31 then
                if isNumberTaken(num) == false then
                    addPlayer(exports.server:getPlayerAccountID(ps),num)
                    takePlayerMoney(ps,500)
					accToPlayer[exports.server:getPlayerAccountID(ps)] = ps
                    exports.dendxmsg:createNewDxMessage(ps,"Congraulations! You are now ready for the next draw.",0,255,0)
					exports.dendxmsg:createNewDxMessage(ps,"Bought CSG Lotto 720 # "..num.." for $500. Next draw is at 18:00!",0,255,0)
                else
                     exports.dendxmsg:createNewDxMessage(ps,""..num.." is already taken, try another number.",255,0,0)
                end
            else
                exports.dendxmsg:createNewDxMessage(ps,"The only lottery numbers are 1-30!",255,0,0)
            end
        end
    else
        outputChatBox("Syntax: /lotto number ( Any number from 1-30 )",ps,255,0,0)
    end
end
addCommandHandler("lotto",doCommandLotto)
addCommandHandler("Lotto",doCommandLotto)

addEventHandler("onPlayerLogin",root,function()
	accToPlayer[exports.server:getPlayerAccountID(source)] = source
end)
