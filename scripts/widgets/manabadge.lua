local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local ManaBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "health", owner)

    self.anim:GetAnimState():SetBuild("mana")

    self.manaarrow = self.underNumber:AddChild(UIAnim())
    self.manaarrow:GetAnimState():SetBank("sanity_arrow")
    self.manaarrow:GetAnimState():SetBuild("sanity_arrow")
    self.manaarrow:GetAnimState():PlayAnimation("neutral")
    self.manaarrow:SetClickable(false)
    self.manaarrow:GetAnimState():AnimateWhilePaused(false)

    self:StartUpdating()
end)

function ManaBadge:SetPercent(val, max)
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

function ManaBadge:OnUpdate(dt)
    if TheNet:IsServerPaused() then return end

    local mana = self.owner.replica.mana
    local anim = "neutral"

    if mana ~= nil then
        local ratelevel = mana:GetRateLevel()
        if ratelevel ~= 0 then
            if (ratelevel <= 3 and mana:GetPercent() ~= 1) or (ratelevel >= 4 and mana:GetPercent() ~= 0) then
                anim = RATE_SCALE_ANIM[ratelevel]
            end
        end
    end

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.manaarrow:GetAnimState():PlayAnimation(anim, true)
    end
end

return ManaBadge
