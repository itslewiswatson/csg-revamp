------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  ppBusdriver_s.lua (server-side)
--  Bus Driver Job
--  Priyen Patel
------------------------------------------------------------------------------------

--[[
busDriverVehs = {
	[431] = {"Bus",1,1,1,1},
	[437] = {"Coach",1,1,1,1}
}

 --SF
 { "Bus Driver", "Civilian Workers", -2271, 521.44, 35.01, 255, 255, 0, 0, {255,253}, 3, false, "Drive around SA and transport civilians from one place to another!", 270 }
 { -2271, 526.69, 35.01, 255, 255, 0, busDriverVehs, "Civilian Workers", "Bus Driver", 270}
 { -2271, 540.83, 35.01, 255, 255, 0, busDriverVehs, "Civilian Workers", "Bus Driver", 270}

 --LS
 { "Bus Driver", "Civilian Workers", 1110.47, -1806.08, 16.59, 255, 255, 0, 0, {255,253}, 3, false, "Drive around SA and transport civilians from one place to another!", 48 }
 {  1064.23, -1769.7, 13.36, 255, 255, 0, busDriverVehs, "Civilian Workers", "Bus Driver", 270}
 {  1064.23, -1740.19, 13.47, 255, 255, 0, busDriverVehs, "Civilian Workers", "Bus Driver", 270}
 {  1096.72, -1772.59, 13.34, 255, 255, 0, busDriverVehs, "Civilian Workers", "Bus Driver", 90}

 --]]

--NOTE: format as follows for routes table:
--Index:1,2,3,4,         5             6                                    7
	-- x,y,z,name,rotationForPole,distanceBetweenLastStop-And This Stop,Total Route Distance
