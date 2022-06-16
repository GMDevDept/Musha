local require = GLOBAL.require
local Vector3 = GLOBAL.Vector3
TECH = GLOBAL.TECH
local IsServer = GLOBAL.TheNet:GetIsServer()
local containers = require("containers")

local share_item = GetModConfigData("shareitems")
local in_container =  GetModConfigData("incontainer")
local musha_in_container =  GetModConfigData("musha_incontainer")

-----------
--temporaly compatible with 
--[[local Tropical = 0
for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
if GLOBAL.KnownModIndex:GetModInfo(moddir).name == " Tropical Experience Return of Them" then
	Tropical = 1
end
end
function Tropical(inst)
if IsServer then
inst.Tropical = true
end end	

if Tropical == 1 then
AddPrefabPostInit( "armor_mushaa", Tropical)
AddPrefabPostInit( "armor_mushab", Tropical)
AddPrefabPostInit( "broken_frosthammer", Tropical)
AddPrefabPostInit( "pirateback", Tropical)
end]]


local oldwidgetsetup = containers.widgetsetup
containers.widgetsetup = function(container, prefab)

if not prefab and container.inst.prefab == "bowm" then
prefab = "slingshot" end
if not prefab and container.inst.prefab == "armor_mushaa" then
prefab = "backpack" end
if not prefab and container.inst.prefab == "broken_frosthammer" then
prefab = "backpack" end
if not prefab and container.inst.prefab == "armor_mushab" then
prefab = "piggyback" end
if not prefab and container.inst.prefab == "pirateback" then
prefab = "krampus_sack" end

  if not prefab and container.inst.prefab == "musha_tall3" then  prefab = "chester" end   if not prefab and container.inst.prefab == "musha_tallrrr1" then  prefab = "chester" end   if not prefab and container.inst.prefab == "musha_tallrrr2" then  prefab = "chester" end   if not prefab and container.inst.prefab == "musha_tallrrr3" then  prefab = "chester" end   if not prefab and container.inst.prefab == "musha_tallrrr4" then  prefab = "chester" end   if not prefab and container.inst.prefab == "musha_tallrrr5" then  prefab = "chester" end   if not prefab and container.inst.prefab == "musha_tallrrrice" then  prefab = "chester" end if not prefab and container.inst.prefab == "musha_small_super" then  prefab = "chester" end 
oldwidgetsetup(container, prefab)
end



---------------
-------------comfortable extra equip slot
--compatible with shipwrecked mod

--local extraequipslot = 0
--[[for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
    if GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Extra Equip Slots" or GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Extra Equip Slots API Edition" or GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Tropical Experience | The Volcano Biome" or GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Island Adventures" then
	
		extraequipslot = 1
   end end ]]
   


--local DLC2 = 0 
--[[for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
    if GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Tropical Experience | The Volcano Biome" or GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Island Adventures" then
		DLC2 = 1
   end end ]]

--[[local DLC2_fly = 0 
for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
    if GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Island Adventures" then
		DLC2_fly = 1
   end end]]
   
