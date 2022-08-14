-- Hotkey: ToggleValkyrie
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_valkyrie"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        SendModRPCToServer(MOD_RPC.musha.togglevalkyrie)
    end
end)

-- Hotkey: ToggleBerserk
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_berserk"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        SendModRPCToServer(MOD_RPC.musha.toggleberserk)
    end
end)

-- Hotkey: ToggleShield
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_shield"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        SendModRPCToServer(MOD_RPC.musha.toggleshield)
    end
end)

-- Hotkey: ToggleSleep
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_sleep"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        SendModRPCToServer(MOD_RPC.musha.togglesleep)
    end
end)

-- Hotkey: switch companion order hotkey bindings
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_keybinding"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        SendModRPCToServer(MOD_RPC.musha.switchkeybindings)
    end
end)

-- Hotkey: Companion Order: Shadow Musha
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_shadowmusha"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        SendModRPCToServer(MOD_RPC.musha.doshadowmushaorder)
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
