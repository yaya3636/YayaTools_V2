IndexedMinPQ = {}

function IndexedMinPQ:Less(a1, a2)
    return self.comparator(a1, a2) < 0
end

function IndexedMinPQ:Exchange(a, i, j)
    local temp = a[i]
    a[i] = a[j]
    a[j] = temp
end

function IndexedMinPQ:Add(index, key)
    self.keys[index] = key
    self.N = self.N + 1
    self.pq[self.N] = index
    self.qp[index] = self.N

    self:Swim(self.N)
end

function IndexedMinPQ:Swim(k)
    while k > 1 do
        local parent = math.floor(k / 2)
        if self:Less(self.keys[self.pq[k]], self.keys[self.pq[parent]]) then
            self:Exchange(self.pq, k, parent)
            self.qp[self.pq[k]] = k
            self.qp[self.pq[parent]] = parent
        else
            break
        end
    end

end

function IndexedMinPQ:MinKey()
    return self.keys[self.pq[1]]
end

function IndexedMinPQ:MinIndex()
    return self.pq[1]
end

function IndexedMinPQ:DelMin()
    if self.N == 0 then
        return nil
    end

    local key = self.keys[self.pq[1]]
    self:Exchange(self.pq, 1, self.N)
    self.qp[self.pq[1]] = 1
    self.qp[self.pq[self.N]] = self.N
    self.N = self.N - 1

    self:Sink(1)

    return key
end

function IndexedMinPQ:Sink(k)
    while k * 2 <= self.N do
        local child = k * 2
        if child < self.N and self:Less(self.keys[self.pq[child+1]], self.keys[self.pq[child]]) then
            child = child + 1
        end

        if self:Less(self.keys[self.pq[child]], self.keys[self.pq[k]]) then
            self:Exchange(self.pq, child, k)
            self.qp[self.pq[child]] = child
            self.qp[self.pq[k]] = k
        else
            break
        end
    end
end

function IndexedMinPQ:DecreaseKey(index, key)
    if self:Less(key, self.keys[index]) then
        local position = self.qp[index]
        self.keys[index] = key
        self:Swim(position)
    end
end

function IndexedMinPQ:Contains(index)
    return self.keys[index] ~= nil
end

function IndexedMinPQ:Size()
    return self.N
end

function IndexedMinPQ:IsEmpty()
    return self.N == 0
end

return IndexedMinPQ

