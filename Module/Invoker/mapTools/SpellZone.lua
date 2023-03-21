local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

MapDirection = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\mapTools\\MapDirection.lua")
MapTools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\mapTools\\MapTools.lua")()

Bit = dofile(yayaToolsModuleDirectory .. "BitOP.lua")

SpellZone = Class("SpellZone")

SpellZone.DEFAULT_RADIUS = 1
SpellZone.DEFAULT_MIN_RADIUS = 0
SpellZone.DEFAULT_DEGRESSION = 10
SpellZone.DEFAULT_MAX_DEGRESSION_TICKS = 4
SpellZone.GLOBAL_RADIUS = 63
SpellZone.MAX_RADIUS_DEGRESSION = 50

function SpellZone:init()
    self.shape = "P"
    self.radius = SpellZone.DEFAULT_RADIUS
    self.minRadius = SpellZone.DEFAULT_MIN_RADIUS
    self.degression = SpellZone.DEFAULT_DEGRESSION
    self.maxDegressionTicks = SpellZone.DEFAULT_MAX_DEGRESSION_TICKS
    self.isCellInZone = nil
    self.getCells = nil
end

function SpellZone:fromRawZone(param1)
    local stopAtTarget6
    local zone44
    local stopAtTarget5
    local zone43
    local zone42
    local zone41
    local directions9
    local zone40
    local directions8
    local zone39
    local zone38
    local zone37
    local zone36
    local zone35
    local zone34
    local zone33
    local zone32
    local zone31
    local zone30
    local zone29
    local directions7
    local zone28
    local directions6
    local zone27
    local zone26
    local zone25
    local stopAtTarget4
    local zone24
    local stopAtTarget3
    local zone23
    local zone22
    local zone21
    local zone20
    local zone19
    local zone18
    local zone17
    local zone16
    local zone15
    local zone14
    local zone13
    local zone12
    local zone11
    local stopAtTarget2
    local zone10
    local stopAtTarget1
    local zone9
    local zone8
    local zone7
    local directions5
    local zone6
    local directions4
    local zone5
    local directions3
    local zone4
    local directions2
    local zone3
    local directions1
    local zone2
    local directions
    local zone1
    local cells
    local _loc5_ = 0
    local _loc6_ = nil
    local _loc7_ = nil

    if param1 == nil then
        param1 = "P"
    end

    local _loc2_ = self.c()
    _loc2_.shape = param1:sub(1, 1)
    local _loc3_ = {}

    for part in string.gmatch(param1:sub(2), '([^,]+)') do
        if part:len() > 0 then
            table.insert(_loc3_, part)
        end
    end

    local _loc4_ = false
    if _loc2_.shape == ";" then
        cells = {}
        _loc5_ = 1
        while _loc5_ <= #_loc3_ do
            _loc6_ = _loc3_[_loc5_]
            _loc5_ = _loc5_ + 1
            if _loc6_:len() > 0 then
                _loc7_ = tonumber(_loc6_)
                table.insert(cells, _loc7_)
            end
        end
        _loc2_.getCells = function(p1, param2)
            return cells
        end
        _loc2_.isCellInZone = function(p1, param2, param3)
            return self:findInArray(cells, p1) ~= -1
        end
        return _loc2_
    end

    if _loc2_.shape == "l" then
        _loc6_ = tostring(_loc3_[1])
        _loc3_[1] = tostring(_loc3_[2])
        _loc3_[2] = _loc6_
    end

    if #_loc3_ > 0 then
        _loc2_.radius = tonumber(_loc3_[1])
    end

    if self.hasMinSize(_loc2_.shape) then
        if #_loc3_ > 1 then
            _loc2_.minRadius = tonumber(_loc3_[2])
        end
        if #_loc3_ > 2 then
            _loc2_.degression = tonumber(_loc3_[3])
        end
    else
        if #_loc3_ > 1 then
            _loc2_.degression = tonumber(_loc3_[2])
        end
        if #_loc3_ > 2 then
            _loc2_.maxDegressionTicks = tonumber(_loc3_[3])
        end
    end

    if #_loc3_ > 3 then
        _loc2_.maxDegressionTicks = tonumber(_loc3_[4])
    end

    if #_loc3_ > 4 then
        _loc4_ = tonumber(_loc3_[5]) ~= 0
    end

    _loc6_ = _loc2_.shape

    if _loc6_ == " " then
        _loc2_.getCells = SpellZone.fillEmptyCells
        _loc2_.isCellInZone = SpellZone.isCellInEmptyZone
    elseif _loc6_ == "#" then
        zone1 = _loc2_
        directions = MapDirection.MAP_CARDINAL_DIRECTIONS
        _loc2_.getCells = function(p1, param2)
            return SpellZone.fillCrossCells(zone1, directions, true, p1, param2)
        end
        zone2 = _loc2_
        directions1 = MapDirection.MAP_CARDINAL_DIRECTIONS
        _loc2_.isCellInZone = function(p1, param2, param3)
            return SpellZone.isCellInCrossZone(zone2, directions1, true, p1, param2, param3)
        end
    elseif _loc6_ == "*" then
        zone3 = _loc2_
        directions2 = MapDirection.MAP_DIRECTIONS
        _loc2_.getCells = function(p1, param2)
            return SpellZone.fillCrossCells(zone3, directions2, false, p1, param2)
        end
        zone4 = _loc2_
        directions3 = MapDirection.MAP_DIRECTIONS
        _loc2_.isCellInZone = function(p1, param2, param3)
            return SpellZone.isCellInCrossZone(zone4, directions3, false, p1, param2, param3)
        end
    elseif _loc6_ == "+" then
        zone5 = _loc2_
        directions4 = MapDirection.MAP_CARDINAL_DIRECTIONS
        _loc2_.getCells = function(p1, param2)
            return SpellZone.fillCrossCells(zone5, directions4, false, p1, param2)
        end
        zone6 = _loc2_
        directions5 = MapDirection.MAP_CARDINAL_DIRECTIONS
        _loc2_.isCellInZone = function(p1, param2, param3)
            return SpellZone.isCellInCrossZone(zone6, directions5, false, p1, param2, param3)
        end
    elseif _loc6_ == "-" then
        zone7 = _loc2_
        _loc2_.getCells = function(p1, param2)
            return SpellZone.fillPerpLineCells(zone7, p1, param2)
        end
        zone8 = _loc2_
        _loc2_.isCellInZone = function(p1, param2, param3)
            return SpellZone.isCellInPerpLineZone(zone8, p1, param2, param3)
        end
    elseif _loc6_ == "/" then
        zone9 = _loc2_
        stopAtTarget1 = _loc4_
        _loc2_.getCells = function(p1, param2)
            return SpellZone.fillLineCells(zone9, stopAtTarget1, false, p1, param2)
        end
        zone10 = _loc2_
        stopAtTarget2 = _loc4_
        _loc2_.isCellInZone = function(p1, param2, param3)
            return SpellZone.isCellInLineZone(zone10, stopAtTarget2, false, p1, param2, param3)
        end
    else
        local loc6 = _loc6_
        if loc6 ~= "A" then
            if loc6 ~= "a" then
                if loc6 == "B" then
                    zone11 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillBoomerang(zone11, p1, param2)
                    end
                    zone12 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInBoomerangZone(zone12, p1, param2, param3)
                    end
                elseif loc6 == "C" then
                    zone13 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillCircleCells(zone13, p1, param2)
                    end
                    zone14 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInCircleZone(zone14, p1, param2, param3)
                    end
                elseif loc6 == "D" then
                    zone15 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillCheckerboard(zone15, p1, param2)
                    end
                    zone16 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInCheckerboardZone(zone16, p1, param2, param3)
                    end
                elseif loc6 == "F" then
                    zone17 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillForkCells(zone17, p1, param2)
                    end
                    zone18 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInForkZone(zone18, p1, param2, param3)
                    end
                elseif loc6 == "G" then
                    zone19 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillSquareCells(zone19, false, p1, param2)
                    end
                    zone20 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInSquareZone(zone20, false, p1, param2, param3)
                    end
                elseif loc6 == "I" then
                    _loc2_.minRadius = _loc2_.radius
                    _loc2_.radius = SpellZone.GLOBAL_RADIUS
                    zone21 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillCircleCells(zone21, p1, param2)
                    end
                    zone22 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInCircleZone(zone22, p1, param2, param3)
                    end
                elseif loc6 == "L" then
                    zone23 = _loc2_
                    stopAtTarget3 = _loc4_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillLineCells(zone23, stopAtTarget3, false, p1, param2)
                    end
                    zone24 = _loc2_
                    stopAtTarget4 = _loc4_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInLineZone(zone24, stopAtTarget4, false, p1, param2, param3)
                    end
                elseif loc6 == "O" then
                    _loc2_.minRadius = _loc2_.radius
                    zone25 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillCircleCells(zone25, p1, param2)
                    end
                    zone26 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInCircleZone(zone26, p1, param2, param3)
                    end
                elseif loc6 == "P" then
                    _loc2_.radius = 0
                    _loc2_.getCells = SpellZone.fillPointCells
                    _loc2_.isCellInZone = SpellZone.isCellInPointZone
                elseif loc6 == "Q" then
                    zone27 = _loc2_
                    directions6 = MapDirection.MAP_ORTHOGONAL_DIRECTIONS
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillCrossCells(zone27, directions6, true, p1, param2)
                    end
                    zone28 = _loc2_
                    directions7 = MapDirection.MAP_ORTHOGONAL_DIRECTIONS
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInCrossZone(zone28, directions7, true, p1, param2, param3)
                    end
                elseif loc6 == "R" then
                    zone29 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillRectangleCells(zone29, p1, param2)
                    end
                    zone30 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInRectangleZone(zone30, p1, param2, param3)
                    end
                elseif loc6 == "T" then
                    zone31 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillPerpLineCells(zone31, p1, param2)
                    end
                    zone32 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInPerpLineZone(zone32, p1, param2, param3)
                    end
                elseif loc6 == "U" then
                    zone33 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillHalfCircle(zone33, p1, param2)
                    end
                    zone34 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInHalfCircleZone(zone34, p1, param2, param3)
                    end
                elseif loc6 == "V" then
                    zone35 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillConeCells(zone35, p1, param2)
                    end
                    zone36 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInConeZone(zone36, p1, param2, param3)
                    end
                elseif loc6 == "W" then
                    zone37 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillSquareCells(zone37, true, p1, param2)
                    end
                    zone38 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInSquareZone(zone38, true, p1, param2, param3)
                    end
                elseif loc6 == "X" then
                    zone39 = _loc2_
                    directions8 = MapDirection.MAP_ORTHOGONAL_DIRECTIONS
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillCrossCells(zone39, directions8, false, p1, param2)
                    end
                    zone40 = _loc2_
                    directions9 = MapDirection.MAP_ORTHOGONAL_DIRECTIONS
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInCrossZone(zone40, directions9, false, p1, param2, param3)
                    end
                elseif loc6 == "Z" then
                    zone41 = _loc2_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillReversedTrueCircleCells(zone41, p1, param2)
                    end
                    zone42 = _loc2_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInReversedTrueCircleZone(zone42, p1, param2, param3)
                    end
                elseif loc6 == "l" then
                    zone43 = _loc2_
                    stopAtTarget5 = _loc4_
                    _loc2_.getCells = function(p1, param2)
                        return SpellZone.fillLineCells(zone43, stopAtTarget5, true, p1, param2)
                    end
                    zone44 = _loc2_
                    stopAtTarget6 = _loc4_
                    _loc2_.isCellInZone = function(p1, param2, param3)
                        return SpellZone.isCellInLineZone(zone44, stopAtTarget6, true, p1, param2, param3)
                    end
                else
                    _loc2_.shape = "P"
                    _loc2_.radius = 0
                    _loc2_.getCells = SpellZone.fillPointCells
                    _loc2_.isCellInZone = SpellZone.isCellInPointZone
                end
            end
            return _loc2_
        else
            _loc2_.getCells = SpellZone.fillWholeMap
            _loc2_.isCellInZone = SpellZone.isCellInWholeMapZone
        end
    end

    return _loc2_
