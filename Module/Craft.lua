Craft = {}

function Craft:GetCraftObject(craftId)
    local recipe = d2data:objectFromD2O("Recipes", craftId).Fields
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