local top = {}

function didWork(p,occ,amount)
	local acc = exports.server:getPlayerAccountName(p)
	if not(top[occ]) then
		top[occ]={}
 	end
	if not(top[occ][acc]) then
		top[occ][acc]=0
	end
	top[occ][acc]=top[occ][acc]+amount
end
addEvent("CSGtopjobs.didWork",true)
addEventHandler("CSGtopjobs.didWork",root, didWork)

function view(ps,_,name)
	outputChatBox(top[name][exports.server:getPlayerAccountName(ps)],ps,0,255,0)
end
addCommandHandler("viewtopstat",view)

function mon()
	if getTime() == 0 then
 		printSeq()
	end
end
setTimer(mon,60000,0)

local accs = {}

for k,v in pairs(getElementsByType("player")) do
	if exports.server:isPlayerLoggedIn(v) then
		accs[exports.server:getPlayerAccountName(v)] = v
	end
end

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function() accs[exports.server:getPlayerAccountName(source)] = source end)

addEventHandler("onPlayerQuit",root,function() accs[exports.server:getPlayerAccountName(source)] = nil end)

function getPFromAcc(n)
	return accs[n] or false
end

function printSeq()
	local tops = {}
	for occ,t in pairs(top) do
		local largest = 0
		local acc = 0
		for user,work in pairs(t) do
			local p = getPFromAcc(user)
			if (p) then
				if isElement(p) then
					if getElementData(p,"Occupation") == occ then
						if occ == "Paramedic" then
							local money = work * 1500
							givePlayerMoney(p,money)
							triggerClientEvent(p,"CSGmedicAddStat",p,"Money earned from daily pay",money)
							exports.DENdxmsg:createNewDxMessageBot(p,">> Civilian Day Work Bonus <<",0,255,0)
							exports.DENdxmsg:createNewDxMessageBot(p,"You got $"..money.." for +"..work.." Paramedic Work in Today's Game Day",0,255,0)
						elseif occ == "Mechanic" then

						end
					end
				end
			end
			if work > largest then
				acc = user
				largest = work
			end
		end
		tops[occ]={acc,largest}
	end

	local curr = 6000
	for _,player in pairs (getElementsByType("player")) do
		--exports.DENdxmsg:createNewDxMessageBot(player,">>> Top Players of the Game Day <<<",0,255,0)
	end
	for k,v in pairs(tops) do
		setTimer(function()
			local name = v[1]
			local p = getPFromAcc(name)
			if (p) then name = getPlayerName(p) end
			for _,player in pairs (getElementsByType("player")) do
				--exports.DENdxmsg:createNewDxMessageBot(player,"Top "..k.." of the day: "..name.." with +"..v[2].." Score",0,255,0)
			end
		end,curr,1)
		curr = curr + 6000
	end
	setTimer(function()
		for _,player in pairs (getElementsByType("player")) do
			--exports.DENdxmsg:createNewDxMessageBot(player,">>> Top Players of the Game Day - Done <<<",0,255,0)
		end
	end,curr+6000,1)

	top = {}
 end
addEvent("printitnow",true)
addEventHandler("printitnow",root,printSeq)
