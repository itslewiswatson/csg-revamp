--
-- c_uv_scripted.lua
--


local myShader
local startTickCount

addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		-- Create shader
		myShader, tec = dxCreateShader ( "uv_scripted.fx" )

		-- Create texture and add to shader
		local myTexture = dxCreateTexture ( "images/env3.bmp" );
		dxSetShaderValue ( myShader, "CUSTOMTEX0", myTexture );

		if not myShader then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
			outputChatBox( "Using technique " .. tec )

			-- Apply to world texture
			engineApplyShaderToWorldTexture ( myShader, "bobo_2" )

			-- Create object with model 4729 (billboard)
			local x,y,z = getElementPosition( getLocalPlayer() )
			createObject ( 4729, x-15, y, z+3 )

			-- Begin updates for UV animation
			startTickCount = getTickCount()
			addEventHandler( "onClientRender", root, updateUVs )
		end
	end
)


------------------------------------------------------
-- Update
------------------------------------------------------
function updateUVs()
	-- Valide shader to save bazillions of warnings
	if not isElement( myShader ) then return end

	-- Calc how many seconds have passed since uv anim started
	local secondsElapsed = ( getTickCount() - startTickCount ) / 1000

	-- Calc section (0-6) and time (0-1) within the section
	local timeLooped = ( secondsElapsed / 2 ) % 6
	local section = math.floor ( timeLooped )
	local time = timeLooped % 1

	-- Figure out what uv anims to do
	local bScrollLeft = section == 0 or section == 3 or section == 4 or section == 6
	local bWobbleRotate = section == 1 or section == 3 or section == 5 or section == 6
	local bGoneAllZoomy = section == 2 or section == 4 or section == 5 or section == 6

	local u,v = 0, 0
	local angle = 0
	local scale = 1

	-- Do uv anims
	if bScrollLeft then
		u = time
	end
	if bWobbleRotate then
		angle = math.sin(time/2*6.28)/4
	end
	if bGoneAllZoomy then
		scale = math.cos(time*6.28) * 0.5 + 0.5
	end

	-- Apply uv anims
	dxSetShaderValue ( myShader, "gUVPosition", u,v );
	dxSetShaderValue ( myShader, "gUVRotAngle", angle );
	dxSetShaderValue ( myShader, "gUVScale", scale, scale );
end
