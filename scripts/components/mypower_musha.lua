local Mypower_musha = Class(function(self, inst)
    self.inst = inst
	--inst:DoTaskInTime(0, function() self:Start() end)
end)

-----------------------------------------------------------------

function Mypower_musha:Boook()
self.inst.AnimState:PushAnimation("mime3", false)
local x,y,z = self.inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, 25)
for k,v in pairs(ents) do
if v ~= nil and v.components.health ~= nil and v.components.combat ~= nil and not v.components.health:IsDead() and v.entity:IsVisible() --[[and (v.components.combat.target == self.inst or v:HasTag("monster") or v:HasTag("werepig") or v:HasTag("frog"))]] and not v:HasTag("player") and not v:HasTag("companion") and not v:HasTag("stalkerminion") and not v:HasTag("smashable") and not v:HasTag("alignwall") and not v:HasTag("shadowminion") and not v:HasTag("groundspike") and not v:HasTag("balloon") and not v:HasTag("wall") then 
	self.inst.active_skill = false
	
			local fx = SpawnPrefab("lantern_winter_fx_held2")
			local follower = fx.entity:AddFollower()
			if not v:HasTag("cavedweller") then
			follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -450, 0.5 )
			else
			follower:FollowSymbol(v.GUID, "body", 0, -450, 0.5 )
			end
			follower:FollowSymbol(self.inst.GUID, "body", 0, -450, 0.5 )
		
	v:DoTaskInTime(1, function() 

	if v ~= nil and v.components.freezable and not v:HasTag("player") and not v:HasTag("yamcheb") and not v:HasTag("critter") then
			v.components.freezable:SpawnShatterFX()

			
			if self.inst.level < 430 then
			--self.inst.components.spellpower:DoDelta(-5)
			v.components.freezable:AddColdness(2)
			self.inst.components.talker:Say("Freeze Level 1")
			elseif self.inst.level >= 430 and self.inst.level < 1880 then
			--self.inst.components.spellpower:DoDelta(-4)
			v.components.freezable:AddColdness(3)
			self.inst.components.talker:Say("Freeze Level 2")
			elseif self.inst.level >= 1880 and self.inst.level < 7000 then
			--self.inst.components.spellpower:DoDelta(-3)
			v.components.freezable:AddColdness(4)
			self.inst.components.talker:Say("Freeze Level 3")
			elseif self.inst.level >= 7000 then
			--self.inst.components.spellpower:DoDelta(-2)
			v.components.freezable:AddColdness(5)
			self.inst.components.talker:Say("Freeze Level 4")
			end

			if not v:HasTag("cavedweller") then
			follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -450, 0.5 )
			else
			follower:FollowSymbol(v.GUID, "body", 0, -450, 0.5 )
			end
	end	
	if v.components.burnable ~= nil and v.components.burnable:IsBurning() then
        v.components.burnable:Extinguish()
	end	
	end)

end 
end
end

--[[function Mypower_musha:Boook()
self.inst.AnimState:PushAnimation("mime3", false)
self.inst.components.spellpower:DoDelta(-20)
local x,y,z = self.inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, 18)
for k,v in pairs(ents) do
if v ~=nil and v.components.health and not v.components.health:IsDead() and v.entity:IsVisible() and v.components.combat and (v.components.combat.target == self.inst or v:HasTag("monster") or v:HasTag("werepig") or v:HasTag("frog")) and not v:HasTag("player") and not v:HasTag("companion") and not v:HasTag("stalkerminion") and not v:HasTag("smashable") and not v:HasTag("alignwall") and not v:HasTag("shadowminion") then 

	self.inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if self.inst.loud_2 or self.inst.loud_3 then
	SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
	else
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	end
			local fx = SpawnPrefab("firesplash_fx")
			fx.Transform:SetScale(0.5, 0.5, 0.5)
			fx.Transform:SetPosition(v:GetPosition():Get())
			local fx2 = SpawnPrefab("firesplash_fx")
			fx2.Transform:SetScale(0.5, 0.5, 0.5)
			fx2.Transform:SetPosition(self.inst:GetPosition():Get())
	
	if v.components.locomotor and not v:HasTag("ghost") then
        v.components.locomotor:StopMoving()
		if v:HasTag("spider") and not v:HasTag("spiderqueen") then
			v.sg:GoToState("hit_stunlock")
		else
			v.sg:GoToState("hit")
		end
	end
	local fx_2 = SpawnPrefab("groundpoundring_fx")
		fx_2.Transform:SetScale(0.4, 0.4, 0.4)
		fx_2.Transform:SetPosition(self.inst:GetPosition():Get())
	  
	v:DoTaskInTime(0.3, function() 
	SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())  
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.4, function() 
	local fx_3 = SpawnPrefab("groundpoundring_fx")
		fx_3.Transform:SetScale(0.3, 0.3, 0.3)
		fx_3.Transform:SetPosition(v:GetPosition():Get())
	  end)
			v.slow = true 
			if not v:HasTag("slow") then
			v:AddTag("slow") 
			end
		
	if v.components.combat and not v:HasTag("companion") then
        v.components.combat:SuggestTarget(self.inst)
    end
	v.burn = false v.bloom = false 
	v:RemoveTag("burn")
		if not v:HasTag("lightninggoat") then
		v.AnimState:SetBloomEffectHandle( "" ) 
		v.bloom = false 
		end

	if v:HasTag("slow") then
	
		local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	
		
		if not v.shocked then
		v.components.health:DoDelta(-40)
		v.shocked = true
		elseif v.shocked then
		SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
		v.components.health:DoDelta(-70)
		v.shocked = false
		end
	
	
		local debuff = SpawnPrefab("debuff_short")
		debuff.Transform:SetPosition(v:GetPosition():Get())
		if debuff and v:HasTag("slow") then
		local follower = debuff.entity:AddFollower()
		if not v:HasTag("cavedweller") then
			follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5 )
			else
			follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5 )
			end
		TheWorld:DoPeriodicTask(2, function() 
		if v:HasTag("slow") and v.components.health and not v.components.health:IsDead() then 
			
			SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())
			v.components.health:DoDelta(-10)

		end	
		end)
		end	
		TheWorld:DoTaskInTime(15, function() if v.components.locomotor then v.components.locomotor.groundspeedmultiplier = 1 v.slow = false v:RemoveTag("slow") debuff:Remove() end end)
	elseif not v:HasTag("slow")	then
	v:AddTag("burn")	
	end
	end)
