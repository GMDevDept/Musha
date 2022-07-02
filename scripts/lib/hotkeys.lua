-- Hotkey: toggle_valkyrie
TheInput:AddKeyDownHandler(GLOBAL.TUNING.MUSHA.hotkey_valkyrie, function()
    if ThePlayer:HasTag("musha") and not IsPaused() then
        if TheWorld.ismastersim then
            ThePlayer.toggle_valkyrie(ThePlayer)
        else
            SendModRPCToServer(MOD_RPC.musha.toggle_valkyrie)
        end
    end
end)

-- Hotkey: toggle_stealth
TheInput:AddKeyDownHandler(GLOBAL.TUNING.MUSHA.hotkey_stealth, function()
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
    function self:OnBecomeActive()
        SetPause(true)

        self._base.OnBecomeActive(self)
        TheFrontEnd:ShowConsoleLog()

        self.console_edit:SetFocus()
        self.console_edit:SetEditing(true)

        self:ToggleRemoteExecute(true) -- if we are admin, start in remote mode
    end

    function self:OnBecomeInactive()
        SetPause(false)

        self._base.OnBecomeInactive(self)

        if self.runtask ~= nil then
            self.runtask:Cancel()
            self.runtask = nil
        end
    end
end)

-- Disable hotkeys when chat screen is active
AddClassPostConstruct("screens/chatinputscreen", function(self)
    function self:OnBecomeActive()
        SetPause(true)

        self._base.OnBecomeActive(self)

        self.chat_edit:SetFocus()
        self.chat_edit:SetEditing(true)

        if IsConsole() then
            TheFrontEnd:LockFocus(true)
        end

        if ThePlayer ~= nil and ThePlayer.HUD ~= nil then
            ThePlayer.HUD.controls.networkchatqueue:Hide()
        end
    end

    function self:OnBecomeInactive()
        SetPause(false)

        self._base.OnBecomeInactive(self)

        if self.runtask ~= nil then
            self.runtask:Cancel()
            self.runtask = nil
        end

        if ThePlayer ~= nil and ThePlayer.HUD ~= nil then
            ThePlayer.HUD.controls.networkchatqueue:Show()
        end
    end
end)
