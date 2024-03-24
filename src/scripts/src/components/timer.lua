local function ClassPostConstructFn(self)
    function self:CustomStartTimer(name, time, ...)
        if name == "premagpiestep" and self:TimerExists(name) then
                self:SetTimeLeft(name, time)
        else
            return self:StartTimer(name, time, ...)
        end
    end
end

AddClassPostConstruct("components/timer", ClassPostConstructFn)
