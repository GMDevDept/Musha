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

function ManaBadge:OnUpdate(dt)
    if TheNet:IsServerPaused() then return end

    local anim = "neutral"
    if self.owner ~= nil and
        self.owner.replica.mana ~= nil then

        local defaultrate = TUNING.musha.manaregenspeed
        local currentrate = self.owner.replica.mana:GetCurrentRate()
        if currentrate > defaultrate then
            anim = "arrow_loop_increase"
        elseif currentrate < defaultrate and currentrate < 0 then
            anim = "arrow_loop_decrease"
        end
    end

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.manaarrow:GetAnimState():PlayAnimation(anim, true)
    end
end

return ManaBadge
