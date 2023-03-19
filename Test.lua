Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Craft = Tools.craft
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character
Gather = Tools.gather
Monsters = Tools.monsters
Memory = Tools.memory
IA = Tools.ia
Json = Tools.json()
-- EffectElement (agilité = 4, intelligence = 2, chance = 3, force = 1)
ElementEnum = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\tools\\enumeration\\ElementEnum.lua")()
HaxeSpellEffect = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\DamageCalculation\\SpellManagement\\HaxeSpellEffect.lua")
LinkedList = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\DamageCalculation\\tools\\LinkedList.lua")
List = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\DamageCalculation\\tools\\List.lua")
MapTools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\mapTools\\MapTools.lua")()
SpellZone = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\mapTools\\SpellZone.lua")()

function move()
    local spell = IA:GetSpellInfo(13110)
    local sz = SpellZone:fromRawZone(spell:Get(1).effects:Get(1).rawZone)
    Tools:Dump(sz.getCells(234, 234))

    -- local l1 = List()

    -- l1:add("Test1")
    -- l1:add("Test2")
    -- l1:add("Test3")
    -- l1:add("Test4")
    -- l1:add("Test5")

    -- Tools:Dump(l1)
    --Tools:Dump(Character:GetStats())
    --local damage = IA:CalculSpellDamage(13047)
    --Tools:Print("Estimation minimal des dégats du sort = " .. damage)
    --Tools:Dump(IA:GetFightEntity())
end

function bank()
    Tools:Print("Full pods")
end

function stopped()
end

function messagesRegistering()
    Character:InitCallBack()
    Character.dialog:InitCallBack()
    Character.group:InitCallBack()
    Movement:InitCallBack()
    Gather:InitCallBack()
    IA:InitCallBack()
end

function fightManagement()
    local entities = fightAction:getAllEntities()
    for _, entity in ipairs(entities) do
        Tools:Print("Dégats minimal sur l'entité : " .. entity.Id .. " = " .. IA:CalculSpellDamage(13047, entity) .. " points de dégats")
    end
end


Memory = Memory({ instanceUID = "Test", clearAll = true })
Craft = Craft()
Monsters = Monsters()
Zone = Zone()
Packet = Packet()
Gather = Gather({ packet = Packet })
Character = Character({ packet = Packet, memory = Tools.memory })
Movement = Movement({ zone = Zone, packet = Packet, character = Character })
IA = IA({ character = Character, packet = Packet })
Tools = Tools()