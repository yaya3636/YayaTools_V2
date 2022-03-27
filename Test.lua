Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character
Gather = Tools.gather
API = Tools.api
Monsters = Tools.monsters

function move()
    Tools:Dump(Monsters:GetMonstersInfoByGrade(31))
end

function messagesRegistering()
    Character.dialog:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
end


API = API()
Monsters = Monsters({api = API})
--Zone = Zone()
Packet = Packet()
Gather = Gather({packet = Packet})
Character.dialog = Character.dialog({packet = Packet})
Character = Character()
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()