Timer = {}

Timer.timerHourStart = 0
Timer.timerMinuteStart = 0
Timer.timerRandTimeToWait = 0

function Timer:IsFinish()
    local date = os.date('*t')
    local curH, curM = date.hour, date.min

    if self:DiffTime(self.timerHourStart, self.timerMinuteStart, curH, curM) >= self.timerRandTimeToWait then
        return true
    end
    return false
end

function Timer:DiffTime(hStart, mStart, hFinish, mFinish)
    local diffTimeMin = 0
    local cond = (tonumber(hStart) == tonumber(hFinish)) and (tonumber(mStart) == tonumber(mFinish))
    while not cond do
        cond = (tonumber(hStart) == tonumber(hFinish)) and (tonumber(mStart) == tonumber(mFinish))
        if tonumber(mStart) >= 60 then
            hStart = hStart + 1
            mStart = 0
        end
        if tonumber(hStart) >= 24 then
            hStart = 0
        end
        diffTimeMin = diffTimeMin + 1
        mStart = mStart + 1
        if diffTimeMin > 2880 then -- Debug
            return diffTimeMin
        end
    end
    return diffTimeMin
end

return Timer