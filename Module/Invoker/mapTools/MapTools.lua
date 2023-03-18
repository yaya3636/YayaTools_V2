local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

Point = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\mapTools\\Point.lua")
MapToolsConfig = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\mapTools\\MapToolsConfig.lua")

MapTools = Class("MapTools")

MapTools.MAP_GRID_WIDTH = nil
MapTools.MAP_GRID_HEIGHT = nil
MapTools.MIN_X_COORD = nil
MapTools.MAX_X_COORD = nil
MapTools.MIN_Y_COORD = nil
MapTools.MAX_Y_COORD = nil
MapTools.EVERY_CELL_ID = nil
MapTools.mapCountCell = nil
MapTools.isInit = false
MapTools.INVALID_CELL_ID = -1
MapTools.PSEUDO_INFINITE = 63
MapTools.COEFF_FOR_REBASE_ON_CLOSEST_8_DIRECTION = math.tan(math.pi / 8)
MapTools.COORDINATES_DIRECTION = {
    Point(1, 0),  -- Droite
    Point(1, 1),  -- Diagonale bas-droite
    Point(0, 1),  -- Bas
    Point(-1, 1), -- Diagonale bas-gauche
    Point(-1, 0), -- Gauche
    Point(-1, -1), -- Diagonale haut-gauche
    Point(0, -1), -- Haut
    Point(1, -1)  -- Diagonale haut-droite
}

function MapTools:init(param1)
    param1 = param1 or MapToolsConfig()
    local _loc5_ = 0
    self.MAP_GRID_WIDTH = param1.mapGridWidth
    self.MAP_GRID_HEIGHT = param1.mapGridHeight
    self.MIN_X_COORD = param1.minXCoord
    self.MAX_X_COORD = param1.maxXCoord
    self.MIN_Y_COORD = param1.minYCoord
    self.MAX_Y_COORD = param1.maxYCoord
    self.mapCountCell = self.MAP_GRID_WIDTH * self.MAP_GRID_HEIGHT * 2
    local _loc2_ = {}
    local _loc3_ = 0
    local _loc4_ = self.mapCountCell
    while _loc3_ < _loc4_ do
        _loc5_ = _loc3_
        table.insert(_loc2_, _loc5_)
        _loc3_ = _loc3_ + 1
    end
    self.EVERY_CELL_ID = _loc2_
    self.isInit = true
end

function MapTools:getCellCoordById(param1)
    if not self:isValidCellId(param1) then
        return nil
    end
    local _loc2_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc3_ = math.floor((_loc2_ + 1) / 2)
    local _loc4_ = _loc2_ - _loc3_
    local _loc5_ = param1 - _loc2_ * self.MAP_GRID_WIDTH
    return Point(_loc3_ + _loc5_, _loc5_ - _loc4_)
end

function MapTools:getCellIdXCoord(param1)
    local _loc2_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc3_ = math.floor((_loc2_ + 1) / 2)
    local _loc4_ = param1 - _loc2_ * self.MAP_GRID_WIDTH
    return _loc3_ + _loc4_
end

function MapTools:getCellIdYCoord(param1)
    local _loc2_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc3_ = math.floor((_loc2_ + 1) / 2)
    local _loc4_ = _loc2_ - _loc3_
    local _loc5_ = param1 - _loc2_ * self.MAP_GRID_WIDTH
    return _loc5_ - _loc4_
end

function MapTools:getCellIdByCoord(param1, param2)
    if not self:isValidCoord(param1, param2) then
        return -1
    end
    return math.floor((param1 - param2) * self.MAP_GRID_WIDTH + param2 + (param1 - param2) / 2)
end

function MapTools:floatAlmostEquals(param1, param2)
    if param1 ~= param2 then
        return math.abs(param1 - param2) < 0.0001
    end
    return true
end

