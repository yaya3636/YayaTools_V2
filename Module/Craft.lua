Craft = {}

Craft.d2oRecipesPath = global:getCurrentDirectory() .. [[\YayaTools\Data\D2O\Recipes.json]]
Craft.d2oRecipes = {}

function Craft:InitD2oProperties()
    local d2oRecipes = self.tools.dictionnary()

    local parseIngredients = function(ingredients, quantities)
        local ret = self.tools.list()
        for i = 1, #ingredients do
            ret:Add(self.tools.object({
                ingredientId = ingredients[i],
                quantities = quantities[i]
            }))
        end
        return ret
    end

    for _, v in pairs(self.d2oRecipes) do
        d2oRecipes:Add(v.resultId, self.tools.object({
            craftId = v.resultId,
            typeId = v.resultTypeId,
            level = v.resultLevel,
            ingredients = parseIngredients(v.ingredientIds, v.quantities),
            jobId = v.jobId,
            skillId = v.skillId
        }))
    end

    self.d2oRecipes = d2oRecipes
end

function Craft:GetCraftInfo(craftId)
    local craftInfo = self.json:decode(self.tools:ReadFile(self.craftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo
    end
    return nil
end

function Craft:GetJobId(craftId)
    local craftInfo = self.json:decode(self.tools:ReadFile(self.craftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.jobId
    end
    return nil
end

function Craft:GetSkillId(craftId)
    local craftInfo = self.json:decode(self.tools:ReadFile(self.craftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.skillId
    end
    return nil
end

function Craft:GetLevel(craftId)
    local craftInfo = self.json:decode(self.tools:ReadFile(self.craftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.craftLvl
    end
    return nil
end

function Craft:GetTypeId(craftId)
    local craftInfo = self.json:decode(self.tools:ReadFile(self.craftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.typeId
    end
    return nil
end

function Craft:GetIngredients(craftId)
    local craftInfo = self.json:decode(self.tools:ReadFile(self.craftPath .. craftId .. ".json"))

    if craftInfo then
        return craftInfo.ingredients
    end
    return nil
end

return Craft