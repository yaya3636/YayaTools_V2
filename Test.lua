Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character
function move()
    local listMapId = Tools.list({153881600, 153881601, 153881089, 153881088, 153880064, 153879552})
    --Tools:Print(Movement:InMapChecker(listMapId))
    Movement:RoadZone({})
end

function messagesRegistering()
    Movement:InitCallBack()
    Character.dialog:InitCallBack()
end

Zone = Zone()
Packet = Packet()
Character.dialog = Character.dialog({packet = Packet})
Character = Character()
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()