local routes = {
	[1] = {
	["name"] = "Central LS",
	{1150.5375976563,-1747.6469726563,12.5703125,"San Andreas Busing HQ",359.7546081543},
	{1285.078491,-1859.12158,12.546875,"Sayanara Restaurant",357.08038330078},
	{1688.8106689453,-1862.8482666016,12.523452758789,"LS Train Station",56.131622314453},
	{1827.7971191406,-1827.6546630859,12.578125,"69c Store",90.911964416504},
	{1827.1550292969,-1694.7095947266,12.546875,"Alhambra",90.43017578125},
	{1722.7901611328,-1588.8601074219,12.546875,"Los Santos Mall",169.24589538574},
	{1523.6083984375,-1676.4071044922,12.546875,"Los Santos Police Department",268.57354736328},
	{1358.4619140625,-1725.9716796875,12.553686141968,"Roboi's Food Mart",179.58609008789},
	{1156.9357910156,-1846.4296875,12.558959007263,"San Andreas Busing HQ",177.77861022949},
	},
	[2] = {
	["name"] = "West LS",
	{1149.2963867188,-1747.66015625,12.5703125,"San Andreas Busing HQ",353.51202392578},
	{881.10827636719,-1762.7985839844,12.546875,"Lucious Condos",175.58395385742},
	{709.23352050781,-1744.1688232422,13.246285438538,"Los Santos River",160.30299377441},
	{597.77679443359,-1716.9333496094,12.844883918762,"West Side Stop Marina",169.70315551758},
	{442.18389892578,-1764.2404785156,4.7855758666992,"Verona Beach",188.40745544434},
	{153.8466796875,-1730.0167236328,4.1995334625244,"Los Santos Lighthouse",181.51400756836},
	{108.47270202637,-1525.7572021484,6.0714521408081,"West Los Santos Limits",156.20635986328},
	{335.98815917969,-1287.1225585938,53.2265625,"Rich Hood",23.592601776123},
	{494.12710571289,-1265.4703369141,15.033195495605,"Vinyl Countdown",306.80154418945},
	{608.98083496094,-1230.1030273438,17.332931518555,"Los Santos Bank",29.908351898193},
	{826.74963378906,-1056.046875,24.329957962036,"Power Video",25.208267211914},
	{1062.3731689453,-968.44616699219,41.796875,"Comedy Club",0},
	{1352.4910888672,-951.22790527344,33.624710083008,"Los Santos Los Venturas Interconnect",301.35424804688},
	{1335.2298583984,-1263.9151611328,12.546875,"Ammunation",283.37359619141},
	{1290.48, -1676.01, 12.54,"SWAT Base",261.44000244141},
	{1150.3791503906,-1733.0606689453,12.7734375,"San Andreas Busing HQ",179.56318664551},
	},
	[3] = {
	["name"] = "East LS",
	{1148.8880615234,-1747.7554931641,12.5703125,"San Andreas Busing HQ",354.30871582031},
	{1285.0584716797,-1859.1912841797,12.539077758789,"Driver Education Centre",357.44201660156},
	{1688.5734863281,-1863.4327392578,12.523452758789,"Unity Station",52.661811828613},
	{1813.4422607422,-1863.5090332031,12.570352554321,"Unity Station East",299.45132446289},
	{1954.7868652344,-2040.0502929688,12.546875,"Bar",263.10433959961},
	{1954.8369140625,-2151.9624023438,12.546875,"Los Santos International Airport",272.1911315918},
	{2189.5637207031,-2184.8525390625,12.539070129395,"Industrial Sector",36.538902282715},
	{2297.8576660156,-2076.451171875,12.546875,"Ocean Docks",46.252326965332},
	{2720.8901367188,-2009.0324707031,12.5546875,"Pawn Shop",82.671783447266},
	{2776.5490722656,-1902.2701416016,10.236605644226,"Interconnect",82.599182128906},
	{2665.8037109375,-1852.611328125,10.042323112488,"Los Santos Stadium",126.44284057617},
	{2649.8708496094,-1416.4431152344,29.364784240723,"NorthEast Los Santos",88.529174804688},
	{2585.2443847656,-1249.2352294922,45.467796325684,"Poor Hood",172.81671142578},
	{2420.9018554688,-1249.7249755859,22.8125,"Pig Pen",181.05944824219},
	{2247.5966796875,-1133.5933837891,25.244571685791,"Jefferson-Motel",157.48670959473},
	{2128.2990722656,-1104.7924804688,24.340618133545,"S O Carshop",156.23336791992},
	{1867.3511962891,-1048.4554443359,22.828125,"Pathway Downtown Los Santos",238.08666992188},
	{1839.1666259766,-1201.1070556641,21.258750915527,"Park",264.64764404297},
	{1840.2344970703,-1411.7348632813,12.5625,"Skate Park",267.154296875},
	{1991.1665039063,-1472.7683105469,12.5625,"Jefferson Hospital",1.2277606725693},
	{2074.8701171875,-1797.5657958984,12.546875,"Well Stacked Pizza",267.06939697266},
	{1808.6530761719,-1824.9610595703,12.570339202881,"Unity Station",175.86515808105},
	{1676.7421875,-1857.9216308594,12.53125,"Unity Station West",248.24584960938},
	{1528.1767578125,-1865.2852783203,12.546875,"Los Santos Road To South",171.79180908203},
	{1259.24609375,-1845.4923095703,12.549283981323,"Driver Education Centre",175.91458129883},
	{1156.9443359375,-1845.6357421875,12.558969497681,"San Andreas Busing HQ Back",178.10794067383},
	{1150.8862304688,-1733.4462890625,12.7734375,"San Andreas Busing HQ Front",186.25465393066},
	},
	[4] = {
	["name"] = "Central SF -> SF Airport",
	{-2241.544921875,501.50857543945,34.171875,"San Fierro Central",358.61254882813},
	{-2160.2790527344,497.89233398438,34.171875,"2265 Central Street",341.06579589844},
	{-2021.3289794922,497.35015869141,34.171875,"Financial District",353.59924316406},
	{-1916.4136962891,596.6220703125,34.171875,"San Fierro Downtown",358.92593383789},
	{-1807.6943359375,596.50189208984,34.171875,"Cluckin Bell",351.40573120117},
	{-1704.7930908203,713.94812011719,23.890625,"Northside Stop SFPD",76.319885253906},
	{-1577.9445800781,722.18487548828,6.4891910552979,"Southside Stop SFPD",357.04568481445},
	{-1627.4561767578,439.05670166016,6.1797046661377,"Xoomer Gas Station",220.43109130859},
	{-1765.2924804688,301.34439086914,6.5266261100769,"San Fierro South-Docks",231.39778137207},
	{-1808.1134033203,17.519380569458,14.109375,"Industrial District",266.17810058594},
	{-1805.8026123047,-130.77766418457,4.8818836212158,"Exports Imports Zone",272.13146972656},
	{-1825.0317382813,-561.50903320313,15.393146514893,"San Fierro International Airport",270.54150390625},
	{-1582.68, -477.28, 5.14,"San Fierro International Airport : Inner Side",49.662952423096},
	},
	[5] = {
	["name"] = "SF North East",
	{-2241.4870605469,501.51870727539,34.171875,"San Fierro Central",0.69223713874817},
	{-2219.4733886719,549.86138916016,34.171875,"Frontside Stop San Fierro Central",90.378936767578},
	{-2245.9328613281,651.27062988281,48.4453125,"1100 Carbon Street",85.292984008789},
	{-2246.3376464844,751.78057861328,48.439266204834,"Little China Town",87.19645690918},
	{-2246.5246582031,963.21026611328,66.021965026855,"Rich Hood",91.992446899414},
	{-2246.5036621094,1044.5270996094,82.84375,"2154 Carbon Street",85.412353515625},
	{-2246.5017089844,1154.2082519531,58.238800048828,"2653 Carbon Street",79.699745178223},
	{-2347.4462890625,1187.4755859375,42.561054229736,"Oceania",176.59327697754},
	{-2493.5539550781,1196.4614257813,36.8996925354,"Cant Bridge Visitor Entrance",215.35087585449},
	{-2647.9223632813,1214.1241455078,54.301429748535,"Cant Bridge SF Side",197.56326293945},
	{-2597.7309570313,1097.9919433594,55.780395507813,"Housing Complex",248.54127502441},
	{-2613.6254882813,984.56530761719,77.278587341309,"3499 Home Street",274.33081054688},
	{-2613.578125,888.71655273438,62.26203918457,"SF Suburbs",266.8108215332},
	{-2719.8742675781,818.83258056641,50.801158905029,"340 Robin Road",178.44985961914},
	{-2758.2429199219,777.93792724609,53.3828125,"Tuff Nut Vege-Complex - Donuts",265.46145629883},
	{-2758.1965332031,578.47875976563,13.584728240967,"Conservation Area",264.52130126953},
	{-2622.7993164063,556.07507324219,13.609375,"San Fierro Medical Centre",2.2821888923645},
	{-2385.64453125,517.39001464844,27.375492095947,"Area 41 - Secret Government Operations",292.12078857422},
	{-2241.7248535156,501.55865478516,34.171875,"San Fierro Busing HQ",0.18720184266567},
	},
	[6] = {
	["name"] = "SF Airport -> Central SF",
	{-1592.5574951172,-467.53079223633,5.1484375,"San Fierro International Airport - Inner Side",225.58636474609},
	{-1801.0755615234,-569.28363037109,15.196492195129,"San Fierro Limits",178.03178405762},
	{-2095.50390625,-537.79895019531,32.148288726807,"Gorvin Stadium - Backside",135.70803833008},
	{-2245.03125,-206.98950195313,34.509162902832,"660 Opaka Street",87.454277038574},
	{-2244.6435546875,-49.361766815186,34.3203125,"Little Mexico",87.068420410156},
	{-2245.1528320313,195.69659423828,34.3203125,"San Fierro Community Park",88.081001281738},
	{-2244.7424316406,298.20971679688,34.3203125,"1792 Opaka Street",89.624351501465},
	{-2293.9201660156,414.5048828125,34.171875,"San Fierro Community Park - Northside",129.73138427734},
	{-2362.306640625,385.97280883789,34.1640625,"San Andreas Immigration and Human Services",132.23806762695},
	{-2443.7951660156,420.71295166016,34.148120880127,"FMA Parking - Backside",224.98542785645},
	{-2425.8220214844,482.26696777344,29.074981689453,"Area 41 - Secret Government Operations",21.630067825317},
	{-2349.9599609375,501.1018371582,29.513729095459,"San Fierro Central - Southside",355.93634033203},
	{-2241.802734375,501.50909423828,34.171875,"San Fierro Busing HQ",358.97372436523},
	},
	[7] = {
	["name"] = "Outer SF Express",
	{-2241.5544433594,501.48831176758,34.171875,"San Fierro Busing HQ",358.03372192383},
	{-1984.5749511719,150.81527709961,26.6875,"San Fierro Central Station",83.043701171875},
	{-1812.1489257813,-553.95306396484,15.2436876297,"San Fierro International Airport - Outer Side",87.743698120117},
	{-1802.8837890625,167.98469543457,14.109375,"South Docks",90.563735961914},
	{-1549.8795166016,691.88043212891,6.1875,"San Fierro Police Department / Downtown",82.416923522949},
	{-1620.6005859375,1247.0003662109,6.1780567169189,"Auto's Ottos",131.92408752441},
	{-2032.2399902344,1321.1069335938,6.3373293876648,"North San Fierro Housing District",173.59780883789},
	{-2817.4697265625,1289.2093505859,4.6015625,"North San Fierro Oceania",213.60888671875},
	{-2848.3569335938,975.04681396484,42.521579742432,"Green Conservatory Park",304.23553466797},
	{-2861.3735351563,426.54196166992,3.5,"San Fierro Fishing West",270.70855712891},
	{-2678.0925292969,328.57797241211,3.3750267028809,"Lucious Core",2.1303195953369},
	{-2264.8828125,313.62411499023,34.570281982422,"San Fierro Community Park",356.24746704102},
	{-2219.1403808594,549.51959228516,34.171875,"San Fierro Busing HQ",91.48021697998},
	},
	[8] = {
	["name"] = "December LS Holiday Route",
	{1148.8243408203,-1747.5101318359,12.5703125,"San Andreas Busing HQ",0.42267692089081},
	{1318.7506103516,-1654.578125,12.546875,"SWAT Base",90.64013671875},
	{1364.0783691406,-1420.7060546875,12.546875,"2265 Los Santos Way",86.880043029785},
	{1301.9849853516,-1388.8146972656,12.480165481567,"North Side Stop All Saints General Hospital - Community of Social Gaming Christmas Celebration",179.04090881348},
	{1009.1795654297,-1389.0863037109,12.335603713989,"Vinewood Wigs",180.03709411621},
	{923.61474609375,-1349.2618408203,12.385469436646,"Cluckin Bell",88.218246459961},
	{981.52386474609,-1333.6339111328,12.540740013123,"Bargain Pawn",358.58996582031},
	{1176.8120117188,-1287.0380859375,12.546875,"South Side Stop All Saints General Hospital - Community of Social Gaming Christmas Celebration",354.70343017578},
	{1336.0727539063,-1293.7000732422,12.546875,"Ammunation",263.31118774414},
	{1291.3815917969,-1639.9774169922,12.546875,"SWAT Base",278.10311889648},
	{1191.7039794922,-1706.1031494141,12.546875,"Convention Heights",179.28042602539},
	{1151.2535400391,-1733.1088867188,12.7734375,"San Andreas Busing HQ",182.44822692871},
	}
}
--[[
local routes = {
[1] = {
	["name"] = "#4A - LS -> East SA -> LV",
    [1] = {1444.467,-1040.944,23,"LS North"},
    [2] = {1023,-947,42,"Fuel Station"},
    [3] = {1025,-1046,31,"Transfender / Pay N Spray"},
    [4] = {1207,-928,42,"BurgerShot"},
    [5] = {1536,-1658,13,"LSPD"},
    [6] = {1828,-1884,13,"South East LS"},
    [7] = {1941,-2172,13,"LS Airport"},
    [8] = {2268,48,26,"East SA"},
    [9] = {1243,158,19,"East SA"},
    [10] = {1706,1416,10,"LV"}
    },
[2] = {
	["name"] = "#4B - Core LS",
    {1155.6630859375, -1698.1650390625, 13.005454063416,"Bobs Clothing Store"},
    {1292.146484375, -1667.2138671875, 12.602264404297,"SWAT Base"},
    {1359.9541015625, -1738.1416015625, 12.59783744812,"Roboi's Food Mart"},
    {1531.6064453125, -1738.0498046875, 12.608879089355,"LSPD"},
    { 1767.1728515625, -1860.23828125, 12.63715171814,"Unity Station"},
    {1827.1708984375, -1843.841796875, 12.641595840454,"69c Store"},
    {1826.822265625, -1683.3037109375, 12.59435653686,"Alhambra Place"},
    {1994.3125, -1471.642578125, 12.615921974182,"Jefferson Hospital"},
    {2241.3974609375, -1295.248046875, 23.046747207642,"LS Church"},
    {2091.7021484375, -1226.7958984375, 23.086851119995,"Discount Warehouse"}
    },
[3] = {
	["name"] = "#4C - Round LS",
    {1152.6716308594,-1746.7940673828,12.5703125,"Conference-Center"},
    {1082.7672119141,-1705.6179199219,12.546875,"Paper-Cuts"},
    {879.86083984375,-1568.7951660156,12.539081573486,"Big-Liquor&Dell"},
    {818.26007080078,-1626.1544189453,12.546875,"BurgerShot"},
    {701.77514648438,-1742.6643066406,12.802894592285,"Ocean-LS-River"},
    {452.54336547852,-1735.6057128906,8.6251792907715,"LS Beach"},
    {154.12236022949,-1731.0521240234,4.1827816963196,"LS-Beach-Lighthouse"},
    {372.89801025391,-1379.7884521484,13.639019966125,"Optimetric-Motel"},
    {610.42224121094,-1228.6127929688,17.375513076782,"Richman-Complex"},
    {843.70330810547,-1042.248046875,24.46764755249,"NewsStand"},
    {1023.5825805664,-1046.3170166016,30.617599487305,"Transfender-Pay&Spray"}
    },
[4] = {
	["name"] = "#PriyenTest",
    {1152.6716308594,-1746.7940673828,12.5703125,"Conference-Center"},
    {1082.7672119141,-1705.6179199219,12.546875,"Paper-Cuts"}
    }
}
--]]
local veh = { }
--[[
function jobVehSpawned(client, veh, id, x, y, z)
    if exports.server:getPlayerOccupation(client) ~= "Bus Driver" then return end
    if id == 431 or id == 437 then
        triggerClientEvent(client, "CSGbusDriverjobVehSpawned", client)
        exports.CSGhelp:setBottomTextServer(client,"Press [F5] to access the Bus Driver Control Panel.",0,255,0)
    end
end
addEvent("CSGjobvehicles.spawnedVehicle", true)
addEventHandler("CSGjobvehicles.spawnedVehicle", root, jobVehSpawned)
--]]
function newJob(player)
     exports.DENdxmsg:createNewDxMessage(player,"Press [F5] to access the Bus Driver Control Panel.",0,255,0)
