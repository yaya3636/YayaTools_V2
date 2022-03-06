Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua") -- Création d'une instance de Tools
Iphone10 = Tools.notifications({key = 0, deviceID = 0}) -- Création d'une instance de Notification
Iphone12 = Tools.notifications({key = 1, deviceID = 1}) -- Création d'une autres instance de Notification avec différent params

function move()
    Iphone10:PSaferSendNotification({title = "Alerte modérateur !", msg = "Keroopin est présent sur le serveur !"})
    Iphone12:PSaferSendNotification({title = "Alerte modérateur !", msg = "Keroopin est présent sur le serveur !"})
end

Tools = Tools()