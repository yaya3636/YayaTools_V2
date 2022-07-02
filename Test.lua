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
    Memory:Add("test", "test")
    Memory:Add("test", "test")
    Memory:Clear()
    Memory:Add("test", "test")
    Memory:Add("tesdst", "test")
    Memory:Add("tedfcvxst", "test")
    Memory:Add("texcvst", "test")
    Memory:Add("tedfsvwxst", "test")
    Memory:Add("te<wxst", "test")
    Memory:Add("tesxcv<wvt", "test")

    Memory:Set("test", "u")
    Memory:Set("Test", "u")
    Tools:Print(Memory:ContainsKey("test"))
    Tools:Print(Memory:ContainsKey("tes"))
    Tools:Dump(Memory:Enumerate())
    Memory:Remove("test")
    Memory:Remove("tes")

end

function stopped()
end

function messagesRegistering()
    Character.dialog:InitCallBack()
    Character.group:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
end

Memory = Memory({clear = true})
API = API()
Craft = Craft({api = API})
Monsters = Monsters({api = API})
Zone = Zone({api = API})
Packet = Packet()
Gather = Gather({packet = Packet})
Character = Character({packet = Packet})
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()