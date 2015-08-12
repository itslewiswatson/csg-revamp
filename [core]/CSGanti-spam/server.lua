spam = {}
blacklist = {
{Next},
{Previous},
{lock},
{note},
{Toggle},
{csg},
{Localchat},
{Mainchat},
{superman},
{Reload},
{gc},
{sms},
{reply},
{repair},
} --commands that doesn't need to toggle the spam filter


function spam(cmd)
	for k,v in ipairs(blacklist) do
		if (blacklist[v] == cmd) then
			return --skip to the last end, its a blacklisted command so no action needed.
			break --stop the loop!
		end
	end
	if not (spam[source]) then
		spam[source] = 1
	elseif (spam[source] == 5) then
		cancelEvent()
		outputChatBox("Calm down on the command usage!!",source,255,0,0)
	else
		spam[source] = spam[source] + 1
	end
end
addEventHandler("onPlayerCommand",root,spam)

setTimer(function() spam = {}, end, 3000, 0)