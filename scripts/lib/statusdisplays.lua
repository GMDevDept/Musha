local function ManaBadgeDisplay(self)
	if self.owner:HasTag("musha") then
		local ManaBadge = require "widgets/manabadge"

		self.manabadge = self:AddChild(ManaBadge(self.owner))
		self.owner.manabadge = self.manabadge
		self._custombadge = self.manabadge 

		local badge_boatmeter = self.boatmeter:GetPosition()
		local badge_brain = self.brain:GetPosition()
		local AlwaysOnStatus = false

		for k,v in ipairs(KnownModIndex:GetModsToLoad()) do 
			local Mod = KnownModIndex:GetModInfo(v).name
			if Mod == "Combined Status" then 
				AlwaysOnStatus = true
			end
		end

		if AlwaysOnStatus then
			self.manabadge:SetPosition(-120, 70, 0)
		else
	    	self.manabadge:SetPosition(-40,-50,0)
		    self.brain:SetPosition(badge_brain.x + 40, badge_brain.y - 10, 0)
			self.boatmeter:SetPosition(badge_boatmeter.x - 90, badge_boatmeter.y + 21, 0)
		end

        self.manabadge:SetPercent(0.5, self.owner.components.mana.max)

		-- function self:ManaDelta(data)
		-- 	self:SetManaPercent(data.newpercent)
		-- end

		-- function self:SetManaPercent(pct)
		-- 	if self.owner.components.mana ~= nil then
		-- 		self.manabadge:SetPercent(pct, self.owner.components.mana.max)
		-- 	end
		-- end

		-- local function OnSetPlayerMode(self)
		-- 	if self.onmanadelta == nil then
		-- 		self.onmanadelta = function(owner, data) self:ManaDelta(data) end
		-- 		self.inst:ListenForEvent("manadelta", self.onmanadelta, self.owner)
		-- 		if self.owner.components.mana ~= nil then
		-- 			self:SetManaPercent(self.owner.components.mana:GetPercent())
		-- 		end
		-- 	end
		-- end

		-- OnSetPlayerMode(self)
	end
end

AddClassPostConstruct("widgets/statusdisplays", ManaBadgeDisplay)