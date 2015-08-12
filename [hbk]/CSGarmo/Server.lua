whoHasIt = false

mark = {
	{1532.1966552734,749,11},
	{1771,2108.2109375,11},
	{2389.5483105469,2310,11},
	{1098,1602,11},
	{2378.9074707031,1040,11},
	{2323,1283.4815673828,97},
	{1989.2025146484,1068,11},
	}

armor = {

	{2281,1125,11},
	{2460,1566,11},
	{1960,2752,11},
	{1434,2616,11},
	{1386,1025,11},
	{1612,1353,11},
	{1600,1945,11},
}


function createarmor()
	local mt = math.random(#armor)
	ob = createObject(1242,armor[mt][1],armor[mt][2],armor[mt][3])
	setElementCollisionsEnabled(ob,false)

	mar = createMarker(armor[mt][1],armor[mt][2],armor[mt][3],"checkpoint",0.2,0,255,0,40)
	bl = createBlipAttachedTo(mar,19)
	setElementData(mar,"num",mt)
	exports.dendxmsg:createNewDxMessage(root,"An Armor has been placed on map as an Object, find it and deliver it! Red flag blip",0,255,0)
	whoHasIt=false
end

setTimer(createarmor,600000,1)


addEventHandler("onMarkerHit",root,
	function (player)
		if ( source == mar ) then
			if getElementType(player) == "player" then
				local x,y,z = getElementPosition(player)
				local data = getElementData(mar,"num")
				--local data = tonumber(data)
				local data = math.random(data)
				destroyElement(mar)
				destroyElement(ob)
				destroyElement(bl)
				setElementData(player,"armor",true)
				atarmor = createObject(1242,x,y,z)
				setElementData(atarmor,"num",data)
				exports.bone_attach:attachElementToBone(atarmor,player,12,0,0.05,0.27,0,480,0)
				bli = createBlipAttachedTo(player,19)
				whoHasIt=player
				exports.DENdxmsg:createNewDxMessage(player,"Deliever This Armor to Red flag blip",255,255,0,true)
				marker = createMarker(mark[data][1],mark[data][2],mark[data][3],"checkpoint",1.5,255,255,0,255,player)
				marBli = createBlipAttachedTo(marker,19,2,255,0,0,255,0,99999.0,player)
				 local arpedid = math.random( 28, 29 )
				armped = createPed( arpedid, mark[data][1],mark[data][2],mark[data][3] )
				CheckVehicleTimer = setTimer(checkForVehicle,1000, 0)
			end
		end
	end
)

function dropArmor()
	local data = getElementData(atarmor,"num")
	local data = tonumber(data)
	local x,y,z = getElementPosition(whoHasIt)
	--setElementData(player,"armor",false)
	destroyElement(atarmor)
	whoHasIt=false
	destroyElement(marker)
	destroyElement(bli)
	destroyElement(marBli)
	destroyElement(armped)
	ob = createObject(1242,x,y,z)
	setElementCollisionsEnabled(ob,false)
	mar = createMarker(x,y,z,"corona",0.5,0,255,0,120)
	setElementData(mar,"num",data)
	bl = createBlipAttachedTo(mar,19)
	if isTimer(CheckVehicleTimer) then killTimer(CheckVehicleTimer) end
end

addEventHandler("onPlayerWasted",root,
	function ()
		if whoHasIt==source then
			dropArmor()
		end
	end
)

addEventHandler("onPlayerQuit",root,
	function ()
		if whoHasIt==source then
			dropArmor()
		end
	end
)

local weps = {
	27,26,30,31

}

addEventHandler("onMarkerHit",root,
	function (player)
		if ( source == marker ) then
			if getElementType(player) == "player" then
				if player~=whoHasIt then return end
				whoHasIt=false
				--setElementData(player,"armor",false)
				destroyElement(marker)
				destroyElement(marBli)
				destroyElement(bli)
				destroyElement(atarmor)
				destroyElement(armped)
				local name = getPlayerName(player)
				exports.DENdxmsg:createNewDxMessage("You got rewarded a weapon and $6000 (+5 Score)",player,255,100,0,true)
				for k,v in pairs(getElementsByType("player")) do
					exports.DENdxmsg:createNewDxMessage(v,name.." has delievered the armor successfully!",0,255,0)
				end
				triggerClientEvent(player,"onShowMoney",player)
				exports.CSGscore:givePlayerScore(player,5)
				setTimer(createarmor,600000,1)
				ID = math.random(1,#weps)
				wepID=weps[ID]
				wepAmoo = math.random (100,200)
				giveWeapon(player,wepID,wepAmoo)
				givePlayerMoney(player,6000)
		        setPedArmor(player, 50)
				if isTimer(CheckVehicleTimer) then killTimer(CheckVehicleTimer) end
			end
		end
	end
)

function checkForVehicle()
	if isElement(whoHasIt) then
		if isPedInVehicle(whoHasIt) or isElementAttached(whoHasIt) then
			dropArmor()
			exports.DENdxmsg:createNewDxMessage(player,"You can't enter or /glue to a vehicle while holding the armor!",255,0,0,true)
		end
	end
end

addEventHandler("onVehicleStartEnter",root,
	function (player)
		if whoHasIt == player then
			cancelEvent()
			exports.DENdxmsg:createNewDxMessage(player,"You can't enter a vehicle while holding the armor!",255,0,0,true)
		end
	end
)

addEventHandler("onPlayerContact",root,
	function (old,new)
		if whoHasIt == source and isElement(new) then
			dropArmor()
			exports.DENdxmsg:createNewDxMessage(source,"You're not allowed to stand on vehicles while holding the flag!",255,0,0,true)
		end
	end
)

