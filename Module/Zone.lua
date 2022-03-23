Zone = {}

Zone.mapsPath = global:getCurrentDirectory() .. [[\YayaTools\Data\Maps\maps.json]]
Zone.subareaPath = global:getCurrentDirectory() .. [[\YayaTools\Data\SubArea\]]
Zone.areaPath = global:getCurrentDirectory() .. [[\YayaTools\Data\Area\]]
Zone.bigDataSubAreas = {}

Zone.d2oAreaPath = global:getCurrentDirectory() .. [[\YayaTools\Data\D2O\Areas.json]]
Zone.d2oArea = {}
Zone.areaNameEnum = {}

Zone.d2oSubAreaPath = global:getCurrentDirectory() .. [[\YayaTools\Data\D2O\SubAreas.json]]
Zone.d2oSubArea = {}
Zone.subAreaNameEnum = {}

function Zone:InitD2oProperties()
    -- Contructeur name
    local areaFileLine = self.tools:ReadFileLine(global:getCurrentDirectory() .. [[\YayaTools\Data\Area.txt]])

    self.areaNameEnum = self.tools.dictionnary()

    for _,v in pairs(areaFileLine:Enumerate()) do
        local id = string.sub(v, 1, string.find(v, "%s"))
        local name = string.sub(v, string.find(v, "%a"), #v)
        self.areaNameEnum:Add(tonumber(id), name)
    end

    local subAreaFileLine = self.tools:ReadFileLine(global:getCurrentDirectory() .. [[\YayaTools\Data\SubArea.txt]])

    self.subAreaNameEnum = self.tools.dictionnary()

    for _,v in pairs(subAreaFileLine:Enumerate()) do
        local id = string.sub(v, 1, string.find(v, "%s"))
        local name = string.sub(v, string.find(v, "%a"), #v)
        self.subAreaNameEnum:Add(tonumber(id), name)
    end

    -- Contructeur Area
    local area = self.tools.dictionnary()

    for _, v in pairs(self.d2oArea) do
        v.subArea = self.tools.list()
        v.name = self.areaNameEnum:Get(v.id)
        area:Add(v.id, self.tools.object(v))
    end

    self.d2oArea = area


    -- Constructeur SubArea
    local subArea = self.tools.dictionnary()

    for _, v in pairs(self.d2oSubArea) do
        -- Ajout des SubArea a Area
        local tmpArea = self.d2oArea:Get(v.areaId)
        tmpArea.subArea:Add(v.id)
        self.d2oArea:Set(v.areaId, tmpArea)

        --self.tools:Print(v.id)
        -- Constructeur SubArea
        subArea:Add(v.id, self.tools.object({
            id = v.id,
            name = self.subAreaNameEnum:Get(v.id),
            areaId = v.areaId,
            mapIds = self.tools.list():CreateWith(v.mapIds, #v.mapIds),
            level = v.level,
            isConquestVillage = v.isConquestVillage,
            monsters = self.tools.list():CreateWith(v.monsters, #v.monsters)
        }))
    end

    self.d2oSubArea = subArea

end

-- Area

function Zone:GetAreaMapId(areaId)
    local ret = self.tools.list()

    for _, vSubAreaId in pairs(self:GetAreaObject(areaId).subArea:Enumerate()) do
        for _, vMapId in pairs(self:GetSubAreaMapId(vSubAreaId):Enumerate()) do
            ret:Add(vMapId)
        end
    end
    return ret
end

function Zone:GetSubArea(areaId)
    return self.d2oArea:Get(areaId).subArea or nil
end

function Zone:GetAreaId(subAreaId)
    return self.d2oSubArea:Get(subAreaId).areaId or nil
end

function Zone:GetAreaIdByMapId(mapId)
    for _, vSubArea in pairs(self.d2oSubArea:Enumerate()) do
        if vSubArea.mapIds:Contains(mapId) then
            return vSubArea.areaId
        end
    end
    return nil
end

function Zone:GetAreaName(areaId)
    return self.d2oArea:Get(areaId).name or nil
end

function Zone:GetAreaObject(areaId)
    return self.d2oArea:Get(areaId)
end

-- SubArea

function Zone:GetSubAreaObject(subAreaId)
    return self.d2oSubArea:Get(subAreaId)
end

function Zone:GetSubAreaIdByMapId(mapId)
    for _, vSubArea in pairs(self.d2oSubArea:Enumerate()) do
        if vSubArea.mapIds:Contains(mapId) then
            return vSubArea.id
        end
    end
    return nil
end

function Zone:GetSubAreaMapId(subAreaId)
    return self.d2oSubArea:Get(subAreaId).mapIds or nil
end

function Zone:IsConquestVillage(subAreaId)
    return self.d2oSubArea:Get(subAreaId).isConquestVillage or nil
end

function Zone:GetSubAreaMonsters(subAreaId)
    return self.d2oSubArea:Get(subAreaId).monsters or nil
end

function Zone:GetSubAreaName(subAreaId)
    return self.d2oSubArea:Get(subAreaId).name or nil
end

function Zone:GetSubAreaMapId(subAreaId)
    return self.d2oSubArea:Get(subAreaId).mapIds or nil
end

return Zone