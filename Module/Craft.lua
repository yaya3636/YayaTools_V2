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
    local recipe = self.api.localAPI:GetRecipe(craftId)
    if recipe then
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
        local obj = self.tools.object(recipe)
        obj.ingredientIds = parseIngredients(recipe.ingredientIds, recipe.quantities)
        return obj
    end

    return nil
end

function Craft:GetJobId(craftId)
    local recipe = self:GetCraftObject(craftId)
    if recipe then return recipe.jobId end
    return nil
end

function Craft:GetSkillId(craftId)
    local recipe = self:GetCraftObject(craftId)
    if recipe then return recipe.skillId end
    return nil
end

function Craft:GetLevel(craftId)
    local recipe = self:GetCraftObject(craftId)
    if recipe then return recipe.resultLevel end
    return nil
end

function Craft:GetTypeId(craftId)
    local recipe = self:GetCraftObject(craftId)
    if recipe then return recipe.resultTypeId end
    return nil
end

function Craft:GetIngredients(craftId)
    local recipe = self:GetCraftObject(craftId)
    if recipe then return recipe.ingredientIds end
    return nil
end

return Craft