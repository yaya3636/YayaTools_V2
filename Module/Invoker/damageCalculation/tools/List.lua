local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

-- ListNode
ListNode = Class("ListNode")

function ListNode:init(item, next)
    self.item = item
    self.next = next
end

-- List
List = Class("List")

function List:init()
    self.h = nil
    self.q = nil
    self.length = 0
    self.classNode = ListNode
end

function List:remove(item)
    local prev = nil
    local current = self.h
    while current ~= nil do
        if current.item == item then
            if prev == nil then
                self.h = current.next
            else
                prev.next = current.next
            end
            if self.q == current then
                self.q = prev
            end
            self.length = self.length - 1
            return true
        end
        prev = current
        current = current.next
    end
    return false
end

function List:map(func)
    local newList = self.c()
    local current = self.h
    while current ~= nil do
        local item = current.item
        current = current.next
        newList:add(func(item))
    end
    return newList
end

function List:isEmpty()
    return self.h == nil
end

function List:filter(func)
    local newList = self.c()
    local current = self.h
    while current ~= nil do
        local item = current.item
        current = current.next
        if func(item) then
            newList:add(item)
        end
    end
    return newList
end

function List:add(item)
    local newNode = self.classNode(item, nil)
    if self.h == nil then
        self.h = newNode
    else
        self.q.next = newNode
    end
    self.q = newNode
    self.length = self.length + 1
end

return List