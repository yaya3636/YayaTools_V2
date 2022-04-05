Graph = {}

Graph.edge = {}

-- Edge

function Graph.edge:From()
    return self.v
end

function Graph.edge:To()
    return self.w;
end

function Graph.edge:Either()
    return self.v
end

function Graph.edge:Other(x)
    if x == self.v then
        return self.w
    else
        return self.v
    end
end

-- Graph

function Graph:VertexCount()
    return self.vertexList:Size()
end

function Graph:Vertices()
    return self.vertexList
end

function Graph:CreateFromVertexList(vertices, directed)
    if directed == nil then
        directed = false
    end

    local g = self.c(self.vertexList:Size(), directed)

    g.vertexList = vertices
    g.adjList = {}
    for i = 0,g.vertexList:Size()-1 do
        local v = g.vertexList:Get(i)
        g.adjList[v] = self.list()
    end
    g.directed = directed

    return g
end

function Graph:AddVertexIfNotExists(v)
    if self.vertexList:Contains(v) then
        return false
    else
        self.vertexList:Add(v)
        self.adjList[v] = self.list()
        return true
    end
end

function Graph:RemoveVertex(v)
    if self.vertexList:Contains(v) then
        self.vertexList:Remove(v)
        self.adjList[v] = nil
        for i = 0, self.vertexList:Size() - 1 do
            local w = self.vertexList:Get(i)
            local adj_w = self.adjList[w]
            for k = 0, adj_w:Size() - 1 do
                local e = adj_w:Get(k)
                if e:Other(w) == v then
                    adj_w:RemoveAt(k)
                    break
                end
            end
        end
    end
end

function Graph:ContainsVertex(v)
    return self.vertexList:Contains(v)
end

function Graph:Adj(v)
    return self.adjList[v]
end

function Graph:AddEdge(v, w, weight)
    local e = self.edge(v, w, weight)
    self:AddVertexIfNotExists(v)
    self:AddVertexIfNotExists(w)
    if self.directed then
        self.adjList[e:From()]:Add(e)
    else
        self.adjList[e:From()]:Add(e)
        self.adjList[e:To()]:Add(e)
    end

end

function Graph:Reverse()
    local g = self:CreateFromVertexList(self.vertexList, self.directed)
    for k = 0, self:VertexCount()-1 do
        local v = self:VertexAt(k)
        local adj_v = self:Adj(v)
        for i = 0, adj_v:Size() - 1 do
            local e = adj_v:Get(i)
            g:AddEdge(e:To(), e:From(), e.weight)
        end
    end
    return g
end

function Graph:VertexAt(i)
    return self.vertexList:Get(i)
end

function Graph:Edges()
    local list = self.list()

    for i = 0, self.vertexList:Size() - 1 do
        local v = self.vertexList:Get(i)
        local adj_v = self:Adj(v)
        for j = 0, adj_v:Size() - 1 do
            local e = adj_v:Get(j)
            local w = e:Other(v)
            if self.directed == true or w > v then
                list:Add(e)
            end
        end
    end
    return list
end

function Graph:HasEdge(v, w)
    local adj_v = self:Adj(v)
    for i = 0, adj_v:Size() - 1 do
        local e = adj_v:Get(i)
        if e:To() == w then
            return true
        end
    end
    return false
end

return Graph