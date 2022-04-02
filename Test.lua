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
    q:Enqueue("1")
    q:Enqueue("1")
    q:Enqueue("1")
    q:Enqueue("1")
    q:Enqueue("1")
    q:Enqueue("1")
    q:Enqueue("1")
    q:Enqueue("1")

    for _ = 1, q:Size() do
        --Tools:Print(q:Dequeue())
    end
    
    Tools:Print(q:Size())
    q:Clear()
    Tools:Print(q)
    Tools:Print(q:Size())

    for _ = 1, q:Size() do
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