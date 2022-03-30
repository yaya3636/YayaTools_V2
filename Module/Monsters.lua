Monsters = {}

function Monsters:GetMonsterObject(idMonster)
    local data = self.api.localAPI:GetMonster(idMonster)
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
                ret:Add(v.grade, self.tools.object({
                    monsterId = v.monsterId,
                    level = v.level,
                    lifePoints = v.lifePoints,
                    actionPoints = v.actionPoints,
                    movementPoints = v.movementPoints,
                    vitality = v.vitality,
                    paDodge = v.paDodge,
                    pmDodge = v.pmDodge,
                    earthResistance = v.earthResistance,
                    airResistance = v.airResistance,
                    fireResistance = v.fireResistance,
                    waterResistance = v.waterResistance,
                    neutralResistance = v.neutralResistance,
                    gradeXp = v.gradeXp,
                    damageReflect = v.damageReflect,
                    hiddenLevel = v.hiddenLevel,
                    wisdom = v.wisdom,
                    strenght = v.strenght,
                    intelligence = v.intelligence,
                    chance = v.chance,
                    agility = v.agility,
                    bonusRange = v.bonusRange,
                    startingSpellId = v.startingSpellId,
                    bonusCharacteristics = parseBonusCharacteristics(v.bonusCharacteristics)
                }))
            end
    
            return ret
        end
    
        local parseDrops = function(drops)
            local ret = self.tools.dictionnary()
            for _, v in pairs(drops) do
                ret:Add(v.objectId, self.tools.object(v))
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
    local data = self.api.localAPI:GetMonsterIdByDropId(dropId)
    if data then
        local ret = self.tools.list(data)
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