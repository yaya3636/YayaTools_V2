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

Movement.rzListMapId = {}
Movement.rzLogMapId = {}
Movement.rzNextMapId = -1

Movement.teleported = false
Movement.lastTpMapId = -1
Movement.roadLoaded = false

function Movement:InitProperties()
    self.rzListMapId = self.tools.list()
    self.rzLogMapId = self.tools.list()
    local tmp = self.forbiddenHavenbagMap
    self.forbiddenHavenbagMap = self.tools.dictionnary()
    for _, v in pairs(tmp) do
        self.forbiddenHavenbagMap:Add(v.map, self.tools.object(v))
    end
end

function Movement:InitCallBack()
    local currentMapMessage = function(msg) Movement:CB_CurrentMapMessage(msg) end

    self.packet:SubManager({
        ["CurrentMapMessage"] = currentMapMessage
    })
end

function Movement:RoadZone(listMapId)
    if listMapId.c == nil then
        self.tools:Print("Movement : La méthode nécéssite une (List) comme paramètre, essayer Movement:RoadZone(Tools.list(tableMapId))", "error")
        return
    end
    if not listMapId:IsEmpty() then
        if not self.rzListMapId:Equal(listMapId) then -- Nouvelle list on reset
            self.rzLogMapId:Clear()
            self.rzListMapId = listMapId
            self.rzNextMapId = -1
        end

        if map:currentMapId() == self.rzNextMapId or self.rzNextMapId == -1 then -- Arrivé sur la map ou init
            if self.rzLogMapId:Size() >= math.floor((self.rzListMapId:Size() / 4) * 3) then -- Suppresion des log au 3/4 de la list
                self.rzLogMapId:RemoveAt(1)
            end

            self.rzListMapId:Shuffle()

            for _, vMapId in pairs(self.rzListMapId:Enumerate()) do -- Séléction de la prochaine map
                if not self.rzLogMapId:Contains(vMapId) then
                    self.rzLogMapId:Add(vMapId)
                    self.rzNextMapId = vMapId
                    break
                end
            end
        end

        self:LoadRoad(self.rzNextMapId)
        self:MoveNext() -- Tentative de déplacement
        self.rzNextMapId = -1 -- On reset la prochaine map en cas d'echec de movement
        self:RoadZone(listMapId) -- On relance la fonction pour trouver une autre map
    end
end

function Movement:LoadRoad(mapIdDest)
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


    if map:GetPathDistance(map:currentMapId(), mapIdDest) > 15 and not self.teleported or map:currentMap() == "0,0" and not self.teleported then
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

function Movement:MoveNext()
    map:moveRoadNext()
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

    if map:currentMap() ~= "0,0" then
        map:changeMap('havenbag')
        global:delay(1000)
    end
end

function Movement:UseZaap(mapIdDest, zaapExcepted)
    local source = 3

    if map:currentMap() ~= "0,0" then
        source = 0
    end

    local closestZaap = map:closestZaapV2(mapIdDest, zaapExcepted)

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
        self.lastTpMapId = dest
        Movement:UseZaap(dest, forbiddenZaap)
        global:delay(1000)
    end
end

function Movement:CB_CurrentMapMessage(msg)
    if msg.mapId == self.lastTpMapId then
        self.teleported = true
    else
        self.teleported = false
    end
end

return Movement