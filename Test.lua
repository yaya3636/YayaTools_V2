Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character


function move()
    local list = Tools.list({1, 2, 3, 4, 5, 6, 7, 8, 9, 10})
    Tools:Dump(list:Enumerate())
    list:Shuffle()
    Tools:Dump(list:Enumerate())

    local dic = Tools.dictionnary({["Test1"] = "Test1", ["Test2"] = "Test2", ["Test3"] = "Test3", ["Test4"] = "Test4",})
    Tools:Dump(dic:Enumerate())
    Tools:Print(dic:Size())
    dic:Shuffle()
    Tools:Dump(dic:Enumerate())

    --Movement:RoadZone(Zone:GetAreaMapId(45))
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