end

function quitJob(player)
    triggerClientEvent(player, "quitBusDriver", player)
end

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if oldJob == "Bus Driver" then
		quitJob(source)
	elseif nJob == "Bus Driver" then
		newJob(source)
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)

function triggerVoice(str,diff)
	local str2 = ""
	if diff == true then
	str2 = "http://translate.google.com/translate_tts?tl=en&q="..str..""
	else
	str2 = "http://translate.google.com/translate_tts?tl=en&q=Nex Stop: "..str..""
	end
	local veh = getPedOccupiedVehicle(source)
	for k,v in pairs(getVehicleOccupants(veh)) do
		triggerClientEvent(v,"CSGbusDriverSayVoiceClient",v,str2)
	end
end
addEvent("CSGbusDriverSayVoice",true)
addEventHandler("CSGbusDriverSayVoice",root,triggerVoice)

local nameToI = {
	["Bus Stops Arrived To"] = 1,
	["Routes Attempted"] = 2,
	["Routes Completed"] = 3,
	["Money Collected From Fare"] = 4,
	["Money Earned from Routes"] = 5,
	["Died on Job off Route"] = 6,
	["Died on Job on Route"] = 7,
	["Total Bus Route Distance Traveled"] = 8,
	["Times someone has refused fare"] = 9,
	["Times someone couldn't afford fare"] = 10,
	["Times someone paid full fare"] = 11,
	["Times freeloaders entered for free"] = 12,
}

