local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"

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

function FatigueBadge:OnUpdate(dt)
    if TheNet:IsServerPaused() then return end

    local anim = "neutral"
    if self.owner ~= nil and
        self.owner.replica.fatigue ~= nil then

        local defaultrate = TUNING.musha.fatiguerate
        local currentrate = self.owner.replica.fatigue:GetCurrentRate()
        if currentrate > defaultrate then
            anim = "arrow_loop_increase"
        elseif currentrate < defaultrate and currentrate < 0 then
            anim = "arrow_loop_decrease"
        end
    end

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.fatiguearrow:GetAnimState():PlayAnimation(anim, true)
    end

end

return FatigueBadge
