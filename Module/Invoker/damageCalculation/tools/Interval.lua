local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

Interval = Class("Interval")

function Interval:init(min, max)
    self.min = min or 0
    self.max = max or 0
end

function Interval:toString()
    return "[" .. self.min .. " - " .. self.max .. "]"
end

function Interval:toArray()
    return {self.min, self.max}
end

function Interval:subInterval(other)
    self.min = self.min - other.min
    self.max = self.max - other.max
    return self
end

function Interval:setToZero()
    self.min = 0
    self.max = 0
    return self
end

function Interval:multiplyInterval(other)
    self.min = self.min * other.min
    self.max = self.max * other.max
    return self
end

function Interval:multiply(value)
    self.min = self.min * value
    self.max = self.max * value
    return self
end

function Interval:minimizeByInterval(other)
    if self.min < other.min then
        self.min = other.min
    end
    if self.max < other.max then
        self.max = other.max
    end
    return self
end

function Interval:minimizeBy(value)
    if self.min < value then
        self.min = value
    end
    if self.max < value then
        self.max = value
    end
    return self
end

function Interval:maximizeByInterval(other)
    if self.min > other.min then
        self.min = other.min
    end
    if self.max > other.max then
        self.max = other.max
    end
    return self
end

function Interval:maximizeBy(value)
    if self.min > value then
        self.min = value
    end
    if self.max > value then
        self.max = value
    end
    return self
end

function Interval:isZero()
    return self.min == 0 and self.max == 0
end

function Interval:increaseByPercent(percent)
    return self:multiply((100 + percent) / 100)
end

function Interval:decreaseByPercent(percent)
    return self:multiply((100 - percent) / 100)
end

function Interval:copy()
    return Interval:new(self.min, self.max)
end

function Interval:addInterval(other)
    self.min = self.min + other.min
    self.max = self.max + other.max
    return self
end

function Interval:add(value)
    self.min = self.min + value
    self.max = self.max + value
    return self
end

function Interval:abs()
    if self.min < 0 then
        self.min = -self.min
    end
    if self.max < 0 then
        self.max = -self.max
    end
    return self
end

return Interval