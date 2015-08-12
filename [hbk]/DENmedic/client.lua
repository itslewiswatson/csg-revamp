healVal = 10
healTime = 1000
healTable = {}
medicFarming = {}
medicFarmingTimer = {}
healReward = 47
local scoreCD = {}
function playerHeal ( attacker, weapon, bodypart, loss )
    local health = getElementHealth(source)+loss
	if attacker ~= false and source ~= nil then
		if healTable[source] == nil then
			healTable[source] = false
		end
		if getElementType ( attacker ) == "vehicle" then
		return
		end
		if (( getTeamName ( getPlayerTeam ( attacker ) ) == "Paramedics" ) or getElementData(attacker,"skill") == "Support Unit") and ( weapon == 41 ) then
			if not healTable[source] then
				local stat = getPedStat(source,24)
				if stat == 1000 then check = 200 else check = 100 end
				if ( health < check ) and (health > 0 ) then
					if not ( isMedicHealAllowed ( attacker ) ) then
						healTable[source] = true
						setTimer ( timeFix, healTime, 1,source )
						triggerServerEvent ( "healedPlayer", attacker, nil, source, healVal )
						cancelEvent()
					else
						healTable[source] = true
						setTimer ( timeFix, healTime, 1,source )


						triggerServerEvent ( "healedPlayer", attacker, healReward, source, healVal )
						cancelEvent()
					end
				else
					cancelEvent()
				end
			else
				cancelEvent()
			end
		end
	end
end

function timeFix ( player )
	healTable[player] = false
end
addEventHandler ( "onClientPlayerDamage", localPlayer, playerHeal )

function onPlayerDamageByMedic ( attacker, weapon, bodypart, loss )
	if  not ( medicFarming[attacker] ) then
		medicFarming[attacker] = {}
	end

	if ( isElement( attacker ) ) and ( source == localPlayer ) then
		if ( attacker ~= source ) then
			if ( getPlayerTeam ( attacker ) ) and ( getTeamName ( getPlayerTeam ( attacker ) ) == "Paramedics" ) and ( weapon == 41 ) then
				return
			else
				table.insert( medicFarming[attacker], source )
				medicFarmingTimer[attacker] = setTimer( removeHealAttack, 60000, 1, attacker, source )
			end
		end
	end
end
addEventHandler ( "onClientPlayerDamage", root, onPlayerDamageByMedic )

function removeHealAttack ( attacker, victim )
	if ( medicFarming[attacker] ) then
		for i=1,#medicFarming[attacker] do
			if ( medicFarming[attacker][i] == victim ) then
				table.remove( medicFarming[attacker], i )
			end
		end
	end
end

function isMedicHealAllowed ( attacker )
	if ( medicFarming[attacker] ) then
		for i=1,#medicFarming[attacker] do
			if ( medicFarming[attacker][i] == localPlayer ) then
				return false
			end
		end
	end
	return true
end

