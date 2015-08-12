

LSped = createPed( 2, 1689, -1950, 14, -95 )
SFped = createPed( 2, -1975.2877197266,119,27.5, -90 )
LVped = createPed( 2, 1437.2, 2620, 11.3, 90 )

LSpedLV2 = createPed( 2, 1689.5035400391,-1961,14, -95 )
SFpedLS2 = createPed( 2, -1974.8603515625,122,27.5, -90 )
LVpedSF2 = createPed( 2, 1429,2620,11, -90 )


setElementCollisionsEnabled(LSped,false)
setElementCollisionsEnabled(SFped,false)
setElementCollisionsEnabled(LVped,false)

setElementCollisionsEnabled(LSpedLV2,false)
setElementCollisionsEnabled(SFpedLS2,false)
setElementCollisionsEnabled(LVpedSF2,false)

exports.CSGsprinjobdx:add(1689.72, -1950.34, 14.35,"Train - LS to SF $1000",0,255,0)
exports.CSGsprinjobdx:add(-1975.2877197266,119,27.5,"Train - SF to LV $1000",0,255,0)
exports.CSGsprinjobdx:add(1437.2, 2620, 11.3,"Train - LV to LS $1000",0,255,0)
exports.CSGsprinjobdx:add(-1974.88, 121.99, 27.69 ,"Train - SF to LS $1000",0,255,0)
exports.CSGsprinjobdx:add(1429,2620,11.3,"Train - LV to SF $1000",0,255,0)
exports.CSGsprinjobdx:add(1688.87, -1960.19, 14.35,"Train - LS to LV $1000",0,255,0)





