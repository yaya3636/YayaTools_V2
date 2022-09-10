Group = {}

Group.isLeader = false
Group.members = nil
Group.invitationMessage = nil
Group.leaderUsername = nil
Group.partyId = 0
Group.movement = nil

function Group:SendInvitation(username)
    self.tools:Print("Invitation du personnage (" .. username .. ") au groupe", "Group")
    self.packet:SendPacket("PartyInvitationRequestMessage", function(msg)
        msg.target = developer:createMessage("PlayerSearchCharacterNameInformation")
        msg.target.name = username
        return msg
    end)
end

function Group:WaitInvitation(username)
    self.leaderUsername = username or self.leaderUsername

    local joinGroup = false
    self.invitationMessage:Foreach(function(v)
        if v.fromName == self.leaderUsername then
            self.packet:SendPacket("PartyAcceptInvitationMessage", function(msg)
                msg.partyId = v.partyId
                return msg
            end)
            joinGroup = true
        end
    end)

    if joinGroup then
        self.invitationMessage:Clear()
    else
        if self.super.inGroup then
            return
        end
        global:delay(100)
        self:WaitInvitation()
    end
end

function Group:Leave()
    self.packet:SendPacket("PartyLeaveRequestMessage", function(msg)
        msg.partyId = self.partyId
        return msg
    end)
end

function Group:Kick(username)
    if self.isLeader then
        if type(username) == "string" then
            self.members:Foreach(function(v)
                if v.name == username then
                    self.packet:SendPacket("PartyKickRequestMessage", function(msg)
                        msg.playerId = v.id
                        msg.partyId = self.partyId
                    end)
                end
            end)
        elseif type(username) == "number" then
            self.packet:SendPacket("PartyKickRequestMessage", function(msg)
                msg.playerId = username
                msg.partyId = self.partyId
            end)
        end
    else
        self.tools:Print("La méthode Kick() ne peux pas être lancer depuis une mûle", "Group")
    end
end

function Group:InitCallBack() -- A mettre obligatoirement dans le script charger par Ankabot
    local partyAcceptInvitationMessage = function(msg) Character.group:CB_PartyAcceptInvitationMessage(msg) end
    local partyInvitationMessage = function(msg) Character.group:CB_PartyInvitationMessage(msg) end
    local partyJoinMessage = function(msg) Character.group:CB_PartyJoinMessage(msg) end
    local partyNewMemberMessage = function(msg) Character.group:CB_PartyNewMemberMessage(msg) end
    local partyLeaveMessage = function(msg) Character.group:CB_PartyLeaveMessage(msg) end
    local partyMemberRemoveMessage = function(msg) Character.group:CB_PartyMemberRemoveMessage(msg) end
    local partyDeletedMessage = function(msg) Character.group:CB_PartyDeletedMessage(msg) end
    local partyKickedByMessage = function(msg) Character.group:CB_PartyKickedByMessage(msg) end
    local partyMemberEjectedMessage = function(msg) Character.group:CB_PartyMemberEjectedMessage(msg) end
    local currentMapMessage = function(msg) Character.group:CB_ChangeMapMessage(msg) end

    self.packet:SubManager({
        ["PartyAcceptInvitationMessage"] = partyAcceptInvitationMessage,
        ["PartyInvitationMessage"] = partyInvitationMessage,
        ["PartyJoinMessage"] = partyJoinMessage,
        ["PartyNewMemberMessage"] = partyNewMemberMessage,
        ["PartyLeaveMessage"] = partyLeaveMessage,
        ["PartyMemberRemoveMessage"] = partyMemberRemoveMessage,
        ["PartyDeletedMessage"] = partyDeletedMessage,
        ["PartyKickedByMessage"] = partyKickedByMessage,
        ["PartyMemberEjectedMessage"] = partyMemberEjectedMessage,
        ["ChangeMapMessage"] = currentMapMessage,

    })

end

function Group:JoinBoss()
    if not self.isLeader and self.super.inGroup then
        local mapId = self:GetLeaderMapId()
        self.movement:LoadRoad(mapId)
        self.movement:MoveNext()
    end
end

function Group:GetLeaderMapId()
    local mapId
    self.members:Foreach(function(v)
        if v.name == self.leaderUsername then
            local info = self.memory:Get("Groupe-" .. self.partyId .. "-" .. v.name)
            mapId = info.mapId
            return
        end
    end)
    return mapId
end

function Group:CB_PartyAcceptInvitationMessage(msg)
    self.tools:Print("Un personnage a rejoint le groupe", "Group")
end

function Group:CB_PartyInvitationMessage(msg)
    self.tools:Print(msg.fromName .. " Nous invite a rejoindre son groupe", "Group")
    if self.super.inGroup then
        self.invitationMessage:Clear()
    else
        if self.invitationMessage:Size() > 10 then
            self.invitationMessage:Clear()
        end
        self.invitationMessage:Add(msg)
    end
end

function Group:CB_PartyJoinMessage(msg)
    self.tools:Print("Nous avons rejoint un groupe", "Group")
    self.super.inGroup = true
    self.partyId = msg.partyId

    if msg.partyLeaderId == character:id() then
        self.isLeader = true
        self.leaderUsername = character:name()
        self.memory:CreateInstance("Groupe-" .. self.partyId)
    else
        self.memory:BindInstance("Groupe-" .. self.partyId)
    end

    self.memory:Add("Groupe-" .. self.partyId .. "-" .. character:name(), { mapId = map:currentMapId() })
    self.members:Clear()

    for _, v in pairs(msg.members) do
        self.members:Add(v)
    end
end

function Group:CB_PartyNewMemberMessage(msg)
    self.tools:Print("Le personnage (" .. msg.memberInformations.name .. ") a rejoint le groupe", "Group")
    self.members:Add(msg.memberInformations)
end

function Group:CB_PartyLeaveMessage(msg)
    self.tools:Print("Nous avons quitté le groupe", "Group")
    self.super.inGroup = false
    self.partyId = 0
    self.members:Clear()
end

function Group:CB_PartyMemberRemoveMessage(msg)
    for i, v in pairs(self.members:Enumerate()) do
        if v.id == msg.leavingPlayerId then
            self.tools:Print("Le personnage (" .. v.name .. ") a quitté le groupe", "Group")
            self.members:RemoveAt(i)
        end
    end
end

function Group:CB_PartyDeletedMessage(msg)
    if msg.partyId == self.partyId then
        self.tools:Print("Nous avons quitté le groupe", "Group")
        self.super.inGroup = false
        self.partyId = 0
        self.members:Clear()
    end
end

function Group:CB_PartyKickedByMessage(msg)
    if msg.partyId == self.partyId then
        self.tools:Print("Nous avons été exclu du groupe", "Group")
        self.super.inGroup = false
        self.partyId = 0
        self.members:Clear()
    end
end

function Group:CB_PartyMemberEjectedMessage(msg)
    if msg.partyId == self.partyId then
        for i, v in pairs(self.members:Enumerate()) do
            if v.id == msg.leavingPlayerId then
                self.tools:Print("Le personnage (" .. v.name .. ") a été exclu du groupe", "Group")
                self.members:RemoveAt(i)
            end
        end
    end
end

function Group:CB_ChangeMapMessage(msg)
    self.memory:Set("Groupe-" .. self.partyId .. "-" .. character:name(), { mapId = map:currentMapId() })
end

return Group