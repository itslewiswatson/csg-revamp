local trans=false

addCommandHandler("transtogglecsg",function(ps)
	trans=(not trans)
	outputChatBox("Translate : "..tostring(trans).."",ps,255,0,0)
end)


local data = {}
local bad = {
"lul","Lul","lul.","Lul.","Hai","hai","Hai.","hai."
}
local warnings = {}

function chat(msg)
	if trans==false then return end
	if exports.server:getPlayerAccountName(source) == "priyen" or exports.server:getPlayerAccountName(source) == "carter" then return end
	--if data[source] == nil then data[source] = msg return end
	for k,v in pairs(bad) do if v == msg then return end end
	data[source]=msg
	--table.insert(data,{"",{getTeamColor(getPlayerTeam(source))},source})
	callRemote("http://priyenremote.comuv.com/priyenTranslate.php",rec,msg,getPlayerName(source))
end
addEventHandler("onPlayerChat",root,chat)

local badLangs = {
	"en","noun","interjection","adverb","bs","article","adjective"
}
function rec(msg,p,lang)
	p=getPlayerFromName(p)
	if p == false then return end
	outputDebugString(msg)
	local r,g,b = getTeamColor(getPlayerTeam(p))
	local pName = getPlayerName(p)
	if data[p] == msg then return end
	outputChatBox("(LS) "..pName..": #FFFFFF"..msg.." ["..lang.." to en]",root,r,g,b,true)
	if warnings[lang] == nil then
		callRemote("http://priyenremote.comuv.com/priyenTranslateToLang.php",rec2,"only English in main chat!",lang,getPlayerName(p))
	else
		exports.dendxmsg:createNewDxMessage(p,""..pName..", "..warnings[lang].."",255,0,0)
	end
end

function rec2(msg,p,lang)
	warnings[lang] = msg
	local pName=p
	p=getPlayerFromName(p)
	exports.dendxmsg:createNewDxMessage(p,""..pName..", "..warnings[lang].."",255,0,0)
end
