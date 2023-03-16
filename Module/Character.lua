Character = {}

Character.dialog = {}
Character.group = {}

Character.isInDialog = false
Character.inGroup = false

Character.stats = {}

function Character:GetStats(key)
    if key then
        return self.stats:Get(key)
    end
    return self.stats
end

function Character:InitCallBack() -- A mettre obligatoirement dans le script charger par Ankabot
    local characterStatsListMessage = function(msg) Character:CB_CharacterStatsListMessage(msg) end

    self.packet:SubManager({
        ["CharacterStatsListMessage"] = characterStatsListMessage,
    })

end

function Character:CB_CharacterStatsListMessage(msg)
    for _, v in pairs(msg.stats.characteristics) do
        if tostring(v) == "SwiftBot.CharacterCharacteristicDetailed" then
            local key = self.ENUM_STATS:Get(tostring(v.characteristicId))
            local stat = v.base + v.additional + v.objectsAndMountBonus + v.alignGiftBonus + v.contextModif
            self.stats:Set(key, stat)
        end
    end
end



return Character