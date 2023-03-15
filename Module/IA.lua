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
    local ret = self.tools.list()
    local d2 = d2data:allObjectsFromD2O("SpellLevels")
    local function constructData(d)
        local r = self.tools.object()
        for k, v in pairs(d) do
            if k == "effects" or k == "criticalEffect" then
                r[k] = self.tools.list()
                for _, lst in pairs(v) do
                    local obj = self.tools.object(lst.Fields)
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


function IA:CalculSpellDamage(spellId, entity)

end

return IA