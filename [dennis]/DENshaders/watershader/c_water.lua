function enableWaterEffect()
	if getVersion ().sortable < "1.1.0" then
		return
	end

	myShader, tec = dxCreateShader ( "watershader/water.fx" )

	if not myShader then
		return
	else
		textureVol = dxCreateTexture ( "watershader/images/smallnoise3d.dds" );
		textureCube = dxCreateTexture ( "watershader/images/cube_env256.dds" );
		dxSetShaderValue ( myShader, "sRandomTexture", textureVol );
		dxSetShaderValue ( myShader, "sReflectionTexture", textureCube );

		engineApplyShaderToWorldTexture ( myShader, "waterclear256" )
	end
end

function disableWaterEffect()
	if ( textureVol ) and ( myShader ) and ( textureCube ) then
		destroyElement( myShader )
		destroyElement( textureVol )
		destroyElement( textureCube )
	end
end