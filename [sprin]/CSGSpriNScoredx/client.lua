crash = {{{{{{{{ {}, {}, {} }}}}}}}}
draw = false
function showscore()
thePlayer = getLocalPlayer() 
	if draw == false then
		if getPlayerWantedLevel(thePlayer) == 0 then
			label1 = guiCreateLabel(0.8836,0.2266,0.0666,0.0573,"",true)
			guiSetAlpha(label1,0.69999998807907)
			guiSetFont(label1,"sa-header")

			label2 = guiCreateLabel(0.7796,0.224,0.0908,0.0625,"Score:",true)
			guiSetAlpha(label2,0.69999998807907)
			guiLabelSetColor(label2,255, 200, 70)
			guiSetFont(label2,"sa-header")
			draw = true
		else
			label1 = guiCreateLabel(0.8792,0.2747,0.0864,0.0573,"",true)
			guiSetAlpha(label1,0.69999998807907)
			guiSetFont(label1,"sa-header")

			label2 = guiCreateLabel(0.7811,0.2695,0.0952,0.0794,"Score:",true)
			guiSetAlpha(label2,0.69999998807907)
			guiLabelSetColor(label2,255, 200, 70)
			guiSetFont(label2,"sa-header")
			draw = true
		end
			tmr = setTimer(function (thePlayer)
				thePlayer = getLocalPlayer()
				local score = getElementData(thePlayer, "playerScore")
				if score then
					guiSetText(label1,tostring(score))
				end
			end
			, 1000, 0)
	else
		killTimer(tmr)
		destroyElement(label1)
		destroyElement(label2)
		draw = false
	end
end
addCommandHandler("showscore", showscore)
bindKey("F10","up", showscore)


addCommandHandler("myscore", function (thePlayer)
thePlayer = getLocalPlayer()
local score = getElementData(thePlayer, "playerScore")
outputChatBox("Your Score is: " ..tostring(score),0,255,0, true)
end)

addEventHandler("onClientResourceStart",getRootelement(), function(startedResource)
	if startedResource == getThisResource() then
		showscore()
	end
end)

addEventHandler("onClientPlayerJoin", getRootElement(), function()
	if source == localPlayer then
		showscore()
	end
end)


if fileExists("client.lua") == true then
	fileDelete("client.lua")
end