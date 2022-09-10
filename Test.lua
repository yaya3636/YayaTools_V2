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
    if map:loadMove(5, 5) then
        local loadedRoad = map:getLoadedRoad()
        Tools:Print(loadedRoad)
    end
end

function stopped()
end

function messagesRegistering()
    Character.dialog:InitCallBack()
    Character.group:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
end

Memory = Memory({instanceUID = "Test", clearInstance = true})
API = API()
Craft = Craft({api = API})
Monsters = Monsters({api = API})
Zone = Zone({api = API})
Packet = Packet()
Gather = Gather({packet = Packet})
Character = Character({packet = Packet, memory = Tools.memory})
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()