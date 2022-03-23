Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Character = Tools.character
--Dungeons = Tools.dungeons
--Monsters = Tools.monsters
--Zone = Tools.zone
Packet = Tools.packet

function move()
    Packet:SubManager({["ChatServerMessage"] = Character.test}, true)
    --Tools:Dump()
end

Character.test = function(msg)
    Tools:Print(msg)

end

function test(msg)

    Tools:Print(msg)

end


Character = Character()
Packet = Packet()
--Zone = Zone()
--Monsters = Monsters()
--Dungeons = Dungeons({ monsters = Monsters, zone = Zone })
Tools = Tools()