function CSGbusDriverSetStat(stat,value,p,bool,st,rankPts)
	if (p) then
		if isElement(p) == false then
			if isElement(source) then p = source end
		end
	end
	if (bool) then
		if bool == true then
			if isElement(p) then
				if getElementType(p) == "player" then
					triggerClientEvent(p,"CSGbusDriveraddStat",source,stat,value)
					return
				end
			end
		end
	end
	--local stats = fromJSON(exports.DENstats:getPlayerAccountData(source,"busdriverstat"))
	if (rankPts) then
		exports.DENstats:setPlayerAccountData( source, "busdriver", rankPts, true )
	end
	if st == nil then st = {} end
	st[nameToI[stat]] = value
	exports.DENstats:setPlayerAccountData( source, "busdriverstat", toJSON(st), true )
end
addEvent("CSGbusDriverSetStat",true)
addEventHandler("CSGbusDriverSetStat",root,CSGbusDriverSetStat)

local bonusPercentages = {
	0,0,0,2,5,8,11,15,23
}

function payBusDriver(pay,rankI)
	pay = math.floor((pay)+0.5)
    givePlayerMoney(source, pay)
	local rankBonus = math.floor((pay*((bonusPercentages[rankI])/100))+0.5)
	givePlayerMoney(source, rankBonus)
	local total = math.floor((pay+rankBonus)+0.5)
	exports.CSGscore:givePlayerScore(source,1.2)
	triggerClientEvent(source,"CSGbusDriveraddStat",source,"Money Earned from Routes",total)
     exports.DENdxmsg:createNewDxMessage(source,"Successfully finished the route. You have been paid $"..pay.." + $"..rankBonus.." bonus for your service.", 0,255,0)
