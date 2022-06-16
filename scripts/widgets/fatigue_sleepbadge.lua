local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"

local Fatigue_sleepBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "health", owner)
	
	self.anim:GetAnimState():SetBuild("fatigue")
	
	self.fatigue_sleeparrow = self.underNumber:AddChild(UIAnim())
    self.fatigue_sleeparrow:GetAnimState():SetBank("sanity_arrow")
    self.fatigue_sleeparrow:GetAnimState():SetBuild("sanity_arrow")
    self.fatigue_sleeparrow:GetAnimState():PlayAnimation("neutral")
    self.fatigue_sleeparrow:SetClickable(false)
	
	local fatigue_arrow_pos = self.fatigue_sleeparrow:GetPosition()
	self.fatigue_sleeparrow:SetPosition(fatigue_arrow_pos.x + 11, fatigue_arrow_pos.y, fatigue_arrow_pos.z)
		
	self.owner = owner

	owner.fatigue_sleeparrow = self.fatigue_sleeparrow
   
    self:StartUpdating()
end)


local _oldSetPercent = Fatigue_sleepBadge.SetPercent

function Fatigue_sleepBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)

   -- penaltypercent = penaltypercent or 0
    --self.anim:GetAnimState():SetPercent("anim", penaltypercent)
end

function Fatigue_sleepBadge:OnUpdate(dt)
	--[[
	local down = self.inst.components.sanity and self.inst.components.sanity:GetPercent() < .25 and self.owner.components.fatigue_sleep ~= nil and self.owner.components.fatigue_sleep:GetPercent() >0
	
	local up = not down and
        (self.owner:HasTag("sleeping") or self.owner.fatigue_sleep_regen or self.owner.sleep_on)
		and self.owner.components.fatigue_sleep ~= nil and self.owner.components.fatigue_sleep:GetPercent() <100
 
    local anim =
        (down and "arrow_loop_decrease_most") or
        (not up and "neutral") or
        (next(self.hots) ~= nil and "arrow_loop_increase_most") or
        "arrow_loop_increase"

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.fatigue_sleeparrow:GetAnimState():PlayAnimation(anim, true)
    end
	]]
	
	
	local down = self.owner ~= nil and
        (self.owner:HasTag("sleeping") or self.owner.sleep_on or self.owner.tiny_sleep or self.owner.lightaura) 

	local anim = down and "arrow_loop_decrease" or "neutral"
	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.fatigue_sleeparrow:GetAnimState():PlayAnimation(anim, true)
	end
	
end

return Fatigue_sleepBadge