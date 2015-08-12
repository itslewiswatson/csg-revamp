local streamURL = "http://188.165.208.28:8000"
local radius = 350.0
local volume = 1.0

local thePeds = {}

function clubMusic4 ()

local sound = playSound3D(streamURL, 269.02, -1814.1, 5.32, true)
setSoundVolume(sound, volume)
setSoundMaxDistance(sound, radius)

end
setTimer ( clubMusic4, 1000, 1 )

local hookerDancers = { 
[1]={244, 291.9, -1829.28, 12.52, 327.01031494141},
[2]={246, 289.05, -1828.55, 12.52, 161.27899169922},
[3]={256, 289.05, -1826.02, 12.52, 259.98168945312},
[4]={257, 280.08, -1805.02, 12.89, 141.25064086914},
[5]={237, 301.74, -1805.88, 12.6, 82.956298828125},
[6]={238, 245.39, -1817.32, 5.06, 278.5158996582},
[7]={140, 254.58, -1824.72, 4.66, 7.8361206054688},
[8]={138, 290.35, -1812.56, 7.19, 86.169830322266},
[9]={256, 290.25, -1822.36, 7.19, 88.054016113281}
}

for ID in pairs(hookerDancers) do 
		local skin = hookerDancers[ID][1]
		local x, y, z = hookerDancers[ID][2], hookerDancers[ID][3], hookerDancers[ID][4]
		local rotation = hookerDancers[ID][5]
		local ped = createPed (skin, x, y, z)
		thePeds[ID] = ped
		setElementFrozen (thePeds[ID], true)
		setPedRotation (thePeds[ID], rotation)
		setPedAnimation( thePeds[ID], "DANCING", "dnce_M_b", 100, true, false, false)
		setElementCollisionsEnabled ( thePeds[ID], false )
end

local partyMarkers = {
{267.89999389648, -1797.6999511719, 5.3000001907349},
{267.89999389648, -1837.5, 5.3000001907349},
{267.89999389648, -1797.6999511719, 21},
{267.89999389648, -1837.5, 21},
{267.8994140625, -1797.69921875, 12},
{267.89999389648, -1837.5, 12},
{275.20001220703, -1831.9000244141, 20.420000076294},
{282.39999389648, -1797.6999511719, 5.3000001907349},
{282.20001220703, -1837.5, 5.3000001907349},
{296.70001220703, -1837.1999511719, 5.3000001907349},
{296.5, -1797.6999511719, 5.3000001907349},
{250.39999389648, -1787.8000488281, 5},
{267, -1822.0999755859, 5.1999998092651},
{290.70001220703, -1824.6999511719, 5.1999998092651},
{230.39999389648, -1905.6999511719, 0},
{290.20001220703, -1810.4000244141, 5.1999998092651},
{285.39999389648, -1822, 5},
{286, -1812.8994140625, 5},
{183.19999694824, -1797.5999755859, 4},
{200.7998046875, -1807, 4},
{364.5, -1841.4000244141, 12},
{154.19999694824, -1952, 49},
{185.60000610352, -1839.6999511719, 5.4000000953674},
{236.60000610352, -1797.0999755859, 8.3000001907349},
{236.80000305176, -1775.0999755859, 7.5999999046326},
{282.20001220703, -1797.5999755859, 12},
{267.5, -1813.19921875, 5.1999998092651},
{286.89999389648, -1805.3000488281, 20.799999237061},
{299.79998779297, -1830.6999511719, 20.799999237061}
}

local theMarkers = {}

for i=1,#partyMarkers do
	local x, y, z = partyMarkers[i][1], partyMarkers[i][2], partyMarkers[i][3]
	theMarkers[i] = createMarker ( x, y, z, "corona", math.random(1,8), math.random(0,225), math.random(0,225), math.random(0,225), 170 )
end

setTimer(
	function ()
		if ( theMarkers ) then
			for i, marker in ipairs ( theMarkers ) do
				setMarkerColor ( marker, math.random(0,225), math.random(0,225), math.random(0,225) )
				setMarkerSize ( marker, math.random(1,8) )
			end
		end
	end
, 300, 0 )
