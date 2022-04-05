Dijkstra = {}
Dijkstra.MAX_VALUE = 100000000000.0

function Dijkstra:Run(G, s)
    self.edgeTo = {}
    self.cost = {}
    self.marked = {}
    self.source = s

    for i = 1, G:VertexCount() do
        local v = G:VertexAt(i)
        self.marked[v] = false
        self.edgeTo[v] = -1
        self.cost[v] = Dijkstra.MAX_VALUE
    end

    local pq = self.indexedMinPQ()

    self.cost[s] = 0
    pq:Add(s, self.cost[s])

    while pq:IsEmpty() == false do
        local v = pq:MinIndex()
        pq:DelMin()
        self.marked[v] = true
        local adj_v = G:Adj(v)
        for i=1,adj_v:Size() do
            local e = adj_v:Get(i)
            self:Relax(G, e, pq)
        end

    end
end

function Dijkstra:Relax(G, e, pq)
    local v = e:From()
    local w = e:To()

    if self.marked[w] then
        return
    end

    if self.cost[w] > self.cost[v] + e.weight then
        self.cost[w] = self.cost[v] + e.weight
        self.edgeTo[w] = e
        if pq:Contains(w) then
            pq:DecreaseKey(w, self.cost[w])
        else
            pq:Add(w, self.cost[w])
        end
    end

end

function Dijkstra:HasPathTo(v)
    return self.marked[v]
end

function Dijkstra:GetPathLength(v)
    return self.cost[v]
end

function Dijkstra:GetPathTo(v)
    local stack = self.stack()
    local x = v
    while x ~= self.source do
        local e = self.edgeTo[x]
        stack:Push(e)
        x = e:Other(x)
    end
    return stack:ToList()
end


return Dijkstra

