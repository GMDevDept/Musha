local function ClassPostConstructFn(self)
    local _GetAttacked = self.GetAttacked
    function self:GetAttacked(attacker, damage, weapon, stimuli)
        if not (self.inst.components.health and self.inst.components.health:IsDead())
            and self.inst:HasTag("manashieldactivated") then
            -- By this way 'attacked' event won't be pushed to self.inst and 'onhitother' event won't be pushed to attacker
            -- Thus attacked effects will be cancelled if manashield is active (including stategraph event)

            self.lastattacker = attacker
            self.inst:PushEvent("blocked", { attacker = attacker })
            self.inst:PushEvent("manashieldonattacked",
                { attacker = attacker, damage = damage, weapon = weapon, stimuli = stimuli }) -- Here is original damage before calculating equipments and health absorb multipliers
            return false
        elseif not (self.inst.components.health and self.inst.components.health:IsDead())
            and self.inst.sg:HasStateTag("musha_shadowparry") and self.inst.components.rider:IsRiding() then
            -- Damageredirecttarget is not nil When riding, need to push 'blocked' event to trigger shadow parry
            -- No worry about 'attacked' event since character has 100% combat damage reduction when shadow parry is active

            self.lastattacker = attacker
            self.inst:PushEvent("blocked", { attacker = attacker })
            return false
        else
            return _GetAttacked(self, attacker, damage, weapon, stimuli)
        end
    end
end

AddClassPostConstruct("components/combat", ClassPostConstructFn)
