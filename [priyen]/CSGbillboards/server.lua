local data = {
["fish"] = {5,4,1,0},
				-- best cop   arrests   worst crim --jailed times
["lspd"] = {370,38144,19592,0,"RCT-CJ[MF]",18,"[CSG]STTROPEZ|TSF",8},
["lvcomealot1"] = {"N/A",0,"N/A",0},
["lvcomealot2"] = {"N/A",0,"N/A",0},
}
topGroups = {{"N/A",0},{"N/A",0},{"N/A",0},{"N/A",0},{"N/A",0}}
worstGroups = {{"N/A",0},{"N/A",0},{"N/A",0},{"N/A",0},{"N/A",0}}


local textureData = {
	["fish2"] = "",
	["lspd1"] = "",
	["lspd2"] = "",
	["lspd3"] = "",
	["lvcomealot1a"] = "",
	["lvcomealot2a"] = "",
	["lvcomealot1b"] = "",
	["lvcomealot2b"] = "",
	["lvcomealot1c"] = "",
	["lvcomealot2c"] = ""
}

local oldData = {
["fish"] = {1,4,1,0},
["lspd"] = {0,0,0,0,"bob",-1,"bob",-1},
["lvcomealot1"] = {"test","test"},
["lvcomealot2"] = {"test","test"}
}

local colPlaces = {
	["fish2"] = {989.4,-2101},
	["lspd1"] = {1537.72, -1608.08},
	["lspd2"] = {1537.72, -1608.08},
	["lspd3"] = {1537.72, -1608.08},
	["lvcomealot1a"] = {2102.86, 1718.87},
	["lvcomealot2a"] = {2102.86, 1718.87},
	["lvcomealot1b"] = {2102.86, 1718.87},
	["lvcomealot2b"] = {2102.86, 1718.87},
	["lvcomealot1c"] = {2102.86, 1718.87},
	["lvcomealot2c"] = {2102.86, 1718.87},

}
local hasLatest = {}
local cols = {}

function monitor()
	local h = getTime()
	if h == 23 then
		data["lspd"][5] = "N/A"
		data["lspd"][6] = 0
		data["lspd"][7] = "N/A"
		data["lspd"][8] = 0
	end
end
setTimer(monitor,60000,0)

function startImageDownload(arg1,name)
	callRemote("http://s1works.com/admin/Priyen/csgPriyenMTAmodify.php",startImageDownload2,arg1,name)
end

function startImageDownload2(arg1,name )
	if arg1 == nil then return end
    fetchRemote ( arg1, myCallback, "", false,name )
end

function link(ps,cmdname,arg1,arg2)
	startImageDownload("http://imagegenerator.net/clippy/image.php?question="..arg1.."%3F&amp;option1=Annoy+me+till+my+eyes+bleed&amp;option2=Go+away+please&amp;option3=&amp;option4=%22",arg2)
end
addCommandHandler("dwnlink",link)
function callBackMeme(responseData,name)
	--setHasLatestForAll(name,false)
	startImageDownload(responseData,name)
	--outputConsole(responseData)
end

function myCallback( responseData, errno,name )
    if errno == 0 then
		--triggerClientEvent( root, "onClientGotImage",root,responseData,name )
		textureData[name] = responseData
		setHasLatestForAll(name,false)
		sendToAllInCol(name)
	end
end

function sendToAllInCol(name)
	local col = cols[name]
	local t = getElementsWithinColShape(col,"player")
	local img = textureData[name]
	if t == false then return end
	for k,v in pairs(t) do
		hasLatest[v][name] = true
		triggerClientEvent( v, "onClientGotImage",root,img,name )
	end
end

