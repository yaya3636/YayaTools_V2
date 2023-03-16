IA = {}

-- Character info

IA.characterLevel = 0
IA.characterMaxLifePoints = 0
IA.characterBreed = 0
IA.characterBreedName = ""
IA.characterStats = {}

-- Combat en cours

IA.fightEntity = {}

function IA:GetFightEntity()
    return self.fightEntity
end

-- Spell

function IA:CalculDamage(baseDamage, totalCaracElem, pui, bonusDamage, percentResistance, fixeResistance)
    local totalDamage = ((baseDamage * (100 + totalCaracElem + pui) / 100 + bonusDamage) - fixeResistance ) * (1 - (percentResistance / 100))
    if totalDamage < 0 then
        totalDamage = 0
    end
    return math.ceil(totalDamage)
    -- local totalDamage = baseDamage + baseDamage * (( pui + totalCaracElem ) / 100 ) + bonusDamage * -1
    -- local realDamage = totalDamage - fixeResistance - ((totalDamage / 100 / percentResistance) * 100)
    -- return realDamage
end

function IA:GetSpellInfo(spellId)
    local ret = Tools.list()
    local d2 = d2data:allObjectsFromD2O("SpellLevels")
    local function constructData(d)
        local r = Tools.object()
        for k, v in pairs(d) do
            if k == "effects" or k == "criticalEffect" then
                r[k] = Tools.list()
                for _, lst in pairs(v) do
                    local obj = Tools.object(lst.Fields)
                    --self.tools:Dump(lst.Fields)
                    -- for k2, v2 in pairs(lst.Fields) do
                    --     obj[k2] = v2
                    -- end
                    r[k]:Add(obj)
                end
            else
                r[k] = v
            end
        end
        return r
    end

    for _, v in pairs(d2) do
        if v.Fields.spellId == spellId then
            ret:Add(constructData(v.Fields))
        end
    end

    -- local str = developer:getRequestThroughMyIP("http://localhost:5000/getSpell/" .. spellId)
    -- local ret = self.json:decode(str)
    return ret
end

function IA:GetActualSpellLevel(spellId)
    local spellInfo = self:GetSpellInfo(spellId)
    local ret
    for _, v in pairs(spellInfo:Enumerate()) do
        if v.minPlayerLevel < character:level() then
            ret = v
        else
            break
        end
    end
    return ret
end

function IA:CalculSpellDamage(spellId, entity)
    local totalDamage = 0
    local stats = self.character:GetStats()
    Tools:Dump(stats)
    if entity then
        
    else
        local spell = self:GetActualSpellLevel(spellId)

        for _, v in pairs(spell.effects:Enumerate()) do
            if self.actionIds:Get(v.effectId) == "ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_AIR" then
                Tools:Print("Dégat air min = " .. v.diceNum .. " | Dégat air max = " .. v.diceSide)
                local stat = tonumber(stats:Get("agility"))
                local damagePercent = tonumber(stats:Get("damagePercent"))
                local allDamageBonus = tonumber(stats:Get("allDamageBonus"))
                local damageBonus = tonumber(stats:Get("airDamageBonus"))
                Tools:Print(stat .. " | " .. damagePercent .. " | " .. allDamageBonus .. " | " .. damageBonus)
                totalDamage = totalDamage + self:CalculDamage(v.diceNum, stat, damagePercent, allDamageBonus + damageBonus, 0, 0)
            elseif self.actionIds:Get(v.effectId) == "ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_FIRE" then
                Tools:Print("Dégat feu min = " .. v.diceNum .. " | Dégat feu max = " .. v.diceSide)
            elseif self.actionIds:Get(v.effectId) == "ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_WATER" then
                Tools:Print("Dégat eau min = " .. v.diceNum .. " | Dégat eau max = " .. v.diceSide)
            elseif self.actionIds:Get(v.effectId) == "ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_EARTH" then
                Tools:Print("Dégat terre min = " .. v.diceNum .. " | Dégat terre max = " .. v.diceSide)
            elseif self.actionIds:Get(v.effectId) == "ACTION_CHARACTER_LIFE_POINTS_LOST" then
                Tools:Print("Dégat neutre min = " .. v.diceNum .. " | Dégat neutre max = " .. v.diceSide)
            end
        end
    end
    return totalDamage
end


-- CallBack

function IA:InitCallBack() -- A mettre obligatoirement dans le script charger par Ankabot
    local gameFightShowFighterMessage = function(msg) IA:CB_GameFightShowFighterMessage(msg) end
    local gameFightEndMessage = function(msg) IA:CB_GameFightEndMessage(msg) end

    self.packet:SubManager({
        ["GameFightShowFighterMessage"] = gameFightShowFighterMessage,
        ["GameFightEndMessage"] = gameFightEndMessage,

    })

end

function IA:CB_GameFightShowFighterMessage(msg)
    --Tools:Dump(msg)
    --Tools:Dump(msg.informations.stats.characteristics.characteristics)
    if tostring(msg.informations) == "SwiftBot.GameFightMonsterInformations" then
        local obj = Tools.object()

        obj.creatureGenericId = msg.informations.creatureGenericId
        obj.contextualId = msg.informations.contextualId
        obj.creatureLevel = msg.informations.creatureLevel
        obj.creatureGrade = msg.informations.creatureGrade
        obj.cellId = msg.informations.disposition.cellId
        obj.stats = Tools.dictionnary()

        for _, v in pairs(msg.informations.stats.characteristics.characteristics) do
            obj.stats:Add(self.character.ENUM_STATS:Get(tostring(v.characteristicId)), v.total)
            --Tools:Print("Name : " .. self.character.ENUM_STATS:Get(tostring(v.characteristicId)) .. " | Value : " ..v.total)
        end

        self.fightEntity:Add(obj)
        --Tools:Dump(self.fightEntity)
    end
end

function IA:CB_GameFightEndMessage()
    self.fightEntity:Clear()
end

return IA