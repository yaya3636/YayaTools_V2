Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Craft = Tools.craft
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character
Gather = Tools.gather
Monsters = Tools.monsters
Memory = Tools.memory
Sheduler1 = Tools.sheduler()
IA = Tools.ia()
Json = Tools.json()

function move()

    --local d2 = d2data:allObjectsFromD2O("Recipes")
    --Tools:Dump(d2[5].Fields.quantities)
    --Tools:Dump(d2data:objectFromD2O("Recipes", 62).Fields.quantities)
    --Tools:Dump(Zone:GetHarverstablePositionInSubArea(303, 1021))
    --Tools:Dump(d2data:objectFromD2O("Areas", 48).Fields)

    --Tools:Dump(Sheduler1)
    --Tools:Dump(IA:GetSpellInfo())
    --d2data:exportD2O("SpellLevels")
    --local data = Json:decode(Tools:ReadFile(global:getCurrentDirectory() .. "\\SpellLevels.json"), "Spell")
    Tools:Dump(IA:GetSpellInfo(2117):Enumerate())
    -- local d2 = d2data:allObjectsFromD2O("SpellLevels")
    -- for k, v in pairs(d2) do
    --     Tools:Print(v.Fields.id)
    -- end
end

function stopped()
end

function messagesRegistering()
    Character.dialog:InitCallBack()
    Character.group:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
end

Memory = Memory({instanceUID = "Test", clearAll = true})
Craft = Craft()
Monsters = Monsters()
Zone = Zone()
Packet = Packet()
Gather = Gather({packet = Packet})
Character = Character({packet = Packet, memory = Tools.memory})
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools()