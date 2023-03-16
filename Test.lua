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

-- EffectElement (agilité = 4, intelligence = 2, chance = 3, force = 1)

function move()
    Tools:Dump(Character:GetStats())
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
end

IA = IA()
Memory = Memory({ instanceUID = "Test", clearAll = true })
Craft = Craft()
Monsters = Monsters()
Zone = Zone()
Packet = Packet()
Gather = Gather({ packet = Packet })
Character = Character({ packet = Packet, memory = Tools.memory })
Movement = Movement({ zone = Zone, packet = Packet, character = Character })
Tools = Tools()


    -- local spellEffect = IA:GetSpellInfo(13047):Get(2)
    -- local masks = {}
    -- for _, v in pairs(spellEffect.effects:Enumerate()) do
    --     local split = splitMasks(v.targetMask)
    --     table.insert(masks, split)
    --     Tools:Dump(split)
    --     table.sort(split, function(param1, param2)
    --         if string.find("bBeEfFzZKoOPpTWUvVrRQq", string.sub(param1, 1, 1), 1, true) then
    --             if string.find("bBeEfFzZKoOPpTWUvVrRQq", string.sub(param2, 1, 1), 1, true) then
    --                 if string.byte(param1, 1) == string.byte("") and string.byte(param2, 1) ~= string.byte("") then
    --                     return false
    --                 end
    --                 if string.byte(param2, 1) == string.byte("") and string.byte(param1, 1) ~= string.byte("") then
    --                     return true
    --                 end
    --             end
    --             return false
    --         end
    --         if string.find("*bBeEfFzZKoOPpTWUvVrRQq", string.sub(param2, 1, 1), 1, true) then
    --             return true
    --         end
    --         return false
    --     end)
    -- end
    --Tools:Dump(spellEffect.effects)
    -- local ENUM_STATS = {
    --     -- Stats
    --     ["128"] = "PM",
    --     ["117"] = "PO",
    --     ["111"] = "PA",
    --     ["125"] = "Vitalité",
    --     ["123"] = "Chance",
    --     ["124"] = "Sagesse",
    --     ["119"] = "Agilité",
    --     ["126"] = "Intelligence",
    --     ["118"] = "Force",

    --     -- Dommage
    --     ["422"] = "DTerre",
    --     ["424"] = "DFeu",
    --     ["426"] = "DEau",
    --     ["428"] = "DAir",
    --     ["138"] = "Puissance",

    --     -- Resistance
    --     ["214"] = "PResNeutre",
    --     ["210"] = "PResTerre",
    --     ["213"] = "PResFeu",
    --     ["211"] = "PResEau",
    --     ["212"] = "PResAir",

    --     -- Autres
    --     ["182"] = "Invocation",
    --     ["115"] = "PCritique",
    --     ["752"] = "Fuite",
    --     ["174"] = "Initiative",
    --     ["178"] = "Soin",

    --     -- Malus
    --     ["156"] = "MalusSagesse",
    --     ["153"] = "MalusVitalité",
    --     ["152"] = "MalusChance",
    --     ["157"] = "MalusForce",
    --     ["155"] = "MalusIntelligence",
    --     ["154"] = "MalusAgilité",
    -- }

    -- local iContent = inventory:inventoryContent()
    -- for _, item in ipairs(iContent) do

    --     for _, effect in pairs(item.effects) do
    --         Tools:Print(effect.value, effect.actionId)
    --     end
    -- end
    --Tools:Print(IA:GetCharacteristic(4))
    --local damage = IA:CalculSpellDamage(13047)