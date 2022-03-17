Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Craft = Tools.craft

function move()
    Tools:Dump(Craft.d2oRecipes)
end

Craft = Craft()
Tools = Tools()