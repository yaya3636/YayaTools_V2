JSON = {}

-- Decode

local function create_set(...)
    local res = {}
    for i = 1, select("#", ...) do
      res[ select(i, ...) ] = true
    end
    return res
end

JSON.charFuncMap = {
    [ '"' ] = JSON.ParseString,
    [ "0" ] = JSON.ParseNumber,
    [ "1" ] = JSON.ParseNumber,
    [ "2" ] = JSON.ParseNumber,
    [ "3" ] = JSON.ParseNumber,
    [ "4" ] = JSON.ParseNumber,
    [ "5" ] = JSON.ParseNumber,
    [ "6" ] = JSON.ParseNumber,
    [ "7" ] = JSON.ParseNumber,
    [ "8" ] = JSON.ParseNumber,
    [ "9" ] = JSON.ParseNumber,
    [ "-" ] = JSON.ParseNumber,
    [ "t" ] = JSON.ParseLiteral,
    [ "f" ] = JSON.ParseLiteral,
    [ "n" ] = JSON.ParseLiteral,
    [ "[" ] = JSON.ParseArray,
    [ "{" ] = JSON.ParseObject,
}

JSON.escapeCharMap = {
    [ "\\" ] = "\\",
    [ "\"" ] = "\"",
    [ "\b" ] = "b",
    [ "\f" ] = "f",
    [ "\n" ] = "n",
    [ "\r" ] = "r",
    [ "\t" ] = "t",
}

JSON.loadedPercent = 0

JSON.escapeCharMapInv = { [ "/" ] = "/" }

JSON.spaceChars = create_set(" ", "\t", "\r", "\n")
JSON.delimChars = create_set(" ", "\t", "\r", "\n", "]", "}", ",")
JSON.escapeChars = create_set("\\", "/", '"', "b", "f", "n", "r", "t", "u")
JSON.literals = create_set("true", "false", "null", "NaN")
JSON.literalMap = {
    [ "true"  ] = true,
    [ "false" ] = false,
    [ "null"  ] = nil,
    [  "NaN"  ] = nil
}

function JSON:NextChar(str, idx, set, negate)
    --self.tools:Print(idx)
    for i = idx, #str do
        if set[str:sub(i, i)] ~= negate then
            return i
        end
    end
    return #str + 1
end

function JSON:DecodeError(str, idx, msg)
    local line_count = 1
    local col_count = 1
    for i = 1, idx - 1 do
        col_count = col_count + 1
        if str:sub(i, i) == "\n" then
            line_count = line_count + 1
            col_count = 1
        end
    end
    error(string.format("%s at line %d col %d", msg, line_count, col_count))
end

function JSON:CodepointToUTF8(n)
    local f = math.floor
    if n <= 0x7f then
        return string.char(n)
    elseif n <= 0x7ff then
        return string.char(f(n / 64) + 192, n % 64 + 128)
    elseif n <= 0xffff then
        return string.char(f(n / 4096) + 224, f(n % 4096 / 64) + 128, n % 64 + 128)
    elseif n <= 0x10ffff then
        return string.char(f(n / 262144) + 240, f(n % 262144 / 4096) + 128, f(n % 4096 / 64) + 128, n % 64 + 128)
    end
    error(string.format("invalid unicode codepoint '%x'", n))
end

function JSON:ParseUnicodeEscape(s)
    local n1 = tonumber(s:sub(1, 4),  16)
    local n2 = tonumber(s:sub(7, 10), 16)
    -- Surrogate pair?
    if n2 then
        return self:CodepointToUTF8((n1 - 0xd800) * 0x400 + (n2 - 0xdc00) + 0x10000)
    else
        return self:CodepointToUTF8(n1)
    end
end

function JSON:ParseString(str, i)
    local res = ""
    local j = i + 1
    local k = j

    while j <= #str do
        local x = str:byte(j)

        if x < 32 then
            self:DecodeError(str, j, "control character in string")
        elseif x == 92 then -- `\`: Escape
            res = res .. str:sub(k, j - 1)
            j = j + 1
            local c = str:sub(j, j)
            if c == "u" then
                local hex = str:match("^[dD][89aAbB]%x%x\\u%x%x%x%x", j + 1)
                    or str:match("^%x%x%x%x", j + 1)
                    or self:DecodeError(str, j - 1, "invalid unicode escape in string")
                res = res .. self:ParseUnicodeEscape(hex)
                j = j + #hex
            else
                if not self.escapeChars[c] then
                    self:DecodeError(str, j - 1, "invalid escape char '" .. c .. "' in string")
                end
                res = res .. self.escapeCharMapInv[c]
            end
            k = j + 1
        elseif x == 34 then -- `"`: End of string
            res = res .. str:sub(k, j - 1)
            return res, j + 1
        end

        j = j + 1
    end

    self:DecodeError(str, i, "expected closing quote for string")
end

function JSON:ParseNumber(str, i)
    local x = self:NextChar(str, i, self.delimChars)
    local s = str:sub(i, x - 1)
    local n = tonumber(s)
    if not n then
        self:DecodeError(str, i, "invalid number '" .. s .. "'")
    end
    return n, x
end

function JSON:ParseLiteral(str, i)
    local x = self:NextChar(str, i, self.delimChars)
    local word = str:sub(i, x - 1)
    if word == "NaN" then
        x = x + 1
    end
    --self.tools:Print(word)
    if not self.literals[word] then
        self:DecodeError(str, i, "invalid literal '" .. word .. "'")
    end
    return self.literalMap[word], x
end

