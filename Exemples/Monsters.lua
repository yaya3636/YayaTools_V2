Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Monsters = Tools.monsters
API = Tools.api
-- Regarder le fichier Monsters dans module pour les autres func

function move()
    Tools:Print("-----------------------------------------------------")
    Tools:Print("-----------------------------------------------------")
    Tools:Dump(Monsters:GetMonsterIdByDropId(588))
    Tools:Print("-----------------------------------------------------")
    Tools:Print("-----------------------------------------------------")
    Tools:Dump(Monsters:GetMonsterObject(31))
    Tools:Print("-----------------------------------------------------")
    Tools:Print("-----------------------------------------------------")
end

API = API()
Monsters = Monsters({api = API})
Tools = Tools()