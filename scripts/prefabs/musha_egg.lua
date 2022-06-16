require "prefabutil"
local assets=
{
	Asset("ANIM", "anim/musha_egg.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_egg.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_egg.tex"),
	Asset("IMAGE", "images/inventoryimages/musha_egg_cracked.tex"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cracked.xml"),
	Asset("ATLAS", "images/inventoryimages/musha_egg_cooked.xml"),

}
local prefabs = 
{
	"musha_small",
	"musha_egg_cracked",
}
local loot_hot = 
{
  --  "musha_egg",
}

local loot_cold = 
{
  --  "musha_egg",
}
----------------
local function Activateicon(inst)
local minimap = TheWorld.minimap.MiniMap
 
	minimap:DrawForgottenFogOfWar(true)
	if not inst.components.maprevealer then
		inst:AddComponent("maprevealer")
	end
	inst.components.maprevealer.revealperiod = 1
	inst.components.maprevealer:Start()
		
end
local function green_apple(inst)
inst:DoTaskInTime( 1, function() 
local apple = SpawnPrefab("green_apple_plant")
apple.Transform:SetPosition(inst:GetPosition():Get()) 
SpawnPrefab("pine_needles").Transform:SetPosition(apple:GetPosition():Get()) 
apple.AnimState:PlayAnimation("grow") end)
end

local function Hatch(inst)
    local yamchebird = SpawnPrefab("musha_small")
    yamchebird.Transform:SetPosition(inst.Transform:GetWorldPosition())
    yamchebird.sg:GoToState("hatch")
	if not inst.cooking_born then
	green_apple(inst)
	end
    inst:Remove()
end

local function CheckHatch(inst)
    --print("tallbirdegg - CheckHatch")
    if inst.components.hatchable.state == "hatch" then
        Hatch(inst)
    end
end

local function PlayUncomfySound(inst)
    inst.SoundEmitter:KillSound("uncomfy")
    if inst.components.hatchable.toohot then
        inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hot_steam_LP", "uncomfy")
    elseif inst.components.hatchable.toocold then
        inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_cold_shiver_LP", "uncomfy")
    end
end

local function OnNear(inst)
    if inst.components.playerprox ~= nil and
        inst.components.playerprox:IsPlayerClose() and
        inst.components.hatchable.state == "hatch" and
        not inst.components.inventoryitem:IsHeld() then
        Hatch(inst)
    end
     --CheckHatch(inst)
end
local function OnFar(inst)
 
end

local function OnDropped(inst)
    inst.components.hatchable:StartUpdating()
    CheckHatch(inst)
	inst.holding = false
    PlayUncomfySound(inst)
	inst.Light:Enable(true)
end

local function OnPutInInventory(inst)
    inst.components.hatchable:StopUpdating()
    inst.SoundEmitter:KillSound("uncomfy")
	inst.holding = true
	inst.Light:Enable(false)
end

local function OnPutInInventory_hatched(inst)
    inst.components.hatchable:StartUpdating()
    inst.SoundEmitter:KillSound("uncomfy")
	inst.holding = true
	inst.Light:Enable(false)
end

local function OnLoadPostPass(inst)
    --V2C: in case of load order of hatchable and inventoryitem components
    if inst.components.inventoryitem:IsHeld() then
        OnPutInInventory(inst)
    end
end

local function GetStatus(inst)
    if inst.components.hatchable ~= nil and inst.components.hatchable.state == "uncomfy" then
        return (inst.components.hatchable.toohot and "HOT")
            or (inst.components.hatchable.toocold and "COLD")
            or nil
    end
end

local function DropLoot(inst)
     
    inst:AddComponent("lootdropper")
    if inst.components.hatchable.toohot then

        inst.components.lootdropper:SetLoot(loot_hot)
    else
        inst.components.lootdropper:SetLoot(loot_cold)
    end
    inst.components.lootdropper:DropLoot()
end

local function OnHatchState(inst, state)
    --print("tallbirdegg - OnHatchState", state)

    inst.SoundEmitter:KillSound("uncomfy")

    if state == "crack" then
        local cracked = SpawnPrefab("musha_egg_cracked")
        cracked.Transform:SetPosition(inst.Transform:GetWorldPosition())
        cracked.AnimState:PlayAnimation("crack")
        cracked.AnimState:PushAnimation("idle_happy", true)
        cracked.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hatch_crack")
        inst:Remove()
    elseif state == "uncomfy" then
        if inst.components.hatchable.toohot then
            inst.AnimState:PlayAnimation("idle_hot", true)
        elseif inst.components.hatchable.toocold then
            inst.AnimState:PlayAnimation("idle_cold", true)
        end
        PlayUncomfySound(inst)
    elseif state == "comfy" then
        inst.AnimState:PlayAnimation("idle_happy", true)
    elseif state == "hatch" then
        CheckHatch(inst)
    elseif state == "dead" then
        --print("   ACK! *splat*")
        if inst.components.hatchable.toohot then
            inst.SoundEmitter:PlaySound("dontstarve/creatures/egg/egg_hot_jump")
            inst:DoTaskInTime(20*FRAMES, PlaySound, "dontstarve/creatures/egg/egg_hot_explo")
            inst:DoTaskInTime(20*FRAMES, DropLoot)
            inst.AnimState:PlayAnimation("toohot")
        elseif inst.components.hatchable.toocold then
            inst:DoTaskInTime(15*FRAMES, PlaySound, "dontstarve/creatures/egg/egg_cold_freeze")
            inst:DoTaskInTime(30*FRAMES, DropLoot)
            inst.AnimState:PlayAnimation("toocold")
        end

        inst.components.inventoryitem.canbepickedup = false
        inst.persists = false
        inst:ListenForEvent("animover", inst.Remove)
    end
end
-----

local function commonfn(anim, withsound, cookable)
local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    if withsound then
        inst.entity:AddSoundEmitter()
    end
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("musha_egg")
    inst.AnimState:SetBank("egg")
    inst.AnimState:PlayAnimation("egg")
	
	inst.entity:AddLight()
	inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(150/255, 150/255, 150/255)
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	inst.Light:Enable(true)
	
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_egg.tex" )
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	
	if cookable then
        --cookable (from cookable component) added to pristine state for optimization
        inst:AddTag("cookable")
    end
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

	if cookable then
		inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_egg.xml"
        inst:AddComponent("cookable")
        inst.components.cookable.product = "musha_egg_cooked"
    end
	
	inst:AddComponent("characterspecific_musha")	
	inst.components.characterspecific_musha:SetOwner("musha")
	inst.components.characterspecific_musha:SetStorable(false)
	
    return inst
end

local function defaultfn(anim)
	local inst = commonfn(anim, true, true)
		
 	if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("hatchable")
    inst.components.hatchable:SetOnState(OnHatchState)
    inst.components.hatchable:SetCrackTime(10)
    inst.components.hatchable:SetHatchTime(10)
    inst.components.hatchable:SetHatchFailTime(TUNING.SMALLBIRD_HATCH_TIME * 900000000000)
    inst.components.hatchable:SetHeaterPrefs(false, nil, true)
	inst.components.hatchable:StartUpdating()
	
	inst:AddComponent("characterspecific_musha")	
	inst.components.characterspecific_musha:SetOwner("musha")
	inst.components.characterspecific_musha:SetStorable(false)

    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)

    inst.components.inspectable.getstatus = GetStatus

    inst.OnLoadPostPass = OnLoadPostPass
 
	inst.activatetask = inst:DoTaskInTime(0.1, Activateicon)
	
	return inst
