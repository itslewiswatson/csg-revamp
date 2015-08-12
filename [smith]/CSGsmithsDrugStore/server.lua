------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithsDrugStore/server (server-side)
--  Drug Store Script
--  [CSG]Smith
------------------------------------------------------------------------------------
crash = {{{{{{{{ {}, {}, {} }}}}}}}}
_root = getRootElement ( )
_resroot = getResourceRootElement ( getThisResource ( ) )

local enterMarker = createMarker( -1941.9826171875,2379.45703125,50.6953125, 'arrow', 1.5, 0, 255, 0, 150 )
local exitMarker = createMarker( -1952.6943359375,2375.576171875,9.5251907349, 'arrow', 1.8, 0, 255, 0, 150 )

local Marker_1 = createMarker( -1952.2609375,2385.6669921875,8, 'cylinder', 1.2, 255, 255, 0, 100 )
local Marker_2 = createMarker( -1947.9482421875,2387.3720703125,8, 'cylinder', 1.2, 255, 255, 0, 100 )
local Marker_3 = createMarker( -1945.7724609375,2386.1826171875,8, 'cylinder', 1.2, 255, 255, 0, 100 )
local Marker_4 = createMarker( -1943.853515625,2381.4326171875,8, 'cylinder', 1.2, 255, 255, 0, 100 )
local Marker_5 = createMarker( -1942.0048828125,2376.962890625,8, 'cylinder', 1.2, 255, 255, 0, 100 )
local Marker_6 = createMarker( -1940.39453125,2372.6298828125,8, 'cylinder', 1.2, 255, 255, 0, 100 )
local Marker_7 = createMarker( -1940.7666015625,2370.693359375,8, 'cylinder', 1.2, 255, 255, 0, 100 )
local Marker_8 = createMarker( -1944.81640625,2368.90625,8, 'cylinder', 1.2, 255, 255, 0, 100 )


local DrugStoreColCuboid = createColCuboid (-1966,2329,8, 50,90, 10)





-------------------------------------------------------------
------------------       SQL           ----------------------
-------------------------------------------------------------
 
addEventHandler ( "onResourceStart" , _resroot , 
	function ( )
		executeSQLQuery("DROP TABLE DrugStoreEvent" )
		executeSQLQuery("CREATE TABLE IF NOT EXISTS DrugStoreEvent (RITALIN INTEGER  , WEED INTEGER , LSD INTEGER , COCAINE INTEGER, ECSTASY INTEGER, HEROINE INTEGER)")
		executeSQLQuery("INSERT INTO DrugStoreEvent( RITALIN, WEED, LSD, COCAINE, ECSTASY, HEROINE) VALUES(?,?,?,?,?,?)",120 , 160, 80, 90, 100, 110 )
		outputDebugString ("DRUG STORE: SQL Database has been created!")
	end
)

-------------------------------------------------------------
------------------       SETTINGS      ----------------------
-------------------------------------------------------------

local Drug_Store_Status = false

-------------------------------------------------------------
-------------------------------------------------------------


addEventHandler ( "onResourceStart" , _resroot , 
	function ()
		Open_DrugStoreEvent()
		outputDebugString ("DRUG STORE: Event has been created!")
		for k, v in ipairs(getElementsByType("player")) do
			setElementData(v,"InsideDrugStore",false)
		end
		Drug_Timer = setTimer( Open_DrugStoreEvent,10,0)					
	end
)


function Open_DrugStoreEvent()
	
	Drug_Store_Status = true
	setMarkerColor ( enterMarker, 0, 255, 0, 150 )
	exports.dendxmsg:createNewDxMessage(_root,"*** Drug Store Event (DSE)***",0,255,0)
	exports.dendxmsg:createNewDxMessage(_root,"DSE: Buy all type of drugs for good prize!",0,255,0)
	exports.dendxmsg:createNewDxMessage(_root,"DSE: Less than 10 mins left till store will be closed! Hurry up!",0,255,0)
	exports.dendxmsg:createNewDxMessage(_root,"DSE: Use /dsetime  to check time left to open/close Drug Store Event!",0,255,0)
	
	
	Time_Till_Store_Closed = setTimer(function ()
								Close_DrugStoreEvent()
								end,600000,1)
	setTimer(function()
					for k, v in ipairs(getElementsByType("player")) do
						if getElementData(v,"InsideDrugStore") == true then
							exports.dendxmsg:createNewDxMessage(v,"DRUG STORE: 60 seconds left till store will be closed!",255,0,0)
						end
					end
					end,540000,1)
