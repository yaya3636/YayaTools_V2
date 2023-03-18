local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

SpellManagement = {}

SpellManagement.EXCLUSIVE_MASKS_LIST = "*bBeEfFzZKoOPpTWUvVrRQq"
SpellManagement.TELEFRAG_STATE = 251

function SpellManagement:isSelectedByMask(param1, param2, param3, param4, param5)
    if param2 == nil or #param2 == 0 then
        return true
    end
    if param3 == nil then
        return false
    end
    if self:isIncludedByMask(param1, param2, param3) then
        return self:passMaskExclusion(param1, param2, param3, param4, param5)
    end
    return false
end

function SpellManagement:isIncludedByMask(param1, param2, param3) -- Param1 = HaxeFighter, param2 = array, param3 HaxeFighter
    local _loc5_ = false
    local _loc6_ = false
    local _loc8_
    local _loc9_
    local _loc4_ = param3.id == param1.id

    if _loc4_ then
        if (FindIndex(param2, "c") ~= -1) or (FindIndex(param2, "C") ~= -1) or (FindIndex(param2, "a") ~= -1) then
            return true
        end
    else
        _loc5_ = param1.teamId == param3.teamId
        _loc6_ = param3.data.isSummon()

        for _loc7_ = 1, #param2 do
            _loc8_ = tostring(param2[_loc7_])
            _loc9_ = _loc8_

            if _loc9_ == "A" then
                if not _loc5_ then
                    return true
                end
            elseif _loc9_ == "D" then
                if not _loc5_ and param3.playerType == 2 then
                    return true
                end
            elseif _loc9_ == "H" then
                if not _loc5_ and param3.playerType == 1 and not _loc6_ then
                    return true
                end
            elseif _loc9_ == "I" then
                if not _loc5_ and param3.playerType ~= 2 and _loc6_ and not param3.isStaticElement then
                    return true
                end
            elseif _loc9_ == "J" then
                if not _loc5_ and param3.playerType ~= 2 and _loc6_ then
                    return true
                end
            elseif _loc9_ == "L" then
                if not _loc5_ and ((param3.playerType == 1 and not _loc6_) or param3.playerType == 2) then
                    return true
                end
            elseif _loc9_ == "M" then
                if not _loc5_ and param3.playerType ~= 1 and not _loc6_ and not param3.isStaticElement then
                    return true
                end
            elseif _loc9_ == "S" then
                if not _loc5_ and param3.playerType ~= 2 and _loc6_ and param3.isStaticElement then
                    return true
                end
            else
                if _loc9_ ~= "a" and _loc9_ ~= "g" then
                    if _loc9_ == "d" then
                        if _loc5_ and param3.playerType == 2 then
                            return true
                        end
                    elseif _loc9_ == "h" then
                        if _loc5_ and param3.playerType == 1 and not _loc6_ then
                            return true
                        end
                    elseif _loc9_ == "i" then
                        if _loc5_ and param3.playerType ~= 2 and _loc6_ and not param3.isStaticElement then
                            return true
                        end
                    elseif _loc9_ == "j" then
                        if _loc5_ and param3.playerType ~= 2 and _loc6_ then
                            return true
                        end
                    elseif _loc9_ == "l" then
                        if _loc5_ and ((param3.playerType == 1 and not _loc6_) or param3.playerType == 2) then
                            return true
                        end
                    elseif _loc9_ == "m" then
                        if _loc5_ and param3.playerType ~= 1 and not _loc6_ and not param3.isStaticElement then
                            return true
                        end
                    elseif _loc9_ == "s" then
                        if _loc5_ and param3.playerType ~= 2 and _loc6_ and param3.isStaticElement then
                            return true
                        end
                    end
                else
                    if _loc5_ then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function SpellManagement:splitMasks(param1)
    local _loc2_ = {}
    local _loc3_ = 1
    local _loc4_ = 1

    while _loc3_ <= #param1 do
        while string.sub(param1, _loc3_, _loc3_) == " " or string.sub(param1, _loc3_, _loc3_) == "," do
            _loc3_ = _loc3_ + 1
        end
        _loc4_ = _loc3_
        while _loc4_ <= #param1 and string.sub(param1, _loc4_, _loc4_) ~= "," do
            _loc4_ = _loc4_ + 1
        end
        if _loc4_ ~= _loc3_ then
            table.insert(_loc2_, string.sub(param1, _loc3_, _loc4_ - 1))
        end
        _loc3_ = _loc4_
    end

    return _loc2_
end

function SpellManagement:maskIsOneOfCondition(param1)
    local _loc2_ = param1:sub(1, 1) == "*" and param1:sub(2, 2) or param1:sub(1, 1)

    if _loc2_ ~= "B" and _loc2_ ~= "F" and _loc2_ ~= "Z" then
        return false
    end

    return true
end

function SpellManagement:passMaskExclusion(param1, param2, param3, param4, param5)
    local _loc8_, _loc9_, _loc10_
    local _loc6_ = param5.usingPortal()
    local _loc7_ = 1

    while _loc7_ <= #param2 do
        _loc8_ = tostring(param2[_loc7_])
        _loc7_ = _loc7_ + 1

        if string.find("*bBeEfFzZKoOPpTWUvVrRQq", _loc8_:sub(1, 1), 1, true) then
            if _loc8_:byte(1) == ("*"):byte(1) then
                _loc9_ = param1
                _loc10_ = true
            else
                _loc9_ = param3
                _loc10_ = false
            end

            if not self:targetPassMaskExclusion(param1, _loc9_, param4, param5, _loc8_, param2, _loc6_, _loc10_) then
                return false
            end
        end
    end

    return true
