Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Character = Tools.character
--Dungeons = Tools.dungeons
--Monsters = Tools.monsters
--Zone = Tools.zone
Packet = Tools.packet

function move()
    Packet:SubManager({["ChatServerMessage"] = Character.test}) -- Abbonnement au packet
    Packet:SubManager({["ChatServerMessage"] = Character.test}) -- Essaie d'ajout d'un callback déja définie, le callback ne sera pas ajouter et un print vous l'informera
    Packet:SubManager({["ChatServerMessage"] = test}) -- Ajout d'un deuxieme callback au packet
    Packet:SubManager({"ChatServerMessage"}) -- Désabonnement du packet et c'est callback
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