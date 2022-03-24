Packet = {}

Packet.subscribedPacket = {}

function Packet:SubManager(packetToSub)
    for kPacketName, vCallBack in pairs(packetToSub) do
        if type(vCallBack) == "function" then -- Abonnement au packet
            local signatureFunc = string.dump(vCallBack)
            -- Vérifie si le packet est déja enregistrer sinon on l'enregistre
            if not self.subscribedPacket:ContainsKey(kPacketName) then
                self.tools:Print("Abonnement au packet : "..kPacketName, "packet")
                self.subscribedPacket:Add(kPacketName, self.tools.dictionnary())
            end

            -- Vérifie si la fonction a deja était ajouté sinon on l'ajoute
            local subPacket = self.subscribedPacket:Get(kPacketName)
            if not subPacket:ContainsKey(signatureFunc) then
                self.tools:Print("Ajout d'un callback au packet : "..kPacketName, "packet")
                subPacket:Add(signatureFunc, vCallBack)
            else
                self.tools:Print("Le callback est déja définie au packet : "..kPacketName, "packet")
            end


            -- Vérifie si la fonction de callback est deja definie sinon on la definie
            if not self[kPacketName] then
                self[kPacketName] = function(msg)
                    local tblFunc = self.subscribedPacket:Get(developer:typeOf(msg))
                    for _, v in pairs(tblFunc:Enumerate()) do
                        v(msg)
                    end
                end
            end

            -- Enregistrement du packet
            if not developer:isMessageRegistred(kPacketName) then
                developer:registerMessage(kPacketName, self[kPacketName])
            end
        elseif type(vCallBack) == "string" then
            if developer:isMessageRegistred(vCallBack) then
                self.tools:Print("Désabonnement au packet : "..vCallBack, "packet")
                self.subscribedPacket:Set(vCallBack, nil)
                developer:unRegisterMessage(vCallBack)
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