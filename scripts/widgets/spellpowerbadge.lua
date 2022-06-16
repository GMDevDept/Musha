local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"

local SpellpowerBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "health", owner)
	
	self.anim:GetAnimState():SetBuild("spellpower")
	
	self.spellpowerarrow = self.underNumber:AddChild(UIAnim())
    self.spellpowerarrow:GetAnimState():SetBank("sanity_arrow")
    self.spellpowerarrow:GetAnimState():SetBuild("sanity_arrow")
    self.spellpowerarrow:GetAnimState():PlayAnimation("neutral")
    self.spellpowerarrow:SetClickable(false)

	self.owner = owner

	owner.spellpowerarrow = self.spellpowerarrow
   
    self:StartUpdating()
end)


local _oldSetPercent = SpellpowerBadge.SetPercent

function SpellpowerBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)

   -- penaltypercent = penaltypercent or 0
    --self.anim:GetAnimState():SetPercent("anim", penaltypercent)
end

function SpellpowerBadge:OnUpdate(dt)
	--[[
	local down = self.inst.components.sanity and self.inst.components.sanity:GetPercent() < .25 and self.owner.components.spellpower ~= nil and self.owner.components.spellpower:GetPercent() >0
	
	local up = not down and
        (self.owner:HasTag("sleeping") or self.owner.spellpower_regen or self.owner.sleep_on)
		and self.owner.components.spellpower ~= nil and self.owner.components.spellpower:GetPercent() <100
 
    local anim =
        (down and "arrow_loop_decrease_most") or
        (not up and "neutral") or
        (next(self.hots) ~= nil and "arrow_loop_increase_most") or
        "arrow_loop_increase"

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.spellpowerarrow:GetAnimState():PlayAnimation(anim, true)
    end
	]]
	
	
	local up = self.owner ~= nil and
        (self.owner:HasTag("sleeping") or self.owner.sleep_on or self.owner.tiny_sleep or self.owner.active_valkyrie) 

	local anim = up and "arrow_loop_increase" or "neutral"
	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.spellpowerarrow:GetAnimState():PlayAnimation(anim, true)
	end
	
end

return SpellpowerBadge