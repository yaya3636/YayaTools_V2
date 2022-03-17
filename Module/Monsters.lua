Monsters = {}

Monsters.d2oMonstersPath = global:getCurrentDirectory() .. [[\YayaTools\Data\D2O\Monsters.json]]
Monsters.d2oMonsters = {}

function Monsters:InitD2oProperties()
    local d2oMonsters = self.tools.dictionnary()
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
            ret:Add(v.dropId, self.tools.object(v))
        end

        return ret
    end

    for _, v in pairs(self.d2oMonsters) do
        d2oMonsters:Add(v.id, self.tools.object({
            id = v.id,
            race = v.race,
            grades = parseGrade(v.grades),
            isBoss = v.isBoss,
            drops = parseDrops(v.drops),
            subAreas = self.tools.list():CreateWith(v.subareas, #v.subareas),
            favoriteSubareaId = v.favoriteSubareaId,
            isMiniBoss = v.isMiniBoss,
            isQuestMonster = v.isQuestMonster,
            correspondingMiniBossId = v.correspondingMiniBossId,
            canPlay = v.canPlay,
            canTackle = v.canTackle,
            canBePushed = v.canBePushed,
            canSwitchPos = v.canSwitchPos,
        }))
    end

    self.d2oMonsters = d2oMonsters
end


function Monsters:GetFavoriteSubArea(idMonster)
    return self.d2oMonsters:Get(idMonster).favoriteSubareaId
end

function Monsters:GetMonsterDrops(idMonster)
    return self.d2oMonsters:Get(idMonster).drops
end

function Monsters:GetMonsterSubArea(idMonster)
    return self.d2oMonsters:Get(idMonster).subAreas
end

function Monsters:GetMonsterIdByDropId(dropId)
    local ret = self.tools.list()
    for _, monster in pairs(self.d2oMonsters:Enumerate()) do
        if monster.drops:ContainsKey(dropId) then
            ret:Add(monster.id)
        end
    end
    return ret
end

function Monsters:GetMonstersInfoByGrade(idMonster, grade)
    grade = grade or 1
    return self.d2oMonsters:Get(idMonster).grades:Get(grade)
end

function Monsters:GetMonsterObject(idMonster)
    return self.d2oMonsters:Get(idMonster)
end

return Monsters