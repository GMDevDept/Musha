local assets =
{
	Asset( "ANIM", "anim/splash_water_drop.zip" ),
}
--compatible with sw mod
local function fnsplash_water_drop(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()

    anim:SetBuild("splash_water_drop")
   	anim:SetBank( "splash_water_drop" )

	anim:PlayAnimation( "idle" ) 
	    inst.entity:AddNetwork()

	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent( "animover", function(inst) inst:Remove() end )

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({0,0,0,0}, FRAMES*20)

    return inst
end

return Prefab( "splash_water_drop", fnsplash_water_drop, assets )

