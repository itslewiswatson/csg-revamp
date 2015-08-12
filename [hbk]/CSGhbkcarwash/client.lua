myShader = dxCreateShader( "texture.fx" )

local blip = exports.customblips:createCustomBlip ( 1911.2,-1776,10, 10, "icon.png",255 )
local blip = exports.customblips:createCustomBlip ( 2455,-1461,10, 10, "icon.png",255 )
local blip = exports.customblips:createCustomBlip ( 2162.9028320313,2474,10, 10, "icon.png",255 )

function onservershad ( )
                  --CWmarker = createObject ( 354, 1911.2,-1776,10 )

                  engineApplyShaderToWorldTexture( myShader, "vehiclegrunge256", source)
              engineApplyShaderToWorldTexture( myShader, "?emap*", source )
              setTimer(destroyElement,1800000,1,myShader,false)

end

addEvent("onservershader",true)
addEventHandler("onservershader", root, onservershad)
