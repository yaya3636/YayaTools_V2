Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Zone = Tools.zone
API = Tools.api

-- Regarder le fichier Zone dans module pour les autres func

function move()
    Tools:Print("-----------------------------------------------------")
    Tools:Print("-----------------------------------------------------")
    Tools:Dump(Zone:GetSubAreaMonsters(809))
    Tools:Print("-----------------------------------------------------")
    Tools:Print("-----------------------------------------------------")
    Tools:Dump(Zone:GetSubAreaObject(809))
    Tools:Print("-----------------------------------------------------")
    Tools:Print("-----------------------------------------------------")
end

API = API()
Zone = Zone({api = API})
Tools = Tools()