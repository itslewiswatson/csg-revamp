local visible = false
local credits = 0 --BY DEFAULT
local totalCredits = 0 --BY DEFAULT
local moneySpent = 0 --BY DEFAULT
local itempackages = 0 --BY DEFAULT
local accountID = nil
local accountName = nil

function absoluteToRelativ2( X, Y )
    local rX, rY = guiGetScreenSize()
    local x = math.floor(X*rX/rX)
    local y = math.floor(Y*rY/rY)
    return x, y
end

function setColorByMoneyBase(money)
	if money < 20 then
		return "#00FF00" --GREEN
	elseif money > 20 and money < 10 then
		return "#FFFF00" --YELLOW
	elseif money > 10 then
		return "#FF0000" --RED
	else
		return "#FF0000" --RED BY DEFAULT
	end
end

function setColorByCreditsBase(credits)
	if credits > 20 then
		return "#00FF00" --GREEN
	elseif credits < 20 and credits > 10 then
		return "#FFFF00" --YELLOW
	elseif credits < 10 then
		return "#FF0000" --RED
	else
		return "#FF0000" --RED BY DEFAULT
	end
end

function main()
	--WINDOW--
	x,y = absoluteToRelativ2(342,307)
	width,height = absoluteToRelativ2(574,376)
	dxDrawRectangle(x,y,width,height, tocolor(0, 0, 0, 158), true) --window
	--TITLE--
	x,y = absoluteToRelativ2(350,316)
	width,height = absoluteToRelativ2(904,366)
	dxDrawText("Credits ~ Main", x,y,width,height, tocolor(255, 255, 255, 255), 2, "bankgothic", "center", "center", false, false, true, false, false)
	--ACCOUNT INFO--
	x,y = absoluteToRelativ2(347,658)
	width,height = absoluteToRelativ2(907,681)
	dxDrawText("Account: "..tostring(accountName)..", ID: "..tostring(accountID), x,y,width,height, tocolor(255, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	--LINE UNDER TITLE--
	x,y = absoluteToRelativ2(348,368)
	width,height = absoluteToRelativ2(908,368)
	dxDrawLine(x,y,width,height, tocolor(255, 255, 255, 255), 1, true)
	--CREDITS LABEL--
	x,y = absoluteToRelativ2(348,384)
	width,height = absoluteToRelativ2(499,409)
	dxDrawText("Credits:"..setColorByCreditsBase(credits).." "..credits, x,y,width,height, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "center", false, false, true, true, false)
	--TOTAL CREDITS LABEL--
	x,y = absoluteToRelativ2(348,437)
	width,height = absoluteToRelativ2(580,460)
	dxDrawText("Total credits spent:#00FF00 "..totalCredits, x,y,width,height, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "center", false, false, true, true, false)
	--TOTAL MONEY LABEL--
	x,y = absoluteToRelativ2(348,487)
	width,height = absoluteToRelativ2(581,510)
	dxDrawText("Total money spent:"..setColorByMoneyBase(moneySpent).." £"..moneySpent, x,y,width,height, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "center", false, false, true, true, false)
	if (credits < 20) then
		x,y = absoluteToRelativ2(499,384)
		width,height = absoluteToRelativ2(806,409)
		dxDrawText("Need more credits? contact staff for information.", x,y,width,height, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, true, false)
	end
	--TOTAL ITEM/PACKAGE LABEL--
	x,y = absoluteToRelativ2(347,531)
	width,height = absoluteToRelativ2(581,557)
	dxDrawText("Total items/packages bought:#FFFF00 "..itempackages, x,y,width,height, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "center", false, false, true, true, false)
	if (totalCredits > 50) then
		x,y = absoluteToRelativ2(581,437)
		width,height = absoluteToRelativ2(888,462)
		dxDrawText("Spending too much? try our Premium packages.", x,y,width,height, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, true, false)
	end
	--INFO LABEL--
	x,y = absoluteToRelativ2(347,637)
	width,height = absoluteToRelativ2(555,658)
	dxDrawText("type: /credits to turn off this GUI.", x,y,width,height, tocolor(200, 0, 0, 255), 1, "default", "center", "center", false, false, true, false, false)
	if (moneySpent > 20) then
		x,y = absoluteToRelativ2(581,537)
		width,height = absoluteToRelativ2(888,462)
		dxDrawText("Spending too much money? Try our Premium packages.",x,y,width,height,tocolor(255,255,255,255),1,"default-bold","center","center",false,false,true,false,false)
	end
end

addEvent("openCreditsMain",true)
addEventHandler("openCreditsMain",root,
function(credit,total,spent,items,id,name)
	if visible == false then
		credits = credit
		totalCredits = total
		moneySpent = spent
		itempackages = items
		accountID = id
		accountName = name
		addEventHandler("onClientRender",root,main)
		visible = true
	else
		removeEventHandler("onClientRender",root,main)
		visible = false
	end
end)