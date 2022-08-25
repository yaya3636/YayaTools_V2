Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Craft = Tools.craft
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character
Gather = Tools.gather
API = Tools.api
Monsters = Tools.monsters
Memory = Tools.memory

function move()
    Memory:Add("test", 1)
    Memory:Add("test1", 2)
    Memory:Add("test2", 3)
    Memory:Add("test3", 4)
    Memory:Add("test4", 5)
    Memory:Add("test5", 6)

    Memory:Remove("test5")
    Tools:Dump(Memory:Enumerate())
    --Memory:Clear()
    Memory:KillInstance()
end

function stopped()
end

function messagesRegistering()
    Character.dialog:InitCallBack()
    Character.group:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
end

Memory = Memory({instanceUID = "Test", bindInstance = true})
API = API()
Craft = Craft({api = API})
Monsters = Monsters({api = API})
Zone = Zone({api = API})
Packet = Packet()
Gather = Gather({packet = Packet})
Character = Character({packet = Packet})
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()