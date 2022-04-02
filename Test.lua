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
    local stack = Tools.stack()
    stack:Push("1")
    stack:Push("2")
    stack:Push("3")
    stack:Push("4")
    stack:Push("5")
    stack:Push("6")

    local listStack = stack:ToList()
    Tools:Dump(listStack)

    for _ = 1, stack:Size() do
        Tools:Print(stack:Pop())
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