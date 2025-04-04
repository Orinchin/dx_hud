local curPaused
local lastHealth, lastArmour
local onSurface, isResting

CreateThread(function()
	while true do
		if HUD then
			local paused = IsPauseMenuActive()
			if paused ~= curPaused then
				SendMessage('toggleHud', not paused)
				curPaused = paused
			end

			local curHealth = GetEntityHealth(cache.ped)
			if curHealth ~= lastHealth then
				SendMessage('setHealth', {
					current = curHealth,
					max = GetEntityMaxHealth(cache.ped)
				})
				lastHealth = curHealth
			end

			local curArmour = GetPedArmour(cache.ped)
			if curArmour ~= lastArmour then
				SendMessage('setArmour', curArmour)
				lastArmour = curArmour
			end

			if GetConvarInt('hud:stamina', false) == 1 then
				local curStamina = GetPlayerStamina(cache.playerId)
				local maxStamina = GetPlayerMaxStamina(cache.playerId)
				if curStamina < maxStamina then
					SendMessage('setStamina', {
						current = curStamina,
						max = maxStamina
					})
					isResting = false
				elseif not isResting then
					SendMessage('setStamina', false)
					isResting = true
				end
			end

			local curUnderwaterTime = GetPlayerUnderwaterTimeRemaining(cache.playerId)
			if curUnderwaterTime < maxUnderwaterTime then
				SendMessage('setOxygen', {
					current = curUnderwaterTime,
					max = maxUnderwaterTime
				})
				onSurface = false
			elseif not onSurface then
				SendMessage('setOxygen', false)
				onSurface = true
			end
		end
		Wait(200)
	end
end)

function GetAccountIndexByName(accounts, accountName)
    for i, account in ipairs(accounts) do
        if account.name == accountName then
            return i
        end
    end
    return nil
end

CreateThread(function()
    while true do
        if ESX.PlayerLoaded then
            local playerData = ESX.GetPlayerData()

            local hours = GetClockHours()
            local minutes = GetClockMinutes()

            local ampm = "AM"
            if hours >= 12 then
                ampm = "PM"
                if hours > 12 then
                    hours = hours - 12
                end
            end

            local formattedMinutes = string.format("%02d", minutes)
            local formattedHours = string.format("%02d", hours)

            SendMessage('setPlayerJob', playerData.job.label .. " - " .. playerData.job.grade_label)
            SendMessage('setPlayerTime', formattedHours .. ":" .. formattedMinutes .. ' | ' .. ampm)

            local bankAccountIndex = GetAccountIndexByName(playerData.accounts, 'bank')
            local bankMoney = bankAccountIndex and playerData.accounts[bankAccountIndex].money or 0

            local cashAccountIndex = GetAccountIndexByName(playerData.accounts, 'money')
            local cashMoney = cashAccountIndex and playerData.accounts[cashAccountIndex].money or 0

            SendMessage('setPlayerBank', bankMoney)
            SendMessage('setPlayerCash', cashMoney)

            Wait(500)
        else
            Wait(1000)
        end
    end
end)
