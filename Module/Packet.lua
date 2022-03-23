Packet = {}

Packet.subscribedPacket = {}

function Packet:SubManager(packetToSub, register)
    self.tools:Print("La")
    for kPacketName, vCallBack in pairs(packetToSub) do
        if register then -- Abonnement au packet
            if not developer:isMessageRegistred(kPacketName) then
                self.tools:Print("Abonnement au packet : "..kPacketName, "packet")
                local tmpClass = self.tools.class(kPacketName)
                --tmpClass.init = vCallBack
                developer:registerMessage(kPacketName, vCallBack)
            end



        else -- Désabonnement des packet
            if developer:isMessageRegistred(kPacketName) then
                self.tools:Print("Désabonnement au packet : "..kPacketName, "packet")
                developer:unRegisterMessage(kPacketName)
            end
        end
    end
end

function Packet:SendPacket(packetName, fn)
    self.tools:Print("Envoie du packet "..packetName, "packet")
    local msg = developer:createMessage(packetName)

    if fn ~= nil then
        msg = fn(msg)
    end

    developer:sendMessage(msg)
end

return Packet