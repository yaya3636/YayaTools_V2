local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

Point = Class("Point")

function Point:init(x, y)
    self.x = x
    self.y = y
end

function Point:toString()
    return "Point(" .. self.x .. "," .. self.y .. ")"
end

function Point:toFlashPoint()
end

function Point:toArray()
    return {self.x, self.y}
end

return Point