--[[if DLC2 == 1 then   

function SW_DLC2(inst)
	inst.DLC2 = true
end
AddPrefabPostInit( "mushasword_base", SW_DLC2)
AddPrefabPostInit( "mushasword", SW_DLC2)
AddPrefabPostInit( "mushasword_frost", SW_DLC2)
AddPrefabPostInit( "armor_mushaa", SW_DLC2)
AddPrefabPostInit( "armor_mushab", SW_DLC2)
AddPrefabPostInit( "broken_frosthammer", SW_DLC2)
AddPrefabPostInit( "pirateback", SW_DLC2)

AddPrefabPostInit( "musha", SW_DLC2)
AddPrefabPostInit( "musha_small", SW_DLC2)  AddPrefabPostInit( "musha_teen", SW_DLC2) AddPrefabPostInit( "musha_teenr1", SW_DLC2) AddPrefabPostInit( "musha_teenr2", SW_DLC2) AddPrefabPostInit( "musha_teenr3", SW_DLC2) AddPrefabPostInit( "musha_teenr4", SW_DLC2) AddPrefabPostInit( "musha_teenice", SW_DLC2)  AddPrefabPostInit( "musha_tall", SW_DLC2) AddPrefabPostInit( "musha_tallr1", SW_DLC2) AddPrefabPostInit( "musha_tallr2", SW_DLC2) AddPrefabPostInit( "musha_tallr3", SW_DLC2) AddPrefabPostInit( "musha_tallr4", SW_DLC2) AddPrefabPostInit( "musha_tallrice", SW_DLC2)  AddPrefabPostInit( "musha_tall2", SW_DLC2) AddPrefabPostInit( "musha_tallrr1", SW_DLC2) AddPrefabPostInit( "musha_tallrr2", SW_DLC2) AddPrefabPostInit( "musha_tallrr3", SW_DLC2) AddPrefabPostInit( "musha_tallrr4", SW_DLC2) AddPrefabPostInit( "musha_tallrr5", SW_DLC2) AddPrefabPostInit( "musha_tallrrice", SW_DLC2)  AddPrefabPostInit( "musha_tall3", SW_DLC2) AddPrefabPostInit( "musha_tallrrr1", SW_DLC2) AddPrefabPostInit( "musha_tallrrr2", SW_DLC2) AddPrefabPostInit( "musha_tallrrr3", SW_DLC2) AddPrefabPostInit( "musha_tallrrr4", SW_DLC2) AddPrefabPostInit( "musha_tallrrr5", SW_DLC2) AddPrefabPostInit( "musha_tallrrrice", SW_DLC2)  AddPrefabPostInit( "musha_tall4", SW_DLC2) AddPrefabPostInit( "musha_tallrrrr1", SW_DLC2) AddPrefabPostInit( "musha_tallrrrr2", SW_DLC2) AddPrefabPostInit( "musha_tallrrrr3", SW_DLC2) AddPrefabPostInit( "musha_tallrrrr4", SW_DLC2) AddPrefabPostInit( "musha_tallrrrr5", SW_DLC2) AddPrefabPostInit( "musha_tallrrrr6", SW_DLC2) AddPrefabPostInit( "musha_tallrrrrice", SW_DLC2)  AddPrefabPostInit( "musha_tall5", SW_DLC2) AddPrefabPostInit( "musha_tallrrrrr1", SW_DLC2) AddPrefabPostInit( "musha_tallrrrrr2", SW_DLC2) AddPrefabPostInit( "musha_tallrrrrr3", SW_DLC2) AddPrefabPostInit( "musha_tallrrrrr4", SW_DLC2) AddPrefabPostInit( "musha_tallrrrrr5", SW_DLC2) AddPrefabPostInit( "musha_tallrrrrr6", SW_DLC2) AddPrefabPostInit( "musha_tallrrrrrice", SW_DLC2)  AddPrefabPostInit( "musha_rp1", SW_DLC2) AddPrefabPostInit( "musha_rp2", SW_DLC2) AddPrefabPostInit( "musha_rp3", SW_DLC2) AddPrefabPostInit( "musha_rp4", SW_DLC2) AddPrefabPostInit( "musha_rp5", SW_DLC2) AddPrefabPostInit( "musha_rp6", SW_DLC2) AddPrefabPostInit( "musha_rp7", SW_DLC2) AddPrefabPostInit( "musha_rpice", SW_DLC2)


function hack_tool(inst)
inst:AddComponent("tool")
inst.components.tool:SetAction(ACTIONS.HACK)
end

AddPrefabPostInit("mushasword", hack_tool)
AddPrefabPostInit("mushasword_frost", hack_tool)

end]]

