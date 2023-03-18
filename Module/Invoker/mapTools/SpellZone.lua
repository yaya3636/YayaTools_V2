local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

MapDirection = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Invoker\\mapTools\\MapDirection.lua")()

SpellZone = {}

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
        _loc2_.getCells = function(param1, param2)
            return cells
        end
        _loc2_.isCellInZone = function(param1, param2, param3)
            return self:findInArray(cells, param1) ~= -1
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

    if SpellZone.hasMinSize(_loc2_.shape) then
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
        _loc2_.getCells = function(param1, param2)
            return SpellZone.fillCrossCells(zone1, directions, true, param1, param2)
        end
        zone2 = _loc2_
        directions1 = MapDirection.MAP_CARDINAL_DIRECTIONS
        _loc2_.isCellInZone = function(param1, param2, param3)
            return SpellZone.isCellInCrossZone(zone2, directions1, true, param1, param2, param3)
        end
    elseif _loc6_ == "*" then
        zone3 = _loc2_
        directions2 = MapDirection.MAP_DIRECTIONS
        _loc2_.getCells = function(param1, param2)
            return SpellZone.fillCrossCells(zone3, directions2, false, param1, param2)
        end
        zone4 = _loc2_
        directions3 = MapDirection.MAP_DIRECTIONS
        _loc2_.isCellInZone = function(param1, param2, param3)
            return SpellZone.isCellInCrossZone(zone4, directions3, false, param1, param2, param3)
        end
    elseif _loc6_ == "+" then
        zone5 = _loc2_
        directions4 = MapDirection.MAP_CARDINAL_DIRECTIONS
        _loc2_.getCells = function(param1, param2)
            return SpellZone.fillCrossCells(zone5, directions4, false, param1, param2)
        end
        zone6 = _loc2_
        directions5 = MapDirection.MAP_CARDINAL_DIRECTIONS
        _loc2_.isCellInZone = function(param1, param2, param3)
            return SpellZone.isCellInCrossZone(zone6, directions5, false, param1, param2, param3)
        end
    elseif _loc6_ == "-" then
        zone7 = _loc2_
        _loc2_.getCells = function(param1, param2)
            return SpellZone.fillPerpLineCells(zone7, param1, param2)
        end
        zone8 = _loc2_
        _loc2_.isCellInZone = function(param1, param2, param3)
            return SpellZone.isCellInPerpLineZone(zone8, param1, param2, param3)
        end
    elseif _loc6_ == "/" then
        zone9 = _loc2_
        stopAtTarget1 = _loc4_
        _loc2_.getCells = function(param1, param2)
            return SpellZone.fillLineCells(zone9, stopAtTarget1, false, param1, param2)
        end
        zone10 = _loc2_
        stopAtTarget2 = _loc4_
        _loc2_.isCellInZone = function(param1, param2, param3)
            return SpellZone.isCellInLineZone(zone10, stopAtTarget2, false, param1, param2, param3)
        end
    else
        local loc6 = _loc6_
        if loc6 ~= "A" then
            if loc6 ~= "a" then
                if loc6 == "B" then
                    zone11 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillBoomerang(zone11, param1, param2)
                    end
                    zone12 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInBoomerangZone(zone12, param1, param2, param3)
                    end
                elseif loc6 == "C" then
                    zone13 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillCircleCells(zone13, param1, param2)
                    end
                    zone14 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInCircleZone(zone14, param1, param2, param3)
                    end
                elseif loc6 == "D" then
                    zone15 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillCheckerboard(zone15, param1, param2)
                    end
                    zone16 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInCheckerboardZone(zone16, param1, param2, param3)
                    end
                elseif loc6 == "F" then
                    zone17 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillForkCells(zone17, param1, param2)
                    end
                    zone18 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInForkZone(zone18, param1, param2, param3)
                    end
                elseif loc6 == "G" then
                    zone19 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillSquareCells(zone19, false, param1, param2)
                    end
                    zone20 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInSquareZone(zone20, false, param1, param2, param3)
                    end
                elseif loc6 == "I" then
                    _loc2_.minRadius = _loc2_.radius
                    _loc2_.radius = SpellZone.GLOBAL_RADIUS
                    zone21 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillCircleCells(zone21, param1, param2)
                    end
                    zone22 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInCircleZone(zone22, param1, param2, param3)
                    end
                elseif loc6 == "L" then
                    zone23 = _loc2_
                    stopAtTarget3 = _loc4_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillLineCells(zone23, stopAtTarget3, false, param1, param2)
                    end
                    zone24 = _loc2_
                    stopAtTarget4 = _loc4_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInLineZone(zone24, stopAtTarget4, false, param1, param2, param3)
                    end
                elseif loc6 == "O" then
                    _loc2_.minRadius = _loc2_.radius
                    zone25 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillCircleCells(zone25, param1, param2)
                    end
                    zone26 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInCircleZone(zone26, param1, param2, param3)
                    end
                elseif loc6 == "P" then
                    _loc2_.radius = 0
                    _loc2_.getCells = SpellZone.fillPointCells
                    _loc2_.isCellInZone = SpellZone.isCellInPointZone
                elseif loc6 == "Q" then
                    zone27 = _loc2_
                    directions6 = MapDirection.MAP_ORTHOGONAL_DIRECTIONS
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillCrossCells(zone27, directions6, true, param1, param2)
                    end
                    zone28 = _loc2_
                    directions7 = MapDirection.MAP_ORTHOGONAL_DIRECTIONS
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInCrossZone(zone28, directions7, true, param1, param2, param3)
                    end
                elseif loc6 == "R" then
                    zone29 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillRectangleCells(zone29, param1, param2)
                    end
                    zone30 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInRectangleZone(zone30, param1, param2, param3)
                    end
                elseif loc6 == "T" then
                    zone31 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillPerpLineCells(zone31, param1, param2)
                    end
                    zone32 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInPerpLineZone(zone32, param1, param2, param3)
                    end
                elseif loc6 == "U" then
                    zone33 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillHalfCircle(zone33, param1, param2)
                    end
                    zone34 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInHalfCircleZone(zone34, param1, param2, param3)
                    end
                elseif loc6 == "V" then
                    zone35 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillConeCells(zone35, param1, param2)
                    end
                    zone36 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInConeZone(zone36, param1, param2, param3)
                    end
                elseif loc6 == "W" then
                    zone37 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillSquareCells(zone37, true, param1, param2)
                    end
                    zone38 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInSquareZone(zone38, true, param1, param2, param3)
                    end
                elseif loc6 == "X" then
                    zone39 = _loc2_
                    directions8 = MapDirection.MAP_ORTHOGONAL_DIRECTIONS
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillCrossCells(zone39, directions8, false, param1, param2)
                    end
                    zone40 = _loc2_
                    directions9 = MapDirection.MAP_ORTHOGONAL_DIRECTIONS
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInCrossZone(zone40, directions9, false, param1, param2, param3)
                    end
                elseif loc6 == "Z" then
                    zone41 = _loc2_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillReversedTrueCircleCells(zone41, param1, param2)
                    end
                    zone42 = _loc2_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInReversedTrueCircleZone(zone42, param1, param2, param3)
                    end
                elseif loc6 == "l" then
                    zone43 = _loc2_
                    stopAtTarget5 = _loc4_
                    _loc2_.getCells = function(param1, param2)
                        return SpellZone.fillLineCells(zone43, stopAtTarget5, true, param1, param2)
                    end
                    zone44 = _loc2_
                    stopAtTarget6 = _loc4_
                    _loc2_.isCellInZone = function(param1, param2, param3)
                        return SpellZone.isCellInLineZone(zone44, stopAtTarget6, true, param1, param2, param3)
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

function SpellZone:findInArray(array, value)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end