function JSON:ParseArray(str, i)
    --self.tools:Print("ici")
    local res = {}
    local n = 1
    i = i + 1
    while 1 do
        local x
        i = self:NextChar(str, i, self.spaceChars, true)
        -- Empty / end of array?
        if str:sub(i, i) == "]" then
            i = i + 1
            break
        end
        -- Read token
        x, i = self:Parse(str, i)
        res[n] = x
        n = n + 1
        -- Next token
        i = self:NextChar(str, i, self.spaceChars, true)
        local chr = str:sub(i, i)
        i = i + 1
        if chr == "]" then break end
        if chr ~= "," then self:DecodeError(str, i, "expected ']' or ','") end
    end
    return res, i
end

function JSON:ParseObject(str, i)
    local res = {}
    i = i + 1
    while 1 do
        local key, val
        i = self:NextChar(str, i, self.spaceChars, true)
        -- Empty / end of object?
        if str:sub(i, i) == "}" then
            i = i + 1
            break
        end
        -- Read key
        if str:sub(i, i) ~= '"' then
            self:DecodeError(str, i, "expected string for key")
        end
        key, i = self:Parse(str, i)
        -- Read ':' delimiter
        i = self:NextChar(str, i, self.spaceChars, true)
        if str:sub(i, i) ~= ":" then
            self:DecodeError(str, i, "expected ':' after key")
        end
        i = self:NextChar(str, i + 1, self.spaceChars, true)
        -- Read value
        val, i = self:Parse(str, i)
        -- Set
        res[key] = val
        -- Next token
        i = self:NextChar(str, i, self.spaceChars, true)
        local chr = str:sub(i, i)
        i = i + 1
        if chr == "}" then break end
        if chr ~= "," then self:DecodeError(str, i, "expected '}' or ','") end
    end
    return res, i
end

function JSON:Parse(str, idx)
    if self.printInfo then
        local currentPercent =  math.ceil((idx / #str) * 100)
        if currentPercent >= self.loadedPercent + 5 then
            self.loadedPercent = currentPercent
            self.tools:Print(self.loadedPercent .. "% chargé", self.header)
        end
    end
    local chr = str:sub(idx, idx)
    --self.tools:Print(chr)
    if chr == '"' then
        --self.tools:Print("String")
        return self:ParseString(str, idx)
    elseif chr == "0" or
           chr == "1" or
           chr == "2" or
           chr == "3" or
           chr == "4" or
           chr == "5" or
           chr == "6" or
           chr == "7" or
           chr == "8" or
           chr == "9" or
           chr == "-" then
        --self.tools:Print("Number")
        return self:ParseNumber(str, idx)
    elseif chr == "t" or
           chr == "f" or
           chr == "n" or
           chr == "N" then
        --self.tools:Print("Literal")
        return self:ParseLiteral(str, idx)
    elseif chr == "[" then
        --self.tools:Print("Array")
        return self:ParseArray(str, idx)
    elseif chr == "{" then
        --self.tools:Print("Object")
        return self:ParseObject(str, idx)
    end
    return nil
end

function JSON:decode(str, header)
    if header then
        self.header = header
        self.loadedPercent = 0  
        self.printInfo = true  
    end
    if str == nil or type(str) ~= "string" then
        return nil
    end
    local res, idx = self:Parse(str, self:NextChar(str, 1, self.spaceChars, true))

    if res == nil or idx == nil then
        return nil
    end
    idx = self:NextChar(str, idx, self.spaceChars, true)
    if idx <= #str then
        self:DecodeError(str, idx, "trailing garbage")
    end
    return res
end

-- Encode

function JSON:EscapeChar(c)
    return "\\" .. (self.escapeCharMap[c] or string.format("u%04x", c:byte()))
end

function JSON:EncodeNil(val)
    return "null"
end

function JSON:EncodeTable(val, stack)
    local res = {}
    stack = stack or {}

    -- Circular reference?
    if stack[val] then error("circular reference") end

    stack[val] = true

    if rawget(val, 1) ~= nil or next(val) == nil then
        -- Treat as array -- check keys are valid and it is not sparse
        local n = 0
        for k in pairs(val) do
            if type(k) ~= "number" then
            error("invalid table: mixed or invalid key types")
            end
            n = n + 1
        end
        if n ~= #val then
            error("invalid table: sparse array")
        end
        -- Encode
        for i, v in ipairs(val) do
            table.insert(res, self:EncodeProcess(v, stack))
        end
        stack[val] = nil
        return "[" .. table.concat(res, ",") .. "]"
    else
        -- Treat as an object
        for k, v in pairs(val) do
            if type(k) ~= "string" then
            error("invalid table: mixed or invalid key types")
            end
            table.insert(res, self:EncodeProcess(k, stack) .. ":" .. self:EncodeProcess(v, stack))
        end
        stack[val] = nil
        return "{" .. table.concat(res, ",") .. "}"
    end

end

function JSON:EncodeString(val)
    return '"' .. val:gsub('[%z\1-\31\\"]', self.escapeChars) .. '"'
end

function JSON:EncodeNumber(val)
    if val ~= val or val <= -math.huge or val >= math.huge then
        error("unexpected number value '" .. tostring(val) .. "'")
    end
    return string.format("%.14g", val)
end

function JSON:EncodeProcess(val, stack)
    if type(val) == "boolean" then
        return tostring(val)
    elseif type(val) == "nil" then
        return self:EncodeNil(val)
    elseif type(val) =="number" then
        return self:EncodeNumber(val)
    elseif type(val) == "string" then
        return self:EncodeString(val)
    elseif type(val) == "table" then
        return self:EncodeTable(val, stack)
    end
    error("unexpected type '" .. type(val) .. "'")
end

function JSON:encode(val)
    return ( self:EncodeProcess(val) )
end

return JSON