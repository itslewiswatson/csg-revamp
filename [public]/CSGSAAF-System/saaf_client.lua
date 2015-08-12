local weaponGUI = {}
weaponGUI["window"] = {}
weaponGUI["grid"] = {}
weaponGUI["button"] = {}
weaponGUI["label"] = {}
weaponGUI["tabPanel"] = {}
weaponGUI["tab"] = {}
local sx, sy = guiGetScreenSize()

addEventHandler("onClientRender",getRootElement(),
function ()
	for i,v in ipairs(getElementsByType("marker")) do
		if getElementData(v,"markerName") then
			if getElementDimension(v) == getElementDimension(localPlayer) then
			local name = getElementData(v,"markerName")
				local x,y,z = getElementPosition(v)
				local cx,cy,cz = getCameraMatrix()
				if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 15 then
					local px,py = getScreenFromWorldPosition(x,y,z+1.3,0.06)
					if px then
						local width = dxGetTextWidth(name,1,"sans")
						dxDrawBorderedText(name, px, py, px, py, tocolor(0, 255, 0, 255), 2, "sans", "center", "center", false, false)
					end
				end
			end
		end
	end
end)

weaponGUI["window"]["scores"] = guiCreateWindow(0.3232,0.2227,0.374,0.4271,"",true)
guiWindowSetSizable(weaponGUI["window"]["scores"],false)
guiSetVisible(weaponGUI["window"]["scores"],false)
weaponGUI["tabPanel"]["scores"] = guiCreateTabPanel(0.0235,0.0793,0.953,0.8933,true,weaponGUI["window"]["scores"])
weaponGUI["tab"]["stats"] = guiCreateTab("My stats",weaponGUI["tabPanel"]["scores"])
weaponGUI["label"]["stats_rank"] = guiCreateLabel(0.0329,0.0297,0.6904,0.0818,"My current rank is:",true,weaponGUI["tab"]["stats"])
weaponGUI["label"]["stats_points"] = guiCreateLabel(0.0329,0.119,0.6904,0.0818,"My current points are:",true,weaponGUI["tab"]["stats"])
weaponGUI["label"]["stats_kills"] = guiCreateLabel(0.0329,0.2156,0.6904,0.0818,"My current kills are:",true,weaponGUI["tab"]["stats"])
weaponGUI["label"]["stats_promotion"] = guiCreateLabel(0.0329,0.3123,0.6904,0.0818,"Kills required for promotion:",true,weaponGUI["tab"]["stats"])
weaponGUI["tab"]["scores"] = guiCreateTab("Global scores",weaponGUI["tabPanel"]["scores"])
weaponGUI["grid"]["global_stats"] = guiCreateGridList(0.0274,0.0223,0.9479,0.9517,true,weaponGUI["tab"]["scores"])
guiGridListSetSortingEnabled(weaponGUI["grid"]["global_stats"], false)
guiGridListAddColumn(weaponGUI["grid"]["global_stats"],"#:",0.2)
guiGridListAddColumn(weaponGUI["grid"]["global_stats"],"Account name:",0.2)
guiGridListAddColumn(weaponGUI["grid"]["global_stats"],"Kills:",0.2)
guiGridListAddColumn(weaponGUI["grid"]["global_stats"],"Points:",0.2)
guiGridListAddColumn(weaponGUI["grid"]["global_stats"],"Rank:",0.2)

weaponGUI["window"]["main"] = guiCreateWindow(0.3662,0.2552,0.335,0.4193,"Weapons Shop",true)
guiWindowSetSizable(weaponGUI["window"]["main"],false)
guiSetVisible(weaponGUI["window"]["main"],false)
weaponGUI["grid"]["list"] = guiCreateGridList(0.0292,0.0776,0.9446,0.677,true,weaponGUI["window"]["main"])
guiGridListSetSelectionMode(weaponGUI["grid"]["list"],2)
guiGridListAddColumn(weaponGUI["grid"]["list"],"Weapon name:",0.40)
guiGridListAddColumn(weaponGUI["grid"]["list"],"Points cost:",0.40)
weaponGUI["button"]["buy"] = guiCreateButton(0.2099,0.8696,0.2799,0.0839,"Buy",true,weaponGUI["window"]["main"])
weaponGUI["button"]["close"] = guiCreateButton(0.5569,0.8696,0.2799,0.0839,"Close",true,weaponGUI["window"]["main"])
weaponGUI["label"]["points"] = guiCreateLabel(0.035,0.764,0.5452,0.0652,"My points:",true,weaponGUI["window"]["main"])