end

function SpellZone.fillPointCells(param1, param2)
    if not MapTools:isValidCellId(param1) then
        return {}
    end
    return { param1 }
end

function SpellZone.isCellInPointZone(param1, param2, param3)
    return param1 == param2
end

function SpellZone.fillEmptyCells(param1, param2)
    return {}
end

function SpellZone.isCellInEmptyZone(param1, param2, param3)
    return false
end

function SpellZone.fillCircleCells(param1, param2, param3)
    local _loc4_ = {}
    local _loc5_ = MapTools:getCellCoordById(param2)
    local _loc6_ = -param1.radius
    local _loc7_ = param1.radius + 1
    while _loc6_ < _loc7_ do
        local _loc8_ = _loc6_
        _loc6_ = _loc6_ + 1
        local _loc9_ = -param1.radius
        local _loc10_ = param1.radius + 1
        while _loc9_ < _loc10_ do
            local _loc11_ = _loc9_
            _loc9_ = _loc9_ + 1
            if MapTools:isValidCoord(_loc5_.x + _loc8_, _loc5_.y + _loc11_) and math.abs(_loc8_) + math.abs(_loc11_) <= param1.radius and math.abs(_loc8_) + math.abs(_loc11_) >= param1.minRadius then
                table.insert(_loc4_, MapTools:getCellIdByCoord(_loc5_.x + _loc8_, _loc5_.y + _loc11_))
            end
        end
    end
    return _loc4_
end

function SpellZone.isCellInCircleZone(param1, param2, param3, param4)
    local _loc5_ = MapTools:getDistance(param2, param3)
    if _loc5_ <= param1.radius then
        return _loc5_ >= param1.minRadius
    end
    return false
end

function SpellZone.fillCheckerboard(param1, param2)
    local _loc4_ = {}
    local _loc5_ = MapTools:getCellCoordById(param2)
    local _loc6_ = (param1.radius % 2) == 0
    local _loc7_ = -param1.radius
    local _loc8_ = param1.radius + 1
    while _loc7_ < _loc8_ do
        local _loc9_ = _loc7_
        _loc7_ = _loc7_ + 1
        local _loc10_ = -param1.radius
        local _loc11_ = param1.radius + 1
        while _loc10_ < _loc11_ do
            local _loc12_ = _loc10_
            _loc10_ = _loc10_ + 1
            if MapTools:isValidCoord(_loc5_.x + _loc9_, _loc5_.y + _loc12_) and math.abs(_loc9_) + math.abs(_loc12_) <= param1.radius and math.abs(_loc9_) + math.abs(_loc12_) >= param1.minRadius and (_loc6_ and ((_loc9_ + (_loc12_ % 2)) % 2) == 0 or not _loc6_ and ((_loc9_ + 1 + (_loc12_ % 2)) % 2) == 0) then
                table.insert(_loc4_, MapTools:getCellIdByCoord(_loc5_.x + _loc9_, _loc5_.y + _loc12_))
            end
        end
    end
    return _loc4_
end

function SpellZone.isCellInCheckerboardZone(param1, param2, param3)
    local _loc5_ = MapTools:getDistance(param2, param3)
    local _loc6_ = (param1.radius % 2) == 0
    local _loc7_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc8_ = math.floor((_loc7_ + 1) / 2)
    local _loc9_ = param2 - _loc7_ * MapTools.MAP_GRID_WIDTH
    local _loc10_ = _loc8_ + _loc9_
    local _loc11_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc12_ = math.floor((_loc11_ + 1) / 2)
    local _loc13_ = _loc11_ - _loc12_
    local _loc14_ = param2 - _loc11_ * MapTools.MAP_GRID_WIDTH
    local _loc15_ = _loc14_ - _loc13_
    if _loc5_ >= param1.minRadius then
        if not (_loc6_ and ((_loc10_ + (_loc15_ % 2)) % 2) == 0) then
            if not _loc6_ then
                return ((_loc10_ + 1 + (_loc15_ % 2)) % 2) == 0
            end
            return false
        end
        return true
    end
    return false
