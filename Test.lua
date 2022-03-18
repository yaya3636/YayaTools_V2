Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Dungeons = Tools.dungeons
Monsters = Tools.monsters
Zone = Tools.zone

function move()
    Tools:Print("----------------------------------------------------------")
    Tools:Print("----------------------------------------------------------")
    --Tools:Dump(Monsters:GetMonsterObject(16525))
    Tools:Dump(Dungeons:GetDungeonsEntranceByDropId(16525))
    Tools:Print("----------------------------------------------------------")
    Tools:Print("----------------------------------------------------------")
    Tools:Print(Dungeons:GetDungeonsKeyId(Dungeons:GetDungeonsEntranceByDropId(16525)))
    Tools:Print("----------------------------------------------------------")
    Tools:Print("----------------------------------------------------------")
    Tools:Dump(Dungeons:GetDungeonsEntranceByMapId(152829952))
    Tools:Print("----------------------------------------------------------")
    Tools:Print("----------------------------------------------------------")
end

Zone = Zone()
Monsters = Monsters()
Dungeons = Dungeons({ monsters = Monsters, zone = Zone })
Tools = Tools()