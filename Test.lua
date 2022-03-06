Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")

Craft = Tools.craft()
Monsters = Tools.monsters()
Movement = Tools.movement()
Zone = Tools.zone()
API = Tools.api()


function move()
    local dic1 = Tools.dictionnary()
    dic1:Add("Test", "Test")
    --dic1:RemoveByKey("Test")
    local dic2 = dic1:MakeCopy()

    Tools:Print(dic2:Size())
    Tools:Dump(dic2:Enumerate())


    local list1 = Tools.list()

    list1:Add("test")

    local list2 = list1:MakeCopy()
    Tools:Print(list2:Contains("test"))
    list2:RemoveAt(1)
    Tools:Print(list2:Contains("test"))

    Tools:Print(list2:Size())
    Tools:Dump(list2:Enumerate())
end

Tools = Tools()