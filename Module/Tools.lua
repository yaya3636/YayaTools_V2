local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")
API = dofile(yayaToolsModuleDirectory .. "API.lua")
Queue = dofile(yayaToolsModuleDirectory .. "Queue.lua")
Stack = dofile(yayaToolsModuleDirectory .. "Stack.lua")
Graph = dofile(yayaToolsModuleDirectory .. "Graph.lua")

-- Création des classes
Tools = Class("Tools", dofile(yayaToolsModuleDirectory .. "Utils.lua"))

Tools.craft = Class("Craft", dofile(yayaToolsModuleDirectory .. "Craft.lua"))
Tools.controller = Class("Controller", dofile(yayaToolsModuleDirectory .. "Controller.lua"))
Tools.dungeons = Class("Dungeons", dofile(yayaToolsModuleDirectory .. "Dungeons.lua"))
Tools.dictionnary = Class("Dictionnary", dofile(yayaToolsModuleDirectory .. "Dictionnary.lua"))
Tools.gather = Class("Gather", dofile(yayaToolsModuleDirectory .. "Gather.lua"))
Tools.json = Class("Json", dofile(yayaToolsModuleDirectory .. "Json.lua"))
Tools.indexedMinPQ = Class("IndexedMinPQ", dofile(yayaToolsModuleDirectory .. "IndexedMinPQ.lua"))
Tools.list = Class("List", dofile(yayaToolsModuleDirectory .. "List.lua"))
Tools.pointsOfInterest = Class("PointsOfInterest", dofile(yayaToolsModuleDirectory .. "PointsOfInterest.lua"))
Tools.monsters = Class("Monsters", dofile(yayaToolsModuleDirectory .. "Monsters.lua"))
Tools.movement = Class("Movement", dofile(yayaToolsModuleDirectory .. "Movement.lua"))
Tools.memory = Class("Memory", dofile(yayaToolsModuleDirectory .. "Memory.lua"))
Tools.notifications = Class("Notifications", dofile(yayaToolsModuleDirectory .. "Notifications.lua"))
Tools.object = Class("Object", dofile(yayaToolsModuleDirectory .. "Object.lua"))
Tools.packet = Class("Packet", dofile(yayaToolsModuleDirectory .. "Packet.lua"))
Tools.timer = Class("Timer", dofile(yayaToolsModuleDirectory .. "Timer.lua"))
Tools.zone = Class("Zone", dofile(yayaToolsModuleDirectory .. "Zone.lua"))

Tools.dijkstra = Class("Dijkstra", dofile(yayaToolsModuleDirectory .. "Dijkstra.lua"))

Tools.character = Class("Character", dofile(yayaToolsModuleDirectory .. "Character.lua"))
Tools.character.group = Tools.character:extend("Character.group", dofile(yayaToolsModuleDirectory .. "Character.group.lua"))
Tools.character.dialog = Tools.character:extend("Character.dialog", dofile(yayaToolsModuleDirectory .. "Character.dialog.lua"))

Tools.ctrApi = Class("Api")
Tools.ctrApi.localAPI = Tools.ctrApi:extend("LocalAPI", API.localAPI)
Tools.ctrApi.dofusDB = Tools.ctrApi:extend("DofusDB",  API.dofusDB)
Tools.api = Tools.ctrApi:extend("Api")
Tools.class = Class

local graphEdge = Graph.edge
Graph.edge = Class("Graph.edge", graphEdge)
Tools.graph = Class("Graph", Graph)

local nodeQ = Queue.node
Queue.node = Class("Queue.node", nodeQ)
Tools.queue = Class("Queue", Queue)

local nodeS = Stack.node
Stack.node = Class("Stack.node", nodeS)
Stack.list = Tools.list
Tools.stack = Class("Stack", Stack)

-- Constructeur

function Tools:init(params)
    params = params or {}
    local tmpColor = self.colorPrint
    self.colorPrint = Tools.dictionnary()
    for kHeader, vHexColor in pairs(tmpColor) do
        self.colorPrint:Add(string.lower(kHeader), vHexColor)
    end
    if params.colorPrint then
        for kHeader, vHexColor in pairs(params.colorPrint:Enumerate()) do
            self.colorPrint:Add(string.lower(kHeader), vHexColor)
        end
    end
    self.class = Class
    self:InitCellsArray()
end

function Tools.craft:init(params)
    params = params or {}
    if not params.api then
        error("[Module Craft] : Le paramètre api requis pour instancier la class est non definie")
    end
    self.tools = Tools()
    self.api = params.api
    --self.json = Tools.json()
    --self.d2oRecipes = self.json:decode(self.tools:ReadFile(self.d2oRecipesPath), "Recipes")
    --self:InitD2oProperties()
