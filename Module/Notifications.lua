Notifications = {}

Notifications.APIurl = "http://www.pushsafer.com/api"
Notifications.key = 0
Notifications.deviceID = 0

function Notifications:PSaferSendNotification(params)
    if self:PSaferPostRequest(self.APIurl, "k="..self.key.."&d="..self.deviceID.."&t="..params.title.."&m="..params.msg.."&i=20&s=37&v=3") then
        self:Print("Notification envoyé !", "Notification")
    else
        self:Print("Notification : Erreur lors de l'envoie de la notification", "error")
    end
end


function Notifications:PSaferPostRequest(url, data)
    local result = self.json:decode(developer:postRequest(url, data))

    if result == nil then
        self:Print("Notification : Result non définie", "Error")
        return false
    else
        if result.status == 0 then
            self:Print("Notification : "..result.error, "Error")
            return false
        elseif result.status == 1 then
            return true
        end
    end

end

return Notifications