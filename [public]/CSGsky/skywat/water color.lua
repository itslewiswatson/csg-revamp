function yo()
setWaterColor(math.random (0,255), math.random (0,255), math.random (0,255))
end
setTimer ( yo, 200, 0 )

addEventHandler ( "onResourceStart", root, yo )


