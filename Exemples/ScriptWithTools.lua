Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Movement = Tools.movement
Zone = Tools.zone
Packet = Tools.packet
Character = Tools.character

MyScript = Tools.object() -- On créer un object nommé MyScript, un object c'est comme une table mais vous aurez accès a la fonction HasProperties sur votre object
-- Définition des variable de notre object MyScript
MyScript.isStarted = false
MyScript.timer = nil
MyScript.selectedList = 1
MyScript.maListDeMapId = Tools.list({153881600, 153881601, 153881089, 153881088, 153880064, 153879552})

function MyScript:Start() -- Fonction Start utilisée pour initier le premier timer qui serais nil sinon et retournerais une erreur ligne 25
    Tools:Print("Hello jeune aventurier", "Hello")
    self.listMapIdForetIncarnam = Zone:GetSubAreaMapId(443) -- On récupère la list de mapId de la sous zone foret a inca
    self.isStarted = true
    MyScript.timer = Tools.timer({min = 1, max = 1}) -- Création d'un timer de 1 min
end

function move()
    if not MyScript.isStarted then
        MyScript:Start()
    end

    if MyScript.timer:IsFinish() then -- Si le timer et fini on change de list et on recréer un timer de 1 min
        Tools:Print("Le timer est fini on change de zone !", "MyInfo")
        -- Changement de list, on pourrais faire autrement mais je fait au plus simple
        if MyScript.selectedList == 1 then
            MyScript.selectedList = 2
        else
            MyScript.selectedList = 1
        end

        MyScript.timer = Tools.timer({min = 1, max = 1}) -- Re création d'un timer
    end

    map:gather() -- On gather avant de changer de map

    -- On lance RoadZone avec la bonne list en fonction de la valeur de selectedList
    if MyScript.selectedList == 1 then
        Movement:RoadZone(MyScript.maListDeMapId)
    elseif MyScript.selectedList == 2 then
        Movement:RoadZone(MyScript.listMapIdForetIncarnam)
    end

    -- Ici ton code ne s'aura pas lu car tu change de map avant avec Roadzone
end

function messagesRegistering() -- Init obligatoire des (Tools) utilisé
    Movement:InitCallBack()
    Character.dialog:InitCallBack()
end

local color = Tools.dictionnary()
color:Add("Hello", "#91a832") -- La couleur du print avec le header Hello sera jaune
color:Add("MyInfo", "#21c264") -- La couleur du print avec le header MyInfo sera vert


-- Instanciation obligatoire de tout les module utilisé
Zone = Zone()
Packet = Packet()
Character.dialog = Character.dialog({packet = Packet})
Character = Character()
Movement = Movement({zone = Zone, packet = Packet, character = Character})
Tools = Tools({colorPrint = color}) -- On ajoute nos couleur en paramètre lors de l'instanciation de tools