function monitorCols()
	for k,v in pairs(cols) do
		if isElement(v) == true then
			col=v
			local t = getElementsWithinColShape(col,"player")
			local name = cols[col]
			local img = textureData[name]
			for k2,v2 in pairs(t) do
				if hasLatest[v2] == nil then hasLatest[v2] = {} end
				if hasLatest[v2][name] == nil then hasLatest[v2][name] = false end
				if hasLatest[v2][name] == false then
					triggerClientEvent( v2,"onClientGotImage",root,img,name)
					hasLatest[v2][name] = true
				end
			end
		end
	end
end
setTimer(function() setTimer(monitorCols,5000,0)end,10000,1)

function sendToPlayer(p,name)
	if getElementType(p) ~= "player" then return end
	if hasLatest[p] == nil then hasLatest[p] = {} end
	if hasLatest[p][name] == nil then hasLatest[p][name] = false end
	if hasLatest[p][name] == false then
		hasLatest[p][name] = true
		triggerClientEvent(p,"onClientGotImage",root,textureData[name],name)
	end
end

function setBillboardData(key,value)
	data[key]=value
end

function doUpdates()
	for k,v in pairs(data) do
		local check = true
		if oldData[k] == nil then check=false oldData[k]=v end
		if k == "fish" then
			if check==false or v[1] > oldData[k][1] then
				oldData[k][1] = v[1]
				--setHasLatestForAll("fish2",false)
				startImageDownload2("chart.googleapis.com/chart?chxl=0:|Total+Fish|||Common+|||Rare|||Very+Rare&chxr=0,5,100|1,-5,100&chxt=x,y&chbh=a&chs=300x150&cht=bvs&chd=t:"..(v[1]+2)..",0,0,"..(v[2]+2)..",0,0,"..(v[3]+2)..",0,0,"..(v[4]+2).."&chg=25,50&chtt=CSG+Fish+...+Something+Fishy+About+This","fish2")
			end
		elseif k == "lspd" then
			if (check==false) or (data[k][1] > oldData[k][1]) then
				local pnam = v[5]
				--setHasLatestForAll("lspd1",false)
				--setHasLatestForAll("lspd3",false)
				startImageDownload("http://www.hetemeel.com/einsteinshow.php?text=+E%3Dmc%5E2.+a2%2Bcsgmta%3Dstatistics%0D%0A%0D%0A++++++"..data[k][3].."+Wanted+Points+Earned%0D%0A%0D%0A+++++++++++++++++++++++++"..data[k][2].."+Seconds%0D%0A+++++++++++++++++++++++++++Jail+Time+Served+%0D%0A++++++++++++++++++++++++++%0D%0A+++++++++++++++++++++++"..data[k][1].."+Criminals+Jailed%0D%0A+++++++++++++++++++CSG+%3ASince+Oct+29%2C+2012","lspd3")
				--startImageDownload("chart.googleapis.com/chart?chxl=0:|Total+Arrests|||Total+Jailed|||Jail+Time|||Wanted+Points&chxr=0,5,100|1,-5,100&chxt=x,y&chbh=a&chs=300x150&cht=bvs&chd=t:"..v[1]..",0,0,"..v[2]..",0,0,"..v[3]..",0,0,"..v[4].."&chg=25,50&chtt=CSG+Law+Statistics","lspd3")
				callRemote("http://s1works.com/admin/Priyen/csgPriyenMTAmeme.php",callBackMeme,""..pnam.." makes sure criminals get shutdown","Law Officer of the day with a total of "..v[6].." arrests","American Pride Eagle","lspd1")
				--if v[7] ~= oldData[k][7] then
					--setHasLatestForAll("lspd2",false)
					callRemote("http://s1works.com/admin/Priyen/csgPriyenMTAmeme.php",callBackMeme,"One does not simply go to jail","worst criminal of the day: "..data[k][7].." Jailed "..data[k][8].." Times.","simply","lspd2")
				--end
				oldData[k] = data[k]
			end

		elseif k == "lvcomealot1" or "lvcomealot2" then
			if (check==false) or data[k][2] ~= oldData[k][2] then
				oldData[k][2] = data[k][2]
				--setHasLatestForAll("lvcomealot1c",false)
				meme("","","Please give me a turf...just 1"," "..v[3].." ("..v[4]..") ::: CSG's Worst Group Needs One","pleaseguy","lvcomealot1c",true)
				--setHasLatestForAll("lvcomealot2a",false)
				meme("","",""..v[3].." ("..v[4]..") You criminal group","But you suck at turfing??","jackie","lvcomealot2a",true)
			end
			if (check==false) or data[k][1] ~= oldData[k][1] then
				startImageDownload2("chart.googleapis.com/chart?chxr=0,-25,25&chxt=y&chbh=a&chs=280x150&cht=bvg&chco=000000,FF0000,00FF00,0000FF,008000,224499,990066,FF9900,FF9900&chds=-25,25,-25,25,-25,25,-25,25,-25,25,-25,25,-25,25,-25,25,-25,25&chd=t8:"..topGroups[1][2].."|"..topGroups[2][2].."|"..topGroups[3][2].."|"..topGroups[4][2].."|"..worstGroups[1][2].."|"..worstGroups[2][2].."|"..worstGroups[3][2].."|"..worstGroups[4][2].."|-20&chdl="..topGroups[1][1].."|"..topGroups[2][1].."|"..topGroups[3][1].."|"..topGroups[4][1].."|"..worstGroups[1][1].."|"..worstGroups[2][1].."|"..worstGroups[3][1].."|"..worstGroups[4][1].."|Worst5&chg=5,5&chtt=CSG+Turfing+Top4/Worst4","lvcomealot2c")
				oldData[k][1] = data[k][1]

				local gname = data[k][1]
				--local gname=string.gsub(data[k][1],"	%s","%20")
				startImageDownload2("http://dummyimage.com/600x100/000/fff&text=CSG's%20"..gname.."%20("..v[2]..")%20Rule%20The%20Streets","lvcomealot1b")
				--setHasLatestForAll("lvcomealot2b",false)
				meme("","","As "..gname.." ("..v[2]..") we dont always turf","But when we do, we come out with victory","the most interesting man in the world","lvcomealot2b",true)
			end
		end
	end
