Stack = {}
Stack.first = nil
Stack.N = 0


Stack.node = {}
Stack.node.value = nil
Stack.node.next = nil

function Stack:Push(val)
    local oldFirst = self.first
    self.first = self.node(val)
    self.first.next = oldFirst
    self.N = self.N + 1
end

function Stack:Size()
    return self.N
end

function Stack:IsEmpty()
    return self.N == 0
end

function Stack:Pop()
    if self.N == 0 then
        return nil
    end

    self.N = self.N - 1

    local oldFirst = self.first
    local val

    if oldFirst then
        val = oldFirst.value
        self.first = oldFirst.next
    end
    return val
end

function Stack:ToList()
    local result = self.list()
    local x = self.first
    while x ~= nil do
        result:Add(x.value)
        x = x.next
    end
    return result
end

function Stack:Clear()
    self.first = nil
    self.N = 0
end

return Stack
