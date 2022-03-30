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
            if self.restartAPI and self.isStarted then
                self.tools:Print("Une erreur c'est produite dans l'API, veuillez me MP pour résoudre le problème", "API")
            end
            self.restartAPI = false
            return nil
        else
            self.restartAPI = false
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

-- Monsters

function API.localAPI:GetMonster(monsterId)
    return self:PostRequest("monsters/getMonsters", "monsterId=" .. monsterId)
end

function API.localAPI:GetAllMonstersIds()
    local data = self:PostRequest("monsters/getAllMonstersIds", "")
    return self.tools.list(data)
end

function API.localAPI:GetMonsterIdByDropId(dropId)
    return self:PostRequest("monsters/getMonsterIdByDropId", "dropId=" .. dropId)
end

-- Recipes

function API.localAPI:GetRecipe(craftId)
    return self:PostRequest("recipes/getRecipe", "craftId=" .. craftId)
end

-- Zone

function API.localAPI:GetArea(areaId)
    return self:PostRequest("zone/getArea", "areaId=" .. areaId)
end

function API.localAPI:GetAreaIdByMapId(mapId)
    return self:PostRequest("zone/getAreaIdByMapId", "mapId=" .. mapId)
end

function API.localAPI:GetSubArea(subAreaId)
    return self:PostRequest("zone/getSubArea", "subAreaId=" .. subAreaId)
end

function API.localAPI:GetSubAreaIdByMapId(mapId)
    return self:PostRequest("zone/getSubAreaIdByMapId", "mapId=" .. mapId)
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