local yayaToolsModuleDirectory = global:getCurrentDirectory() .. [[\YayaTools\Module\]]
Class = dofile(yayaToolsModuleDirectory .. "Class.lua")

SlotDataHolderManager = Class("SlotDataHolderManager")

function SlotDataHolderManager:init(linkedSlotData)
    self._weakHolderReference = {}
    self._linkedSlotsData = {}
    table.insert(self._linkedSlotsData, linkedSlotData)
end

function SlotDataHolderManager:setLinkedSlotData(slotData)
    if not self._linkedSlotsData then
        self._linkedSlotsData = {}
    end
    if not table.contains(self._linkedSlotsData, slotData) then
        table.insert(self._linkedSlotsData, slotData)
    end
end

function SlotDataHolderManager:addHolder(h)
    self._weakHolderReference[h] = true
end

function SlotDataHolderManager:removeHolder(h)
    self._weakHolderReference[h] = nil
end

function SlotDataHolderManager:getHolders()
    local result = {}
    for h, _ in pairs(self._weakHolderReference) do
        table.insert(result, h)
    end
    return result
end

function SlotDataHolderManager:refreshAll()
    for h, _ in pairs(self._weakHolderReference) do
        for _, linkedSlotData in ipairs(self._linkedSlotsData) do
            if h and h.data == linkedSlotData then
                h:refresh()
            end
        end
    end
end

-- Helper function to check if a table contains a value
function table.contains(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then
            return true
        end
    end
    return false
end

return SlotDataHolderManager