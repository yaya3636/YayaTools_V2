local list = {}

function list:CreateWith(a)
    return self.c(a)
end

function list:MakeCopy()
    return self:CreateWith(self:Enumerate())
end

function list:Add(value)
    self.N = self.N + 1
    self.a[self.N] = value
end

function list:Set(index,value)
    self.a[index] = value
end

function list:Get(index)
    local temp = self.a[index]
    return temp
end

function list:Clear()
    for i = self:Size(), 1, -1 do
        self:RemoveAt(i)
    end
end

function list:RemoveAt(index)
    if index <= self.N then
        if table.remove(self.a, index) ~= nil then
            self.N = self.N - 1
        end
    end
end

function list:IndexOf(value)
    for i, v in ipairs(self.a) do
        if v == value then
            return i
        end
    end
    return -1
end

function list:Contains(value)
    return self:IndexOf(value) ~= -1
end

function list:Remove(value)
    local index = self:IndexOf(value)
    self:RemoveAt(index)
end

function list:Size()
    return self.N
end

function list:IsEmpty()
    return self.N == 0
end

function list:Enumerate()
    local ret = {}
    for i, v in ipairs(self.a) do
        ret[i] = v
    end
    return ret
end

function list:Equal(listComp)
    if listComp:Size() ~= self:Size() then return false end

    for i, v in ipairs(listComp:Enumerate()) do
        if self.a[i] ~= v then
            return false
        end
    end

    return true
end

return list