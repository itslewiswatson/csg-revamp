function CPUstats()
	columns, rows = getPerformanceStats("Lua timing")
	for i, row in ipairs(rows) do
		outputDebugString(table.concat(row, "  "),0,255,0,0)
	end
end
addCommandHandler("CPU",CPUstats)