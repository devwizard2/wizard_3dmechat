RegisterNetEvent("3dme:trigger")
AddEventHandler("3dme:trigger", function(msg)
    local sourceId = source
    local text = "*" .. msg .. "*"
    TriggerClientEvent("3dme:display", -1, text, sourceId)
end)
