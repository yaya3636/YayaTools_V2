HaxeSpell = {}
SpellManager = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\damageCalculation\\spellManagement\\SpellManager.lua")()

function HaxeSpell:init(id, effects, criticalEffects, level, canAlwaysTriggerSpells, isWeapon, minimaleRange, maximaleRange, criticalHitProbability, needsFreeCell, needsTakenCell, needsVisibleEntity, maxEffectsStack)
    self.canBeReflected = true
    self.isRune = false
    self.isGlyph = false
    self.isTrap = false
    self.isWeapon = false
    self._effects = effects
    self._criticalEffects = criticalEffects
    self.id = id
    self.minimaleRange = 1
    self.maximaleRange = 1
    self.level = level
    self.canAlwaysTriggerSpells = canAlwaysTriggerSpells
    self.isWeapon = isWeapon
    self.minimaleRange = minimaleRange
    self.maximaleRange = maximaleRange
    self.criticalHitProbability = criticalHitProbability
    self.needsFreeCell = needsFreeCell
    self.needsTakenCell = needsTakenCell
    self.needsVisibleEntity = needsVisibleEntity
    self.maxEffectsStack = maxEffectsStack or -1
end

function HaxeSpell:isImmediateDamageInflicted(isCritical)
    local effects = isCritical and self._criticalEffects or self._effects
    if self.isWeapon then
        return true
    end

    if not effects then
        return false
    end

    for _, effect in ipairs(effects) do
        if SpellManager:isInstantaneousSpellEffect(effect) and ActionIdHelper:isDamageInflicted(effect.actionId) then
            return true
        end
    end

    return false
end

function HaxeSpell:hasAtLeastOneRandomEffect()
    if self._effects then
        for _, effect in ipairs(self._effects) do
            if effect.randomWeight > 0 then
                return true
            end
        end
    end

    if self._criticalEffects then
        for _, effect in ipairs(self._criticalEffects) do
            if effect.randomWeight > 0 then
                return true
            end
        end
    end

    return false
end

function HaxeSpell:getEffects()
    return self._effects
end

function HaxeSpell:getEffectById(effectId)
    for _, effect in ipairs(self._effects) do
        if effect.id == effectId then
            return effect
        end
    end
    return nil
end

function HaxeSpell:getEffectByActionId(actionId)
    for _, effect in ipairs(self._effects) do
        if effect.actionId == actionId then
            return effect
        end
    end
    return nil
end

function HaxeSpell:getCriticalEffects()
    return self._criticalEffects
end

function HaxeSpell:getCriticalEffectById(effectId)
    for _, effect in ipairs(self._criticalEffects) do
        if effect.id == effectId then
            return effect
        end
    end
    return nil
end

function HaxeSpell:getCriticalEffectByActionId(actionId)
    for _, effect in ipairs(self._criticalEffects) do
        if effect.actionId == actionId then
            return effect
        end
    end
    return nil
end