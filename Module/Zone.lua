Zone = {}
-- Area

function Zone:GetAreaObject(areaId)
    local area = self.api.localAPI:GetArea(areaId)
    if area then
        local ret = self.tools.object(area)
        ret.bounds = self.tools.object(area.bounds)
        ret.subAreas = self.tools.list(area.subAreas)
        return ret    
    end
    return nil
end

function Zone:GetAreaMapId(areaId)
    local ret = self.tools.list()
    local area = self:GetAreaObject(areaId)
    for _, vSubAreaId in pairs(area.subAreas:Enumerate()) do
        local subAreaMapId = self:GetSubAreaMapId(vSubAreaId)
        for _, vMapId in pairs(subAreaMapId:Enumerate()) do
            ret:Add(vMapId)
        end
    end
    return ret
end

function Zone:GetSubArea(areaId)
    local area = self:GetAreaObject(areaId)
    if area then return area.subAreas end
    return nil
end

function Zone:GetAreaIdByMapId(mapId)
    return self.api.localAPI:GetAreaIdByMapId(mapId)
end

function Zone:GetAreaName(areaId)
    local area = self:GetAreaObject(areaId)
    if area then return area.name end
    return nil
end

-- SubArea

function Zone:GetSubAreaObject(subAreaId)
    if tonumber(subAreaId) >= 10000 then
        local subArea = self.mineArea:Get(subAreaId)
        if subArea then
            local ret = self.tools.object({
                name = subArea.name,
                isConquestVillage = false,
                mapIds = subArea.mapIds,
                monsters = self.tools.list(),
                harvestables = self.tools.list()
            })
            return ret
        end
    else
        local subArea = self.api.localAPI:GetSubArea(subAreaId)
        if subArea then
            local ret = self.tools.object(subArea)
            ret.playlists = nil
            ret.shape = nil
            ret.npcs = nil
            ret.mapIds = self.tools.list(subArea.mapIds)
            ret.bounds = self.tools.object(subArea.bounds)
            ret.monsters = self.tools.list(subArea.monsters)
            ret.harvestables = self.tools.list(subArea.harvestables)
            return ret
        end    
    end
    return nil
end

function Zone:GetAreaId(subAreaId)
    local subArea = self:GetSubAreaObject(subAreaId)
    if subArea then return subArea.areaId end
    return nil
end

function Zone:GetSubAreaIdByMapId(mapId)
    return self.api.localAPI:GetSubAreaIdByMapId(mapId)
end

function Zone:GetSubAreaMapId(subAreaId)
    local subArea = self:GetSubAreaObject(subAreaId)
    if subArea then return subArea.mapIds end
    return nil
end

function Zone:IsConquestVillage(subAreaId)
    local subArea = self:GetSubAreaObject(subAreaId)
    if subArea then return subArea.isConquestVillage end
    return nil
end

function Zone:GetSubAreaMonsters(subAreaId)
    local subArea = self:GetSubAreaObject(subAreaId)
    if subArea then return subArea.monsters end
    return nil
end

function Zone:GetSubAreaName(subAreaId)
    local subArea = self:GetSubAreaObject(subAreaId)
    if subArea then return subArea.name end
    return "nil"
end

-- BankInfo



return Zone