end

function SpellZone.fillLineCells(param1, param2, param3, param4, param5)
    local _loc24_, _loc26_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_, _loc15_, _loc16_, _loc17_, _loc18_, _loc19_, _loc20_, _loc21_, _loc22_, _loc23_
    _loc6_ = {}
    _loc7_ = param3 and param5 or param4
    _loc8_ = param3 and param1.radius + param1.minRadius - 1 or param1.radius
    _loc9_ = math.floor(param5 / MapTools.MAP_GRID_WIDTH)
    _loc10_ = math.floor((_loc9_ + 1) / 2)
    _loc11_ = param5 - _loc9_ * MapTools.MAP_GRID_WIDTH
    _loc12_ = math.floor(param5 / MapTools.MAP_GRID_WIDTH)
    _loc13_ = math.floor((_loc12_ + 1) / 2)
    _loc14_ = _loc12_ - _loc13_
    _loc15_ = param5 - _loc12_ * MapTools.MAP_GRID_WIDTH
    _loc16_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    _loc17_ = math.floor((_loc16_ + 1) / 2)
    _loc18_ = param4 - _loc16_ * MapTools.MAP_GRID_WIDTH
    _loc19_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    _loc20_ = math.floor((_loc19_ + 1) / 2)
    _loc21_ = _loc19_ - _loc20_
    _loc22_ = param4 - _loc19_ * MapTools.MAP_GRID_WIDTH
    _loc23_ = MapTools:getLookDirection8ExactByCoord(_loc10_ + _loc11_, _loc15_ - _loc14_, _loc17_ + _loc18_,
    _loc22_ - _loc21_)
    if param3 and param2 then
        _loc24_ = MapTools:getDistance(param5, param4)
        if _loc24_ < _loc8_ then
            _loc8_ = _loc24_
        end
    end
    _loc24_ = 0
    local _loc25_ = param1.minRadius
    while _loc24_ < _loc25_ do
        _loc26_ = _loc24_
        _loc24_ = _loc24_ + 1
        _loc7_ = MapTools:getNextCellByDirection(_loc7_, _loc23_)
    end
    _loc24_ = param1.minRadius
    _loc25_ = _loc8_ + 1
    while _loc24_ < _loc25_ do
        _loc26_ = _loc24_
        _loc24_ = _loc24_ + 1
        if MapTools:isValidCellId(_loc7_) then
            table.insert(_loc6_, _loc7_)
        end
        _loc7_ = MapTools:getNextCellByDirection(_loc7_, _loc23_)
    end
    return _loc6_
end

function SpellZone.isCellInLineZone(param1, param2, param3, param4, param5, param6)
    if param6 == param4 then
        return false
    end

    local _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_, _loc15_, _loc16_, _loc17_, _loc18_, _loc19_, _loc20_, _loc21_, _loc22_, _loc23_, _loc24_, _loc25_, _loc26_, _loc27_, _loc28_, _loc29_, _loc30_, _loc31_, _loc32_, _loc33_, _loc34_, _loc35_, _loc36_, _loc37_, _loc38_, _loc39_

    _loc7_ = math.floor(param6 / MapTools.MAP_GRID_WIDTH)
    _loc8_ = math.floor((_loc7_ + 1) / 2)
    _loc9_ = param6 - _loc7_ * MapTools.MAP_GRID_WIDTH
    _loc10_ = math.floor(param6 / MapTools.MAP_GRID_WIDTH)
    _loc11_ = math.floor((_loc10_ + 1) / 2)
    _loc12_ = _loc10_ - _loc11_
    _loc13_ = param6 - _loc10_ * MapTools.MAP_GRID_WIDTH
    _loc14_ = math.floor(param5 / MapTools.MAP_GRID_WIDTH)
    _loc15_ = math.floor((_loc14_ + 1) / 2)
    _loc16_ = param5 - _loc14_ * MapTools.MAP_GRID_WIDTH
    _loc17_ = math.floor(param5 / MapTools.MAP_GRID_WIDTH)
    _loc18_ = math.floor((_loc17_ + 1) / 2)
    _loc19_ = _loc17_ - _loc18_
    _loc20_ = param5 - _loc17_ * MapTools.MAP_GRID_WIDTH
    _loc21_ = MapTools:getLookDirection8ExactByCoord(_loc8_ + _loc9_, _loc13_ - _loc12_, _loc15_ + _loc16_,
    _loc20_ - _loc19_)
    _loc22_ = param1.radius

    if param3 then
        _loc25_ = math.floor(param6 / MapTools.MAP_GRID_WIDTH)
        _loc26_ = math.floor((_loc25_ + 1) / 2)
        _loc27_ = param6 - _loc25_ * MapTools.MAP_GRID_WIDTH
        _loc28_ = math.floor(param6 / MapTools.MAP_GRID_WIDTH)
        _loc29_ = math.floor((_loc28_ + 1) / 2)
        _loc30_ = _loc28_ - _loc29_
        _loc31_ = param6 - _loc28_ * MapTools.MAP_GRID_WIDTH
        _loc32_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
        _loc33_ = math.floor((_loc32_ + 1) / 2)
        _loc34_ = param4 - _loc32_ * MapTools.MAP_GRID_WIDTH
        _loc35_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
        _loc36_ = math.floor((_loc35_ + 1) / 2)
        _loc37_ = _loc35_ - _loc36_
        _loc38_ = param4 - _loc35_ * MapTools.MAP_GRID_WIDTH
        _loc23_ = MapTools:getLookDirection8ExactByCoord(_loc26_ + _loc27_, _loc31_ - _loc30_, _loc33_ + _loc34_,
        _loc38_ - _loc37_)
        _loc24_ = MapTools:getDistance(param6, param4)

        if param2 then
            _loc39_ = MapTools:getDistance(param6, param5)
            if _loc39_ < _loc22_ then
                _loc22_ = _loc39_
            end
        end
    else
        _loc25_ = math.floor(param5 / MapTools.MAP_GRID_WIDTH)
        _loc26_ = math.floor((_loc25_ + 1) / 2)
        _loc27_ = param5 - _loc25_ * MapTools.MAP_GRID_WIDTH
        _loc28_ = math.floor(param5 / MapTools.MAP_GRID_WIDTH)
        _loc29_ = math.floor((_loc28_ + 1) / 2)
        _loc30_ = _loc28_ - _loc29_
        _loc31_ = param5 - _loc28_ * MapTools.MAP_GRID_WIDTH
        _loc32_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
        _loc33_ = math.floor((_loc32_ + 1) / 2)
        _loc34_ = param4 - _loc32_ * MapTools.MAP_GRID_WIDTH
        _loc35_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
        _loc36_ = math.floor((_loc35_ + 1) / 2)
        _loc37_ = _loc35_ - _loc36_
        _loc38_ = param4 - _loc35_ * MapTools.MAP_GRID_WIDTH
        _loc23_ = MapTools:getLookDirection8ExactByCoord(_loc26_ + _loc27_, _loc31_ - _loc30_, _loc33_ + _loc34_,
        _loc38_ - _loc37_)
        _loc24_ = MapTools:getDistance(param5, param4)
    end

    if MapDirection:isCardinal(_loc23_) and _loc24_ > 1 then
        _loc24_ = Bit.rshift(_loc24_, 1)
    end

    if (_loc21_ == _loc23_ or _loc24_ == 0) and _loc24_ >= param1.minRadius then
        return _loc24_ <= _loc22_
    end

    return false
end