end
setTimer(doUpdates,15000,0)

function setHasLatestForAll(name,bool)
	for k,v in pairs(getElementsByType("player")) do
		if hasLatest[v] == nil then hasLatest[v] = {} end
	    hasLatest[v][name]=bool
	end
end

function meme(ps,cmdName,top,bot,memeName,name,bool)
	if (bool) then
	else
		top=string.gsub(top,"-"," ")
		bot=string.gsub(bot,"-"," ")
		memeName=string.gsub(memeName,"-"," ")
	end
	callRemote("http://s1works.com/admin/Priyen/csgPriyenMTAmeme.php",callBackMeme,top,bot,memeName,name)
end
addCommandHandler("meme",meme)

function hitCol(col,cim)
	local p = source
	local valid = false
	for k,v in pairs(cols) do
		if v == col then valid = true break end
	end
	if valid == false then return end
	local name = cols[col]
	if textureData[name] == "" then return end
	sendToPlayer(source,name)
end



for k,v in pairs(colPlaces) do
	local col = createColCircle(v[1],v[2],175)
	cols[k] = col
	cols[col]=k

end

for k,v in pairs(getElementsByType("player")) do
	hasLatest[v] = {}
--	for k2,v2 in pairs(colPlaces) do
	--	hasLatest[v][k2] = true
	--end
	hasLatest[v]["fish2"] = false
	hasLatest[v]["lspd1"] = false
	hasLatest[v]["lspd2"] = false
	hasLatest[v]["lspd3"] = false
	hasLatest[v]["lvcomealot1a"] = false
	hasLatest[v]["lvcomealot2a"] = false
	hasLatest[v]["lvcomealot1b"] = false
	hasLatest[v]["lvcomealot2b"] = false
	hasLatest[v]["lvcomealot1c"] = false
	hasLatest[v]["lvcomealot2c"] = false