end

local function normalfn()
	return defaultfn("egg")
	
end

local function crackedfn()
   local inst = defaultfn("idle_happy")

    if not TheWorld.ismastersim then
        return inst
    end

	--[[if inst.components.cookable then
	inst:RemoveTag("cookable")
    inst:RemoveComponent("cookable")
    end]]
	
    inst.components.hatchable.state = "comfy"

	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_egg_cracked.xml"
	
	inst.components.hatchable:StartUpdating()
	
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(6, 6)
    inst.components.playerprox:SetOnPlayerNear(OnNear)
    --inst.components.playerprox:SetOnPlayerFar(OnFar)
	
    return inst
end

local function cookedfn()
	local inst = commonfn("idle_happy", true, true)
  
    if not TheWorld.ismastersim then
        return inst
    end

	inst.cooking_born = true
	
	inst:AddComponent("hatchable")
    inst.components.hatchable:SetOnState(OnHatchState)
    inst.components.hatchable:SetCrackTime(10)
    inst.components.hatchable:SetHatchTime(10)
    inst.components.hatchable:SetHatchFailTime(TUNING.SMALLBIRD_HATCH_TIME * 9999999999999999999)
    inst.components.hatchable:SetHeaterPrefs(false, nil, true)
	inst.components.hatchable:StartUpdating()
	
	inst:AddComponent("characterspecific_musha")	
	inst.components.characterspecific_musha:SetOwner("musha")
	inst.components.characterspecific_musha:SetStorable(false)

    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory_hatched)

    inst.components.inspectable.getstatus = GetStatus

    inst.OnLoadPostPass = OnLoadPostPass
 
	
    inst.components.hatchable.state = "comfy"

	inst.components.inventoryitem:ChangeImageName("musha_egg_cracked")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_egg_cracked.xml"
	
	inst.components.hatchable:StartUpdating()
	
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(6, 6)
    inst.components.playerprox:SetOnPlayerNear(OnNear)
    --inst.components.playerprox:SetOnPlayerFar(OnFar)

inst:DoTaskInTime( 1, function() 
inst.components.hatchable.state = "hatch"
CheckHatch(inst) end)
	
	return inst
end

return Prefab( "common/inventory/musha_egg", normalfn, assets, prefabs),
		Prefab( "common/inventory/musha_egg_cracked", crackedfn, assets),
		Prefab("musha_egg_cooked", cookedfn, assets)
