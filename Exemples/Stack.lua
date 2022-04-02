Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")

function move()
    local stack = Tools.stack()
    stack:Push("1")
    stack:Push("2")
    stack:Push("3")
    stack:Push("4")
    stack:Push("5")
    stack:Push("6")

    Tools:Print("La stack est vide ? " .. tostring(stack:IsEmpty()))
    Tools:Print("Taille de la stack : " .. stack:Size())


    local listStack = stack:ToList()
    Tools:Dump(listStack)

    for _ = 1, stack:Size() do
        Tools:Print(stack:Pop())
    end

    Tools:Print("La stack est vide ? " .. tostring(stack:IsEmpty()))
    Tools:Print("Taille de la stack : " .. stack:Size())
end

Tools = Tools()