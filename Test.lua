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
    local dijkstra = Tools.dijkstra()
    dijkstra:Run(Movement.mineGraph, 97259013)
    Tools:Print(dijkstra:HasPathTo(97260043))

    local stackMap = dijkstra:GetPathTo(97260043)

    for i = 1, stackMap:Size() do
        Tools:Print(stackMap:Get(i):From() .. " to " .. stackMap:Get(i):To())
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
Zone = Zone({api = API})
Packet = Packet()
Gather = Gather({packet = Packet})
Character = Character({packet = Packet})
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()