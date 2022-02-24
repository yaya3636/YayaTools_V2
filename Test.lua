Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
ToolsInstance = Tools()

VotreClass = ToolsInstance.class("Nom de la classe") -- Initialistation de votre classe

VotreClass.test = "nil" -- Variable de votre classe

function VotreClass:HelloWorld() -- Fonction de votre classe
    ToolsInstance:Print(self.test, "test")
end

function VotreClass:init(paramsInit) -- Constructeur de la classe appelée lors de l'instanciation
    self.test = paramsInit
end

InstanceDeVotreClasse = VotreClass("test") -- Instanciation de la classe en lui passant un paramètre


function move()
    ToolsInstance:Print(VotreClass, "Class")
    ToolsInstance:Print(InstanceDeVotreClasse, "Instance")
    InstanceDeVotreClasse:HelloWorld()


    ToolsInstance:Print(ToolsInstance, "Instance")
    ToolsInstance:Print(ToolsInstance.api, "Instance")
    ToolsInstance:Print(ToolsInstance.api.dofusDB, "Instance")
    ToolsInstance:Print(ToolsInstance.api.dofusDB.harvestable, "Instance")
    ToolsInstance:Dump(ToolsInstance.api.dofusDB.harvestable:GetHarvestablePosition(303), 100)

end