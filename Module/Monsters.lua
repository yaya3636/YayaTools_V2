Monsters = {}

function Monsters:GetFavoriteSubArea(idMonster)
    local monster = self:GetMonsterObject(idMonster)
    return monster.favoriteSubareaId
end

function Monsters:GetMonsterDrops(idMonster)
    local monster = self:GetMonsterObject(idMonster)
    return monster.drops
end

function Monsters:GetMonsterSubArea(idMonster)
    local monster = self:GetMonsterObject(idMonster)
    return monster.subAreas
end

function Monsters:GetMonsterIdByDropId(dropId)
    return self.api.localAPI:GetMonsterIdByDropId(dropId)
end

function Monsters:GetMonstersInfoByGrade(idMonster, grade)
    grade = grade or 1
    local monster = self:GetMonsterObject(idMonster)
    return monster.grades:Get(grade)
end

function Monsters:GetMonsterObject(idMonster)
    return self.api.localAPI:GetMonsterObject(idMonster)
end

return Monsters