--[[if DLC2_fly == 1 then   
modimport "compatible_mod/postinit_IA"

function SW_DLC2_fly(inst)
	inst.DLC2_fly = true
end
AddPrefabPostInit( "mushasword_base", SW_DLC2_fly)
AddPrefabPostInit( "mushasword", SW_DLC2_fly)
AddPrefabPostInit( "mushasword_frost", SW_DLC2_fly)
AddPrefabPostInit( "armor_mushaa", SW_DLC2_fly)
AddPrefabPostInit( "armor_mushab", SW_DLC2_fly)
AddPrefabPostInit( "broken_frosthammer", SW_DLC2_fly)
AddPrefabPostInit( "pirateback", SW_DLC2_fly)

AddPrefabPostInit( "ghosthound", SW_DLC2_fly)
AddPrefabPostInit( "ghosthound2", SW_DLC2_fly)
AddPrefabPostInit( "shadowmusha", SW_DLC2_fly)

AddPrefabPostInit( "musha", SW_DLC2_fly)
AddPrefabPostInit( "musha_small", SW_DLC2_fly)  AddPrefabPostInit( "musha_teen", SW_DLC2_fly) AddPrefabPostInit( "musha_teenr1", SW_DLC2_fly) AddPrefabPostInit( "musha_teenr2", SW_DLC2_fly) AddPrefabPostInit( "musha_teenr3", SW_DLC2_fly) AddPrefabPostInit( "musha_teenr4", SW_DLC2_fly) AddPrefabPostInit( "musha_teenice", SW_DLC2_fly)  AddPrefabPostInit( "musha_tall", SW_DLC2_fly) AddPrefabPostInit( "musha_tallr1", SW_DLC2_fly) AddPrefabPostInit( "musha_tallr2", SW_DLC2_fly) AddPrefabPostInit( "musha_tallr3", SW_DLC2_fly) AddPrefabPostInit( "musha_tallr4", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrice", SW_DLC2_fly)  AddPrefabPostInit( "musha_tall2", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrr1", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrr2", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrr3", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrr4", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrr5", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrice", SW_DLC2_fly)  AddPrefabPostInit( "musha_tall3", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrr1", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrr2", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrr3", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrr4", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrr5", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrice", SW_DLC2_fly)  AddPrefabPostInit( "musha_tall4", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrr1", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrr2", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrr3", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrr4", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrr5", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrr6", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrrice", SW_DLC2_fly)  AddPrefabPostInit( "musha_tall5", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrrr1", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrrr2", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrrr3", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrrr4", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrrr5", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrrr6", SW_DLC2_fly) AddPrefabPostInit( "musha_tallrrrrrice", SW_DLC2_fly)  AddPrefabPostInit( "musha_rp1", SW_DLC2_fly) AddPrefabPostInit( "musha_rp2", SW_DLC2_fly) AddPrefabPostInit( "musha_rp3", SW_DLC2_fly) AddPrefabPostInit( "musha_rp4", SW_DLC2_fly) AddPrefabPostInit( "musha_rp5", SW_DLC2_fly) AddPrefabPostInit( "musha_rp6", SW_DLC2_fly) AddPrefabPostInit( "musha_rp7", SW_DLC2_fly) AddPrefabPostInit( "musha_rpice", SW_DLC2_fly)

end]]

if extraequipslot == 1 then
ACTIONS.RUMMAGE.strfn = function(act)
    local targ = act.target or act.invobject
    return targ ~= nil
        and (   targ.replica.container ~= nil and
                targ.replica.container:IsOpenedBy(act.doer) and
                "CLOSE" or
                (   act.target ~= nil and
                    act.target:HasTag("winter_tree") and
                    "DECORATE"
                ) or
                (   act.target ~= nil and
                    act.target:HasTag("musha_items") 
                )
            )
        or nil
end
end
  
   
   function mushaa_armor(inst)
    if IsServer then
    inst:AddComponent("container")
	inst.components.container:WidgetSetup("mushaa")
	inst.components.container.onopenfn = OnOpen
	inst.components.container.onclosefn = OnClose
    end end	
	
	function armor_princess(inst)
    if IsServer then
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("princess")
	inst.components.container.onopenfn = OnOpen
	inst.components.container.onclosefn = OnClose
    end end	

 
   function backpack_armor_postinit(inst)
    if extraequipslot == 1 and IsServer then
        inst.components.equippable.equipslot = GLOBAL.EQUIPSLOTS.BACK or GLOBAL.EQUIPSLOTS.BODY
    end 
	end
	
	if extraequipslot == 1 then
       AddPrefabPostInit("pirateback", backpack_armor_postinit)  
	end


--share
function share_items(inst)
if IsServer then
	if share_item == 0 then
 	inst:AddComponent("characterspecific_musha")	
	inst.components.characterspecific_musha:SetOwner("musha")
	inst.components.characterspecific_musha:SetStorable(false)
	end
	if share_item == 1 then
	inst.share_item = true
	end 
 end
end
AddPrefabPostInit("mushasword_base", share_items) 
AddPrefabPostInit("mushasword", share_items)
AddPrefabPostInit("mushasword_frost", share_items)
AddPrefabPostInit("mushasword4", share_items)
AddPrefabPostInit("phoenixspear", share_items)
AddPrefabPostInit("bowm", share_items)
AddPrefabPostInit("frosthammer", share_items)

