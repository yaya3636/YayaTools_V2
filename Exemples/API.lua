Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character
Gather = Tools.gather
API = Tools.api.dofusDB

function move()
    if not init then
        mapIdToRoad = API.dofusDB:GetHarverstableMapIdInSubArea(303, 443) -- Retourne une list avec toutes les mapId contenant du frêne dans la sous zone forêt
        Gather:AddGatherElement(1) -- Ajout du frêne a la table de récolte
        init = true
    end
    Gather:GatherByPriority() -- Récolte
    Movement:RoadZone(mapIdToRoad) -- Movement vers les carte contenant le frêne
end

function messagesRegistering()
    Character.dialog:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
end


API = API()
Zone = Zone()
Packet = Packet()
Gather = Gather({packet = Packet})
Character.dialog = Character.dialog({packet = Packet})
Character = Character()
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()