function MapTools:getCellsIdBetween(param1, param2)
    if param1 == param2 then
        return {}
    end
    if not self:isValidCellId(param1) or not self:isValidCellId(param2) then
        return {}
    end
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = _loc4_ + _loc5_
    local _loc7_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc8_ = math.floor((_loc7_ + 1) / 2)
    local _loc9_ = _loc7_ - _loc8_
    local _loc10_ = param1 - _loc7_ * self.MAP_GRID_WIDTH
    local _loc11_ = _loc10_ - _loc9_
    local _loc12_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc13_ = math.floor((_loc12_ + 1) / 2)
    local _loc14_ = param2 - _loc12_ * self.MAP_GRID_WIDTH
    local _loc15_ = _loc13_ + _loc14_
    local _loc16_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc17_ = math.floor((_loc16_ + 1) / 2)
    local _loc18_ = _loc16_ - _loc17_
    local _loc19_ = param2 - _loc16_ * self.MAP_GRID_WIDTH
    local _loc20_ = _loc19_ - _loc18_
    local _loc21_ = _loc15_ - _loc6_
    local _loc22_ = _loc20_ - _loc11_
    local _loc23_ = math.sqrt(_loc21_ * _loc21_ + _loc22_ * _loc22_)
    local _loc24_ = _loc21_ / _loc23_
    local _loc25_ = _loc22_ / _loc23_
    local _loc26_ = math.abs(1 / _loc24_)
    local _loc27_ = math.abs(1 / _loc25_)
    local _loc28_ = _loc24_ < 0 and -1 or 1
    local _loc29_ = _loc25_ < 0 and -1 or 1
    local _loc30_ = 0.5 * _loc26_
    local _loc31_ = 0.5 * _loc27_
    local _loc32_ = {}
    while _loc6_ ~= _loc15_ or _loc11_ ~= _loc20_ do
        if self:floatAlmostEquals(_loc30_, _loc31_) then
            _loc30_ = _loc30_ + _loc26_
            _loc31_ = _loc31_ + _loc27_
            _loc6_ = _loc6_ + _loc28_
            _loc11_ = _loc11_ + _loc29_
        elseif _loc30_ < _loc31_ then
            _loc30_ = _loc30_ + _loc26_
            _loc6_ = _loc6_ + _loc28_
        else
            _loc31_ = _loc31_ + _loc27_
            _loc11_ = _loc11_ + _loc29_
        end
        table.insert(_loc32_, self:getCellIdByCoord(_loc6_, _loc11_))
    end
    return _loc32_
end

function MapTools:getCellsIdOnLargeWay(param1, param2)
    local _loc21_ = 0
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local _loc8_ = _loc6_ - _loc7_
    local _loc9_ = param1 - _loc6_ * self.MAP_GRID_WIDTH
    local _loc10_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc11_ = math.floor((_loc10_ + 1) / 2)
    local _loc12_ = param2 - _loc10_ * self.MAP_GRID_WIDTH
    local _loc13_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc14_ = math.floor((_loc13_ + 1) / 2)
    local _loc15_ = _loc13_ - _loc14_
    local _loc16_ = param2 - _loc13_ * self.MAP_GRID_WIDTH
    local _loc17_ = self:getLookDirection8ExactByCoord(_loc4_ + _loc5_, _loc9_ - _loc8_, _loc11_ + _loc12_, _loc16_ - _loc15_)

    if not MapDirection:isValidDirection(_loc17_) then
        return {}
    end

    local _loc18_ = {param1}
    local _loc19_ = param1
    local _loc20_ = 8
    while _loc19_ ~= param2 do
        if MapDirection:isCardinal(_loc17_) then
            _loc21_ = self:getNextCellByDirection(_loc19_, (_loc17_ + 1) % _loc20_)
            if self:isValidCellId(_loc21_) then
                table.insert(_loc18_, _loc21_)
            end
            _loc21_ = self:getNextCellByDirection(_loc19_, (_loc17_ + _loc20_ - 1) % _loc20_)
            if self:isValidCellId(_loc21_) then
                table.insert(_loc18_, _loc21_)
            end
        end
        _loc19_ = self:getNextCellByDirection(_loc19_, _loc17_)
        table.insert(_loc18_, _loc19_)
    end

    return _loc18_
end

function MapTools:isValidCellId(param1)
    if not self.isInit then
        error("MapTools must be initiliazed with method .initForDofus2 or .initForDofus3")
    end

    if param1 >= 0 then
        return param1 < self.mapCountCell
    end

    return false
end

