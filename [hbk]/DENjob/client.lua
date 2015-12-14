-- Anti compiller
local CSGSecurity = {{{{{ {}, {}, {} }}}}}

local policeDisc = "Here you can join the police service.\n\nPolice officer job is all about arresting wanted players. You can pick one of 8 various skins and 4 different types of police vehicles. When you get enough arrests you will be able to get promoted and become one of the special ranks in police job. Also good progress as a police officer can lead to joining one of the special government services. \n\nJob perk: To arrest players simply hit them with a nighstick. You can also use tazer to stun them. The player is wanted if he has numbers (1-6) behind his name.\n"
local hookerDisc = "Here you can work as a hooker.\n\nAs a hooker you can offer your services to other players. You are able to pick 1 of 9 different skins. You can find your customer by standing around a corner or even advertising your services. When customer pick one of your services you will receive cash and he will gain HP.\n\nJob perk: To offer your services to a customers you have to enter their car as a passanger."
local medicDisc = "As a paramedic your job is to heal players with you spraycan.\nYou can heal player by simply spray them, with the spraycan, every time you heal somebody you earn money for it.\n\nParamedics get acces to the Ambulance car. For a emergency accident you can use the medic chopper."
local mechDisc = "Here you can work as a mechanic.\n\nAs a mechanic your job is to repair vehicles owned by other players. You can pick 1 of 3 various skins and 1 of 4 vehicles for easier transportation. You are able to use Towtruck to tow other players vehicles if they run out of gas or bounce off the road.\n\nJob perk: To repair a vehicle press right mouse button near it's doors. Use num_2 and num_8 keys to adjust Towtruck's cable height."
local trafficDisc = "As a Traffic Officer you can do everything a regular Police Officer can.\nThe difference is that you may use your camera (given to you after taking the Job) to photograph drivers who are speeding.\n\nIf you manage to photograph a speeding driver, you will earn a 200$ bonus.\n\nNote that you can only photograph the same driver every 40 seconds (to prevent abuse)."
local swatDisc = "The SWAT (Special Weapons and Tactics) Team focuses on quick, effective raids against its targets.\nOur members are trained to be the best at what they do, in every aspect, always using teamwork to achieve their objectives. Our main objective is to bring order to San Andreas, in cooperation with our Law counterparts.\n\nIf you wish to join an elite Law group and you are interested in joining SWAT, apply at the SWAT Team board in the CSG forum.\n\nRequirements:\n-Good English skills;\n-50 hours of gameplay;\n-150 arrests;\n-5000 arrest points;\n-Mature behavior;\n\nWe are also recruiting full-time Paramedics to help the Tactical Teams. Paramedics will get an invite to the group, meaning that they will be able to open the base’s gate at any time.\nYou can apply for the SWAT Tactical Paramedics in our board. Other than good English, the requirements are minimal.\nMedics who use the SWAT skin/job without permission from a CPT+ will be kicked from SWAT without notice."
local truckerDisc = "Take the job and spawn a truck. Go to light green marker to take a trailer then deliver it to assigned destination for your payments. Be a Trucker and deliver goods all over the country with a amazing salary. Can you truck?"
local pilotDisc = "Take the pilot job and then spawn a plane. You can find Cargo on your radar as Big red blips. Pickup the cargo by entering the red marker then deliver it its destination. Your main job is to deliver goods via air, but you can also provide service to Civilians for transport."
local busDisc = "Take the job and spawn a bus or coach. Start a route from your panel using F5. Also view Route management, select your any route in the City and complete all bus stops to be paid. Use the GPS system to help you and the automated voice announcements of each stop."
local elecDisc = "Take the job and spawn a maintenance van. Drive to waypoints blips,[Red ball blips] and you will notice there is problem with the electrical pole. Enter it's marker and check the pole's status to see the pole stats details. Then repair the pole to take your payments."
local fireDisc = "Take the job you will notice there is red blips on your map. Go to them and you will be encountered by a big fire! Extinguish the fire by using a fire extinguisher or you can use your fire truck. You will be paid for putting out the fires. People's lives depend on you!"
local trashDisc = "Keep LS clean, Take the job and spawn a trashmaster, you can find trash as big red blips on your radar. Geather at least 5 units of trash, then go back to the W blips to dump your trash and to get your payments."
local navyDisc = "Welcome, here is the official Navy job, only group members can take it, have fun. "
local drugDisc = "Start the mission and go to the blip on the map. Kill the druggies and collect the body parts and deliever them to a hospital. Then go to the drug factory. You will get your reward once you reach there."
local theJobsTable = {
	-- { Occupation, Team, MarkerX, MarkerY, MarkerZ, markerR, markerG, markerB, Weapon, {skins}, wantedLevel, Group, Information, pedRotation }
	--NAVY
	--{"Navy","Navy", -1527.07, 490.41, 7.17 ,0,0,255,3,{179,191},10,"Navy",navyDisc,0},
	-- SWAT
	{ "SWAT Team", "SWAT",  1222.75, -1616.53, 25.53, 39, 64, 139, 3, {285,76}, 10, "SWAT Team", swatDisc, 266 },
	-- MF
	{ "Military Forces", "Military Forces", 125.79, 1933.8, 19.25, 107, 142, 35, 3, {97, 287, 191, 73}, 10, "Military Forces", "Empty", 265 },
	-- Police
	{ "Police Officer", "Police", 2348.09, 2455.07, 14.97, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 85.274444580078 },
	--{ "Police Officer", "Police", -215.8, 973.69, 19.32, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 271.76470947266 },
	--{ "Police Officer", "Police", -1395.03, 2646.44, 55.85, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 136.15838623047 },
	{ "Police Officer", "Police", -2161.64, -2385.5, 30.62, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 137.83932495117 },
	{ "Police Officer", "Police", 1574.700, -1634.300, 13.600, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 87.235534667969 },
	{ "Police Officer", "Police", 630.84, -569.06, 16.33, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 271.76470947266 },
	{ "Police Officer", "Police", -1622.52, 686.91, 7.18, 67, 156, 252, 3, {265, 266, 267, 280, 281, 282, 283, 288}, 10, nil, policeDisc, 167.47540283203 },
--	{ "Police Officer", "Police",   1537, -1634.300, 13.600, 67, 156, 252, 3,{265, 266, 267, 280, 281, 282, 283, 288},10, nil,policeDisc,87},
	-- Traffic police
	{ "Traffic Officer", "Police", 1601.24, -1634.94, 13.71, 67, 156, 252, 3, {284}, 10, nil, trafficDisc, 3.403076171875 },
	{ "Traffic Officer", "Police", 619.01, -584.65, 17.22, 67, 156, 252, 3, {284}, 10, nil, trafficDisc, 175.54498291016 },
	{ "Traffic Officer", "Police", -1619.49, 692.34, 7.18, 67, 156, 252, 3, {284}, 10, nil, trafficDisc, 90.580902099609 },
	--{ "Traffic Officer", "Police", -226.3, 985.22, 19.59, 67, 156, 252, 3, {284}, 10, nil, trafficDisc, 85.884185791016 },
	-- Drug detective
--	{inDev=true,"Drug Detective", "Police", 1584.26, -1685.71, 6.21,67,156,252,3,{166},10,nil,drugDisc,268},
	-- Pilot
	{ "Pilot", "Civilian Workers", 1895.26, -2246.88, 13.54, 225, 225, 0, 0, {61}, 25, nil,pilotDisc, 211.89929199219 },
	{ "Pilot", "Civilian Workers", 1712.99, 1615.86, 10.15, 225, 225, 0, 0, {61}, 25, nil,pilotDisc, 247.35270690918 },
	{ "Pilot", "Civilian Workers", -1542.99, -437.79, 6, 225, 225, 0, 0, {61}, 25, nil,pilotDisc, 130.25314331055 },
	-- Paramedic
	{ "Paramedic", "Paramedics", 1178.61, -1319.42, 14.12, 0, 225, 225, 41, {274, 275, 276,70}, 10, nil, medicDisc, 278.97186279297 },
	{ "Paramedic", "Paramedics", 1253.16, 328.22, 19.75, 0, 225, 225, 41, {274, 275, 276,70}, 10, nil, medicDisc, 335.29962158203 },
	{ "Paramedic", "Paramedics", -2641.51, 636.4, 14.45, 0, 225, 225, 41, {274, 275, 276,70}, 10, nil, medicDisc, 161.91076660156 },
	--{ "Paramedic", "Paramedics", -323.25, 1055.37, 19.74, 0, 225, 225, 41, {274, 275, 276,70}, 10, nil, medicDisc, 313.19479370117 },
	--{ "Paramedic", "Paramedics", -1510.04, 2520.85, 55.87, 0, 225, 225, 41, {274, 275, 276,70}, 10, nil, medicDisc, 358.06912231445 },
	{ "Paramedic", "Paramedics", 1600.54, 1818.96, 10.82, 0, 225, 225, 41, {274, 275, 276,70}, 10, nil, medicDisc, 359.32159423828 },
	{ "Paramedic", "Paramedics", 2036.27, -1404.07, 17.26, 0, 225, 225, 41, {274, 275, 276,70}, 10, nil, medicDisc, 146.98010253906 },
	{ "Paramedic", "Paramedics", -2204.52, -2312.74, 30.61, 0, 225, 225, 41, {274, 275, 276,70}, 10, nil, medicDisc, 271.76470947266 },
	--add skin 70 for v2
	-- Hooker Removed by NASAR
--	{ "Prostitute", "Civilian Workers", 2425.92, -1222.26, 25.39, 205, 104, 137, 0, {152, 243, 244, 245, 256, 257, 63, 64, 237}, 10, nil, hookerDisc, 159.32891845703 },
--	{ "Prostitute", "Civilian Workers", -2628.85, 1403.44, 7.09, 205, 104, 137, 0, {152, 243, 244, 245, 256, 257, 63, 64, 237}, 10, nil, hookerDisc, 250.25863647461 },
--	{ "Prostitute", "Civilian Workers", 788.28, -1550.94, 13.56, 205, 104, 137, 0, {152, 243, 244, 245, 256, 257, 63, 64, 237}, 10, nil, hookerDisc, 87.202575683594 },
--	{ "Prostitute", "Civilian Workers", 2104.58, 2198.14, 10.82, 205, 104, 137, 0, {152, 243, 244, 245, 256, 257, 63, 64, 237}, 10, nil, hookerDisc, 266.93612670898 },
--	{ "Prostitute","Civilian Workers", 698.97, 1966.9, 5.53,205,104,137,0,{152,243,244,245,256,257,63,64,237},10,nil,hookerDisc,184},
	-- Mechanic
	{ "Mechanic", "Civilian Workers", 1013.06, -1028.97, 32.1, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 186.24034118652 },
	{ "Mechanic", "Civilian Workers", 2070.31, -1865.53, 13.54, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 272.57769775391 },
	{ "Mechanic", "Civilian Workers", 708.79, -474.49, 16.33, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 182.90043640137 },
	{ "Mechanic", "Civilian Workers", -1895.93, 276.32, 41.04, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 172.72692871094 },
	--{ "Mechanic", "Civilian Workers", -89.71, 1115.7, 19.74, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 177.17645263672 },
	{ "Mechanic", "Civilian Workers", 1966.14, 2143.93, 10.82, 225, 225, 0, 0, {268, 305, 309}, 25, nil, mechDisc, 95.299621582031 },
	-- Trucker
	{ "Trucker", "Civilian Workers", 46.56, -223.96, 1.59, 225, 225, 0, 0, {206, 202, 133, 15}, 25, nil, truckerDisc, 269.0510559082 },
	{ "Trucker", "Civilian Workers", 2225.56, -2210.81, 13.54, 225, 225, 0, 0, {206, 202, 133, 15}, 25, nil,truckerDisc, 223.98443603516 },
	{ "Trucker", "Civilian Workers", -80.32, -1115.62, 1.08, 225, 225, 0, 0, {206, 202, 133, 15}, 25, nil,truckerDisc, 161.91076660156 },
	{ "Trucker", "Civilian Workers", -2096.45, -2254.1, 30.62, 225, 225, 0, 0, {206, 202, 133, 15}, 25, nil,truckerDisc, 142.96450805664 },
	--{ "Trucker", "Civilian Workers", -1734.64, -101.94, 3.55, 225, 225, 0, 0, {206, 202, 133, 15}, 25, nil,truckerDisc, 128.15472412109 },
	--{ "Trucker", "Civilian Workers", 682.5, 1848.21, 5.53, 225, 225, 0, 0, {206, 202, 133, 15}, 25, nil,truckerDisc, 257.57015991211 },
	-- Firefighter
	{ "Firefighter", "Firefighters",  1112.5, -1201.1, 18.23, 255, 0, 0, 42, {277,278,279}, 10, nil,fireDisc, 181 },
	{ "Firefighter", "Firefighters",  -2025.3, 66.96, 28.46, 255, 0, 0, 42, {277,278,279}, 10, nil,fireDisc, 270 },
	-- Police dog officer
	{ "K-9 Unit Officer", "Police",  1543.16, -1644.61, 5.89, 67, 156, 252, 3, {283,288,164,163}, 10, false, "Empty", 174 },
	-- Bus driver
	{ "Bus Driver", "Civilian Workers", -2271, 521.44, 35.01, 255, 255, 0, 0, {255,253}, 3, false,busDisc, 270 },
	{ "Bus Driver", "Civilian Workers", 1110.47, -1806.08, 16.59, 255, 255, 0, 0, {255,253}, 3, false,busDisc, 48 },
	-- Street cleaners
	{ "Street Cleaner", "Civilian Workers", 2195.63, -1973.31, 13.55, 255, 255, 0, 0, {16}, 3, false, "Keep SA clean,get Sweeper and clean SA streets. The Trash is marked on your radar with green blips,then back to blue marker to take your payments,you will gain money and score.", 181.14259338379 },
	{ "Street Cleaner", "Civilian Workers", -2089.74, 84.27, 35.31, 255, 255,0, 0, {16}, 3, false, "Keep SA clean,get Sweeper and clean SA streets. The Trash is marked on your radar with green blips,then back to blue marker to take your payments,you will gain money and score.", 81.022644042969 },
	-- Electrican  Removed by NASAR
	--{ "Electrician", "Civilian Workers", 1613.5861816406, -1886.6519775391, 13.546875, 255, 255, 0, 0, {260}, 3, false, elecDisc, 360 },
	--{ "Electrician", "Civilian Workers", -1737.3839111328,-5.1656022071838,3.5489187240601, 255, 255, 0, 0, {260}, 3, false,elecDisc, 0 },
	-- Fisherman
	{ "Fisherman", "Civilian Workers", 979.92, -2087.71, 4.8, 255, 255, 255, false, {35,37}, 3, false, "Work as a Fisherman to get fish and earn money!", 2.1 },
	{ "Fisherman", "Civilian Workers", -2425.48, 2321, 4.99, 255, 255, 0, false, {35,37}, 3, false, "Work as a Fisherman to get fish and earn money!", 2 },
	{ "Fisherman", "Civilian Workers", 1623.78, 606.04, 7.78 , 255, 255, 0, false, {35,37}, 3, false, "Work as a Fisherman to get fish and earn money!", 360 },

--	{inDev=true,"Delievery Man","Civilian Workers",2690.62, -1113.07, 69.52,255,255,0,false,{306},3,false,"Work as a Delievery Man, earn money by delievering goods. Get in a rumpo or van to start a assignment. Look for the house blip and go to it to deleiver the goods and earn money.",356},
	-- Iron Miner
		--add "inDev=true" for jobs in dev
--	{inDev=true,"Iron Miner","Civilian Workers",629.67, 894.01, -42.72,255,255,0,false,{27},3,false,"Work as a Iron Miner to earn money and make a living. Extract gold, iron, etc from the rocks and deposit it at the disc blip to earn money.",232},
	{"Iron Miner","Civilian Workers",629.67, 894.01, -42.72,255,255,0,false,{27},3,false,"Work as a Iron Miner to earn money and make a living. Extract gold, iron, etc from the rocks and deposit it at the disc blip to earn money.You must have Dune vehicle",232},
	{"Farmer","Civilian Workers", -1058.6, -1208.43, 129.21,255,255,0,false,{158,159,161},3,false,"Start your job by getting Seeds and Tractor then enter yellow area and start pressing mouse button to plant",267},
---	{inDev=true,"Archaeologist","Civilian Workers", -2354.24, -1629.49, 483.40,255,255,0,false,{234},3,false,"Still in development",250},
-- Remove by NASAR
--	{"Photographer","Civilian Workers", 1789.1, -1296.46, 13.43,255,255,0,false,{43},3,false,"Start your job by getting Films for your camera. ",360},
	{"Limo Driver", "Civilian Workers", 1006.96, -1118.77, 23.9, 255,255,0, 0, {61, 255, 253}, 10, nil, "empty", 189.23965454102},
	--Bag Collector
	{ "Airport Attendant", "Civilian Workers", 1643.35, -2238.97, 13.49, 255, 255, 255, false, {50}, 3, false, "Work as a Airport Attendant to transport passenger bags and earn money!",180 },
	-- Taxi driver
 	{ "Taxi Driver", "Civilian Workers", 1804.98, -1934.3, 13.38 , 255, 255, 0, false, {20}, 3, false, "Work as a taxi driver and drive civilians around to earn money! Press F5 for a panel to respond to people who need Taxi's and Press 1 and 2 in the taxi to toggle the taxi light for players. If you ask for a passenger via F5, go to the person blip on the map. Pick them up and you might or might not see a green blip on map. Press F11 and you will see their destination. Go there and hit the marker to be paid.", 1 },
	-- Fuel tank driver
	{ "Fuel Tank Driver", "Civilian Workers",  2594.67, -2201.05, 13.54 , 255, 255, 0, false, {66}, 3, false, "Work as a fuel tank driver to refuel gas stations and earn money!", 266 },
	-- FBI
	--{ "Federal Agent", "Government Agency",  1993.44, -197.52, 35.58,190,190,190,3,{286,240},3,"FBI","Fidelity, Bravery, Integrity.",1},
	----GOV
	--{ "Government", "Government Agency",   2874.17, -1762.15, 11.03,0,0,0,3,{60,286,285,97,76,51,62,165,283},3,"Department of Defense","GOV underbuilding ",79}, removed?

	-- Trash Collector
	{ "Trash Collector","Civilian Workers", 2200.16, -1973.3, 13.55, 255, 255, 0, 0, {16}, 10, false,trashDisc, 181.14259338379 },
	-- News Reporter
	{ "News Reporter", "Civilian Workers", 647.95, -1363.2, 13.6, 255, 255, 0, 43, {59},10, false,"Work as a CSG News Reporter and report crimes and other events all over the city! Get paid for catching those criminals in action and submitting these photos to the police! Press F5 to access your panel.", 41 },
	-- Criminal Smurfs SKIN
	{ "Criminal","Criminals",2197.32, 552.41, 12.16, 255, 0, 0, 0, {261,57}, 9999, "The Smurfs", "CSG's Smurfs Official Job / Skin", 95,nrgb={139, 0, 139} },
	{ "Criminal","Criminals",2663.84, 634.48, 15.02, 255, 0, 0, 0, {136}, 9999, "The Terrorists", "CSG's Terrorists Official Job / Skin", 3,nrgb={0, 52, 52} },
	--tq
--	{ "Criminal","Criminals", 2815.33, 2685.55, 14.74 , 255, 0, 0, 0, {231}, 9999, "Terror Squad", "CSG's Terror Squad Official Job / Skin", 2 },
	-- Criminal Wolfensteins skin
    { "Criminal","Criminals", 1264.59, 729.29, 20.21,255,0,0,0,{232},9999,"Wolfensteins","CSG's Wolfensteins Official Job / Skin", 185},

--	{ "Mail Officer", "Civilian Workers",  1712.22, -1615.44, 13.55, 255, 255, 0, false, {36}, 3, false, "Work as a Mail Officer and deliever goods to earn money! Enter the faggio to get an assignment and look for a green blip on your map.", 1 },
--	{ "Car Delivery","Civilian Workers",2141, -1167, 23.5, 255, 255, 0, false, {171}, 3, false, "Work as Packer Driver and deliever cars to earn money! Go to the Car shops in SA, there is a Unloading marker for cars. Deleiver those cars for money.", 264 },
--	{inDev=true,"Mortuary Agency","Civilian Workers", 825.3, -1102.69, 25.7, 255, 255, 0, false, {33}, 3, false, "Work as Mortuary Agency to deliever dead body to Cemetery ! Go to the Cemetery in LS. Deleiver those body to get some money.", 264 },

	{ "Pizza Boy","Civilian Workers",2092.62, -1796.18, 13.38, 255, 255, 0, false, {155}, 3, false, "Work as a Pizza Boy and deliever pizza's to earn money! Go to the pizza restaurant in Ls, there is a pickup marker for pizza's right outside it. Deleiver those pizza's for money.", 95 },
	--CIA
	--{ "Police Officer", "Police",927.53, 2480.81, 14.71, 167, 156, 252, 3, {225}, 10, "CIA", "CIA Police Job", 167.47540283203 },
	{ "Rescuer Man", "Civilian Workers", 146.92, -1942.42, 3.77, 255, 255, 0, 0, {18,45}, 10, nil, "As rescuer Man, you have to rescue drown people in the sea, you will get paid for each person you save his life", 332.93200683594},
	{ "Lumberjack","Civilian Workers", -535.22, -177.42, 78.4,255,255,0,9,{27},10,nil,"Work as a Lumberjack and cut down trees for money!",173},
}


