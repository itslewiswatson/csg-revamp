-------------------------------------------------------------------------------
-------------- HOUSING SYSTEM V1.1 COPYRIGHT DENNIS (UNION) CSG! --------------
-------------------------------------------------------------------------------

local intids = {
-- House interoirs with locations
[1]="3|235.22|1188.84|1080.25",
[2]="2|225.13|1240.07|1082.14",
[3]="1|223.2|1288.84|1082.13",
[4]="15|328.03|1479.42|1084.43",
[5]="2|2466.27|-1698.18|1013.5",
[6]="5|227.76|1114.44|1080.99",
[7]="15|385.72|1471.91|1080.18",
[8]="7|225.83|1023.95|1084",
[9]="8|2807.61|-1172.83|1025.57",
[10]="10|2268.66|-1210.38|1047.56",
[11]="3|2495.79|-1694.12|1014.74",
[12]="10|2261.62|-1135.71|1050.63",
[13]="8|2365.2|-1133.07|1050.87",
[14]="5|2233.68|-1113.33|1050.88",
[15]="11|2283|-1138.13|1050.89",
[16]="6|2194.83|-1204.12|1049.02",
[17]="6|2308.73|-1210.88|1049.02",
[18]="1|2215.42|-1076.06|1050.48",
[19]="2|2237.74|-1078.89|1049.02",
[20]="9|2318.03|-1024.64|1050.21",
[21]="6|2333.03|-1075.38|1049.02",
[22]="5|1263.44|-785.63|1091.9",
[23]="1|245.98|305.13|999.14",
[24]="2|269.09|305.15|999.14",
[25]="12|2324.39|-1145.2|1050.71",
[26]="5|318.56|1118.2|1083.88",
[27]="1|245.78|305.12|999.14",
[28]="5|140.33|1368.78|1083.86",
[29]="6|234.21|1066.84|1084.2",
[30]="9|83.52|1324.48|1083.85",
[31]="10|24.15|1341.64|1084.37",
[32]="15|374.34|1417.51|1081.32",
[33]="1|2525.0420|-1679.1150|1015.4990",
}

local leavingCols = {
-- Leaving positions for the doors
[1] = {3, 235.23, 1186.67, 1080.25},
[2] = {2, 226.78, 1239.93, 1082.14},
[3] = {1, 223.07, 1287.08, 1082.13},
[4] = {15, 327.94, 1477.72, 1084.43},
[5] = {2, 2468.84, -1698.36, 1013.5},
[6] = {5, 226.29, 1114.27, 1080.99},
[7] = {15, 387.22, 1471.73, 1080.18},
[8] = {7, 225.66, 1021.44, 1084},
[9] = {8, 2807.62, -1174.76, 1025.57},
[10] = {10, 2270.41, -1210.53, 1047.56},
[11] = {3, 2496.05, -1692.09, 1014.74},
[12] = {10, 2259.38, -1135.9, 1050.63},
[13] = {8, 2365.18, -1135.6, 1050.87},
[14] = {5, 2233.64, -1115.27, 1050.88},
[15] = {11, 2282.82, -1140.29, 1050.89},
[16] = {6, 2196.85, -1204.45, 1049.02},
[17] = {6, 2308.76, -1212.94, 1049.02},
[18] = {1, 2218.4, -1076.36, 1050.48},
[19] = {2, 2237.55, -1081.65, 1049.02},
[20] = {9, 2317.77, -1026.77, 1050.21},
[21] = {6, 2333, -1077.36, 1049.02},
[22] = {5, 1260.64, -785.34, 1091.9},
[23] = {1, 243.71, 305.01, 999.14},
[24] = {2, 266.49, 304.99, 999.14},
[25] = {12, 2324.31, -1149.55, 1050.71},
[26] = {5, 318.57, 1114.47, 1083.88},
[27] = {1, 243.71, 304.96, 999.14},
[28] = {5, 140.32, 1365.91, 1083.86},
[29] = {6, 234.13, 1063.72, 1084.2},
[30] = {9, 83.04, 1322.28, 1083.85},
[31] = {10, 23.92, 1340.16, 1084.37},
[32] = {15, 377.15, 1417.3, 1081.32},
[33] = {5, 1298.87, -797.01, 1084, 1015.4990}
}

-------------------------------------------------------------------------------
-------------------------------- DATABASE FUNCTIONS ---------------------------
-------------------------------------------------------------------------------

