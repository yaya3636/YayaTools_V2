Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")

function move()
    local dic1 = Tools.dictionnary()
    dic1:Add("KeyTest", "ValueTest")
    Tools:Print("ContainsValue : ValueTest = " .. tostring(dic1:ContainsValue("ValueTest")), "dic1")
    Tools:Print("ContainsKey : KeyTest = " .. tostring(dic1:ContainsKey("KeyTest")), "dic1")
    Tools:Print("Taille du dictionnaire = " ..  dic1:Size(), "dic1")

    local dic2 = dic1:MakeCopy()

    dic1:RemoveByKey("KeyTest")
    Tools:Print("ContainsValue : ValueTest = " .. tostring(dic1:ContainsValue("ValueTest")), "dic1")
    Tools:Print("ContainsKey : KeyTest = " .. tostring(dic1:ContainsKey("KeyTest")), "dic1")
    Tools:Print("Taille du dictionnaire = " ..  dic1:Size(), "dic1")


    Tools:Print("ContainsValue : ValueTest = " .. tostring(dic2:ContainsValue("ValueTest")), "dic2")
    Tools:Print("ContainsKey : KeyTest = " .. tostring(dic2:ContainsKey("KeyTest")), "dic2")
    Tools:Print("Taille du dictionnaire = " ..  dic2:Size(), "dic2")
    Tools:Dump(dic2:Enumerate())
    Tools:Print(dic1)
    Tools:Print(dic2)

end

Tools = Tools()