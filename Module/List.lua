List = {}

function List:CreateWith(a)
    return self.c(a)
end

function List:MakeCopy()
    return self:CreateWith(self:Enumerate())
end

function List:Add(value)
    self.N = self.N + 1
    self.a[self.N] = value
    return self.N
end

function List:Set(index, value)
    self.a[index] = value
end

function List:Insert(index, value)
    self.N = self.N + 1
    table.insert(self.a, index, value)
end

function List:Get(index)
    local temp = self.a[index]
    return temp
end

function List:Clear()
    for i = self:Size(), 1, -1 do
        self:RemoveAt(i)
    end
end

function List:Concatenate(list)
    for _, v in pairs(list:Enumerate()) do
        self:Add(v)
    end
end

function List:RemoveAt(index)
    if index > 0 and index <= self.N then
        local removedValue = table.remove(self.a, index)
        if removedValue ~= nil then
            self.N = self.N - 1
            return removedValue
        end
    end
    return nil
end

function List:IndexOf(value)
    for i, v in ipairs(self.a) do
        if type(value) == "function" then
            if value(v) then
                return i
            end
        else
            if v == value then
                return i
            end
        end
    end
    return -1
end

function List:Contains(value)
    return self:IndexOf(value) ~= -1
end

function List:Remove(value)
    local index = self:IndexOf(value)
    return self:RemoveAt(index)
end

function List:Size()
    return self.N
end

function List:IsEmpty()
    return self.N == 0
end

function List:Enumerate()
    local ret = {}
    for i, v in ipairs(self.a) do
        ret[i] = v
    end
    return ret
end

function List:Equal(listComp)
    if listComp:Size() ~= self:Size() then return false end

    for i, v in ipairs(listComp:Enumerate()) do
        if self.a[i] ~= v then
            return false
        end
    end

    return true
end

function List:Shuffle()
    for i = self.N, 1, -1 do
        local j = global:random(1, i)
        self.a[i], self.a[j] = self.a[j], self.a[i]
    end
end

function List:Foreach(fn)
    for i, v in ipairs(self:Enumerate()) do
        fn(v, i)
    end
end

return List