local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")
ElementEnum = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\tools\\enumeration\\ElementEnum.lua")()

HaxeSpellEffect = {}


function HaxeSpellEffect:init(id, level, order, actionId, param1, param2, param3, duration, isCritical, triggers, rawZone, masks, randomWeight, randomGroup, isDispellable, delay, category)
    self.id = id
    self.level = level
    self.order = order
    self.actionId = actionId
    self.param1 = param1
    self.param2 = param2
    self.param3 = param3
    self.duration = duration
    self.isCritical = isCritical
    --self.triggers = SpellManager.splitTriggers(triggers)
    self.rawZone = rawZone
    ---self.masks = SpellManager.splitMasks(masks)
    --table.sort(self.masks, HaxeSpellEffect.sortMasks)
    self.randomWeight = randomWeight
    self.randomGroup = randomGroup
    self.isDispellable = isDispellable
    self.delay = delay
    self.category = category
    --self.zone = SpellZone.fromRawZone(rawZone)
end

function HaxeSpellEffect.sortMasks(param1, param2)
    if string.find("*bBeEfFzZKoOPpTWUvVrRQq", string.sub(param1, 1, 1), 1, true) then
        if string.find("*bBeEfFzZKoOPpTWUvVrRQq", string.sub(param2, 1, 1), 1, true) then
            if string.byte(param1, 1) == string.byte("*") and string.byte(param2, 1) ~= string.byte("*") then
                return true
            end
            if string.byte(param2, 1) == string.byte("*") and string.byte(param1, 1) ~= string.byte("*") then
                return false
            end
        end
        return true
    end
    if string.find("*bBeEfFzZKoOPpTWUvVrRQq", string.sub(param2, 1, 1), 1, true) then
        return false
    end
    return false
end

function HaxeSpellEffect:isRandom()
    return self.randomWeight > 0
end

function HaxeSpellEffect:isAoe()
    return self.zone.radius >= 1
end

function HaxeSpellEffect:getRandomRoll()
    local minRoll = self:getMinRoll()
    local maxRoll = self:getMaxRoll()
    local randomNumber = math.random()
    local randomValue = randomNumber * (maxRoll - minRoll)
    return math.floor(minRoll + randomValue + 0.5)
end

function HaxeSpellEffect:getMinRoll()
    return self.param1 + self.param3
end

function HaxeSpellEffect:getMaxRoll()
    return self.param1 * self.param2 + self.param3
end

function HaxeSpellEffect:getElement()
    return ElementEnum.getElementFromActionId(self.actionId)
end

function HaxeSpellEffect:getDamageInterval()
    return Interval.new(self:getMinRoll(), self:getMaxRoll())
end

function HaxeSpellEffect:clone()
    local clone = HaxeSpellEffect.new(self.id, self.level, self.order, self.actionId, self.param1, self.param2, self.param3, self.duration, self.isCritical, "", self.rawZone, "", self.randomWeight,
    self.randomGroup, self.isDispellable, self.delay, self.category)
    clone.triggers = self.triggers
    clone.masks = self.masks
    return clone
end

return Class("HaxeSpellEffect", HaxeSpellEffect)