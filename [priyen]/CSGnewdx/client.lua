--[[--------------------------------------------------
	GUI Editor
	client
	context_bar.lua

	manages the context bar for the editor
	(the bar at the bottom of the screen)
--]]--------------------------------------------------
gEnabled=true
gScreen = {}
gScreen.x,gScreen.y = guiGetScreenSize()
ContextBar = {
	height = 28,
	speed = 20,
	step = -2,
	life = 5000,
	update = 0,
	textColour = {255,255,0,100},
	lineColour = {0, 0, 0},
	entries = {}
}

function math.lerp(from, to, t)
    return from + (to - from) * t
end

function ContextBar.add2(_,text)
	ContextBar.add(text)
end

function ContextBar.add(text)
	if not gEnabled then
		return
	end

	local y = gScreen.y - ContextBar.height
	y = gScreen.y - (#ContextBar.entries*ContextBar.height)-28
	y = gScreen.y-y
	if #ContextBar.entries > 0 then
		if ContextBar.entries[#ContextBar.entries].text == text then
			return
		end

		--y = ContextBar.entries[#ContextBar.entries].y - ContextBar.height
	end
	--y=gScreen.y-y
	local pixelsPerSecond = (1000 / ContextBar.speed) * ContextBar.step
	local alphaStep = -((y + ContextBar.height) / pixelsPerSecond)/2

	ContextBar.entries[#ContextBar.entries + 1] = {
		text = text,
		creation = getTickCount(),
		y = y,
		landed = false,
		alphaStep = alphaStep == 0 and 0.05 or (1 / ((alphaStep * 1000) / ContextBar.speed)),
		alpha = alphaStep == 0 and 1 or 0,
	}
end

addCommandHandler("dx",ContextBar.add2)

addEventHandler("onClientRender", root,
	function()
		for _,bar in ipairs(ContextBar.entries) do
			dxDrawRectangle(0, bar.y, gScreen.x, ContextBar.height, tocolor(0, 0, 0, math.lerp(0, 170, bar.alpha)), true)
			dxDrawText(bar.text, 0, bar.y, gScreen.x, bar.y + ContextBar.height, tocolor(ContextBar.textColour[1], ContextBar.textColour[2], ContextBar.textColour[3], math.lerp(0, 255, bar.alpha)), 1, "default-bold", "center", "center", true, true, true)

			dxDrawLine(0, bar.y, gScreen.x, bar.y, tocolor(ContextBar.lineColour[1], ContextBar.lineColour[2], ContextBar.lineColour[3], math.lerp(0, 255, bar.alpha)), 1, true)
		end

		local tick = getTickCount()

		if tick > (ContextBar.update + ContextBar.speed) then
			ContextBar.update = tick

			if #ContextBar.entries > 0 then
				for i = 1,#ContextBar.entries do
					if ContextBar.entries[i].y < -28 then
						table.remove(ContextBar.entries, i)
					else
						local num = (i*28)-28
						if ContextBar.entries[i].y > num then
						ContextBar.entries[i].alpha = math.min(1, ContextBar.entries[i].alpha + ContextBar.entries[i].alphaStep)
						ContextBar.entries[i].y = ContextBar.entries[i].y + ContextBar.step
						end
						if ContextBar.entries[i].y == 0 then ContextBar.entries[i].landed=true end
						-- make sure we always align the last in the list exactly with the bottom of the screen
						if i ~= 1 and #ContextBar.entries == 2 and ContextBar.entries[i].y > (gScreen.y - ContextBar.height) then
							ContextBar.entries[i].y = gScreen.y - ContextBar.height
						end
					end
				end
			end
			if ContextBar.entries[1] ~= nil then
				if not ContextBar.entries[1].landed then
					ContextBar.entries[1].landed = true
					ContextBar.entries[1].creation = tick
				end

				if tick > (ContextBar.entries[1].creation + ContextBar.life) then
					ContextBar.entries[1].alpha = ContextBar.entries[1].alpha - ContextBar.entries[1].alphaStep

					if ContextBar.entries[1].alpha <= 0 then
						--ContextBar.entries[1] = nil
						table.remove(ContextBar.entries,1)
					end
				end
			end --]]
		end
	end
)
