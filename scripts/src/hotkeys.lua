-- R: Valkyrie mode
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_valkyrie"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        local CursorPosition = TheInput:GetWorldEntityUnderMouse() and TheInput:GetWorldEntityUnderMouse():GetPosition()
            or TheInput:GetWorldPosition()

        SendModRPCToServer(MOD_RPC.musha.valkyriekeydown, CursorPosition.x, CursorPosition.y, CursorPosition.z)
    end
end)

TheInput:AddKeyUpHandler(GetModConfigData("hotkey_valkyrie"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        local CursorPosition = TheInput:GetWorldEntityUnderMouse() and TheInput:GetWorldEntityUnderMouse():GetPosition()
            or TheInput:GetWorldPosition()

        SendModRPCToServer(MOD_RPC.musha.valkyriekeyup, CursorPosition.x, CursorPosition.y, CursorPosition.z)
    end
end)

-- G: Shadow mode
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_shadow"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        local CursorPosition = TheInput:GetWorldEntityUnderMouse() and TheInput:GetWorldEntityUnderMouse():GetPosition()
            or TheInput:GetWorldPosition()

        SendModRPCToServer(MOD_RPC.musha.shadowkeydown, CursorPosition.x, CursorPosition.y, CursorPosition.z)
    end
end)

TheInput:AddKeyUpHandler(GetModConfigData("hotkey_shadow"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        local CursorPosition = TheInput:GetWorldEntityUnderMouse() and TheInput:GetWorldEntityUnderMouse():GetPosition()
            or TheInput:GetWorldPosition()

        SendModRPCToServer(MOD_RPC.musha.shadowkeyup, CursorPosition.x, CursorPosition.y, CursorPosition.z)
    end
end)

-- T: ToggleShield
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_shield"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        local CursorPosition = TheInput:GetWorldEntityUnderMouse() and TheInput:GetWorldEntityUnderMouse():GetPosition()
            or TheInput:GetWorldPosition()

        SendModRPCToServer(MOD_RPC.musha.shieldkeydown, CursorPosition.x, CursorPosition.y, CursorPosition.z)
    end
end)

TheInput:AddKeyUpHandler(GetModConfigData("hotkey_shield"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        local CursorPosition = TheInput:GetWorldEntityUnderMouse() and TheInput:GetWorldEntityUnderMouse():GetPosition()
            or TheInput:GetWorldPosition()

        SendModRPCToServer(MOD_RPC.musha.shieldkeyup, CursorPosition.x, CursorPosition.y, CursorPosition.z)
    end
end)

-- Z: ToggleSleep
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_sleep"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        SendModRPCToServer(MOD_RPC.musha.togglesleep)
    end
end)

-- X: PlayElfMelody
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_elfmelody"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        SendModRPCToServer(MOD_RPC.musha.playelfmelody)
    end
end)

-- F1: switch companion order hotkey bindings
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_keybinding"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        SendModRPCToServer(MOD_RPC.musha.switchkeybindings)
    end
end)

-- F2: Companion Order: Shadow Musha
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
