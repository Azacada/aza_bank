-- function 

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(2000)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function retirer()
    local amount = KeyboardInput('AZA_RETIRER', ('Retirer de l\'espèces'), '', 6)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('AZA:Retirer', amount)
        end
    end
end

function deposer()
    local amount = KeyboardInput('AZA_DEPOSER', ('Déposer de l\'argent'), '', 6)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('AZA:Deposer', amount)
        end
    end
end	

function startScenario(anim)
    TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

function RefreshMoney()
    Citizen.CreateThread(function()
            ESX.Math.GroupDigits(ESX.PlayerData.money)
            ESX.Math.GroupDigits(ESX.PlayerData.accounts[1].money)
            ESX.Math.GroupDigits(ESX.PlayerData.accounts[2].money)
    end)
end

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i=1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end
end)

