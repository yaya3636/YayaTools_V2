local list = {}


function list:createWith(a, aLen, N)
    return self.list(a, aLen, N)
end

function list:makeCopy()
    local temp = {}
    for key,val in pairs(self.a) do
        temp[key] = val
    end
    return self:createWith(temp, self.aLen, self.N)
end

function list:add(value)
    self.a[self.N] = value
    self.N = self.N + 1
    if self.N == self.aLen then
        self:resize(self.aLen * 2)
    end
end

function list:set(index,value)
    self.a[index] = value
end

function list:get(index)
    local temp = self.a[index]
    return temp
end

function list:removeAt(index)
    if index == self.N-1 then
        self.N = self.N - 1
        return
    end
    for i = index+1,self.N-1 do
        self.a[i-1]=self.a[i]
    end
    self.N = self.N - 1
    if self.N == math.floor(self.aLen / 4) then
        self:resize(math.floor(self.aLen / 2))
    end

end

function list:indexOf(value)
    if self.N == 0 then
        return -1
    end
    for i=0,self.N-1 do
        if self.a[i] == value then
            return i
        end
    end
    return -1
end

function list:contains(value)
    return self:indexOf(value) ~= -1
end

function list:remove(value)
    local index = self:indexOf(value)
    self:removeAt(index)
end

function list:resize(newSize)
    local temp = {}
    for i = 0,(newSize-1) do
        temp[i] = self.a[i]
    end

    self.a = temp
    self.aLen = newSize
end

function list:size()
    return self.N
end

function list:isEmpty()
    return self.N == 0
end

function list:enumerate()
    local temp = {}
    for i = 0,(self.N-1) do
        temp[i] = self.a[i]
    end
    return temp
end

function list:isSortedAscendingly(comparator)
    for i=0,(self:size()-2) do
        if comparator(self:get(i), self:get(i+1)) > 0 then
            return false
        end

    end
    return true
end

function list:isSortedDescendingly(comparator)
    for i=0,(self:size()-2) do
        if comparator(self:get(i), self:get(i+1)) < 0 then
            return false
        end

    end
    return true
end

return list

