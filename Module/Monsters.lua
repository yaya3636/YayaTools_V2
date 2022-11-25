Monsters = {}

function Monsters:GetMonsterObject(idMonster)
    local data = d2data:objectFromD2O("Monsters", idMonster).Fields
    if data then
        local parseGrade = function(grades)
            local parseBonusCharacteristics = function(bonusCharacteristics)
                return self.tools.object({
                    lifePoints = bonusCharacteristics.lifePoints,
                    strenght = bonusCharacteristics.strenght,
                    wisdom = bonusCharacteristics.wisdom,
                    chance = bonusCharacteristics.chance,
                    agility = bonusCharacteristics.agility,
                    intelligence = bonusCharacteristics.intelligence,
                    earthResistance = bonusCharacteristics.earthResistance,
                    fireResistance = bonusCharacteristics.fireResistance,
                    waterResistance = bonusCharacteristics.waterResistance,
                    airResistance = bonusCharacteristics.airResistance,
                    neutralResistance = bonusCharacteristics.neutralResistance,
                    tackleEvade = bonusCharacteristics.tackleEvade,
                    tackleBlock = bonusCharacteristics.tackleBlock,
                    bonusEarthDamage = bonusCharacteristics.bonusEarthDamage,
                    bonusFireDamage = bonusCharacteristics.bonusFireDamage,
                    bonusWaterDamage = bonusCharacteristics.bonusWaterDamage,
                    bonusAirDamage = bonusCharacteristics.bonusAirDamage,
                    APRemoval = bonusCharacteristics.APRemoval
                })
            end
    
            local ret = self.tools.dictionnary()
            for _, v in pairs(grades) do
                ret:Add(v.Fields.grade, self.tools.object({
                    monsterId = v.Fields.monsterId,
                    level = v.Fields.level,
                    lifePoints = v.Fields.lifePoints,
                    actionPoints = v.Fields.actionPoints,
                    movementPoints = v.Fields.movementPoints,
                    vitality = v.Fields.vitality,
                    paDodge = v.Fields.paDodge,
                    pmDodge = v.Fields.pmDodge,
                    earthResistance = v.Fields.earthResistance,
                    airResistance = v.Fields.airResistance,
                    fireResistance = v.Fields.fireResistance,
                    waterResistance = v.Fields.waterResistance,
                    neutralResistance = v.Fields.neutralResistance,
                    gradeXp = v.Fields.gradeXp,
                    damageReflect = v.Fields.damageReflect,
                    hiddenLevel = v.Fields.hiddenLevel,
                    wisdom = v.Fields.wisdom,
                    strenght = v.Fields.strenght,
                    intelligence = v.Fields.intelligence,
                    chance = v.Fields.chance,
                    agility = v.Fields.agility,
                    bonusRange = v.Fields.bonusRange,
                    startingSpellId = v.Fields.startingSpellId,
                    bonusCharacteristics = parseBonusCharacteristics(v.Fields.bonusCharacteristics.Fields)
                }))
            end
    
            return ret
        end
    
        local parseDrops = function(drops)
            local ret = self.tools.dictionnary()
            for _, v in pairs(drops) do
                ret:Add(v.Fields.objectId, self.tools.object(v.Fields))
            end
    
            return ret
        end
    
        local monster = self.tools.object({
            id = data.id,
            race = data.race,
            grades = parseGrade(data.grades),
            isBoss = data.isBoss,
            drops = parseDrops(data.drops),
            subAreas = self.tools.list():CreateWith(data.subareas),
            favoriteSubareaId = data.favoriteSubareaId,
            isMiniBoss = data.isMiniBoss,
            isQuestMonster = data.isQuestMonster,
            correspondingMiniBossId = data.correspondingMiniBossId,
            canPlay = data.canPlay,
            canTackle = data.canTackle,
            canBePushed = data.canBePushed,
            canSwitchPos = data.canSwitchPos,
        })
        return monster
    end
    return nil
end

function Monsters:GetFavoriteSubArea(idMonster)
    local monster = self:GetMonsterObject(idMonster)
    if monster then return monster.favoriteSubareaId end
    return nil
end

function Monsters:GetMonsterDrops(idMonster)
    local monster = self:GetMonsterObject(idMonster)
    if monster then return monster.drops end
    return nil
end

function Monsters:GetMonsterSubArea(idMonster)
    local monster = self:GetMonsterObject(idMonster)
    if monster then return monster.subAreas end
    return nil
end

function Monsters:GetMonsterIdByDropId(dropId)
    local data = d2data:objectFromD2O("Items", dropId).Fields
    if data then
        local ret = self.tools.list(data.dropMonsterIds)
        return ret
    end
    return nil
end

function Monsters:GetMonstersInfoByGrade(idMonster, grade)
    grade = grade or 1
    local monster = self:GetMonsterObject(idMonster)
    if monster then return monster.grades:Get(grade) end
    return nil
end



return Monsters