function SpellZone.fillCrossCells(param1, param2, param3, param4, param5)
    local _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_, _loc15_

    _loc6_ = {}
    _loc7_ = param1.minRadius
    if param1.minRadius == 0 then
        _loc7_ = 1
        if not param3 then
            table.insert(_loc6_, param4)
        end
    end
    _loc8_ = {}
    _loc9_ = 0
    _loc10_ = #param2
    while _loc9_ < _loc10_ do
        table.insert(_loc8_, param4)
        _loc9_ = _loc9_ + 1
    end
    _loc11_ = _loc8_
    _loc12_ = 1
    _loc13_ = param1.radius + 1
    while _loc12_ < _loc13_ do
        _loc14_ = 0
        _loc15_ = #param2
        while _loc14_ < _loc15_ do
            _loc11_[_loc14_ + 1] = MapTools:getNextCellByDirection(_loc11_[_loc14_ + 1], param2[_loc14_ + 1])
            if _loc12_ >= _loc7_ and MapTools:isValidCellId(_loc11_[_loc14_ + 1]) then
                table.insert(_loc6_, _loc11_[_loc14_ + 1])
            end
            _loc14_ = _loc14_ + 1
        end
        _loc12_ = _loc12_ + 1
    end
    return _loc6_
end

function SpellZone.isCellInCrossZone(param1, param2, param3, param4, param5, param6)
    local _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_, _loc15_, _loc16_, _loc17_, _loc18_, _loc19_, _loc20_, _loc21_, _loc22_

    _loc7_ = math.floor(param5 / MapTools.MAP_GRID_WIDTH)
    _loc8_ = math.floor((_loc7_ + 1) / 2)
    _loc9_ = param5 - _loc7_ * MapTools.MAP_GRID_WIDTH
    _loc10_ = math.floor(param5 / MapTools.MAP_GRID_WIDTH)
    _loc11_ = math.floor((_loc10_ + 1) / 2)
    _loc12_ = _loc10_ - _loc11_
    _loc13_ = param5 - _loc10_ * MapTools.MAP_GRID_WIDTH
    _loc14_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    _loc15_ = math.floor((_loc14_ + 1) / 2)
    _loc16_ = param4 - _loc14_ * MapTools.MAP_GRID_WIDTH
    _loc17_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    _loc18_ = math.floor((_loc17_ + 1) / 2)
    _loc19_ = _loc17_ - _loc18_
    _loc20_ = param4 - _loc17_ * MapTools.MAP_GRID_WIDTH

    _loc21_ = MapTools:getLookDirection4ByCoord(_loc8_ + _loc9_, _loc13_ - _loc12_, _loc15_ + _loc16_, _loc20_ - _loc19_)
    _loc22_ = MapTools:getDistance(param5, param4)

    if (_loc21_ ~= nil) and _loc22_ >= param1.minRadius then
        return _loc22_ <= param1.radius
    end

    return false
end

function SpellZone.fillPerpLineCells(param1, param2, param3)
    local _loc4_ = {}
    local _loc5_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc6_ = math.floor((_loc5_ + 1) / 2)
    local _loc7_ = param3 - _loc5_ * MapTools.MAP_GRID_WIDTH
    local _loc8_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc9_ = math.floor((_loc8_ + 1) / 2)
    local _loc10_ = _loc8_ - _loc9_
    local _loc11_ = param3 - _loc8_ * MapTools.MAP_GRID_WIDTH
    local _loc12_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc13_ = math.floor((_loc12_ + 1) / 2)
    local _loc14_ = param2 - _loc12_ * MapTools.MAP_GRID_WIDTH
    local _loc15_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc16_ = math.floor((_loc15_ + 1) / 2)
    local _loc17_ = _loc15_ - _loc16_
    local _loc18_ = param2 - _loc15_ * MapTools.MAP_GRID_WIDTH

    local _loc19_ = MapTools:getLookDirection8ExactByCoord(_loc6_ + _loc7_, _loc11_ - _loc10_, _loc13_ + _loc14_,
    _loc18_ - _loc17_)
    local _loc20_ = (_loc19_ + 2) % 8
    local _loc21_ = (_loc19_ - 2 + 8) % 8

    local _loc22_ = param1.minRadius
    if param1.minRadius == 0 then
        _loc22_ = 1
        if MapTools:isValidCellId(param2) then
            table.insert(_loc4_, param2)
        end
    end

    local _loc23_ = param2
    local _loc24_ = param2
    local _loc25_ = _loc22_
    local _loc26_ = param1.radius + 1

    for _loc27_ = _loc25_, _loc26_ - 1 do
        _loc23_ = MapTools:getNextCellByDirection(_loc23_, _loc20_)
        _loc24_ = MapTools:getNextCellByDirection(_loc24_, _loc21_)
        if MapTools:isValidCellId(_loc23_) then
            table.insert(_loc4_, _loc23_)
        end
        if MapTools:isValidCellId(_loc24_) then
            table.insert(_loc4_, _loc24_)
        end
    end

    return _loc4_
end

function SpellZone.isCellInPerpLineZone(param1, param2, param3, param4)
    local _loc5_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    local _loc6_ = math.floor((_loc5_ + 1) / 2)
    local _loc7_ = param4 - _loc5_ * MapTools.MAP_GRID_WIDTH
    local _loc8_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    local _loc9_ = math.floor((_loc8_ + 1) / 2)
    local _loc10_ = _loc8_ - _loc9_
    local _loc11_ = param4 - _loc8_ * MapTools.MAP_GRID_WIDTH
    local _loc12_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc13_ = math.floor((_loc12_ + 1) / 2)
    local _loc14_ = param3 - _loc12_ * MapTools.MAP_GRID_WIDTH
    local _loc15_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc16_ = math.floor((_loc15_ + 1) / 2)
    local _loc17_ = _loc15_ - _loc16_
    local _loc18_ = param3 - _loc15_ * MapTools.MAP_GRID_WIDTH

    local _loc19_ = MapTools:getLookDirection8ExactByCoord(_loc6_ + _loc7_, _loc11_ - _loc10_, _loc13_ + _loc14_,
    _loc18_ - _loc17_)
    local _loc20_ = (_loc19_ + 2) % 8
    local _loc21_ = (_loc19_ - 2 + 8) % 8

    local _loc22_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc23_ = math.floor((_loc22_ + 1) / 2)
    local _loc24_ = param3 - _loc22_ * MapTools.MAP_GRID_WIDTH
    local _loc25_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc26_ = math.floor((_loc25_ + 1) / 2)
    local _loc27_ = _loc25_ - _loc26_
    local _loc28_ = param3 - _loc25_ * MapTools.MAP_GRID_WIDTH
    local _loc29_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc30_ = math.floor((_loc29_ + 1) / 2)
    local _loc31_ = param2 - _loc29_ * MapTools.MAP_GRID_WIDTH
    local _loc32_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc33_ = math.floor((_loc32_ + 1) / 2)
    local _loc34_ = _loc32_ - _loc33_
    local _loc35_ = param2 - _loc32_ * MapTools.MAP_GRID_WIDTH

    local _loc36_ = MapTools:getLookDirection8ExactByCoord(_loc23_ + _loc24_, _loc28_ - _loc27_, _loc30_ + _loc31_,
    _loc35_ - _loc34_)
    local _loc37_ = MapTools:getDistance(param3, param2)

    if MapDirection:isCardinal(_loc36_) and _loc37_ > 1 then
        _loc37_ = Bit.rshift(_loc37_, 1)
    end

    if (_loc36_ == _loc20_ or _loc36_ == _loc21_ or _loc37_ == 0) and _loc37_ >= param1.minRadius then
        return _loc37_ <= param1.radius
    end

    return false
end

