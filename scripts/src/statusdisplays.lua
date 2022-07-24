-- Mana
local function ManaBadgeDisplay(self)
    if self.owner:HasTag("musha") then
        local ManaBadge = require "widgets/manabadge"

        self.manabadge = self:AddChild(ManaBadge(self.owner))
        self.owner.manabadge = self.manabadge
        self._custombadge = self.manabadge
        self.onmanadelta = nil

        local isghost =
        (self.inst.player_classified ~= nil and self.inst.player_classified.isghostmode:value()) or
            (self.inst.player_classified == nil and self.inst:HasTag("playerghost"))

        local badge_boatmeter = self.boatmeter:GetPosition()
        local badge_brain = self.brain:GetPosition()
        local AlwaysOnStatus = nil
        for k, v in ipairs(KnownModIndex:GetModsToLoad()) do
            local Mod = KnownModIndex:GetModInfo(v).name
            if Mod == "Combined Status" then
                AlwaysOnStatus = true
                break
            end
        end

        if AlwaysOnStatus then
            self.manabadge:SetPosition(-120, 70, 0)
        else
            self.manabadge:SetPosition(-40, -50, 0)
            self.brain:SetPosition(badge_brain.x + 40, badge_brain.y - 10, 0)
            self.boatmeter:SetPosition(badge_boatmeter.x - 90, badge_boatmeter.y + 21, 0)
        end

        function self:SetManaPercent(pct)
            self.manabadge:SetPercent(pct, self.owner.replica.mana:Max())

            if pct <= 0 then
                self.manabadge:StartWarning()
            else
                self.manabadge:StopWarning()
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

--------------------------------------------------------------------------

-- Fatigue
local function FatigueBadgeDisplay(self)
    if self.owner:HasTag("musha") then
        local FatigueBadge = require "widgets/fatiguebadge"

        self.fatiguebadge = self:AddChild(FatigueBadge(self.owner))
        self.owner.fatiguebadge = self.fatiguebadge
        self._custombadge = self.fatiguebadge
        self.onfatiguedelta = nil

        local isghost =
        (self.inst.player_classified ~= nil and self.inst.player_classified.isghostmode:value()) or
            (self.inst.player_classified == nil and self.inst:HasTag("playerghost"))

        local AlwaysOnStatus = nil
        for k, v in ipairs(KnownModIndex:GetModsToLoad()) do
            local Mod = KnownModIndex:GetModInfo(v).name
            if Mod == "Combined Status" then
                AlwaysOnStatus = true
                break
            end
        end

        if AlwaysOnStatus then
            self.fatiguebadge:SetPosition(-120, -15, 0)
        else
            self.fatiguebadge:SetPosition(-100, -15, 0)
        end

        function self:SetFatiguePercent(pct)
            self.fatiguebadge:SetPercent(pct, self.owner.replica.fatigue:Max())
        end

        function self:FatigueDelta(data)
            self:SetFatiguePercent(data.newpercent)
        end

        local function OnSetPlayerMode(inst, self)
            self.modetask = nil

            if self.onfatiguedelta == nil then
                self.onfatiguedelta = function(owner, data) self:FatigueDelta(data) end
                self.inst:ListenForEvent("fatiguedelta", self.onfatiguedelta, self.owner)
                self:SetFatiguePercent(self.owner.replica.fatigue:GetPercent())
            end
        end

        local function OnSetGhostMode(inst, self)
            self.modetask = nil

            if self.onfatiguedelta ~= nil then
                self.inst:RemoveEventCallback("fatiguedelta", self.onfatiguedelta, self.owner)
                self.onfatiguedelta = nil
            end
        end

        local _SetGhostMode = self.SetGhostMode
        function self:SetGhostMode(ghostmode)
            if not self.isghostmode == not ghostmode then
                return
            elseif ghostmode then
                self.fatiguebadge:Hide()
            else
                self.fatiguebadge:Show()
            end

            self.inst:DoStaticTaskInTime(0, ghostmode and OnSetGhostMode or OnSetPlayerMode, self)

            return _SetGhostMode(self, ghostmode)
        end

        self.inst:DoStaticTaskInTime(0, isghost and OnSetGhostMode or OnSetPlayerMode, self)

    end
end

AddClassPostConstruct("widgets/statusdisplays", FatigueBadgeDisplay)

--------------------------------------------------------------------------

-- Stamina
local function StaminaBadgeDisplay(self)
    if self.owner:HasTag("musha") then
        local StaminaBadge = require "widgets/staminabadge"

        self.staminabadge = self:AddChild(StaminaBadge(self.owner))
        self.owner.staminabadge = self.staminabadge
        self._custombadge = self.staminabadge
        self.onstaminadelta = nil

        local isghost =
        (self.inst.player_classified ~= nil and self.inst.player_classified.isghostmode:value()) or
            (self.inst.player_classified == nil and self.inst:HasTag("playerghost"))

        local AlwaysOnStatus = nil
        for k, v in ipairs(KnownModIndex:GetModsToLoad()) do
            local Mod = KnownModIndex:GetModInfo(v).name
            if Mod == "Combined Status" then
                AlwaysOnStatus = true
                break
            end
        end

        if AlwaysOnStatus then
            self.staminabadge:SetPosition(-120, -15, 0)
        else
            self.staminabadge:SetPosition(-100, -15, 0)
        end

        function self:SetStaminaPercent(pct)
            self.staminabadge:SetPercent(pct, self.owner.replica.stamina:Max())

            if pct >= 1 then
                self.staminabadge:StartWarning()
            else
                self.staminabadge:StopWarning()
            end
        end

        function self:StaminaDelta(data)
            self:SetStaminaPercent(data.newpercent)
        end

        local function OnSetPlayerMode(inst, self)
            self.modetask = nil

            if self.onstaminadelta == nil then
                self.onstaminadelta = function(owner, data) self:StaminaDelta(data) end
                self.inst:ListenForEvent("staminadelta", self.onstaminadelta, self.owner)
                self:SetStaminaPercent(self.owner.replica.stamina:GetPercent())
            end
        end

        local function OnSetGhostMode(inst, self)
            self.modetask = nil

            if self.onstaminadelta ~= nil then
                self.inst:RemoveEventCallback("staminadelta", self.onstaminadelta, self.owner)
                self.onstaminadelta = nil
            end
        end

        local _SetGhostMode = self.SetGhostMode
        function self:SetGhostMode(ghostmode)
            if not self.isghostmode == not ghostmode then
                return
            elseif ghostmode then
                self.staminabadge:Hide()
                self.staminabadge:StopWarning()
            else
                self.staminabadge:Show()
            end

            self.inst:DoStaticTaskInTime(0, ghostmode and OnSetGhostMode or OnSetPlayerMode, self)

            return _SetGhostMode(self, ghostmode)
        end

        self.inst:DoStaticTaskInTime(0, isghost and OnSetGhostMode or OnSetPlayerMode, self)

    end
end

AddClassPostConstruct("widgets/statusdisplays", StaminaBadgeDisplay)