end 
end
end]]

--smite
function Mypower_musha:Lightning(victim)
local weapon = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if weapon and weapon.components.weapon then
	if victim and self.inst:HasTag("musha") and (victim.components.health and not victim.components.health:IsDead()) and self.inst.components.spellpower and self.inst.components.spellpower.current >=5 then

	if not victim:HasTag("alignwall") and not victim:HasTag("stalkerminion") and not victim:HasTag("smashable") and not victim:HasTag("alignwall") and not victim:HasTag("shadowminion") then 
	
	self.inst.components.spellpower:DoDelta(-3)
	--self.inst.components.fatigue_sleep:DoDelta(2)
	
	--[[if self.inst.loud_2 or self.inst.loud_3 then
	SpawnPrefab("lightning").Transform:SetPosition(victim:GetPosition():Get())
	else
	SpawnPrefab("lightning2").Transform:SetPosition(victim:GetPosition():Get())
	end]]
	
	local fx_3 = SpawnPrefab("groundpoundring_fx")
	fx_3.Transform:SetScale(0.7, 0.7, 0.7)
	fx_3.Transform:SetPosition(victim:GetPosition():Get())
	  
	  SpawnPrefab("explode_small").Transform:SetPosition(victim:GetPosition():Get())
		end 
		
		local shocking2 = SpawnPrefab("musha_spin_fx")	
		shocking2.Transform:SetPosition(self.inst:GetPosition():Get())
		if shocking2 then
		local follower = shocking2.entity:AddFollower()
		follower:FollowSymbol(self.inst.GUID, self.inst.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	
		
		if self.inst.fire then
			local fx = SpawnPrefab("firesplash_fx")
			fx.Transform:SetScale(0.5, 0.5, 0.5)
			fx.Transform:SetPosition(victim:GetPosition():Get())
			local fx2 = SpawnPrefab("firesplash_fx")
			fx2.Transform:SetScale(0.5, 0.5, 0.5)
			fx2.Transform:SetPosition(self.inst:GetPosition():Get())
			if victim.components.burnable then
			victim.components.burnable:Ignite()
			victim.components.health:DoDelta(-100)
			else
			victim.components.health:DoDelta(-40)
			end

		elseif self.inst.frost then	
			if victim ~= nil and victim.components.freezable then
			victim.components.freezable:AddColdness(2)
			victim.components.freezable:SpawnShatterFX()
			local prefab = "icespike_fx_"..math.random(1,4)
			local fx = SpawnPrefab(prefab)
			local shards = math.random(0.8,1.2)
			fx.Transform:SetScale(shards, shards, shards)
			fx.Transform:SetPosition(victim:GetPosition():Get())
			victim.components.health:DoDelta(-40)
			else
			local prefab = "icespike_fx_"..math.random(1,4)
			local fx = SpawnPrefab(prefab)
			local shards = math.random(0.8,1.2)
			fx.Transform:SetScale(shards, shards, shards)
			fx.Transform:SetPosition(victim:GetPosition():Get())
			victim.components.health:DoDelta(-40)
			end	
		else
			victim.components.health:DoDelta(-40)
		end
		if victim.components.burnable and victim.components.burnable:IsBurning() then
        victim.components.burnable:Extinguish()
		end

		
		if not self.inst.berserk then
		self.inst.components.combat:SetAreaDamage(0, 0)
		end
	end
end
end


--[[function Mypower_musha:Start()
end]]

return Mypower_musha