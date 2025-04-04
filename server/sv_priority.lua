ESX = exports['es_extended']:getSharedObject()

local CurrStatus = 1
local CurrStatusSheriff = 2 --Change to 1 if you have sheriff job

RegisterNetEvent('nui:green:server')
AddEventHandler('nui:green:server', function()
   CurrStatus = 1
   TriggerClientEvent('nui:green', -1)
end)

RegisterNetEvent('nui:red:server')
AddEventHandler('nui:red:server', function()
   CurrStatus = 2
   TriggerClientEvent('nui:red', -1)
end)

RegisterNetEvent('nui:green:server:sheriff')
AddEventHandler('nui:green:server:sheriff', function()
   CurrStatusSheriff = 1
   TriggerClientEvent('nui:green:sheriff', -1)
end)

RegisterNetEvent('nui:red:server:sheriff')
AddEventHandler('nui:red:server:sheriff', function()
   CurrStatusSheriff = 2
   TriggerClientEvent('nui:red:sheriff', -1)
end)

ESX.RegisterServerCallback('nui:GetPriorityStatus', function(source, cb)
    cb(CurrStatus)
end)

ESX.RegisterServerCallback('nui:GetPriorityStatusSheriff', function(source, cb)
   cb(CurrStatusSheriff)
end)