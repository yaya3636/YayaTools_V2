Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")

function move()
    local queue = Tools.queue()

    queue:Enqueue("1")
    queue:Enqueue("Hello")
    queue:Enqueue("2")
    queue:Enqueue("Ankabot")
    queue:Enqueue("Dofus")
    queue:Enqueue("3")
    queue:Enqueue("4")

    Tools:Print("La queue est vide ? " .. tostring(queue:IsEmpty()))
    Tools:Print("Taille de la queue : " .. queue:Size())

    for _ = 1, queue:Size() do
        Tools:Print(queue:Dequeue())
    end

    Tools:Print("La queue est vide ? " .. tostring(queue:IsEmpty()))
    Tools:Print("Taille de la queue : " .. queue:Size())
end

Tools = Tools()