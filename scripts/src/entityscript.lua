local function ClassPostConstructFn(self)
    local _DoPeriodicTask = self.DoPeriodicTask
    function self:CustomDoPeriodicTask(duration, period, fn, initialdelay, ...)
        local task = _DoPeriodicTask(self, period, fn, initialdelay, ...)
        if duration then
            CustomCancelTask(task, duration)
        end
        return task
    end
end

AddGlobalClassPostConstruct("entityscript", "EntityScript", ClassPostConstructFn)

--------------------------------------------------------------------------