end
addEventHandler("onElementColShapeHit",root,hitCol)
function login()
	hasLatest[source] = {}
	for k,v in pairs(colPlaces) do
		hasLatest[source][k] = false
	end
end
addEventHandler("onPlayerLogin",root,login)

cops = {}
crims = {}

function recalcBestLaw()
	local topArrests = 0
	local copUser = ""
	for k,v in pairs(cops) do
		if v[1] > topArrests then topArrests = v[1] copUser=k end
	end
	if data["lspd"][6] < topArrests then
		local pl = getAccountPlayer(getAccount(copUser))
		local oldpl = getPlayerFromName(data["lspd"][5])

		local copName = getPlayerName(pl)
		if oldpl ~= false then
			 exports.DENdxmsg:createNewDxMessage(pl,"You are no longer Law Officer of the day, "..copName.." has taken the title!",0,255,0)
		end
		data["lspd"][5] = copName
		data["lspd"][6] = topArrests
		 exports.DENdxmsg:createNewDxMessage(pl,"Congratulations! You are now the best Law Officer of the day with "..topArrests.." arrests!",0,255,0)
	end
end

function recalcWorstCrim()
	local topJailed = 0
	local crimUser = ""
	for k,v in pairs(crims) do
		if v[1] > topJailed then topJailed = v[1] crimUser=k end
	end
	if data["lspd"][8] < topJailed then
		local pl = getAccountPlayer(getAccount(crimUser))
		local oldpl = getPlayerFromName(data["lspd"][7])
		local crimName = getPlayerName(getAccountPlayer(getAccount(crimUser)))
		if oldpl ~= false then
			 exports.DENdxmsg:createNewDxMessage(pl,"You are no longer the Worst Criminal of the day, "..crimName.." has taken the title!",0,255,0)
		end
		data["lspd"][7] = crimName
		data["lspd"][8] = topJailed
		exports.DENdxmsg:createNewDxMessage(pl,"Congratulations! You are now the Worst Criminal of the day : Jailed "..topJailed.." times!",0,255,0)
	end
end

local arrests = {}
addEvent("onPlayerArrest",true)
addEventHandler("onPlayerArrest",root,function(cop)
	arrests[source]=cop
end)

function jailed(thetime)
	if arrests[source] == nil then return end
	local jailer = arrests[source]
	local wantedpts = exports.server:getPlayerWantedPoints(source)
	local crimAcc = exports.server:getPlayerAccountName(source)
	local jailerAcc = exports.server:getPlayerAccountName(jailer)
	if cops[jailerAcc] == nil then cops[jailerAcc] = {0,0,0,0} end
	cops[jailerAcc][1] = cops[jailerAcc][1]+1 --arrests
	cops[jailerAcc][2] = cops[jailerAcc][2]+thetime
	cops[jailerAcc][3] = cops[jailerAcc][3]+wantedpts
	data["lspd"][1] = data["lspd"][1]+1
	data["lspd"][2] = data["lspd"][2]+thetime
	data["lspd"][3] = data["lspd"][3]+wantedpts
	if crims[crimAcc] == nil then crims[crimAcc] = {0,0,0,0} end
	crims[crimAcc][1] = crims[crimAcc][1]+1 --jailed # of times
	crims[crimAcc][2] = crims[crimAcc][2]+thetime
	crims[crimAcc][3] = crims[crimAcc][3]+wantedpts
	recalcBestLaw()
	recalcWorstCrim()
	oldData["lspd"] = nil
end
addEvent("onPlayerJailed",true)
addEventHandler("onPlayerJailed",root,jailed)

groupRatings = {}
turfsFirst = {}

function tableContains(t,va)
	for k,v in pairs(t) do
		if v[1] == va then return true end
	end
	return false
end

