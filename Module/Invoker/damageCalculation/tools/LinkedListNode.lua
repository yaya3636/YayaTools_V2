local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

LinkedListNode = {}

function LinkedListNode:init(item)
    self.previous = nil
    self.next = nil
    self.item = item
end

return Class("LinkedListNode", LinkedListNode)