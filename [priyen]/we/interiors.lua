local intMarkers = {
	--------------------------------------------------------------------
	------------------- ADD HERE AS MUCH GATES YOU WANT! ---------------
	-- Xmarker, Ymarker, Zmarker, INTmarker, DIMmarker, Xwarp, Ywarp, Zwarp, rotWarp, INTwarp, DIMwarp (start from 6000 with dimensions), groupname, teamname
	--------------------------------------------------------------------
	--[[{1222.53, -1617.8, 13.54, 0, 0, 1235.44, -1639.85, 13.54, 186.52047729492, 0, 0, "SWAT Team", "SWAT"}, --SWAT BASE
	{1235.57, -1638.08, 13.54, 0, 0, 1222.19, -1615.08, 13.54, 357.28909301758, 0, 0, "SWAT Team", "SWAT"}, -- SWAT BASE
	{1273.99, -1641.6, 27.37, 0, 0, 1266.12, -1639.61, 13.54, 91.5751953125, 0, 0, "SWAT Team", "SWAT"}, -- SWAT BASE
	{1268.76, -1639.89, 13.54, 0, 0, 1274.34, -1638.04, 27.37, 356.99792480469, 0, 0, "SWAT Team", "SWAT"}, -- SWAT BASE
	{1213.51, -1657.77, 17.81, 0, 0, 1233.64, -1645.99, 21.26, 178.06634521484, 0, 0, "SWAT Team", "SWAT"}, -- SWAT BASE
	{1233.44, -1643.91, 21.26, 0, 0, 1216.14, -1657.72, 17.81, 264.82672119141, 0, 0, "SWAT Team", "SWAT"}, -- SWAT BASE
	{1268.52, -1673.68, 13.55, 0, 0, 246.22, 110.49, 1003.21, 0, 10, 6000, "SWAT Team", "SWAT"}, -- SWAT BASE
	{246.22, 107.94, 1003.21, 10, 6000, 1265.82, -1673.24, 13.54, 68.618896484375, 0, 0, "SWAT Team", "SWAT"}, -- SWAT BASE
	--]]
	{2909.53, -1972.35, 11.01, 0, 0,2954.97, -1958.73, 21.6 , 185, 0, 0, "SWAT Team", "SWAT"},
	{ 2955.08, -1957.11, 21.6, 0, 0,2909.51, -1970.2, 11.01 , 3, 0, 0, "SWAT Team", "SWAT"},

	{204.8994140625,-1860.599609375,4.5 ,0,0,  196.60000610352,-1837.5, 10.199999809265,92,0,0,"FBI","Government Agency"},
	{196.60000610352, -1841.6999511719,9.5,0,0,209.89999389648,-1860.4000244141, 5.1999998092651,91,0,0,"FBI","Government"},
	{206.7998046875, -1869.3994140625, 4.5,0,0,189.19999694824,-1875.4000244141, 4.1999998092651,94,0,0,"FBI","Government"},
	{189.19921875, -1872.19921875, 3.4,0,0,206.89999389648, -1864.8000488281,5.1999998092651,179.5,0,0,"FBI","Government"},

	{205.19999694824, -1848.5,  4.5,0,0,218.69999694824,-1824.1999511719, 10.199999809265,91,0,0,"FBI","Government"},
	{218.60000610352, -1820, 9.5,0,0,208.80000305176, -1848.5,5.5,94,0,0,"FBI","Government"},
	{209.599609375, -1829.5986328125, 9.4,0,0,215,-1829.5999755859,10,179.5,0,0,"FBI","Government"},
	{211.10000610352, -1829.5999755859, 9.4,0,0,205.39999389648,-1829.5,10,179.5,0,0,"FBI","Government"},

	--JAIL
	{884.56, -2372.91, 13.28,0,0,926.79, -2388.12, 5700.42,181,0,0,"All","All"},
	{926.61, -2385.97, 5700.42,0,0,886.74, -2371.56, 13.28,297,0,0,"All","All"},

	--JAIL TO BACK
	{928.7, -2453.82, 5700.42,0,0,914.21, -2399.36, 13.28,297,0,0,"All","All"},
	{923.47, -2453.88, 5700.42,0,0,914.21, -2399.36, 13.28,297,0,0,"All","All"},

	--BACK to INSIDE
	{912.48, -2400.77, 13.28,0,0,925.74, -2446.31, 5700.42,4,0,0,"All","All"},

	--The Champions
	{2944.38, 1183.51, 40.76 ,0,0, 2956.16, 1128.02, 60.8,351,0,0,"All","All"},
	{ 2958.09, 1125.68, 60.8 ,0,0,2943.17, 1188.03, 40.76 ,7,0,0,"All","All"},

	--Wolfenstiens
	{945.67, 1514, 26.36 ,0,0,  893.21, 1491.54, 44.76 ,183,0,0,"All","All"},
	{ 893.05, 1493.7, 44.76 ,0,0,945.98, 1511.58, 26.36,183,0,0,"All","All"},
	--TLA
	{2819.88, 1231.23, 10.79,0,0,2836, 1236.28, 26.76,1,0,0,"All","All"},
	{ 2836.03, 1233.1, 26.76 ,0,0,2822.58, 1231.17, 10.79,266,0,0,"All","All"},
	--SM
	--{2194.14, 524.17, 11.3 ,0,0, 2127.33, 539.18, 1.2 ,83,0,0,"All","All"},
	--{2130.11, 539.09, 1.2 ,0,0, 2194.99, 526.35, 11.3,327,0,0,"All","All"},

	--TSF and SM UA
	{1945.08, 541.05, 11.79 ,0,0, 2044.69, 582.87, 0.85 ,6,0,0,"All","All"},
	{2044.44, 580.84, 0.85 ,0,0,1950.64, 542, 11.47 ,318,0,0,"All","All"},

	{1977.33, 537.84, 11.56,0,0,2070.39, 584.25, -10.53,84,0,0,"All","All"},
	{2072.57, 583.98, -10.53,0,0,1974.26, 537.21, 11.56,89,0,0,"All","All"},

	{2111.28, 570.03, 11.17,0,0,2032.72, 583.93, -10.53,268,0,0,"All","All"},
	{2028.75, 584, -10.53,0,0, 2111.44, 573.03, 11.17,1,0,0,"All","All"},

	{1928.56, 544.91, 11.47,0,0,1934.05, 549.91, 1.49,88,0,0,"All","All"},
	{ 1936.54, 548.57, 1.49,0,0, 1925.57, 544.93, 11.47,352,0,0,"All","All"},

	{2123.58, 526.97, 11.3,0,0,2127.82, 539.36, 1.2,90,0,0,"All","All"},
	{2129.94, 539.33, 1.2,0,0,2124.88, 528.37, 11.3,316,0,0,"All","All"},

	{2111.36, 545.98, 11.79,0,0,2045.38, 584.04, 0.85 ,1,0,0,"All","All"},
	{2047.89, 580.65, 0.85,0,0,2113.47, 545.75, 11.17,265,0,0,"All","All"},
	--in 85
}
	--------------------------------------------------------------------
	-------------- CHANGE ONLY STUFF BETWEEN THIS AND ABOVE ------------
	--------------------------------------------------------------------

function getInteriorMarkers ()
	return intMarkers
end
