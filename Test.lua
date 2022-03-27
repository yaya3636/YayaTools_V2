Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character
Gather = Tools.gather

function move()
    if not init then
        Gather:AddGatherElement(1)
        Gather:AddGatherElement(254, 1)
        Gather:AddGatherElement(38, 3)
        init = true
    end
    Gather:GatherByPriority()
    Movement:RoadZone(Zone:GetAreaMapId(45))
end

function messagesRegistering()
    Character.dialog:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
end

Zone = Zone()
Packet = Packet()
Gather = Gather({packet = Packet})
Character.dialog = Character.dialog({packet = Packet})
Character = Character()
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()