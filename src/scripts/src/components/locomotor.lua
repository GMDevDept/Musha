local function ClassPostConstructFn(self)
    local _RecalculateExternalSpeedMultiplier = self.RecalculateExternalSpeedMultiplier
    function self:RecalculateExternalSpeedMultiplier(...)
        local m = _RecalculateExternalSpeedMultiplier(self, ...)
        if self.inst:HasTag("musha") then
            self.inst.updaterunninganim:push()
        end
        return m
    end
end

AddClassPostConstruct("components/locomotor", ClassPostConstructFn)
