Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
Craft = Tools.craft

function move()
    Tools:Dump(Craft:GetCraftObject(283))
end

Craft = Craft()
Tools = Tools()