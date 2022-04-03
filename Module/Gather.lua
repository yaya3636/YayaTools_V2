Gather = {}

Gather.elementsToGather = {}

Gather.harvestableElements = {}

Gather.sortedElementsByPriority = {}
Gather.sortedElementsByDist = {}
Gather.sortedFinish = true

Gather.gatherInfo = {
    -- Bucheron
    Frene =  { name = "Frêne", gatherId = 1, objectId = 303, jobId = 2, minLvlToFarm = 1 },
    Chataignier =  { name = "Châtaignier", gatherId = 33, objectId = 473, jobId = 2, minLvlToFarm = 20 },
    Noyer = { name = "Noyer", gatherId = 34, objectId = 476, jobId = 2, minLvlToFarm = 40 },
    Chene = { name = "Chêne", gatherId = 8, objectId = 460, jobId = 2, minLvlToFarm = 60 },
    Bombu = { name = "Bombu", gatherId = 98, objectId = 2358, jobId = 2, minLvlToFarm = 70 },
    Erable = { name = "Erable", gatherId = 31, objectId = 471, jobId = 2, minLvlToFarm = 80 },
    Oliviolet = { name = "Oliviolet", gatherId = 101, objectId = 2357, jobId = 2, minLvlToFarm = 90 },
    If = { name = "If", gatherId = 28, objectId = 461, jobId = 2, minLvlToFarm = 100 },
    Bambou = { name = "Bambou", gatherId = 108, objectId = 7013, jobId = 2, minLvlToFarm = 110 },
    Merisier = { name = "Merisier", gatherId = 35, objectId = 474, jobId = 2, minLvlToFarm = 120 },
    Noisetier = { name = "Noisetier", gatherId = 259, objectId = 16488, jobId = 2, minLvlToFarm = 130 },
    Ebene = { name = "Ebène", gatherId = 29, objectId = 449, jobId = 2, minLvlToFarm = 140 },
    Kaliptus = { name = "Kaliptus", gatherId = 121, objectId = 7925, jobId = 2, minLvlToFarm = 150 },
    Charme = { name = "Charme", gatherId = 32, objectId = 472, jobId = 2, minLvlToFarm = 160 },
    BambouSombre = { name = "Bambou Sombre", gatherId = 109, objectId = 7016, jobId = 2, minLvlToFarm = 170 },
    Orme = { name = "Orme", gatherId = 30, objectId = 470, jobId = 2, minLvlToFarm = 180 },
    BambouSacre = { name = "Bambou Sacré", gatherId = 110, objectId = 7014, jobId = 2, minLvlToFarm = 190 },
    Tremble = { name = "Tremble", gatherId = 133, objectId = 11107, jobId = 2, minLvlToFarm = 200 },
    -- Alchimiste
    Ortie = { name = "Ortie", gatherId = 254, objectId = 421, jobId = 26, minLvlToFarm = 1 },
    Sauge = { name = "Sauge", gatherId = 255, objectId = 428, jobId = 26, minLvlToFarm = 20 },
    Trefle = { name = "Trèfle à 5 feuilles", gatherId = 67, objectId = 395, jobId = 26, minLvlToFarm = 40 },
    MentheSauvage = { name = "Menthe Sauvage", gatherId = 66, objectId = 380, jobId = 26, minLvlToFarm = 60 },
    OrchideeFreyesque = { name = "Orchidée Freyesque", gatherId = 68, objectId = 593, jobId = 26, minLvlToFarm = 80 },
    Edelweiss = { name = "Edelweiss", gatherId = 61, objectId = 594, jobId = 26, minLvlToFarm = 100 },
    Pandouille = { name = "Graine de pandouille", gatherId = 112, objectId = 7059, jobId = 26, minLvlToFarm = 120 },
    Ginseng = { name = "Ginseng", gatherId = 256, objectId = 16385, jobId = 26, minLvlToFarm = 140 },
    Belladone = { name = "Belladone", gatherId = 257, objectId = 16387, jobId = 26, minLvlToFarm = 160 },
    Mandragore = { name = "Mandragore", gatherId = 258, objectId = 16389, jobId = 26, minLvlToFarm = 180 },
    PerceNeige = { name = "Perce-Neige", gatherId = 131, objectId = 11102, jobId = 26, minLvlToFarm = 200 },
    Salikrone = { name = "Salikrone", gatherId = 288, objectId = 17992, jobId = 26, minLvlToFarm = 200 },
    TulipeEnPapier = { name = "Tulipe en papier", gatherId = 364, objectId = 23824, jobId = 26, minLvlToFarm = 200 },
    -- Mineur
    Fer = { name = "Fer", gatherId = 17, objectId = 312, jobId = 24, minLvlToFarm = 1 },
    Cuivre = { name = "Cuivre", gatherId = 53, objectId = 441, jobId = 24, minLvlToFarm = 20 },
    Bronze = { name = "Bronze", gatherId = 55, objectId = 442, jobId = 24, minLvlToFarm = 40 },
    Kobalte = { name = "Kobalte", gatherId = 37, objectId = 443, jobId = 24, minLvlToFarm = 60 },
    Manganese = { name = "Manganèse", gatherId = 54, objectId = 445, jobId = 24, minLvlToFarm = 80 },
    Etain = { name = "Etain", gatherId = 52, objectId = 444, jobId = 24, minLvlToFarm = 100 },
    Silicate = { name = "Silicate", gatherId = 114, objectId = 7032, jobId = 24, minLvlToFarm = 100 },
    Argent = { name = "Argent", gatherId = 24, objectId = 350, jobId = 24, minLvlToFarm = 120 },
    Bauxite = { name = "Bauxite", gatherId = 26, objectId = 446, jobId = 24, minLvlToFarm = 140 },
    Or = { name = "Or", gatherId = 25, objectId = 313, jobId = 24, minLvlToFarm = 160 },
    Dolomite = { name = "Dolomite", gatherId = 113, objectId = 7033, jobId = 24, minLvlToFarm = 180 },
    Obsidienne = { name = "Obsidienne", gatherId = 135, objectId = 11110, jobId = 24, minLvlToFarm = 200 },
    -- Paysan
    Ble = { name = "Blé", gatherId = 38, objectId = 289, jobId = 28, minLvlToFarm = 1 },
    Orge = { name = "Orge", gatherId = 43, objectId = 400, jobId = 28, minLvlToFarm = 20 },
    Avoine = { name = "Avoine", gatherId = 45, objectId = 533, jobId = 28, minLvlToFarm = 40 },
    Houblon = { name = "Houblon", gatherId = 39, objectId = 401, jobId = 28, minLvlToFarm = 60 },
    Lin = { name = "Lin", gatherId = 42, objectId = 423, jobId = 28, minLvlToFarm = 80 },
    Riz = { name = "Riz", gatherId = 111, objectId = 7018, jobId = 28, minLvlToFarm = 100 },
    Seigle = { name = "Seigle", gatherId = 44, objectId = 532, jobId = 28, minLvlToFarm = 100 },
    Malt = { name = "Malt", gatherId = 47, objectId = 405, jobId = 28, minLvlToFarm = 120 },
    Chanvre = { name = "Chanvre", gatherId = 46, objectId = 425, jobId = 28, minLvlToFarm = 140 },
    Mais = { name = "Maïs", gatherId = 260, objectId = 16454, jobId = 28, minLvlToFarm = 160 },
    Millet = { name = "Millet", gatherId = 261, objectId = 16456, jobId = 28, minLvlToFarm = 180 },
    Frostiz = { name = "Frostiz", gatherId = 134, objectId = 11109, jobId = 28, minLvlToFarm = 200 },
    -- Pêcheur
    Goujon = { name = "Goujon", gatherId = 75, objectId = 1782, jobId = 36, minLvlToFarm = 1 },
    Greuvette = { name = "Greuvette", gatherId = 71, objectId = 598, jobId = 36, minLvlToFarm = 10 },
    Truite = { name = "Truite", gatherId = 74, objectId = 1844, jobId = 36, minLvlToFarm = 20 },
    Crabe = { name = "Crab Sourimis", gatherId = 77, objectId = 1757, jobId = 36, minLvlToFarm = 30 },
    PoissonChaton = { name = "Poisson-Chaton", gatherId = 76, objectId = 603, jobId = 36, minLvlToFarm = 40 },
    PoissonPane = { name = "Poisson Pané", gatherId = 78, objectId = 1750, jobId = 36, minLvlToFarm = 50 },
    CarpeDiem = { name = "Carpe d'Iem", gatherId = 79, objectId = 1794, jobId = 36, minLvlToFarm = 60 },
    SardineBrillante = { name = "Sardine Brillante", gatherId = 81, objectId = 1805, jobId = 36, minLvlToFarm = 70 },
    Brochet = { name = "Brochet", gatherId = 263, objectId = 1847, jobId = 36, minLvlToFarm = 80 },
    Kralamoure = { name = "Kralamoure", gatherId = 264, objectId = 600, jobId = 36, minLvlToFarm = 90 },
    Anguille = { name = "Anguille", gatherId = 265, objectId = 16461, jobId = 36, minLvlToFarm = 100 },
    DoradeGrise = { name = "Dorade Grise", gatherId = 266, objectId = 16463, jobId = 36, minLvlToFarm = 110 },
    Perche = { name = "Perche", gatherId = 267, objectId = 1801, jobId = 36, minLvlToFarm = 120 },
    RaieBleue = { name = "Raie Bleue", gatherId = 268, objectId = 1784, jobId = 36, minLvlToFarm = 130 },
    Lotte = { name = "Lotte", gatherId = 269, objectId = 16465, jobId = 36, minLvlToFarm = 140 },
    RequinMarteauFaucille = { name = "Requin Marteau-Faucille", gatherId = 270, objectId = 602, jobId = 36, minLvlToFarm = 150 },
    BarRikain = { name = "Bar Rikain", gatherId = 271, objectId = 1779, jobId = 36, minLvlToFarm = 160 },
    Morue = { name = "Morue", gatherId = 272, objectId = 16467, jobId = 36, minLvlToFarm = 170 },
    Tanche = { name = "Tanche", gatherId = 273, objectId = 16469, jobId = 36, minLvlToFarm = 180 },
    Espadon = { name = "Espadon", gatherId = 274, objectId = 16471, jobId = 36, minLvlToFarm = 190 },
    PichonDencre = { name = "Pichon d'encre", gatherId = 365, objectId = 23825, jobId = 36, minLvlToFarm = 200 },
    Poisskaille = { name = "Poisskaille", gatherId = 132, objectId = 11106, jobId = 36, minLvlToFarm = 200 },


    -- Autres
    Puits = { name = "Puits", gatherId = 84, objectId = 311, jobId = 2, minLvlToFarm = 1 }
}

