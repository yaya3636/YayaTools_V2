Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Character = Tools.character
Packet = Tools.packet

function move()
    Character.dialog:CreateDialog(-20000, Tools.list({24979, 24976, 24975})) -- Tentative de création de dialog avec un NpcId incorrect, Print une erreur et continue le script
    Character.dialog:CreateDialog(2907, Tools.list({24979, 24976})) -- Tentative de création de dialog avec un replyId manquant pour finir le dialog, Print une erreur, quitte le dialog et continue le script
    Character.dialog:CreateDialog(2907, Tools.list({24979, 24976, 24975})) -- On crée un dialog avec le npc 2907 (PNJ entrée Kardorim) et on lui passe une list de replyId en second paramètre
end

function messagesRegistering()
    Character.dialog:InitCallBack()
end

Packet = Packet() -- Instanciation du module packet
Character.dialog = Character.dialog({packet = Packet})-- Instanciation du module Character.dialog en lui passant en paramètre l'instance de Packet
Character = Character() -- Instanciation du module Character
Tools = Tools()-- Instanciation du module Tools