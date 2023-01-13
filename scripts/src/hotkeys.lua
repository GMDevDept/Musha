-- R: Valkyrie mode
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_valkyrie"), function()
    if ThePlayer:HasTag("musha") then
        if TheFrontEnd:GetActiveScreen().name == "HUD" and not ThePlayer.valkyriekeypressed then
            local CursorPosition = TheInput:GetWorldEntityUnderMouse() and
                TheInput:GetWorldEntityUnderMouse():GetPosition() or TheInput:GetWorldPosition()

            SendModRPCToServer(MOD_RPC.musha.valkyriekeydown, CursorPosition.x, CursorPosition.y, CursorPosition.z)

            ThePlayer.valkyriekeypressed = true -- Prevent continuous triggering on long press
        end
    end
end)

TheInput:AddKeyUpHandler(GetModConfigData("hotkey_valkyrie"), function()
    if ThePlayer:HasTag("musha") then
        if TheFrontEnd:GetActiveScreen().name == "HUD" then
            local CursorPosition = TheInput:GetWorldEntityUnderMouse() and
                TheInput:GetWorldEntityUnderMouse():GetPosition() or TheInput:GetWorldPosition()

            SendModRPCToServer(MOD_RPC.musha.valkyriekeyup, CursorPosition.x, CursorPosition.y, CursorPosition.z)
        end

        ThePlayer.valkyriekeypressed = nil
    end
end)

-- G: Shadow mode
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_shadow"), function()
    if ThePlayer:HasTag("musha") then
        if TheFrontEnd:GetActiveScreen().name == "HUD" and not ThePlayer.shadowkeypressed then
            local CursorPosition = TheInput:GetWorldEntityUnderMouse() and
                TheInput:GetWorldEntityUnderMouse():GetPosition() or TheInput:GetWorldPosition()

            SendModRPCToServer(MOD_RPC.musha.shadowkeydown, CursorPosition.x, CursorPosition.y, CursorPosition.z)

            ThePlayer.shadowkeypressed = true -- Prevent continuous triggering on long press
        end
    end
end)

TheInput:AddKeyUpHandler(GetModConfigData("hotkey_shadow"), function()
    if ThePlayer:HasTag("musha") then
        if TheFrontEnd:GetActiveScreen().name == "HUD" then
            local CursorPosition = TheInput:GetWorldEntityUnderMouse() and
                TheInput:GetWorldEntityUnderMouse():GetPosition() or TheInput:GetWorldPosition()

            SendModRPCToServer(MOD_RPC.musha.shadowkeyup, CursorPosition.x, CursorPosition.y, CursorPosition.z)
        end

        ThePlayer.shadowkeypressed = nil
    end
end)

-- T: ToggleShield
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_shield"), function()
    if ThePlayer:HasTag("musha") then
        if TheFrontEnd:GetActiveScreen().name == "HUD" and not ThePlayer.shieldkeypressed then
            local CursorPosition = TheInput:GetWorldEntityUnderMouse() and
                TheInput:GetWorldEntityUnderMouse():GetPosition() or TheInput:GetWorldPosition()

            SendModRPCToServer(MOD_RPC.musha.shieldkeydown, CursorPosition.x, CursorPosition.y, CursorPosition.z)

            ThePlayer.shieldkeypressed = true -- Prevent continuous triggering on long press
        end
    end
end)

TheInput:AddKeyUpHandler(GetModConfigData("hotkey_shield"), function()
    if ThePlayer:HasTag("musha") then
        if TheFrontEnd:GetActiveScreen().name == "HUD" then
            local CursorPosition = TheInput:GetWorldEntityUnderMouse() and
                TheInput:GetWorldEntityUnderMouse():GetPosition() or TheInput:GetWorldPosition()

            SendModRPCToServer(MOD_RPC.musha.shieldkeyup, CursorPosition.x, CursorPosition.y, CursorPosition.z)
        end

        ThePlayer.shieldkeypressed = nil
    end
end)

-- Z: ToggleSleep
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_sleep"), function()
    if ThePlayer:HasTag("musha") and TheFrontEnd:GetActiveScreen().name == "HUD" then
        SendModRPCToServer(MOD_RPC.musha.togglesleep)
    end
end)

-- X: PlayElfMelody
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_elfmelody"), function()
    if ThePlayer:HasTag("musha") and TheFrontEnd:GetActiveScreen().name == "HUD" then
        SendModRPCToServer(MOD_RPC.musha.playelfmelody)
    end
end)

-- F1: switch companion order hotkey bindings
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_keybinding"), function()
    if ThePlayer:HasTag("musha") and TheFrontEnd:GetActiveScreen().name == "HUD" then
        SendModRPCToServer(MOD_RPC.musha.switchkeybindings)
    end
end)

-- F2: Companion Order: Shadow Musha
TheInput:AddKeyDownHandler(GetModConfigData("hotkey_shadowmusha"), function()
    if ThePlayer:HasTag("musha") and TheFrontEnd:GetActiveScreen().name == "HUD" then
        SendModRPCToServer(MOD_RPC.musha.doshadowmushaorder)
    end
end)
