Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua") -- Création d'une instance de Tools

function move()

    local timer1 = Tools.timer({min = 0, max = 0})
    local timer2 = Tools.timer({min = 1, max = 10}) -- Temp aléatoire choisie entre 1 et 10 min

    Tools:Print("Le timer et fini ? = " .. tostring(timer1:Timer()), "Timer1")
    Tools:Print("Le timer et fini ? = " .. tostring(timer2:Timer()), "Timer2")
end

Tools = Tools()