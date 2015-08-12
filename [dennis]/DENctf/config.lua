-- Table with all the flags stored
local flagPositions = {
	{ 1019.49, 1086.17, 11 },
	{ 2006.57, 2908.16, 47.82 },
	{ 2915.94, 2474.08, 10.24 },
	{ 2850.4, 1290.69, 10.81 },
	{ 2614.55, 817.44, 4.74 },
	{ 1411.77, 781.26, 10.24 },
	{ 1066.84, 2085.41, 10.24 },
	{ 892.720, 2638.37, 11.44 },
}

-- Table with all the deliver points stored
local deliverPositions = {
	{ 1972.00, 1623.11, 12.87 },
	{ 2187.04, 1974.65, 10.24 },
	{ 2179.95, 2416.52, 73.03 },
	{ 1632.22, 2132.01, 10.35 },
	{ 1345.15, 2147.29, 11.01 },
}

-- Get a random position for the flag to spawn
function getRandomFlagPosition ()
	local number = math.random( 1, #flagPositions )
	return flagPositions[number][1], flagPositions[number][2], flagPositions[number][3]
end

-- Get a random postion for the deliver place for the flag
function getRandomDeliverPosition ()
	local number = math.random( 1, #deliverPositions )
	return deliverPositions[number][1], deliverPositions[number][2], deliverPositions[number][3]
end