function onUpdateHouseData ( houseID, column1, data1, column2, data2, column3, data3 )
	if ( houseID ) then
		if ( column1 ) and ( column2 ) and ( column3 ) then
			exports.DENmysql:exec("UPDATE housing SET `??`=?, `??`=?, `??`=? WHERE id=?", column1, data1, column2, data2, column3, data3, houseID )
		elseif ( column1 ) and ( culumn2 ) then
			exports.DENmysql:exec("UPDATE housing SET `??`=?, `??`=? WHERE id=?", column1, data1, column2, data2, houseID )
		elseif ( column1 ) then
			exports.DENmysql:exec("UPDATE housing SET `??`=? WHERE id=?", column1, data1, houseID )
		end
	end
end

function onPlayerUpdateLabels ( thePlayer, houseID )
	local houseTable = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", tonumber(houseID) )
	triggerClientEvent ( thePlayer, "updateLabels", thePlayer, houseTable.ownerid, houseTable.interiorid, houseTable.sale, houseTable.houseprice, houseTable.housename, houseTable.locked, houseTable.boughtprice, houseTable.passwordlocked )
	return true
end

function onPlayerUpdateLabelsOnBuy ( thePlayer, houseID )
	local playersid = exports.server:getPlayerAccountID( source )
	local houseTable = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", tonumber(houseID) )
	triggerClientEvent ( thePlayer, "updateLabelsOnBuy", thePlayer, playersid, houseTable.id, exports.server:getPlayerAccountName(thePlayer), houseTable.ownerid, houseTable.interiorid, houseTable.sale, houseTable.houseprice, houseTable.housename, houseTable.locked, houseTable.boughtprice )
	return true
end

-------------------------------------------------------------------------------
------------------------------ OTHER HOUSE FUNCTIONS --------------------------
-------------------------------------------------------------------------------

-- On resource start create the houses
function onHousingStart ()
	local houses = exports.DENmysql:query( "SELECT * FROM housing" )
	if ( houses and #houses > 0 ) then
		for i=1,#houses do
			-- Load the houses on resource start
			createHouse( houses[i].id, houses[i].ownerid, houses[i].interiorid, houses[i].x, houses[i].y, houses[i].z, houses[i].sale, houses[i].houseprice, houses[i].housename, houses[i].locked, houses[i].boughtprice, houses[i].passwordlocked, houses[i].password )
		end
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), onHousingStart )

-- When a player hits the door warp him outside
function onHousingColHit ( thePlayer )
	local houseDimension = getElementDimension(thePlayer)
	local houseLocation = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", tonumber(houseDimension) )
	setElementInterior(thePlayer, 0, houseLocation.x, houseLocation.y, houseLocation.z)
	setElementPosition(thePlayer, houseLocation.x,houseLocation.y,houseLocation.z)
	setElementDimension(thePlayer, 0)
end

-- Create the leaving markers
for i=1,#leavingCols do
	local x, y, z = leavingCols[i][2], leavingCols[i][3], leavingCols[i][4]
	local interior = leavingCols[i][1]
	colCircle = createColTube ( x, y, z -0.5, 1.3, 2.5 )
	setElementInterior (colCircle, interior)
	addEventHandler ( "onColShapeHit", colCircle, onHousingColHit )
end

-- Create houses
function createHouse ( houseid, ownerid, interiorid, housex, housey, housez, housesale, houseprice, housename, houselocked, boughtprice, passwordlocked, housepassword )
	if ( housesale == 0 ) then
		_G["house"..tostring(houseid)] = createPickup ( housex, housey, housez, 3, 1272, 0)
	else
		_G["house"..tostring(houseid)] = createPickup ( housex, housey, housez, 3, 1273, 0)
	end
	
	local house = _G["house"..tostring(houseid)]
	local houseOwner = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ?", tonumber(ownerid) )
	
	if not ( houseOwner ) then
		outputServerLog( "House: " .. houseid .. " has no owner set, please check in the database!", 3 )
		return
	end
	
	setElementData(house, "1", houseid)
	setElementData(house, "2", houseOwner.username)
	setElementData(house, "3",  tonumber(ownerid))
	setElementData(house, "4",  tonumber(interiorid))
	setElementData(house, "5",  tonumber(housesale))
	setElementData(house, "6", tonumber(houseprice))
	setElementData(house, "7", housename)
	setElementData(house, "8",  tonumber(houselocked))
	setElementData(house, "9",  tonumber(boughtprice))
	setElementData(house, "10",  tonumber(housepassword))
	setElementData(house, "11",  tonumber(passwordlocked))
