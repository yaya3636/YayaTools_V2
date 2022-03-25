Dialog = {}

Dialog.tryDialog = false
Dialog.dialogMapId = -1
Dialog.npcId = -1
Dialog.messageId = -1
Dialog.visibleReplies = {}
Dialog.newVisibleReplies = false

function Dialog:CreateDialog(npcId, listReplies)
    npc:npc(npcId, 3)

    self.tools:Wait(not self.super.isInDialog)

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
        self.tools:Wait(not self.newVisibleReplies)
    end
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
    self.visibleReplies = self.tools.list(msg.visibleReplies, #msg.visibleReplies)
    self.newVisibleReplies = true
end


function Dialog:CB_LeaveDialogMessage(msg)
    self.tools:Print("Fin du dialog", "Dialog")
    self.super.isInDialog = false
    self.tryDialog = false
    self.dialogMapId = -1
    self.currentNpc = -1
    self.npcId = -1
    self.messageId = -1
    self.visibleReplies:Clear()
end


return Dialog