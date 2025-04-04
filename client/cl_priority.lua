ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
    Citizen.Wait(1)
    ESX.TriggerServerCallback('nui:GetPriorityStatus', function(status)
    value = status
    if value == 1 then 
		TriggerServerEvent('nui:green:server')
    elseif value == 2 then
		TriggerServerEvent('nui:red:server')
    end 
  end)
  ESX.TriggerServerCallback('nui:GetPriorityStatusSheriff', function(status)
  value = status
  if value == 1 then 
      TriggerServerEvent('nui:green:server:sheriff')
  elseif value == 2 then
      TriggerServerEvent('nui:red:server:sheriff')
  end 
end)
end)

RegisterNetEvent('nui:green')
AddEventHandler('nui:green', function()
	SendNUIMessage({
		type = "setPriority",
		display = true
	})
end)

RegisterNetEvent('nui:red')
AddEventHandler('nui:red', function()
	SendNUIMessage({
		type = "setPriority",
		display = false
	})
end)

RegisterNetEvent('nui:green:sheriff')
AddEventHandler('nui:green:sheriff', function()
	SendNUIMessage({
		type = "setPrioritySheriff",
		display = true
	})
end)

RegisterNetEvent('nui:red:sheriff')
AddEventHandler('nui:red:sheriff', function()
	SendNUIMessage({
		type = "setPrioritySheriff",
		display = false
	})
end)

RegisterCommand('green', function(source, args, rawCommand)
    if ESX.PlayerData.job.name == 'police' then
      TriggerServerEvent('nui:green:server')
    end
  end)

  RegisterCommand('red', function(source, args, rawCommand)
    if ESX.PlayerData.job.name == 'police' then
      TriggerServerEvent('nui:red:server')
    end
  end)
  
  RegisterCommand('sgreen', function(source, args, rawCommand)
    if ESX.PlayerData.job.name == 'sheriff' then
      TriggerServerEvent('nui:green:server:sheriff')
    end
  end)

  RegisterCommand('sred', function(source, args, rawCommand)
    if ESX.PlayerData.job.name == 'sheriff' then
      TriggerServerEvent('nui:red:server:sheriff')
    end
  end)
  
  AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    ESX.TriggerServerCallback('nui:GetPriorityStatus', function(status)
        value = status
        if value == 1 then 
            TriggerServerEvent('nui:green:server')
        elseif value == 2 then
            TriggerServerEvent('nui:red:server')
        end 
      end)
      ESX.TriggerServerCallback('nui:GetPriorityStatusSheriff', function(status)
        value = status
        if value == 1 then 
            TriggerServerEvent('nui:green:server:sheriff')
        elseif value == 2 then
            TriggerServerEvent('nui:red:server:sheriff')
        end 
      end)
  end)