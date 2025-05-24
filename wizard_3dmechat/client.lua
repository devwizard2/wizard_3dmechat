RegisterCommand("chat", function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "open" })
end)

RegisterKeyMapping("chat", "Open Chat", "keyboard", "T")

RegisterNUICallback("chatCommand", function(data, cb)
    local msg = data.message
    if msg:sub(1, 3) == "/me" then
        local content = msg:sub(5)
        TriggerServerEvent("3dme:trigger", content)
    else
        ExecuteCommand(msg:sub(2))
    end
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNUICallback("close", function(_, cb)
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNetEvent("3dme:display")
AddEventHandler("3dme:display", function(text, sourceId)
    local playerId = GetPlayerFromServerId(sourceId)
    if playerId == -1 then return end

    local ped = GetPlayerPed(playerId)
    local displayTime = 5000
    local start = GetGameTimer()

    CreateThread(function()
        while GetGameTimer() - start < displayTime do
            Wait(0)
            local pedCoords = GetEntityCoords(ped)
            local myCoords = GetEntityCoords(PlayerPedId())
            local dist = #(pedCoords - myCoords)

            if dist < 15.0 then
                DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 1.0, text)
            end
        end
    end)
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local camCoords = GetGameplayCamCoords()
    local dist = #(vector3(x, y, z) - camCoords)

    if onScreen then
        SetTextScale(0.4, 0.4)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(true)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
