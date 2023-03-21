local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

SlotDataHolderManager = dofile(yayaToolsModuleDirectory .. "\\Invoker\\com\\ankamagames\\berilia\\managers\\SlotDataHolderManager.lua")

SpellWrapper = Class("SpellWrapper")

local _cache = {}
local _playersCache = {}
local _cac = nil
local _errorIconUri = nil

local BASE_DAMAGE_EFFECT_IDS = {100, 96, 97, 98, 99, 92, 93, 94, 95, 1012, 1013, 1014, 1015, 1016}
local INFINITE_VALUE = 63

function SpellWrapper:init()
    self._uri = nil
    self._slotDataHolderManager = nil
    self._canTargetCasterOutOfZone = nil
    self._variantActivated = false
    self._spellLevel = nil
    self._spell = nil
    self._isActiveOutsideTurn = false
    self.id = 0
    self.spellLevel = 1
    self.effects = {}
    self.criticalEffect = {}
    self.gfxId = 0
    self.playerId = 0
    self.versionNum = 0
    self._actualCooldown = 0
end

function SpellWrapper.create(spellID, spellLevel, useCache, playerId, variantActivated, areModifiers, isActiveOutsideTurn)
    spellLevel = spellLevel or 0
    useCache = useCache or true
    playerId = playerId or 0
    variantActivated = variantActivated or false
    areModifiers = areModifiers or true
    isActiveOutsideTurn = isActiveOutsideTurn or false

    local spell = nil

    if spellID == 0 then
        useCache = false
    end

    if useCache then
        if _cache[spellID] and playerId == 0 then
            spell = _cache[spellID]
        elseif _playersCache[playerId] and _playersCache[playerId][spellID] then
            spell = _playersCache[playerId][spellID]
        end
    end

    if spellID == 0 and _cac ~= nil then
        spell = _cac
    end

    if not spell then
        spell = SpellWrapper()
        spell.id = spellID

        if useCache then
            if playerId ~= 0 then
                if not _playersCache[playerId] then
                    _playersCache[playerId] = {}
                end

                if not _playersCache[playerId][spellID] then
                    _playersCache[playerId][spellID] = spell
                end
            else
                _cache[spellID] = spell
            end
        end

        spell._slotDataHolderManager = SlotDataHolderManager(spell)
    end

    if spellID ~= 0 or not _cac then
        if spellID == 0 then
            _cac = spell
        end

        spell.id = spellID
        spell.gfxId = spellID
        spell.variantActivated = variantActivated
    end

    spell.playerId = playerId

    -- Note: Vous devrez implémenter la classe Spell en Lua
    -- local spellData = Spell.getSpellById(spellID)
    local spellData = nil

    if not spellData then
        return nil
    end

    if spellLevel == 0 then
        -- Note: Vous devrez implémenter updateSpellLevelAccordingToPlayerLevel en Lua
        -- spell:updateSpellLevelAccordingToPlayerLevel()
    else
        spell.spellLevel = spellLevel
        -- Note: Vous devrez implémenter getSpellLevel en Lua
        -- spell._spellLevel = spellData:getSpellLevel(spell.spellLevel)
    end

    -- Note: Vous devrez implémenter setSpellEffects en Lua
    -- spell:setSpellEffects(areModifiers)
    spell._isActiveOutsideTurn = isActiveOutsideTurn

    return spell
end
