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

function Craft:GetCraftObject(craftId)
    return self.d2oRecipes:Get(craftId) or nil
end

function Craft:GetJobId(craftId)
    return self.d2oRecipes:Get(craftId).jobId or nil
end

function Craft:GetSkillId(craftId)
    return self.d2oRecipes:Get(craftId).skillId or nil
end

function Craft:GetLevel(craftId)
    return self.d2oRecipes:Get(craftId).level or nil
end

function Craft:GetTypeId(craftId)
    return self.d2oRecipes:Get(craftId).typeId or nil
end

function Craft:GetIngredients(craftId)
    return self.d2oRecipes:Get(craftId).ingredients or nil
end

return Craft