Utils = {}

Utils.cellAray = {}

Utils.colorPrint = {
    ["Info"] = "#00fc4c",
    ["Error"] = "#fc0000",
    ["Packet"] = "#45e9f5",
    ["Dialog"] = "#fc9905",
    ["Monsters"] = "#fc0599",
    ["Zone"] = "#fccf05",
    ["Area"] = "#fccf05",
    ["SubArea"] = "#fccf05",
    ["Dungeons"] = "#dffc05",
    ["Notification"] = "#0b0429",
    ["Json"] = "#077869",
    ["Movement"] = "#00fc4c",
}

-- Print, Divers

function Utils:Print(msg, header, color)
    local prefabStr = ""

    if color == nil then
        color = self:ColorPicker(header)
    end

    msg = tostring(msg)

    if header ~= nil then
        prefabStr = "["..string.upper(header).."] "..msg
    else
        prefabStr = msg
    end

    if color == nil then
        global:printSuccess(prefabStr)
    else
        global:printColor(color, prefabStr)
    end
end

function Utils:ColorPicker(header)
    if header ~= nil then
        return self.colorPrint:Get(string.lower(header)) or nil
    end
    return nil
end

function Utils:GenerateDateTime(format)
    local dateTimeTable = os.date('*t')
    local ret

    if format == "h" then
        ret = dateTimeTable.hour
    elseif format == "m" then
        ret = dateTimeTable.min
    elseif format == "s" then
        ret = dateTimeTable.sec
    elseif format == "hm" then
        ret = { hour = dateTimeTable.hour, min = dateTimeTable.min }
    elseif format == "ms" then
        ret = { min = dateTimeTable.min, sec = dateTimeTable.sec }
    elseif format == "hms" then
        ret = { hour = dateTimeTable.hour, min = dateTimeTable.min, sec = dateTimeTable.sec }
    end

    if ret == nil then 
        Utils:Print("Erreur format", "GenerateDateTime", "error")
    else
        return ret
    end
end

function Utils:Wait(bool, maxDelay)
    local i = 0
    while bool do
        if maxDelay then
            global:delay(maxDelay / 4)
            if i == 4 then
                return false
            end
            i = i + 1
        else
            global:delay(50)
        end
    end
    return true
end

-- IO, CMD

function Utils:ExecuteWinCMD(cmd, onlyCmd)
    if onlyCmd then
        os.execute(cmd)
    else
        os.execute(cmd .. " %ComSpec% /D /E:ON /K")
    end
end

function Utils:ReadFile(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

function Utils:ReadFileLine(file)
    if not self:FileExists(file) then return {} end
    local lines = self.list()
    for line in io.lines(file) do
        lines:Add(line)
    end
    return lines
end


function Utils:WriteFile(path, content)
    local file = io.open(path, "w+") -- r read mode and b binary mode
    file:write(content)
    file:close()
end

function Utils:FileExists(path)
    local f = io.open(path, "rb")
    if f then f:close() end
    return f ~= nil
end

-- Distance cellule dofus

function Utils:InitCellsArray()
    local startX = 0
    local startY = 0
    local cell = 0
    local axeX = 0
    local axeY = 0

    while (axeX < 20) do
        axeY = 0

        while (axeY < 14) do
            self.cellAray[cell] = {x = startX + axeY, y = startY + axeY}
            cell = cell + 1
            axeY = axeY + 1
        end

        startX = startX + 1
        axeY = 0

        while (axeY < 14) do
            self.cellAray[cell] = {x = startX + axeY, y = startY + axeY}
            cell = cell + 1
            axeY = axeY + 1
        end

        startY = startY - 1
        axeX = axeX + 1
    end
end

function Utils:CellIdToCoord(cellId)
    if Utils:IsCellIdValid(cellId) then
        return self.cellAray[cellId]
    end

    return nil
end

function Utils:CoordToCellId(coord)
	return math.floor((((coord.x - coord.y) * 14) + coord.y) + ((coord.x - coord.y) / 2))
end

function Utils:IsCellIdValid(cellId)
	return (cellId >= 0 and cellId < 560)
end

function Utils:ManhattanDistanceCellId(fromCellId, toCellId)
	local fromCoord = Utils:CellIdToCoord(fromCellId)
	local toCoord = Utils:CellIdToCoord(toCellId)
	if fromCoord ~= nil and toCoord ~= nil then
		return (math.abs(toCoord.x - fromCoord.x) + math.abs(toCoord.y - fromCoord.y))
	end
	return nil
end

function Utils:ManhattanDistanceCoord(fromCoord, toCoord)
	return (math.abs(toCoord.x - fromCoord.x) + math.abs(toCoord.y - fromCoord.y))
end

-- Array

function Utils:ArrayConcat(...)
    local arg = {...}
    local ret = arg[1]

    for i = 2, #arg do
        for k,v in pairs(arg[i]) do
            ret[k] = v
        end
    end
    return ret
end

function Utils:Dump(tbl, printDelay)
    local str = "Root"
    printDelay = printDelay or 0

    local function dmp(t, l, k, rep, init)
        global:delay(printDelay)
        if type(t) == "table" then
            self:Print(string.format("% s% s:", string.rep(rep, l * 3), tostring (k)))
            for key, v in pairs(t) do
                if key ~= "c" then
                    if self.class.isClass(v) or self.class.isInstance(v) then
                        key = key .. " : " .. tostring(v)
                    end
                    dmp(v, l + 1, key, " ")
                end
            end
        else
            if self.class.isClass(t) or self.class.isInstance(t) then
                k = k .. " : " ..  tostring(t)
            end
            self:Print(string.format("% s% s:% s", string.rep(rep, l * 3), tostring(k), tostring(t)))
        end
    end

    if self.class.isClass(tbl) or self.class.isInstance(tbl) then
        str = str .. " : " .. tostring(tbl)
    end

    dmp(tbl, 1, str, "", true)
end

function Utils:GetTableValue(index, tbl)
    local i = 1
    for _, v in pairs(tbl) do
        if index == i then
            return v
        end
        i = i + 1
    end
end

function Utils:LenghtOfTable(tbl)
    if tbl ~= nil then
        local ret = 0

        for _, _ in pairs(tbl) do
            ret = ret + 1
        end

        return ret
    else
        return 0
    end
end

function Utils:ExistKeyTable(t, key)
    for k, _ in pairs(t) do
        if self:Equal(k, key) then
            return true
        end
    end
    return false
end

function Utils:SortArray(array, fn)
    local numArray = array
    for i = 1, #numArray do
        local min = i
        for j = i + 1, #numArray do
            if (fn(numArray[j], numArray[min])) then
                min = j
            end
        end
        if (min ~= i) then
            local target = numArray[i]
            numArray[i] = numArray[min]
            numArray[min] = target
        end
    end
    return numArray
end

function Utils:ShuffleTbl(tbl)
    local ret = tbl

    for i = #ret, 1, -1 do
        local j = global:random(1, i)
        ret[i], ret[j] = ret[j], ret[i]
    end

    return ret
end

-- Time

function Utils:ConvertMinuteToHour(minuteToConvert)
    local hour = math.floor(minuteToConvert / 60)
    local minute = ( minuteToConvert / 60 - math.floor(minuteToConvert / 60) ) * 60
    return hour, minute
end

-- String

function Utils:Equal(str1, str2)
    if str1 == nil then
        str1 = ""
    end
    if str2 == nil then
        str2 = ""
    end
    return string.lower(tostring(str1)) == string.lower(tostring(str2))
end

return Utils