end

function Tools.controller:init(params)
    params = params or {}
    self.tools = Tools()
    self.teamLoaded = Tools.dictionnary()
    self.accountController = Tools.dictionnary()
end

function Tools.character:init(params)
    params = params or {}
    if not params.packet then
        error("[Module Character] : Le paramètre packet requis pour instancier la class est non definie")
    end
    self.tools = Tools()
    params.tools = self.tools
    self.dialog = self.dialog(params)
    self.group = self.group(params)
end

function Tools.character.dialog:init(params)
    params = params or {}
    self.tools = params.tools
    self.packet = params.packet
    self.visibleReplies = Tools.list()
end

function Tools.character.group:init(params)
    params = params or {}
    self.tools = params.tools
    self.packet = params.packet
    self.members = Tools.list()
    self.invitationMessage = Tools.list()
end

function Tools.dungeons:init(params)
    params = params or {}
    if not params.monsters then
        error("[Module Dungeons] : Le paramètre monsters requis pour instancier la class est non definie")
    elseif not params.zone then
        error("[Module Dungeons] : Le paramètre zone requis pour instancier la class est non definie")
    end
    self.monsters = params.monsters
    self.zone = params.zone
    self.tools = Tools()
    self.json = Tools.json()
    self.d2oDungeons = self.json:decode(self.tools:ReadFile(self.d2oDungeonsPath), "Dungeons")
    self.dungeonsKeys = self.json:decode(self.tools:ReadFile(self.dungeonsKeysPath), "Dungeons")
    self:InitD2oProperties()
end

function Tools.dictionnary:init(dic)
    local tmp = {}
    if dic ~= nil then
        if dic.c then
            if dic.a then
                for _, v in pairs(dic.a) do
                    table.insert(tmp, v)
                end
            end

            if dic.dic then
                for k, v in pairs(dic.dic) do
                    tmp[k] = v
                end
            end
        else
            for k, v in pairs(dic) do
                tmp[k] = v
            end
        end
    end

    self.dic = tmp
    self.N = Tools:LenghtOfTable(self.dic)
    self.tools = Tools
end

function Tools.dijkstra:init()
    self.edgeTo = {}
    self.cost = {}
    self.source = -1
    self.marked = {}
    self.indexedMinPQ = Tools.indexedMinPQ
    self.stack = Tools.stack
end

function Tools.gather:init(params)
    params = params or {}
    if not params.packet then
        error("[Module Gather] : Le paramètre packet requis pour instancier la class est non definie")
    end
    self.tools = Tools()
    self.packet = params.packet
    self.elementsToGather = Tools.list()
    self.harvestableElements = Tools.dictionnary()
    self.sortedElementsByDist = Tools.list()
    self.sortedElementsByPriority = Tools.list()
    local tmp = self.gatherInfo
    self.gatherInfo = Tools.dictionnary()
    for _, v in pairs(tmp) do
        self.gatherInfo:Add(tostring(v.objectId), Tools.object(v))
    end
    tmp = self.bagsId
    self.bagsId = Tools.list(tmp)

end

function Tools.graph.edge:init(v, w, weight)
    if weight == nil then
        weight = 1.0
    end
    self.v = v
    self.w = w
    self.weight = weight
end

function Tools.graph:init(V, directed)
    if directed == nil then
        directed = false
    end

    self.list = Tools.list
    self.vertexList = Tools.list()
    self.adjList = {}
    for v = 0, V-1 do
        self.vertexList:Add(v)
        self.adjList[v] = Tools.list()
    end
    self.directed = directed
end

function Tools.json:init()
    self.tools = Tools()
    for k, v in pairs(self.escapeCharMap) do
        self.escapeCharMapInv[v] = k
    end
    --self.tools:Print("ici")
end

function Tools.indexedMinPQ:init(params)
    params = params or {}
    if params.comparator == nil then
        params.comparator = function(a1, a2) return a1 - a2 end
    end

    self.keys = {}
    self.pq = {}
    self.qp = {}
    self.N = 0
    self.comparator = params.comparator
end

function Tools.list:init(a)
    local tmp = {}
    if a ~= nil then
        if a.c then
            if a.a then
                for _, v in pairs(a.a) do
                    table.insert(tmp, v)
                end
            end

            if a.dic then
                for _, v in pairs(a.dic) do
                    table.insert(tmp, v)
                end
            end
        else
            for _, v in pairs(a) do
                table.insert(tmp, v)
            end
        end
    end
    self.a = tmp
    self.N = Tools:LenghtOfTable(tmp)
