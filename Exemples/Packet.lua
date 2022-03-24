Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Packet = Tools.packet

Tbl = Tools.object()

function move()
    Packet:SubManager({["ChatServerMessage"] = Tbl["FuncTest"]}) -- Abbonnement au packet
    Packet:SubManager({["ChatServerMessage"] = Tbl.FuncTest}) -- Essaie d'ajout d'un callback déja définie, le callback ne sera pas ajouter et un print vous l'informera
    Packet:SubManager({["ChatServerMessage"] = test}) -- Ajout d'un deuxieme callback au packet

    --Packet:SubManager({"ChatServerMessage"}) -- Désabonnement du packet et c'est callback
    while true do
        Tools:Print("test")
        global:delay(1000)
    end
end

function test(msg)
    Tools:Print(msg)
end

function Tbl.FuncTest(msg)
    Tools:Print(msg)
end


Packet = Packet()
Tools = Tools()