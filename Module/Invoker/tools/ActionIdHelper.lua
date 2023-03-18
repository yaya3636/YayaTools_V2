ActionIdHelper = {
    STAT_BUFF_ACTION_IDS = {1027, 283, 293, 110, 118, 125, 2844, 123, 119, 126, 124, 422, 424, 426, 428, 430, 138, 112, 165, 1054, 414, 416, 418, 420, 1171, 2808, 2812, 2800, 2804, 2802, 2806, 2814, 2810, 178, 2872, 226, 225, 1166, 1167, 240, 243, 241, 242, 244, 1076, 111, 128, 1144, 182, 210, 211, 212, 213, 214, 117, 115, 174, 176, 1039, 1040, 220, 158, 161, 160, 752, 753, 776, 412, 410, 121, 150, 2846, 2848, 2852, 2850, 2854, 2856, 2858, 2860, 2836, 2838, 2840, 2834, 2842, 2844},
    STAT_DEBUFF_ACTION_IDS = {157, 153, 2845, 152, 154, 155, 156, 423, 425, 427, 429, 431, 186, 145, 415, 417, 419, 421, 1172, 2809, 2813, 2801, 2805, 2803, 2807, 2815, 2811, 179, 245, 248, 246, 247, 249, 1077, 168, 169, 215, 216, 217, 218, 219, 116, 171, 175, 177, 159, 163, 162, 754, 755, 413, 411, 2857, 2855, 2861, 2859, 2853, 2851, 2849, 2847, 2843, 2841, 2839, 2837, 2835},
    actionIdToStatNameMap = {},
    percentStatBoostActionIdToStat = {},
    flatStatBoostActionIdToStat = {},
    shieldActionIdToStatId = {}
}

function ActionIdHelper:isBasedOnCasterLife(actionId)
    return self:isBasedOnCasterLifePercent(actionId) or self:isBasedOnCasterLifeMidlife(actionId) or self:isBasedOnCasterLifeMissing(actionId) or self:isBasedOnCasterLifeMissingMaxLife(actionId)
end

function ActionIdHelper:isBasedOnCasterLifePercent(actionId)
    return actionId == 85 or actionId == 86 or actionId == 87 or actionId == 88 or actionId == 89 or actionId == 90 or actionId == 671
end

function ActionIdHelper:isBasedOnCasterLifeMissing(actionId)
    return actionId == 279 or actionId == 275 or actionId == 276 or actionId == 277 or actionId or actionId == 278
end

function ActionIdHelper:isBasedOnCasterLifeMissingMaxLife(actionId)
    return actionId == 1118 or actionId == 1121 or actionId == 1122 or actionId == 1119 or actionId == 1120
end

function ActionIdHelper:isBasedOnCasterLifeMidlife(actionId)
    return actionId == 672
end

function ActionIdHelper:isSplash(actionId)
    return self:isSplashDamage(actionId) or self:isSplashHeal(actionId)
end

function ActionIdHelper:isSplashDamage(actionId)
    return self:isSplashFinalDamage(actionId) or self:isSplashRawDamage(actionId)
end

function ActionIdHelper:isSplashFinalDamage(actionId)
    return actionId == 1223 or actionId == 1224 or actionId == 1225 or actionId == 1226 or actionId == 1227 or actionId == 1228
end

function ActionIdHelper:isSplashRawDamage(actionId)
    return actionId == 1123 or actionId == 1124 or actionId == 1125 or actionId == 1126 or actionId == 1127 or actionId == 1128
end

function ActionIdHelper:isSplashHeal(actionId)
    return actionId == 2020
end

function ActionIdHelper:isBasedOnMovementPoints(actionId)
    return actionId == 1012 or actionId == 1013 or actionId == 1016 or actionId == 1015 or actionId == 1014
end

function ActionIdHelper:isBasedOnTargetLifePercent(actionId)
    return actionId == 1071 or actionId == 1068 or actionId == 1070 or actionId == 1067 or actionId == 1069 or actionId == 1048
end

function ActionIdHelper:isTargetMaxLifeAffected(actionId)
    return actionId == 1037 or actionId == 153 or actionId == 1033 or actionId == 125 or actionId == 1078 or actionId == 610 or actionId == 267 or actionId == 2844 or actionId == 2845
end

