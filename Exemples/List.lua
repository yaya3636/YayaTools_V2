Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")

function move()
    local list1 = Tools.list()
    list1:Add("ValueTest")
    Tools:Print("Contains : ValueTest = " .. tostring(list1:Contains("ValueTest")), "list1")
    Tools:Print("Taille de la liste = " ..  list1:Size(), "list1")

    local list2 = list1:MakeCopy()
    list1:Remove("ValueTest")

    Tools:Print("Contains : ValueTest = " .. tostring(list1:Contains("ValueTest")), "list1")
    Tools:Print("Taille de la liste = " ..  list1:Size(), "list1")


    Tools:Print("Contains : ValueTest = " .. tostring(list2:Contains("ValueTest")), "list2")
    Tools:Print("Taille de la liste = " ..  list2:Size(), "list2")
    Tools:Dump(list2:Enumerate())
    Tools:Print(list1)
    Tools:Print(list2)

end

Tools = Tools()