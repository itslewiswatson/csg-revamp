local pendingvalidSize = {}
local validSize = {}

function getMaskedYoutube(link)

end

function isAlreadyExists(link)
	--link=string.lower(link)
	local str = string.gsub(link,"www.","")
	str = string.gsub(str,"http://","")
	str="www."..str..""
	local t = exports.DENmysql:query("SELECT * FROM youtube WHERE youtubelink=?",str)
	if #t > 0 then
		return true
	else
		return false
	end
end

function doesAlreadyExistLink(link)
	if link==nil then return false end
	--link=string.lower(link)
	local str = string.gsub(link,"www.","")
	str = string.gsub(str,"http://","")
	str="www."..str..""
	local t = exports.DENmysql:query("SELECT * FROM youtube WHERE youtubelink=?",str)
	if #t > 0 then
		return t[1]
	else
		return false
	end
end

function isYoutubeLink(link)
	local is=false
	if string.find(string.lower(link),"youtube") then
		is=true
	end
	return is
end

function isValidYoutubeLink(link)
	local valid=true
	if string.find(string.lower(link),"#t=") then
		valid=false
	end
	if string.find(string.lower(link),"feature=") then
		valid=false
	end
	return valid
end

function attemptProcessLink(link)
	if pendingvalidSize[link]==nil then pendingvalidSize[link]=false end
	if pendingvalidSize[link]==true then return end
	local str = string.gsub(link,"www.","")
	str = string.gsub(str,"http://","")
	str="www."..str..""
	pendingvalidSize[str]=true
	callRemote("http://priyen2.cloudapp.net/csg/youtube/length.php",function(_,length)
	if length == nil then
		triggerEvent("CSGyoutube.badLink",getRandomPlayer(),str)
		pendingvalidSize[str]=false
		return
	end
	local out = tonumber(length["0"])
	pendingvalidSize[str]=false
	if out <= 1200 then
		validSize[str]=true
	else
		validSize[str]=false
	end
	triggerEvent("CSGyoutube.recSizeValidity",getRandomPlayer(),link,validSize[str],out)
	end,str)
end
--[[
function recSize(link,length)
	if length == nil then
		triggerEvent("CSGyoutube.badLink",getRandomPlayer(),link)
		pendingvalidSize[link]=false
		return
	end
	local out = tonumber(length["0"])
	pendingvalidSize[link]=false
	if out <= 300 then
		validSize[link]=true
	else
		validSize[link]=false
	end
	triggerEvent("CSGyoutube.recSizeValidity",getRandomPlayer(),link,validSize[link],out)
end
--]]
addEvent("CSGyoutube.recSizeValidity",true)
addEventHandler("CSGyoutube.recSizeValidity",root,function(link,valid,length)
	if valid==false then return end
	local str = string.gsub(link,"www.","")
	str = string.gsub(str,"http://","")
	str="www."..str..""
	if isAlreadyExists(link) == false then
		exports.DENmysql:query( "INSERT INTO youtube SET youtubelink=?, length=?",str,length)
	else
		return
	end
	local t = exports.DENmysql:query("SELECT * FROM youtube WHERE youtubelink=?",str)
	local songID=nil
	for k,v in pairs(t) do
		if v.youtubelink == str then
			songID=v.id
			break
		end
	end
	if songID==nil then return end
	triggerEvent("CSGyoutube.idMade",getRandomPlayer(),link,songID)
	exports.DENmysql:query("UPDATE youtube SET mp3link=? WHERE youtubelink=?","http://priyen2.cloudapp.net/csg/youtube/mp3/CSG-ID-"..songID..".mp3",str)
	local moddedSTR=string.gsub(str,"www.","")
	moddedSTR="http://"..moddedSTR..""
	callRemote("http://priyen2.cloudapp.net/csg/youtube/csg.php",recConversion,moddedSTR,songID)
end)

function recConversion(title,id)
	exports.DENmysql:query("UPDATE youtube SET name=? WHERE id=?",title,id)
	triggerEvent("CSGyoutube.gotTitle",getRandomPlayer(),title,id)
end

addCommandHandler("processalldatabaselinks",function(ps)
	dbQuery(processAllCB,{},exports.DENmysql:getConnection(),"SELECT * FROM youtube")
end)

function processAllCB(qh)
	local t = dbPoll(qh,0)
	outputDebugString("CSG Youtube - reprocessing all videos!")
	local count=20000
	for k,v in pairs(t) do
		setTimer(function()
			local str = string.gsub(v.youtubelink,"www.","")
			local moddedSTR="http://"..str..""
			callRemote("http://priyen2.cloudapp.net/csg/youtube/csg.php",function() end,moddedSTR,v.id)
			outputDebugString("sent req to process "..v.youtubelink.."")
		end,count,1)
		count=count+20000
	end
end
