-- Anti compiller
local CSGSecurity = {{{{{ {}, {}, {} }}}}}


boards = {
      
    {"north","radar_north"},
    {"moon","coronamoon"},
    {"radardisc","radardisc"},
    {"centre", "radar_centre"},

    {"bank", "radar_cash"},
    {"waypoint", "radar_waypoint"},
    {"clothes", "radar_tshirt"},
    {"car", "radar_impound"},
    {"gun", "radar_ammugun"},
    {"burger", "radar_burgershot"},
    {"spray", "radar_spray"},
    {"pizza", "radar_pizza"},
    {"chicken", "radar_chicken"},
    {"gun", "radar_emmetgun"},
    {"wrench", "radar_modGarage"},
    {"disco", "radar_dateDisco"},
    {"champagne", "radar_dateDrink"},
    {"airport", "radar_airYard"},
    {"gym", "radar_gym"},
    {"police", "radar_police"}
}


addEventHandler( "onClientResourceStart", resourceRoot,
function()
    for i = 1, #boards do
        local shader, tec = dxCreateShader ( "texreplace.fx" )
        local tex = dxCreateTexture ( "textures/"..boards[i][1]..".png" )
        engineApplyShaderToWorldTexture ( shader, boards[i][2] )
        engineApplyShaderToWorldTexture ( shader, boards[i][2].."lod" )
        dxSetShaderValue ( shader, "gTexture", tex )
    end
end)

addEventHandler( "onClientResourceStart", resourceRoot,
function()
	local shader, tec = dxCreateShader ( "uv_scroll.fx" )
	engineApplyShaderToWorldTexture ( shader, "aarprt92las" )
	engineApplyShaderToWorldTexture ( shader, "aarprt91las" )
end)
