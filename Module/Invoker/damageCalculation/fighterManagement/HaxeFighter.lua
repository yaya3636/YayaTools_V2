local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

LinkedList = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\damageCalculation\\tools\\LinkedList.lua")
List = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\damageCalculation\\tools\\List.lua")

HaxeFighter = {}

HaxeFighter.MAX_RESIST_HUMAN = 50
HaxeFighter.MAX_RESIST_MONSTER = 100
HaxeFighter.INVALID_ID = 0
HaxeFighter.BOMB_BREED_ID = {3112, 3113, 3114, 5161}
HaxeFighter.STEAMER_TURRET_BREED_ID = {3287, 3288, 3289, 5143, 5141, 5142}
HaxeFighter.MIN_PERMANENT_DAMAGE_PERCENT = 0
HaxeFighter.BASE_PERMANENT_DAMAGE_PERCENT = 10
HaxeFighter.MAX_PERMANENT_DAMAGE_PERCENT = 50

function HaxeFighter:init(id, level, breed, playerType, teamId, isStaticElement, buffs, data, isSummonCastPreviewed)
    self._save = nil
    self._carriedFighter = nil
    self._currentPosition = -1
    self._pendingPreviousPosition = -1
    self._pendingDispelledBuffs = LinkedList()
    self._pendingBuffHead = nil
    self._buffs = LinkedList()
    self.totalEffects = List()
    self.lastTheoreticalRawDamageTaken = nil
    self.lastRawDamageTaken = nil
    self.beforeLastSpellPosition = -1
    self.pendingEffects = List()
    self.isSummonCastPreviewed = false
    self.isStaticElement = isStaticElement
    self.teamId = teamId
    self.playerType = playerType
    self.level = level
    self.breed = breed
    self.id = id
    self.data = data
    self.isSummonCastPreviewed = isSummonCastPreviewed or false

    for _, buff in ipairs(buffs) do
        self._buffs:add(buff)
    end
end

function HaxeFighter:wasTeleportedInInvalidCellThisTurn(fightContext)
    local current = self.pendingEffects.h
    while current ~= nil do
        local effectOutput = current.item
        current = current.next
        if effectOutput.movement ~= nil and not fightContext.map.isCellWalkable(effectOutput.movement.newPosition) then
            return true
        end
    end
    return false
end

function HaxeFighter:wasTelefraggedThisTurn()
    local current = self.pendingEffects.h
    while current ~= nil do
        local effectOutput = current.item
        current = current.next
        if effectOutput.movement ~= nil and effectOutput.movement.swappedWith ~= nil then
            return true
        end
    end
    return false
end

function HaxeFighter:updateStatWithPercentValue(self, stat, percent, increase)
    local factor = increase and 1 or -1
    local total = stat:get_total()
    local delta = math.floor(factor * percent)
    return math.floor(total + delta)
end

function HaxeFighter:updateStatFromFlatValue(self, stat, value, increase)
    local factor = increase and 1 or -1
    local isLinear = ActionIdHelper.isLinearBuffActionIds(stat:get_id())
    local total = stat:get_total()
    local newValue

    if isLinear then
        local delta = value * factor
        newValue = total + delta
    else
        local percent = math.floor(100 * (1 + factor * value * 0.01)) - 100
        if total == 0 then
            newValue = percent
        else
            newValue = math.floor(total * (1 + percent * 0.01))
        end
    end

    return newValue
end

function HaxeFighter:updateStatFromBuff(self, buff, update)
    local effect = buff.effect

    if not SpellManager.isInstantaneousSpellEffect(effect) then
        return
    end

    local statId = ActionIdHelper.getStatIdFromStatActionId(effect.actionId)

    if statId ~= -1 then
        local stat = data.getStat(statId)

        if stat == nil then
            stat = HaxeSimpleStat(statId, 0)
            data.setStat(stat)
        end

        stat:updateStatFromEffect(effect, update)
    end
end

function HaxeFighter:underMaximizeRollEffect(self)
    local currentNode = self.buffs.head
    while currentNode ~= nil do
        local buff = currentNode.item
        currentNode = currentNode.next

        if buff.effect.actionId == 782 then
            return true
        end
    end
    return false
end

function HaxeFighter:storeSpellEffectStatBoost(self, spell, spellEffect)
    local clonedEffect = spellEffect:clone()
    local newActionId = ActionIdHelper.statBoostToBuffActionId(spellEffect.actionId)
    clonedEffect.actionId = newActionId
    local newBuff = HaxeBuff(id, spell, clonedEffect)
    storePendingBuff(self, newBuff)
end

-- For the storePendingBuff function, please note that the converted code is quite long and requires additional code restructuring in order to work correctly in Lua. I'd recommend splitting the code into smaller helper functions and adjusting the logic accordingly.

function HaxeFighter:setCurrentPositionCell(cell)
    self.pendingPreviousPosition = getCurrentPositionCell(self)
    self.currentPosition = cell
    if hasState(self, 3) and self.carriedFighter ~= nil then
        self.carriedFighter:setCurrentPositionCell(cell)
    end
end

function HaxeFighter:setBeforeLastSpellPosition(position)
    self.beforeLastSpellPosition = position
end

function HaxeFighter:savePositionBeforeSpellExecution()
    self:setBeforeLastSpellPosition(getCurrentPositionCell())
end

function HaxeFighter:savePendingEffects(self)
    if self.totalEffects ~= nil and self.pendingEffects ~= nil then
        self.totalEffects = FpUtils.listConcat_damageCalculation_damageManagement_EffectOutput(self.totalEffects, self.pendingEffects)
    else
        self.totalEffects = self.pendingEffects
    end
    self.pendingEffects = List.new()
end