function Gather:InitCallBack()
    local mapComplementaryInformationsDataMessage = function(msg) Gather:CB_MapComplementaryInformationsDataMessage(msg) end
    local changeMapMessage = function() Gather:CB_ChangeMapMessage() end
    self.packet:SubManager({
        ["MapComplementaryInformationsDataMessage"] = mapComplementaryInformationsDataMessage,
        ["ChangeMapMessage"] = changeMapMessage
    })

end

function Gather:GatherByDist()
    local i = 0
    while not self.sortedFinish do global:delay(50) i = i + 1 if i == 40 then break end end
    for _, v in pairs(self.sortedElementsByDist:Enumerate()) do
        map:door(v.elementCellId)
    end
end

function Gather:GatherByPriority()
    local i = 0
    while not self.sortedFinish do global:delay(50) i = i + 1 if i == 40 then break end end
    for _, v in pairs(self.sortedElementsByPriority:Enumerate()) do
        map:door(v.elementCellId)
    end
end

function Gather:AddGatherElement(gatherId, priority)
    local fnGatherId = function(v) return v.gatherId == gatherId end
    if priority == nil and not self.elementsToGather:Contains(fnGatherId) then
        self.elementsToGather:Add(self.tools.object({gatherId = gatherId, priority = self.elementsToGather:Size() + 1}))
    elseif not self.elementsToGather:Contains(fnGatherId) then
        local deletedElem = self.elementsToGather:Remove(priority)
        if deletedElem ~= nil then
            self.elementsToGather:Insert(priority, {gatherId = gatherId, priority = priority})
            self.elementsToGather:Insert(priority + 1, deletedElem)
        else
            self.elementsToGather:Insert(priority, {gatherId = gatherId, priority = priority})
        end
    end
