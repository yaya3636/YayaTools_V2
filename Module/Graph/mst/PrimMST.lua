--
-- Created by IntelliJ IDEA.
-- User: chen0
-- Date: 26/7/2017
-- Time: 9:29 AM
-- To change this template use File | Settings | File Templates.
--

local currentDirectory = global:getCurrentDirectory()

local PrimMST = {}
PrimMST.__index = PrimMST

function PrimMST.create()
    local s = {}
    setmetatable(s, PrimMST)

    s.marked = {}
    s.path = dofile(currentDirectory .. '\\YAYA\\Module\\Graph\\data\\list.lua').create()
    return s
end

function PrimMST:run(G)
    self.marked = {}
    self.path = dofile(currentDirectory .. '\\YAYA\\Module\\Graph\\data\\list.lua').create()
    local pq = dofile(currentDirectory .. '\\YAYA\\Module\\Graph\\data\\MinPQ.lua').create(function(e1, e2)
        return e1.weight - e2.weight
    end)

    for i = 0, G:vertexCount()-1 do
        local v = G:vertexAt(i)
        self.marked[v] = false
    end

    local source = G:vertexAt(0)
    local adj_s = G:adj(source)
    self.marked[source] = true
    for i = 0, adj_s:size()-1 do
        local e = adj_s:get(i)
        pq:add(e)
    end

    while pq:isEmpty() == false and self.path:size() < G:vertexCount() - 1 do
        local e = pq:delMin()
        local v = e:either()
        local w = e:other(v)
        if self.marked[v] == false or self.marked[w] == false then
            self.path:add(e)

            if self.marked[v] == false then
                self.marked[v] = true
                local adj_v = G:adj(v)
                for i = 0, adj_v:size()-1 do
                    local e_v = adj_v:get(i)
                    pq:add(e_v)
                end
            end

            if self.marked[w] == false then
                self.marked[w] = true
                local adj_w = G:adj(w)
                for i = 0, adj_w:size()-1 do
                    local e_w = adj_w:get(i)
                    pq:add(e_w)
                end
            end
        end
    end
end

return PrimMST

