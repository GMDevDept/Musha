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

local function StashChest(inst, stash)
    if inst.container and inst.loots then
        local container = SpawnPrefab(inst.container)
        for _, v in pairs(inst.loots) do
            if math.random() < v.chance then
                for i = 1, math.random(v.lootcount, v.lootcountmax) do
                    local loot = SpawnPrefab(v.prefab)
                    container.components.container:GiveItem(loot)
                end

                if container.components.container:IsFull() then
                    break
                end
            end
        end
        stash:stashloot(container)
    end

    if inst.extraloots then
        for _, v in pairs(inst.extraloots) do
            if math.random() < v.chance then
                for i = 1, math.random(v.lootcount, v.lootcountmax) do
                    local loot = SpawnPrefab(v.prefab)
                    stash:stashloot(loot)
                end
            end
        end
    end
end

local function GenerateLoot(stash, count)
    local lootlist = {}

    local function additem(name)
        local item = SpawnPrefab(name)
        StashLoot(item, stash)
    end

    local collection1 = {
        boneshard = 4,
        houndstooth = 4,
        stinger = 4,
        tentaclespots = 2,
        beefalowool = 4,
        feather_robin = 1,
        feather_robin_winter = 1,
        feather_crow = 1,
        feather_canary = 1,
        pigskin = 4,
        manrabbit_tail = 4,
        spidergland = 4,
    }

    local collection2 = {
        nightmarefuel = 4,
        livinglog = 4,
        petals_evil = 4,
        petals = 4,
        purplegem = 1,
    }

    local collection3 = {
        gears = 4,
        cutreeds = 4,
        log = 4,
        rocks = 4,
        nitre = 4,
        charcoal = 4,
        moonglass = 2,
    }

    local collection4 = {
        boards = 4,
        cutstone = 4,
        rope = 4,
        papyrus = 4,
        transistor = 2,
        marblebean = 2,
    }

    local foodlist = require("preparedfoods")
    local additionalfoods = require("preparedfoods_warly")

    for k, v in pairs(additionalfoods) do
        foodlist[k] = v
    end

    local food = GetRandomItem(foodlist)
    table.insert(lootlist, food.name)

    local collections = { collection1, collection2, collection3, collection4 }

    for i = 1, math.random(1, 3) do
        local collection = GetRandomItem(collections)
        local item = weighted_random_choice(collection)
        for i = 1, math.random(2, 4) do
            table.insert(lootlist, item)
        end
    end

    for i = 1, math.random(2, 5) do
        table.insert(lootlist, "goldnugget")
    end

    if math.random() < 0.7 then
        for i = 1, math.random(1, 3) do
            table.insert(lootlist, "taffy")
        end
    else
        table.insert(lootlist, "jellybean")
    end

    if math.random() < 0.10 then
        table.insert(lootlist, "mandrake")
    end

    if math.random() < 0.15 then
        table.insert(lootlist, "purplegem")
    end

    if math.random() < 0.05 then
        table.insert(lootlist, "greengem")
    end

    if math.random() < 0.05 then
        table.insert(lootlist, "yellowgem")
    end

    if math.random() < 0.05 then
        table.insert(lootlist, "orangegem")
    end

    if math.random() < 0.5 then
        for i = 1, math.random(1, 3) do
            if math.random() < 0.5 then
                table.insert(lootlist, "redgem")
            end
        end
    end

    if math.random() < 0.5 then
        for i = 1, math.random(1, 3) do
            if math.random() < 0.5 then
                table.insert(lootlist, "bluegem")
            end
        end
    end

    for i, loot in ipairs(lootlist) do
        additem(loot)
    end

    local chest
    local treasurechests, weightedtable = require("src/treasurechests")[1], require("src/treasurechests")[2]

    if count == 0 then
        stash.loot = {} -- No additional loots with the first chest
        chest = treasurechests.gift_birth
    elseif count == 2 then
        chest = treasurechests.gift_shadow
    elseif count == 4 then
        chest = treasurechests.gift_book
    elseif math.random() < TUNING.musha.skills.treasuresniffing.chestchance then
        chest = treasurechests[weighted_random_choice(weightedtable)]
    end

    if chest ~= nil then
        StashChest(chest, stash)
    end
end

function TreasureHunter:FindStashLocation()
    local pt = Vector3(0, 0, 0)

    if self.count == 0 then
        local x, y, z = self.inst.Transform:GetWorldPosition()
        local range = 10
        local map = TheWorld.Map
        local offset

        while not offset do
            offset = FindValidPositionByFan(
                math.random() * 2 * PI,
                math.random() * range,
                4,
                function(offset)
                    local x1 = x + offset.x
                    local z1 = z + offset.z
                    return map:IsVisualGroundAtPoint(x1, 0, z1)
                        and #TheSim:FindEntities(x1, 0, z1, 5, nil, nil, { "player" }) == 0
                end
            )
        end
        pt = Vector3(x + offset.x, 0, z + offset.z)
    else
        local locationOK = false
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

            while not TheWorld.Map:IsVisualGroundAtPoint(pt.x, 0, pt.z) == true do
                local theta = math.random() * 2 * PI
                local radius = 4
                offset = Vector3(radius * math.cos(theta), 0, -radius * math.sin(theta))
                pt = pt + offset
            end

            local players = FindPlayersInRange(pt.x, pt.y, pt.z, 10, true)
            if #players == 0 then
                locationOK = true
            end
        end
    end

    return pt
end

function TreasureHunter:NewStash(pt) -- pt: Vector3
    if not pt then
        pt = self:FindStashLocation()
        if not pt then -- Theoretically impossible
            self.inst.components.talker:Say(STRINGS.musha.skills.treasuresniffing.cannot_find_pos)
            return
        end
    end

    local stash = SpawnPrefab("elftreasure")
    stash.Transform:SetPosition(pt.x, 0, pt.z)
    stash.owner = self.inst.GUID
    stash.components.mapspotrevealer:RevealMap(self.inst)

    if self.count == 0 then
        SpawnPrefab("shovel").Transform:SetPosition(pt.x, 0, pt.z)
    end

    GenerateLoot(stash, self.count)
    return stash
end

return TreasureHunter