function doesTopsContainValue(t,val)
	for k,v in pairs(t) do
		if v[1] == val then return true,k end
	end
	return false
end

function recalcGroups()
	local taken = {}
	local temp = {}
	for k,v in pairs(groupRatings) do
		--outputChatBox("rating "..k.." "..v.."")
		table.insert(temp,v)
	end
	if #temp < 8 then
		for i = 1,8-#temp do
			table.insert(temp,1,-999)
		end
	end
	table.sort(temp)

	for k,v in pairs(groupRatings) do
		local na = string.gsub(k,"%s","-")

		if v == temp[1] then
			worstGroups[4][1] = na
			worstGroups[4][2] = v
		elseif v == temp[2] then
			worstGroups[3][1] = na
			worstGroups[3][2] = v
		elseif v == temp[3] then
			worstGroups[2][1] = na
			worstGroups[2][2] = v
		elseif v == temp[4] then
			worstGroups[1][1] = na
			worstGroups[1][2] = v
		elseif v == temp[#temp-3] then
			topGroups[4][1] = na
			topGroups[4][2] = v
		elseif v == temp[#temp-2] then
			topGroups[3][1] = na
			topGroups[3][2] = v
		elseif v == temp[#temp-1] then
			topGroups[2][1] = na
			topGroups[2][2] = v
		elseif v == temp[#temp-0] then
			topGroups[1][1] = na
			topGroups[1][2] = v
		end
	end
	top=topGroups[1][2]
	topName=topGroups[1][1]
	worst=worstGroups[4][2]
	worstName=worstGroups[4][1]
	oldData["lvcomealot1"] = nil oldData["lvcomealot2"] = nil
	if top > 0 then top = "+"..top.."" end
	if worst > 0 then worst = "+"..worst.."" end
	topName=string.gsub(topName,"%s","-")
	worstName=string.gsub(worstName,"%s","-")
	data["lvcomealot1"]={topName,top,worstName,worst}
	data["lvcomealot2"]={topName,top,worstName,worst}
end

function startedTurfAttack(defendinggroup,atkingroup,id)
	if turfsFirst[id] == nil then turfsFirst[id] = true end
	if groupRatings[defendinggroup] == nil then groupRatings[defendinggroup] = 0+((math.random(1,100))/100) end
	if groupRatings[atkingroup] == nil then groupRatings[atkingroup] = 0+((math.random(1,100))/100) end
	if turfsFirst[id] ==  false then
		groupRatings[atkingroup] = groupRatings[atkingroup]-1
	else
		turfsFirst[id] = false
	end
	recalcGroups()
end
addEvent("onStartTurfAttack ",true)
addEventHandler("onStartTurfAttack ",root,startedTurfAttack)

function turfTaken(oldgroup,newgroup,id)
	if turfsFirst[id] == nil then turfsFirst[id] = true end
	if groupRatings[oldgroup] == nil then groupRatings[oldgroup] = 0+((math.random(1,100))/100) end
	if groupRatings[newgroup] == nil then groupRatings[newgroup] = 0+((math.random(1,100))/100) end
	if turfsFirst[id] ==  false then
		groupRatings[oldgroup] = groupRatings[oldgroup]-1
		groupRatings[newgroup] = groupRatings[newgroup]+2
	else
		groupRatings[newgroup] = groupRatings[newgroup]+1
		turfsFirst[id] = false
	end

	recalcGroups()
end
addEvent("onTurfCaptured",true)
addEventHandler("onTurfCaptured",root,turfTaken)

function myUpdates(ps)
	for k,v in pairs(hasLatest[ps]) do
		outputChatBox(""..k.." : "..tostring(v).."",ps)
	end
end
addCommandHandler("mylatests",myUpdates)

doUpdates()
startImageDownload2("http://dummyimage.com/600x100/000/66cd00&text=They%20Say%20It.%20Then%20Do%20It.%20To%20the%20end.","lvcomealot1a")


