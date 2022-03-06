Dictionnary = {}
Dictionnary.dic = {}
Dictionnary.N = 0

function Dictionnary:CreateWith(dic, N)
    return self.c(dic, N)
end

function Dictionnary:MakeCopy()
    return self:CreateWith(self:Enumerate(), self.N)
end

function Dictionnary:Add(key, value)
    self.dic[key] = value
    self.N = self.N + 1
end

function Dictionnary:Set(key, value)
    self.dic[key] = value
end

function Dictionnary:Get(key)
    local tmp = self.dic[key]
    return tmp
end

function Dictionnary:RemoveByKey(key)
    if self.dic[key] ~= nil then
        self.dic[key] = nil
        self.N = self.N - 1
    end
end

function Dictionnary:RemoveByValue(value)
    for k, v in pairs(self.dic) do
        if v == value then
            self.dic[k] = nil
            self.N = self.N - 1
            break
        end
    end
end

function Dictionnary:ContainsKey(key)
    if self.dic[key] ~= nil then
        return true
    end
    return false
end

function Dictionnary:ContainsValue(value)
    for _, v in pairs(self.dic) do
        if v == value then
            return true
        end
    end
    return false
end

function Dictionnary:IsEmpty()
    if self.N == 0 then return true end
    return false
end

function Dictionnary:Size()
    return self.N
end

function Dictionnary:Enumerate()
    local ret = {}
    for k, v in pairs(self.dic) do
        ret[k] = v
    end
    return ret
end

return Dictionnary