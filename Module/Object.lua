Object = {}

function Object:HasProperties(properties)
    if self[properties] then return true end return false
end

return Object