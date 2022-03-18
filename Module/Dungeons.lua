Dungeons = {}
Dungeons.d2oDungeonsPath = global:getCurrentDirectory() .. [[\YayaTools\Data\D2O\Dungeons.json]]
Dungeons.d2oDungeons = {}
Dungeons.dungeonsKeysPath = global:getCurrentDirectory() .. [[\YayaTools\Data\DungeonsKeys.json]]
Dungeons.dungeonsKeys = {}

function Dungeons:InitD2oProperties()
    local d2oDungeons = self.tools.list()
    local dungeonsKeys = self.tools.dictionnary()

    for _, v in pairs(self.d2oDungeons) do
        d2oDungeons:Add(self.tools.object({
            id = v.id,
            optimalPlayerLevel = v.optimalPlayerLevel,
            mapIds = self.tools.list():CreateWith(v.mapIds, #v.mapIds),
            entranceMapId = v.entranceMapId,
            exitMapId = v.exitMapId
        }))
    end

    for _, v in pairs(self.dungeonsKeys) do
        dungeonsKeys:Add(v.entranceMapId, self.tools.object(v))
    end

    self.dungeonsKeys = dungeonsKeys
    self.d2oDungeons = d2oDungeons
end

function Dungeons:GetDungeonsEntranceByMapId(mapId)
    for _, v in pairs(self.d2oDungeons:Enumerate()) do
        if v.mapIds:Contains(mapId) then
            return v.entranceMapId
        end
    end
    return nil
end

function Dungeons:GetDungeonsEntranceByDropId(dropId)
    local monsterBoss = nil

    for _, v in pairs(self.monsters:GetMonsterIdByDropId(dropId):Enumerate()) do
        local monster = self.monsters:GetMonsterObject(v)

        if monster.isBoss then
            monsterBoss = monster
        end
    end

    if monsterBoss then
        for _, vMapId in pairs(self.zone:GetSubAreaMapId(monsterBoss.favoriteSubareaId):Enumerate()) do
            local mapId = self:GetDungeonsEntranceByMapId(vMapId)
            if mapId then return mapId end
        end
    else
        self.tools:Print("Le monstre n'est pas un boss", "Dungeons")
    end
    return nil
end

function Dungeons:GetDungeonsKeyId(entranceMapId)
    return self.dungeonsKeys:Get(entranceMapId).keyObjectId or nil
end

return Dungeons