Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Zone = Tools.zone

function move()
    local obj = Tools.object({ test = "test"})
    local dic = Tools.dictionnary()
    local list = Tools.list()
    list:Add("Test")
    dic:Add("test", list)
    Tools:Dump(dic)
end


--Zone = Zone()
Tools = Tools()