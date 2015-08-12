------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  pp_s.lua (server-sdrugNamee)
--  Arms / Weapons Dealing
--  Priyen Patel
------------------------------------------------------------------------------------
--TODO:
-- add chance wanted level cops round, new gui  http://pastebin.com/RWdx6Shn
local prices = {}
local drugs = {}
local viewing = {}
local markers = {}
local vending = {}

function setDefaults(pp)
	local p = source
	if (pp) then if isElement(pp) then p = pp end end
	local t = {}
	t["Ritalin"] = 500
	t["Weed"] = 500
	t["LSD"] = 500
	t["Cocaine"] = 500
	t["Ecstasy"] = 500
	t["Heroine"] = 500

	prices[p] = t
	t=nil
	t={}
	drugs[p] = t
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

function toggle(amm,mypric)
	if vending[source] == nil then setDefaults(source) vending[source] = false end
	if vending[source] == false then 
		if isPedOnGround(source) then
			vend(amm,source)
			exports.DENdxmsg:createNewDxMessage(source,"Drugs Shop: Now Vending", 0,255,0)
		else
			exports.DENdxmsg:createNewDxMessage(source,"Drugs Shop: You must be on the ground to start vending!", 255,0,0)
		end
	else	
		unvend(source)
		exports.DENdxmsg:createNewDxMessage(source,"Drugs Shop: No Longer Vending", 255,0,0)
	end
	prices[source]=mypric
end
addEvent("DrugsDealingToggleVending",true)
addEventHandler("DrugsDealingToggleVending",root,toggle)

function vend(amm,p)
	drugs[p] = amm
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
			triggerClientEvent(k,"DrugsDealingSellerQuit",k,getPlayerName(p))
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

function setPrice(drugName,p,price,drugs)
	if prices[source][drugName] == nil then setDefaults(source) end
	prices[source][drugName] = p
	prices[source]=price
	drugs[source]=drugs
	sendData(source,source,false)
	updateViewersForP(source)
end
addEvent("DrugsDealingSetPrice",true)
addEventHandler("DrugsDealingSetPrice",root,setPrice)

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
	triggerClientEvent(to,"DrugsDealingRecData",to,prices[seller],drugs[seller],consumer,seller,justHit)
end

-- bug abuse logging
local bugAbuseLog
function openBugLogFile()
	if fileExists('log.xml') then
		bugAbuseLog = xmlLoadFile('log.xml')
	else
		bugAbuseLog = xmlCreateFile('log.xml','abusers')
	end
end
--
function DrugsDealingBuyingAmmo(drugName,am,seller)
	if isElement(seller) == false then
		 exports.DENdxmsg:createNewDxMessage(source, "It appears the Seller has disconnected and / or left",255,0,0)
		return
	end
	if am <= 0 then
		if am ~= 0 then
			openBugLogFile()
			local node = xmlCreateChild(bugAbuseLog,'abuse')
			xmlNodeSetAttribute(node,'abuserAccount',exports.server:getPlayerAccountName(source))
			xmlNodeSetAttribute(node,'abuserAccountSeller',exports.server:getPlayerAccountName(seller))
			xmlNodeSetAttribute(node,'drugsamount',am)
			xmlNodeSetAttribute(node,'cost',prices[seller][drugName] * am)
			local theTime = getRealTime()
			xmlNodeSetAttribute(node,'date',theTime.monthday .. '-'..(theTime.month+1)..'-'..(theTime.years+1900))
			xmlNodeSetAttribute(node,'time',theTime.hour+1 .. '-'..(theTime.minute)..'-'..(theTime.second))
			xmlSaveFile(bugAbuseLog)
			xmlUnloadFile(bugAbuseLog)
			bugAbuseLog = nil
			return
		end
	end
	local sname = getPlayerName(seller)
	local bname = getPlayerName(source)
	if drugs[seller][drugName] >= am then
		local cost = prices[seller][drugName] * am
		if getPlayerMoney(source) >= cost then
			takePlayerMoney(source,cost)
			givePlayerMoney(seller,cost)
			exports.CSGdrugs:giveDrug(source,drugName,am)
			exports.CSGdrugs:takeDrug(seller,drugName,am)
			drugs[seller][drugName] = drugs[seller][drugName] - am
			exports.DENdxmsg:createNewDxMessage(seller,"Sold "..am.." hits of "..drugName..", total: $"..cost.." to "..bname.."",0,255,0)
			exports.DENdxmsg:createNewDxMessage(source,"Bought "..am.." hits of "..drugName.." for $"..cost.."",0,255,0)
			updateViewersForP(seller)
			triggerClientEvent(seller,"CSGdrugsSelling.updateSeller",seller)
			if isLawNearby(source) == true then
				exports.CSGwanted:addWanted(seller,34,source)
				exports.CSGwanted:addWanted(source,35,seller)
			end
		else
			 exports.DENdxmsg:createNewDxMessage(source, "You can't afford this much drugs. You need $"..cost.."",255,0,0)
		end
	else
		 exports.DENdxmsg:createNewDxMessage(seller,""..bname.." tried to buy "..am.." hits of "..drugName.." but you don't have enough",255,255,0)
		 exports.DENdxmsg:createNewDxMessage(source, ""..sname.." doesn't have enough drugs",255,0,0)
		return
	end
end
addEvent("DrugsDealingBuyingAmmo",true)
addEventHandler("DrugsDealingBuyingAmmo",root,DrugsDealingBuyingAmmo)

function DrugsDealingClosedShop()
	viewing[source] = ""
end
addEvent("DrugsDealingClosedShop",true)
addEventHandler("DrugsDealingClosedShop",root,DrugsDealingClosedShop)

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
addEvent("DrugsDealingClientLoaded",true)
addEventHandler("DrugsDealingClientLoaded",root,clientLoaded)

function isLaw(p)
	local t = getPlayerTeam(p)
	if t==false then return false end
	local name=getTeamName(t)
	if name == "Police" or name == "Government Agency" or name == "Military Forces" or name == "SWAT" then
		return true
	end
	return false
end

function isLawNearby(p)
	local x,y,z = getElementPosition(p)
	for k,v in pairs(getElementsByType("player")) do
		if isLaw(v) then
			local x2,y2,z2 = getElementPosition(v)
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 60 then
				return true
			end
		end
	end
	return false
end
