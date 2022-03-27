API = {}

API.localAPI = {}

API.localAPI.isStarted = false
API.localAPI.nbTryStartAPI = 0
API.localAPI.restartAPI = false
API.localAPI.localPort = ""
API.localAPI.localUrl = ""

API.dofusDB = {}
API.dofusDB.apiUrl = "https://api.dofusdb.fr/"


-- LocalAPI

function API.localAPI:StartAPI()
    if not self.isStarted then

        if self.nbTryStartAPI == 0 then
            self.tools:Print("Vérification de l'API", "API")
            self.tools:Print("Penser a installer NodeJS sur votre PC", "API")
        end

        self.nbTryStartAPI = self.nbTryStartAPI + 1

        if self.nbTryStartAPI > 2 then
            self.tools:Print("Impossible de lancer l'API vérifier les pré-requis", "API")
            return
        end
        if developer:getRequest(self.localUrl .. "startedAPI") ~= "sucess" then
            if self.nbTryStartAPI == 1 then
                self.tools:Print("L'API n'est pas exécuter, exécution du serveur", "API")
            end
            self.tools:ExecuteWinCMD("start " .. global:getCurrentDirectory() .. "\\YayaTools\\LocalAPI\\install.bat " .. global:getCurrentDirectory() .. "\\YAYA\\LocalAPI", true)
            self.tools:ExecuteWinCMD("start node " .. global:getCurrentDirectory() .. "\\YayaTools\\LocalAPI\\app.js")
            global:delay(5000)
            self:StartAPI()
            if self.nbTryStartAPI < 3 then
                self.tools:Print("L'API a été lancée", "API")
                self.isStarted = true
                self.restartAPI = false
            end
        else
            if self.nbTryStartAPI < 3 then
                self.tools:Print("L'API et déja exécuter", "API")
                self.isStarted = true
                self.restartAPI = false
            end
        end

    end
end

function API.localAPI:PostRequest(url, data)
    if self.isStarted then
        local result = self.json:decode(developer:postRequest(self.localUrl .. url, data))

        if result == nil then
            if not self.restartAPI then
                self.tools:Print("Result non définie, vérification de l'API", "API")
                self.isStarted = false
                self.nbTryStartAPI = 0
                self.restartAPI = true
                self:StartAPI()
                return self:PostRequest(url, data)
            end
            return nil
        else
            if result.status == "error" then
                self.tools:Print(result.message, "API")
                return nil
            elseif result.status == "success" then
                return result.result
            end
        end
    else
        if self.nbTryStartAPI >= 3 then
            self.tools:Print("L'API n'est pas exécuter, installer NodeJS et ne pas fermer l'invite de commande !", "API")
            return nil
        end
        self:StartAPI()
        return self:PostRequest(url, data)
    end
end

function API.localAPI:GetMonsterObject(monsterId)
    local data = self:PostRequest("monsters/getMonsters", "monsterId=" .. monsterId)

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

function API.localAPI:GetAllMonstersIds()
    local data = self:PostRequest("monsters/getAllMonstersIds", "")
    return self.tools.list(data)
end

function API.localAPI:GetMonsterIdByDropId(dropId)
    local data = self:PostRequest("monsters/getMonsterIdByDropId", "dropId=" .. dropId)
    local ret = self.tools.list(data)
    return ret
end
-- DofusDB

function API.dofusDB:GetHarvestablePosition(gatherId)
    self.localAPI:StartAPI()
    local data = self.localAPI:PostRequest("harvestable/getHarvestablePosition", "gatherId=" .. gatherId)
    local sortedData = self.tools.dictionnary()

    for i = 1, #data do
        for _, v in pairs(data[i]) do
            local sortedSubArea = sortedData:Get(tostring(v.subAreaId))

            if sortedSubArea == nil then
                sortedData:Add(tostring(v.subAreaId), self.tools.list())
                sortedSubArea = sortedData:Get(tostring(v.subAreaId))
            end

            local harvestableElementCtor = function(harvestableElement)
                local l = self.tools.list()
                for _, vHarves in pairs(harvestableElement) do
                    l:Add(self.tools.object({gatherId = vHarves.gatherId, quantity = vHarves.quantity}))
                end
                return l
            end

            local mapContruct = self.tools.object({
                mapId = v.mapId,
                posX = v.posX,
                posY = v.posY,
                subAreaId = v.subAreaId,
                worldMap = v.worldMap,
                harvestableElement = harvestableElementCtor(v.harvestableElement)
            })

            sortedSubArea:Add(mapContruct)
            sortedData:Set(tostring(v.subAreaId), sortedSubArea)
        end
    end

    return sortedData
end

function API.dofusDB:GetHarverstablePositionInSubArea(gatherId, subAreaId)
    local harvestablePosition = self:GetHarvestablePosition(gatherId)
    return harvestablePosition:Get(tostring(subAreaId))
end

function API.dofusDB:GetHarverstableMapIdInSubArea(gatherId, subAreaId)
    local ret = self.tools.list()
    local harvestablePosition = self:GetHarvestablePosition(gatherId)
    harvestablePosition = harvestablePosition:Get(tostring(subAreaId))
    for _, v in pairs(harvestablePosition:Enumerate()) do
        ret:Add(v.mapId)
    end
    return ret
end


function API.dofusDB:GetURL(gatherId)
    return "recoltable?resources[$in][]=" .. gatherId
end

return API