end

function Tools.pointsOfInterest:init()
    self.tools = Tools()
    local tmp = self.bankInfo
    self.bankInfo = Tools.dictionnary()

    for k, v in pairs(tmp) do
        self.bankInfo:Add(k, Tools.object(v))
    end

    tmp = self.workshopInfo

    self.workshopInfo = Tools.dictionnary()

    for kJob, vInfo in pairs(tmp) do
        kJob = string.lower(kJob)
        local ins = Tools.object()
        for kProp, v in pairs(vInfo) do
            kProp = string.lower(kProp)
            if kProp == "skillid" then
                ins[kProp] = Tools.list(v)
            else
                ins[kProp] = Tools.dictionnary()
                for kSkillId, vWorkShop in pairs(v) do
                    ins[kProp]:Add(kSkillId, Tools.object({
                        mapId = vWorkShop.mapId,
                        workshopId = Tools.list(vWorkShop.workshopId)
                    }))
                end
            end
        end
        self.workshopInfo:Add(kJob, ins)
    end
end

function Tools.monsters:init(params)
    params = params or {}
    if not params.api then
        error("[Module Monsters] : Le paramètre api requis pour instancier la class est non definie")
    end
    self.tools = Tools()
    self.json = Tools.json()
    self.api = params.api
end

function Tools.movement:init(params)
    params = params or {}
    if not params.zone then
        error("[Module Movement] : Le paramètre zone requis pour instancier la class est non definie")
    elseif not params.packet then
        error("[Module Movement] : Le paramètre packet requis pour instancier la class est non definie")
    elseif not params.character then
        error("[Module Movement] : Le paramètre character requis pour instancier la class est non definie") 
    end
    self.zone = params.zone
    self.packet = params.packet
    self.character = params.character
    self.tools = Tools()
    self.json = Tools.json()
    self.mineGraphData = Tools.dictionnary(dofile(global:getCurrentDirectory() .. [[\YayaTools\Data\MineGraph.lua]]))
    self.mineGraph = Tools.graph(0, true)
    self:InitProperties()
end

function Tools.memory:init(params)
    params = params or {}
    self.tools = Tools()
    self.registeredKey = Tools.list()
    if params.clear then
        developer:deleteAllGlobalMemory()
        self.tools:Print("Toutes les clés ont bien été supprimé", "Memory")
    end
end

function Tools.notifications:init(params)
    params = params or {}
    self.tools = Tools()
    self.json = Tools.json()
    self.key = params.key
    self.deviceID = params.deviceID
end

function Tools.object:init(...)
    self = Tools:ArrayConcat(self, ...)
end

function Tools.packet:init(params)
    params = params or {}
    self.tools = Tools()
    self.subscribedPacket = self.tools.dictionnary()
end

function Tools.queue:init()
    self.node = Tools.queue.node
end

function Tools.queue.node:init(value)
    self.value = value
end

function Tools.stack:init()
    self.node = Tools.queue.node
end

function Tools.stack.node:init(value)
    self.value = value
end

function Tools.timer:init(params)
    params = params or {}
    self.startAt = os.time()
    self.timeToWait = global:random(params.min * 60, params.max * 60)
end

function Tools.zone:init(params)
    params = params or {}
    if not params.api then
        error("[Module Zone] : Le paramètre api requis pour instancier la class est non definie")
    end
    local mineArea = dofile(global:getCurrentDirectory() .. [[\YayaTools\Data\MineArea.lua]])
    self.mineArea = Tools.dictionnary()
    for k, v in pairs(mineArea) do
        self.mineArea:Add(k, Tools.object({
            name = v.name,
            mapId = Tools.list(v.mapId)
        }))
    end
    self.tools = Tools()
    self.api = params.api
end

function Tools.api:init()
    self.super.tools = Tools()
    self.super.json = Tools.json()
    self.super.mineArea = Tools.dictionnary()
    local mineArea = dofile(global:getCurrentDirectory() .. [[\YayaTools\Data\MineArea.lua]])

    for k, v in pairs(mineArea) do
        self.super.mineArea:Add(k, Tools.object({
            name = v.name,
            mapId = Tools.list(v.mapId)
        }))
    end

    self.super.localAPI.localPort = self.super.json:decode(self.super.tools:ReadFile(global:getCurrentDirectory() .. "\\YayaTools\\LocalAPI\\ConfigAPI.json"), "API").port
    self.super.localAPI.localUrl = "http://localhost:" .. self.super.localAPI.localPort .. "/"
    self.super.localAPI = self.super.localAPI()
    self.super = self.super()
end

return Tools