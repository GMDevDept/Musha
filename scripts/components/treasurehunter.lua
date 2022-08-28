---@diagnostic disable: undefined-field
local function OnTaskTick(inst, self, period)
    self:Recalc(period)
end

local TreasureHunter = Class(function(self, inst)
    self.inst = inst
    self.max = TUNING.musha.skills.treasuresniffing.max
    self.current = 0
    self.count = 0
    self.ispaused = false
    self.baserate = TUNING.musha.skills.treasuresniffing.regen
    self.modifiers = SourceModifierList(inst, 0, SourceModifierList.additive)
    self.rate = 0

    local period = 5
    self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
end)

function TreasureHunter:OnSave()
    return {
        count = self.count,
        current = self.current,
    }
end

function TreasureHunter:OnLoad(data)
    self.count = data.count or 0
    if self.count == 0 then
        self.max = TUNING.musha.skills.treasuresniffing.first
    end

    self.current = data.current or 0
    self:DoDelta(0)
end

function TreasureHunter:IsPaused()
    return self.ispaused
end

function TreasureHunter:Pause()
    self.ispaused = true
end

function TreasureHunter:Resume()
    self.ispaused = false
end

function TreasureHunter:IsReady()
    return self.current == self.max
end

function TreasureHunter:GetPercent()
    return self.current / self.max
end

function TreasureHunter:SetPercent(p)
    local old    = self.current
    self.current = p * self.max
    self.inst:PushEvent("treasuredelta", { oldpercent = old / self.max, newpercent = p })

    if old < self.max then
        if self.current >= self.max then
            self.inst:PushEvent("treasurefull")
        end
    else
        if self.current < self.max then
            self.inst:PushEvent("treasurenolongerfull")
        end
    end
end

function TreasureHunter:Reset()
    self.count = self.count + 1
    self.max = TUNING.musha.skills.treasuresniffing.max
    self.current = 0
end

function TreasureHunter:IsEffective()
    return self.modifiers:Get() ~= 0 or self.inst.sg:HasStateTag("moving")
end

function TreasureHunter:Recalc(dt)
    if self.ispaused or not self:IsEffective() then
        return
    end

    self.rate = self.baserate + self.modifiers:Get()

    self:DoDelta(dt * self.rate)
end

function TreasureHunter:DoDelta(delta)
    local old = self.current
    self.current = math.clamp(self.current + delta, 0, self.max)

    self.inst:PushEvent("treasuredelta",
        { oldpercent = old / self.max, newpercent = self.current / self.max, delta = self.current - old })

    if old < self.max then
        if self.current >= self.max then
            self.inst:PushEvent("treasurefull")
        end
    else
        if self.current < self.max then
            self.inst:PushEvent("treasurenolongerfull")
        end
    end
end

function TreasureHunter:GetDebugString()
    return string.format("%2.2f / %2.2f, rate: %2.2f", self.current, self.max, self.rate)
end

---------------------------------------------------------------------------------------------------------

-- Generate elf treasure

local function StashLoot(inst, stash)
    if inst.components.inventoryitem then
        stash:stashloot(inst)
    elseif inst.components.inventory then
        local function checkitem(item)
            if item then
                inst.components.inventory:DropItem(item, true)
                stash:stashloot(inst)
            end
        end

        inst.components.inventory:ForEachItem(checkitem)
    end
end

local function GenerateLoot(stash)

    local function additem(name)
        local item = SpawnPrefab(name)
        StashLoot(item, stash)
    end

    local lootlist = {}

    for i = 1, math.random(2, 4) do
        table.insert(lootlist, "palmcone_scale")
    end

    for i = 1, math.random(2, 4) do
        table.insert(lootlist, "cave_banana")
    end

    if math.random() < 0.3 then
        for i = 1, math.random(2, 4) do
            table.insert(lootlist, "treegrowthsolution")
        end
    end

    if math.random() < 0.3 then
        for i = 1, math.random(2, 4) do
            table.insert(lootlist, "goldnugget")
        end
    end

    if math.random() < 0.5 then
        for i = 1, math.random(3, 6) do
            if math.random() < 0.3 then
                table.insert(lootlist, "meat_dried")
            end
        end
    end

    if math.random() < 0.5 then
        for i = 1, math.random(1, 3) do
            table.insert(lootlist, "bananajuice")
        end
    end

    for i, loot in ipairs(lootlist) do
        additem(loot)
    end
end

function TreasureHunter:FindStashLocation()
    local locationOK = false
    local pt = Vector3(0, 0, 0)
    local offset = Vector3(0, 0, 0)

    while locationOK == false do
        local ids = {}
        for node, i in pairs(TheWorld.topology.nodes) do
            local ct = TheWorld.topology.nodes[node].cent
            if TheWorld.Map:IsVisualGroundAtPoint(ct[1], 0, ct[2]) then
                table.insert(ids, node)
            end
        end

        local randnode = TheWorld.topology.nodes[ids[math.random(1, #ids)]]
        pt = Vector3(randnode.cent[1], 0, randnode.cent[2])
        local theta = math.random() * 2 * PI
        local radius = 4
        offset = Vector3(radius * math.cos(theta), 0, -radius * math.sin(theta))

        while TheWorld.Map:IsVisualGroundAtPoint(pt.x, 0, pt.z) == true do
            pt = pt + offset
        end

        local players = FindPlayersInRange(pt.x, pt.y, pt.z, 40, true)
        if #players == 0 then
            locationOK = true
        end
    end

    return pt - (offset * 2)
end

function TreasureHunter:NewStash(pt) -- pt: Vector3
    if not pt then
        pt = self:FindStashLocation()
        if not pt then
            self.inst.components.talker:Say(STRINGS.musha.skills.treasuresniffing.cannot_find_pos)
            return
        end
    end
    local stash = SpawnPrefab("elftreasure")
    stash.Transform:SetPosition(pt.x, 0, pt.z)
    stash.owner = self.inst.GUID
    stash.components.mapspotrevealer:RevealMap(self.inst)

    GenerateLoot(stash)
    return stash
end

return TreasureHunter
