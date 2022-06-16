local function Fatigue_sleep_statusdisplays(self)
	if self.owner:HasTag("musha") then
		local Fatigue_sleepBadge = GLOBAL.require "widgets/fatigue_sleepbadge"
		self.fatigue_sleep = self:AddChild(Fatigue_sleepBadge(self.owner))
		self.owner.fatigue_sleepbadge = self.fatigue_sleep
		self._custombadge = self.fatigue_sleep 
		
		local AlwaysOnStatus = false
		for k,v in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do 
			local Mod = GLOBAL.KnownModIndex:GetModInfo(v).name
			if Mod == "Combined Status" then 
				AlwaysOnStatus = true
			end
		end
		if AlwaysOnStatus and not self.owner:HasTag("bearded") then
			self.fatigue_sleep:SetPosition(-115, -15, 0)
		elseif AlwaysOnStatus and self.owner:HasTag("bearded") then
			self.fatigue_sleep:SetPosition(-165, 19, 0)	
		elseif not AlwaysOnStatus and self.owner:HasTag("bearded") then	
			self.fatigue_sleep:SetPosition(-165,19,0)
		end
		
		if not AlwaysOnStatus and not self.owner:HasTag("bearded") then	
	    	self.fatigue_sleep:SetPosition(-100,-15,0)
		end

		local function OnSetPlayerMode(self)
			if self.onfatigue_sleepdelta == nil then
				self.onfatigue_sleepdelta = function(owner, data) self:Fatigue_sleepDelta(data) end
				self.inst:ListenForEvent("fatigue_sleepdelta", self.onfatigue_sleepdelta, self.owner)
				if self.owner.components.fatigue_sleep ~= nil then
					self:SetFatigue_sleepPercent(self.owner.components.fatigue_sleep:GetPercent())
				end
			end
		end

		
		function self:SetFatigue_sleepPercent(pct)
			if self.owner.components.fatigue_sleep ~= nil then
				self.fatigue_sleep:SetPercent(pct, self.owner.components.fatigue_sleep.max)
			end
		end

		function self:Fatigue_sleepDelta(data)
			self:SetFatigue_sleepPercent(data.newpercent)
		end

		OnSetPlayerMode(self)
	end
end
AddClassPostConstruct("widgets/statusdisplays", Fatigue_sleep_statusdisplays)