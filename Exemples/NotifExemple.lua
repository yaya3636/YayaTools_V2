Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")()
Iphone10 = Tools.notifications({key = 0, deviceID = 0})
Iphone12 = Tools.notifications({key = 1, deviceID = 1})

function move()
    Iphone10:PSaferSendNotification({title = "Alerte modérateur !", msg = "Keroopin est présent sur le serveur !"})
    Iphone12:PSaferSendNotification({title = "Alerte modérateur !", msg = "Keroopin est présent sur le serveur !"})
end