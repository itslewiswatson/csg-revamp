addEventHandler("onResourceStart",resourceRoot,
function()
	update(true)
end)

addEventHandler("onResourceStop",resourceRoot,
function()
	update(false)
end)

function update(state)
	if state == true then
		value = 1
	else
		value = 2
	end
	
	exports.DENmysql:exec("UPDATE settings SET value=? WHERE settingName=?",value,"serverState")
end