function ActionIdHelper:isBasedOnTargetLife(actionId)
    return self:isBasedOnTargetLifePercent(actionId) or self:isBasedOnTargetMaxLife(actionId) or self:isBasedOnTargetLifeMissingMaxLife(actionId)
end

function ActionIdHelper:isBasedOnTargetMaxLife(actionId)
    return actionId == 1109
end

function ActionIdHelper:isBasedOnTargetLifeMissingMaxLife(actionId)
    return actionId == 1092 or actionId == 1095 or actionId == 1096 or actionId == 1093 or actionId == 1094
end

function ActionIdHelper:isBoostable(actionId)
    if actionId == 80 or actionId == 82 or actionId == 144 or actionId == 1063 or actionId == 1064 or actionId == 1065 or actionId == 1066 then
        return false
    end

    return not (self:isBasedOnCasterLife(actionId) or self:isBasedOnTargetLife(actionId) or self:isSplash(actionId))
end

function ActionIdHelper:isLifeSteal(actionId)
    return actionId == 95 or actionId == 2828 or actionId == 2890 or actionId == 82 or actionId == 92 or actionId == 94 or actionId == 91 or actionId == 93
end

function ActionIdHelper:isHeal(actionId)
    return actionId == 81 or actionId == 90 or actionId == 108 or actionId == 143 or actionId == 407 or actionId == 786 or actionId == 1037 or actionId == 1109 or actionId == 2020
end

function ActionIdHelper:isShield(actionId)
    return actionId == 1020 or actionId == 1039 or actionId == 1040
end

function ActionIdHelper:isTargetMarkDispell(actionId)
    return actionId == 2018 or actionId == 2019 or actionId == 2024
end

function ActionIdHelper:isStatBoost(actionId)
    return actionId == 266 or actionId == 268 or actionId == 269 or actionId == 270 or actionId == 271 or actionId == 414
end

function ActionIdHelper:statBoostToStatName(actionId)
    if actionId == 266 then
        return "chance"
    elseif actionId == 268 then
        return "agility"
    elseif actionId == 269 then
        return "intelligence"
    elseif actionId == 270 then
        return "wisdom"
    elseif actionId == 271 then
        return "strength"
    else
        return nil
    end
end

function ActionIdHelper:statBoostToBuffActionId(actionId)
    if actionId == 266 then
        return 123
    elseif actionId == 268 then
        return 119
    elseif actionId == 269 then
        return 126
    elseif actionId == 270 then
        return 124
    elseif actionId == 271 then
        return 118
    else
        return 0
    end
end

function ActionIdHelper:statBoostToDebuffActionId(actionId)
    if actionId == 266 then
        return 152
    elseif actionId == 268 then
        return 154
    elseif actionId == 269 then
        return 155
    elseif actionId == 270 then
        return 156
    elseif actionId == 271 then
        return 157
    else
        return -1
    end
end

function ActionIdHelper:isDamage(actionId, effectId)
    return actionId == 2 and effectId ~= 127 and effectId ~= 101
end

function ActionIdHelper:isPush(actionId)
    return actionId == 5 or actionId == 1021 or actionId == 1041 or actionId == 1103
end

function ActionIdHelper:isPull(actionId)
    return actionId == 6 or actionId == 1022 or actionId == 1042
end

function ActionIdHelper:isForcedDrag(actionId)
    return actionId == 1021 or actionId == 1022
end

function ActionIdHelper:isDrag(actionId)
    return self:isPush(actionId) or self:isPull(actionId)
end

function ActionIdHelper:allowCollisionDamage(actionId)
    return actionId == 5 or actionId == 1041
end

function ActionIdHelper:isSummon(actionId)
    if actionId == 181 or actionId == 780 or actionId == 1008 or actionId == 1097 or actionId == 1189 or self:isSummonWithSlot(actionId) then
        return true
    end
    return false
end

function ActionIdHelper:isSummonWithSlot(actionId)
    return actionId == 180 or actionId == 405 or actionId == 1011 or actionId == 1034 or actionId == 2796
end

function ActionIdHelper:isSummonWithoutTarget(actionId)
    return actionId == 180 or actionId == 181 or actionId == 780 or actionId == 1008 or actionId == 1011 or actionId == 1034 or actionId == 1097 or actionId == 1189
end

function ActionIdHelper:isKillAndSummon(actionId)
    return actionId == 405 or actionId == 2796
end

function ActionIdHelper:isRevive(actionId)
    return actionId == 780 or actionId == 1034
end