AddPrefabPostInit("hat_mbunny", share_items)
AddPrefabPostInit("hat_mbunnya", share_items)
AddPrefabPostInit("hat_mphoenix", share_items)
AddPrefabPostInit("hat_mprincess", share_items)
AddPrefabPostInit("hat_mwildcat", share_items)

AddPrefabPostInit("broken_frosthammer", share_items)
AddPrefabPostInit("armor_mushaa", share_items)
AddPrefabPostInit("armor_mushab", share_items)
AddPrefabPostInit("pirateback", share_items)

--in container
function backpack_incontainer(inst)
if IsServer then
	if in_container == 1 then
	if inst.components.inventoryitem then
	inst.components.inventoryitem.cangoincontainer = true
	end
	end
end
end
AddPrefabPostInit("backpack", backpack_incontainer)
--AddPrefabPostInit("piggyback", backpack_incontainer)
AddPrefabPostInit("icepack", backpack_incontainer)
--AddPrefabPostInit("krampus_sack", backpack_incontainer)
--AddPrefabPostInit("thatchpack", backpack_incontainer)

function musha_incontainer(inst)
if IsServer then
	if musha_in_container == 0 then
	if inst.components.inventoryitem then
	inst.components.inventoryitem.cangoincontainer = false
	end
	elseif musha_in_container == 1 then
	if inst.components.inventoryitem then
	inst.components.inventoryitem.cangoincontainer = true
	end
	end
end
end
AddPrefabPostInit("armor_mushaa", musha_incontainer)
AddPrefabPostInit("armor_mushab", musha_incontainer)
AddPrefabPostInit("broken_frosthammer", musha_incontainer)
AddPrefabPostInit("pirateback", musha_incontainer)

	---------------
--musha armor 
--[[if extraequipslot == 0 then
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "mushaa"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end

local function mushaa()
    local container =
    {
        widget =
        {
            slotpos = {},
            animbank = "ui_backpack_2x4",
            animbuild = "ui_backpack_2x4",
            pos = GLOBAL.Vector3(-5, -70, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
			type = "pack",
    }
 
	for y = 0, 3 do
    table.insert(container.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 114, 0))
    table.insert(container.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 114, 0))
end
    return container
end

params.mushaa = mushaa()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "mushaa" then
                container.type = "pack"
            end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)
AddPrefabPostInit("armor_mushaa", mushaa_armor) 
AddPrefabPostInit("broken_frosthammer", mushaa_armor) 
end]]

--musha armor with extra slot
--[[if extraequipslot == 1 then
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "mushaa"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end

local function mushaa()
    local container =
    {
        widget =
        {
            slotpos = {},
            animbank = "ui_backpack_2x4",
            animbuild = "ui_backpack_2x4",
            pos = GLOBAL.Vector3(-5, -70, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
			type = "chest",
    }
 
	for y = 0, 3 do
    table.insert(container.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 114, 0))
    table.insert(container.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 114, 0))
end
    return container
end

params.mushaa = mushaa()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "mushaa" then
                container.type = "pack"
            end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)
AddPrefabPostInit("armor_mushaa", mushaa_armor)
AddPrefabPostInit("broken_frosthammer", mushaa_armor)
end]]
--princess armor
--[[if extraequipslot == 0 then
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "princess"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end
local function princess()
    local container =
    {
        widget =
        {
            slotpos = {},
            animbank = "ui_piggyback_2x6",
            animbuild = "ui_piggyback_2x6",
            pos = GLOBAL.Vector3(-5, -50, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
        type = "pack",
    }

	for y = 0, 5 do
    table.insert(container.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 170, 0))
    table.insert(container.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 170, 0))
end
    return container
end

params.princess = princess()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "princess" then
                container.type = "pack"
            end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)
AddPrefabPostInit("armor_mushab", armor_princess)
end]]

--princess armor with extra slot 
--[[if extraequipslot == 1 then
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "princess"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end
local function princess()
    local container =
    {
        widget =
        {
            slotpos = {},
            animbank = "ui_piggyback_2x6",
            animbuild = "ui_piggyback_2x6",
            pos = GLOBAL.Vector3(-5, -50, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
        type = "chest", --"chest"
    }

	for y = 0, 5 do
    table.insert(container.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 170, 0))
    table.insert(container.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 170, 0))
end
    return container
end

params.princess = princess()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "princess" then
                container.type = "pack"
            end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)

AddPrefabPostInit("armor_mushab", armor_princess)
end]]

