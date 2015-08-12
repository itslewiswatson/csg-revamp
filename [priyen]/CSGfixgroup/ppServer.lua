addCommandHandler("resettotrial",function()
	dbQuery(resetCB1,{nil},exports.DENmysql:getConnection(),"SELECT * FROM groups_members")
end)

function resetCB1(qh)
	local t = dbPoll(qh,0)
	for k,v in pairs(t) do
		exports.DENmysql:exec("UPDATE groups_members SET grouprank=?","Trial")
	end
	dbQuery(resetCB2,{nil},exports.DENmysql:getConnection(),"SELECT * FROM groups")
end

function resetCB2(qh)
	local t = dbPoll(qh,0)
	for k,v in pairs(t) do
		exports.DENmysql:exec("UPDATE groups_members SET grouprank=? WHERE membername=? AND groupname=?","Group founder",v.groupleader,v.groupname)
	end
end
