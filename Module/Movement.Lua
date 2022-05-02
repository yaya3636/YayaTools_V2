Movement = {}

Movement.forbiddenHavenbagMap = {

    { map = 165153537, path = "left" },

    --Mine Ebbernard

    { map = 29622275, path = "450" },
    { map = 29622272, path = "450" },
    { map = 29622531, path = "450" },
    { map = 29622534, path = "424" },

    -- Mine manganese ile dragoeuf

    { map = 86246410, path = "431" },

    -- Mine Bwork

    { map = 104860165, path = "444" },
    { map = 104859139, path = "444" },
    { map = 104860169, path = "263" },
    { map = 104861193, path = "254" },
    { map = 104859145, path = "457" },
    { map = 104858121, path = "507" },
    { map = 104861189, path = "451" },
    { map = 104862213, path = "376" },
    { map = 104858119, path = "207" },

    { map = 104861191, path = "457" },
    { map = 104860167, path = "478" },
    { map = 104859143, path = "543" },
    { map = 104862215, path = "472" },


    -- Mine Maksage

    { map = 57017861, path = "270" },
    { map = 56886787, path = "396" },
    { map = 56885763, path = "436" },
    { map = 57016837, path = "401" },
    { map = 57016835, path = "409" },
    { map = 57017859, path = "395" },

    -- Malle au tresor
    { map = 128452097, path = "504" },
    { map = 128451073, door = "549" },

    -- Zone astrub

    { map = 188745734, path = "bottom" },

    -- Territoire des porco

    { map = 72619524, path = "left" },

    -- Amakna

    { map = 88085773, path = "left" },
    { map = 88082193, path = "right" },

}

Movement.forbiddenZaap = {}

Movement.printedInfo = false

Movement.compRzListMapId = {}
Movement.rzListMapId = {}
Movement.rzLogMapId = {}
Movement.loadedMinePath = {}
Movement.lastMapId = 0
Movement.rzNextMapId = -1
Movement.rzMaxDist = -1

Movement.teleported = false
Movement.forceTP = false
Movement.tpOn = false
Movement.tpDestination = -1
Movement.roadLoaded = false
Movement.startTimeInMap = 0
Movement.timeoutReached = false

Movement.zaapAvailable = {}
Movement.rcvZaapDestination = false

function Movement:InitProperties()
    for k, vMap in pairs(self.mineGraphData:Enumerate()) do
        for _, v in pairs(vMap.moveMapInfo) do
            self.mineGraph:AddEdge(vMap.mapId, v.toMapId, 1.0)
        end
    end
    self.compRzListMapId = self.tools.list()
    self.rzListMapId = self.tools.list()
    self.rzLogMapId = self.tools.list()
    self.loadedMinePath = self.tools.dictionnary()
    local tmp = self.forbiddenHavenbagMap
    self.forbiddenHavenbagMap = self.tools.dictionnary()
    self.zaapAvailable = self.tools.dictionnary()
    for _, v in pairs(tmp) do
        self.forbiddenHavenbagMap:Add(v.map, self.tools.object(v))
    end
end

function Movement:InitCallBack()
    local currentMapMessage = function(msg) Movement:CB_CurrentMapMessage(msg) end
    local zaapDestinationsMessage = function(msg) Movement:CB_ZaapDestinationMessage(msg) end

    self.packet:SubManager({
        ["CurrentMapMessage"] = currentMapMessage,
        ["ZaapDestinationsMessage"] = zaapDestinationsMessage,
    })
end

