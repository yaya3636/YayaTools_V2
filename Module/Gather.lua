Gather = {}

Gather.elementsToGather = {}

Gather.harvestableElements = {}

Gather.sortedElementsByPriority = {}
Gather.sortedElementsByDist = {}
Gather.sortedFinish = true

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