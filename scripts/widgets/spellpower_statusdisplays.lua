local function Spellpower_statusdisplays(self)
	if self.owner:HasTag("musha") or self.owner:HasTag("spellpower") then
		local SpellpowerBadge = GLOBAL.require "widgets/spellpowerbadge"
		self.spellpower = self:AddChild(SpellpowerBadge(self.owner))
		self.owner.spellpowerbadge = self.spellpower
		self._custombadge = self.spellpower 
		local badge_boatmeter = self.boatmeter:GetPosition()
		local badge_brain = self.brain:GetPosition()
		local AlwaysOnStatus = false
		for k,v in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do 
			local Mod = GLOBAL.KnownModIndex:GetModInfo(v).name
			if Mod == "Combined Status" then 
				AlwaysOnStatus = true
			end
		end
			
		if AlwaysOnStatus then
			--self.spellpower:SetPosition(-60, -54, 0)
			self.spellpower:SetPosition(-120, 70, 0)
		else
	    	self.spellpower:SetPosition(-40,-50,0)
		    self.brain:SetPosition(badge_brain.x + 40, badge_brain.y - 10, 0)
			self.boatmeter:SetPosition(badge_boatmeter.x - 90, badge_boatmeter.y + 21, 0)
			
		end

		local function OnSetPlayerMode(self)
			if self.onspellpowerdelta == nil then
				self.onspellpowerdelta = function(owner, data) self:SpellpowerDelta(data) end
				self.inst:ListenForEvent("spellpowerdelta", self.onspellpowerdelta, self.owner)
				if self.owner.components.spellpower ~= nil then
					self:SetSpellpowerPercent(self.owner.components.spellpower:GetPercent())
				end
			end
		end

		
		function self:SetSpellpowerPercent(pct)
			if self.owner.components.spellpower ~= nil then
				self.spellpower:SetPercent(pct, self.owner.components.spellpower.max)
			end
		end

		function self:SpellpowerDelta(data)
			self:SetSpellpowerPercent(data.newpercent)
		end

		OnSetPlayerMode(self)
	end
end
AddClassPostConstruct("widgets/statusdisplays", Spellpower_statusdisplays)