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
    test()
    --Tools:Dump(Zone:GetSubAreaObject(Zone:GetSubAreaIdByMapId(153880322)))
    --Tools:Print(Zone:GetAreaName(8))
    --Tools:Print(Zone:GetAreaIdByMapId(153880322))
    --Tools:Print(Zone:GetAreaIdByMapId("153880322"))
end

function messagesRegistering()
    Character.dialog:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
end

function test()
    local i = 0
    while i ~= 100 do
        Tools:Print("Start")

        if global:isBoss() then
            Tools:Print("Je suis le boss")
        else
            Tools:Print("Je suis une mule")
        end
        i = i + 1
    end
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