end

function Close_DrugStoreEvent()
	Drug_Store_Status = false
	setMarkerColor ( enterMarker, 255, 0, 0, 150 )
	for k, v in ipairs(getElementsByType("player")) do
		if getElementData(v,"InsideDrugStore") == true then
			setElementHealth(v,0)
			exports.dendxmsg:createNewDxMessage(v,"You have been killed due that Drug Store have been closed!",255,0,0)
			triggerClientEvent(thePlayer,"close_all_windows",thePlayer)
		end
	end
end

function TimeLeftTillDrugStoreClose(thePlayer)
	if isTimer (Time_Till_Store_Closed) then
		remaining, executesRemaining, totalExecutes = getTimerDetails(Time_Till_Store_Closed)
		exports.dendxmsg:createNewDxMessage(thePlayer,"DRUG STORE: "..math.ceil(remaining/1000).." second(s) left until Store will be closed.",0,200,0)
	else
		rem, exe, tot = getTimerDetails(Drug_Timer)
		exports.dendxmsg:createNewDxMessage(thePlayer,"DRUG STORE: Store is closed at this moment, will be open in "..math.ceil(rem/60000).." minute(s).",0,255,0)
	end
end
addCommandHandler("dsetime", TimeLeftTillDrugStoreClose)




--------------------------------------------------------------------------------------
-- Markers / Functions that has to do with enter/exit to the interior of Drug Store --
--------------------------------------------------------------------------------------
addEventHandler ("onColShapeHit", getRootElement(),
function( hitElement, matchingDimension )
	if not matchingDimension then return end
	if( getElementType( hitElement ) ~= "player" ) then return end
	if (source == DrugStoreColCuboid) then
		setElementData(hitElement,"InsideDrugStore",true)
		setTimer (giveWeapon, 1500, 1, hitElement,0,1, true)
		toggleControl (hitElement, "next_weapon", false)
		toggleControl (hitElement, "previous_weapon", false)
		toggleControl (hitElement, "fire", false)
		toggleControl (hitElement, "aim_weapon", false)
	end
end
)

addEventHandler ("onColShapeLeave", getRootElement(),
function( hitElement, matchingDimension )
	if not matchingDimension then return end
	if( getElementType( hitElement ) ~= "player" ) then return end
	if (source == DrugStoreColCuboid) then
		setElementData(hitElement,"InsideDrugStore",false)
		toggleControl (hitElement, "next_weapon", true)
		toggleControl (hitElement, "previous_weapon", true)
		toggleControl (hitElement, "fire", true)
		toggleControl (hitElement, "aim_weapon", true)
		triggerClientEvent(hitElement,"close_all_windows",hitElement)
	end
end
)




function enterPlayer( hitPlayer, matchingDimension )
	if( getElementType( hitPlayer ) ~= "player" ) then return end
	if (Drug_Store_Status == false) then
			rem, exe, tot = getTimerDetails(Drug_Timer)
		exports.dendxmsg:createNewDxMessage(hitPlayer,"DRUG STORE: Store is closed at this moment, will be open in "..math.ceil(rem/60000).." minute(s).",0,255,0)
	elseif (Drug_Store_Status == true) then
		loc = math.random(1,5)
			--	setElementDimension( hitPlayer, 0)
				setElementRotation(hitPlayer,0,0,270)
		if loc == 1 then
			setElementPosition ( hitPlayer,  -1948,2374, 9)
		elseif loc == 2 then
			setElementPosition ( hitPlayer,  -1950,2378, 9)
		elseif loc == 3 then
			setElementPosition ( hitPlayer,  -1949,2377, 9)
		elseif loc == 4 then
			setElementPosition ( hitPlayer,  -1950,2379, 9)
		elseif loc == 5 then
			setElementPosition ( hitPlayer,  -1949,2376,9)
		end	
	end
end
addEventHandler( "onMarkerHit", enterMarker, enterPlayer )


