local function ClassPostConstructFn(self)
    local _TakeFuelItem = self.TakeFuelItem
    function self:TakeFuelItem(item, doer)
        if self.inst and self.inst:HasTag("musha_equipment") then
            local fuel_obj = item or doer

            if self:CanAcceptFuelItem(fuel_obj) then
                local oldsection = self:GetCurrentSection()

                local wetmult = fuel_obj:GetIsWet() and TUNING.WET_FUEL_PENALTY or 1
                local masterymult = doer ~= nil and doer.components.fuelmaster ~= nil and
                    doer.components.fuelmaster:GetBonusMult(fuel_obj, self.inst) or 1

                local fuel = fuel_obj.components.fuel or fuel_obj.components.fueler

                local fuelvalue = fuel.fuelvalue * self.bonusmult * wetmult * masterymult

                self:DoDelta(fuelvalue, doer)

                fuel:Taken(self.inst)

                if item ~= nil then
                    item:Remove()
                end

                if self.ontakefuelfn ~= nil then
                    self.ontakefuelfn(self.inst, fuelvalue, fuel_obj) -- The only change is adding fuel_obj to the param list
                end
                self.inst:PushEvent("takefuel", { fuelvalue = fuelvalue })

                return true
            end
        else
            return _TakeFuelItem(self, item, doer)
        end
    end
end

AddClassPostConstruct("components/fueled", ClassPostConstructFn)
