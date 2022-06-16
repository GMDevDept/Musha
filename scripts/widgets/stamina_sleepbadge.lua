local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"

local Stamina_sleepBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "health", owner)
	
	self.anim:GetAnimState():SetBuild("stamina")
	
	self.stamina_sleeparrow = self.underNumber:AddChild(UIAnim())
    self.stamina_sleeparrow:GetAnimState():SetBank("sanity_arrow")
    self.stamina_sleeparrow:GetAnimState():SetBuild("sanity_arrow")
    self.stamina_sleeparrow:GetAnimState():PlayAnimation("neutral")
    self.stamina_sleeparrow:SetClickable(false)

	local stamina_arrow_pos = self.stamina_sleeparrow:GetPosition()
	self.stamina_sleeparrow:SetPosition(stamina_arrow_pos.x - 11, stamina_arrow_pos.y, stamina_arrow_pos.z)
	
	self.owner = owner

	owner.stamina_sleeparrow = self.stamina_sleeparrow
   
    self:StartUpdating()
end)


local _oldSetPercent = Stamina_sleepBadge.SetPercent

function Stamina_sleepBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)

   -- penaltypercent = penaltypercent or 0
    --self.anim:GetAnimState():SetPercent("anim", penaltypercent)
end

function Stamina_sleepBadge:OnUpdate(dt)
	--[[
	local down = self.inst.components.sanity and self.inst.components.sanity:GetPercent() < .25 and self.owner.components.stamina_sleep ~= nil and self.owner.components.stamina_sleep:GetPercent() >0
	
	local up = not down and
        (self.owner:HasTag("sleeping") or self.owner.stamina_sleep_regen or self.owner.sleep_on)
		and self.owner.components.stamina_sleep ~= nil and self.owner.components.stamina_sleep:GetPercent() <100
 
    local anim =
        (down and "arrow_loop_decrease_most") or
        (not up and "neutral") or
        (next(self.hots) ~= nil and "arrow_loop_increase_most") or
        "arrow_loop_increase"

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.stamina_sleeparrow:GetAnimState():PlayAnimation(anim, true)
    end
	]]
	
	
	local up = self.owner ~= nil and
        (self.owner:HasTag("sleeping") or self.owner.sleep_on or self.owner.tiny_sleep or self.owner.lightaura)

	local anim = up and "arrow_loop_increase" or "neutral"
	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.stamina_sleeparrow:GetAnimState():PlayAnimation(anim, true)
	end
	
end

return Stamina_sleepBadge