function SpellZone.fillConeCells(param1, param2, param3)
    local _loc4_ = {}
    local _loc5_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc6_ = math.floor((_loc5_ + 1) / 2)
    local _loc7_ = param3 - _loc5_ * MapTools.MAP_GRID_WIDTH
    local _loc8_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc9_ = math.floor((_loc8_ + 1) / 2)
    local _loc10_ = _loc8_ - _loc9_
    local _loc11_ = param3 - _loc8_ * MapTools.MAP_GRID_WIDTH
    local _loc12_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc13_ = math.floor((_loc12_ + 1) / 2)
    local _loc14_ = param2 - _loc12_ * MapTools.MAP_GRID_WIDTH
    local _loc15_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc16_ = math.floor((_loc15_ + 1) / 2)
    local _loc17_ = _loc15_ - _loc16_
    local _loc18_ = param2 - _loc15_ * MapTools.MAP_GRID_WIDTH

    local _loc19_ = MapTools:getLookDirection8ExactByCoord(_loc6_ + _loc7_, _loc11_ - _loc10_, _loc13_ + _loc14_,
    _loc18_ - _loc17_)
    local _loc20_ = (_loc19_ + 2) % 8
    local _loc21_ = (_loc19_ - 2 + 8) % 8
    local _loc22_ = param2
    local _loc23_ = 0
    local _loc24_ = param1.radius + 1

    while _loc23_ < _loc24_ do
        local _loc25_ = _loc23_
        table.insert(_loc4_, _loc22_)
        local _loc26_ = _loc22_
        local _loc27_ = _loc22_
        local _loc28_ = 0
        local _loc29_ = _loc25_

        while _loc28_ < _loc29_ do
            local _loc30_ = _loc28_
            _loc26_ = MapTools:getNextCellByDirection(_loc26_, _loc20_)
            _loc27_ = MapTools:getNextCellByDirection(_loc27_, _loc21_)

            if MapTools:isValidCellId(_loc26_) then
                table.insert(_loc4_, _loc26_)
            end

            if MapTools:isValidCellId(_loc27_) then
                table.insert(_loc4_, _loc27_)
            end

            _loc28_ = _loc28_ + 1
        end

        _loc22_ = MapTools:getNextCellByDirection(_loc22_, _loc19_)
        _loc23_ = _loc23_ + 1
    end

    return _loc4_
end

function SpellZone.isCellInConeZone(param1, param2, param3, param4)
    local _loc5_ = MapTools:getLookDirection4(param4, param3)
    local _loc6_ = MapTools:getCellCoordById(param3)
    local _loc7_ = MapTools:getCellCoordById(param2)
    local _loc8_ = _loc7_.x - _loc6_.x
    local _loc9_ = _loc7_.y - _loc6_.y

    local function _loc10_(p1)
        if p1 < 0 then
            return -p1
        else
            return p1
        end
    end

    if _loc5_ == 1 then
        if _loc8_ >= 0 and _loc8_ <= param1.radius then
            return _loc10_(_loc9_) <= _loc8_
        else
            return false
        end
    elseif _loc5_ == 3 then
        if _loc9_ <= 0 and _loc9_ >= -param1.radius then
            return _loc10_(_loc8_) <= -_loc9_
        else
            return false
        end
    elseif _loc5_ == 5 then
        if _loc8_ <= 0 and _loc8_ >= -param1.radius then
            return _loc10_(_loc9_) <= -_loc8_
        else
            return false
        end
    elseif _loc5_ == 7 then
        if _loc9_ >= 0 and _loc9_ <= param1.radius then
            return _loc10_(_loc8_) <= _loc9_
        else
            return false
        end
    else
        return false
    end
end

function SpellZone.fillForkCells(param1, param2, param3)
    local _loc4_ = {}
    local _loc5_ = MapTools:getCellCoordById(param2)
    local _loc6_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local _loc8_ = param3 - _loc6_ * MapTools.MAP_GRID_WIDTH
    local _loc9_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc10_ = math.floor((_loc9_ + 1) / 2)
    local _loc11_ = _loc9_ - _loc10_
    local _loc12_ = param3 - _loc9_ * MapTools.MAP_GRID_WIDTH
    local _loc13_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc14_ = math.floor((_loc13_ + 1) / 2)
    local _loc15_ = param2 - _loc13_ * MapTools.MAP_GRID_WIDTH
    local _loc16_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc17_ = math.floor((_loc16_ + 1) / 2)
    local _loc18_ = _loc16_ - _loc17_
    local _loc19_ = param2 - _loc16_ * MapTools.MAP_GRID_WIDTH
    local _loc20_ = MapTools:getLookDirection8ExactByCoord(_loc7_ + _loc8_, _loc12_ - _loc11_, _loc14_ + _loc15_,
    _loc19_ - _loc18_)
    local _loc21_ = (_loc20_ == 5 or _loc20_ == 3) and -1 or 1
    local _loc22_ = _loc20_ == 5 or _loc20_ == 1
    local _loc23_ = param1.radius + 1

    if MapTools:isValidCoord(_loc5_.x, _loc5_.y) then
        table.insert(_loc4_, MapTools:getCellIdByCoord(_loc5_.x, _loc5_.y))
    end

    local _loc24_ = 1
    local _loc25_ = _loc23_ + 1

    while _loc24_ < _loc25_ do
        local _loc26_ = _loc24_
        local _loc27_, _loc28_ = 0, 0

        if _loc22_ then
            _loc27_ = _loc5_.x + _loc26_ * _loc21_
            _loc28_ = _loc5_.y + -1 * _loc26_
        else
            _loc27_ = _loc5_.x + -1 * _loc26_
            _loc28_ = _loc5_.y + _loc26_ * _loc21_
        end

        if MapTools:isValidCoord(_loc27_, _loc28_) then
            table.insert(_loc4_, MapTools:getCellIdByCoord(_loc27_, _loc28_))
        end

        _loc27_, _loc28_ = 0, 0

        if _loc22_ then
            _loc27_ = _loc5_.x + _loc26_ * _loc21_
            _loc28_ = _loc5_.y + 0 * _loc26_
        else
            _loc27_ = _loc5_.x + 0 * _loc26_
            _loc28_ = _loc5_.y + _loc26_ * _loc21_
        end

        if MapTools:isValidCoord(_loc27_, _loc28_) then
            table.insert(_loc4_, MapTools:getCellIdByCoord(_loc27_, _loc28_))
        end

        _loc27_, _loc28_ = 0, 0

        if _loc22_ then
            _loc27_ = _loc5_.x + _loc26_ * _loc21_
            _loc28_ = _loc5_.y + _loc26_
        else
            _loc27_ = _loc5_.x + _loc26_
            _loc28_ = _loc5_.y + _loc26_ * _loc21_
        end

        if MapTools:isValidCoord(_loc27_, _loc28_) then
            table.insert(_loc4_, MapTools:getCellIdByCoord(_loc27_, _loc28_))
        end

        _loc24_ = _loc24_ + 1
    end

    return _loc4_
end

function SpellZone.isCellInForkZone(param1, param2, param3, param4)
    local _loc10_, _loc11_
    local _loc5_ = MapTools:getCellCoordById(param3)
    local _loc6_ = MapTools:getCellCoordById(param2)
    local _loc7_ = MapTools:getLookDirection4(param4, param3)
    local _loc8_ = param1.radius + 1
    local _loc9_ = (_loc7_ == 5 or _loc7_ == 3) and -1 or 1

    if _loc7_ == 5 or _loc7_ == 1 then
        _loc10_ = (_loc6_.x - _loc5_.x) * _loc9_
        _loc11_ = _loc6_.y - _loc5_.y
    else
        _loc10_ = (_loc6_.y - _loc5_.y) * _loc9_
        _loc11_ = _loc6_.x - _loc5_.x
    end

    if _loc10_ >= 0 and _loc10_ <= _loc8_ then
        if not (_loc11_ == _loc10_ or _loc11_ == 0) then
            return _loc11_ == -_loc10_
        end
        return true
    end

    return false
end