function Movement:RoadZone(listMapId, listExcludeMapId)
    listExcludeMapId = listExcludeMapId or self.tools.list()
    if listMapId.c == nil then
        self.tools:Print("Movement : La méthode nécéssite une (List) comme paramètre, essayer Movement:RoadZone(Tools.list(tableMapId))", "error")
        return
    end
    if not listMapId:IsEmpty() and not self.timeoutReached then
        if not self.compRzListMapId:Equal(listMapId) then -- Nouvelle list on reset
            self.teleported = false
            self.compRzListMapId = listMapId:MakeCopy()
            self.rzListMapId = listMapId:MakeCopy()
            self.rzLogMapId:Clear()
            self.rzNextMapId = -1

            local dist = 0
            local refMap = listMapId:Get(1)
            for _, v in pairs(listMapId:Enumerate()) do
                local clcDist = map:GetPathDistance(refMap, v)
                if clcDist > dist then
                    dist = clcDist
                end
            end
            self.rzMaxDist = dist
        end

        if map:currentMapId() == self.rzNextMapId or self.rzNextMapId == -1 then -- Arrivé sur la map ou init
            self.tools:Print("Arrivé a destination")
            if self.rzLogMapId:Size() >= math.floor((self.rzListMapId:Size() / 4) * 3) then -- Suppresion des log au 3/4 de la list
                self.rzLogMapId:RemoveAt(1)
            end

            self.rzListMapId:Shuffle()

            local foundedNextMap = false

            for _, vMapId in pairs(self.rzListMapId:Enumerate()) do -- Séléction de la prochaine map
                if not self.rzLogMapId:Contains(vMapId) and not listExcludeMapId:Contains(vMapId) and map:GetPathDistance(map:currentMapId(), vMapId) >= self.rzMaxDist / 2.5 then
                    self.rzLogMapId:Add(vMapId)
                    self.rzNextMapId = vMapId
                    --self.tools:Print("RzNext trouvé")
                    foundedNextMap = true
                    break
                end
            end

            if not foundedNextMap then
                --self.tools:Print("Debug rzNext")
                --self.tools:Dump(self.rzListMapId)
                for _, vMapId in pairs(self.rzListMapId:Enumerate()) do -- Séléction de la prochaine map
                    if not self.rzLogMapId:Contains(vMapId) and not listExcludeMapId:Contains(vMapId) then
                        self.rzLogMapId:Add(vMapId)
                        self.rzNextMapId = vMapId
                        --self.tools:Print("RzNext trouvé")
                        foundedNextMap = true
                        break
                    end
                end
            end

            if self:InMine() and self:IsMine(self.rzNextMapId) then
                --self.tools:Print("Chargement path mine", "Info")
                self:LoadMinePath()
            end
            self.tools:Print("RzNext = " .. self.rzNextMapId)
        end

        if self.lastMapId ~= map:currentMapId() then
            self.startTimeInMap = os.time()
            self.timeoutReached = false
        elseif os.difftime(os.time(), self.startTimeInMap) > 60 then
            self.tools:Print("Aucun changement de map détecté depuis 1 min, go havresac pour reset", "Movement")
            self.timeoutReached = true
            self:HavenBag()
        end

        self.lastMapId = map:currentMapId()

        if self:InMine() and self:IsMine(self.rzNextMapId) then
            --self.tools:Print("Dans une mine", 'Info')
            self:MoveMine()
        else
            self:LoadRoad(self.rzNextMapId)
            self:MoveNext() -- Tentative de déplacement
        end
        self.rzNextMapId = -1 -- On reset la prochaine map en cas d'echec de movement
        self:RoadZone(listMapId) -- On relance la fonction pour trouver une autre map
    elseif listMapId:IsEmpty() then
        self.tools:Print("Movement:RoadZone(listMapId, listExcludeMapId) listMapId is empty !", "error")
    elseif self.timeoutReached then
        self.tools:Print("Movement : Aucun changement de map détecté depuis 1 min", "error")
    end
end

function Movement:MoveMine(retry)
    local path = self.loadedMinePath:Get(map:currentMapId())

    if path then
        if path.path then
            map:changeMap(path.path)
        else
            map:door(path.door)
        end
    elseif not retry then
        if self.rzNextMapId == map:currentMapId() then
            self.tools:Print("Retry but equal : RzNext " .. self.rzNextMapId)
            self.rzNextMapId = -1
            self:RoadZone(self.compRzListMapId)
        end
        self.tools:Print("Retry : RzNext " .. self.rzNextMapId)
        self:LoadMinePath()
        self:MoveMine(true)
    else
        self.tools:Print("No path")
        self:HavenBag()
    end
    global:delay(2000)
end

