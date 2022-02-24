Packet = {}

function Packet:SubManager(packetToSub, register)
    for kPacketName, vCallBack in pairs(packetToSub) do
        if register then -- Abonnement au packet
            if not developer:isMessageRegistred(kPacketName) then
                self:Print("Abonnement au packet : "..kPacketName, "packet")
                developer:registerMessage(kPacketName, vCallBack)
            end            
        else -- Désabonnement des packet
            if developer:isMessageRegistred(kPacketName) then
                self:Print("Désabonnement au packet : "..kPacketName, "packet")
                developer:unRegisterMessage(kPacketName)
            end
        end
    end
end

function Packet:SendPacket(packetName, fn)
    self:Print("Envoie du packet "..packetName, "packet")
    local msg = developer:createMessage(packetName)

    if fn ~= nil then
        msg = fn(msg)
    end

    developer:sendMessage(msg)
end

return Packet