local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

Effect = Class("Effect")

function Effect:init(id)
    local d2Effects = d2data:objectFromD2O("Effects", id).Fields

    self.id = d2Effects.id
    self.descriptionId = d2Effects.descriptionId
    self.iconId = d2Effects.iconId
    self.characteristic = d2Effects.characteristic
    self.category = d2Effects.category
    self.operator = d2Effects.operator
    self.showInTooltip = d2Effects.showInTooltip
    self.useDice = d2Effects.useDice
    self.forceMinMax = d2Effects.forceMinMax
    self.boost = d2Effects.boost
    self.active = d2Effects.active
    self.oppositeId = d2Effects.oppositeId
    self.theoreticalDescriptionId = d2Effects.theoreticalDescriptionId
    self.theoreticalPattern = d2Effects.theoreticalPattern
    self.showInSet = d2Effects.showInSet
    self.bonusType = d2Effects.bonusType
    self.useInFight = d2Effects.useInFight
    self.effectPriority = d2Effects.effectPriority
    self.effectPowerRate = d2Effects.effectPowerRate
    self.elementId = d2Effects.elementId
end

function Effect:getEffectById(id)
    return self.c(id)
end

return Effect