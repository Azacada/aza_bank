-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ BY AZA#6666 ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("AZA:Retirer")
AddEventHandler("AZA:Retirer", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getAccount('bank').money
    
    if xMoney >= total then

    xPlayer.removeAccountMoney('bank', total)
    xPlayer.addMoney(total)
 
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'FLEECA', "Vous avez retiré ~g~"..total.." $ .", 'CHAR_BANK_FLEECA', 8)
    else
         TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas toute cette somme d\'argent !")
    end    
end) 

RegisterServerEvent("AZA:Deposer")
AddEventHandler("AZA:Deposer", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getMoney()
    
    if xMoney >= total then

    xPlayer.addAccountMoney('bank', total)
    xPlayer.removeMoney(total)
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'FLEECA', "Vous avez déposer ~g~ "..total.." $", 'CHAR_BANK_FLEECA', 8)
    else
         TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas toute cette somme d\'argent !")
    end    
end)