function SpellZone.fillSquareCells(param1, param2, param3, param4)
    local _loc5_ = {}
    local _loc6_ = MapTools:getCellCoordById(param3)
    local _loc7_ = -param1.radius
    local _loc8_ = param1.radius + 1

    while _loc7_ < _loc8_ do
        local _loc9_ = _loc7_
        _loc7_ = _loc7_ + 1
        local _loc10_ = -param1.radius
        local _loc11_ = param1.radius + 1

        while _loc10_ < _loc11_ do
            local _loc12_ = _loc10_
            _loc10_ = _loc10_ + 1

            if MapTools:isValidCoord(_loc6_.x + _loc9_, _loc6_.y + _loc12_) and (not param2 or math.abs(_loc9_) ~= math.abs(_loc12_)) then
                table.insert(_loc5_, MapTools:getCellIdByCoord(_loc6_.x + _loc9_, _loc6_.y + _loc12_))
            end
        end
    end

    return _loc5_
end

function SpellZone.isCellInSquareZone(param1, param2, param3, param4, param5)
    local _loc6_ = MapTools:getCellCoordById(param4)
    local _loc7_ = MapTools:getCellCoordById(param3)

    local function _loc8_(param1)
        if param1 < 0 then
            return -param1
        else
            return param1
        end
    end

    local _loc9_ = _loc8_(_loc7_.x - _loc6_.x)
    local _loc10_ = _loc8_(_loc7_.y - _loc6_.y)

    if (not param2 or _loc9_ ~= _loc10_) and _loc9_ <= param1.radius and _loc10_ <= param1.radius and _loc9_ >= param1.minRadius then
        return _loc10_ >= param1.minRadius
    else
        return false
    end
end

function SpellZone.fillRectangleCells(param1, param2, param3)
    if param1.radius < 1 then
        param1.radius = 1
    end

    if param1.minRadius < 1 then
        param1.minRadius = 1
    end

    local _loc4_ = {}
    local _loc5_ = MapTools:getCellCoordById(param2)
    local _loc6_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc7_ = math.floor((_loc6_ + 1) / 2)
    local _loc8_ = param3 - _loc6_ * MapTools.MAP_GRID_WIDTH
    local _loc9_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc10_ = math.floor((_loc9_ + 1) / 2)
    local _loc11_ = _loc9_ - _loc10_
    local _loc12_ = param3 - _loc9_ * MapTools.MAP_GRID_WIDTH
    local _loc13_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc14_ = math.floor((_loc13_ + 1) / 2)
    local _loc15_ = param2 - _loc13_ * MapTools.MAP_GRID_WIDTH
    local _loc16_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc17_ = math.floor((_loc16_ + 1) / 2)
    local _loc18_ = _loc16_ - _loc17_
    local _loc19_ = param2 - _loc16_ * MapTools.MAP_GRID_WIDTH
    local _loc20_ = MapTools:getLookDirection8ExactByCoord(_loc7_ + _loc8_, _loc12_ - _loc11_, _loc14_ + _loc15_,
    _loc19_ - _loc18_)
    local _loc21_ = (_loc20_ == 5 or _loc20_ == 3) and -1 or 1
    local _loc22_ = _loc20_ == 7 or _loc20_ == 3
    local _loc23_ = 1 + param1.radius * 2
    local _loc24_ = 1 + param1.minRadius
    local _loc25_ = 0
    local _loc26_ = _loc24_

    while _loc25_ < _loc26_ do
        local _loc27_ = _loc25_
        _loc25_ = _loc25_ + 1
        local _loc28_ = 0
        local _loc29_ = _loc23_

        while _loc28_ < _loc29_ do
            local _loc30_ = _loc28_
            _loc28_ = _loc28_ + 1
            local _loc31_, _loc32_

            if _loc22_ then
                _loc31_ = _loc5_.x + _loc30_ - math.floor(_loc23_ / 2)
                _loc32_ = _loc5_.y + _loc27_ * _loc21_
            else
                _loc31_ = _loc5_.x + _loc27_ * _loc21_
                _loc32_ = _loc5_.y + _loc30_ - math.floor(_loc23_ / 2)
            end

            if MapTools:isValidCoord(_loc31_, _loc32_) then
                table.insert(_loc4_, MapTools:getCellIdByCoord(_loc31_, _loc32_))
            end
        end
    end

    return _loc4_
end

function SpellZone.isCellInRectangleZone(param1, param2, param3, param4)
    local _loc26_ = 0
    local _loc27_ = 0

    if param1.radius < 1 then
        param1.radius = 1
    end

    if param1.minRadius < 1 then
        param1.minRadius = 1
    end

    local _loc5_ = MapTools:getCellCoordById(param3)
    local _loc6_ = MapTools:getCellCoordById(param2)

    local function _loc7_(p1)
        if p1 < 0 then
            return -p1
        else
            return p1
        end
    end

    local _loc8_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    local _loc9_ = math.floor((_loc8_ + 1) / 2)
    local _loc10_ = param4 - _loc8_ * MapTools.MAP_GRID_WIDTH
    local _loc11_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    local _loc12_ = math.floor((_loc11_ + 1) / 2)
    local _loc13_ = _loc11_ - _loc12_
    local _loc14_ = param4 - _loc11_ * MapTools.MAP_GRID_WIDTH
    local _loc15_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc16_ = math.floor((_loc15_ + 1) / 2)
    local _loc17_ = param3 - _loc15_ * MapTools.MAP_GRID_WIDTH
    local _loc18_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc19_ = math.floor((_loc18_ + 1) / 2)
    local _loc20_ = _loc18_ - _loc19_
    local _loc21_ = param3 - _loc18_ * MapTools.MAP_GRID_WIDTH
    local _loc22_ = MapTools:getLookDirection8ExactByCoord(_loc9_ + _loc10_, _loc14_ - _loc13_, _loc16_ + _loc17_,
    _loc21_ - _loc20_)
    local _loc23_ = (_loc22_ == 5 or _loc22_ == 3) and -1 or 1
    local _loc24_ = 1 + param1.radius * 2
    local _loc25_ = 1 + param1.minRadius

    if _loc22_ == 7 or _loc22_ == 3 then
        _loc26_ = _loc7_(_loc6_.x - _loc5_.x)
        _loc27_ = (_loc6_.y - _loc5_.y) * _loc23_
    else
        _loc26_ = _loc7_(_loc6_.y - _loc5_.y)
        _loc27_ = (_loc6_.x - _loc5_.x) * _loc23_
    end

    if _loc26_ <= math.floor(_loc24_ / 2) then
        if _loc27_ >= 0 then
            return _loc27_ < _loc25_
        else
            return false
        end
    end

    return false
end

-- -- GPT-3.5

function SpellZone.fillHalfCircle(param1, param2, param3)
    local _loc27_ = 0
    local _loc4_ = {}
    local _loc5_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc6_ = math.floor((_loc5_ + 1) / 2)
    local _loc7_ = param3 - _loc5_ * MapTools.MAP_GRID_WIDTH
    local _loc8_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc9_ = math.floor((_loc8_ + 1) / 2)
    local _loc10_ = _loc8_ - _loc9_
    local _loc11_ = param3 - _loc8_ * MapTools.MAP_GRID_WIDTH
    local _loc12_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc13_ = math.floor((_loc12_ + 1) / 2)
    local _loc14_ = param2 - _loc12_ * MapTools.MAP_GRID_WIDTH
    local _loc15_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc16_ = math.floor((_loc15_ + 1) / 2)
    local _loc17_ = _loc15_ - _loc16_
    local _loc18_ = param2 - _loc15_ * MapTools.MAP_GRID_WIDTH
    local _loc19_ = MapTools:getLookDirection8ExactByCoord(_loc6_ + _loc7_, _loc11_ - _loc10_, _loc13_ + _loc14_,
    _loc18_ - _loc17_)
    local _loc20_ = (_loc19_ + 3) % 8
    local _loc21_ = (_loc19_ - 3 + 8) % 8
    local _loc22_ = param1.minRadius
    if param1.minRadius == 0 then
        _loc22_ = 1
        table.insert(_loc4_, param2)
    end
    local _loc23_ = param2
    local _loc24_ = param2
    local _loc25_ = _loc22_
    local _loc26_ = param1.radius + 1
    while _loc25_ < _loc26_ do
        _loc27_ = _loc25_
        _loc25_ = _loc25_ + 1
        _loc23_ = MapTools:getNextCellByDirection(_loc23_, _loc20_)
        _loc24_ = MapTools:getNextCellByDirection(_loc24_, _loc21_)
        if MapTools:isValidCellId(_loc23_) then
            table.insert(_loc4_, _loc23_)
        end
        if MapTools:isValidCellId(_loc24_) then
            table.insert(_loc4_, _loc24_)
        end
    end
    return _loc4_
