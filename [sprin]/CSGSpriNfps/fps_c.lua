local root = getRootElement()
local player = getLocalPlayer()
local counter = 0
local starttick
local currenttick
exports [ "scoreboard" ]:scoreboardAddColumn ( "FPS", 25, FPS, 11 )
addEventHandler("onClientRender",root,
	function()
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			setElementData(player,"FPS",counter)
			counter = 0
			starttick = false
		end
	end
)
