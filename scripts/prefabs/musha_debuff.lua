local assets =
{
	Asset("ANIM", "anim/field_check.zip"),
	Asset("ANIM", "anim/sleep_debuff_30.zip"),
	Asset("ANIM", "anim/sleep_debuff_50.zip"),
	Asset("ANIM", "anim/sleep_debuff_70.zip"),
	Asset("ANIM", "anim/sleep_debuff_90.zip"),
	Asset("ANIM", "anim/tired_debuff_30.zip"),
	Asset("ANIM", "anim/tired_debuff_50.zip"),
	Asset("ANIM", "anim/tired_debuff_70.zip"),
	Asset("ANIM", "anim/tired_debuff_90.zip"),
	Asset("ANIM", "anim/sporecloud2.zip"),
}


local FADE_FRAMES = 5
local FADE_INTENSITY = .8
local FADE_RADIUS = 1
local FADE_FALLOFF = .5


local function OnUpdateFade(inst)
    local k
    if inst._fade:value() <= FADE_FRAMES then
        inst._fade:set_local(math.min(inst._fade:value() + 1, FADE_FRAMES))
        k = inst._fade:value() / FADE_FRAMES
    else
        inst._fade:set_local(math.min(inst._fade:value() + 1, FADE_FRAMES * 2 + 1))
        k = (FADE_FRAMES * 2 + 1 - inst._fade:value()) / FADE_FRAMES
    end

    if inst._fade:value() == FADE_FRAMES or inst._fade:value() > FADE_FRAMES * 2 then
        inst._fadetask:Cancel()
        inst._fadetask = nil
    end
end

local function OnFadeDirty(inst)
    if inst._fadetask == nil then
        inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
    end
    OnUpdateFade(inst)
end

local function FadeOut(inst)
   local parent = inst.entity:GetParent()
    if parent ~= nil then
			local fx = SpawnPrefab("statue_transition_2")
			fx.Transform:SetScale(0.5, 0.5, 0.5)
			fx.Transform:SetPosition(inst:GetPosition():Get())
			inst:Remove()
	end	
end

local function field_check()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") inst:AddTag("field_check")
	 
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("field_check")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:SetLightOverride(.1)
    --inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    --inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(0.6,0.6,0.6)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)
        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	
	inst:DoTaskInTime(6, function() FadeOut(inst) end)

	inst.FadeOut_kill = inst:DoPeriodicTask(.5, function() 
	local parent = inst.entity:GetParent()
    if parent ~= nil and parent.field_check_on then
			parent.field_check_on = false
			inst:Remove()
	end
	end	)
	
	return inst
end

local function fadeout_sleep(inst)
 local parent = inst.entity:GetParent()
	if parent ~= nil then
	if parent.sleep_debuff_reset then 
		parent.sleep_debuff_90 = false
		parent.sleep_debuff_70 = false
		parent.sleep_debuff_50 = false
		parent.sleep_debuff_30 = false
		local fx = SpawnPrefab("statue_transition_2")
		fx.Transform:SetScale(0.35, 0.35, 0.35)
		fx.Transform:SetPosition(inst:GetPosition():Get())
		inst:Remove()
	elseif parent.sleep_debuff_90 then
		if not inst:HasTag("sleep_90") then
		inst:Remove()
		end
	elseif parent.sleep_debuff_70 then	
		if not inst:HasTag("sleep_70") then
		inst:Remove()
		end
	elseif parent.sleep_debuff_50 then	
		if not inst:HasTag("sleep_50") then
		inst:Remove()
		end	
	elseif parent.sleep_debuff_30 then	
		if not inst:HasTag("sleep_30") then
		inst:Remove()
		end	
	end
	end 
end
local function fadeout_tired(inst)
 local parent = inst.entity:GetParent()
    if parent ~= nil then
	if parent.tired_debuff_reset then 
		parent.tired_debuff_90 = false
		parent.tired_debuff_70 = false
		parent.tired_debuff_50 = false
		parent.tired_debuff_30 = false
		inst:Remove()
	elseif parent.tired_debuff_90 then
		if not inst:HasTag("tired_90") then
		inst:Remove()
		end
	elseif parent.tired_debuff_70 then	
		if not inst:HasTag("tired_70") then
		inst:Remove()
		end
	elseif parent.tired_debuff_50 then	
		if not inst:HasTag("tired_50") then
		inst:Remove()
		end	
	elseif parent.tired_debuff_30 then	
		if not inst:HasTag("tired_30") then
		inst:Remove()
		end	
	end
	end 
end
local function fadeout_poison(inst)
 local parent = inst.entity:GetParent()
    if parent ~= nil then
	if not parent.poison_sneaka then 
	local fx = SpawnPrefab("statue_transition_2")
		fx.Transform:SetScale(0.5, 0.5, 0.5)
		fx.Transform:SetPosition(inst:GetPosition():Get())
		inst:Remove()
	end	
	end