end

function SpellZone.isCellInHalfCircleZone(param1, param2, param3, param4)
    local _loc5_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    local _loc6_ = math.floor((_loc5_ + 1) / 2)
    local _loc7_ = param4 - _loc5_ * MapTools.MAP_GRID_WIDTH
    local _loc8_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    local _loc9_ = math.floor((_loc8_ + 1) / 2)
    local _loc10_ = _loc8_ - _loc9_
    local _loc11_ = param4 - _loc8_ * MapTools.MAP_GRID_WIDTH
    local _loc12_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc13_ = math.floor((_loc12_ + 1) / 2)
    local _loc14_ = param3 - _loc12_ * MapTools.MAP_GRID_WIDTH
    local _loc15_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc16_ = math.floor((_loc15_ + 1) / 2)
    local _loc17_ = _loc15_ - _loc16_
    local _loc18_ = param3 - _loc15_ * MapTools.MAP_GRID_WIDTH
    local _loc19_ = MapTools:getLookDirection8ExactByCoord(_loc6_ + _loc7_, _loc11_ - _loc10_, _loc13_ + _loc14_,
    _loc18_ - _loc17_)
    local _loc20_ = (_loc19_ - 3 + 8) % 8
    local _loc21_ = (_loc19_ + 3) % 8
    local _loc22_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc23_ = math.floor((_loc22_ + 1) / 2)
    local _loc24_ = param3 - _loc22_ * MapTools.MAP_GRID_WIDTH
    local _loc25_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc26_ = math.floor((_loc25_ + 1) / 2)
    local _loc27_ = _loc25_ - _loc26_
    local _loc28_ = param3 - _loc25_ * MapTools.MAP_GRID_WIDTH
    local _loc29_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc30_ = math.floor((_loc29_ + 1) / 2)
    local _loc31_ = param2 - _loc29_ * MapTools.MAP_GRID_WIDTH
    local _loc32_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc33_ = math.floor((_loc32_ + 1) / 2)
    local _loc34_ = _loc32_ - _loc33_
    local _loc35_ = param2 - _loc32_ * MapTools.MAP_GRID_WIDTH
    local _loc36_ = MapTools:getLookDirection8ExactByCoord(_loc23_ + _loc24_, _loc28_ - _loc27_, _loc30_ + _loc31_,
    _loc35_ - _loc34_)
    local _loc37_ = MapTools:getDistance(param3, param2)
    if MapDirection:isCardinal(_loc36_) and _loc37_ > 1 then
        _loc37_ = Bit.rshift(_loc37_, 1)
    end
    if _loc20_ == _loc36_ or _loc21_ == _loc36_ or _loc37_ == 0 and _loc37_ <= param1.radius then
        return _loc37_ >= param1.minRadius
    end
    return false
end

function SpellZone.fillBoomerang(param1, param2, param3)
    local loc4 = {}
    local loc5 = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local loc6 = math.floor((loc5 + 1) / 2)
    local loc7 = param3 - loc5 * MapTools.MAP_GRID_WIDTH
    local loc8 = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local loc9 = math.floor((loc8 + 1) / 2)
    local loc10 = loc8 - loc9
    local loc11 = param3 - loc8 * MapTools.MAP_GRID_WIDTH
    local loc12 = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local loc13 = math.floor((loc12 + 1) / 2)
    local loc14 = param2 - loc12 * MapTools.MAP_GRID_WIDTH
    local loc15 = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local loc16 = math.floor((loc15 + 1) / 2)
    local loc17 = loc15 - loc16
    local loc18 = param2 - loc15 * MapTools.MAP_GRID_WIDTH
    local loc19 = MapTools:getLookDirection8ExactByCoord(loc6 + loc7, loc11 - loc10, loc13 + loc14, loc18 - loc17)
    local loc20 = (loc19 + 2) % 8
    local loc21 = (loc19 + 3) % 8
    local loc22 = (loc19 - 2 + 8) % 8
    local loc23 = (loc19 - 3 + 8) % 8
    local loc24 = param1.minRadius
    if param1.minRadius == 0 then
        loc24 = 1
        table.insert(loc4, param2)
    end
    local loc25 = param2
    local loc26 = param2
    local loc27 = loc24
    local loc28 = param1.radius
    while loc27 < loc28 do
        loc25 = MapTools:getNextCellByDirection(loc25, loc20)
        loc26 = MapTools:getNextCellByDirection(loc26, loc22)
        if MapTools:isValidCellId(loc25) then
            table.insert(loc4, loc25)
        end
        if MapTools:isValidCellId(loc26) then
            table.insert(loc4, loc26)
        end
        loc27 = loc27 + 1
    end
    if param1.radius ~= 0 then
        loc25 = MapTools:getNextCellByDirection(loc25, loc21)
        loc26 = MapTools:getNextCellByDirection(loc26, loc23)
        if MapTools:isValidCellId(loc25) then
            table.insert(loc4, loc25)
        end
        if MapTools:isValidCellId(loc26) then
            table.insert(loc4, loc26)
        end
    end
    return loc4
end

