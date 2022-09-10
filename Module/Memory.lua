Memory = {}

Memory.instanceUID = nil
Memory.registeredKey = nil

function Memory:Add(key, value)
    self:UpdateRegisteredKeys()
    if not self.registeredKey:Contains(self.instanceUID .."-" .. key) then
        local registeredKey = developer:getInGlobalMemory(self.instanceUID .. "-RegisteredKeys")
        table.insert(registeredKey, self.instanceUID .."-" .. key)
        developer:editInGlobalMemory(self.instanceUID .. "-RegisteredKeys", registeredKey)
        developer:addInGlobalMemory(self.instanceUID .."-" .. key, value)
        self.tools:Print("La clé (" .. key .. ") a bien été enregistré", "Memory")
    else
        self.tools:Print("La clé et déjà enregistré", "Memory")
    end
end

function Memory:Set(key, value)
    self:UpdateRegisteredKeys()
    if self.registeredKey:Contains(self.instanceUID .."-" .. key) then
        developer:editInGlobalMemory(self.instanceUID .."-" .. key, value)
        self.tools:Print("La clé (" .. key .. ") a bien été modifié", "Memory")
    else
        self.tools:Print("La clé (" .. key .. ") n'éxiste pas", "Memory")
    end
end

function Memory:AddRegisteredKey(key)
    self:UpdateRegisteredKeys()
    self.tools:Print("La clé (" .. key .. ") a bien été enregistré dans le registre", "Memory")
    local registeredKey = developer:getInGlobalMemory(self.instanceUID .. "-RegisteredKeys")
    table.insert(registeredKey, self.instanceUID .."-" .. key)
    developer:editInGlobalMemory(self.instanceUID .. "-RegisteredKeys", registeredKey)
end

function Memory:Get(key)
    self:UpdateRegisteredKeys()
    if self.registeredKey:Contains(self.instanceUID .."-" .. key) then
        return developer:getInGlobalMemory(self.instanceUID .."-" .. key)
    else
        self.tools:Print("La clé (" .. key .. ") n'éxiste pas", "Memory")
    end
end

function Memory:Remove(key)
    local UID = self.instanceUID .."-"
    self:UpdateRegisteredKeys()
    if self.registeredKey:Contains(self.instanceUID .."-" .. key) then
        developer:deleteFromGlobalMemory(self.instanceUID .."-" .. key)
        local registeredKey = developer:getInGlobalMemory(self.instanceUID .. "-RegisteredKeys")
        for k, v in pairs(registeredKey) do
            if v:sub(UID:len() + 1) == key then
                v = nil
                break
            end
        end
        developer:editInGlobalMemory(self.instanceUID .. "-RegisteredKeys", registeredKey)    
        self.tools:Print("La clé (" .. key .. ") a bien été supprimé", "Memory")
    else
        self.tools:Print("La clé (" .. key .. ") n'éxiste pas", "Memory")
    end
end

function Memory:ContainsKey(key)
    self:UpdateRegisteredKeys()
    return self.registeredKey:Contains(self.instanceUID .."-" .. key)
end

function Memory:Enumerate()
    self:UpdateRegisteredKeys()
    local UID = self.instanceUID .."-"
    local dic = self.tools.dictionnary()

    self.registeredKey:Foreach(function(v)
        dic:Add(v, self:Get(v:sub(UID:len() + 1)))
    end)

    return dic
end

function Memory:Clear()
    self:UpdateRegisteredKeys()
    local UID = self.instanceUID .."-"
    for _, v in pairs(self.registeredKey:Enumerate()) do
        self:Remove(v:sub(UID:len() + 1))
    end
    self.tools:Print("Toutes les clés ont bien été supprimé", "Memory")
end

function Memory:KillInstance()
    self:Clear()
    developer:deleteFromGlobalMemory(self.instanceUID .."-" .. "RegisteredKeys")
    developer:deleteFromGlobalMemory(self.instanceUID)
    self.tools:Print("L'instance (" .. self.instanceUID .. ") a bien été supprimé", "Memory")
end

function Memory:CreateInstance(instanceUID)
    if not developer:getInGlobalMemory(instanceUID) then
        self.tools:Print("L'instance (" .. instanceUID .. ") a été créer !", "Memory")
        self.instanceUID = instanceUID
        developer:addInGlobalMemory(instanceUID, true)
        developer:addInGlobalMemory(instanceUID .. "-RegisteredKeys", {})
    else
        self.tools:Print("L'instance (" .. instanceUID .. ") éxiste déja !", "Memory")
    end
end

function Memory:BindInstance(instanceUID)
    if not developer:getInGlobalMemory(instanceUID) then
        self.tools:Print("L'instance (" .. instanceUID .. ") n'éxiste pas !", "Memory")
    else
        self.instanceUID = instanceUID
        self.tools:Print("La liaison avec l'instance (" .. instanceUID .. ") a bien été pris en compte", "Memory")
    end
end

function Memory:UpdateRegisteredKeys()
    local keys = developer:getInGlobalMemory(self.instanceUID .. "-RegisteredKeys")
    self.registeredKey = self.tools.list(keys)
end

return Memory