Zone = {}
-- Area

function Zone:GetAreaObject(areaId)
    local area = d2data:objectFromD2O("Areas", areaId).Fields
    if area then
        local ret = self.tools.object(area)
        ret.bounds = self.tools.object(area.bounds.Fields)
        ret.subAreas = self.subAreaInArea:Get(areaId)
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
        local subArea = d2data:objectFromD2O("SubAreas", subAreaId).Fields
        if subArea then
            local ret = self.tools.object(subArea)
            ret.playlists = nil
            ret.shape = nil
            ret.npcs = nil
            ret.mapIds = self.tools.list(subArea.mapIds)
            ret.bounds = self.tools.object(subArea.bounds.Fields)
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

-- DofusDB HarvestableElement

function Zone:GetHarvestablePosition(gatherId)
    local constructorMap = function(map)
        local constructorHarvestable = function(harvestable)
            local ret = self.tools.list()

            for _, v in pairs(harvestable) do
                ret:Add(self.tools.object({
                    gatherId = v.item,
                    quantity = v.quantity
                }))
            end
            return ret
        end

        local sorted = self.tools.object({
            mapId = map.id,
            posX = map.pos.posX,
            posY = map.pos.posY,
            subAreaId = map.pos.subAreaId,
            worldMap = map.pos.worldMap,
            harvestableElement = constructorHarvestable(map.quantities)
        })
        return sorted
    end

    local urlDDB = "https://api.dofusdb.fr/"
    local skip = "&$skip=0&lang=fr"
    local data = self.tools.dictionnary()
    local req = self.json:decode(developer:getRequest(urlDDB .. "recoltable?resources[$in][]=" .. gatherId .. skip))
    local total = req.total

    for i = 0, math.ceil(total / 10) do
        skip = "&$skip=" .. (i * 10) .. "&lang=fr"
        req = self.json:decode(developer:getRequest(urlDDB .. "recoltable?resources[$in][]=" .. gatherId .. skip))

        for _, v in pairs(req.data) do
            if v.pos then
                if not data:ContainsKey(v.pos.subAreaId) then
                    local l = self.tools.list()
                    l:Add(constructorMap(v))
                    data:Add(v.pos.subAreaId, l)
                else
                    local l = data:Get(v.pos.subAreaId)
                    l:Add(constructorMap(v))
                    data:Set(v.pos.subAreaId, l)
                end
            end
        end
    end

    return data
end

function Zone:GetHarverstablePositionInSubArea(gatherId, subAreaId)
    local harvestablePosition = self:GetHarvestablePosition(gatherId)
    return harvestablePosition:Get(tostring(subAreaId))
end

function Zone:GetHarverstableMapIdInSubArea(gatherId, subAreaId)
    local ret = self.tools.list()
    local harvestablePosition = self:GetHarvestablePosition(gatherId)
    harvestablePosition = harvestablePosition:Get(tostring(subAreaId))
    for _, v in pairs(harvestablePosition:Enumerate()) do
        ret:Add(v.mapId)
    end
    return ret
end

return Zone