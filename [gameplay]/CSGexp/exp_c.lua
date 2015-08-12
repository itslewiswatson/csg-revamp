local earned = 0
local level = 0
local alpha = 0
local visible = false
local visible2 = false
local scale = 1.3
local font = "pricedown"
local exp = 0
local expNeeded = 0
local levelAlpha = 0
local tLevel = ""

addEventHandler("onClientRender",root,
function()
	local rX,rY = guiGetScreenSize()
	local width,height = dxGetTextWidth(earned), dxGetFontHeight(scale,font)
	local X_l = (rX/2) - (width/2)
	local X_r = (rX/2) - (width/2)
	local Y_t = (rY/10) - (height/2)
	local Y_b = (rY/2) - (height/2)
	dxDrawText("+"..earned,X_l,Y_t,X_r,Y_b,tocolor(255,255,0,alpha),scale,font,"center","center",true,false,true,true,false)
end)

addEventHandler("onClientRender",root,
function()
	local rX,rY = guiGetScreenSize()
	local width,height = rX,35
	local X,Y = (rX/2) - (width/2),(rY/1.02) - (height/2) --CENTERED AT THE BOTTOM
	dxDrawRectangle(X,Y,width,height,tocolor(0,0,0,alpha),true)
	
	local width,height = rX-10,25
	local X,Y = (rX/2) - (width/2),(rY/1.02) - (height/2)
	dxDrawRectangle(X,Y,width,height,tocolor(128,128,128,alpha),true)
	
	local width,height = ((exp-0.9)/expNeeded)*rX-10,25
	local X,Y = (rX/2)-(width/2),(rY/1.02)-(height/2)
	dxDrawRectangle(X,Y,width,height,tocolor(0,255,0,alpha),true)
	
	local width,height = 5,25
	local X,Y = (rX/2) - (width/2),(rY/1.02) - (height/2)
	dxDrawRectangle(X,Y,width,height,tocolor(0,0,0,alpha),true)
	
	local text = "Only "..expNeeded-exp.." EXP to go!"
	local width,height = dxGetTextWidth(text), dxGetFontHeight(scale,font)
	local X_l = (rX/1.75) - (width/2)
	local X_r = (rX/2) - (width/2)
	local Y_t = (rY/0.7) - (height/2)
	local Y_b = (rY/2) - (height/2)
	dxDrawText(text,X_l,Y_t,X_r,Y_b,tocolor(0,255,0,alpha),scale,font,"center","center",true,false,true,true,false)
end)

addEventHandler("onClientRender",root,
function()
	local rX,rY = guiGetScreenSize()
	local width,height = dxGetTextWidth(tLevel),dxGetFontHeight(scale,font)
	local X_l = (rX/2)-(width/2)
	local X_r = (rX/2)-(width/2)
	local Y_t = (rY/2) - (height/2)
	local Y_b = (rY/2) - (height/2)
	dxDrawText("LEVELED UP!\nLEVEL: "..level,X_l,Y_t,X_r,Y_b,tocolor(255,255,255,levelAlpha),scale,font,"center","center",true,false,true,true,false)
	--outputDebugString(levelAlpha)
end)

local output = 0
function startFadingSequence()
	if not output == 0 then outputDebugString("Starting fade.") output = 1 end
	outputDebugString(alpha)
	if not (alpha < 1) then
		alpha = alpha - 1
		visible = true
	else
		removeEventHandler("onClientRender",root,startFadingSequence)
		output = 0
		visible = false
	end
end

local output2 = 0
function startFadingSequence2()
	if not output2 == 0 then outputDebugString("Starting fade.") output2 = 1 end
	outputDebugString(levelAlpha)
	if not (levelAlpha < 1) then
		levelAlpha = levelAlpha - 1
		visible2 = true
	else
		removeEventHandler("onClientRender",root,startFadingSequence2)
		output = 0
		visible2 = false
	end
end

function prepEXP(texp,tearned,tneeded,tlevel)
	if (texp) and (tearned) and (tneeded) and (tlevel) then
		exp = texp
		expNeeded = tneeded
		earned = tearned
		level = tlevel
		--outputChatBox(exp.." "..expNeeded.." "..earned.." "..level)
		if (visible) then
			removeEventHandler("onClientRender",root,startFadingSequence)
		end
		alpha = 255
		addEventHandler("onClientRender",root,startFadingSequence)
	else
		return false
	end
end
addEvent("onEXPEarned",true)
addEventHandler("onEXPEarned",root,prepEXP)

function onPlayerLevelUp(level)
	player = source
	--draw the stuff--
	tLevel = level
	if (visible2) then
		removeEventHandler("onClientRender",root,startFadingSequence2)
	end
	addEventHandler("onClientRender",root,startFadingSequence2)
	levelAlpha = 255
	playSound("sound/levelup.ogg",false)
	--outputChatBox("LEVELD UP!")
end
addEvent("onPlayerLevelUp",true)
addEventHandler("onPlayerLevelUp",root,onPlayerLevelUp)