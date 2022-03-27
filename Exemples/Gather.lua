-- On récupere les tools et les différent module dont on aura besoin
Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Character = Tools.character
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Gather = Tools.gather

-- Gather:SetGatherPriority(gatherId, priority) Change la priorité d'un gatherId
-- Gather:RemoveGatherElement(gatherId) Supprime un gatherId de la récolte
-- Gather:ClearGatherElement() Supprime tout les gatherId de la récolte


-- Notre fonction Move
function move()
    if not init then
        Gather:AddGatherElement(1) -- On ajoute le gatherId du frêne il aura la priorité 1 (La plus haute)
        Gather:AddGatherElement(254, 1) -- On ajoute le gatherId de l'ortie en lui donnant la priorité 1, le frêne aura donc sa priorité changé qui passera a la priorité donner en paramètre + 1
        Gather:AddGatherElement(38, 3) -- On ajoute gatherId du blé en position 3, rien ne change pour le reste car nous avons pas plus de 3 gatherId a notre table
        init = true
    end


    Gather:GatherByPriority() -- On récolte par ordre de priorité et distance
    Gather:GatherByDist() -- On récolte par distance, element 1 au plus proche du perso, element 2 au plus proche de l'element 1 ect ect
    Movement:RoadZone(Zone:GetAreaMapId(45), Tools.list({152045573})) -- On move notre personnage dans tout incarnam
end

function messagesRegistering() -- Initialisation obligatoire des callBack
    Movement:InitCallBack()
    Gather:InitCallBack()
end

-- Instanciation des module, on instancie Zone, Packet, Character avant les autres car nous devons les passez en paramètre pour instancier Gather et Movement
Zone = Zone()
Packet = Packet()
Character.dialog = Character.dialog({packet = Packet})
Character = Character()
Gather = Gather({packet = Packet})
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()