function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

local perdownload = 30000

addEvent("xdownload:downloadFile", true)
addEventHandler("xdownload:downloadFile", getRootElement(),
	function (serverFile, clientFile, interval)
		--outputDebugString(serverFile)
		local file = fileOpen(serverFile,true)
		--outputDebugString("rec down req")
		if file then
			--outputDebugString("Sending "..serverFile.." via background transfer - evading on connect download for "..getPlayerName(source).."")
			local fileSize = fileGetSize ( file )
			local fileTimes = math.round(fileSize / perdownload, 0 , "ceil")
			triggerEvent("onDownloadPreStart", source, serverFile, clientFile, interval, fileSize, fileTimes)
			triggerClientEvent(source, "onClientDownloadPreStart", source, clientFile, interval, fileSize, fileTimes)
			--interval forced to 1000
			interval = 1500
			local timer = setTimer(
				function (source, file, fileSize, fileTimes, serverFile, clientFile, t)
					if isElement(source) == false then
						if file then
							fileClose(file)
							file=false
						end
						return
					end
					if fileIsEOF(file) then
						triggerEvent("onDownloadComplete", source, serverFile, clientFile)
						triggerClientEvent(source, "onClientDownloadComplete", source, clientFile)
						fileClose(file)
					else
     						fstring = fileRead(file, perdownload)
						local rData = {fstring}
				   		triggerClientEvent(source, "xdownload:returnPartString", source, clientFile, rData)
					end
				end
			, interval, fileTimes + 1, source, file, fileSize, fileTimes, serverFile, clientFile, t)
		else
			triggerEvent("onDownloadFailure", source, serverFile, clientFile, interval)
			triggerClientEvent(source, "onClientDownloadFailure", source, serverFile, clientFile, interval)
		end
	end
)

function getServerFileSize(file, type)
local path = ""
	if not file then return false; end
	if string.find(file, ":") == 1 then
		path = file
	else
		if sourceResource then
			path = ":"..getResourceName(sourceResource).."/"..file
		else
			path = file
		end

	end
	if string.len(path) == 0 then
		outputDebugString("There must be a valid file to read from.", 3)
		return false;
	else
		local tFile = fileOpen(path, true)
		if tFile then
			local size = fileGetSize (tFile)
			if string.upper(type) == "KB" then
				size = math.round(size / 1024, 2)
			elseif string.upper(type) == "MB" then
				size = math.round(size / 1048576, 2)
			end
			fileClose(tFile)
			return size;
		else
			return false;
		end
	end
end

addEvent("onDownloadFailure", true)
addEvent("onDownloadComplete", true)
addEvent("onDownloadPreStart", true)
