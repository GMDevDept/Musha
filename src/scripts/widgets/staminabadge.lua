local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local StaminaBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "health", owner)

    self.anim:GetAnimState():SetBuild("stamina")

    self.staminaarrow = self.underNumber:AddChild(UIAnim())
    self.staminaarrow:GetAnimState():SetBank("sanity_arrow")
    self.staminaarrow:GetAnimState():SetBuild("sanity_arrow")
    self.staminaarrow:GetAnimState():PlayAnimation("neutral")
    self.staminaarrow:SetClickable(false)
    self.staminaarrow:GetAnimState():AnimateWhilePaused(false)

    local stamina_arrow_pos = self.staminaarrow:GetPosition()
    self.staminaarrow:SetPosition(stamina_arrow_pos.x - 11, stamina_arrow_pos.y, stamina_arrow_pos.z)

    self:StartUpdating()
end)

function StaminaBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
end

local RATE_SCALE_ANIM =
{
    [RATE_SCALE.INCREASE_HIGH] = "arrow_loop_increase_most",
    [RATE_SCALE.INCREASE_MED] = "arrow_loop_increase_more",
    [RATE_SCALE.INCREASE_LOW] = "arrow_loop_increase",
    [RATE_SCALE.DECREASE_HIGH] = "arrow_loop_decrease_most",
    [RATE_SCALE.DECREASE_MED] = "arrow_loop_decrease_more",
    [RATE_SCALE.DECREASE_LOW] = "arrow_loop_decrease",
}

function StaminaBadge:OnUpdate(dt)
    if TheNet:IsServerPaused() then return end

    local stamina = self.owner.replica.stamina
    local anim = "neutral"

    if stamina ~= nil then
        local ratelevel = stamina:GetRateLevel()
        if ratelevel ~= 0 then
            if (ratelevel <= 3 and stamina:GetPercent() ~= 1) or (ratelevel >= 4 and stamina:GetPercent() ~= 0) then
                anim = RATE_SCALE_ANIM[ratelevel]
            end
        end
    end

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.staminaarrow:GetAnimState():PlayAnimation(anim, true)
    end
end

return StaminaBadge
