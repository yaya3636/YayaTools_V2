Dialog = {}

Dialog.tryDialog = false
Dialog.dialogMapId = -1
Dialog.npcId = -1
Dialog.messageId = -1
Dialog.visibleReplies = {}
Dialog.newVisibleReplies = false

function Dialog:CreateDialog(npcId, listReplies)
    npc:npc(npcId, 3)

    self.tools:Wait(not self.tryDialog, 200)

    self.tools:Wait(not self.super.isInDialog, 200)

    if not self.super.isInDialog then
        self.tools:Print("Dialog : Impossible d'ouvrir un dialog avec le Npc : " .. npcId, "error")
        self.tryDialog = false
        return
    end

    while self.super.isInDialog do
        local sendedReply = false
        self.newVisibleReplies = false
        for _, vReply in pairs(listReplies:Enumerate()) do
            if self.visibleReplies:Contains(vReply) then
                sendedReply = true
                npc:reply(vReply)
            end
        end
        if not sendedReply then
            self.tools:Print("Dialog : Aucun replyId correspondant au dialog trouvé dans la list listReplies, on quitte le dialog", "Error")
            global:leaveDialog()
            break
        end
        self.tools:Wait(not self.newVisibleReplies, 200)
    end
end

function Dialog:InitCallBack() -- A mettre obligatoirement dans le script charger par Ankabot
    local genericActionRequest = function(msg) Character.dialog:CB_NpcGenericActionRequestMessage(msg) end
    local dialogCreation = function(msg) Character.dialog:CB_NpcDialogCreationMessage(msg) end
    local dialogQuestion = function(msg) Character.dialog:CB_NpcDialogQuestionMessage(msg) end
    local leaveDialog = function(msg) Character.dialog:CB_LeaveDialogMessage(msg) end
    --local zaapDestinationMessage = function() Character.dialog:CB_ZaapDestinationMessage() end
    local exchangeStartedWithStorageMessage = function() Character.dialog:CB_ExchangeStartedWithStorageMessage() end

    self.packet:SubManager({
        ["NpcGenericActionRequestMessage"] = genericActionRequest,
        ["NpcDialogCreationMessage"] = dialogCreation,
        ["NpcDialogQuestionMessage"] = dialogQuestion,
        ["LeaveDialogMessage"] = leaveDialog,
        --["ZaapDestinationsMessage"] = zaapDestinationMessage,
        ["ExchangeStartedWithStorageMessage"] = exchangeStartedWithStorageMessage,
        ["ExchangeLeaveMessage"] = leaveDialog,

    })

end

function Dialog:CB_NpcGenericActionRequestMessage(msg)
    self.tools:Print("Création d'un dialog avec le NPC : " .. msg.npcId, "Dialog")
    self.tryDialog = true
end

function Dialog:CB_NpcDialogCreationMessage(msg)
    self.tools:Print("Dialog crée avec succès", "Dialog")
    self.super.isInDialog = true
    self.visibleReplies:Clear()
    self.dialogMapId = msg.mapId
    self.npcId = msg.npcId
end

function Dialog:CB_NpcDialogQuestionMessage(msg)
    self.messageId = msg.messageId
    self.visibleReplies = self.tools.list(msg.visibleReplies)
    self.newVisibleReplies = true
end


function Dialog:CB_LeaveDialogMessage(msg)
    if developer:typeOf(msg) == "LeaveDialogMessage" then
        self.tools:Print("Fin du dialog", "Dialog")

    elseif developer:typeOf(msg) == "ExchangeLeaveMessage" then
        self.tools:Print("Fin de l'echange", "Dialog")
    end

    self.super.isInDialog = false
    self.tryDialog = false
    self.dialogMapId = -1
    self.currentNpc = -1
    self.npcId = -1
    self.messageId = -1
    self.visibleReplies:Clear()
end

function Dialog:CB_ExchangeStartedWithStorageMessage()
    self.tools:Print("Echange crée avec succès", "Dialog")
    self.super.isInDialog = true
end

return Dialog