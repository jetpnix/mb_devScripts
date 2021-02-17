RegisterNetEvent('TeleportServer')
AddEventHandler('TeleportServer', function()
    TriggerEvent('TeleportServer2')
    TriggerClientEvent('TestDariServer', source)
end)

-- event TeleportServer2
RegisterNetEvent('TeleportServer2')
AddEventHandler('TeleportServer2', function()
    print('halo aku di TeleportServer2')
end)

RegisterCommand('fetchtest', function()
    local data = PerformHttpRequest('http://188.166.217.13:4500/api/', function(err, text, headers)
        print(err)
        print(text)
    end, 'GET', "", { ['Content-Type'] = 'application/json' })
end)

-- server --> client source(id)
--        --> client2