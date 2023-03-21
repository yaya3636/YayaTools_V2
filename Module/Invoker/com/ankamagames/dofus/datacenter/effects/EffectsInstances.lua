EffectInstance = {}

local UNKNOWN_NAME = "???"
local IS_DISPELLABLE = 1
local IS_DISPELLABLE_ONLY_BY_DEATH = 2
local IS_NOT_DISPELLABLE = 3
local UNDEFINED_CATEGORY = -2
local UNDEFINED_SHOW = -1
local UNDEFINED_DESCRIPTION = "undefined"

function EffectInstance:init()
    self.effectUid = 0
    self.baseEffectId = 0
    self.effectId = 0
    self.order = 0
    self.targetId = 0
    self.targetMask = ""
    self.duration = 0
    self.delay = 0
    self.random = 0
    self.group = 0
    self.modificator = 0
    self.trigger = false
    self.triggers = ""
    self.visibleInTooltip = true
    self.visibleInBuffUi = true
    self.visibleInFightLog = true
    self.visibleOnTerrain = true
    self.forClientOnly = false
    self.dispellable = 1
    self.zoneSize = nil
    self.zoneShape = 0
    self.zoneMinSize = nil
    self.zoneEfficiencyPercent = nil
    self.zoneMaxEfficiency = nil
    self.zoneStopAtTarget = nil
    self.effectElement = 0
    self.spellId = 0
    self._effectData = nil
    self._durationStringValue = 0
    self._delayStringValue = 0
    self._durationString = ""
    self._bonusType = -2
    self._oppositeId = -1
    self._category = -2
    self._description = "undefined"
    self._theoricDescription = "undefined"
    self._descriptionForTooltip = "undefined"
    self._theoricDescriptionForTooltip = "undefined"
    self._showSet = -1
    self._priority = 0
    self._rawZone = ""
    self._theoricShortDescriptionForTooltip = "undefined"
end

function EffectInstance:set_rawZone(data)
    self._rawZone = data
    self:parseZone()
end

