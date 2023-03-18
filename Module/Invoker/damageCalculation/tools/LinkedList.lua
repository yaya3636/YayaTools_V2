local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

LinkedListIterator =  dofile(yayaToolsModuleDirectory .. "Invoker\\damageCalculation\\tools\\LinkedListIterator.lua")
LinkedListNode =  dofile(yayaToolsModuleDirectory .. "Invoker\\damageCalculation\\tools\\LinkedListNode.lua")

LinkedList = Class("LinkedList")

function LinkedList:init()
    self.tail = nil
    self.head = nil
    self.classIterator = LinkedListIterator
    self.classNode = LinkedListNode
end

function LinkedList:remove(node)
    if node.previous ~= nil then
        node.previous.next = node.next
    end
    if node.next ~= nil then
        node.next.previous = node.previous
    end
    if node == self.head then
        self.head = node.next
    end
    if node == self.tail then
        self.tail = node.previous
    end
end

function LinkedList:iterator()
    return self.classIterator(self.head)
end

function LinkedList:copy()
    local copiedList = self.c()
    local currentNode = self.head
    while currentNode ~= nil do
        copiedList:add(currentNode.item)
        currentNode = currentNode.next
    end
    return copiedList
end

function LinkedList:clear()
    self.head = nil
    self.tail = nil
end

function LinkedList:append(list)
    local currentNode = list.head
    while currentNode ~= nil do
        self:add(currentNode.item)
        currentNode = currentNode.next
    end
    return self
end

function LinkedList:add(item)
    local newNode = self.classNode(item)
    if self.head == nil then
        self.head = newNode
    end
    if self.tail == nil then
        self.tail = newNode
    else
        newNode.previous = self.tail
        self.tail.next = newNode
        self.tail = newNode
    end
    return newNode
end

return LinkedList