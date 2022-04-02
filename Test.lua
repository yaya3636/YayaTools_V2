Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Craft = Tools.craft
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character
Gather = Tools.gather
API = Tools.api
Monsters = Tools.monsters


function move()
    local q = Tools.queue()
    --Tools:Print(q.node)
    q:Enqueue("1")
    q:Enqueue("2")
    q:Enqueue("3")
    q:Enqueue("4")
    q:Enqueue("5")
    q:Enqueue("6")
    for i = 1, q.N do
        Tools:Print(q:Dequeue())
    end
end

function messagesRegistering()
    Character.dialog:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
end


API = API()
Craft = Craft({api = API})
Monsters = Monsters({api = API})
--Zone = Zone()
Packet = Packet()
Gather = Gather({packet = Packet})
Character = Character({packet = Packet})
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()