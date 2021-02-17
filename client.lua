
--Menambahkan suatu event
RegisterNetEvent('Teleportplayer')
--Event ini mau bisa apa? bisa nerima apa?
AddEventHandler('Teleportplayer', function()
    local waypoint = GetFirstBlipInfoId(8)
    local coords = GetBlipInfoIdCoord(waypoint)

    for height=1, 1000 do
        SetPedCoordsKeepVehicle(PlayerPedId(), coords.x, coords.y, height + 0.0)

        local ketemuKetinggian, ketinggian = GetGroundZFor_3dCoord(coords.x, coords.y, height + 0.0)

        if ketemuKetinggian then
            print(ketemuKetinggian, ketinggian)
            SetPedCoordsKeepVehicle(PlayerPedId(), coords.x, coords.y, height + 0.0)
            break
        end

        Citizen.Wait(5)
    end

    --SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0,0,0)
end)

function DrawTextOnScreen(text, x, y)
    SetTextFont(4)
    SetTextScale(0, 0.4)
    SetTextDropShadow(1, 0, 0, 0, 255)
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y)
end

local display = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsControlJustReleased(0, 83) then
            display = not display      
        end
        if display then
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            local pedHeading = GetEntityHeading(ped)

            DrawTextOnScreen('X: '..pedCoords.x, 0.85, 0.4)
            DrawTextOnScreen('Y: '..pedCoords.y, 0.85, 0.43)
            DrawTextOnScreen('Z: '..pedCoords.z, 0.85, 0.46)
            DrawTextOnScreen('Heading: '..pedHeading, 0.85, 0.49)
        end
    end
end)

RegisterCommand('tpc', function(source, args, rawCommand)
    SetPedCoordsKeepVehicle(PlayerPedId(), args[1] + 0.0, args[2] + 0.0, args[3] + 0.0, 0,0,0)
end)

RegisterNetEvent('TestDariServer')
AddEventHandler('TestDariServer', function()
    print('Dipanggil dari server')
end)

RegisterCommand('tpm', function(source, args, rawCommand)
    TriggerEvent('Teleportplayer')
end)