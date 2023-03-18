local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")
LinkedListIterator = {}

function LinkedListIterator:init(node)
    self.cursor = node
end

function LinkedListIterator:next()
    --Tools:Print(self.cursor.next)
    local currentNode = self.cursor
    self.cursor = self.cursor.next
    return currentNode
end

function LinkedListIterator:hasNext()
    return self.cursor ~= nil
end

return Class("LinkedListIterator", LinkedListIterator)