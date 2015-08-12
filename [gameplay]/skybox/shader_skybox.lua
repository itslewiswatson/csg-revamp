-- Shader SKYBOX v1.05 by Ren712
-- knoblauch700@o2.pl

-- Adjust sphere object size (depending on the weather, game mode etc)
local skybox_scale = 3200

local getLastTick, getLastTock = 0,0
local skybox_shader, technique = dxCreateShader ( "shader_skybox.fx" )

function startShaderResource()
 -----------------------------------------------------
 -- apply shader
 if not skybox_shader then 
  outputChatBox('Could not start Skybox shader!')
  return 
  else
  outputChatBox('Using technique '..technique)
 end
 local textureSkybox= dxCreateTexture ( "textures/skybox.dds" )
 dxSetShaderValue ( skybox_shader, "sSkyBoxTexture", textureSkybox )
 -- brighten (-1,1) 
 dxSetShaderValue ( skybox_shader, "gBrighten", 0)
 -- enable alpha 1-true 0-false
 dxSetShaderValue ( skybox_shader, "gEnAlpha", 1)
 -- invert time cycle (0-normal/24h sky 1-nightsky)
  dxSetShaderValue ( skybox_shader, "gInvertTimeCycle", 0)
 -- apply to texture
 engineApplyShaderToWorldTexture ( skybox_shader, "skybox_tex" )
 -----------------------------------------------------
 -- apply model
 txd_skybox = engineLoadTXD('models/skybox_model.txd')
 engineImportTXD(txd_skybox, 14538)
 dff_skybox = engineLoadDFF('models/skybox_model.dff', 14538)
 engineReplaceModel(dff_skybox, 14538)  
-- at the first time we will take player coordinates instead of camera coordinates
 local cam_x,cam_y,cam_z = getElementPosition(getLocalPlayer())
 skyBoxBoxa = createObject ( 14538, cam_x, cam_y, cam_z, 0, 0, 0, true )
-- Scale the spheric object on which the skybox is drawn
-- The bigger value, the bigger max distance 
 setObjectScale ( skyBoxBoxa, skybox_scale )
-- setCloudsEnabled(false) -- why doesn't it work ?
 setWeather(12) -- works great with setWeather 17 and 12 at theese settings

addEventHandler ( "onClientHUDRender", getRootElement (), renderSphere ) -- draw skybox
addEventHandler ( "onClientHUDRender", getRootElement (), renderTime ) -- add timecycle 
end

function renderTime()
 -- Darken the skybox at night (pause 300)
 local hour, minute = getTime ( )
 if getTickCount ( ) - getLastTick < 300  then return end
 if not skybox_shader then return end
 if hour >= 20 then
  local dusk_aspect = ((hour-20)*60+minute)/240
  dusk_aspect = -dusk_aspect
  dxSetShaderValue ( skybox_shader, "gBrighten", dusk_aspect)
 end
	
 if hour <= 2 then
  dxSetShaderValue ( skybox_shader, "gBrighten", -1)
 end
	
 if hour > 2 and hour <= 6 then
  local dawn_aspect = ((hour-3)*60+minute)/180
  dawn_aspect = -(1 - dawn_aspect)
  dxSetShaderValue ( skybox_shader, "gBrighten", dawn_aspect)
 end
	
 if hour > 6 and hour < 20 then
  dxSetShaderValue ( skybox_shader, "gBrighten", 0)
 end

 getLastTick = getTickCount ()
end

function renderSphere()
 -- Updates the position of the sphere object (pause 30)
 if getTickCount ( ) - getLastTock < 30  then return end
 -- Set the skybox model position accordingly to the camera position
 local cam_x, cam_y, cam_z, lx, ly, lz = getCameraMatrix()
 setElementPosition ( skyBoxBoxa, cam_x, cam_y, cam_z ,false )
 getLastTock = getTickCount ()
end

addEventHandler("onClientResourceStart", getResourceRootElement( getThisResource()), startShaderResource)
