Monsters = {}

Monsters.monstersFilesPath = global:getCurrentDirectory() .. "\\YayaTools\\Data\\Monsters\\MonstersFilesById\\"

Monsters.unModifiedMonstersLoaded = false

Monsters.unModifiedMonsters = {}
Monsters.modifiedMonsters = {}


function Monsters:GetMonsterName(idMonster)
    local monsterInfo = self.json:decode(self.tools:ReadFile(self.monstersFilesPath .. idMonster .. ".json"))

    if monsterInfo then
        return monsterInfo.monsterName
    end
    return nil
end

function Monsters:GetFavoriteSubArea(idMonster)
    local monsterInfo = self.json:decode(self.tools:ReadFile(self.monstersFilesPath .. idMonster .. ".json"))

    if monsterInfo then
        return monsterInfo.favoriteSubArea
    end
    return nil
end

function Monsters:GetMonsterDrops(idMonster)
    local monsterInfo = self.json:decode(self.tools:ReadFile(self.monstersFilesPath .. idMonster .. ".json"))

    if monsterInfo then
        return monsterInfo.drops
    end
    return nil
end

function Monsters:GetMonsterSubArea(idMonster)
    local monsterInfo = self.json:decode(self.tools:ReadFile(self.monstersFilesPath .. idMonster .. ".json"))

    if monsterInfo then
        return monsterInfo.subAreas
    end
    return nil
end

function Monsters:GetMonsterIdByDropId(dropId)
    local ret = {}
    for _, monster in pairs(self.modifiedMonsters) do
        for _, drop in pairs(monster.drops) do
            if drop.dropId == dropId then
                table.insert(ret, monster.monsterId)
                break
            end
        end

    end
    return ret
end

function Monsters:GetMonstersInfoByGrade(idMonster, grade)
    if not self.unModifiedMonstersLoaded then
        self.tools:Print("Veuillez patientez quelque instants chargement des données !", "Tools")
        self.unModifiedMonsters = self.json:decode(self.tools:ReadFile(global:getCurrentDirectory() .. "\\YayaTools\\Data\\Monsters\\NoModifiedMonsters.json"))
        self.unModifiedMonstersLoaded = true
    end

    for _, v in pairs(self.unModifiedMonsters) do
        if self.tools:Equal(v.id, idMonster) then
            return v.grades[grade]
        end
    end

    return nil
end

return Monsters