function MapTools:isValidCoord(param1, param2)
    if not self.isInit then
        error("MapTools must be initiliazed with method .initForDofus2 or .initForDofus3")
    end

    if param2 >= -param1 and param2 <= param1 and param2 <= self.MAP_GRID_WIDTH + self.MAX_Y_COORD - param1 then
        return param2 >= param1 - (self.MAP_GRID_HEIGHT - self.MIN_Y_COORD)
    end

    return false
end

function MapTools:isInDiag(param1, param2)
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local _loc8_ = _loc6_ - _loc7_
    local _loc9_ = param1 - _loc6_ * self.MAP_GRID_WIDTH
    local _loc10_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc11_ = math.floor((_loc10_ + 1) / 2)
    local _loc12_ = param2 - _loc10_ * self.MAP_GRID_WIDTH
    local _loc13_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc14_ = math.floor((_loc13_ + 1) / 2)
    local _loc15_ = _loc13_ - _loc14_
    local _loc16_ = param2 - _loc13_ * self.MAP_GRID_WIDTH
    return self:isInDiagByCoord(_loc4_ + _loc5_, _loc9_ - _loc8_, _loc11_ + _loc12_, _loc16_ - _loc15_)
end

function MapTools:isInDiagByCoord(param1, param2, param3, param4)
    if not self:isValidCoord(param1, param2) or not self:isValidCoord(param3, param4) then
        return false
    end
    return math.floor(math.abs(param1 - param3)) == math.floor(math.abs(param2 - param4))
end

function MapTools:getLookDirection4(param1, param2)
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local _loc8_ = _loc6_ - _loc7_
    local _loc9_ = param1 - _loc6_ * self.MAP_GRID_WIDTH
    local _loc10_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc11_ = math.floor((_loc10_ + 1) / 2)
    local _loc12_ = param2 - _loc10_ * self.MAP_GRID_WIDTH
    local _loc13_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc14_ = math.floor((_loc13_ + 1) / 2)
    local _loc15_ = _loc13_ - _loc14_
    local _loc16_ = param2 - _loc13_ * self.MAP_GRID_WIDTH
    return self:getLookDirection4ByCoord(_loc4_ + _loc5_, _loc9_ - _loc8_, _loc11_ + _loc12_, _loc16_ - _loc15_)
end

function MapTools:getLookDirection4ByCoord(param1, param2, param3, param4)
    if not self:isValidCoord(param1, param2) or not self:isValidCoord(param3, param4) then
        return -1
    end
    local _loc5_ = param1 - param3
    local _loc6_ = param2 - param4
    if math.floor(math.abs(_loc5_)) > math.floor(math.abs(_loc6_)) then
        if _loc5_ < 0 then
            return 1
        end
        return 5
    end
    if _loc6_ < 0 then
        return 7
    end
    return 3
end

function MapTools:getLookDirection4Exact(param1, param2)
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local _loc8_ = _loc6_ - _loc7_
    local _loc9_ = param1 - _loc6_ * self.MAP_GRID_WIDTH
    local _loc10_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc11_ = math.floor((_loc10_ + 1) / 2)
    local _loc12_ = param2 - _loc10_ * self.MAP_GRID_WIDTH
    local _loc13_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc14_ = math.floor((_loc13_ + 1) / 2)
    local _loc15_ = _loc13_ - _loc14_
    local _loc16_ = param2 - _loc13_ * self.MAP_GRID_WIDTH

    return self:getLookDirection4ExactByCoord(_loc4_ + _loc5_, _loc9_ - _loc8_, _loc11_ + _loc12_, _loc16_ - _loc15_)
end

function MapTools:getLookDirection4ExactByCoord(param1, param2, param3, param4)
    if not self:isValidCoord(param1, param2) or not self:isValidCoord(param3, param4) then
        return -1
    end
    local _loc5_ = param3 - param1
    local _loc6_ = param4 - param2
    if _loc6_ == 0 then
        if _loc5_ < 0 then
            return 5
        end
        return 1
    end
    if _loc5_ == 0 then
        if _loc6_ < 0 then
            return 3
        end
        return 7
    end
    return -1
end