--small icebox1
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "frostsmall"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end
local function frostsmall()
    local container =
    {
        widget =
        {
            slotpos = {},
            animbank = "ui_backpack_2x4",
            animbuild = "ui_chest_frosthammer",
            pos = GLOBAL.Vector3(-5, 100, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
        type = "chest",
    }
    
	for y = 0, 1 do
		table.insert(container.widget.slotpos, GLOBAL.Vector3(-126, -y*75 + 114 ,-126 +75, -y*75 + 114 ))

end
    return container
end
params.frostsmall = frostsmall()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "frostsmall" then
                container.type = "chest"
            end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)

--[[function params.frostsmall.itemtestfn(container, item, slot)
    return not item:HasTag("heatrock") 
end]]
--------------------------------------------------

--------------------------------------------------

--box1
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "chest_yamche0"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end
local function chest_yamche0()
    local container =
    {
        widget =
        {
            slotpos = {},
            animbank = "ui_chest_3x3",
            animbuild = "ui_chest_yamche0",
            pos = GLOBAL.Vector3(0, 150, 0),
            side_align_tip = 160,
        },
        type = "chest",
    }
    for y = 1, 0, -1 do
        table.insert(container.widget.slotpos, GLOBAL.Vector3(74*y-74*2+70, 0))
 
end
    return container
end
params.chest_yamche0 = chest_yamche0()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "chest_yamche0" then
                container.type = "chest"
            end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)
---------------------------------------------------------------
--box2
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "chest_yamche1"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end
local function chest_yamche1()
    local container =
    {
        widget =
        {
            slotpos = {},
            animbank = "ui_chest_3x3",
            animbuild = "ui_chest_yamche1",
            pos = GLOBAL.Vector3(0, 150, 0),
            side_align_tip = 160,
        },
        type = "chest",
    }
 for y = 1, 0, -1 do
    for x = 0, 1 do
        table.insert(container.widget.slotpos, GLOBAL.Vector3(80*x-80*2+78, 80*y-80*2+80,0))
    end
end
    return container
end
params.chest_yamche1 = chest_yamche1()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "chest_yamche1" then
                container.type = "chest"
            end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)
---------------------------------------------------------------
--box3
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "chest_yamche2"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end
local function chest_yamche2()
    local container =
    {
        widget =
        {
            slotpos = {},
            animbank = "ui_chest_3x3",
            animbuild = "ui_chest_yamche2",
            pos = GLOBAL.Vector3(0, 180, 0),
            side_align_tip = 160,
        },
        type = "chest",
    }
		
for y = 2, 0, -1 do
    for x = 0, 1 do
        table.insert(container.widget.slotpos, GLOBAL.Vector3(80*x-76*2+78, 80*y-78*2+78,0))
    end
end
    return container
end
params.chest_yamche2 = chest_yamche2()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "chest_yamche2" then
                container.type = "chest"
        end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)
---------------------------------------------------------------
--box5
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "chest_yamche4"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end
local function chest_yamche4()
    local container =
    {
        widget =
        {
            slotpos = {},
            animbank = "ui_chest_3x3",
            animbuild = "ui_chest_3x3",
            pos = GLOBAL.Vector3(0, 180, 0),
            side_align_tip = 160,
        },
        type = "chest",
    }
for y = 3, 0, -1 do
    for x = 0, 3 do
        table.insert(container.widget.slotpos, GLOBAL.Vector3(60*x-60*2+30, 60*y-60*2+30,0))
    end
end
    return container
end
params.chest_yamche4 = chest_yamche4()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "chest_yamche4" then
                container.type = "chest"
    end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)

---------------------------------------------------------------
---------------------------------------------------------------
--box6-1
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "chest_yamche5"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end
function chest_yamche5()
    local container =
    {
        widget =
        {
            slotpos = {},
			animbank = "ui_chester_shadow_3x4",
			animbuild = "ui_chester_shadow_3x4",
            pos = GLOBAL.Vector3(0, 180, 0),
            side_align_tip = 160,
        },
        type = "chest",
    }
