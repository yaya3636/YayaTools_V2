Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Zone = Tools.zone

-- Regarder le fichier Zone dans module pour les autres func

function move()
    Tools:Print("-----------------------------------------------------")
    Tools:Print("-----------------------------------------------------")
    Tools:Dump(Zone:GetAreaObject(1))
    Tools:Print("-----------------------------------------------------")
    Tools:Print("-----------------------------------------------------")
    Tools:Dump(Zone:GetSubAreaObject(809))
    Tools:Print("-----------------------------------------------------")
    Tools:Print("-----------------------------------------------------")
end

Zone = Zone()
Tools = Tools()