end

-- Show the housing gui
addEventHandler ( "onPickupHit", root,
function ( thePlayer )
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
	if not ( theVehicle ) then
		local houseElementID = getElementData(source, "1")
		local houseElement = _G["house"..tostring( houseElementID )]
		if ( source == houseElement ) then
			local playerID = exports.server:getPlayerAccountID( thePlayer )
			local houseid = getElementData(source, "1")
			local ownersid = getElementData(source, "3")
			local ownername = getElementData(source, "2")
			local interiorid = getElementData(source, "4")
			local housesale = getElementData(source, "5")
			local houseprice = getElementData(source, "6")
			local housename = getElementData(source, "7")
			local houselocked = getElementData(source, "8")
			local boughtprice = getElementData(source, "9")
			local passwordlocked = getElementData(source, "11")
			triggerClientEvent ( thePlayer, "showHousingGui", thePlayer, playerID, houseid, ownername, ownersid, interiorid, housesale, houseprice, housename, houselocked, boughtprice, passwordlocked )
		end
	end
end )

-- Function when player enters the house
addEvent( "enterHouse", true )
function enterHouse (houseid, interiorid, isPassword, password)
	local theHouse = _G["house"..tostring( houseid )]
	local ownersid = getElementData( theHouse, "3" )
	local playersid = exports.server:getPlayerAccountID( source )
	local sourceTeam = getTeamName( getPlayerTeam( source ) )
	if ( isPassword ) or ( sourceTeam == "Staff" ) or ( sourceTeam == "SWAT" ) or ( sourceTeam == "Military Forces" ) then
		if ( tostring(getElementData(theHouse, "10")) == tostring(password) ) or ( sourceTeam == "Staff" ) or ( sourceTeam == "SWAT" ) or ( sourceTeam == "Military Forces" ) then
			local playerdim = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", houseid )
			local portstring = intids[tonumber(interiorid)]
			local tInt = gettok ( portstring, 1, string.byte('|') )
			local tX = gettok ( portstring, 2, string.byte('|') )
			local tY = gettok ( portstring, 3, string.byte('|') )
			local tZ = gettok ( portstring, 4, string.byte('|') )	

			setElementInterior(source, tInt, tX, tY, tZ)
			setElementPosition(source, tX,tY,tZ)
			setElementDimension(source, tonumber(playerdim.id))
		else
			outputChatBox("Wrong house password! Try again.", source, 225, 0, 0)
		end
	else
		if ( ownersid ~= playersid ) and ( getElementData(theHouse, "11") == 1 ) then
			triggerClientEvent( source, "showPasswordWindow", source )
		else
			local playerdim = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", houseid)
			local portstring = intids[tonumber(interiorid)]
			local tInt = gettok ( portstring, 1, string.byte('|') )
			local tX = gettok ( portstring, 2, string.byte('|') )
			local tY = gettok ( portstring, 3, string.byte('|') )
			local tZ = gettok ( portstring, 4, string.byte('|') )	

			setElementInterior(source, tInt, tX, tY, tZ)
			setElementPosition(source, tX,tY,tZ)
			setElementDimension(source, tonumber(playerdim.id))
		end
	end
end
addEventHandler( "enterHouse", root, enterHouse )

-- Function for changing the password of the house
addEvent( "setHousePassword", true )
function setHousePassword ( houseid, password )
	local theHouse = _G["house"..tostring(houseid)]
	setElementData( theHouse, "10", password )
	setElementData( theHouse, "11", 1 )
	setElementData( theHouse, "8", 1 )
	onUpdateHouseData ( houseid, "locked", 1, "11", 1, "password", password )
	onPlayerUpdateLabels ( source, houseid )
	outputChatBox("New house password is set to: "..password, source, 0, 225, 0)
end
addEventHandler( "setHousePassword", root, setHousePassword )

-- Function that removes the lock from a house
addEvent( "removeHousePassword", true )
function removeHousePassword ( houseid )
	local theHouse = _G["house"..tostring(houseid)]
	if ( getElementData( theHouse, "11" ) == 1 ) then
		local theHouse = _G["house"..tostring( houseid )]
		setElementData( theHouse, "11", 0 )
		onUpdateHouseData ( houseid, "11", 0 )
		onPlayerUpdateLabels ( source, houseid )
		outputChatBox("The password is removed from your house!", source, 0, 225, 0)
	else
		outputChatBox("Your house isn't password locked!", source, 225, 0, 0)
	end
