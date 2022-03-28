Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Craft = Tools.craft
API = Tools.api

function move()
    Tools:Dump(Craft:GetIngredients(44))
end

API = API()
Craft = Craft({api = API})
Tools = Tools()