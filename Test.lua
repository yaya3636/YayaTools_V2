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
    if character:name() == "Perso2" then
        Character.group:SendInvitation("Perso1")
    else
        Character.group:WaitInvitation("Perso1")
        global:delay(500)
        Character.group:Leave()
    end
end

function stopped()
    Tools:Dump(Character.group.members)
    Tools:Print(Character.inGroup)
end

function messagesRegistering()
    Character.dialog:InitCallBack()
    Character.group:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
end

API = API()
Craft = Craft({api = API})
Monsters = Monsters({api = API})
Zone = Zone({api = API})
Packet = Packet()
Gather = Gather({packet = Packet})
Character = Character({packet = Packet})
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()