local function Stamina_sleep_statusdisplays(self)
	if self.owner:HasTag("musha") then
		local Stamina_sleepBadge = GLOBAL.require "widgets/stamina_sleepbadge"
		self.stamina_sleep = self:AddChild(Stamina_sleepBadge(self.owner))
		self.owner.stamina_sleepbadge = self.stamina_sleep
		self._custombadge = self.stamina_sleep 
		
		local AlwaysOnStatus = false
		for k,v in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do 
			local Mod = GLOBAL.KnownModIndex:GetModInfo(v).name
			if Mod == "Combined Status" then 
				AlwaysOnStatus = true
			end
		end
		if AlwaysOnStatus and not self.owner:HasTag("bearded") then
			self.stamina_sleep:SetPosition(-115, -15, 0)
		elseif AlwaysOnStatus and self.owner:HasTag("bearded") then
			self.stamina_sleep:SetPosition(-165, 19, 0)	
		elseif not AlwaysOnStatus and self.owner:HasTag("bearded") then	
			self.stamina_sleep:SetPosition(-165,19,0)

		else
	    	self.stamina_sleep:SetPosition(-100,-15,0)

		end

		local function OnSetPlayerMode(self)
			if self.onstamina_sleepdelta == nil then
				self.onstamina_sleepdelta = function(owner, data) self:Stamina_sleepDelta(data) end
				self.inst:ListenForEvent("stamina_sleepdelta", self.onstamina_sleepdelta, self.owner)
				if self.owner.components.stamina_sleep ~= nil then
					self:SetStamina_sleepPercent(self.owner.components.stamina_sleep:GetPercent())
				end
			end
		end

		
		function self:SetStamina_sleepPercent(pct)
			if self.owner.components.stamina_sleep ~= nil then
				self.stamina_sleep:SetPercent(pct, self.owner.components.stamina_sleep.max)
			end
		end

		function self:Stamina_sleepDelta(data)
			self:SetStamina_sleepPercent(data.newpercent)
		end

		OnSetPlayerMode(self)
	end
end
AddClassPostConstruct("widgets/statusdisplays", Stamina_sleep_statusdisplays)