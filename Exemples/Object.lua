Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")

function move()
    local obj = Tools.object({ test = "test" })
    Tools:Print(obj:HasProperties("test"))
    Tools:Print(obj:HasProperties("autre"))
    Tools:Dump(obj)
end

Tools = Tools()