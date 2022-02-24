Tools = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Tools.lua")
--Graph = dofile(global:getCurrentDirectory() .. "\\YayaTools\\Module\\Graph\\data\\graph.lua")
ToolsInstance = Tools()


function move()
    ToolsInstance:Print(ToolsInstance, "Instance")
    ToolsInstance:Print(ToolsInstance.api, "Instance")
    ToolsInstance:Print(ToolsInstance.api.dofusDB, "Instance")
    ToolsInstance:Print(ToolsInstance.api.dofusDB.harvestable, "Instance")

    ToolsInstance:Dump(ToolsInstance.api.dofusDB.harvestable:GetHarvestablePosition(303), 100)

end