function exitPlayer( hitPlayer, matchingDimension )
	if( getElementType( hitPlayer ) ~= "player" ) then return end
		locd = math.random(1,5)
		setElementRotation(hitPlayer,0,0,270)
		if locd == 1 then
			setElementPosition ( hitPlayer,-1938, 2381, 50)
		elseif locd == 2 then
			setElementPosition ( hitPlayer, -1938, 2379, 50)
		elseif locd == 3 then
			setElementPosition ( hitPlayer, -1940, 2379.5, 50)
		elseif locd == 4 then
			setElementPosition ( hitPlayer, -1940, 2381, 50)
		elseif locd == 5 then
			setElementPosition ( hitPlayer, -1939, 2377.5,50)
		end	
		--setElementDimension( hitPlayer, 0)
end
addEventHandler( "onMarkerHit",exitMarker, exitPlayer )



addEventHandler( "onMarkerHit",_root,
function( hitPlayer, matchingDimension )
	if not matchingDimension then return end
	if ((source == Marker_1) or (source == Marker_2) or (source == Marker_3) or (source == Marker_4) or (source == Marker_5) or (source == Marker_6) or (source == Marker_7) or (source == Marker_8)) then
		dTable = executeSQLQuery("SELECT RITALIN,WEED,LSD,COCAINE,ECSTASY,HEROINE FROM DrugStoreEvent" )
		if ( type ( dTable ) == 'table' ) and ( #dTable == 0 ) then
			executeSQLQuery("INSERT INTO DrugStoreEvent( RITALIN, WEED, LSD, COCAINE, ECSTASY, HEROINE) VALUES(?,?,?,?,?,?)",120 , 160, 80, 90, 100, 110 )
			triggerClientEvent(hitPlayer,"DrugStoreShop",hitPlayer,120,160,80,90,100,110)
		else
			triggerClientEvent(hitPlayer,"DrugStoreShop",hitPlayer,dTable[1].RITALIN,dTable[1].WEED,dTable[1].LSD,dTable[1].COCAINE,dTable[1].ECSTASY,dTable[1].HEROINE)
		end
	end
end
)

addEvent( "updateDrugPrize", true )
function updateDrugPrize(drugName, prize)
	dprize = tonumber(prize)
	dTable = executeSQLQuery("SELECT RITALIN,WEED,LSD,COCAINE,ECSTASY,HEROINE FROM DrugStoreEvent" )
	if drugName == "Ritalin" then
		executeSQLQuery("UPDATE DrugStoreEvent SET RITALIN='"..dprize.."'" )
		triggerClientEvent("refreshDrugPrizes",getRootElement(),dprize,dTable[1].WEED,dTable[1].LSD,dTable[1].COCAINE,dTable[1].ECSTASY,dTable[1].HEROINE)
	elseif drugName == "Weed" then
		executeSQLQuery("UPDATE DrugStoreEvent SET WEED='"..dprize.."'" )
		triggerClientEvent("refreshDrugPrizes",getRootElement(),dTable[1].RITALIN,dprize,dTable[1].LSD,dTable[1].COCAINE,dTable[1].ECSTASY,dTable[1].HEROINE)
	elseif drugName == "Lsd" then
		executeSQLQuery("UPDATE DrugStoreEvent SET LSD='"..dprize.."'" )
		triggerClientEvent("refreshDrugPrizes",getRootElement(),dTable[1].RITALIN,dTable[1].WEED,dprize,dTable[1].COCAINE,dTable[1].ECSTASY,dTable[1].HEROINE)
	elseif drugName == "Cocaine" then
		executeSQLQuery("UPDATE DrugStoreEvent SET COCAINE='"..dprize.."'" )
		triggerClientEvent("refreshDrugPrizes",getRootElement(),dTable[1].RITALIN,dTable[1].WEED,dTable[1].LSD,dprize,dTable[1].ECSTASY,dTable[1].HEROINE)
	elseif drugName == "Ecstasy" then
		executeSQLQuery("UPDATE DrugStoreEvent SET ECSTASY='"..dprize.."'" )
		triggerClientEvent("refreshDrugPrizes",getRootElement(),dTable[1].RITALIN,dTable[1].WEED,dTable[1].LSD,dTable[1].COCAINE,dprize,dTable[1].HEROINE)
	elseif drugName == "Heroine" then
		executeSQLQuery("UPDATE DrugStoreEvent SET HEROINE='"..dprize.."'" )
		triggerClientEvent("refreshDrugPrizes",getRootElement(),dTable[1].RITALIN,dTable[1].WEED,dTable[1].LSD,dTable[1].COCAINE,dTable[1].ECSTASY,dprize)
	end
end
addEventHandler( "updateDrugPrize", getRootElement(), updateDrugPrize )


addCommandHandler("dsesettings",
function(thePlayer)
	 if ("smith" == exports.server:getPlayerAccountName(thePlayer) or "nasar" == exports.server:getPlayerAccountName(thePlayer) or "jack" == exports.server:getPlayerAccountName(thePlayer)) then
		dTable = executeSQLQuery("SELECT RITALIN,WEED,LSD,COCAINE,ECSTASY,HEROINE FROM DrugStoreEvent" )
		if ( type ( dTable ) == 'table' ) and ( #dTable == 0 ) then
			executeSQLQuery("INSERT INTO DrugStoreEvent( RITALIN, WEED, LSD, COCAINE, ECSTASY, HEROINE) VALUES(?,?,?,?,?,?)",120 , 160, 80, 90, 100, 110 )
			triggerClientEvent(thePlayer,"DrugStoreShop_Settings",thePlayer,120,160,80,90,100,110)
		else
			triggerClientEvent(thePlayer,"DrugStoreShop_Settings",thePlayer,dTable[1].RITALIN,dTable[1].WEED,dTable[1].LSD,dTable[1].COCAINE,dTable[1].ECSTASY,dTable[1].HEROINE)
		end
	end
end
)

addCommandHandler("dseprize",
function(thePlayer)
	dTable = executeSQLQuery("SELECT RITALIN,WEED,LSD,COCAINE,ECSTASY,HEROINE FROM DrugStoreEvent" )
	outputChatBox ( " *** DRUG STORE EVENT / Prize List ***",  thePlayer, 0,255,0 )
	outputChatBox ( " Retailin  $"..dTable[1].RITALIN,  thePlayer, 0,255,0 )
	outputChatBox ( " Weed  $"..dTable[1].WEED,  thePlayer, 0,255,0 )
	outputChatBox ( " Lsd  $"..dTable[1].LSD,  thePlayer, 0,255,0 )
	outputChatBox ( " Cocaine  $"..dTable[1].COCAINE,  thePlayer, 0,255,0 )
	outputChatBox ( " Ecstasy  $"..dTable[1].ECSTASY,  thePlayer, 0,255,0 )
	outputChatBox ( " Heroine  $"..dTable[1].HEROINE,  thePlayer, 0,255,0 )
	outputChatBox ( " ------------------------------",  thePlayer, 0,255,0 )
end
)

addEvent( "dStoreTrigger", true )
function dStoreTrigger(thePlayer,drugName,hits)
	local hitsNumber = tonumber(hits)
	local pMoney = getPlayerMoney(thePlayer)
	dTable = executeSQLQuery("SELECT RITALIN,WEED,LSD,COCAINE,ECSTASY,HEROINE FROM DrugStoreEvent" )
	if drugName == "Ritalin" then
		prize = tonumber(dTable[1].RITALIN)
		totalcosts = prize*hitsNumber
		if pMoney >= totalcosts then
			takePlayerMoney(thePlayer,totalcosts)
			exports.dendxmsg:createNewDxMessage(thePlayer,"Successfuly bought "..hitsNumber.." hits of "..drugName.."",0,255,0)
			exports.CSGdrugs:giveDrug(thePlayer,drugName,hitsNumber)
		else
			additional = totalcosts - pMoney
			exports.dendxmsg:createNewDxMessage(thePlayer,"You need additional of $"..additional.." to be able to buy "..hitsNumber.." drug hits.",255,0,0)
		end
	elseif drugName == "Weed" then
		prize = tonumber(dTable[1].WEED)
		totalcosts = prize*hitsNumber
		if pMoney >= totalcosts then
			takePlayerMoney(thePlayer,totalcosts)
			exports.dendxmsg:createNewDxMessage(thePlayer,"Successfuly bought "..hitsNumber.." hits of "..drugName.."",0,255,0)
			exports.CSGdrugs:giveDrug(thePlayer,drugName,hitsNumber)
		else
			additional = totalcosts - pMoney
			exports.dendxmsg:createNewDxMessage(thePlayer,"You need additional of $"..additional.." to be able to buy "..hitsNumber.." drug hits.",255,0,0)
		end
	elseif drugName == "Lsd" then
		prize = tonumber(dTable[1].LSD)
		totalcosts = prize*hitsNumber
		if pMoney >= totalcosts then
			takePlayerMoney(thePlayer,totalcosts)
			exports.dendxmsg:createNewDxMessage(thePlayer,"Successfuly bought "..hitsNumber.." hits of "..drugName.."",0,255,0)
			exports.CSGdrugs:giveDrug(thePlayer,"LSD",hitsNumber)
		else
			additional = totalcosts - pMoney
			exports.dendxmsg:createNewDxMessage(thePlayer,"You need additional of $"..additional.." to be able to buy "..hitsNumber.." drug hits.",255,0,0)
		end
	elseif drugName == "Cocaine" then
		prize = tonumber(dTable[1].COCAINE)
		totalcosts = prize*hitsNumber
		if pMoney >= totalcosts then
			takePlayerMoney(thePlayer,totalcosts)
			exports.dendxmsg:createNewDxMessage(thePlayer,"Successfuly bought "..hitsNumber.." hits of "..drugName.."",0,255,0)
			exports.CSGdrugs:giveDrug(thePlayer,drugName,hitsNumber)
		else
			additional = totalcosts - pMoney
			exports.dendxmsg:createNewDxMessage(thePlayer,"You need additional of $"..additional.." to be able to buy "..hitsNumber.." drug hits.",255,0,0)
		end
	elseif drugName == "Ecstasy" then
		prize = tonumber(dTable[1].ECSTASY)
		totalcosts = prize*hitsNumber
		if pMoney >= totalcosts then
			takePlayerMoney(thePlayer,totalcosts)
			exports.dendxmsg:createNewDxMessage(thePlayer,"Successfuly bought "..hitsNumber.." hits of "..drugName.."",0,255,0)
			exports.CSGdrugs:giveDrug(thePlayer,drugName,hitsNumber)
		else
			additional = totalcosts - pMoney
			exports.dendxmsg:createNewDxMessage(thePlayer,"You need additional of $"..additional.." to be able to buy "..hitsNumber.." drug hits.",255,0,0)
		end
	elseif drugName == "Heroine" then
		prize = tonumber(dTable[1].HEROINE)
		totalcosts = prize*hitsNumber
		if pMoney >= totalcosts then
			takePlayerMoney(thePlayer,totalcosts)
			exports.dendxmsg:createNewDxMessage(thePlayer,"Successfuly bought "..hitsNumber.." hits of "..drugName.."",0,255,0)
			exports.CSGdrugs:giveDrug(thePlayer,drugName,hitsNumber)
		else
			additional = totalcosts - pMoney
			exports.dendxmsg:createNewDxMessage(thePlayer,"You need additional of $"..additional.." to be able to buy "..hitsNumber.." drug hits.",255,0,0)
		end
	end
end
addEventHandler( "dStoreTrigger", getRootElement(), dStoreTrigger )


-------------------------------------------------------------
-------------------------------------------------------------

-------------------------------------------------------------
-------------------- MAP Files  -----------------------------
-------------------------------------------------------------

createObject ( 14665, -1946.5, 2378, 9.8, 0, 0, 22 )
createObject ( 1491, -1950.80005, 2374.59009, 7.8, 0, 0, 114 )
createObject ( 1491, -1952, 2377.36963, 7.8, 0, 0, 291.995 )
createObject ( 2367, -1949.09998, 2388.3999, 7.8, 0, 0, 21.995 )
createObject ( 2367, -1953.30005, 2386.69995, 7.8, 0, 0, 21.995 )
createObject ( 2367, -1944.59998, 2387.30005, 7.8, 0, 0, 293.995 )
createObject ( 2367, -1942.69995, 2382.6001, 7.8, 0, 0, 291.995 )
createObject ( 2367, -1940.90002, 2378, 7.8, 0, 0, 291.995 )
createObject ( 2367, -1939.19995, 2373.80005, 7.8, 0, 0, 291.995 )
createObject ( 2367, -1939.59998, 2369.30005, 7.8, 0, 0, 201.995 )
createObject ( 2367, -1943.59998, 2367.69995, 7.8, 0, 0, 203.99 )
createObject ( 1313, -1952.59998, 2386.5, 8.25, 0, 0, 22 )
createObject ( 1575, -1953.09973, 2386.51953, 8.7, 0, 0, 22 )
createObject ( 1575, -1952.20044, 2386.88989, 8.66, 0, 0, 22 )
createObject ( 1314, -1948.30005, 2388.19995, 8.2, 0, 0, 22 )
createObject ( 1254, -1944.40002, 2367.8999, 8.3, 0, 0, 30 )
createObject ( 1241, -1940.30005, 2369.5, 8.24, 0, 0, 26 )
createObject ( 1240, -1939.40002, 2373.1001, 8.301, 0, 0, 300 )
createObject ( 1248, -1941.19995, 2377.30005, 8.27, 0, 0, 292 )
createObject ( 1318, -1944.80005, 2386.57007, 8.28, 0, 0, 24 )
createObject ( 2891, -1942.88, 2382.50098, 8.62, 0, 0, 18 )
createObject ( 2891, -1942.40637, 2381.48486, 8.65, 0, 0, 22 )
createObject ( 1279, -1946, 2389.30005, 7.9, 0, 0, 22 )
createObject ( 1279, -1937.80005, 2370.1001, 7.901 )
createObject ( 1279, -1945.59998, 2388.6001, 7.9 )
createObject ( 1576, -1948.92432, 2388.30103, 8.63598, 0, 0, 20 )
createObject ( 1576, -1947.97559, 2388.67993, 8.63598, 0, 0, 22 )
createObject ( 1577, -1944.73755, 2387.10522, 8.63598, 0, 0, 290 )
createObject ( 1577, -1944.29956, 2386.20996, 8.63598, 0, 0, 112 )
createObject ( 1241, -1942.94995, 2381.8999, 8.2, 0, 0, 122 )
createObject ( 1578, -1939.36951, 2373.69019, 8.63598, 0, 0, 114 )
createObject ( 1578, -1939, 2372.68994, 8.63598, 0, 0, 112 )
createObject ( 1579, -1941.05005, 2377.82983, 8.63598, 0, 0, 114 )
createObject ( 1579, -1940.66003, 2376.89014, 8.63598, 0, 0, 112 )
createObject ( 1580, -1939.77002, 2369.39941, 8.63598, 0, 0, 18 )
createObject ( 1580, -1940.79004, 2369.00488, 8.63598, 0, 0, 22 )
createObject ( 1575, -1943.80005, 2367.90967, 8.63598, 0, 0, 22 )
createObject ( 1575, -1944.69946, 2367.51001, 8.63598, 0, 0, 12 )
createObject ( 1279, -1943.5, 2384.3999, 7.89, 0, 0, 314 )
createObject ( 1279, -1950.5, 2387.69995, 7.89 )
createObject ( 1279, -1942.09998, 2380.5, 7.9, 0, 0, 158 )
createObject ( 1279, -1941.5, 2378.8999, 7.89, 0, 0, 311.995 )
createObject ( 1279, -1939.90002, 2375.3999, 7.89, 0, 0, 99 )
createObject ( 1279, -1938.19995, 2371.19995, 7.89, 0, 0, 98.998 )
createObject ( 1279, -1942.19995, 2368.5, 7.89 )
createObject ( 1279, -1946.19995, 2366.8999, 7.9 )
createObject ( 3383, -1944.5, 2373.80005, 7.6, 0, 0, 112 )
createObject ( 3383, -1947.80005, 2381.6001, 7.6, 0, 0, 111.995 )
createObject ( 1279, -1948.19995, 2382.69995, 8.7 )
createObject ( 1279, -1947.59998, 2381.8999, 8.7, 0, 0, 298 )
createObject ( 1575, -1948.40002, 2381.69995, 8.7, 0, 0, 355.995 )
createObject ( 1577, -1947.90002, 2380.80005, 8.7, 0, 0, 273 )
createObject ( 1279, -1944, 2372.30005, 8.7, 0, 0, 207.999 )
createObject ( 1575, -1945, 2375.1001, 8.7 )
createObject ( 1579, -1944.59998, 2374.19995, 8.7, 0, 0, 111.995 )
createObject ( 1578, -1944.19995, 2373.3999, 8.7, 0, 0, 97.995 )
createObject ( 2891, -1944.90002, 2373.69995, 8.7, 0, 0, 21.995 )
------------------------------------------------------------------