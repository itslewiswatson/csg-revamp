------------------
--      FFS     --
-- model: 7911  --
------------------

local SCREEN_WIDTH, SCREEN_HEIGHT = guiGetScreenSize ()

local shader, screen, texture

local SPEED = 1

addEventHandler("onClientResourceStart", resourceRoot,
	function ()

		-- Create shader
		shader, tec = dxCreateShader ("texturereplace_clamp.fx")

		if not shader then
			outputChatBox ("Could not create shader. Please use debugscript 3")
		else
			
			-- Create texture and screen source
			texture = dxCreateRenderTarget (400, 400, true)
			
			-- Set the shader's replacement texture to our newly created one
			dxSetShaderValue (shader, "gTexture", texture)			
			dxSetShaderValue (shader, "gHScale", 1)
			dxSetShaderValue (shader, "gVScale", 1)
			
			-- Apply shader to all vehicles using vehicle colors
			engineApplyShaderToWorldTexture (shader, "heat_02")
			
			loadburnTextures ()
			
			addEventHandler ("onClientHUDRender", getRootElement(), renderScreen)

		end
	end
)


local burnTex = {}
local burnId  = 1
local startTick = 0

function loadburnTextures ()
	for i = 1, 24 do
		table.insert (burnTex, dxCreateTexture ("burn/burn"..i..".png"))
	end
end


function renderScreen ()	
	local frame = math.floor (((getTickCount () * SPEED) / 150) % 24)	
	dxSetRenderTarget (texture, true)
	dxDrawImage (0, 0, 400, 400, burnTex [ frame + 1 ], 0, 0, 0)	
	dxSetRenderTarget ()
end