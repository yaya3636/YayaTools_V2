Queue = {}
Queue.first = nil
Queue.last = nil
Queue.N = 0


Queue.node = {}
Queue.node.value = nil
Queue.node.next = nil

function Queue:Enqueue(value)
    local oldLast = self.last
    self.last = self.node(value)

    if oldLast ~= nil then
        oldLast.next = self.last
    end

    if self.first == nil then
        self.first = self.last
    end

    self.N = self.N + 1
end

function Queue:Dequeue()
    local oldFirst = self.first
    if oldFirst == nil then
        return nil
    end

    local value = oldFirst.value
    self.first = oldFirst.next
    self.N = self.N - 1
    if self.first == nil then
        self.last = nil
    end
    return value
end

function Queue:Size()
    return self.N
end

function Queue:IsEmpty()
    return self.N == 0
end

function Queue:Clear()
    self.first = nil
    self.last = nil
    self.N = 0
end

return Queue