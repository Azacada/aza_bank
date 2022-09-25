local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

Conf              = {}
Conf.DrawDistance = 50
Conf.Size         = {x = 0.50, y = 0.50, z = 0.50}
Conf.Color        = {r = 207, g = 13, b = 113}
Conf.Type         = 29


local position = {
    {x = 150.266, y = -1040.203, z = 29.374},
    {x = -1212.980, y = -330.841, z = 37.787},
    {x = -2962.59, y = 482.5, z = 15.703},
    {x = -112.202, y = 6469.295, z = 31.626},
    {x = 314.187, y = -278.621, z = 54.170},
    {x = -351.534, y = -49.529, z = 49.042},
    {x = 241.727, y = 220.706, z = 106.286},
    {x = 1175.064, y = 2706.643, z = 38.094},	
}  


Citizen.CreateThread(function()
    for k in pairs(position) do
       local blip = AddBlipForCoord(position[k].x, position[k].y, position[k].z)
       SetBlipSprite(blip, 207)
       SetBlipColour(blip, 3)
       SetBlipScale(blip, 0.65)
       SetBlipAsShortRange(blip, true)

       BeginTextCommandSetBlipName('STRING')
       AddTextComponentString("Fleeca")
       EndTextCommandSetBlipName(blip)
   end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(position) do
            if (Conf.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < Conf.DrawDistance) then
                DrawMarker(Conf.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Conf.Size.x, Conf.Size.y, Conf.Size.z, Conf.Color.r, Conf.Color.g, Conf.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)


Banque = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_purple}, HeaderColor = {207, 13, 113}, Title = "Banque"},
    Data = { currentMenu = "Compte Banquaire" },
    Events = {
        
        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)

            if btn.name == "Mon compte" then

                Banque.Menu["Mon compte"].b = {}

                table.insert(Banque.Menu["Mon compte"].b, {name = "Détenteur du compte :", ask = ""..GetPlayerName(PlayerId()).."", askX = true})
                table.insert(Banque.Menu["Mon compte"].b, {name = "Déposer", ask = "→", askX = true})
                table.insert(Banque.Menu["Mon compte"].b, {name = "Retirer", ask = "→", askX = true})


                local xPlayer = ESX.GetPlayerData()
                local money, bank = 0, 0
            
                for i = 1, #xPlayer.accounts, 1 do
                    if xPlayer.accounts[i].name == 'money' then
                        money = ESX.Math.GroupDigits(xPlayer.accounts[i].money)
                        table.insert(Banque.Menu["Mon compte"].b, {name = "Liquide :", ask = "~g~"..ESX.Math.GroupDigits(xPlayer.accounts[i].money).." $", askX = true})
                    elseif xPlayer.accounts[i].name == 'bank' then
                        bank = ESX.Math.GroupDigits(xPlayer.accounts[i].money)
                        table.insert(Banque.Menu["Mon compte"].b, {name = "Banque :", ask = "~b~"..ESX.Math.GroupDigits(xPlayer.accounts[i].money).." $", askX = true})
                    end
                end


                startScenario('WORLD_HUMAN_STAND_IMPATIENT')

                Citizen.Wait(1000) 
                ClearPedTasksImmediately(PlayerPedId())

                OpenMenu("Mon compte")
                
            end

            if btn.name == "Déconnexion" then

                CloseMenu("Compte Banquaire")
            end


            if btn.name == "Déposer" then


                deposer()
                OpenMenu("Compte Banquaire")
            end

            if btn.name == "Retirer" then
        
                retirer()
                OpenMenu("Compte Banquaire")

            end


        end,
    },

    Menu = {

        ["Compte Banquaire"] = {
            b = {
                {name = "Mon compte", ask = "→", askX = true},
                {name = "Déconnexion", ask = "→", askX = true},
            }
        }, 
        
        ["Mon compte"] = {    
            b = {
            }
        },
    }
} 


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à la banque")
                if IsControlJustPressed(1,51) then
                    CreateMenu(Banque)
                end   
            end
        end
    end
end)



