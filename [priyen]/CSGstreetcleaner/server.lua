
function paygarbagecleaner(pay)
    if pay == nil or pay == 0 then return end
     exports.CSGaccounts:addPlayerMoney(source, pay, "Street Cleaner")
end
addEvent("paygarbagecleaner", true)
addEventHandler("paygarbagecleaner", getRootElement(), paygarbagecleaner)

