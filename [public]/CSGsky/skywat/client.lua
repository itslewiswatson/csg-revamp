gMe = getLocalPlayer()

function Ryan ()

setTimer (Timer, 2000, 0)

	tekstura = engineLoadTXD("vgehshade.txd") 
	engineImportTXD(tekstura, 3458 )


	lotnisko = createObject (8355, -2216.1711425781, -3582.14453125, 109.7142791748, 289.91998291016, 180, 0)


	
	setElementAlpha (lotnisko, 0)

	
	Budynek1 = createObject (8498, 4694.9072265625, 286.7301940918, 24.264915466309, 0, 0, 157.48815917969)
	Budynek2 = createObject (8498, 4622.591796875, 286.20028686523, 23.383708953857, 0, 0, 247.21337890625)
	Shade = createObject (3458, 4662.1098632813, 784.00939941406, 17.165580749512, 60, 0)



	
	setElementCollisionsEnabled (Budynek1, false)
	setElementCollisionsEnabled (Budynek2, false)
	setElementCollisionsEnabled (Shade, false)

	
	setTime (23, 0)
	setWeather (17)
	setWaveHeight ( 0 )	
	
	
	setCloudsEnabled ( false ) 

end

function Timer()
    setTime (23, 0)
	setWeather (17)
	setWaveHeight ( 0 )	
	
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Ryan )