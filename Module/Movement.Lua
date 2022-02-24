Movement = {}

Movement.havenbagMap = {

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

Movement.teleported = false

Movement.roadLoaded = false

Movement.roadZoneNextMapId = -1

Movement.goToAstrub = false

function Movement:LoadRoad(mapIdDest)
    if self:Equal(map:currentArea(), "Incarnam") then
        if not self:Equal(self.zone:GetAreaName(self.zone:GetAreaIdByMapId(mapIdDest)), "Incarnam") then
            self.goToAstrub = true
            self:GoAstrub()
        end
    end

    if self.goToAstrub and map:currentMapId() == 192416776 then
        self.goToAstrub = false
        global:leaveDialog()
    end

    local currentMapId = map:currentMapId()
    if currentMapId ~= mapIdDest then
        if not map:loadMove(mapIdDest) then
            self:Print("Impossible de charger un chemin jusqu'a la map ("..mapIdDest..")", "LoadRoad")
        else
            self.roadLoaded = true
        end
    elseif currentMapId == mapIdDest then
        self.roadLoaded = false
    end
end

function Movement:RoadZone(tblMapId)
    if tblMapId ~= nil and self:LenghtOfTable(tblMapId) > 0 then
        if map:currentMapId() == self.roadZoneNextMapId or self.roadZoneNextMapId == -1 then

            self.roadZoneNextMapId = tblMapId[global:random(1, self:LenghtOfTable(tblMapId))]

            if not map:loadMove(self.roadZoneNextMapId) then
                self:Print("Impossible de charger un chemin jusqu'a la mapId : ("..self.roadZoneNextMapId..") changement de map avant re tentative", "RoadZone", "warn")
            end
        end

        map:moveRoadNext()

        self:Print("Apres MoveNext", "RoadZone")
        self.roadZoneNextMapId = -1
        self:RoadZone(tblMapId)
    else
        self:Print("Table nil", "RoadZone", "error")
    end
end

function Movement:InMapChecker(tbl)
    for _, v in pairs(tbl) do
        if map:currentMapId() == v then
            return true
        end
    end
    return false
end

function Movement:GoAstrub()
    if self:Equal(map:currentArea(), "Incarnam") then
        self:LoadRoad(153880835)
        local possibleIdReply = {
            36982,
            36980
        }

        if map:currentMapId() == 153880835 then
            npc:npc(4398, 3)
            global:delay(1000)
            if map:currentMapId() == 153880835 then
                npc:reply(36982)
                npc:reply(36980)
            end
        else
            map:moveRoadNext()
        end
    end
end

function Movement:HavenBag()
    local canHaven = true
    for _, v in pairs(self.havenbagMap) do
        if map:currentMapId() == v.map then
            canHaven = false
            if v.door then
                map:door(tonumber(v.door))
            elseif tonumber(v.path) == nil then
                map:changeMap(v.path)
            else
                map:moveToCell(tonumber(v.path))
            end
            global:delay(1000)
        end
    end

    if map:currentMap() ~= "0,0" and canHaven then
        map:changeMap('havenbag')
    end
end

function Movement:UseZaap(mapIdDest, zaapExcepted)
        local source = 3

        if map:currentMap() ~= "0,0" then
            source = 0
        end

        local closestZaap = map:closestZaapV2(mapIdDest, zaapExcepted)

        if closestZaap == 0 then
            self:Print("Aucun zaap trouvée pour la map (" .. mapIdDest .. ")", "error")
            global:leaveDialog()
            map:changeMap('havenbag')
            return false
        else
            self.teleported = true
            map:toZaap(closestZaap, source)
            global:leaveDialog()
            return false
        end
end

function Movement:HavenBagTP(dest, message, forbiddenZaap)
    if self.teleported == nil then
        self.teleported = true
    end

    if not self.teleported then
        self:HavenBag()
        if type(message) == "string" then
            self:Print(message, "Move")
        end
        self.teleported = Movement:UseZaap(dest, forbiddenZaap)
        global:delay(1000)
    end

end

return Movement