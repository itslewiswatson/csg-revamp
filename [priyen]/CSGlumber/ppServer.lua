local treeE = {}
local peds = {}
local trees = {}
local made = {}
local treei={}
local addX={
	[696]=0.5
}
local addY={
	[696]=0
}


addEventHandler("onPlayerWeaponSwitch",root,function(i)
	if getElementData(source,"Occupation") == "Lumberjack" and getTeamName(getPlayerTeam(source)) == "Civilian Workers" then
		setTimer(function() if isElement(source) then giveWeapon(source,9,1,true) end end,500,1)
	end
end)

local lumberRanks = {
	{"Wood Collector",0},
	{"Seasonal Woodcutter",50},
	{"Constant Lumberjack",450},
	{"Forest Woodcutter",1000},
	{"Head Lumberjack",2000},
	{"Lumberjack at Charge",2500},
	{"Senior Woodcutter",3600},
	{"Lead Lumberjack",5000},
	{"Wooden King",7000},
}


function pedWasted(_,killer)
	if getElementData(killer,"Occupation") == "Lumberjack" then
		exports.DENdxmsg:createNewDxMessage(killer,"Cut down a tree : Paid $400",0,255,0)
		givePlayerMoney(killer,400)
		exports.DENstats:setPlayerAccountData(killer,"lj",exports.DENstats:getPlayerAccountData(killer,"lj")+1)
		local pts = exports.DENstats:getPlayerAccountData(killer,"lj")
		local bonus = 0
		local name,num,maxx = exports.csgranks:getRank(killer,"Lumberjack")
		bonus=(num-1)*(4)
		if bonus > 0 then
			givePlayerMoney(killer,math.floor(400*(bonus/100)))
			exports.DENdxmsg:createNewDxMessage(killer,"Rank Bonus: $"..math.floor(400*(bonus/100)).."",0,255,0)
		end
	end
	local deadCount=0
	local tree = peds[source]
	for k,v in pairs(peds) do
		if v==tree then destroyElement(k) end
	end
	local x,y,z = getElementPosition(tree)
	local model = getElementModel(tree)
	made[treei[tree]]=false

	tc("remTree",tree)
	destroyElement(tree)
	tc("treeFall",model,x,y,z)
	makeTree(math.random(#trees))
end

function circle(r,s,cx,cy)
	xVals = {}
	yVals = {}
	for i=1,s-1 do
		xVals[i] = (cx+r*math.cos(math.pi*i/s*2-math.pi/2))
		yVals[i] = (cy+r*math.sin(math.pi*i/s*2-math.pi/2))
	end
end

function makeTree(i)
	if made[i] then return end
	local x,y,z = unpack(trees[i])
	local model = 696
	made[i]=true

	x=x-3
	local tree=createObject(model,x,y,z)
	treei[tree]=i
	local x,y,z = getElementPosition(tree)
	x=x+addX[model]
	y=y+addY[model]
	circle(1.5,6,x,y)
	for k,v in pairs(xVals) do
		x,y=v,yVals[k]
		local ped = createPed(0,x,y,z)
		setElementAlpha(ped,0)
		setElementFrozen(ped,true)
		setElementData(ped,"l",true)
		peds[ped]=tree
		addEventHandler("onPedWasted",ped,pedWasted)
	end
	tc("recTree",tree)
end
addCommandHandler("mt",makeTree)

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	for k,v in pairs(treei) do
		if isElement(k) then
			triggerClientEvent(source,"recTree",source,k)
		end
	end
end)

function tc(nam, ... )
	for k,v in pairs(getElementsByType("player")) do
		triggerClientEvent(v,nam,v, ... )
	end
end

--[[
addEvent("desTree",true)
addEventHandler("desTree",root,function(e) destroyElement(e) end)
--]]
    --[[local file = xmlLoadFile("pos.xml")
    if not file then file = xmlCreateFile("pos.xml",'positions') end

    addCommandHandler('maptree',
    function (pSource)
    local x,y,z = getElementPosition(pSource)
    local node = xmlCreateChild(file,'position')
    xmlNodeSetAttribute(node,'x',x)
    xmlNodeSetAttribute(node,'y',y)
    xmlNodeSetAttribute(node,'z',z)
    xmlSaveFile(file)
	createMarker(x,y,z,"arrow",1)
    end)
--]]

function loads()
	local rootnode = xmlLoadFile("pos.xml")

	for i,pos in ipairs(xmlNodeGetChildren(rootnode)) do
		local x = xmlNodeGetAttribute(pos,"x")
		local y = xmlNodeGetAttribute(pos,"y")
		local z = xmlNodeGetAttribute(pos,"z")

		trees[i]={x,y,z}
	end

	for i=1,40 do
		makeTree(math.random(#trees))
	end
end
setTimer(function()
loads()
end,5000,1)

