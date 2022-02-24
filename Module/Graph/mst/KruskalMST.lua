--
-- Created by IntelliJ IDEA.
-- User: chen0
-- Date: 26/7/2017
-- Time: 9:29 AM
-- To change this template use File | Settings | File Templates.
--
local currentDirectory = global:getCurrentDirectory()

local KruskalMST = {}
KruskalMST.__index = KruskalMST

function KruskalMST.create()
    local s = {}
    setmetatable(s, KruskalMST)

    s.marked = {}
    s.path = dofile(currentDirectory .. '\\YAYA\\Module\\Graph\\data\\list.lua').create()
    return s
end

function KruskalMST:run(G)
    self.marked = {}
    self.path = dofile(currentDirectory .. '\\YAYA\\Module\\Graph\\data\\list.lua').create()
    local pq = dofile(currentDirectory .. '\\YAYA\\Module\\Graph\\data\\MinPQ.lua').create(function(e1, e2)
        return e1.weight - e2.weight
    end)

    for i = 0, G:vertexCount()-1 do
        local v = G:vertexAt(i)
        self.marked[v] = false
    end

    local edges = G:edges()
    for i = 0, edges:size()-1 do
        local e = edges:get(i)
        pq:add(e)
    end

    local uf = dofile(currentDirectory .. '\\YAYA\\Module\\Graph\\data\\UnionFind.lua').createFromVertexList(G:vertices())
    while pq:isEmpty() == false and self.path:size() < G:vertexCount() - 1 do
        local e = pq:delMin()
        local v = e:either()
        local w = e:other(v)
        if uf:connected(w, v) == false then
            uf:union(w, v)
            self.path:add(e)
        end
    end
end

return KruskalMST

