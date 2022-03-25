Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Character = Tools.character
--Dungeons = Tools.dungeons
--Monsters = Tools.monsters
--Zone = Tools.zone
Packet = Tools.packet

function move()
    --Packet:SubManager({["NpcGenericActionRequestMessage"] = CB_NpcGenericActionRequestMessage})
    Character.dialog:InitProperties()
    Character.dialog:InitProperties()
    Character.dialog:CreateDialog(2907, Tools.list({24979, 24976, 24975}))
    local next = true
    while next do
        next = global:question("next")
        Tools:Print("isInDialog : " .. tostring(Character.isInDialog))
        Tools:Print("DialogMapId : " .. Character.dialog.dialogMapId)
        Tools:Print("NpcId : " .. Character.dialog.npcId)
        Tools:Print("MessageId : " .. Character.dialog.messageId)
        Tools:Print("VisibleReplies :")
        Tools:Dump(Character.dialog.visibleReplies:Enumerate())
    end
end

function Character.dialog:InitProperties()
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
end

Packet = Packet()
Character.dialog = Character.dialog({packet = Packet})
Character = Character()

--Zone = Zone()
--Monsters = Monsters()
--Dungeons = Dungeons({ monsters = Monsters, zone = Zone })
Tools = Tools()