function Movement:LoadRoad(mapIdDest)
    if mapIdDest ~= -1 then
        if self.character.isInDialog then
            self.tools:Print("Le personnage a un dialog ouvert, on quitte le dialog", "Movement")
            global:leaveDialog()
        end
    
        if self.tools:Equal(map:currentArea(), "Incarnam") and not self.tools:Equal(self.zone:GetAreaName(self.zone:GetAreaIdByMapId(mapIdDest)), "Incarnam") then -- Si on est a incarnam et que notre prochaine map et en dehors de incarnam
            if not self.printedInfo then
                self.tools:Print("On part de Incarnam !", "Movement")
                self.printedInfo = true
            end
            if map:currentMapId() ~= 153880835 then
                map:moveToward(153880835)
            else
                self.printedInfo = false
                map:door(430)
                self.character.dialog:CreateDialog(4398, self.tools.list({36982, 36980}))
            end
        end
    
        if not self.tools:Equal(map:currentArea(), "Incarnam") and self.tools:Equal(self.zone:GetAreaName(self.zone:GetAreaIdByMapId(mapIdDest)), "Incarnam") then -- Si on est pas a incarnam et que notre prochaine map et a incarnam
            if not self.printedInfo then
                self.tools:Print("On va a Incarnam !", "Movement")
                self.printedInfo = true
            end
            if map:currentMapId() ~= 192416776 then
                self:LoadRoad(192416776)
                self:MoveNext()
            else
                self.printedInfo = false
                map:door(455)
            end
        end
    
        if map:GetPathDistance(map:currentMapId(), mapIdDest) > 15 and not self.teleported or map:currentMap() == "0,0" and not self:InMine() and not self.teleported and not self.tools:Equal(map:currentArea(), "Incarnam") or self.forceTP then
            self:HavenBagTP(mapIdDest, "La prochaine map est a plus de 15 map, on se téléporte", self.forbiddenZaap)
        end
    
        local currentMapId = map:currentMapId()
        if currentMapId ~= mapIdDest and not self.roadLoaded then
            if not map:loadMove(mapIdDest) then
                self.tools:Print("Impossible de charger un chemin jusqu'a la map ("..mapIdDest..")", "LoadRoad")
            else
                self.roadLoaded = true
            end
        elseif currentMapId == mapIdDest and self.roadLoaded then
            self.tools:Print("Nous somme arrivé sur la carte de destination ("..mapIdDest..")", "Movement")
            self.roadLoaded = false
            self.teleported = false
        elseif currentMapId == mapIdDest and not self.roadLoaded then
            self.tools:Print("Vous êtes déjà sur la carte de destination ("..mapIdDest..")", "Movement")
        end
    
    end
end

function Movement:MoveNext()
    map:moveRoadNext()
    global:delay(2000)
end

function Movement:InMapChecker(listMapId)
    if listMapId:Contains(map:currentMapId()) then return true end
    return false
end

function Movement:HavenBag()
    if self.forbiddenHavenbagMap:ContainsKey(map:currentMapId()) then -- Une map ou on peut pas havresac
        local obj = self.forbiddenHavenbagMap:Get(map:currentMapId())
        if obj:HasProperties("door") then
            map:door(obj.door)
        elseif obj:HasProperties("path") then
            if tonumber(obj.path) == nil then
                map:changeMap(obj.path)
            else
                map:moveToCell(tonumber(obj.path))
            end
        end
        global:delay(1000)
    end

    if map:currentMap() ~= "0,0" or map:currentMap() == "0,0" and map:currentMapId() == 88212247 then
        self.timeoutReached = false
        map:changeMap('havenbag')
        global:delay(1000)
    end
end

function Movement:UseZaap(mapIdDest, zaapExcepted)
    local source = 3

    if map:currentMap() ~= "0,0" then
        source = 0
    end

    --local closestZaap = map:closestZaapV2(mapIdDest, zaapExcepted)
    self.rcvZaapDestination = false
    map:closestZaapV2(0)
    local closestZaap = self:ClosestZaap(mapIdDest)
    self.tpDestination = closestZaap
    self.tpOn = true

    if closestZaap == 0 then
        self.tools:Print("Aucun zaap trouvée pour la map (" .. mapIdDest .. ")", "error")
        global:leaveDialog()
        map:changeMap('havenbag')
    else
        map:toZaap(closestZaap, source)
        --global:leaveDialog()
    end
