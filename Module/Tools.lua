Class = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Class.lua")
API = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\API.lua")
-- Création des classes
Tools = Class("Tools", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Utils.lua"))
Tools.class = Tools:extend("Class", Class)
Tools.zone = Tools:extend("Zone", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Zone.lua"))
Tools.monsters = Tools:extend("Monsters", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Monsters.lua"))
Tools.craft = Tools:extend("Craft", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Craft.lua"))
Tools.json = Tools:extend("Json", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\JSON.lua"))
Tools.packet = Tools:extend("Packet", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Packet.lua"))
Tools.movement = Tools:extend("Movement", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Movement.lua"))
Tools.notifications = Tools:extend("Notifications", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Notifications.lua"))

Tools.graph = Tools:extend("Graph", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Graph\\data\\graph.lua"))
Tools.dijkstra = Tools:extend("Dijkstra", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Graph\\shortest_paths\\Dijkstra.lua"))
Tools.list = Tools:extend("List", dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\List.lua"))

Tools.api = Tools:extend("Api")
Tools.api.localAPI = Tools.api:extend("LocalAPI", API.localAPI)
Tools.api.dofusDB = Tools.api:extend("DofusDB")
Tools.api.dofusDB.harvestable = Tools.api.dofusDB:extend("Harvestable", API.dofusDB.harvestable)
Tools.api.dofusDB.treasure = Tools.api.dofusDB:extend("Harvestable", API.dofusDB.treasure)

-- Constructeur

function Tools:init()
    self:InitCellsArray()
    self.zone = self.zone()
    self.monsters = self.monsters()
    self.api = self.api()
end


function Tools.zone:init()
    self.BigDataSubAreas = self.json:decode(self:ReadFile(global:getCurrentDirectory() .. "\\YayaTools\\Data\\SubArea\\SubAreas.json"))
end

function Tools.monsters:init()
    self.ModifiedMonsters = self.json:decode(self:ReadFile(global:getCurrentDirectory() .. "\\YayaTools\\Data\\Monsters\\monsters.json"))
end

function Tools.list:init(a, aLen, N)
    self.a = a or {}
    self.aLen = aLen or 1
    self.N = N or 1
end

function Tools.api:init()
    self.dofusDB.treasure = self.dofusDB.treasure()
    self.dofusDB.harvestable = self.dofusDB.harvestable()
    self.dofusDB = self.dofusDB()
    self.localAPI.localPort = self.json:decode(self:ReadFile(global:getCurrentDirectory() .. "\\YayaTools\\LocalAPI\\ConfigAPI.json")).port
    self.localAPI.localURL = "http://localhost:" .. self.localAPI.localPort .. "/"
    self.localAPI = self.localAPI()
end

function Tools.api.localAPI:init()
end

function Tools.api.dofusDB:init()
    self.apiUrl = "https://api.dofusdb.fr/"
end

return Tools