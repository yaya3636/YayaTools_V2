Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character


function move()
    Movement:RoadZone(Zone:GetAreaMapId(45))
end

function messagesRegistering()
    Movement:InitCallBack()
    Character.dialog:InitCallBack()
end

local color = Tools.dictionnary()
color:Add("")

Zone = Zone()
Packet = Packet()
Character.dialog = Character.dialog({packet = Packet})
Character = Character()
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()