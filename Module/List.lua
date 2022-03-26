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
end

function List:Set(index,value)
    self.a[index] = value
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
    if index <= self.N then
        if table.remove(self.a, index) ~= nil then
            self.N = self.N - 1
        end
    end
end

function List:IndexOf(value)
    for i, v in ipairs(self.a) do
        if v == value then
            return i
        end
    end
    return -1
end

function List:Contains(value)
    return self:IndexOf(value) ~= -1
end

function List:Remove(value)
    local index = self:IndexOf(value)
    self:RemoveAt(index)
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

return List