end
addEventHandler( "removeHousePassword", root, removeHousePassword )

-- Function that sets the house closed
addEvent( "toggleClosed", true )
function toggleClosed (houseid, houseinglocked)
	local theHouse = _G["house"..tostring( houseid )]
	local houseLockStatus = getElementData( theHouse, "8" )
	if ( houseLockStatus == 1 ) then
		setElementData( theHouse,"8", 0 )
		onUpdateHouseData ( houseid, "locked", 0 )
		onPlayerUpdateLabels ( source, houseid )
	else
		setElementData( theHouse,"8", 1 )
		onUpdateHouseData ( houseid, "locked", 1 )
		onPlayerUpdateLabels ( source, houseid )
	end
end
addEventHandler( "toggleClosed", root, toggleClosed )

-- Function that toggle the house his sale status
addEvent( "toggleSale", true )
function toggleSale (houseid, houseinglocked)
	local theHouse = _G["house"..tostring( houseid )]
	local houseSaleStatus = getElementData( theHouse, "5" )
	if ( houseSaleStatus == 1 ) then
		setElementData( theHouse, "5", 0 )
		setPickupType( theHouse, 3, 1272, 0 )
		onUpdateHouseData ( houseid, "sale", 0 )
		onPlayerUpdateLabels ( source, houseid )
	else
		setElementData( theHouse, "5", 1 )
		setPickupType( theHouse, 3, 1273, 0 )
		onUpdateHouseData ( houseid, "sale", 1 )
		onPlayerUpdateLabels ( source, houseid )
	end
end
addEventHandler( "toggleSale", root, toggleSale )

-- Function that toggle the sale price of the house
addEvent( "toggleSalePrice", true )
function toggleSalePrice (houseid, thePrice)
	local theHouse = _G["house"..tostring( houseid )]
	setElementData( theHouse, "6", tonumber(thePrice))
	onUpdateHouseData ( houseid, "6", tonumber(thePrice) )
	onPlayerUpdateLabels ( source, houseid )
end
addEventHandler( "toggleSalePrice", root, toggleSalePrice )

-- Function for buying the house
addEvent( "buyHouse", true )
function buyHouse (houseid)
	local theHouse = _G["house"..tostring( houseid )]
	local theHousePrice = getElementData( theHouse, "6" )
	local theHouseOwnerID = getElementData( theHouse, "3" )
	local isHouseForSale = getElementData( theHouse, "5" )
	local playerMoney = getPlayerMoney( source ) 
	local playerID = exports.server:getPlayerAccountID( source )
	
	local maxHouses = getPlayerMaxHouses( source )
	
	local getPlayerHouses = exports.DENmysql:query( "SELECT * FROM housing WHERE ownerid = ?", playerID )
	if ( playerMoney < theHousePrice ) then
		exports.DENdxmsg:createNewDxMessage(source, "You dont have enough money for this house!", 200, 0, 0)
		triggerClientEvent ( source, "closeBuyWindow", source)
	elseif ( getPlayerHouses and #getPlayerHouses > maxHouses ) then
		exports.DENdxmsg:createNewDxMessage(source, "You can't have more then " .. maxHouses .. " houses!", 200, 0, 0)
		triggerClientEvent ( source, "closeBuyWindow", source)
	elseif ( isHouseForSale == 0 ) then
		exports.DENdxmsg:createNewDxMessage(source, "This house is already sold!", 200, 0, 0)
		triggerClientEvent ( source, "closeAllHousingWindows", source)
	else
		local theHouseOwnerBank = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", theHouseOwnerID )
		local theHouseOwnerBalance = theHouseOwnerBank.balance
		if ( theHouseOwnerBalance ) then
			local theOwnerNewBalance = ( theHouseOwnerBalance + theHousePrice )
			local theOwnerGiveMoney = exports.DENmysql:exec( "UPDATE banking SET balance=? WHERE userid=?", theOwnerNewBalance, theHouseOwnerID )
			if ( theOwnerGiveMoney ) then
				takePlayerMoney(source, theHousePrice)
				local playerAccountName = getElementData(source, "playerAccount")
				setElementData( theHouse, "2", playerAccountName)
				setElementData( theHouse, "3", playerID)
				setElementData( theHouse, "9", theHousePrice)
				onUpdateHouseData ( houseid, "3", playerID, "9", theHousePrice, "sale", 0 )
				setElementData( theHouse,"5", 0)
				setPickupType( theHouse, 3, 1272, 0)
				triggerClientEvent ( source, "closeBuyWindow", source)
				onPlayerUpdateLabelsOnBuy ( source, houseid )
				exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." bought a house for $" .. theHousePrice .. " (HOUSEID: " .. houseid .. ") (PREVIOUS OWNER: " .. theHouseOwnerID .. ")" )
				local transaction = exports.DENmysql:exec( "INSERT INTO banking_transactions SET userid=?, transaction=?"
                            ,tonumber(theHouseOwnerID)
                            ,"You're house was sold for $".. theHousePrice .."" .. " to ".. getPlayerName(source) ..""
                        )
			end
		end
	end	