end

function Gather:SetGatherPriority(gatherId, priority)
    if self.elementsToGather:Contains(gatherId) then
        local elem = self.elementsToGather:Get(priority)
        if elem ~= nil then
            self.elementsToGather:Set(priority, gatherId)
            self.elementsToGather:Add(elem)
        else
            self.elementsToGather:Set(priority, gatherId)
        end
    end
end

function Gather:RemoveGatherElement(gatherId)
    self.elementsToGather:Remove(gatherId)
end

function Gather:ClearGatherElement()
    self.elementsToGather:Clear()
end

function Gather:GetGatherInfo(objectId)
    return self.gatherInfo:Get(tostring(objectId))
end

function Gather:IsHarvestableObject(objectId)
    return self.gatherInfo:ContainsValue(function(v)
        if tostring(v.objectId) == tostring(objectId) then
            return true
        end
    end)
end

function Gather:CB_MapComplementaryInformationsDataMessage(msg) -- Update des element intéractif sur la carte
    local statedElements = msg.statedElements
    local integereractiveElements = msg.integereractiveElements

    for _, vInteractive in pairs(integereractiveElements) do -- On récupére les element intéractif présent sur la map
        if developer:typeOf(vInteractive) == "InteractiveElementWithAgeBonus" and vInteractive.onCurrentMap then
            if self.elementsToGather:Contains(function(v) return v.gatherId == vInteractive.elementTypeId end) then
                self.harvestableElements:Add(vInteractive.elementId, self.tools.object({ elementId = vInteractive.elementId, elementTypeId = vInteractive.elementTypeId }))
            end
        end
    end

    for _, vStatedElement in pairs(statedElements) do -- On tri les element intéractif en fonction des gatherId voulu, et on récupére les cellId
        if self.harvestableElements:ContainsKey(vStatedElement.elementId) then
            local tmp = self.harvestableElements:Get(vStatedElement.elementId)
            tmp.elementCellId = vStatedElement.elementCellId
            self.harvestableElements:Set(vStatedElement.elementId, tmp)
        end
    end

    -- On tri les element par distance, le premier element sera au plus proche de notre perso, le deuxieme element sera au plus proche du premier element ect ect
    local sortedElementByDist = self.tools.list()
    local startCell = map:currentCell()
    local copyHarvestableElements = self.harvestableElements:MakeCopy()

    while copyHarvestableElements:Size() > 0 do
        local minDist = 1000
        local key
        for k, v in pairs(copyHarvestableElements:Enumerate()) do
            local dist = self.tools:ManhattanDistanceCellId(startCell, v.elementCellId)
            if dist < minDist then
                key = k
                minDist = dist
            end
        end
        local elem = copyHarvestableElements:Get(key)
        startCell = elem.elementCellId
        sortedElementByDist:Add(elem)
        copyHarvestableElements:RemoveByKey(key)
    end

    self.sortedElementsByDist = sortedElementByDist

    -- Trie des element par priorité
    local sortedElementsByPriority = self.tools.list()
    startCell = map:currentCell()
    copyHarvestableElements = self.harvestableElements:MakeCopy()

    for i = 1, self.elementsToGather:Size() do
        local elemToGather = self.elementsToGather:Get(i)
        local sortedHarvestable = copyHarvestableElements:Sort(function(k, v) return v.elementTypeId == elemToGather.gatherId end)
        --self.tools:Dump(sortedHarvestable:Enumerate())
        while sortedHarvestable:Size() > 0 do
            local minDist = 1000
            local key
            for k, v in pairs(sortedHarvestable:Enumerate()) do
                local dist = self.tools:ManhattanDistanceCellId(startCell, v.elementCellId)
                if dist < minDist then
                    key = k
                    minDist = dist
                end
            end
            local elem = sortedHarvestable:Get(key)
            startCell = elem.elementCellId
            sortedElementsByPriority:Add(elem)
            sortedHarvestable:RemoveByKey(key)
        end
    end

    --self.tools:Dump(sortedElementByDist:Enumerate())
    --self.tools:Dump(sortedElementsByPriority:Enumerate())

    self.sortedElementsByPriority = sortedElementsByPriority
    self.sortedFinish = true
end

function Gather:CB_ChangeMapMessage() -- Reset des valeurs a chaque changement de map
    self.harvestableElements:Clear()
    self.sortedElementsByDist:Clear()
    self.sortedElementsByPriority:Clear()
    self.sortedFinish = false
end

return Gather