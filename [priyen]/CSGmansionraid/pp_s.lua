------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  pp_s.lua (server-side)
--  Arms / Weapons Dealing
--  Priyen Patel
------------------------------------------------------------------------------------
--TODO:
-- add chance wanted level cops round, new gui  http://pastebin.com/RWdx6Shn
local prices = {}
local ammo = {}
local viewing = {}
local markers = {}
local vending = {}
local clips = {
	[22]=17,
	[23]=17,
	[24]=7,
	[25]=1,
	[26]=2,
	[27]=7,
	[28]=50,
	[29]=30,
	[32]=50,
	[30]=30,
	[31]=50,
	[33]=1,
	[34]=1
}

function setDefaults(pp)
	local p = source
	if (pp) then if isElement(pp) then p = pp end end
	local t = {}
	t[22] = 65
	t[23] = 65
	t[24] = 95
	t[25] = 200
	t[26] = 210
	t[27] = 250
	t[30] = 450
	t[31] = 500
	t[28] = 350
	t[29] = 400
	t[32] = 350
	t[33] = 350
	t[34] = 500

	prices[p] = t
	t=nil
	t={}
	for i=22,34,1 do
		t[i] = -1
	end
	ammo[p] = t
	viewing[p] = ""
	vending[p] = false
	sendData(p,p,false,false)
end
addEvent( "onClientPlayerLogin" )
addEventHandler( "onClientPlayerLogin", root,
	function ( userID, username )
		setDefaults(source)
	end
)

function toggle(amm)
	if vending[source] == nil then setDefaults(source) vending[source] = false end
	if vending[source] == false then vend(amm,source)
		 exports.DENdxmsg:createNewDxMessage(source,"Weapons Shop: Now Vending", 0,255,0)
	else
		unvend(source)
		 exports.DENdxmsg:createNewDxMessage(source,"Weapons Shop: No Longer Vending", 255,0,0)
	end
end
addEvent("ArmsDealingToggleVending",true)
addEventHandler("ArmsDealingToggleVending",root,toggle)

function vend(amm,p)

	ammo[p] = amm
	vending[p] = true
	local x,y,z = getElementPosition(p)
	local m = createMarker(x,y,z-1,"cylinder",2,math.random(1,255),math.random(1,255),math.random(1,255))
	addEventHandler("onMarkerHit",m,hitMarker)
	local dim = getElementDimension(p)
	local int = getElementInterior(p)
	setElementDimension(m,dim)
	setElementInterior(m,int)
	markers[p] = m
	markers[m] = p
	setElementFrozen(p,true)
	sendData(p,p,false)
end


function unvend(p)
	if (p) then
		if isElement(p) == false then
			if (source) then
				if isElement(source) == true then
					p = source
				end
			end
		end
	else
		if isElement(source) == true then
			p = source
		end
	end
	if vending[p] == false then return end
	vending[p] = false
	local m = markers[p]
	if isElement(m) == true then
		removeEventHandler("onMarkerHit",m,hitMarker)
		if markers[m] ~= nil then
			markers[m] = nil
		end
		destroyElement(m)
		markers[p] = nil
	end

	if isElement(p) then setElementFrozen(p,false) end
	for k,v in pairs(viewing) do
		if v == p then
			triggerClientEvent(k,"ArmsDealingSellerQuit",k)
		end
	end
end

function quit()
	unvend(source)
	viewing[source] = ""
end
addEventHandler("onPlayerQuit",root,quit)

function wasted()
	viewing[source] = ""
end
addEventHandler("onPlayerWasted",root,wasted)

function setPrice(id,p)
	if (prices[source][id] < 1) then outputChatBox("Price must be over $1!",source,255,0,0) return end
	if prices[source][id] == nil then setDefaults(source) end
	prices[source][id] = p
	sendData(source,source,false)
	updateViewersForP(source)
end
addEvent("ArmsDealingSetPrice",true)
addEventHandler("ArmsDealingSetPrice",root,setPrice)

function updateViewersForP(seller)
	for k,v in pairs(viewing) do
		if v == seller then
		sendData(k,seller,true)
		end
	end
	sendData(seller,seller,false)
end

function hitMarker(e)
	if getElementType(e) ~= "player" then return end
	if isPedInVehicle(e) ~= false then return end
	if viewing[e] == nil then setDefaults(e) end
	local seller = markers[source]
	if seller == e then return end
	local consumer = true
	local justHit = true
	viewing[e] = seller
	sendData(e,seller,consumer,justHit)
end

function sendData(to,seller,consumer,justHit)
	triggerClientEvent(to,"ArmsDealingRecData",to,prices[seller],ammo[seller],consumer,seller,justHit)
end

function ArmsDealingBuyingAmmo(id,am,seller)
	local wname = getWeaponNameFromID(id)
	local bname = getPlayerName(source)
	if isElement(seller) == false then
		 exports.DENdxmsg:createNewDxMessage(source, "It appears the Seller has disconnected and / or left",255,0,0)
	return
	end
	local sname = getPlayerName(seller)
	--if exports.server:getPlayerWeaponTable(source)[id] == 0 then
	--	 exports.DENdxmsg:createNewDxMessage(source, "You cant buy ammo for "..wname..", you don't own the weapon!",255,0,0)
	--return
	--end
	if ammo[seller][id] >= am then
		local cost = prices[seller][id] * am
			--convert clips to ammo:
			am = clips[id]*am
		if getPlayerMoney(source) >= cost then
			takePlayerMoney(source,cost)
			givePlayerMoney(seller,cost)
			giveWeapon(source,id,am)
			takeWeapon(seller,id,am)
			ammo[seller][id] = ammo[seller][id] - am
			 exports.DENdxmsg:createNewDxMessage(seller,"Sold "..am.." ammo "..wname..", total: $"..cost.." to "..bname.."",0,255,0)
			 exports.DENdxmsg:createNewDxMessage(source,"Bought "..am.." ammo for "..wname.." for $"..cost.."",0,255,0)
			updateViewersForP(seller)
		else
			 exports.DENdxmsg:createNewDxMessage(source, "You can't afford this much ammo. You need $"..cost.."",255,0,0)
		end
	else
		 exports.DENdxmsg:createNewDxMessage(seller,""..bname.." tried to buy "..am.." "..wname.." ammo but you don't have enough",255,255,0)
		 exports.DENdxmsg:createNewDxMessage(source, ""..sname.." doesn't have enough ammo",255,0,0)
		return
	end
end
addEvent("ArmsDealingBuyingAmmo",true)
addEventHandler("ArmsDealingBuyingAmmo",root,ArmsDealingBuyingAmmo)

function ArmsDealingClosedShop()
	viewing[source] = ""
end
addEvent("ArmsDealingClosedShop",true)
addEventHandler("ArmsDealingClosedShop",root,ArmsDealingClosedShop)

addEvent( "onServerPlayerArrested" )
addEventHandler( "onServerPlayerArrested", root,
	function ( theCop )
		unvend(source)
	end
)
--[[
function start()
	for k,v in pairs(getElementsByType("player")) do
		setDefaults(v)
	end
end
setTimer(start,5000,1)
--]]
function clientLoaded()
	setDefaults(source)
end
addEvent("armsDealingClientLoaded",true)
addEventHandler("armsDealingClientLoaded",root,clientLoaded)


