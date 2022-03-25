Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Character = Tools.character
Packet = Tools.packet

function move()
    Character.dialog:InitProperties() -- Initier la méthode dans move obligatoirement !
    Character.dialog:CreateDialog(2907, Tools.list({24979, 24976, 24975})) -- On crée un dialog avec le npc 2907 (PNJ entrée Kardorim) et on lui passe une list de replyId en second paramètre
end

function Character.dialog:InitProperties() -- A mettre obligatoirement dans le script charger par Ankabot
    if not self.initialized then
        local genericActionRequest = function(msg) Character.dialog:CB_NpcGenericActionRequestMessage(msg) end
        local dialogCreation = function(msg) Character.dialog:CB_NpcDialogCreationMessage(msg) end
        local dialogQuestion = function(msg) Character.dialog:CB_NpcDialogQuestionMessage(msg) end
        local leaveDialog = function(msg) Character.dialog:CB_LeaveDialogMessage(msg) end

        self.packet:SubManager({
            ["NpcGenericActionRequestMessage"] = genericActionRequest,
            ["NpcDialogCreationMessage"] = dialogCreation,
            ["NpcDialogQuestionMessage"] = dialogQuestion,
            ["LeaveDialogMessage"] = leaveDialog,
        })

        self.initialized = true
    end
end

Packet = Packet() -- Instanciation du module packet
Character.dialog = Character.dialog({packet = Packet})-- Instanciation du module Character.dialog en lui passant en paramètre l'instance de Packet
Character = Character() -- Instanciation du module Character
Tools = Tools()-- Instanciation du module Tools