-- Hotkey: ToggleValkyrie
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_valkyrie"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer:ToggleValkyrie()
        else
            SendModRPCToServer(MOD_RPC.musha.ToggleValkyrie)
        end
    end
end)

-- Hotkey: ToggleBerserk
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_berserk"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer:ToggleBerserk()
        else
            SendModRPCToServer(MOD_RPC.musha.ToggleBerserk)
            local previousmode = ThePlayer._mode
            if previousmode == 0 or previousmode == 1 then
                ThePlayer:PushEvent("activateberserk")
            end
        end
    end
end)

-- Hotkey: ToggleSleep
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_sleep"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer:ToggleSleep()
        else
            SendModRPCToServer(MOD_RPC.musha.ToggleSleep)
        end
    end
end)

-- Hotkey: switch companion order hotkey bindings
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_keybinding"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer:SwitchKeyBindings()
        else
            SendModRPCToServer(MOD_RPC.musha.SwitchKeyBindings)
        end
    end
end)

-- Hotkey: Companion Order: Shadow Musha
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_shadowmusha"), function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer:DoShadowMushaOrder()
        else
            SendModRPCToServer(MOD_RPC.musha.DoShadowMushaOrder)
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
