local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local FatigueBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "health", owner)

    self.anim:GetAnimState():SetBuild("fatigue")

    self.fatiguearrow = self.underNumber:AddChild(UIAnim())
    self.fatiguearrow:GetAnimState():SetBank("sanity_arrow")
    self.fatiguearrow:GetAnimState():SetBuild("sanity_arrow")
    self.fatiguearrow:GetAnimState():PlayAnimation("neutral")
    self.fatiguearrow:SetClickable(false)
    self.fatiguearrow:GetAnimState():AnimateWhilePaused(false)

    local fatigue_arrow_pos = self.fatiguearrow:GetPosition()
    self.fatiguearrow:SetPosition(fatigue_arrow_pos.x + 11, fatigue_arrow_pos.y, fatigue_arrow_pos.z)

    self:StartUpdating()
end)

function FatigueBadge:SetPercent(val, max)
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

function FatigueBadge:OnUpdate(dt)
    if TheNet:IsServerPaused() then return end

    local fatigue = self.owner.replica.fatigue
    local anim = "neutral"

    if fatigue ~= nil then
        local ratelevel = fatigue:GetRateLevel()
        if ratelevel ~= 0 then
            anim = RATE_SCALE_ANIM[ratelevel]
        end
    end

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.fatiguearrow:GetAnimState():PlayAnimation(anim, true)
    end
end

return FatigueBadge
