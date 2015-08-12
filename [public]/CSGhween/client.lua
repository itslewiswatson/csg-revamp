function replaceModel()
  txd = engineLoadTXD("files/hween1.txd", 7 )
  engineImportTXD(txd, 7)
  dff = engineLoadDFF("files/hween1.dff", 7 )
  engineReplaceModel(dff, 7)
  
  txd1 = engineLoadTXD("files/hween2.txd", 10 )
  engineImportTXD(txd1, 10)
  dff1 = engineLoadDFF("files/hween2.dff", 10 )
  engineReplaceModel(dff1, 10)
  
  txd2 = engineLoadTXD("files/hween3.txd", 11 )
  engineImportTXD(txd2, 11)
  dff2 = engineLoadDFF("files/hween3.dff", 11 )
  engineReplaceModel(dff2, 11)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)

addEventHandler ( "onClientResourceStart" , resourceRoot ,
	function ( )
		liveradio = playSound3D ( "http://ministryofsound.sharp-stream.com/web/mosradiowma.asx" , 0 , 0 , 0 )
		setSoundMinDistance ( liveradio , 0 )
		setSoundMaxDistance ( liveradio , 10000 )
	end
)

addEventHandler( 'onClientRender', getRootElement( ),
    function( )
        setTime( 1, 0 )
    end
)

addEventHandler ( "onClientResourceStart" , resourceRoot ,
	function ( )
		shader , technique = dxCreateShader ( "repshader.fx" )
		if shader and technique then
			mTexture = dxCreateTexture ( "moon.png" )
			dxSetShaderValue ( shader , "CustomMoon" , mTexture )
			engineApplyShaderToWorldTexture ( shader , "coronamoon" )
		end
	end
)

--http://yp.shoutcast.com/sbin/tunein-station.pls?id=708058