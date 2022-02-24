Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")()

VotreClass = Tools.class("Nom de la classe") -- Initialistation de votre classe

VotreClass.test = "nil" -- Variable de votre classe

function VotreClass:HelloWorld() -- Fonction de votre classe
    Tools:Print(self.test, "test")
end

function VotreClass:init(paramsInit) -- Constructeur de la classe appelée lors de l'instanciation
    self.test = paramsInit
end

InstanceDeVotreClasse = VotreClass("test") -- Instanciation de la classe en lui passant un paramètre


function move()
    Tools:Print(VotreClass, "Class")
    Tools:Print(InstanceDeVotreClasse, "Instance")
    InstanceDeVotreClasse:HelloWorld()
end