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
    self.dic[tostring(key)] = value
    self.N = self.N + 1
end

function Dictionnary:Set(key, value)
    self.dic[tostring(key)] = value
end

function Dictionnary:Get(key)
    local tmp = self.dic[tostring(key)]
    return tmp
end

function Dictionnary:Concatenate(dic)
    for k, v in pairs(dic:Enumerate()) do
        self:Add(k, v)
    end
end

function Dictionnary:RemoveByKey(key)
    if self.dic[tostring(key)] ~= nil then
        self.dic[tostring(key)] = nil
        self.N = self.N - 1
    end
end

function Dictionnary:RemoveByValue(value)
    for k, v in pairs(self.dic) do
        if type(value) == "function" then
            if value(v) then
                self.dic[k] = nil
                self.N = self.N - 1
                break
            end
        else
            if v == value then
                self.dic[k] = nil
                self.N = self.N - 1
                break
            end
        end
    end
end

function Dictionnary:ContainsKey(key)
    if self.dic[tostring(key)] ~= nil then
        return true
    end
    return false
end

function Dictionnary:ContainsValue(value)
    for _, v in pairs(self.dic) do
        if type(value) == "function" then
            if value(v) then
                return true
            end
        else
            if v == value then
                return true
            end
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

function Dictionnary:EnumerateKeys()
    local ret = {}
    for k, _ in pairs(self.dic) do
        ret[k] = k
    end
    return ret
end

function Dictionnary:Clear()
    for k, _ in pairs(self:Enumerate()) do
        self:RemoveByKey(k)
    end
end

function Dictionnary:Shuffle()
    local iKey, iValue = {}, {}
    local j = 1
    for k, v in pairs(self:Enumerate()) do
        iKey[j] = k
        iValue[j] = v
        j = j + 1
    end
    local tmp = {}
    while self.tools:LenghtOfTable(tmp) ~= self.N do
        for i = self.N, 1, -1 do
            local rand = global:random(1, i)
            tmp[iKey[rand]] = iValue[rand]
        end
    end
    self.dic = tmp
end

function Dictionnary:Sort(fn)
    local newDic = self.c()

    for k, v in pairs(self:Enumerate()) do
        if fn(k, v) then
            newDic:Add(k, v)
        end
    end

    return newDic
end

function Dictionnary:Foreach(fn)
    for k, v in pairs(self:Enumerate()) do
        fn(v, k)
    end
end

return Dictionnary