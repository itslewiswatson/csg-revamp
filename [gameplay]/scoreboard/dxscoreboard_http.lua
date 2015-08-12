-- Original file by jbeta
local httpColumns = {}
local httpRows = {}
local updateInterval = 1000
local lastUpdateTime = 0

function getScoreboardColumns()
	-- Only update http data if someone is looking
	if getTickCount() - lastUpdateTime > updateInterval then
		lastUpdateTime = getTickCount()
		refreshServerScoreboard()
	end
   return httpColumns
end

function getScoreboardRows()
	return httpRows
end

local function getName( element )
	local elementType = getElementType( element )
	if elementType == "player" then
		return getPlayerName( element )
	elseif elementType == "team" then
		return getTeamName( element )
	end
end

local function calculateWidth()
	local width = 0
	for key, value in ipairs( scoreboardColumns ) do
		width = width + value.width
	end
	return width
end
--[[
local showingRank=true

setTimer(function()
	if showingRank == true then showingRank=false else showingRank=true end
end,1000,0)

function isLaw(p)
	local name = getTeamName(getPlayerTeam(p))
	if name == "Police" or name == "Government Agency" or name == "SWAT" or name == "Military Forces" then return true end
	return false
end

--]]
local function getRowData( element )
	local rowData = { getElementType( element ), }
	for key, column in ipairs( httpColumns ) do
		if column.name == "name" then
			table.insert( rowData, getName( element ) )
		elseif column.name == "ping" then
			local ping = ""
			if getElementType( element ) == "player" then
				ping = getPlayerPing( element )
			end
			table.insert( rowData, ping )
		--[[elseif column.name == "Rank" then
			if isLaw(element) == true then
				if showingRank == true then
					table.insert( rowData, getElementData( element, column.name ) or "" )
				else
					local skill = getElementData(element,"skill")
					if skill ~= false then
						table.insert( rowData, getElementData( element, "skill" ) or "" )
					else
						table.insert( rowData, getElementData( element, column.name ) or "" )
					end
				end
			else
				table.insert( rowData, getElementData( element, column.name ) or "" )
			end--]]
		else
			if tostring(column.name) == "playerScore" then
				table.insert( rowData, math.floor((getElementData( element, column.name ))+0.5) or "" )
			else
				table.insert( rowData, getElementData( element, column.name ) or "" )
			end
		end
	end
	return rowData
end

function refreshServerScoreboard()
	local scoreboardNewColumns = {}

	for key, column in ipairs( scoreboardColumns ) do
		table.insert( scoreboardNewColumns, { ["name"] = column.name, ["size"] = column.width/calculateWidth() } )
	end
	httpColumns = scoreboardNewColumns

	local scoreboardNewRows = {}

	local players = getElementsByType( "player" )
	for key, player in ipairs( players ) do
		if isElement( player ) and not getPlayerTeam( player ) then
			table.insert( scoreboardNewRows, getRowData( player ) )
		end
	end

	local teams = getElementsByType( "team" )
	for key, team in ipairs( teams ) do
		if isElement( team ) then
			table.insert( scoreboardNewRows, getRowData( team ) )
			local players = getPlayersInTeam( team )
			for i, player in ipairs( players ) do
				if isElement( player ) then
					table.insert( scoreboardNewRows, getRowData( player ) )
				end
			end
		end
	end
	httpRows = scoreboardNewRows
end
