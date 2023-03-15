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
    local str = developer:getRequestThroughMyIP("http://localhost:5000/getSpell/" .. spellId)
    local ret = self.json:decode(str)
    return ret
end


function IA:CalculSpellDamage(spellId, entity)

end

return IA