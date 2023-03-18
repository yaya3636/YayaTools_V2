local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

MapToolsConfig = Class("MapToolsConfig")

function MapToolsConfig:init(param1, param2, param3, param4, param5, param6)
    if param1 == nil or param2 == nil or param3 == nil or param4 == nil or param5 == nil or param6 == nil then
        param1 = 14
        param2 = 20
        param3 = 0
        param4 = 33
        param5 = -19
        param6 = 13
    end
    self.mapGridWidth = param1
    self.mapGridHeight = param2
    self.minXCoord = param3
    self.maxXCoord = param4
    self.minYCoord = param5
    self.maxYCoord = param6
end

return MapToolsConfig