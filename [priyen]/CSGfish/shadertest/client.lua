texShader = dxCreateShader ( "texreplace.fx" )
moonTexture = dxCreateTexture("pic.png") -- Replace the filename to your image's file obviously

dxSetShaderValue(texShader,"gTexture",moonTexture)

engineApplyShaderToWorldTexture(texShader,"billbrd01_lan")
