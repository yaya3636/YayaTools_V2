Class = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Class.lua")
API = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\API.lua")
-- Création des classes
Tools = Class("Tools", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Utils.lua"))
Tools.class = Class
Tools.craft = Class("Craft", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Craft.lua"))
Tools.dictionnary = Class("Dictionnary", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Dictionnary.lua"))
Tools.json = Class("Json", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\json.lua"))
Tools.list = Class("List", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\List.lua"))
Tools.monsters = Class("Monsters", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Monsters.lua"))
Tools.movement = Class("Movement", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Movement.lua"))
Tools.notifications = Class("Notifications", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Notifications.lua"))
Tools.object = Class("Object", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Object.lua"))
Tools.packet = Class("Packet", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Packet.lua"))
Tools.timer = Class("Timer", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Timer.lua"))
Tools.zone = Class("Zone", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Zone.lua"))

Tools.graph = Class("Graph", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Graph\\data\\graph.lua"))
Tools.dijkstra = Class("Dijkstra", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Graph\\shortest_paths\\Dijkstra.lua"))

Tools.api = Class("Api", {tools = Tools(), json = Tools.json()})
Tools.api.localAPI = Tools.api:extend("LocalAPI", API.localAPI)()
Tools.api.dofusDB = Tools.api:extend("DofusDB")
Tools.api.dofusDB.harvestable = Tools.api.dofusDB:extend("Harvestable", API.dofusDB.harvestable)()
Tools.api.dofusDB.treasure = Tools.api.dofusDB:extend("Treasure", API.dofusDB.treasure)()
Tools.api.dofusDB = Tools.api.dofusDB()

-- Constructeur

function Tools:init(params)
    params = params or {}
    self.colorPrint = params.colorPrint or self.colorPrint
    self.class = Class
    self:InitCellsArray()
end

function Tools.craft:init(params)
    params = params or {}
    self.tools = Tools()
    self.json = Tools.json()
end

function Tools.dictionnary:init(dic, N)
    self.dic = dic or {}
    self.N = N or 0
end

function Tools.json:init()
    self.tools = Tools()
    for k, v in pairs(self.escapeCharMap) do
        self.escapeCharMapInv[v] = k
    end
    --self.tools:Print("ici")
end

function Tools.list:init(a, N)
    self.a = a or {}
    self.N = N or 0
end

function Tools.monsters:init(params)
    params = params or {}
    self.tools = Tools()
    self.json = Tools.json()
    self.tools:Print("Chargement des données des monstres, cela peut prendre plusieurs minutes, le chargement peut paraître bloqué", "Info")
    self.d2oMonsters = self.json:decode(self.tools:ReadFile(self.d2oMonstersPath), "Monsters")
    self.tools:Print("Contruction des données des monstres", "Info")
    self:InitD2oProperties()
end

function Tools.movement:init(params)
    params = params or {}
    self.tools = Tools()
    self.json = Tools.json()
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
end

function Tools.timer:init(params)
    params = params or {}
    local date = os.date('*t')
    local curH, curM = date.hour, date.min
    self.timerRandTimeToWait = global:random(params.min, params.max)
    self.timerHourStart, self.timerMinuteStart = curH, curM
end

function Tools.zone:init(params)
    params = params or {}
    self.tools = Tools()
    self.json = Tools.json()
    self.d2oArea = self.json:decode(self.tools:ReadFile(self.d2oAreaPath), "Area")
    self.d2oSubArea = self.json:decode(self.tools:ReadFile(self.d2oSubAreaPath), "SubArea")
    self:InitD2oProperties()
end

function Tools.api:init(params)
    params = params or {}
    self.tools = Tools()
    self.json = Tools.json()
    self.localAPI.localPort = self.json:decode(self.tools:ReadFile(global:getCurrentDirectory() .. "\\YayaTools\\LocalAPI\\ConfigAPI.json"), "ConfigAPI").port
    self.localAPI.localUrl = "http://localhost:" .. self.localAPI.localPort .. "/"
end

return Tools