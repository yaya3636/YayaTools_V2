local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

ElementEnum = {
    ELEMENT_MULTI = -2,
    ELEMENT_UNDEFINED = -1,
    ELEMENT_NEUTRAL = 0,
    ELEMENT_EARTH = 1,
    ELEMENT_FIRE = 2,
    ELEMENT_WATER = 3,
    ELEMENT_AIR = 4,
    ELEMENT_NONE = 5,
    ELEMENT_BEST = 6,
    ELEMENT_WORST = 7
}

function ElementEnum:getElementFromActionId(param1)
    if param1 == 81 then
        return 5
    elseif param1 ~= 82 then
        if param1 == 88 or param1 == 94 or param1 == 99 or param1 == 108 or param1 == 278 or param1 == 1015 or param1 == 1037 or param1 == 1066 or param1 == 1069 or param1 == 1094 or param1 == 1126 or param1 == 1226 then
            return 4
        elseif param1 == 85 or param1 == 91 or param1 == 96 or param1 == 275 or param1 == 1014 or param1 == 1065 or param1 == 1068 or param1 == 1095 or param1 == 1127 or param1 == 1227 then
            return 3
        elseif param1 == 87 or param1 == 93 or param1 == 98 or param1 == 277 or param1 == 1013 or param1 == 1064 or param1 == 1067 or param1 == 1093 or param1 == 1125 or param1 == 1225 then
            return 2
        elseif param1 == 86 or param1 == 92 or param1 == 97 or param1 == 276 or param1 == 1016 or param1 == 1063 or param1 == 1070 or param1 == 1096 or param1 == 1128 or param1 == 1228 then
            return 1
        elseif param1 == 2822 or param1 == 2828 or param1 == 2829 or param1 == 2830 or param1 == 2832 or param1 == 2890 or param1 == 2891 then
            return 7
        else
            return -1
        end
    else
        return 0
    end
end

function ElementEnum:init()
end

return Class("ElementEnum", ElementEnum)