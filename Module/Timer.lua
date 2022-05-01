Timer = {}

Timer.startAt = 0
Timer.timeToWait = 0

function Timer:IsFinish()
    if os.difftime(os.time(), self.startAt) >= self.timeToWait then
        return true
    end
    return false
end

return Timer