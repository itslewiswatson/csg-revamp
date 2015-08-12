local crims = 05
local MF = 03
local cops = 12
local civils = 08
local medics = 11
local FBI = 14
local firefighters = 04
local SWAT = 02
local unoccupied = 07 --off duty
local unemployed = 06
local staff = 00

function getColorForIRC(player)
	if (team(player,"Criminals") == true) then
		return crims
	elseif (team(player,"Military Forces") == true) then
		return MF
	elseif (team(player,"Police") == true) then
		return cops
	elseif (team(player,"Civilian Workers") == true) then
		return civils
	elseif (team(player,"Paramedics") == true) then
		return medics
	elseif (team(player,"Government Agency") == true) then
		return FBI
	elseif (team(player,"Firefighters") == true) then
		return firefighters
	elseif (team(player,"SWAT") == true) then
		return SWAT
	elseif (team(player,"Unoccupied") == true) then
		return unoccupied
	elseif (team(player,"Unemployed") == true) then
		return unemployed
	elseif (team(player,"Staff") == true) then
		return staff
	else
		return 15 --default color for those who are not in a team
	end
end

function team(player,team)
	if (getPlayerTeam(player) == getTeamFromName(team)) then
		return true
	else
		return false
	end
end