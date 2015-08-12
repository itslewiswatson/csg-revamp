function pchiefChat(thePlayer, cmd, ...)
    local msg = table.concat({...}, " ")
    if (msg and msg ~= "") then
        for k,v in pairs(getElementsByType("player")) do
            if getElementData(v,"polc") ~= false then
			--	outputChatBox("#ff000f(Police Chief) : #0f98ea".. getPlayerName(thePlayer) .." : " .. msg .."",v,50,150,200,true)
				outputChatBox("#ff000f(Police Chief) : #0f98ea".. getPlayerName(thePlayer) .. "#ff000f L"   .. getElementData(thePlayer,"polc") .. " : #0f98ea " .. msg .."",v,50,150,200,true)
			--	outputChatBox("#ff000f(Police Chief) : #ffffff".. getPlayerName(thePlayer) .." : #0f98ea " .. msg .."",v,50,150,200,true)
			--  outputChatBox("#0f98ea(Police Chief): ".. getPlayerName(thePlayer) .."#0f98ea:#ffffff " .. msg .."",v,50,150,200,true)
			end
		end
    end
end

addCommandHandler("Pchief",pchiefChat)

addEventHandler("onPlayerJoin",root,
    function ()
	for k,v in pairs(getElementsByType("player")) do
        if getElementData(v,"polc") ~= false then
			bindKey(v,"B","down","chatbox","Pchief")
		end
    end
end
)

addEventHandler("onResourceStart",resourceRoot,
    function ()
	for k,v in pairs(getElementsByType("player")) do

		if getElementData(v,"polc") ~= false then
			bindKey(v,"B","down","chatbox","Pchief")
        end
    end
    end
)
