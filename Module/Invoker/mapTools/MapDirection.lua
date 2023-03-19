local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")
Bit = dofile(yayaToolsModuleDirectory .. "BitOP.lua")

MapDirection = Class("MapDirection")


MapDirection.INVALID_DIRECTION = -1
MapDirection.DEFAULT_DIRECTION = 1
MapDirection.MAP_ORTHOGONAL_DIRECTIONS_COUNT = 4
MapDirection.MAP_CARDINAL_DIRECTIONS_COUNT = 4
MapDirection.MAP_INTER_CARDINAL_DIRECTIONS_COUNT = 8
MapDirection.MAP_INTER_CARDINAL_DIRECTIONS_HALF_COUNT = 4
MapDirection.EAST = 0
MapDirection.SOUTH_EAST = 1
MapDirection.SOUTH = 2
MapDirection.SOUTH_WEST = 3
MapDirection.WEST = 4
MapDirection.NORTH_WEST = 5
MapDirection.NORTH = 6
MapDirection.NORTH_EAST = 7
MapDirection.MAP_CARDINAL_DIRECTIONS = {0, 2, 4, 6}
MapDirection.MAP_ORTHOGONAL_DIRECTIONS = {1, 3, 5, 7}
MapDirection.MAP_DIRECTIONS = {0, 1, 2, 3, 4, 5, 6, 7}

function MapDirection:isValidDirection(param1)
    if param1 >= 0 then
        return param1 <= 7
    end
    return false
end


function MapDirection:getOppositeDirection(param1)
    return Bit.bxor(param1, 4)
end

 function MapDirection:isCardinal(param1)
    return Bit.band(param1, 1) == 0
end

function MapDirection:isOrthogonal(param1)
    return Bit.band(param1, 1) == 1
end

return MapDirection