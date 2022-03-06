Zone = {}

Zone.mapsPath = global:getCurrentDirectory() .. "\\YayaTools\\Data\\Maps\\maps.json"
Zone.subareaPath = global:getCurrentDirectory() .. "\\YayaTools\\Data\\SubArea\\"
Zone.areaPath = global:getCurrentDirectory() .. "\\YayaTools\\Data\\Area\\"
Zone.bigDataSubAreas = {}

function Zone:RetrieveSubAreaContainingRessource(gatherId, minResMap)
    minResMap = minResMap or 1

    local mapsDecode = self.json:decode(self.tools:ReadFile(self.mapsPath))

    local subArea = {}

    for kAreaId, vArea in pairs(mapsDecode) do
        if type(vArea) == "table" then
            for kSubAreaId, vSubArea in pairs(vArea) do
                if type(vSubArea) == "table" then
                    for _, vMap in pairs(vSubArea) do
                        if type(vMap) == "table" then
                            for _, vGather in pairs(vMap.gatherElements) do
                                if self.tools:Equal(vGather.gatherId, gatherId) and vGather.count >= minResMap then
                                    if subArea[tostring(kSubAreaId)] == nil then
                                        subArea[tostring(kSubAreaId)] = {}
                                    end
                                    table.insert(subArea[tostring(kSubAreaId)], vMap)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return subArea
end

function Zone:GetAreaMapId(areaId)
    local areaInfo = self.json:decode(self.tools:ReadFile(self.areaPath .. areaId .. ".json"))

    if areaInfo then
        local mapId = {}

        for _, v in pairs(areaInfo.subArea) do
            local tmpMapId = self:GetSubAreaMapId(v)

            for _, j in pairs(tmpMapId) do
                table.insert(mapId, j)
            end
        end

        return mapId
    end
    return nil
end

function Zone:GetAreaName(areaId)
    local areaInfo = self.json:decode(self.tools:ReadFile(self.areaPath .. areaId .. ".json"))

    if areaInfo then
        return areaInfo.areaName
    end
    return nil
end

function Zone:GetSubArea(areaId)
    local areaInfo = self.json:decode(self.tools:ReadFile(self.areaPath .. areaId .. ".json"))

    if areaInfo then
        return areaInfo.subArea
    end
    return nil
end

function Zone:GetSubAreaMapId(subAreaId)
    local subAreaInfo = self.json:decode(self.tools:ReadFile(self.subareaPath .. subAreaId .. ".json"))

    if subAreaInfo then
        return subAreaInfo.mapIds
    end
    return nil
end

function Zone:GetSubAreaMonsters(subAreaId)
    local subAreaInfo = self.json:decode(self.tools:ReadFile(self.subareaPath .. subAreaId .. ".json"))

    if subAreaInfo then
        return subAreaInfo.monsters
    end
    return nil
end

function Zone:GetSubAreaName(subAreaId)
    local subAreaInfo = self.json:decode(self.tools:ReadFile(self.subareaPath .. subAreaId .. ".json"))

    if subAreaInfo then
        return subAreaInfo.subAreaName
    end
    return nil
end

function Zone:GetArea(subAreaId)
    local subAreaInfo = self.json:decode(self.tools:ReadFile(self.subareaPath .. subAreaId .. ".json"))

    if subAreaInfo then
        return subAreaInfo.areaId
    end
    return nil
end

function Zone:GetAreaIdByMapId(mapId)
    if self.bigDataSubAreas then
        for _, vSubArea in pairs(self.bigDataSubAreas) do
            for _, vMapId in pairs(vSubArea.mapIds) do
                if self.tools:Equal(vMapId, mapId) then
                    return vSubArea.areaId
                end
            end
        end
    end
    return nil
end

function Zone:GetSubAreaIdByMapId(mapId)
    if self.bigDataSubAreas then
        for _, vSubArea in pairs(self.bigDataSubAreas) do
            for _, vMapId in pairs(vSubArea.mapIds) do
                if self.tools:Equal(vMapId, mapId) then
                    return vSubArea.id
                end
            end
        end
    end
    return nil
end

return Zone