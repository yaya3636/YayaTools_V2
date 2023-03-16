IA = {}

-- Character info

IA.characterLevel = 0
IA.characterMaxLifePoints = 0
IA.characterBreed = 0
IA.characterBreedName = ""
IA.characterStats = {}


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
    if entity then
        
    else
        local spell = self:GetActualSpellLevel(spellId)
        local totalDamage = 0

        for _, v in pairs(spell.effects:Enumerate()) do
            if v.effectElement > 0 and v.effectElement < 5 then
                
            end
        end
    end
end

function IA:GetCharacteristic(effectElement)
    local map = {
        [1] = function() return character:getStrenght() end,
        [2] = function() return character:getIntelligence() end,
        [3] = function() return character:getChance() end,
        [4] = function() return character:getAgilityBase() end
    }

    return map[effectElement]()
end

return IA