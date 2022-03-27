local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")
API = dofile(yayaToolsModuleDirectory .. "API.lua")
-- Création des classes
Tools = Class("Tools", dofile(yayaToolsModuleDirectory .. "Utils.lua"))
Tools.craft = Class("Craft", dofile(yayaToolsModuleDirectory .. "Craft.lua"))
Tools.dungeons = Class("Dungeons", dofile(yayaToolsModuleDirectory .. "Dungeons.lua"))
Tools.dictionnary = Class("Dictionnary", dofile(yayaToolsModuleDirectory .. "Dictionnary.lua"))
Tools.gather = Class("Gather", dofile(yayaToolsModuleDirectory .. "Gather.lua"))
Tools.json = Class("Json", dofile(yayaToolsModuleDirectory .. "Json.lua"))
Tools.list = Class("List", dofile(yayaToolsModuleDirectory .. "List.lua"))
Tools.monsters = Class("Monsters", dofile(yayaToolsModuleDirectory .. "Monsters.lua"))
Tools.movement = Class("Movement", dofile(yayaToolsModuleDirectory .. "Movement.lua"))
Tools.notifications = Class("Notifications", dofile(yayaToolsModuleDirectory .. "Notifications.lua"))
Tools.object = Class("Object", dofile(yayaToolsModuleDirectory .. "Object.lua"))
Tools.packet = Class("Packet", dofile(yayaToolsModuleDirectory .. "Packet.lua"))
Tools.timer = Class("Timer", dofile(yayaToolsModuleDirectory .. "Timer.lua"))
Tools.zone = Class("Zone", dofile(yayaToolsModuleDirectory .. "Zone.lua"))

Tools.graph = Class("Graph", dofile(yayaToolsModuleDirectory .. [[Graph\data\graph.lua]]))
Tools.dijkstra = Class("Dijkstra", dofile(yayaToolsModuleDirectory .. [[Graph\shortest_paths\Dijkstra.lua]]))

Tools.character = Class("Character", dofile(yayaToolsModuleDirectory .. "Character.lua"))
Tools.character.dialog = Tools.character:extend("Dialog", dofile(yayaToolsModuleDirectory .. "Dialog.lua"))

Tools.api = Class("Api")
Tools.api.localAPI = Tools.api:extend("LocalAPI", API.localAPI)
Tools.api.dofusDB = Tools.api:extend("DofusDB",  API.dofusDB)
Tools.class = Class

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
    self.tools = Tools()
    self.json = Tools.json()
    self.d2oRecipes = self.json:decode(self.tools:ReadFile(self.d2oRecipesPath), "Recipes")
    self:InitD2oProperties()
end

function Tools.character:init(params)
    params = params or {}
    self.tools = Tools()
end

function Tools.character.dialog:init(params)
    params = params or {}
    if not params.packet then
        error("Character : Le paramètre packet requis pour instancier la class est non definie")
    end
    self.tools = Tools()
    self.packet = params.packet
    self.visibleReplies = Tools.list()
end


function Tools.dungeons:init(params)
    params = params or {}
    if not params.monsters then
        error("Dungeons : Le paramètre monsters requis pour instancier la class est non definie")
    elseif not params.zone then
        error("Dungeons : Le paramètre zone requis pour instancier la class est non definie")
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
    self.dic = dic or {}
    self.N = Tools:LenghtOfTable(self.dic)
    self.tools = Tools
end

function Tools.gather:init(params)
    if not params.packet then
        error("Gather : Le paramètre packet requis pour instancier la class est non definie")
    end
    self.tools = Tools()
    self.packet = params.packet
    self.elementsToGather = Tools.list()
    self.harvestableElements = Tools.dictionnary()
    self.sortedElementsByDist = Tools.list()
    self.sortedElementsByPriority = Tools.list()
end

function Tools.json:init()
    self.tools = Tools()
    for k, v in pairs(self.escapeCharMap) do
        self.escapeCharMapInv[v] = k
    end
    --self.tools:Print("ici")
end

function Tools.list:init(a)
    self.a = a or {}
    self.N = Tools:LenghtOfTable(a)
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
    if not params.zone then
        error("Movement : Le paramètre zone requis pour instancier la class est non definie")
    elseif not params.packet then
        error("Movement : Le paramètre packet requis pour instancier la class est non definie")
    elseif not params.character then
        error("Movement : Le paramètre character requis pour instancier la class est non definie") 
    end
    self.zone = params.zone
    self.packet = params.packet
    self.character = params.character
    self.tools = Tools()
    self.json = Tools.json()
    self:InitProperties()
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

function Tools.api.dofusDB:init()
    self.super.tools = Tools()
    self.super.json = Tools.json()
    self.super.localAPI.localPort = self.super.json:decode(self.super.tools:ReadFile(global:getCurrentDirectory() .. "\\YayaTools\\LocalAPI\\ConfigAPI.json"), "ConfigAPI").port
    self.super.localAPI.localUrl = "http://localhost:" .. self.super.localAPI.localPort .. "/"
    self.super.localAPI = self.super.localAPI()
    self.super = self.super()
end


--Tools.character.dialog = Tools.character.dialog()

return Tools