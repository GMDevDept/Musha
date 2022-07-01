local function ManaBadgeDisplay(self)
	if self.owner:HasTag("musha") then
		local ManaBadge = require "widgets/manabadge"

		self.manabadge = self:AddChild(ManaBadge(self.owner))
		self.owner.manabadge = self.manabadge
		self._custombadge = self.manabadge 
        self.onmanadelta = nil

		local badge_boatmeter = self.boatmeter:GetPosition()
		local badge_brain = self.brain:GetPosition()
		local AlwaysOnStatus = false

        local isghost =
        (self.inst.player_classified ~= nil and self.inst.player_classified.isghostmode:value()) or
        (self.inst.player_classified == nil and self.inst:HasTag("playerghost"))

		for k,v in ipairs(KnownModIndex:GetModsToLoad()) do 
			local Mod = KnownModIndex:GetModInfo(v).name
			if Mod == "Combined Status" then 
				AlwaysOnStatus = true
                break
			end
		end

		if AlwaysOnStatus then
			self.manabadge:SetPosition(-120, 70, 0)
		else
	    	self.manabadge:SetPosition(-40,-50,0)
		    self.brain:SetPosition(badge_brain.x + 40, badge_brain.y - 10, 0)
			self.boatmeter:SetPosition(badge_boatmeter.x - 90, badge_boatmeter.y + 21, 0)
		end

        function self:SetManaPercent(pct)
            if self.owner.components.mana ~= nil then
                self.manabadge:SetPercent(pct, self.owner.replica.mana:Max())
            
                if pct <= 0 then
                    self.manabadge:StartWarning()
                else
                    self.manabadge:StopWarning()
                end
            end
        end
        
        function self:ManaDelta(data)
            self:SetManaPercent(data.newpercent)
        end

        local function OnSetPlayerMode(inst, self)
            self.modetask = nil

            if self.onmanadelta == nil then
                self.onmanadelta = function(owner, data) self:ManaDelta(data) end
                self.inst:ListenForEvent("manadelta", self.onmanadelta, self.owner)
                self:SetManaPercent(self.owner.replica.mana:GetPercent())
            end
        end

        local function OnSetGhostMode(inst, self)
            self.modetask = nil
        
            if self.onmanadelta ~= nil then
                self.inst:RemoveEventCallback("manadelta", self.onmanadelta, self.owner)
                self.onmanadelta = nil
            end        
        end

        local _SetGhostMode = self.SetGhostMode
        function self:SetGhostMode(ghostmode)
            if not self.isghostmode == not ghostmode then
                return
            elseif ghostmode then
                self.manabadge:Hide()
                self.manabadge:StopWarning()
            else
                self.manabadge:Show()
            end

            self.inst:DoStaticTaskInTime(0, ghostmode and OnSetGhostMode or OnSetPlayerMode, self)

            return _SetGhostMode(self, ghostmode)
        end

        self.inst:DoStaticTaskInTime(0, isghost and OnSetGhostMode or OnSetPlayerMode, self)
	end
end

AddClassPostConstruct("widgets/statusdisplays", ManaBadgeDisplay)