addEvent("weaponShop:show",true)
addEventHandler("weaponShop:show",root,
function (weapons, points)
guiSetVisible(weaponGUI["window"]["main"],true)
showCursor(true)
guiGridListClear(weaponGUI["grid"]["list"])
guiSetText(weaponGUI["label"]["points"], "My points: ".. tostring(points))
	for weapon, price in pairs(weapons) do
		local row = guiGridListAddRow(weaponGUI["grid"]["list"])
		guiGridListSetItemText(weaponGUI["grid"]["list"],row,1,tostring(getWeaponNameFromID(weapon)),false,false)
		guiGridListSetItemText(weaponGUI["grid"]["list"],row,2,tostring(price),false,false)
	end
end)

addEventHandler("onClientGUIClick",weaponGUI["button"]["close"],
function ()
	guiSetVisible(weaponGUI["window"]["main"],false)
	showCursor(false)
end, false)


addEventHandler("onClientGUIClick",weaponGUI["button"]["buy"],
function ()
	local row,col = guiGridListGetSelectedItem(weaponGUI["grid"]["list"])
	if row and col and row ~= -1 and col ~= -1 then
		local weaponName = tostring(guiGridListGetItemText(weaponGUI["grid"]["list"], row, 1))
		triggerServerEvent("weaponShop:buy",localPlayer,weaponName)
	end
end, false)

addEventHandler ( "onClientPlayerWeaponSwitch", root,
function ( prevSlot, newSlot )
	if getPlayerTeam(localPlayer) then
		local teamName = getTeamName(getPlayerTeam(localPlayer))
		if (teamName == "SAAF" or teamName == "Insurgents") then
			if (getPedWeapon(localPlayer,newSlot) == 16 or getPedWeapon(localPlayer,newSlot) == 39) then
				if getElementDimension(localPlayer) ~= 2 then return end
				toggleControl ( "fire", false )
				exports["Info"]:sendClientMessage("This weapon is not allowed.",255,0,0)
			else
				toggleControl ( "fire", true )
			end
		end
	end
end)

addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(),
function (weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	if getPlayerTeam(localPlayer) then
		local teamName = getTeamName(getPlayerTeam(localPlayer))
		if (teamName == "SAAF" or teamName == "Insurgents") then
			if (weapon == 16 or weapon == 49) then
				if getElementDimension(localPlayer) ~= 2 then return end
				setPedWeaponSlot(localPlayer, 0)
				exports["(CSG)Info"]:sendClientMessage("This weapon is not allowed.",255,0,0)
			end
		end
    end
end)

function checkZPosition()
	if getPlayerTeam(localPlayer) then
		local teamName = getTeamName(getPlayerTeam(localPlayer))
		if (teamName == "SAAF" or teamName == "Insurgents") then
			if getElementDimension(localPlayer) ~= 2 then return end
			if getElementData(localPlayer,"respawning") then return end
			local x, y, z = getElementPosition(localPlayer)
			if (tonumber(z) <= 45) then
				setElementFrozen(localPlayer, true)
				setElementData(localPlayer,"respawning",true)
				triggerServerEvent("respawnPlayer",localPlayer)
			end
		end
	end
end
addEventHandler("onClientPreRender",root,checkZPosition)

function resetStatsLabel()
	guiSetText(weaponGUI["label"]["stats_rank"], "My current rank is:")
	guiSetText(weaponGUI["label"]["stats_points"], "My current points are:")
	guiSetText(weaponGUI["label"]["stats_kills"], "My current kills are:")
	guiSetText(weaponGUI["label"]["stats_promotion"], "Kills required for promotion:")	
