Memory = {}

Memory.registeredKey = nil

function Memory:Add(key, value)
    if not self.registeredKey:Contains(key) then
        self.registeredKey:Add(key)
        developer:addInGlobalMemory(key, value)
        self.tools:Print("La clé (" .. key .. ") a bien été enregistré", "Memory")
    else
        self.tools:Print("La clé et déjà enregistré", "Memory")
    end
end

function Memory:Set(key, value)
    if self.registeredKey:Contains(key) then
        developer:editInGlobalMemory(key, value)
        self.tools:Print("La clé (" .. key .. ") a bien été modifié", "Memory")
    else
        self.tools:Print("La clé (" .. key .. ") n'éxiste pas", "Memory")
    end
end

function Memory:Get(key)
    if self.registeredKey:Contains(key) then
        return developer:getInGlobalMemory(key)
    else
        self.tools:Print("La clé (" .. key .. ") n'éxiste pas", "Memory")
    end
end

function Memory:Remove(key)
    if self.registeredKey:Contains(key) then
        developer:deleteFromGlobalMemory(key)
        self.registeredKey:Remove(key)
        self.tools:Print("La clé (" .. key .. ") a bien été supprimé", "Memory")
    else
        self.tools:Print("La clé (" .. key .. ") n'éxiste pas", "Memory")
    end
end

function Memory:ContainsKey(key)
    return self.registeredKey:Contains(key)
end

function Memory:Enumerate()
    local dic = self.tools.dictionnary()

    self.registeredKey:Foreach(function(v)
        dic:Add(v, self:Get(v))
    end)

    return dic
end

function Memory:Clear()
    developer:deleteAllGlobalMemory()
    self.registeredKey:Clear()
    self.tools:Print("Toutes les clés ont bien été supprimé", "Memory")
end

return Memory