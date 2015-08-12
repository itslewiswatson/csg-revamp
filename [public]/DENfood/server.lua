local ratios = {}

function buySmallMenu ()
	local ratio = 1
	local int,dim = getElementInterior(source),getElementDimension(source)
	if ratios[int] ~= nil then if ratios[int][dim] ~= nil then ratio=ratios[int][dim] end end
setElementHealth (source, getElementHealth(source) + 5*ratio)
--if ( exports.CSGgift:getChristmasDay() == "Day7" ) then return end
takePlayerMoney (source, 10)
end

function buyMediumMenu ()
local ratio = 1
	local int,dim = getElementInterior(source),getElementDimension(source)
	if ratios[int] ~= nil then if ratios[int][dim] ~= nil then ratio=ratios[int][dim] end end
setElementHealth (source, getElementHealth(source) + 10*ratio)
--if ( exports.CSGgift:getChristmasDay() == "Day7" ) then return end
takePlayerMoney (source, 20)
end

function buyBigMenu ()
local ratio = 1
	local int,dim = getElementInterior(source),getElementDimension(source)
	if ratios[int] ~= nil then if ratios[int][dim] ~= nil then ratio=ratios[int][dim] end end
setElementHealth (source, getElementHealth(source) + 15*ratio)
--if ( exports.CSGgift:getChristmasDay() == "Day7" ) then return end
takePlayerMoney (source, 30)
end

function buySprunkDrink ()
setElementHealth (source, getElementHealth(source) + 3)
--if ( exports.CSGgift:getChristmasDay() == "Day7" ) then return end
takePlayerMoney (source, 7)
end

function buyDonut()
setElementHealth (source, getElementHealth(source) + 10)
--if ( exports.CSGgift:getChristmasDay() == "Day7" ) then return end
takePlayerMoney (source, 20)
end
addEvent ("buyDonut", true)
addEventHandler ("buyDonut", getRootElement(), buyDonut)
addEvent ("buySmallMenu", true)
addEventHandler ("buySmallMenu", getRootElement(), buySmallMenu)
addEvent ("buyBigMenu", true)
addEventHandler ("buyBigMenu", getRootElement(), buyBigMenu)
addEvent ("buyMediumMenu", true)
addEventHandler ("buyMediumMenu", getRootElement(), buyMediumMenu)
addEvent ("buySprunkDrink", true)
addEventHandler ("buySprunkDrink", getRootElement(), buySprunkDrink)

function setHealthRatioForIntDim(int,dim,ratio)
	if ratios[int] == nil then ratios[int] = {} end
	ratios[int][dim]=ratio
end

local canEnter = {}
addEvent("onInteriorHit",true)
addEventHandler("onInteriorHit",root,function(p)
	if exports.DENlaw:isPlayerLawEnforcer(p) == true then return end
	local int = source
	source=p
	local id = getElementData(int,"id")
	local inti = getElementData(int,"interior")

	for k,v in pairs(getElementsByType("interiorReturn")) do
		if getElementData(v,"refid") == id then
			inti = getElementData(v,"interior")
			break
		end
	end
	inti = tonumber(inti)
	if inti == 5 or inti == 9 or inti == 10 then
		if getElementInterior(source) == 0 then
			local acc = exports.server:getPlayerAccountName(source)
			if canEnter[acc] == nil then canEnter[acc] = true end
			if canEnter[acc] == false then
				cancelEvent()
				exports.DENdxmsg:createNewDxMessage(source,"You cannot enter here rightnow. You can only enter a food store once per 5 minutes in LV!",255,0,0)
			else
				canEnter[acc]=false
				setTimer(function()
					canEnter[acc]=true
				end,300000,1)
			end
		end
	end
end)