end

function SpellManagement:targetPassMaskExclusion(param1, param2, param3, param4, param5, param6, param7, param8)
    local caster = param1
    local _loc9_ = param8 and 1 or 0
    local _loc10_ = nil
    local _loc12_ = false

    if #param5 == _loc9_ + 1 then
        _loc10_ = tonumber(param5:sub(_loc9_ + 1))
    else
        _loc10_ = 0
    end

    local _loc11_ = param5:sub(_loc9_, _loc9_)
    local _loc13_ = _loc11_

    if _loc13_ == "B" then
        _loc12_ = param2.playerType == 1 and param2.breed == _loc10_
    elseif _loc13_ == "E" then
        _loc12_ = param2:hasState(_loc10_)
    elseif _loc13_ == "F" then
        _loc12_ = param2.playerType ~= 1 and param2.breed == _loc10_
    elseif _loc13_ == "K" then
        _loc12_ = param2:hasState(8) and caster:getCarried(param4) == param2 or param2:isThrownByCaster(caster)
    elseif _loc13_ == "P" then
        _loc12_ = param2.id == caster.id or param2.data:isSummon() and param2.data:getSummonerId() == caster.id or param2.data:isSummon() and caster.data:getSummonerId() == param2.data:getSummonerId() or caster.data:isSummon() and caster.data:getSummonerId() == param2.id
    elseif _loc13_ == "Q" then
        _loc12_ = param4:getFighterCurrentSummonCount(param2) >= param2.data:getCharacteristicValue(26)
    elseif _loc13_ == "R" then
        _loc12_ = param7
    elseif _loc13_ == "T" then
        _loc12_ = param2:wasTelefraggedThisTurn()
    elseif _loc13_ == "U" then
        _loc12_ = param2:isAppearing()
    elseif _loc13_ == "V" then
        local _loc14_ = param2:getPendingLifePoints().min / param2.data:getMaxHealthPoints() * 100
        _loc12_ = _loc14_ <= _loc10_
    elseif _loc13_ == "W" then
        _loc12_ = param2:wasTeleportedInInvalidCellThisTurn(param4)
    elseif _loc13_ == "Z" then
        _loc12_ = param2.playerType == 2 and param2.breed == _loc10_
    elseif _loc13_ == "b" then
        _loc12_ = param2.playerType ~= 1 or param2.breed ~= _loc10_
    elseif _loc13_ == "e" then
        _loc12_ = not param2:hasState(_loc10_)
    elseif _loc13_ == "f" then
        _loc12_ = param2.playerType == 1 or param2.breed ~= _loc10_
    elseif _loc13_ == "O" then
        _loc12_ = param3 ~= nil and param2.id == param3.id
    elseif _loc13_ == "o" then
        _loc12_ = param3 == nil or param2.id ~= param3.id
    elseif _loc13_ == "p" then
        _loc12_ = not (param2.id == caster.id or param2.data:isSummon() and param2.data:getSummonerId() == caster.id or param2.data:isSummon() and caster.data:getSummonerId() == param2.data:getSummonerId() or caster.data:isSummon() and caster.data:getSummonerId() == param2.id)
    elseif _loc13_ == "q" then
        _loc12_ = param4:getFighterCurrentSummonCount(param2) < param2.data:getCharacteristicValue(26)
    elseif _loc13_ == "r" then
        _loc12_ = not param7
    elseif _loc13_ == "v" then
        local _loc14_ = param2:getPendingLifePoints().min / param2.data:getMaxHealthPoints() * 100
        _loc12_ = _loc14_ > _loc10_
    elseif _loc13_ == "z" then
        _loc12_ = param2.playerType ~= 2 or param2.breed ~= _loc10_
    end

    if self:maskIsOneOfCondition(param5) then
        local _loc15_ = FindIndex(param6, param5) + 1
        if _loc12_ then
            local _loc16_ = _loc15_
            local _loc17_ = #param6
            while _loc16_ < _loc17_ do
                local _loc18_ = _loc16_ + 1
                if tostring(param6[_loc18_]):byte(_loc9_) == param5:byte(_loc9_) then
                    param6[_loc18_] = " "
                end
            end
        else
            local _loc16_ = _loc15_
            local _loc17_ = #param6
            while _loc16_ < _loc17_ do
                local _loc18_ = _loc16_ + 1
                if tostring(param6[_loc18_]):byte(_loc9_) == param5:byte(_loc9_) then
                    _loc12_ = true
                    break
                end
            end
        end
    end

    return _loc12_
end

function SpellManagement:isInstantaneousSpellEffect(haxeSpellEffect)
    if haxeSpellEffect.triggers == nil or FindIndex(haxeSpellEffect.triggers, "I") ~= nil then
        return true
    end
    return false
end

function FindIndex(tbl, value)
    for i, v in ipairs(tbl) do
        if v == value then
            return i
        end
    end
    return -1
end

return Class("SpellManagement", SpellManagement)