end
addEvent("payBusDriver", true)
addEventHandler("payBusDriver", getRootElement(), payBusDriver)

function CSGbusDriverNewRank(pts)
	if source == nil then return end
	if pts == nil or type(pts) ~= "number" then return end
	exports.DENstats:updatePlayerStats ( source, "busdriver", pts )
end
addEvent("CSGbusDriverNewRank",true)
addEventHandler("CSGbusDriverNewRank",root,CSGbusDriverNewRank)

function sendRoutes(p)
	local ele = ""
	if (p) then if isElement(p) then ele = p else if isElement(source) then ele = source end end end

	local ds = exports.DENstats:getPlayerAccountData(ele,"busdriverstat")
	--outputChatBox(ds)
    triggerClientEvent(ele,"recRoutes", ele, routes, ds)
end
addEvent("sendRoutes", true)
addEventHandler("sendRoutes", root, sendRoutes)

function login()
	local p = source
    setTimer( function() sendRoutes(p) end,5000,1)
end
addEventHandler("onPlayerLogin",root,login)

setTimer( function()
for k,v in pairs(getElementsByType("player")) do
	sendRoutes(v)
end
end, 5000,1)

function announceToAllPassengers(msg,t,r,g,b)
    for k,v in pairs(t) do
		 exports.DENdxmsg:createNewDxMessage(v,msg,r,g,b)
    end
