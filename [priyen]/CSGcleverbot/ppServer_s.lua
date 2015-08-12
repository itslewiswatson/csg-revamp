local waitingOnResult = false
function sendToCB(msg)
	waitingOnResult = true
	callRemote("http://priyenremote.comuv.com/test.php",function(a) waitingOnResult=false
	outputChatBox("#B0171F(LV) novs: #FFFFFF"..a.."",root,255,255,255,true) end,msg)

end


function pChat(tx)
	if waitingOnResult == true then return end
	--if exports.server:getPlayerAccountName(source) == "kaze123" or exports.server:getPlayerAccountName(source) == "carter" then --benja
		sendToCB(tostring(tx))
	--end
end
addEventHandler("onPlayerChat",root,pChat)
--sendToCB("Hi")
