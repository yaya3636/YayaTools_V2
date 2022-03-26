Gather = {}

function Gather:InitCallBack()
    local mapComplementaryInformationsDataMessage = function(msg) Character.dialog:CB_NpcGenericActionRequestMessage(msg) end

    self.packet:SubManager({
        ["mapComplementaryInformationsDataMessage"] = mapComplementaryInformationsDataMessage,
    })

end

function Gather:CB_MapComplementaryInformationsDataMessage(msg)

end

return Gather