end
addEvent("announceToAllPassengers", true)
addEventHandler("announceToAllPassengers", root, announceToAllPassengers)

function isBusDriverVeh(veh)
    local model = getElementModel(veh)
    if model == 431 or model == 437 then return true else return false end
end

local busdriversFare = {}
function CSGbusdriverNewFare(fare)
    busdriversFare[source] = tonumber(fare)
    local veh = getPedOccupiedVehicle(source)
    local pName = getPlayerName(source)
    if veh ~= false then
		if getPedOccupiedVehicleSeat(source) == 0 then
			if isBusDriverVeh(veh) == true then
				local t = getVehicleOccupants(veh)
				for k,p in pairs(t) do
					 exports.DENdxmsg:createNewDxMessage(p,"Bus Driver "..pName.." Has changed the fare to $"..fare.."",255,255,0)
				end
			end
		end
    end
end
addEvent("CSGbusdriverNewFare",true)
addEventHandler("CSGbusdriverNewFare",root,CSGbusdriverNewFare)

function enterVeh(veh,seat,jacked)
    if seat == 0 then return end
    if isBusDriverVeh(veh) == true then
        local driver = getVehicleController(veh)
        if exports.server:getPlayerOccupation(driver) == "Bus Driver" then
			if getTeamName(getPlayerTeam(driver)) ~= "Civilian Workers" then return end
			local pName = getPlayerName(source)
				if getElementData(source,"isPlayerArrested") == true then
					 exports.DENdxmsg:createNewDxMessage(driver,""..pName.." is arrested and is riding in your bus under the authority of the SAPD",255,255,0)
					return
				end
            local fare = busdriversFare[driver]
            if fare == nil then
            fare = 500
            busdriversFare[driver] = 500
            end
			local msg1 = ""
			local msg2 = ""
			local dName = getPlayerName(driver)

			if fare > 0 then
				msg1 = ""..dName.."'s bus, Fare: $"..fare.. " Paying within 10 seconds."
				msg2 = "New Passenger: "..pName..". Expecting fare in 10 seconds."
			else
				msg1 = ""..dName.."'s bus, Fare: $0. Free transportation"
				msg2 = "New Passenger: "..pName..". Providing free transportation"
				triggerClientEvent(driver,"CSGbusDriveraddStat",driver,"Times freeloaders entered for free",1)
			end
			 exports.DENdxmsg:createNewDxMessage(source,msg1,255,255,0)
             exports.DENdxmsg:createNewDxMessage(driver,msg2,0,255,0)
			if fare == 0 then return end
            triggerClientEvent(source,"CSGbusFareMenu",source,driver,fare)
        end
    else
        return
    end
