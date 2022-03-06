local list = {}

function list:CreateWith(a, N)
    return self.c(a, N)
end

function list:MakeCopy()
    return self:CreateWith(self:Enumerate(), self.N)
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

function list:RemoveAt(index)
    if index <= self.N then
        if table.remove(self.a, index) ~= nil then
            self.N = self.N - 1
        end
    end
end

function list:IndexOf(value)
    if self.N == 0 then
        return -1
    end
    for i = 0, self.N do
        if self.a[i] == value then
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

return list