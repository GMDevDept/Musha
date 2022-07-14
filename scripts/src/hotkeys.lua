-- Hotkey: toggle_valkyrie
TheInput:AddKeyDownHandler(TUNING.musha.hotkey_valkyrie, function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer.toggle_valkyrie(ThePlayer)
        else
            SendModRPCToServer(MOD_RPC.musha.toggle_valkyrie)
        end
    end
end)

-- Hotkey: toggle_stealth
TheInput:AddKeyDownHandler(TUNING.musha.hotkey_stealth, function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer.toggle_stealth(ThePlayer)
        else
            SendModRPCToServer(MOD_RPC.musha.toggle_stealth)
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
