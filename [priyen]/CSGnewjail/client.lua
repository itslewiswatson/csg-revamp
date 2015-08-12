local sniperPeds = {}

addEvent("CSGjail.recSniperPed",true)
addEventHandler("CSGjail.recSniperPed",localPlayer,function(p)
	table.insert(sniperPeds,p)
end)

local msgs = {
	"Do that again and you will pay the price.",
	"Do you want to spend your life in here?",
	"I'm warning you.",
	"Do that again, I dare you.",
	"Your lucky I'm nice, next time wont be the same.",
	"Your asking for it",
	"I can make you disappear noob",
	"You know that I know peaple ? nextime I will kill you !",
	"You are a dead man",
	"You are making me mad!",
}

local justHurtArmyPed = false
addEventHandler("onClientPedDamage",root,function(atker)
	if atker ~= localPlayer then return end
	for k,v in pairs(sniperPeds) do
		if v == source then
			if justHurtArmyPed == false then
				justHurtArmyPed=true
				outputChatBox("[CSG]Jail Guard: "..msgs[math.random(1,#msgs)].."",255,0,0)
				return
			end
			triggerServerEvent("CSGjail.iHurtArmyPed",localPlayer,source)
		end
	end
end)

sound=false
addEvent("CSGjail.alarm",true)
addEventHandler("CSGjail.alarm",localPlayer,function(x,y,z)
	if isElement(sound) then stopSound(sound) end
	sound=playSound3D("alarm.ogg",x,y,z)
end)

addEvent("CSGjail.alarmStop",true)
addEventHandler("CSGjail.alarmStop",localPlayer,function()
	stopSound(sound)
end)