function SpellZone.isCellInBoomerangZone(param1, param2, param3, param4)
    local _loc5_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    local _loc6_ = math.floor((_loc5_ + 1) / 2)
    local _loc7_ = param4 - _loc5_ * MapTools.MAP_GRID_WIDTH
    local _loc8_ = math.floor(param4 / MapTools.MAP_GRID_WIDTH)
    local _loc9_ = math.floor((_loc8_ + 1) / 2)
    local _loc10_ = _loc8_ - _loc9_
    local _loc11_ = param4 - _loc8_ * MapTools.MAP_GRID_WIDTH
    local _loc12_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc13_ = math.floor((_loc12_ + 1) / 2)
    local _loc14_ = param3 - _loc12_ * MapTools.MAP_GRID_WIDTH
    local _loc15_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc16_ = math.floor((_loc15_ + 1) / 2)
    local _loc17_ = _loc15_ - _loc16_
    local _loc18_ = param3 - _loc15_ * MapTools.MAP_GRID_WIDTH
    local _loc19_ = MapTools:getLookDirection8ExactByCoord(_loc6_ + _loc7_, _loc11_ - _loc10_, _loc13_ + _loc14_, _loc18_ - _loc17_)
    local _loc20_ = (_loc19_ + 2) % 8
    local _loc21_ = (_loc19_ - 2 + 8) % 8
    local _loc22_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc23_ = math.floor((_loc22_ + 1) / 2)
    local _loc24_ = param3 - _loc22_ * MapTools.MAP_GRID_WIDTH
    local _loc25_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc26_ = math.floor((_loc25_ + 1) / 2)
    local _loc27_ = _loc25_ - _loc26_
    local _loc28_ = param3 - _loc25_ * MapTools.MAP_GRID_WIDTH
    local _loc29_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc30_ = math.floor((_loc29_ + 1) / 2)
    local _loc31_ = param2 - _loc29_ * MapTools.MAP_GRID_WIDTH
    local _loc32_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc33_ = math.floor((_loc32_ + 1) / 2)
    local _loc34_ = _loc32_ - _loc33_
    local _loc35_ = param2 - _loc32_ * MapTools.MAP_GRID_WIDTH
    local _loc36_ = MapTools:getLookDirection8ExactByCoord(_loc23_ + _loc24_, _loc28_ - _loc27_, _loc30_ + _loc31_, _loc35_ - _loc34_)
    local _loc37_ = MapTools:getDistance(param3, param2)
    if MapDirection:isCardinal(_loc36_) and _loc37_ > 1 then
        _loc37_ = Bit.rshift(_loc37_, 1)
    end
    if ((_loc36_ == _loc20_ or _loc36_ == _loc21_ or _loc37_ == 0) and _loc37_ >= param1.minRadius and _loc37_ < param1.radius) then
        return true
    end
    param2 = MapTools:getNextCellByDirection(param2, _loc19_)
    local _loc38_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc39_ = math.floor((_loc38_ + 1) / 2)
    local _loc40_ = param3 - _loc38_ * MapTools.MAP_GRID_WIDTH
    local _loc41_ = math.floor(param3 / MapTools.MAP_GRID_WIDTH)
    local _loc42_ = math.floor((_loc41_ + 1) / 2)
    local _loc43_ = _loc41_ - _loc42_
    local _loc44_ = param3 - _loc41_ * MapTools.MAP_GRID_WIDTH
    local _loc45_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc46_ = math.floor((_loc45_ + 1) / 2)
    local _loc47_ = param2 - _loc45_ * MapTools.MAP_GRID_WIDTH
    local _loc48_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
    local _loc49_ = math.floor((_loc48_ + 1) / 2)
    local _loc50_ = _loc48_ - _loc49_
    local _loc51_ = param2 - _loc48_ * MapTools.MAP_GRID_WIDTH
    _loc36_ = MapTools:getLookDirection8ExactByCoord(_loc39_ + _loc40_, _loc44_ - _loc43_, _loc46_ + _loc47_, _loc51_ - _loc50_)
    _loc37_ = MapTools:getDistance(param3, param2)
    if MapDirection:isCardinal(_loc36_) and _loc37_ > 1 then
        _loc37_ = Bit.rshift(_loc37_, 1)
    end
    if ((_loc36_ == _loc20_ or _loc36_ == _loc21_) and _loc37_ ~= 0 and _loc37_ >= param1.minRadius) then
        return _loc37_ == param1.radius
    end
    return false
end

function SpellZone.fillWholeMap(param1, param2)
    return MapTools.EVERY_CELL_ID
end

function SpellZone.isCellInWholeMapZone(param1, param2, param3)
    return true
end

function SpellZone.fillReversedTrueCircleCells(param1, param2, param3)
    local _loc4_ = {}
    local _loc5_ = MapTools:getCellCoordById(param2)
    local _loc6_ = param1.radius
    local _loc7_ = 0
    local _loc8_ = MapTools.mapCountCell
    while _loc7_ < _loc8_ do
        local _loc9_ = _loc7_
        local _loc10_ = MapTools:getCellCoordById(_loc9_)
        local _loc11_ = {x = _loc10_.x - _loc5_.x, y = _loc10_.y - _loc5_.y}
        if math.sqrt(_loc11_.x * _loc11_.x + _loc11_.y * _loc11_.y) >= _loc6_ then
            table.insert(_loc4_, _loc9_)
        end
        _loc7_ = _loc7_ + 1
    end
    return _loc4_
end

function SpellZone.isCellInReversedTrueCircleZone(param1, param2, param3, param4)
    local _loc5_ = MapTools:getCellCoordById(param3)
    local _loc6_ = MapTools:getCellCoordById(param2)
    local _loc7_ = {x = _loc6_.x - _loc5_.x, y = _loc6_.y - _loc5_.y}
    return math.sqrt(_loc7_.x * _loc7_.x + _loc7_.y * _loc7_.y) >= param1.radius
end


function SpellZone.hasMinSize(param1)
    return not (param1 == "#" or param1 == "+" or param1 == "C" or param1 == "Q" or param1 == "R" or param1 == "X" or param1 == "l")
end

function SpellZone.getAoeMalus(param1, param2, param3, param4)
    local _loc4_ = 0
    local _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_, _loc15_, _loc16_, _loc17_, _loc18_, _loc19_, _loc20_, _loc21_, _loc22_

    if param4.radius > param4.MAX_RADIUS_DEGRESSION then
        return 0
    end

    local _loc5_ = param4.shape
    if _loc5_ ~= ";" then
        if _loc5_ ~= "A" then
            if _loc5_ ~= "I" then
                if _loc5_ == "a" then
                    _loc4_ = 0
                elseif _loc5_ ~= "G" then
                    if _loc5_ ~= "R" then
                        if _loc5_ ~= "W" then
                            if _loc5_ ~= "#" then
                                if _loc5_ ~= "+" then
                                    if _loc5_ ~= "-" then
                                        if _loc5_ ~= "/" then
                                            if _loc5_ ~= "U" then
                                                if _loc5_ ~= "F" then
                                                    if _loc5_ ~= "V" then
                                                        _loc4_ = MapTools:getDistance(param1, param3)
                                                        _loc8_ = param4.shape == "R" and 0 or param4.minRadius
                                                        if _loc4_ < 0 then
                                                            _loc4_ = 0
                                                        end
                                                        return math.min(math.min(_loc4_ - _loc8_, param4.maxDegressionTicks) * param4.degression, 100)
                                                    end
                                                else
                                                    _loc8_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
                                                    _loc9_ = math.floor((_loc8_ + 1) / 2)
                                                    _loc10_ = param2 - _loc8_ * MapTools.MAP_GRID_WIDTH
                                                    _loc11_ = math.floor(param2 / MapTools.MAP_GRID_WIDTH)
                                                    _loc12_ = math.floor((_loc11_ + 1) / 2)
                                                    _loc13_ = _loc11_ - _loc12_
                                                    _loc14_ = param2 - _loc11_ * MapTools.MAP_GRID_WIDTH
                                                    _loc15_ = math.floor(param1 / MapTools.MAP_GRID_WIDTH)
                                                    _loc16_ = math.floor((_loc15_ + 1) / 2)
                                                    _loc17_ = param1 - _loc15_ * MapTools.MAP_GRID_WIDTH
                                                    _loc18_ = math.floor(param1 / MapTools.MAP_GRID_WIDTH)
                                                    _loc19_ = math.floor((_loc18_ + 1) / 2)
                                                    _loc20_ = _loc18_ - _loc19_
                                                    _loc21_ = param1 - _loc18_ * MapTools.MAP_GRID_WIDTH
                                                    _loc22_ = MapTools:getLookDirection8ExactByCoord(_loc9_ + _loc10_, _loc14_ - _loc13_, _loc16_ + _loc17_, _loc21_ - _loc20_)
                                                    _loc6_ = MapTools:getCellCoordById(param1)
                                                    _loc7_ = MapTools:getCellCoordById(param3)
                                                    if _loc22_ == 0 or _loc22_ == 4 then
                                                        _loc4_ = math.abs(math.abs(_loc6_.x - _loc6_.y) + math.abs(_loc7_.x - _loc7_.y))
                                                    elseif _loc22_ == 1 or _loc22_ == 5 then
                                                        _loc4_ = math.abs(_loc6_.x - _loc7_.x)
                                                    elseif _loc22_ == 2 or _loc22_ == 6 then
                                                        _loc4_ = math.abs(math.abs(_loc6_.x - _loc6_.y) - math.abs(_loc7_.x - _loc7_.y))
                                                    elseif _loc22_ == 3 or _loc22_ == 7 then
                                                        _loc4_ = math.abs(_loc6_.y - _loc7_.y)
                                                    else
                                                        _loc4_ = 0
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if _loc4_ < 0 then
        _loc4_ = 0
    end
    return math.min(math.min(_loc4_ - _loc8_, param4.maxDegressionTicks) * param4.degression, 100)
end


function SpellZone:findInArray(array, value)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end


return SpellZone