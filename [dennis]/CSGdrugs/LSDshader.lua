local lsdShader = {}
local LSDshader
local tec1
local lsdTimer
local started=false
function startLSD()
	if started==true then return end
	if (not isElement(LSDshader)) then
		started=true
		lsdShader = {}
		LSDshader, tec1 = dxCreateShader("shaders/block_world.fx")
		if (LSDshader) then
			for c=65,96 do
				local clone = dxCreateShader("shaders/block_world.fx")
				engineApplyShaderToWorldTexture(clone, string.format("%c*", c + 32))
				engineRemoveShaderFromWorldTexture(clone, "tx*")
				lsdShader[#lsdShader+1] = clone
			end
		end
		colorize()
		changeSky()

	end
end

function stopLSD()

	for a,b in pairs(lsdShader) do
		destroyElement(b)
	end
	lsdShader = {}
	tec1 = nil
	LSDshader = nil
	if (lsdTimer) then
		killTimer(lsdTimer)
		started=false
	end
	
	resetSkyGradient()
end

function colorize()
	for _,shader in pairs(lsdShader) do
		local r,g,b = 0,0,0
		while (r+g+b < 2) do
			r,g,b = math.random(0.25,1.25),math.random(0.25,1.25),math.random(0.25,1.25)
		end
		if (isElement(shader)) then
			dxSetShaderValue(shader, "COLORIZE", r, g, b)
		end
	end
	if (LSDshader) then
		lsdTimer = setTimer(colorize, 50, 1)
	end
end

function changeSky()
	setSkyGradient(math.random(255),math.random(255),math.random(255),math.random(255),math.random(255),math.random(255))
end