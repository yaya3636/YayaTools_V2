Craft = {}

Craft.CraftPath = global:getCurrentDirectory() .. "\\YayaTools\\Data\\Recipes\\"


function Craft:GetCraftInfo(craftId)
    local craftInfo = self.json:decode(self:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo
    end
    return nil
end

function Craft:GetJobId(craftId)
    local craftInfo = self.json:decode(self:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.jobId
    end
    return nil
end

function Craft:GetSkillId(craftId)
    local craftInfo = self.json:decode(self:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.skillId
    end
    return nil
end

function Craft:GetLevel(craftId)
    local craftInfo = self.json:decode(self:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.craftLvl
    end
    return nil
end

function Craft:GetTypeId(craftId)
    local craftInfo = self.json:decode(self:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.typeId
    end
    return nil
end

function Craft:GetIngredients(craftId)
    local craftInfo = self.json:decode(self:ReadFile(self.CraftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.ingredients
    end
    return nil
end

return Craft