function ActionIdHelper:getSplashFinalTakenDamageElement(element)
    local elements = {1224, 1228, 1226, 1227, 1225, 1223}
    return elements[element + 1] or elements[#elements]
end

function ActionIdHelper:getSplashRawTakenDamageElement(element)
    local elements = {1124, 1128, 1126, 1127, 1125, 1123}
    return elements[element + 1] or elements[#elements]
end

function ActionIdHelper:isFakeDamage(actionId)
    return actionId == 90 or actionId == 1047 or actionId == 1048
end

function ActionIdHelper:isSpellExecution(actionId)
    local allowedActionIds = {1160, 2160, 1019, 1018, 792, 2792, 2794, 2795, 1017, 2017, 793, 2793}
    for _, v in ipairs(allowedActionIds) do
        if actionId == v then
            return true
        end
    end
    return false
end

function ActionIdHelper:isTeleport(actionId)
    if actionId == 4 or actionId == 1099 or actionId == 1100 or actionId == 1101 or actionId == 1104 or actionId == 1105 or actionId == 1106 or self:isExchange(actionId) then
        return true
    end
    return false
end

function ActionIdHelper:isExchange(actionId)
    return actionId == 8 or actionId == 1023
end

function ActionIdHelper:canTeleportOverBreedSwitchPos(actionId)
    return actionId == 4 or actionId == 1023
end

function ActionIdHelper:allowAoeMalus(actionId)
    if (self:isSplash(actionId) and false) or self:isShield(actionId) then
        return false
    end
    return true
end

function ActionIdHelper:canTriggerHealMultiplier(actionId)
    return actionId ~= 90
end

function ActionIdHelper:canTriggerDamageMultiplier(actionId)
    return actionId ~= 90
end

function ActionIdHelper:canTriggerOnDamage(actionId)
    return actionId ~= 1048
end

function ActionIdHelper:StatToBuffPercentActionIds(statId)
    local buffPercentActionIds = {
        [1] = 2846,
        [10] = 2834,
        [11] = 2844,
        [12] = 2842,
        [13] = 2840,
        [14] = 2836,
        [15] = 2838,
        [23] = 2848,
    }
    return buffPercentActionIds[statId] or -1
end

function ActionIdHelper:StatToDebuffPercentActionIds(statId)
    local debuffPercentActionIds = {
        [1] = 2847,
        [10] = 2835,
        [11] = 2845,
        [12] = 2843,
        [13] = 2841,
        [14] = 2837,
        [15] = 2839,
        [23] = 2848,
    }
    return debuffPercentActionIds[statId] or -1
end

function ActionIdHelper:isLinearBuffActionIds(actionId)
    local nonLinearBuffActionIds = {31, 33, 34, 35, 36, 37, 59, 60, 61, 62, 63, 69, 101, 121, 124, 141, 142}
    for _, v in ipairs(nonLinearBuffActionIds) do
        if actionId == v then
            return false
        end
    end
    return true
end

function ActionIdHelper:isStatModifier(actionId)
    return (self:isBuff(actionId) or self:isDebuff(actionId)) and not self:isShield(actionId)
end

function ActionIdHelper:isBuff(actionId)
    return self:findInArray(self.STAT_BUFF_ACTION_IDS, actionId)
end

function ActionIdHelper:isDebuff(actionId)
    return self:findInArray(self.STAT_DEBUFF_ACTION_IDS, actionId)
end

function ActionIdHelper:getActionIdStatName(actionId)
    return self.actionIdToStatNameMap[actionId] or ""
end

function ActionIdHelper:isPercentStatBoostActionId(actionId)
    return self.percentStatBoostActionIdToStat[actionId] ~= nil
end

function ActionIdHelper:isFlatStatBoostActionId(actionId)
    return self.flatStatBoostActionIdToStat[actionId] ~= nil
end

function ActionIdHelper:getStatIdFromStatActionId(actionId)
    if self:isFlatStatBoostActionId(actionId) then
        return self.flatStatBoostActionIdToStat[actionId]
    elseif self:isPercentStatBoostActionId(actionId) then
        return self.percentStatBoostActionIdToStat[actionId]
    elseif self.shieldActionIdToStatId[actionId] ~= nil then
        return self.shieldActionIdToStatId[actionId]
    else
        return -1
    end
end

-- Helper function to find a value in an array (for isBuff and isDebuff)
function ActionIdHelper:findInArray(array, value)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end