for y = 4, 0, -1 do
    for x = 0, 3 do
        table.insert(container.widget.slotpos, GLOBAL.Vector3(60*x-60*2+30, 60*y-60*2+2,0))
    end
end
    return container
end
params.chest_yamche5 = chest_yamche5()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "chest_yamche5" then
                container.type = "chest"
    end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)

---------------------------------------------------------------
---------------------------------------------------------------
--box7
local params = {}
local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "chest_yamche6"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end
local function chest_yamche6()
    local container =
    {
        widget =
        {
            slotpos = {},
            animbank = "ui_chest_3x3",
            animbuild = "",--"ui_chest_moon",
            pos = GLOBAL.Vector3(0, 180, 0),
            side_align_tip = 160,
        },
        type = "chest",
    }
for y = 5, 0, -1 do
    for x = 0, 14 do
        table.insert(container.widget.slotpos, GLOBAL.Vector3(60*x-60*2+-150, 60*y-60*2+10,0))
    end
end
    return container
end
params.chest_yamche6 = chest_yamche6()
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS
AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "chest_yamche6" then
                container.type = "chest"
    end end end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)

---------------------------------------------------------------
--visual

local function visual_back_musha(inst)
if avisual_Musha == "Bmm" then
inst.Bmm = true
elseif avisual_Musha == "BT" then
inst.BT = true
elseif avisual_Musha == "BS" then
inst.BS = true
elseif avisual_Musha == "BM" then
inst.BL = true
elseif avisual_Musha == "BL" then
inst.BL = true
elseif avisual_Musha == "WSP" then
inst.WSP = true
elseif avisual_Musha == "WSR" then
inst.WSR = true
elseif avisual_Musha == "WSB" then
inst.WSB = true
elseif avisual_Musha == "WSH" then
inst.WSH = true
elseif avisual_Musha == "WLR" then
inst.WLR = true
elseif avisual_Musha == "WLB" then
inst.WLB = true
end
end
AddPrefabPostInit("armor_mushaa", visual_back_musha)

local function visual_back_princess(inst)
if avisual_Princess == "Bmm" then
inst.Bmm = true
elseif avisual_Princess == "BT" then
inst.BT = true
elseif avisual_Princess == "BS" then
inst.BS = true
elseif avisual_Princess == "BM" then
inst.BL = true
elseif avisual_Princess == "BL" then
inst.BL = true
elseif avisual_Princess == "WSP" then
inst.WSP = true
elseif avisual_Princess == "WSR" then
inst.WSR = true
elseif avisual_Princess == "WSB" then
inst.WSB = true
elseif avisual_Princess == "WSH" then
inst.WSH = true
elseif avisual_Princess == "WLR" then
inst.WLR = true
elseif avisual_Princess == "WLB" then
inst.WLB = true
end
end
AddPrefabPostInit("armor_mushab", visual_back_princess)

local function visual_back_pirate(inst)
if avisual_Pirate == "Bmm" then
inst.Bmm = true
elseif avisual_Pirate == "BT" then
inst.BT = true
elseif avisual_Pirate == "BS" then
inst.BS = true
elseif avisual_Pirate == "BM" then
inst.BL = true
elseif avisual_Pirate == "BL" then
inst.BL = true
elseif avisual_Pirate == "WSP" then
inst.WSP = true
elseif avisual_Pirate == "WSR" then
inst.WSR = true
elseif avisual_Pirate == "WSB" then
inst.WSB = true
elseif avisual_Pirate == "WSH" then
inst.WSH = true
elseif avisual_Pirate == "WLR" then
inst.WLR = true
elseif avisual_Pirate == "WLB" then
inst.WLB = true
end
end
AddPrefabPostInit("pirateback", visual_back_pirate)


local function visual_armor_pirate(inst)
if avisual_Pirate_Armor == "pirate" then
inst.Pirate = true
elseif avisual_Pirate_Armor == "green" then
inst.Green = true
elseif avisual_Pirate_Armor == "pink" then
inst.Pink = true
elseif avisual_Pirate_Armor == "blue" then
inst.Blue = true
elseif avisual_Pirate_Armor == "chest" then
inst.Chest = true
end
end
AddPrefabPostInit("pirateback", visual_armor_pirate)


local function frostarmor_shield(inst)
if butterfly_shield == 2 then
inst.no_butterfly_shield = true

end
end
AddPrefabPostInit("broken_frosthammer", frostarmor_shield)
