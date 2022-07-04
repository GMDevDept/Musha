local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"

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
    self.staminaarrow:SetPosition(stamina_arrow_pos.x + 11, stamina_arrow_pos.y, stamina_arrow_pos.z)

    self:StartUpdating()
end)

function StaminaBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
end

function StaminaBadge:OnUpdate(dt)
    if TheNet:IsServerPaused() then return end

    local anim = "neutral"
    if self.owner ~= nil and
        self.owner.replica.stamina ~= nil then

        local defaultrate = TUNING.MUSHA.staminarate
        local currentrate = self.owner.replica.stamina:GetCurrentRate()
        if currentrate > defaultrate then
            anim = "arrow_loop_increase"
        elseif currentrate < defaultrate and currentrate < 0 then
            anim = "arrow_loop_decrease"
        end
    end

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.staminaarrow:GetAnimState():PlayAnimation(anim, true)
    end

end

return StaminaBadge