function MapTools:getLookDirection4Diag(param1, param2)
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local _loc8_ = _loc6_ - _loc7_
    local _loc9_ = param1 - _loc6_ * self.MAP_GRID_WIDTH
    local _loc10_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc11_ = math.floor((_loc10_ + 1) / 2)
    local _loc12_ = param2 - _loc10_ * self.MAP_GRID_WIDTH
    local _loc13_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc14_ = math.floor((_loc13_ + 1) / 2)
    local _loc15_ = _loc13_ - _loc14_
    local _loc16_ = param2 - _loc13_ * self.MAP_GRID_WIDTH

    return self:getLookDirection4DiagByCoord(_loc4_ + _loc5_, _loc9_ - _loc8_, _loc11_ + _loc12_, _loc16_ - _loc15_)
end

function MapTools:getLookDirection4DiagByCoord(param1, param2, param3, param4)
    if not self:isValidCoord(param1, param2) or not self:isValidCoord(param3, param4) then
        return -1
    end
    local _loc5_ = param3 - param1
    local _loc6_ = param4 - param2
    if (_loc5_ >= 0 and _loc6_ <= 0) or (_loc5_ <= 0 and _loc6_ >= 0) then
        if _loc5_ < 0 then
            return 6
        end
        return 2
    end
    if _loc5_ < 0 then
        return 4
    end
    return 0
end

function MapTools:getLookDirection4DiagExact(param1, param2)
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local _loc8_ = _loc6_ - _loc7_
    local _loc9_ = param1 - _loc6_ * self.MAP_GRID_WIDTH
    local _loc10_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc11_ = math.floor((_loc10_ + 1) / 2)
    local _loc12_ = param2 - _loc10_ * self.MAP_GRID_WIDTH
    local _loc13_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc14_ = math.floor((_loc13_ + 1) / 2)
    local _loc15_ = _loc13_ - _loc14_
    local _loc16_ = param2 - _loc13_ * self.MAP_GRID_WIDTH

    return self:getLookDirection4DiagExactByCoord(_loc4_ + _loc5_, _loc9_ - _loc8_, _loc11_ + _loc12_, _loc16_ - _loc15_)
end

function MapTools:getLookDirection4DiagExactByCoord(param1, param2, param3, param4)
    if not self:isValidCoord(param1, param2) or not self:isValidCoord(param3, param4) then
        return -1
    end
    local _loc5_ = param3 - param1
    local _loc6_ = param4 - param2
    if _loc5_ == -_loc6_ then
        if _loc5_ < 0 then
            return 6
        end
        return 2
    end
    if _loc5_ == _loc6_ then
        if _loc5_ < 0 then
            return 4
        end
        return 0
    end
    return -1
end

function MapTools:getLookDirection8(param1, param2)
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local _loc8_ = _loc6_ - _loc7_
    local _loc9_ = param1 - _loc6_ * self.MAP_GRID_WIDTH
    local _loc10_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc11_ = math.floor((_loc10_ + 1) / 2)
    local _loc12_ = param2 - _loc10_ * self.MAP_GRID_WIDTH
    local _loc13_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc14_ = math.floor((_loc13_ + 1) / 2)
    local _loc15_ = _loc13_ - _loc14_
    local _loc16_ = param2 - _loc13_ * self.MAP_GRID_WIDTH

    return self:getLookDirection8ByCoord(_loc4_ + _loc5_, _loc9_ - _loc8_, _loc11_ + _loc12_, _loc16_ - _loc15_)
end

function MapTools:getLookDirection8ByCoord(param1, param2, param3, param4)
    local _loc5_ = self:getLookDirection8ExactByCoord(param1, param2, param3, param4)
    local _loc6_, _loc7_, _loc8_, _loc9_

    if not MapDirection:isValidDirection(_loc5_) then
        _loc6_ = param3 - param1
        _loc7_ = param4 - param2
        _loc8_ = math.floor(math.abs(_loc6_))
        _loc9_ = math.floor(math.abs(_loc7_))
        if _loc8_ < _loc9_ then
            if _loc7_ > 0 then
                _loc5_ = _loc6_ < 0 and 6 or 7
            else
                _loc5_ = _loc6_ < 0 and 3 or 2
            end
        elseif _loc6_ > 0 then
            _loc5_ = _loc7_ > 0 and 0 or 1
        else
            _loc5_ = _loc7_ < 0 and 4 or 5
        end
    end

    return _loc5_
end