end
addEventHandler("onPlayerVehicleEnter",root,enterVeh)

function payFare(driver,fare)
	local fare = tonumber(fare)
	if getPlayerMoney(source) >= fare then
		triggerClientEvent(driver,"CSGbusDriveraddStat",driver,"Times someone paid full fare",1)
		step2(driver,source,getPedOccupiedVehicle(driver),fare)
	else
		triggerClientEvent(driver,"CSGbusDriveraddStat",driver,"Times someone couldn't afford fare",1)
		refuseFare(driver,source)
		exports.server:givePlayerWantedPoints(source, 10)
	end
end
addEvent("CSGbusPayFare",true)
addEventHandler("CSGbusPayFare",root,payFare)

function refuseFare(driver,player)
	triggerClientEvent(driver,"CSGbusDriveraddStat",driver,"Times someone has refused fare",1)
	--if (source) then if isElement(source) then player = source end end
	local sourceVeh = getPedOccupiedVehicle(player)
	if isElement(sourceVeh) == true then
		local veh = getPedOccupiedVehicle(driver)
		if veh == sourceVeh then
			if isBusDriverVeh(veh) == false then return end
			removePedFromVehicle(player)
			 exports.DENdxmsg:createNewDxMessage(driver,"Passenger "..getPlayerName(player).." couldn't afford or refused to pay the fare and was forced out of the vehicle",255,0,0)
			 exports.DENdxmsg:createNewDxMessage(player,"You have been kicked off "..getPlayerName(driver).."'s bus for not paying the full fare!",255,0,0)
		end
	end
end
addEvent("CSGbusRefuseFare",true)
addEventHandler("CSGbusRefuseFare",root,refuseFare)

function step2(driver,player,veh,fare)
    local playerVeh = getPedOccupiedVehicle(player)
    local passName = getPlayerName(player)
    if playerVeh == veh then
        if getPedOccupiedVehicle(driver) == veh then
            local playerMoney = getPlayerMoney(player)
            if playerMoney >= tonumber(fare) then
                 exports.DENdxmsg:createNewDxMessage(player,"Paid Bus Driver "..getPlayerName(driver).." Full $"..fare.. " Fare.",0,255,0)
                 exports.DENdxmsg:createNewDxMessage(driver,"Received Full Fare of $"..fare.." From  Passenger "..passName.."",0,255,0)
            else
                fare = playerMoney
                 exports.DENdxmsg:createNewDxMessage(player,"Paid Bus Driver "..getPlayerName(driver).." Partial $"..fare.. " Fare.",255,255,0)
                 exports.DENdxmsg:createNewDxMessage(driver,"Received Partial Fare of $"..fare.." from Passenger "..passName.."",255,255,0)
                exports.server:givePlayerWantedPoints(player, 10)
            end
			triggerClientEvent(driver,"CSGbusDriveraddStat",driver,"Money Collected From Fare",fare)
			takePlayerMoney(player,fare)
			givePlayerMoney(driver,fare)
        end
    end
end

for k1,v1 in pairs(routes) do
	local totalDist = 0
	local t = v1
	local between = 0
	for k,v in pairs(t) do
		if k ~= "name" then
			if k ~= (#t)+1 then
				if k == 1 then
					dist = 0
				else
					local x1,y1,z1 = v[1],v[2],v[3]
					local x2,y2,z2 = t[k-1][1],t[k-1][2],t[k-1][3]
				    between = math.floor((getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2))+0.5)
					totalDist = math.floor((totalDist+between)+0.5)
				end
				local point = v
				table.insert(point,between)
				table.insert(point,totalDist)
				routes[k1][k] = point
			end
		end
	end
end
