local first = true
local show = true
local money = 0
local l1 = ""
local l2 = ""
local l3 = ""
local test = ""
function showDialog(m,done,success)
	if type(success) ~= "boolean" then
		if success == "fail" then
			exports.CSGpriyenmisc:playCustomSound("fail.mp3")
			l1 = "Robbery Failed"
			l2 = "Stolen $0"
			l3 = ""
			setTimer(reset,6000,1)
		end
	end
    if success == true then
        l1 = "Robbery Success"
        l2 = "Received $"..m..""
        l3 = ""
        setTimer(reset,6000,1)
		exports.CSGpriyenmisc:playCustomSound("complete.mp3")
        return
	end
    if done == true then
        l1 = "Robbery Complete"
        l2 = "Leave the Red Checkpoint"
        l3 = "Run Far Away to Get the Money"
        setTimer(reset,2000,1)
        return
    end
    if first == true then
    l1 = "Beginning Robbery"
    l2 = "Stay In The"
    l3 = "Red Checkpoint"
    first = false
    return
    end
    local money = m
    if show == true then
            l1 = "Robbery in Progress"
            l2 = "Stolen $"..money..""
            l3 = "Stay in the Red Checkpoint"
            show = false
    else
        show = true
        l1 = ""
        l2 = ""
        l3 = ""
    end
end

addEvent("CSGstoreRobberiesShowRobberyDialog",true)
addEventHandler("CSGstoreRobberiesShowRobberyDialog",localPlayer,showDialog)

function reset()
    first = true
    l1 = ""
    l2 = ""
    l3 = ""
end
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution
function draw()
    dxDrawColorText("#66FF00"..l1.."",screenWidth*0.25, screenHeight*0.30, screenWidth*0.75, screenHeight, tocolor(255,255,255,255),1.7,"pricedown","center")
    dxDrawColorText("#FF8C00"..l2.."",screenWidth*0.25, screenHeight*0.35, screenWidth*0.75, screenHeight, tocolor(255,255,255,255),1.7,"pricedown","center")
    dxDrawColorText("#FF0000"..l3.."",screenWidth*0.25, screenHeight*0.40, screenWidth*0.75, screenHeight, tocolor(255,255,255,255),1.7,"pricedown","center")
end

local rootElement = getRootElement()

addEventHandler("onClientRender",rootElement, draw) -- keep the text visible with onClientRender.


function dxDrawColorText(str, ax, ay, bx, by, color, scale, font, alignX, alignY)
  bx, by, color, scale, font = bx or ax, by or ay, color or tocolor(255,255,255,255), scale or 1, font or "default"
  if alignX then
    if alignX == "center" then
      ax = ax + (bx - ax - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font))/2
    elseif alignX == "right" then
      ax = bx - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font)
    end
  end
  if alignY then
    if alignY == "center" then
      ay = ay + (by - ay - dxGetFontHeight(scale, font))/2
    elseif alignY == "bottom" then
      ay = by - dxGetFontHeight(scale, font)
    end
  end
  local alpha = string.format("%08X", color):sub(1,2)
  local pat = "(.-)#(%x%x%x%x%x%x)"
  local s, e, cap, col = str:find(pat, 1)
  local last = 1
  while s do
    if cap == "" and col then color = tocolor(getColorFromString("#"..col..alpha)) end
    if s ~= 1 or cap ~= "" then
      local w = dxGetTextWidth(cap, scale, font)
      dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
      ax = ax + w
      color = tocolor(getColorFromString("#"..col..alpha))
    end
    last = e + 1
    s, e, cap, col = str:find(pat, last)
  end
  if last <= #str then
    cap = str:sub(last)
    dxDrawText(cap, ax, ay, ax + dxGetTextWidth(cap, scale, font), by, color, scale, font)
  end
end