end

function Movement:HavenBagTP(dest, message, forbiddenZaap)
    if not self.teleported then
        self:HavenBag()
        if type(message) == "string" then
            self.tools:Print(message, "Movement")
        end
        Movement:UseZaap(dest, forbiddenZaap)
        global:delay(1000)
    end
end

function Movement:IsMine(mapId)
    return self.mineGraphData:ContainsKey(mapId)
end

function Movement:InMine()
    return self:IsMine(map:currentMapId())
end

function Movement:LoadMinePath()
    self.loadedMinePath:Clear()

    local dijkstra = self.tools.dijkstra()
    dijkstra:Run(self.mineGraph, map:currentMapId())
    if dijkstra:HasPathTo(self.rzNextMapId) then
        local stackMap = dijkstra:GetPathTo(self.rzNextMapId)
        for i = 1, stackMap:Size() do
            local fromMapId = stackMap:Get(i):From()
            local toMapId = stackMap:Get(i):To()
            local changeMapInfo = self.mineGraphData:Get(fromMapId)

            for _, v in  pairs(changeMapInfo.moveMapInfo) do
                if self.tools:Equal(v.toMapId, toMapId) then
                    if v.path then
                        self.loadedMinePath:Add(fromMapId, self.tools.object({
                            map = fromMapId,
                            path = v.path
                        }))
                    else
                        self.loadedMinePath:Add(fromMapId, self.tools.object({
                            map = fromMapId,
                            door = v.door
                        }))
                    end
                end
            end
            --self.tools:Print("Mine path loaded", "Info")
        end
    else
        self.tools:Print("Dijkstra ne trouve aucun path depuis la carte (" .. map:currentMapId() .. ") vers la map (" .. self.rzNextMapId .. ")", "Error")  
    end
end

function Movement:ClosestZaap(mapIdDest)
    while self.rcvZaapDestination == false do global:delay(50) end
    local dist, mapClosest = 99999, 0
    for _, v in pairs(self.zaapAvailable:Enumerate()) do
        local clcDist = self:MapDistance(v.mapId, mapIdDest)
        if clcDist < dist and v.cost < character:kamas() then
            dist = clcDist
            mapClosest = v.mapId
        end
    end
    return mapClosest
end

function Movement:MapDistance(mapIdStart, mapIdEnd)
    local startX = map:getX(mapIdStart)
    local startY = map:getY(mapIdStart)
    local endX = map:getX(mapIdEnd)
    local endY = map:getY(mapIdEnd)

    local dist = 0

    local function countDist(a,b)
        for _ = a, b do
            dist = dist + 1
        end
    end

    if startX > endX then
        countDist(endX, startX)
    else
        countDist(startX, endX)
    end

    if startY > endY then
        countDist(endY, startY)
    else
        countDist(startY, endY)
    end

    return dist
end

function Movement:CB_CurrentMapMessage(msg)
    if self.tpOn then
        if msg.mapId == self.tpDestination then
            --self.tools:Print("teleported = true")
            self.teleported = true
            self.tpOn = false
        end
    end

    if msg.mapId == self.rzNextMapId then
        --self.tools:Print("teleported = false")
        self.teleported = false
    end
end

function Movement:CB_ZaapDestinationMessage(msg)
    for _, v in pairs(msg.destinations) do
        if not self.zaapAvailable:ContainsKey(v.mapId) then
            self.tools:Print("Le zaap de la sous zone (" .. self.zone:GetSubAreaName(v.subAreaId) .. ") a bien été pris en compte", "Movement")
            self.zaapAvailable:Add(v.mapId, self.tools.object({
                type = v.type,
                mapId = v.mapId,
                subAreaId = v.subAreaId,
                level = v.level,
                cost = v.cost
            }))
        else
            local tmp = self.zaapAvailable:Get(v.mapId)
            tmp.cost = v.cost
            self.zaapAvailable:Set(v.mapId, tmp)
        end
    end
    self.rcvZaapDestination = true
end

return Movement