function MapTools:getLookDirection8Exact(param1, param2)
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local loc8 = _loc6_ - _loc7_
    local loc9 = param1 - _loc6_ * self.MAP_GRID_WIDTH
    local loc10 = math.floor(param2 / self.MAP_GRID_WIDTH)
    local loc11 = math.floor((loc10 + 1) / 2)
    local loc12 = param2 - loc10 * self.MAP_GRID_WIDTH
    local loc13 = math.floor(param2 / self.MAP_GRID_WIDTH)
    local loc14 = math.floor((loc13 + 1) / 2)
    local loc15 = loc13 - loc14
    local loc16 = param2 - loc13 * self.MAP_GRID_WIDTH

    return self:getLookDirection8ExactByCoord(_loc4_ + _loc5_, loc9 - loc8, loc11 + loc12, loc16 - loc15)
end

function MapTools:getLookDirection8ExactByCoord(param1, param2, param3, param4)
    local _loc5_ = self:getLookDirection4ExactByCoord(param1, param2, param3, param4)
    if not MapDirection:isValidDirection(_loc5_) then
        _loc5_ = self:getLookDirection4DiagExactByCoord(param1, param2, param3, param4)
    end

    return _loc5_
end

function MapTools:getNextCellByDirection(param1, param2)
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local _loc8_ = _loc6_ - _loc7_
    local _loc9_ = param1 - _loc6_ * self.MAP_GRID_WIDTH

    return self:getNextCellByDirectionAndCoord(_loc4_ + _loc5_, _loc9_ - _loc8_, param2)
end

function MapTools:getNextCellByDirectionAndCoord(param1, param2, param3)
    if not self:isValidCoord(param1, param2) or not MapDirection:isValidDirection(param3) then
        return -1
    end
    return self:getCellIdByCoord(param1 + self.COORDINATES_DIRECTION[param3].x, param2 + self.COORDINATES_DIRECTION[param3].y)
end

function MapTools:adjacentCellsAllowAccess(param1, param2, param3)
    local _loc4_ = 8
    local _loc5_ = self:getNextCellByDirection(param2, (param3 + 1) % _loc4_)
    local _loc6_ = self:getNextCellByDirection(param2, (param3 + _loc4_ - 1) % _loc4_)

    if MapDirection:isOrthogonal(param3) or param1:isCellEmptyForMovement(_loc5_) and param1:isCellEmptyForMovement(_loc6_) then
        return true
    end
    return false
end

function MapTools:getDistance(param1, param2)
    if not self:isValidCellId(param1) or not self:isValidCellId(param2) then
        return -1
    end
    local _loc3_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc4_ = math.floor((_loc3_ + 1) / 2)
    local _loc5_ = param1 - _loc3_ * self.MAP_GRID_WIDTH
    local _loc6_ = _loc4_ + _loc5_
    local _loc7_ = math.floor(param1 / self.MAP_GRID_WIDTH)
    local _loc8_ = math.floor((_loc7_ + 1) / 2)
    local _loc9_ = _loc7_ - _loc8_
    local _loc10_ = param1 - _loc7_ * self.MAP_GRID_WIDTH
    local _loc11_ = _loc10_ - _loc9_
    local _loc12_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc13_ = math.floor((_loc12_ + 1) / 2)
    local _loc14_ = param2 - _loc12_ * self.MAP_GRID_WIDTH
    local _loc15_ = _loc13_ + _loc14_
    local _loc16_ = math.floor(param2 / self.MAP_GRID_WIDTH)
    local _loc17_ = math.floor((_loc16_ + 1) / 2)
    local _loc18_ = _loc16_ - _loc17_
    local _loc19_ = param2 - _loc16_ * self.MAP_GRID_WIDTH
    local _loc20_ = _loc19_ - _loc18_
    return math.floor(math.abs(_loc15_ - _loc6_) + math.abs(_loc20_ - _loc11_))
end

function MapTools:areCellsAdjacent(param1, param2)
    local _loc3_ = self:getDistance(param1, param2)
    if _loc3_ >= 0 then
        return _loc3_ <= 1
    end
    return false
end

function MapTools:getCellsCoordBetween(param1, param2)
    local cellsIdBetween = self:getCellsIdBetween(param1, param2)
    local result = {}

    for _, cellId in ipairs(cellsIdBetween) do
        local coord = self:getCellCoordById(cellId)
        table.insert(result, coord) -- assuming coord is a table with x and y keys
    end

    return result
end

return MapTools