end 

local function vadabomb(inst, data)
    
	local parent = inst.entity:GetParent()
    if parent ~= nil then
        if parent.components.health and not parent.components.health:IsDead() then	
			--parent.components.health:DoDelta(-60)
		if parent.components.sleeper then
           parent.components.sleeper:AddSleepiness(1, 15, parent)
		end
		 local cloud = SpawnPrefab("sporecloud2")
			cloud.Transform:SetPosition(parent:GetPosition():Get())
			cloud:FadeInImmediately()
	end
	end
    
	local fx = SpawnPrefab("statue_transition_2")
		fx.Transform:SetScale(1, 1, 1)
		fx.Transform:SetPosition(inst:GetPosition():Get())
	inst:Remove()
end


local function shadowbomb()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") 	 
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("sporebomb")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:SetLightOverride(.3)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(0.8,0.8,0.8)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)
        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	
	inst:DoTaskInTime(6, vadabomb)
	
	return inst
end

local function shadowbomb_r()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") 	 
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("sporebomb")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:SetLightOverride(.3)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(0.8,0.8,0.8)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)
        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	inst:DoPeriodicTask(0.5, function()
	fadeout_poison(inst) end)
	
	return inst
end

local function sleep_90()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") inst:AddTag("sleep_90")
	 
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("sleep_debuff_90")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    --inst.AnimState:SetLightOverride(.3)
    --inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(0.6,0.6,0.6)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)
  
        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	inst:DoPeriodicTask(1, function()
	fadeout_sleep(inst) end)
	
	return inst
end

local function sleep_70()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") inst:AddTag("sleep_70")

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("sleep_debuff_70")
    --inst.AnimState:PlayAnimation("sporebomb_pre")
    --inst.AnimState:SetLightOverride(.3)
    --inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(0.65,0.65,0.65)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)
  
        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	inst:DoPeriodicTask(1, function()
	fadeout_sleep(inst) end)	
	
	return inst
end

local function sleep_50()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") inst:AddTag("sleep_50")

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("sleep_debuff_50")
    --inst.AnimState:PlayAnimation("sporebomb_pre")
    --inst.AnimState:SetLightOverride(.3)
    --inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(0.7,0.7,0.7)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)
  
        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	inst:DoPeriodicTask(1, function()
	fadeout_sleep(inst) end)	
	
	return inst
end
local function sleep_30()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") inst:AddTag("sleep_30")

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("sleep_debuff_30")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:SetLightOverride(.3)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(0.75,0.75,0.75)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)
  
        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	inst:DoPeriodicTask(1, function()
	fadeout_sleep(inst) end)	
	
	return inst
end

local function tired_90()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") inst:AddTag("tired_90")

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("tired_debuff_90")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:SetLightOverride(.3)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(1,1,1)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)

        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	inst:DoPeriodicTask(1, function()
	fadeout_tired(inst) end)

	return inst
end

local function tired_70()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") inst:AddTag("tired_70")

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("tired_debuff_70")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:SetLightOverride(.3)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(1,1,1)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)
  
        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	inst:DoPeriodicTask(1, function()
	fadeout_tired(inst) end)
	
	return inst
end

local function tired_50()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") inst:AddTag("tired_50")

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("tired_debuff_50")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:SetLightOverride(.3)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(1,1,1)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)
  
        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	inst:DoPeriodicTask(1, function()
	fadeout_tired(inst) end)
	
	return inst
end
local function tired_30()

	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddFollower()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK") inst:AddTag("tired_30")

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("tired_debuff_30")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:SetLightOverride(.3)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

	inst.Transform:SetScale(1,1,1)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
	 inst:ListenForEvent("fadedirty", OnFadeDirty)
  
        return inst
    end
	
	inst.AnimState:PushAnimation("sporebomb_loop")
	inst:DoPeriodicTask(1, function()
	fadeout_tired(inst) end)
	
	return inst
end

return  --Prefab("sleep_debuff_90", sleep_90, assets),
		--Prefab("sleep_debuff_70", sleep_70, assets),
		--Prefab("sleep_debuff_50", sleep_50, assets),
		--Prefab("sleep_debuff_30", sleep_30, assets),
		
		Prefab("tired_debuff_90", tired_90, assets),
		Prefab("tired_debuff_70", tired_70, assets),
		Prefab("tired_debuff_50", tired_50, assets),
		Prefab("tired_debuff_30", tired_30, assets),
		
		Prefab("shadowbomb_r", shadowbomb_r, assets),
		Prefab("shadowbomb", shadowbomb, assets),
		
		Prefab("field_check", field_check, assets)
