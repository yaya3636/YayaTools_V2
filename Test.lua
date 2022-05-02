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
    local dic = Tools.dictionnary()
    local list = Tools.list()

    for i = 0, 10 do
        dic:Add("test" .. i, i)
        list:Add(i * 10)
    end

    dic:Foreach(function(v, k)
        Tools:Print("Value : " .. v .. " Key : " .. k)
    end)

    list:Foreach(function(v, i)
        Tools:Print("Value : " .. v .. " Index : " .. i)
    end)

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

API = API()
Craft = Craft({api = API})
Monsters = Monsters({api = API})
Zone = Zone({api = API})
Packet = Packet()
Gather = Gather({packet = Packet})
Character = Character({packet = Packet})
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()