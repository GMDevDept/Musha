-- Hotkey: ToggleValkyrie
TheInput:AddKeyDownHandler(TUNING.musha.hotkey_valkyrie, function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer:ToggleValkyrie()
        else
            SendModRPCToServer(MOD_RPC.musha.ToggleValkyrie)
        end
    end
end)

-- Hotkey: ToggleBerserk
TheInput:AddKeyDownHandler(TUNING.musha.hotkey_berserk, function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer:ToggleBerserk()
        else
            SendModRPCToServer(MOD_RPC.musha.ToggleBerserk)
            local previousmode = ThePlayer.mode:value()
            if previousmode == 0 or previousmode == 1 then
                ThePlayer:PushEvent("activateberserk")
            end
        end
    end
end)

-- Hotkey: ToggleSleep
TheInput:AddKeyDownHandler(TUNING.musha.hotkey_sleep, function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer:ToggleSleep()
        else
            SendModRPCToServer(MOD_RPC.musha.ToggleSleep)
        end
    end
end)

-- Disable hotkeys when console screen is active
AddClassPostConstruct("screens/consolescreen", function(self)
    local _OnBecomeActive = self.OnBecomeActive
    function self:OnBecomeActive()
        SetPause(true)
        return _OnBecomeActive(self)
    end

    local _OnBecomeInactive = self.OnBecomeInactive
    function self:OnBecomeInactive()
        SetPause(false)
        return _OnBecomeInactive(self)
    end
end)

-- Disable hotkeys when chat screen is active
AddClassPostConstruct("screens/chatinputscreen", function(self)
    local _OnBecomeActive = self.OnBecomeActive
    function self:OnBecomeActive()
        SetPause(true)
        return _OnBecomeActive(self)
    end

    local _OnBecomeInactive = self.OnBecomeInactive
    function self:OnBecomeInactive()
        SetPause(false)
        return _OnBecomeInactive(self)
    end
end)