for i=1,#theJobsTable do
	local x, y, z = theJobsTable[i][3], theJobsTable[i][4], theJobsTable[i][5]
	if (theJobsTable[i][2] == "Civilian Workers") then
	--	createBlip (x, y, z, 56, 2, 0, 0, 0, 0, 0, 270)
		exports.customblips:createCustomBlip (x, y, 14, 14, "images/civBlipn.png", 100)
	elseif (theJobsTable[i][1] == "Police Officer") then
		exports.customblips:createCustomBlip (x, y, 14, 14, "images/policeBlipn.png", 100)
	elseif (theJobsTable[i][2] == "Paramedics") then
		exports.customblips:createCustomBlip (x, y, 14, 14, "images/medicBlipn.png", 100)
	elseif (theJobsTable[i][2] == "Firefighters") then
		exports.customblips:createCustomBlip (x, y, 14, 14, "images/fireBlips.png", 100)
	end
end

local jobMarkersTable = {}

local theJobWindow = guiCreateWindow(544,193,321,470,"CSG ~ Job",false)
local theJobGrid = guiCreateGridList(9,288,322,133,false,theJobWindow)
local column1 = guiGridListAddColumn(theJobGrid, "  Skin Name:", 0.69)
local column2 = guiGridListAddColumn(theJobGrid, "ID:", 0.2)
local theJobButton1 = guiCreateButton(11,426,149,35,"Take job!",false,theJobWindow)
local theJobButton2 = guiCreateButton(163,426,149,35,"No thanks!",false,theJobWindow)
local theJobMemo = guiCreateMemo(9,44,322,217,"",false,theJobWindow)
guiMemoSetReadOnly(theJobMemo, true)
local theJobLabel1 = guiCreateLabel(14,22,257,17,"Information about this job:",false,theJobWindow)
guiSetFont(theJobLabel1,"default-bold-small")
local theJobLabel2 = guiCreateLabel(14,269,257,17,"Choose job clothes:",false,theJobWindow)
guiSetFont(theJobLabel2,"default-bold-small")

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(theJobWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(theJobWindow,x,y,false)

guiWindowSetMovable (theJobWindow, true)
guiWindowSetSizable (theJobWindow, false)
guiSetVisible (theJobWindow, false)

timer=false
local theHitMarker = nil

function onClientJobMarkerHit(hitElement, matchingDimension)
	local px,py,pz = getElementPosition (hitElement)
	local mx, my, mz = getElementPosition (source)
	local markerNumber = getElementData(source, "jobMarkerNumber")
	if (hitElement == localPlayer) and (pz-1.5 < mz) and (pz+1.5 > mz) then
		if (getTeamName(getPlayerTeam(localPlayer)) == "Staff") or (isElementInGroup (localPlayer, markerNumber)) then
			if not (getPedOccupiedVehicle (localPlayer)) then
				local pts = theJobsTable[markerNumber][11]
				if pts >=10 then pts=math.floor(pts/10) end
				if getPlayerWantedLevel() >= pts then
					exports.DENdxmsg:createNewDxMessage("Your wantedlevel is to high to take this job!", 225, 0, 0)
				else
					theHitMarker = source
					setElementData (localPlayer, "skinBeforeEnter", getElementModel (localPlayer), false)
					guiSetText (theJobWindow, "CSG ~ "..theJobsTable[markerNumber][1])
					guiSetText (theJobMemo, theJobsTable[markerNumber][13])
					loadSkinsIntoGrid(markerNumber)
					guiSetVisible(theJobWindow, true)
					showCursor(true, true)
					setElementFrozen(localPlayer,true)
					timer =  setTimer(function() check() end,500,0)
				end
			end
		end
	end
end

function check()
	if guiGetVisible(theJobWindow) then
		showCursor(true,true)
	else
		if isTimer(timer) then killTimer(timer) setElementFrozen(localPlayer,false) end
	end
end

function loadSkinsIntoGrid(markerNumber)
	local theTable = theJobsTable[markerNumber][10]
	guiGridListClear(theJobGrid)
	for k, v in ipairs (theTable) do
		local row = guiGridListAddRow (theJobGrid)
		guiGridListSetItemText (theJobGrid, row, 1, theJobsTable[markerNumber][1].." "..k, false, true)
		guiGridListSetItemText (theJobGrid, row, 2, v, false, false)
	end
end

function isElementInGroup (thePlayer, markerNumber)
	if (theJobsTable[markerNumber][12]) then
		if (getElementData(thePlayer, "Group") == theJobsTable[markerNumber][12]) then
			return true
		else
			exports.DENdxmsg:createNewDxMessage("You can't take this job!", 225, 0, 0)
			return false
		end
	else
		return true
	end
end

for i=1,#theJobsTable do
	local x, y, z = theJobsTable[i][3], theJobsTable[i][4], theJobsTable[i][5]
	local r, g, b = theJobsTable[i][6], theJobsTable[i][7], theJobsTable[i][8]
	jobMarkersTable[i] = createMarker(x, y, z -1, "cylinder", 2.0, r, g, b, 150)
	setElementData(jobMarkersTable[i], "jobMarkerNumber", i)
	local theSkin = theJobsTable[i][10][math.random(1,#theJobsTable[i][10])]
	local thePed = createPed (theSkin, x, y, z)
	setElementFrozen (thePed, true)
	setPedRotation (thePed, theJobsTable[i][14])
	setElementData(thePed, "showModelPed", true)
	addEventHandler("onClientMarkerHit", jobMarkersTable[i], onClientJobMarkerHit)
end

function onJobSelectSkin ()
	local theSkin = guiGridListGetItemText(theJobGrid, guiGridListGetSelectedItem(theJobGrid), 2, 1)
	if (not theSkin or theSkin == nil or theSkin == "") then
		setElementModel(localPlayer, tonumber(getElementData(localPlayer, "skinBeforeEnter")))
	else
		setElementModel(localPlayer, theSkin)
	end
end
addEventHandler("onClientGUIClick", theJobGrid, onJobSelectSkin)

function onJobWindowClose()
	guiSetVisible(theJobWindow, false)
	showCursor(false, false)
	setElementModel (localPlayer, tonumber(getElementData(localPlayer, "skinBeforeEnter")), true)
end
addEventHandler("onClientGUIClick", theJobButton2, onJobWindowClose, false)

function onPlayerTakeJob()
	if (theHitMarker) then
		local theSkin = guiGridListGetItemText(theJobGrid, guiGridListGetSelectedItem (theJobGrid), 2, 1)
		if (not theSkin or theSkin == nil or theSkin == "") then
			exports.DENdxmsg:createNewDxMessage("Please select a skin before taking the job!", 225, 0, 0)
		else
			guiSetVisible(theJobWindow, false) showCursor(false, false)
			local markerNumber = getElementData(theHitMarker, "jobMarkerNumber")
			local theTeam, theOccupation, theWeapon = theJobsTable[markerNumber][2], theJobsTable[markerNumber][1], theJobsTable[markerNumber][9]
			if (theJobsTable[markerNumber].inDev) then
				exports.DENdxmsg:createNewDxMessage("This job is in development and only staff can take it",255,0,0)
				if getTeamName(getPlayerTeam(localPlayer)) ~= "Staff" then
					return
				end
			end
			setElementModel (localPlayer, tonumber(getElementData(localPlayer, "skinBeforeEnter")))
			triggerServerEvent("onSetPlayerJob", localPlayer, theTeam, theOccupation, tonumber(theSkin), theWeapon,theJobsTable[markerNumber]["nrgb"] or false)

			if (theTeam ~= getTeamName(getPlayerTeam(localPlayer))) then
				triggerEvent("onClientPlayerTeamChange", localPlayer, getPlayerTeam(localPlayer), getTeamFromName(theTeam))
			end
			triggerEvent("onClientPlayerJobChange", localPlayer, theOccupation, theTeam)
		end
	end
end
addEventHandler("onClientGUIClick", theJobButton1, onPlayerTakeJob, false)

--[[
smurfsTXD = engineLoadTXD("sm.txd")
engineImportTXD(smurfsTXD,261)
smurfsDFF = engineLoadDFF("sm.dff",261)
engineReplaceModel(smurfsDFF,261)

--MF
champsTXD = engineLoadTXD("army.txd")
engineImportTXD(champsTXD,97)
champsDFF = engineLoadDFF("army.dff",97)
engineReplaceModel(champsDFF,97)
--]]
--[[
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	legionTXD = engineLoadTXD("legion.txd",231)
	legionDFF = engineLoadDFF("legion.dff",231)
	if legionTXD == false then
		exports.CSGsecrettrans:downloadFile(":/CSGsecrettrans/legion.txd", "legion.txd", 200)
	else
		engineImportTXD(legionTXD,231)
	end
	if legionDFF == false then
		exports.CSGsecrettrans:downloadFile(":/CSGsecrettrans/legion.dff", "legion.dff", 200)
	else
		engineReplaceModel(legionDFF,231)
	end
end)
--]]
--[[
legionTXD = engineLoadTXD("legion.txd")
engineImportTXD(legionTXD,231)
legionDFF = engineLoadDFF("legion.dff",231)
engineReplaceModel(legionDFF,231)
--]]
--[[
addEventHandler("onClientDownloadComplete", getRootElement(),
function (theFile)
	if theFile == ":/DENjob/legion.txd" then
		legionTXD = engineLoadTXD(theFile)
		engineImportTXD(legionTXD,231)
	elseif theFile == ":/DENjob/legion.dff" then
		legionDFF = engineLoadDFF(theFile,231)
		engineReplaceModel(legionDFF,231)
	end
end)
--]]
--[[
swatTXD = engineLoadTXD ("swat.txd")
engineImportTXD (swatTXD, 54)
swatDFF = engineLoadDFF ("swat.dff", 54)
engineReplaceModel (swatDFF, 54)


tsfTXD = engineLoadTXD ("tsf.txd")
engineImportTXD (tsfTXD, 222)
tsfDFF = engineLoadDFF ("tsf.dff", 222)
engineReplaceModel (tsfDFF, 222)


wolfTXD = engineLoadTXD ("wolf.txd")
engineImportTXD (wolfTXD, 232)
wolfDFF = engineLoadDFF ("wolf.dff", 232)
engineReplaceModel (wolfDFF, 232)


terrorists5TXD = engineLoadTXD ("terrorists5.txd")
engineImportTXD (terrorists5TXD, 136)
terrorists5DFF = engineLoadDFF ("terrorists5.dff", 136)
engineReplaceModel (terrorists5DFF, 136)
--]]

function Tskin()
terrorists5TXD = engineLoadTXD ("terrorists5.txd")
engineImportTXD (terrorists5TXD, 136)
terrorists5DFF = engineLoadDFF ("terrorists5.dff", 136)
engineReplaceModel (terrorists5DFF, 136)
end

local mods = {
	--{"lamb",503},
	{"fbijuly23",286},
	--{"smokeghost",38},
	{"swatjuly19",54},
	{"wolfjuly23",232},
	{"tq",231},
	{"smjuly5",261},
	{"s2m",57},
--	{"mf1july23",97},
	{"mf1july26",97},
	{"mf2july23",131},
	{"fbi3",51},
	{"fbi0",240},
--	{"terrorists5",136},

--	{"terroristsjuly5",136}
}
local res = "DENjob"

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	for k,v in pairs(mods) do
		lambTXD = engineLoadTXD(""..v[1]..".txd",v[2])
		lambDFF = engineLoadDFF(""..v[1]..".dff",v[2])
		if lambTXD == false then
			exports.CSGsecrettrans:downloadFile(":"..res.."/"..v[1]..".txd",":"..res.."/"..v[1]..".txd", 150)
		else
			engineImportTXD(lambTXD,v[2])
		end
		if lambDFF == false then
			exports.CSGsecrettrans:downloadFile(":"..res.."/"..v[1]..".dff",":"..res.."/"..v[1]..".dff", 150)
		else
			engineReplaceModel(lambDFF, v[2])
		end
	end
end)

addEvent("onClientDownloadComplete",true)
addEventHandler("onClientDownloadComplete", getRootElement(),
function (theFile)
	for k,v in pairs(mods) do
		if theFile == ":"..res.."/"..v[1]..".txd" then
			lambTXD = engineLoadTXD(theFile)
			engineImportTXD(lambTXD,v[2])
		elseif theFile == ":"..res.."/"..v[1]..".dff" then
			lambDFF = engineLoadDFF(theFile,v[2])
			engineReplaceModel(lambDFF,v[2])
		end
	end
end)
