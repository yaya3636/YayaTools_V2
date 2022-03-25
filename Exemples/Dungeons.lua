Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Dungeons = Tools.dungeons
Monsters = Tools.monsters
Zone = Tools.zone

function move()

    
end

Zone = Zone()
Monsters = Monsters()
Dungeons = Dungeons({ monsters = Monsters, zone = Zone })
Tools = Tools()