end

addEvent("scores:showPanel",true)
addEventHandler("scores:showPanel",root,
function (stats, global)
guiSetVisible(weaponGUI["window"]["scores"], not guiGetVisible(weaponGUI["window"]["scores"]))
showCursor(guiGetVisible(weaponGUI["window"]["scores"]))
guiGridListClear(weaponGUI["grid"]["global_stats"])
if guiGetVisible(weaponGUI["window"]["scores"]) then
resetStatsLabel()
for dataName, dataValue in pairs(stats) do
	guiSetText(weaponGUI["label"][dataName], guiGetText(weaponGUI["label"][dataName]) .." ".. tostring(dataValue))
end
for index, data in pairs(sortTable(global)) do
	local row = guiGridListAddRow(weaponGUI["grid"]["global_stats"])
	guiGridListSetItemText(weaponGUI["grid"]["global_stats"], row, 1, tostring(index), false, false)
	guiGridListSetItemText(weaponGUI["grid"]["global_stats"], row, 2, tostring(data.account), false, false)
	guiGridListSetItemText(weaponGUI["grid"]["global_stats"], row, 3, tostring(data.kills), false, false)
	guiGridListSetItemText(weaponGUI["grid"]["global_stats"], row, 4, tostring(data.points), false, false)
	guiGridListSetItemText(weaponGUI["grid"]["global_stats"], row, 5, tostring(data.rank), false, false)
	if (index >= 50) then
		guiGridListRemoveRow (weaponGUI["grid"]["global_stats"], index)
		break
	end
end	
	end
end)

function sortTable(theTable)
	local rowdata = {}
	for index, account in pairs(theTable) do
		rowdata[index] = {
			account = account.accountName,
			kills = account.accountKills,
			points = account.accountPoints,
			rank = account.accountRank,
		}
	end
 	local comparator = function (a, b) 
		return (tonumber(a.kills) or 0) > (tonumber(b.kills) or 0) 
	end
 	table.sort(rowdata, comparator)
	return rowdata
end

local SAAF = {["SAAF"] = true, ["Insurgents"] = true}

addEventHandler ( "onClientPlayerDamage", root,
function ( attacker, weapon, bodypart )
	if ( attacker and getElementType(attacker) == "player" ) then
	local attackerTeam = getPlayerTeam(attacker)
	local sourceTeam = getPlayerTeam(source)
		if (attackerTeam and sourceTeam) then
			local attackerTeam = getTeamName(attackerTeam)
			local sourceTeam = getTeamName(sourceTeam)
			if (SAAF[attackerTeam] and SAAF[sourceTeam]) then
				if (attackerTeam == sourceTeam) then
					if (getElementDimension(attacker) == 2 and getElementDimension(source) == 2) then
						cancelEvent()
					end
				end
			end
		end
	end
end)

addEventHandler("onClientRender",root,
    function()
		if getPlayerTeam(localPlayer) then
			local teamName = getTeamName(getPlayerTeam(localPlayer))
			if (teamName == "SAAF" or teamName == "Insurgents") then
				if getElementDimension(localPlayer) ~= 2 then return end
				if getElementByID("saafTime") and getElementData(getElementByID("saafTime"),"timeLeft") then
					local minutes, seconds = convertTime(getElementData(getElementByID("saafTime"), "timeLeft") or 0)
					dxDrawBorderedText("The round will end in ".. minutes .." minutes ".. seconds .." seconds.",(384/1024)*sx,(692/768)*sy,(673/1024)*sx,(629/768)*sy,tocolor(255,255,255,255),0.5,"bankgothic","left","top",false,false,true)
					dxDrawRectangle((370/1024)*sx,(680/768)*sy,(395/1024)*sx,(43/768)*sy,tocolor(0,0,0,155),false)
				end
			end
		end
    end
)

function convertTime(ms)
    local min = math.floor ( ms/60000 )
    local sec = math.floor( (ms/1000)%60 )
    return min, sec
end

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end