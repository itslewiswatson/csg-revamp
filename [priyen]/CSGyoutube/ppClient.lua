local pendingvalidSize = {}
local validSize = {}
function isYoutubeLink(link)
	local is=false
	if string.find(string.lower(link),"youtube") then
		is=true
	end
	return is
end

function isValidYoutubeLink(link)
	local valid=true
	if string.find(string.lower(link),"#t=") then
		valid=false
	end
	if string.find(string.lower(link),"feature=") then
		valid=false
	end
	return valid
end