end
addEventHandler( "buyHouse", root, buyHouse )

function getPlayerMaxHouses ( thePlayer )
	if ( getElementData(thePlayer, "isPlayerPremium") ) then
		return 10
	else
		return 7
	end
end

-- Create part for housing system
addEvent( "createTheNewHouse", true )
function createTheNewHouse (int, price, name)
	if ( int ) and ( price ) and ( name ) then
	local madeBy = getPlayerName(source)
	local x, y, z = getElementPosition (source)
	local makeHouse = exports.DENmysql:exec("INSERT INTO housing SET sale=?, locked=?, housename=?, x=?, y=?, z=?, interiorid=?, houseprice=?, createdBy=?"
			,1
			,1
			,name
			,x
			,y
			,z
			,int
			,price
			,madeBy
		)
		outputChatBox ("House created and putted into the database :)", source, 0, 225, 0)
		createPickup ( x, y, z, 3, 1277, 0)
	else
		outputChatBox ("Something is wrong, please check the fields!", source, 225, 225, 0)
	end
end
addEventHandler( "createTheNewHouse", root, createTheNewHouse )

--- Edit part for the housing system
function getTheHouseInfo ( houseid )
local houseinfo = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", houseid )
	if ( houseinfo ) then
		triggerClientEvent ( source, "updateEditGUI", source, houseinfo.interiorid, houseinfo.houseprice, houseinfo.housename )
	else
		outputChatBox("The ID of the house you enterd is wrong!", source, 225, 0, 0)
	end
end
addEvent( "getTheHouseInfo", true )
addEventHandler( "getTheHouseInfo", root, getTheHouseInfo )

addEvent( "doEditTheHouse", true )
function doEditTheHouse (int, price, street, houseID)
	local houseinfo = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", houseID )
	if ( houseinfo ) then
		local getHouse = _G["house"..tostring(houseID)]
		setElementData(getHouse,"4", int)
		setElementData(getHouse,"6", price)
		setElementData(getHouse,"7", street)
		local updatHouse = exports.DENmysql:exec("UPDATE housing SET houseprice=?, interiorid=?, housename=? WHERE id = ?", houseID
                ,tonumber(price)
                ,tonumber(int)
                ,street
            )
		triggerClientEvent ( source, "updateLabels", source, houseinfo.ownerid, int, houseinfo.sale, price, street, houseinfo.locked, houseinfo.boughtprice, houseinfo.boughtprice, houseinfo.passwordlocked )
		outputChatBox("Updating the house... Cleaning the house... Doing some laundry... DONE!", source, 0, 225, 0)
	else
		outputChatBox("The ID of the house you enterd is wrong!", source, 225, 0, 0)
	end
end
addEventHandler( "doEditTheHouse", root, doEditTheHouse )

-- Delete house part
function deleteHouse ( playerSource, command, houseid )
	if ( houseid ) then
		if getElementData(playerSource, "isPlayerStaff") == true then
		local checkHouse = exports.DENmysql:querySingle( "SELECT * FROM housing WHERE id = ?", houseid )
			if ( checkHouse ) then
				local deleteHouse = exports.DENmysql:exec( "DELETE FROM housing WHERE id = ?", houseid )
				local getTheHouse = _G["house"..tostring(houseid)]
				destroyElement( getTheHouse )
				outputChatBox("House Deleted!", playerSource, 0, 200, 0)
			else
				outputChatBox("The ID of the house you enterd is wrong!", playerSource, 225, 0, 0)
			end
		end
	end
end
addCommandHandler ( "deletehouse", deleteHouse )