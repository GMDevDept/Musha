
---adds state



--[[
local FRAMES = GLOBAL.FRAMES
local TimeEvent = GLOBAL.TimeEvent
local EventHandler = GLOBAL.EventHandler
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
]]
-------------------------------------------------
local function DoMountSound(inst, mount, sound, ispredicted)
    if mount ~= nil and mount.sounds ~= nil then
        inst.SoundEmitter:PlaySound(mount.sounds[sound], nil, nil, ispredicted)
    end
end

local function DoTalkSound(inst)
    if inst.talksoundoverride ~= nil then
        inst.SoundEmitter:PlaySound(inst.talksoundoverride, "talk")
        return true
    elseif not inst:HasTag("mime") and not inst.keep_check then
        inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/talk_LP", "talk")
        return true
    end
end
local function StopTalkSound(inst, instant)
    if not instant and inst.endtalksound ~= nil and inst.SoundEmitter:PlayingSound("talk") then
        inst.SoundEmitter:PlaySound(inst.endtalksound)
    end
    inst.SoundEmitter:KillSound("talk")
end
-------------------------------------------------

--[[
local idle = GLOBAL.State(
{name = "idle",
        tags = { "idle", "canrotate" },

        onenter = function(inst, pushanim)
            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()

            inst.sg.statemem.ignoresandstorm = true

            if inst.components.rider:IsRiding() then
                inst.sg:GoToState("mounted_idle", pushanim)
                return
            end

            local equippedArmor = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
            if equippedArmor ~= nil and equippedArmor:HasTag("band") then
                inst.sg:GoToState("enter_onemanband", pushanim)
                return
            end

            local anims = {}
            local dofunny = true

            if inst:HasTag("beaver") then
                if inst:HasTag("groggy") then
                    table.insert(anims, "idle_groggy_pre")
                    table.insert(anims, "idle_groggy")
                else
                    table.insert(anims, "idle_loop")
                end
                dofunny = false
            elseif inst.components.inventory:IsHeavyLifting() then
                table.insert(anims, "heavy_idle")
                dofunny = false
            else
                inst.sg.statemem.ignoresandstorm = false
                if inst:GetSandstormLevel() >= TUNING.SANDSTORM_FULL_LEVEL
                    and not inst.components.playervision:HasGoggleVision() then
                    if not (inst.AnimState:IsCurrentAnimation("sand_walk_pst") or
                            inst.AnimState:IsCurrentAnimation("sand_walk") or
                            inst.AnimState:IsCurrentAnimation("sand_walk_pre")) then
                        table.insert(anims, "sand_idle_pre")
                    end
                    table.insert(anims, "sand_idle_loop")
                    inst.sg.statemem.sandstorm = true
                    dofunny = false
                elseif not inst.components.sanity:IsSane() then
                    table.insert(anims, "idle_sanity_pre")
                    table.insert(anims, "idle_sanity_loop")
                elseif inst.components.temperature:IsFreezing() then
                    table.insert(anims, "idle_shiver_pre")
                    table.insert(anims, "idle_shiver_loop")
                elseif inst.components.temperature:IsOverheating() then
                    table.insert(anims, "idle_hot_pre")
                    table.insert(anims, "idle_hot_loop")
                    dofunny = false
                elseif inst:HasTag("groggy") then
                    table.insert(anims, "idle_groggy_pre")
                    table.insert(anims, "idle_groggy")
				elseif inst.groggy3 then
                    table.insert(anims, "idle_groggy_pre")
                    table.insert(anims, "idle_groggy")	

                else
                    table.insert(anims, "idle_loop")
                end
            end

            if pushanim then
                for k, v in pairs(anims) do
                    inst.AnimState:PushAnimation(v, k == #anims)
                end
            else
                inst.AnimState:PlayAnimation(anims[1], #anims == 1)
                for k, v in pairs(anims) do
                    if k > 1 then
                        inst.AnimState:PushAnimation(v, k == #anims)
                    end
                end
            end

            if dofunny then
                inst.sg:SetTimeout(math.random() * 4 + 2)
            end
        end,

        events =
        {
            EventHandler("sandstormlevel", function(inst, data)
                if not inst.sg.statemem.ignoresandstorm then
                    if data.level < TUNING.SANDSTORM_FULL_LEVEL then
                        if inst.sg.statemem.sandstorm then
                            inst.sg:GoToState("idle")
                        end
                    elseif not (inst.sg.statemem.sandstorm or inst.components.playervision:HasGoggleVision()) then
                        inst.sg:GoToState("idle")
                    end
                end
            end),
        },

        ontimeout = function(inst)
            local royalty = nil
            local mindistsq = 25
            for i, v in ipairs(AllPlayers) do
                if v ~= inst and
                    not v:HasTag("playerghost") and
                    v.entity:IsVisible() and
                    v.components.inventory:EquipHasTag("regal") then
                    local distsq = v:GetDistanceSqToInst(inst)
                    if distsq < mindistsq then
                        mindistsq = distsq
                        royalty = v
                    end
                end
            end
            if royalty ~= nil then
                inst.sg:GoToState("bow", royalty)
            else
                inst.sg:GoToState("funnyidle")
            end
        end,
    }
	)
AddStategraphState("wilson", idle)	

local funnyidle = GLOBAL.State(
{name = "funnyidle",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
            if inst.components.temperature:GetCurrent() < 5 then
                inst.AnimState:PlayAnimation("idle_shiver_pre")
                inst.AnimState:PushAnimation("idle_shiver_loop")
                inst.AnimState:PushAnimation("idle_shiver_pst", false)
            elseif inst.components.temperature:GetCurrent() > TUNING.OVERHEAT_TEMP - 10 then
                inst.AnimState:PlayAnimation("idle_hot_pre")
                inst.AnimState:PushAnimation("idle_hot_loop")
                inst.AnimState:PushAnimation("idle_hot_pst", false)
            elseif inst.components.hunger:GetPercent() < TUNING.HUNGRY_THRESH then
                inst.AnimState:PlayAnimation("hungry")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/hungry")    
            elseif inst.components.sanity:GetPercent() < .5 and not inst:HasTag("musha") then
                inst.AnimState:PlayAnimation("idle_inaction_sanity")
			elseif inst.components.sanity:GetPercent() < .1 and inst:HasTag("musha") then
                inst.AnimState:PlayAnimation("idle_inaction_sanity")	
            elseif inst:HasTag("groggy") then
                inst.AnimState:PlayAnimation("idle_groggy01_pre")
                inst.AnimState:PushAnimation("idle_groggy01_loop")
                inst.AnimState:PushAnimation("idle_groggy01_pst", false)
			 elseif inst.groggy3 then
                inst.AnimState:PlayAnimation("idle_groggy01_pre")
                inst.AnimState:PushAnimation("idle_groggy01_loop")
                inst.AnimState:PushAnimation("idle_groggy01_pst", false)	
            else
                inst.AnimState:PlayAnimation("idle_inaction")
            end
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    }
	)
AddStategraphState("wilson", funnyidle)	
]]

----------------------------
--[[local mtalk = GLOBAL.State(

{name = "talk",
        tags = { "idle", "talking" },

        onenter = function(inst, noanim)
			if not noanim and inst.keep_check and inst:HasTag("musha") then
			for k = 1, math.random(2, 3) do
                local aname = "mime" .. tostring(math.random(7))
                if k == 1 then
                    inst.AnimState:PlayAnimation(aname, false)
                else
                    inst.AnimState:PushAnimation(aname, false)
                end
            end
       
            elseif not noanim and not inst.keep_check then
                inst.AnimState:PlayAnimation(
                    inst.components.inventory:IsHeavyLifting() and
                    not (inst.components.rider ~= nil and inst.components.rider:IsRiding()) and
                    "heavy_dial_loop" or
                    "dial_loop",
                    true)
            end
            DoTalkSound(inst)
			if inst.keep_check then
			--inst.SoundEmitter:KillSound("talk")
			end
            inst.sg:SetTimeout(1.5 + math.random() * .5)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle")
        end,

        events =
        {
            EventHandler("donetalking", function(inst)
                inst.sg:GoToState("idle")
            end),
        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("talk")
        end,
    }
	)]]
local mtalk = GLOBAL.State(

{name = "talk",
        tags = { "idle", "talking" },

        onenter = function(inst, noanim)
			if not inst.quiet then
			if not noanim and inst.keep_check and inst:HasTag("musha") then
			for k = 1, math.random(2, 3) do
                local aname = "mime" .. tostring(math.random(7))
                if k == 1 then
                    inst.AnimState:PlayAnimation(aname, false)
                else
                    inst.AnimState:PushAnimation(aname, false)
                end
            end
       
            elseif not noanim and not inst.keep_check then
                inst.AnimState:PlayAnimation(
                    inst.components.inventory:IsHeavyLifting() and
                    not (inst.components.rider ~= nil and inst.components.rider:IsRiding()) and
                    "heavy_dial_loop" or
                    "dial_loop",
                    true)
            end
            DoTalkSound(inst)
			if inst.keep_check then
			--inst.SoundEmitter:KillSound("talk")
			end
            inst.sg:SetTimeout(1.5 + math.random() * .5)
        end
		end
		,
		

        ontimeout = function(inst)
            inst.sg:GoToState("idle")
        end,

        events =
        {
            EventHandler("donetalking", function(inst)
                inst.sg:GoToState("idle")
            end),
        },

        onexit = StopTalkSound,
    }
	)	
	
AddStategraphState("wilson", mtalk)	
	
local mrefuseeat = GLOBAL.State(
    {name = "refuseeat",
        tags = { "busy", "pausepredict" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()
            inst:ClearBufferedAction()
			inst.quiet = true

            if inst.components.rider:IsRiding() then
                inst.sg.statemem.talking = true
                inst.AnimState:PlayAnimation("dial_loop")
                DoTalkSound(inst)
                inst.sg:SetTimeout(1.5 + math.random() * .5)
            else
                inst.AnimState:PlayAnimation(inst.components.inventory:IsHeavyLifting() and "heavy_refuseeat" or "refuseeat")
                inst.sg:SetTimeout(22 * FRAMES)
            end

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
        end,

        timeline =
        {
            TimeEvent(22 * FRAMES, function(inst)
				if not inst.quiet then
                if inst.sg.statemem.talking then
                    inst.sg:RemoveStateTag("busy")
                    inst.sg:RemoveStateTag("pausepredict")
                end
				end
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
			inst.quiet = false
        end,

        onexit = StopTalkSound,
    }
	)	
	AddStategraphState("wilson", mrefuseeat)	
	
local shovel_start = GLOBAL.State(
{
        name = "dig_start",
        tags = { "predig", "working" },

        onenter = function(inst)
			local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("frost_spear") then
			inst.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear_2r", "phoenixspear")
			inst.AnimState:Show("ARM_carry") 
			inst.AnimState:Hide("ARM_normal")
			end
			
			inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("shovel_pre")
			
        end,

        events =
        {
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("dig")
                end
            end),
        },
		onexit = function(inst)
 			local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("frost_spear") then
			inst.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear2", "phoenixspear")
			inst.AnimState:Show("ARM_carry") 
			inst.AnimState:Hide("ARM_normal")
			end
        end
    }
	)
AddStategraphState("wilson", shovel_start)

local shovel = GLOBAL.State(
{
        name = "dig",
        tags = { "predig", "digging", "working" },

        onenter = function(inst)
			local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("frost_spear") then
			inst.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear_2r", "phoenixspear")
			inst.AnimState:Show("ARM_carry") 
			inst.AnimState:Hide("ARM_normal")
			end
            inst.AnimState:PlayAnimation("shovel_loop")
            inst.sg.statemem.action = inst:GetBufferedAction()
        end,

        timeline =
        {
            TimeEvent(15 * FRAMES, function(inst)
                inst:PerformBufferedAction() 
                inst.sg:RemoveStateTag("predig") 
                inst.SoundEmitter:PlaySound("dontstarve/wilson/dig")
            end),

            TimeEvent(35 * FRAMES, function(inst)
                if inst.components.playercontroller ~= nil and
                    inst.components.playercontroller:IsAnyOfControlsPressed(
                        CONTROL_SECONDARY,
                        CONTROL_ACTION,
                        CONTROL_CONTROLLER_ACTION) and
                    inst.sg.statemem.action ~= nil and
                    inst.sg.statemem.action:IsValid() and
                    inst.sg.statemem.action.target ~= nil and
                    inst.sg.statemem.action.target.components.workable ~= nil and
                    inst.sg.statemem.action.target.components.workable:CanBeWorked() and
                    inst.sg.statemem.action.target:IsActionValid(inst.sg.statemem.action.action, true) and
                    CanEntitySeeTarget(inst, inst.sg.statemem.action.target) then
                    inst:ClearBufferedAction()
                    inst:PushBufferedAction(inst.sg.statemem.action)
                end
            end),
        },

        events =
        {
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.AnimState:PlayAnimation("shovel_pst")
                    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
					if weapon and weapon:HasTag("frost_spear") then
					inst.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear2", "phoenixspear")
			inst.AnimState:Show("ARM_carry") 
			inst.AnimState:Hide("ARM_normal")
					end
					inst.sg:GoToState("idle", true)
				
                end
            end),
        },
		onexit = function(inst)
			local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("frost_spear") then
			inst.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear2", "phoenixspear")
			inst.AnimState:Show("ARM_carry") 
			inst.AnimState:Hide("ARM_normal")
			end
        end
    }
)
AddStategraphState("wilson", shovel)

local flute2 = GLOBAL.State(
{
        name = "play_flute2",
        tags = { "doing", "playing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("flute", false)
            inst.AnimState:OverrideSymbol("pan_flute01", "pan_flute", "pan_flute01")
            inst.AnimState:Hide("ARM_carry") 
            inst.AnimState:Show("ARM_normal")
            inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and inst.bufferedaction.invobject or nil)
        end,

        timeline =
        {
            TimeEvent(30*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/flute_LP", "flute")
                inst:PerformBufferedAction()
            end),
            TimeEvent(85*FRAMES, function(inst)
                inst.SoundEmitter:KillSound("flute")
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("flute")
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
        end
    }
	)
	AddStategraphState("wilson", flute2)

	
local horn2 = GLOBAL.State(
{name = "play_horn2",
        tags = { "doing", "playing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("horn", false)
            inst.AnimState:OverrideSymbol("horn01", "horn", "horn01")
            --inst.AnimState:Hide("ARM_carry") 
            inst.AnimState:Show("ARM_normal")
            inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and inst.bufferedaction.invobject or nil)
        end,

        timeline =
        {
            TimeEvent(21*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/horn_beefalo")
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
        end,
    }
	)
	AddStategraphState("wilson", horn2)
	
local peer = GLOBAL.State(
{name = "peertelescope2",
        tags = {"doing", "busy", "canrotate", "notalking"},

        onenter = function(inst)
  			local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) 
		   	   if item and item.components.equippable then
				item.components.equippable:Unequip(inst)
				end
            inst:ForceFacePoint(inst.x, inst.y, inst.z)
            inst.components.playercontroller:Enable(false)
			inst.components.health:SetInvincible(true)
			inst.components.locomotor:Stop()
			inst.AnimState:OverrideSymbol("swap_object", "swap_telescope", "swap_object")
			inst.AnimState:Show("ARM_carry") 
            inst.AnimState:Hide("ARM_normal")
			
            inst.AnimState:PlayAnimation("telescope", false)
            inst.AnimState:PushAnimation("telescope_pst", false)

        end,

        timeline = 
        {
            TimeEvent(2*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold") end),
			TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/blink") end),
        },

        onexit = function(inst)
            inst.components.playercontroller:Enable(true)
			inst.components.health:SetInvincible(false)
	           if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
				else
				inst.AnimState:Hide("ARM_carry") 
				inst.AnimState:Show("ARM_normal")
				end
        end,

        events = {
            EventHandler("animover", function(inst)
                inst:PerformBufferedAction()
            end ),
            EventHandler("animqueueover", function(inst)
   
                inst.sg:GoToState("idle")

            end ),
        },
    }
	)
AddStategraphState("wilson", peer)

local map = GLOBAL.State(
{name = "map",
        tags = {"doing", "notalking"},
        
        onenter = function(inst)
            inst.components.playercontroller:Enable(false)
			inst.components.health:SetInvincible(true)
			inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("scroll", false)
            inst.AnimState:OverrideSymbol("scroll", "messagebottle", "scroll")
            inst.AnimState:PushAnimation("scroll_pst", false)
            
            --inst.AnimState:Hide("ARM_carry") 
            inst.AnimState:Show("ARM_normal")
            if inst.components.inventory.activeitem and inst.components.inventory.activeitem.components.book then
                inst.components.inventory:ReturnActiveItem()
            end
        end,
        
        onexit = function(inst)
		 inst.components.playercontroller:Enable(true)
		 inst.components.health:SetInvincible(false)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
        end,
        
        timeline=
        {
			--TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/use_book") end)
            TimeEvent(24*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light") end),
            TimeEvent(58*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close") end),
        },
        
        events=
        {
            EventHandler("animover", function(inst)
                inst:PerformBufferedAction()
            end),


            EventHandler("animqueueover", function(inst)
                inst.sg:GoToState("idle")
            end),

            
        },
    }
	)
AddStategraphState("wilson", map)

local book2 = GLOBAL.State(
{name = "book2",
        tags = { "doing", "busy", "notalking" },

        onenter = function(inst)
		--[[if inst.components.playercontroller then
		inst.components.playercontroller:Enable(false)
		end]]
		 inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("book", true)
			--Moved to player_common because these symbols are never cleared
            --inst.AnimState:OverrideSymbol("book_open", "player_actions_uniqueitem", "book_open")
            --inst.AnimState:OverrideSymbol("book_closed", "player_actions_uniqueitem", "book_closed")
            --inst.AnimState:OverrideSymbol("book_open_pages", "player_actions_uniqueitem", "book_open_pages")
            --inst.AnimState:Hide("ARM_carry") 
            inst.AnimState:Show("ARM_normal")
            inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and (inst.bufferedaction.target or inst.bufferedaction.invobject) or nil)
		inst.sg:SetTimeout(3)   
		
				--shield --------
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 20, {"player"})
	for k,v in pairs(ents) do	
		if v ~= nil and not v:HasTag("musha") and v.components.combat and (v.components.combat.target ~= inst) and v.components.health and not v.components.health:IsDead() then
		v.components.health:SetInvincible(true)		
			
		v.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
		local fx = SpawnPrefab("forcefieldfxx")

        fx.entity:SetParent(v.entity)
		if v.components.rider ~= nil and v.components.rider:IsRiding() then
		fx.Transform:SetScale(2, 2, 2)
		else
		fx.Transform:SetScale(0.8, 0.8, 0.8)
		end
        fx.Transform:SetPosition(0, 0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
			end
        fx:ListenForEvent("blocked", fx_hitanim, v)
			v:DoTaskInTime( 11, function()
			
            fx:RemoveEventCallback("blocked", fx_hitanim, v)
			v.components.health:SetInvincible(false)
			inst.casting = false
            if v:IsValid() then
            fx.kill_fx(fx) end
			end)
		end	
		end	
		-------- --------
   
		end,

        timeline =
        {
            TimeEvent(0, function(inst)
                local fxtoplay = inst.components.rider ~= nil and inst.components.rider:IsRiding() and "book_fx_mount" or "book_fx"
                local fx = SpawnPrefab(fxtoplay)
                fx.entity:SetParent(inst.entity)
                fx.Transform:SetPosition(0, 0.2, 0)
                inst.sg.statemem.book_fx = fx
            end),

            TimeEvent(28 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
            end),

            TimeEvent(54 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
				inst.sg:RemoveStateTag("busy")
            end),

            TimeEvent(58 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
                inst:PerformBufferedAction()
                inst.sg.statemem.book_fx = nil
            end),
        },

		 events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
	
		ontimeout = function(inst)
		inst.sg:RemoveStateTag("doing")
		inst.sg:RemoveStateTag("notalking")
		inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
	        end
        end,
	
        onexit = function(inst)
			--inst.components.playercontroller:Enable(true)
			inst:ClearBufferedAction()
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			inst.AnimState:PushAnimation("mime3", false)
        end,
    }
	)
AddStategraphState("wilson", book2)

local bowm = GLOBAL.State(
{name = "blowdart",
        tags = { "attack", "notalking", "abouttoattack", "autopredict" },

        onenter = function(inst)
		--inst.components.locomotor:Stop()
			if inst.components.combat:InCooldown() then
                inst.sg:RemoveStateTag("abouttoattack")
                inst:ClearBufferedAction()
                inst.sg:GoToState("idle", true)
                return
            end		
			local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
              --local cooldown = math.max(inst.components.combat.min_attack_period + .5 * FRAMES, 20 * FRAMES)
			
			local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("bowm") then
			inst.AnimState:PlayAnimation("speargun")
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm2", "bowm")
			--inst.AnimState:PlayAnimation("speargun")
			--inst.AnimState:PlayAnimation("slingshot_pre") -- todo change anim later
			inst:DoTaskInTime(0.5, function()
			inst.AnimState:PushAnimation("slingshot", false) 
			inst:DoTaskInTime(0.5, function()
			local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("bowm") then
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm_boost", "bowm")
			elseif weapon and not weapon:HasTag("bowm") and not weapon.broken then
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm", "bowm")
			end end) end)
            --inst.AnimState:PushAnimation("slingshot", false)
            
			else
			inst.AnimState:PlayAnimation("dart_pre")
				if inst.sg.laststate == inst.sg.currentstate then
                inst.sg.statemem.chained = true
                inst.AnimState:SetTime(5 * FRAMES)
				end
				inst.AnimState:PushAnimation("dart", false)
				inst.sg:SetTimeout(math.max((inst.sg.statemem.chained and 14 or 18) * FRAMES, inst.components.combat.min_attack_period + .5 * FRAMES))
			end
			
            --inst.sg:SetTimeout(cooldown)

            if target ~= nil and target:IsValid() then
                inst:FacePoint(target.Transform:GetWorldPosition())
                inst.sg.statemem.attacktarget = target
            end
			
			if (equip ~= nil and equip.projectiledelay or 0) > 0 then
                --V2C: Projectiles don't show in the initial delayed frames so that
                --     when they do appear, they're already in front of the player.
                --     Start the attack early to keep animation in sync.
                inst.sg.statemem.projectiledelay = (inst.sg.statemem.chained and 9 or 14) * FRAMES - equip.projectiledelay
                if inst.sg.statemem.projectiledelay <= 0 then
                    inst.sg.statemem.projectiledelay = nil
                end
            end
			
        end,
		
		onupdate = function(inst, dt)
            if (inst.sg.statemem.projectiledelay or 0) > 0 then
                inst.sg.statemem.projectiledelay = inst.sg.statemem.projectiledelay - dt
                if inst.sg.statemem.projectiledelay <= 0 then
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end
        end,
		

        timeline =
        {
            TimeEvent(8 * FRAMES, function(inst)
			local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
				if inst.sg.statemem.chained then
				if inst.fire then
					--[[if math.random() < 0.55 then
					inst.SoundEmitter:PlaySound("bowm/musha/bowm/bow", nil, nil, true)
					else
					inst.SoundEmitter:PlaySound("bowm/musha/bowm/bow2", nil, nil, true)
					end]]
				else
					inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
				end
				end
            end),
			
			 TimeEvent(9 * FRAMES, function(inst)
                if inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
		
			
           --[[TimeEvent(10 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("abouttoattack")
				local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
				if weapon and weapon:HasTag("bowm") then
				if math.random() < 0.55 then
				inst.SoundEmitter:PlaySound("bowm/musha/bowm/bow", nil, nil, true)
				else
				inst.SoundEmitter:PlaySound("bowm/musha/bowm/bow2", nil, nil, true)
				end
				else
                inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
				end
            end),]]
			
			TimeEvent(13 * FRAMES, function(inst)
                if not inst.sg.statemem.chained then
                if inst.fire then
					inst.SoundEmitter:PlaySound("bowm/musha/bowm/bow", nil, nil, true)
				else
					inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
				end
                end
				
            end),
			
			TimeEvent(14 * FRAMES, function(inst)
                if not inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
			
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
	            end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
			
			local weapon = inst.components.combat and inst.components.combat:GetWeapon()
			if weapon and weapon:HasTag("bowm") then
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm_boost", "bowm")
			elseif weapon and not weapon:HasTag("bowm") and not weapon.broken then
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm", "bowm")
			elseif weapon and not weapon:HasTag("bowm") and weapon.broken then
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm_broken", "bowm")
			
			end
        end,
    }
	)
AddStategraphState("wilson", bowm)

local function SetSleeperAwakeState(inst)
    if inst.components.grue ~= nil then
        inst.components.grue:RemoveImmunity("sleeping")
    end
    if inst.components.talker ~= nil then
        inst.components.talker:StopIgnoringAll("sleeping")
    end
    if inst.components.firebug ~= nil then
        inst.components.firebug:Enable()
    end
    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:EnableMapControls(true)
        inst.components.playercontroller:Enable(true)
    end
    inst:OnWakeUp()
    inst.components.inventory:Show()
    inst:ShowActions(true)
end
local function SetSleeperSleepState(inst)
    if inst.components.grue ~= nil then
        inst.components.grue:AddImmunity("sleeping")
    end
    if inst.components.talker ~= nil then
        inst.components.talker:IgnoreAll("sleeping")
    end
    if inst.components.firebug ~= nil then
        inst.components.firebug:Disable()
    end
    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:EnableMapControls(false)
        inst.components.playercontroller:Enable(false)
    end
    inst:OnSleepIn()
    inst.components.inventory:Hide()
    inst:PushEvent("ms_closepopups")
    inst:ShowActions(false)
end

local bedroll2 = GLOBAL.State(
{name = "bedroll2",
        tags = { "bedroll", "busy", "nomorph" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
			inst.quiet = true
            local failreason =
                (TheWorld.state.isday and
                    (TheWorld:HasTag("cave") and "ANNOUNCE_NODAYSLEEP_CAVE" or "ANNOUNCE_NODAYSLEEP")
                )
               -- or (IsNearDanger(inst) and "ANNOUNCE_NODANGERSLEEP")
                -- you can still sleep if your hunger will bottom out, but not absolutely
               -- or (inst.components.hunger.current < TUNING.CALORIES_MED and "ANNOUNCE_NOHUNGERSLEEP")
                or (inst.components.beaverness ~= nil and inst.components.beaverness:IsStarving() and "ANNOUNCE_NOHUNGERSLEEP")
                or nil

            if failreason ~= nil then
                inst:PushEvent("performaction", { action = inst.bufferedaction })
                inst:ClearBufferedAction()
                inst.sg:GoToState("idle")
                if inst.components.talker ~= nil then
                    inst.components.talker:Say(GetString(inst, failreason))
                end
                return
            end

            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("bedroll", false)

            SetSleeperSleepState(inst)
        end,

        timeline =
        {
            TimeEvent(20 * FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve/wilson/use_bedroll")
            end),
        },

        events =
        {
            EventHandler("firedamage", function(inst)
                if inst.sg:HasStateTag("sleeping") then
                    inst.sg.statemem.iswaking = true
                    inst.sg:GoToState("wakeup")
                end
            end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    if TheWorld.state.isday or
                        (inst.components.health ~= nil and inst.components.health.takingfiredamage) or
                        (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
                        inst:PushEvent("performaction", { action = inst.bufferedaction })
                        inst:ClearBufferedAction()
                        inst.sg.statemem.iswaking = true
                        inst.sg:GoToState("wakeup")
                    elseif inst:GetBufferedAction() then
                        inst:PerformBufferedAction() 
                        if inst.components.playercontroller ~= nil then
                            inst.components.playercontroller:Enable(true)
                        end
                        inst.sg:AddStateTag("sleeping")
                        inst.sg:AddStateTag("silentmorph")
                        inst.sg:RemoveStateTag("nomorph")
                        inst.sg:RemoveStateTag("busy")
                        inst.AnimState:PlayAnimation("bedroll_sleep_loop", true)
                    else
                        inst.sg.statemem.iswaking = true
                        inst.sg:GoToState("wakeup")
                    end
                end
            end),
        },

        onexit = function(inst)
		inst.quiet = false
            if inst.sleepingbag ~= nil then
                --Interrupted while we are "sleeping"
                inst.sleepingbag.components.sleepingbag:DoWakeUp(true)
                inst.sleepingbag = nil
                SetSleeperAwakeState(inst)
            elseif not inst.sg.statemem.iswaking then
                --Interrupted before we are "sleeping"
                SetSleeperAwakeState(inst)
            end
        end,
    }
	)
AddStategraphState("wilson", bedroll2)

local attack_frosthammer = GLOBAL.State(
{name = "attack2",
        tags = {"prehammer", "attack", "notalking", "abouttoattack", "autopredict", "doing", "busy"},
        
        onenter = function(inst)
	
			inst.f_attack = true
			--inst:DoTaskInTime(1.6, function(inst) inst.f_attack = false end )
			if inst:HasTag("musha") and not inst.on_sparkshield and not inst.light_shield then
			inst.components.health:SetAbsorptionAmount(0.5)
			end
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			local cooldown = inst.components.combat.min_attack_period + .5 * FRAMES
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
			if target ~= nil and target.components.locomotor then
			target.components.locomotor:Stop()
			end
            local weapon = inst.components.combat and inst.components.combat:GetWeapon()
		
		if weapon and not inst.components.rider:IsRiding() then
                inst.AnimState:PlayAnimation("pickaxe_pre")
				--inst.AnimState:PushAnimation("pickaxe_lag", false)
				cooldown = math.max(cooldown, 6 * FRAMES)
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_icestaff")
                    --inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
					
		elseif inst.components.rider:IsRiding() then
            local cooldown = inst.components.combat.min_attack_period + .5 * FRAMES
                if equip ~= nil and (equip.components.projectile ~= nil or equip:HasTag("rangedweapon")) then
                    inst.AnimState:PlayAnimation("player_atk_pre")
                    inst.AnimState:PushAnimation("player_atk", false)
                    inst.SoundEmitter:PlaySound(
                        (equip:HasTag("icestaff") and "dontstarve/wilson/attack_icestaff") or
                        (equip:HasTag("firestaff") and "dontstarve/wilson/attack_firestaff") or
                        "dontstarve/wilson/attack_weapon",
                        nil, nil, true
                    )
                    cooldown = math.max(cooldown, 13 * FRAMES)
                else
                    inst.AnimState:PlayAnimation("atk_pre")
                    inst.AnimState:PushAnimation("atk", false)
                    DoMountSound(inst, inst.components.rider:GetMount(), "angry", true)
                    cooldown = math.max(cooldown, 16 * FRAMES)
                end		
					
            else
				inst.sg.statemem.slow = true
                inst.AnimState:PlayAnimation("punch")
                --inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
            end
				--inst.sg:SetTimeout(cooldown)
			    inst:PerformPreviewBufferedAction()
		end,
		timeline =
        {
            TimeEvent(6 * FRAMES, function(inst)
				if not inst.components.rider:IsRiding() then
                inst.sg:RemoveStateTag("prehammer")
				end
            end),
			TimeEvent(8 * FRAMES, function(inst)
                if inst.components.rider:IsRiding() then
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
		},
					
		ontimeout = function(inst)
		if not inst.components.rider:IsRiding() then
		inst:ClearBufferedAction()
		inst.sg:RemoveStateTag("prehammer")
		elseif inst.components.rider:IsRiding() then
		inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
		end
        end,
		
        events =
        {
		
			EventHandler("equip", function(inst) 
			if inst.components.rider:IsRiding() then
			inst.sg:GoToState("idle") end 
			end),
			
            EventHandler("unequip", function(inst)  
			if not inst.components.rider:IsRiding() then
			inst:ClearBufferedAction()
            inst.AnimState:PlayAnimation("pickaxe_pst")
			inst.AnimState:PushAnimation("pickaxe_lag", false)
            inst.sg:GoToState("idle", true) 
			inst.f_attack = false
			end
			end),
			
			EventHandler("animqueueover", function(inst)
			if inst.components.rider:IsRiding() then
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
			end	
            end),
			
            EventHandler("animover", function(inst)
			if not inst.components.rider:IsRiding() then
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("attacking")
					inst.sg:SetTimeout(cooldown)
                end
			end	
            end),
		
        },
	
        onexit = function(inst)
		if inst.components.rider:IsRiding() then
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
		end	
        end,
    	
    }
	)
AddStategraphState("wilson", attack_frosthammer)

local attack_frosthammer2 = GLOBAL.State(

{name = "attacking",
        tags = { "prehammer", "attack", "notalking", "abouttoattack", "autopredict", "doing" },

        onenter = function(inst)
			
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            local cooldown = inst.components.combat.min_attack_period + .5 * FRAMES
            if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk", false)
                DoMountSound(inst, inst.components.rider:GetMount(), "angry", true)
                cooldown = math.max(cooldown, 16 * FRAMES)
            elseif equip ~= nil --[[and equip:HasTag("frost_hammer")]] then
				inst.AnimState:PlayAnimation("pickaxe_loop")
				local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon() or nil
                if weapon and weapon:HasTag("phoenix_axe") then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_firestaff", nil, nil, true)
				else
				inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_icestaff", nil, nil, true)
				end
                cooldown = math.max(cooldown, 13 * FRAMES)
            else
                inst.AnimState:PlayAnimation("punch")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, nil, true)
                cooldown = math.max(cooldown, 24 * FRAMES)
            end

            inst.sg:SetTimeout(cooldown)

            if target ~= nil then
                inst.components.combat:BattleCry()
                if target:IsValid() then
                    inst:FacePoint(target:GetPosition())
                    inst.sg.statemem.attacktarget = target
                end
            end
        end,

        timeline =
        {
            TimeEvent(10 * FRAMES, function(inst)
				inst.sg:RemoveStateTag("prehammer")
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
            end),
        },

        ontimeout = function(inst)
		inst.sg:RemoveStateTag("prehammer")
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
			inst.f_attack = false
        end,

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") 
			inst.f_attack = false
			end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") 
			inst.f_attack = false
			end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.AnimState:PlayAnimation("pickaxe_pst")
                    inst.sg:GoToState("idle", true)
					inst.f_attack = false
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
				inst.f_attack = false
            end
        end,
    }
	)
AddStategraphState("wilson", attack_frosthammer2)

-----------
-----------
-----------
-----------client

local shovel_start_c = GLOBAL.State(
 {name = "dig_start",
        tags = { "predig", "working" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
			local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("frost_spear") then
			inst.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear_2r", "phoenixspear")
			inst.AnimState:Show("ARM_carry") 
			inst.AnimState:Hide("ARM_normal")
			end
			
			if not inst:HasTag("working") then
                inst.AnimState:PlayAnimation("shovel_pre")
                inst.AnimState:PushAnimation("shovel_lag", false)
            end

            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(TIMEOUT)
        end,

        onupdate = function(inst)
            if inst:HasTag("working") then
                if inst.entity:FlattenMovementPrediction() then
                inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.AnimState:PlayAnimation("shovel_pst")
                inst.sg:GoToState("idle", true)
            end
        end,

        ontimeout = function(inst)
            inst:ClearBufferedAction()
            inst.AnimState:PlayAnimation("shovel_pst")
			local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("frost_spear") then
			inst.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear2", "phoenixspear")
			inst.AnimState:Show("ARM_carry") 
			inst.AnimState:Hide("ARM_normal")
			end
            inst.sg:GoToState("idle", true)
        end,
		
    })
--AddStategraphState("wilson_client", shovel_start_c)

local bedroll2_c = GLOBAL.State(
{name = "bedroll2",
        tags = { "bedroll", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("action_uniqueitem_lag", false)

            inst:PerformPreviewBufferedAction()
           -- inst.sg:SetTimeout(TIMEOUT)
        end,

        onupdate = function(inst)
            if inst:HasTag("busy") or inst:HasTag("sleeping") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,

        ontimeout = function(inst)
            inst:ClearBufferedAction()
            inst.sg:GoToState("idle")
        end,
    }
	)
AddStategraphState("wilson_client", bedroll2_c)

local book2_c = GLOBAL.State(
{name = "book2",
        tags = { "doing", "busy", "notalking" },

        onenter = function(inst)
		--[[if inst.components.playercontroller then
		inst.components.playercontroller:Enable(false)
		end]]
		if inst.replica.health then
		inst.replica.health:SetInvincible(true)
		end
		inst.replica.locomotor:Stop()
		-------- --------
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("action_uniqueitem_lag", false)
	      --inst.AnimState:PushAnimation("book", false)
            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(3)   
				--shield --------
		--[[inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")

		local fx = SpawnPrefab("forcefieldfxx")
        fx.entity:SetParent(inst.entity)
		if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
		fx.Transform:SetScale(2, 2, 2)
		else
		fx.Transform:SetScale(0.8, 0.8, 0.8)
		end
        fx.Transform:SetPosition(0, 0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
			end
        fx:ListenForEvent("blocked", fx_hitanim, inst)
			inst:DoTaskInTime( 3, function()
		
				inst.sg:RemoveStateTag("busy") end)
			inst:DoTaskInTime( 5, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, inst)
			inst.replica.health:SetInvincible(false)
			inst.casting = false
            if inst:IsValid() then
            fx.kill_fx(fx) end
			end)
			]]
        end,

        timeline =
        {
            TimeEvent(0, function(inst)
                local fxtoplay = inst.replica.rider ~= nil and inst.replica.rider:IsRiding() and "book_fx_mount" or "book_fx"
                local fx = SpawnPrefab(fxtoplay)
                fx.entity:SetParent(inst.entity)
                fx.Transform:SetPosition(0, 0.2, 0)
                inst.sg.statemem.book_fx = fx
            end),

            TimeEvent(28 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
            end),

            TimeEvent(54 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
				inst.sg:RemoveStateTag("busy")
            end),

            TimeEvent(58 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
                inst:PerformBufferedAction()
                inst.sg.statemem.book_fx = nil
            end),
        },
       events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
		
		onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,
		
		ontimeout = function(inst)
            inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
					--inst.components.playercontroller:Enable(true) 
            end
        end,

        --[[onexit = function(inst)
			
            if inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
        end,]]
    }
	)
AddStategraphState("wilson_client", book2_c)

local bowm_c = GLOBAL.State(
{name = "blowdart",
        tags = { "attack", "notalking", "abouttoattack" },

        onenter = function(inst)
		
		local buffaction = inst:GetBufferedAction()
            if inst.replica.combat ~= nil then
                if inst.replica.combat:InCooldown() then
                    inst.sg:RemoveStateTag("abouttoattack")
                    inst:ClearBufferedAction()
                    inst.sg:GoToState("idle", true)
                    return
                end
                inst.replica.combat:StartAttack()
                inst.sg:SetTimeout(math.max((inst.sg.statemem.chained and 14 or 18) * FRAMES, inst.replica.combat:MinAttackPeriod() + .5 * FRAMES))
            end
		
            --[[if inst.replica.combat ~= nil then
                inst.replica.combat:StartAttack()
                inst.sg:SetTimeout(math.max(20 * FRAMES, inst.replica.combat:MinAttackPeriod() + .5 * FRAMES))
            end]]
			local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            inst.components.locomotor:Stop()
			
			local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("bowm") then
			inst.AnimState:PlayAnimation("speargun")
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm2", "bowm")
			--inst.AnimState:PlayAnimation("speargun")
			--inst.AnimState:PlayAnimation("slingshot_pre") -- todo change anim later
			inst:DoTaskInTime(0.5, function()
			inst.AnimState:PushAnimation("slingshot", false) 
			inst:DoTaskInTime(0.5, function()
			local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("bowm") then
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm_boost", "bowm")
			elseif weapon and not weapon:HasTag("bowm") and not weapon.broken then
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm", "bowm")
			end end) end)
            --inst.AnimState:PushAnimation("slingshot", false)

			else
			inst.AnimState:PlayAnimation("dart")
			end
		
            if buffaction ~= nil then
                inst:PerformPreviewBufferedAction()

                if buffaction.target ~= nil and buffaction.target:IsValid() then
                    inst:FacePoint(buffaction.target:GetPosition())
                    inst.sg.statemem.attacktarget = buffaction.target
                end
            end
			
			 if (equip.projectiledelay or 0) > 0 then
                --V2C: Projectiles don't show in the initial delayed frames so that
                --     when they do appear, they're already in front of the player.
                --     Start the attack early to keep animation in sync.
                inst.sg.statemem.projectiledelay = (inst.sg.statemem.chained and 9 or 14) * FRAMES - equip.projectiledelay
                if inst.sg.statemem.projectiledelay <= 0 then
                    inst.sg.statemem.projectiledelay = nil
                end
            end
			
        end,

		onupdate = function(inst, dt)
            if (inst.sg.statemem.projectiledelay or 0) > 0 then
                inst.sg.statemem.projectiledelay = inst.sg.statemem.projectiledelay - dt
                if inst.sg.statemem.projectiledelay <= 0 then
                    inst:ClearBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end
        end,
	
		timeline =
        {
            TimeEvent(8 * FRAMES, function(inst)
				if inst.sg.statemem.chained then
					local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
					if weapon and weapon:HasTag("bowm") then

					--inst.SoundEmitter:PlaySound("bowm/musha/bowm/bow2", nil, nil, true)
					
					else
					inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
				end
				end	
            end),
            TimeEvent(9 * FRAMES, function(inst)
                if inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
                    inst:ClearBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
            TimeEvent(13 * FRAMES, function(inst)
				if not inst.sg.statemem.chained then
					local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
					if weapon and weapon:HasTag("bowm") then

					inst.SoundEmitter:PlaySound("bowm/musha/bowm/bow", nil, nil, true)
					else
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
					end
                end
            end),
            TimeEvent(14 * FRAMES, function(inst)
                if not inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
                    inst:ClearBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
        },


        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
                inst.replica.combat:CancelAttack()
            end
			local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if weapon and weapon:HasTag("bowm") then
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm_boost", "bowm")
			elseif weapon and not weapon:HasTag("bowm") and not weapon.broken then
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm", "bowm")
			elseif weapon and not weapon:HasTag("bowm") and weapon.broken then
			inst.AnimState:OverrideSymbol("swap_object", "swap_bowm_broken", "bowm")	
			end
        end,
    }
	)
AddStategraphState("wilson_client", bowm_c)


local attack_frosthammer_c = GLOBAL.State(
{name = "attack2",
        tags = {"prehammer", "attack", "notalking", "abouttoattack", "autopredict", "doing", "busy"},
        
        onenter = function(inst)
			inst.f_attack = true
						--inst:DoTaskInTime(1.6, function(inst) inst.f_attack = false end )
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            --inst.replica.combat:SetTarget(target)
            --inst.replica.combat:StartAttack()
			local cooldown = inst.replica.combat:MinAttackPeriod() + .5 * FRAMES
            if inst.replica.combat ~= nil then
                inst.replica.combat:StartAttack()
            end
			
            inst.components.locomotor:Stop()
            local weapon = inst.replica.combat and inst.replica.combat:GetWeapon()
			local rider = inst.replica.rider
			
			if rider ~= nil and rider:IsRiding() then
			local cooldown = 0
            if inst.replica.combat ~= nil then
                inst.replica.combat:StartAttack()
                cooldown = inst.replica.combat:MinAttackPeriod() + .5 * FRAMES
            end
			
                if equip ~= nil and (equip:HasTag("rangedweapon") or equip:HasTag("projectile")) then
                    inst.AnimState:PlayAnimation("player_atk_pre")
                    inst.AnimState:PushAnimation("player_atk", false)
                    inst.SoundEmitter:PlaySound(
                        (equip:HasTag("icestaff") and "dontstarve/wilson/attack_icestaff") or
                        (equip:HasTag("firestaff") and "dontstarve/wilson/attack_firestaff") or
                        "dontstarve/wilson/attack_weapon",
                        nil, nil, true
                    )
                    if cooldown > 0 then
                        cooldown = math.max(cooldown, 13 * FRAMES)
                    end
                else
                    inst.AnimState:PlayAnimation("atk_pre")
                    inst.AnimState:PushAnimation("atk", false)
                    DoMountSound(inst, rider:GetMount(), "angry")
                    if cooldown > 0 then
                        cooldown = math.max(cooldown, 16 * FRAMES)
                    end
                end
				
			else
            if weapon and not rider:IsRiding() then
                inst.AnimState:PlayAnimation("pickaxe_pre")
				--inst.AnimState:PushAnimation("pickaxe_lag", false)
				cooldown = math.max(cooldown, 6 * FRAMES)
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_icestaff")
                    --inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")

            else
				inst.sg.statemem.slow = true
                inst.AnimState:PlayAnimation("punch")
                --inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
            end
				--inst.sg:SetTimeout(cooldown)
			    inst:PerformPreviewBufferedAction()
		end	
        end,
		
		timeline =
        {
            TimeEvent(6 * FRAMES, function(inst)
				local rider = inst.replica.rider
				if not rider:IsRiding() then
                inst.sg:RemoveStateTag("prehammer")
				end
            end),
			
			 TimeEvent(8 * FRAMES, function(inst)
                local rider = inst.replica.rider
				if rider ~= nil and rider:IsRiding() then
                    inst:ClearBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
		},
		ontimeout = function(inst)
		--inst:ClearBufferedAction()
		local rider = inst.replica.rider
		if rider ~= nil and rider:IsRiding() then
		inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
		else
		inst.sg:RemoveStateTag("prehammer")
		end
        end,
		
        events =
        {
            EventHandler("unequip", function(inst) 
			local rider = inst.replica.rider			
			if not rider:IsRiding() then
			inst:ClearBufferedAction()
            inst.AnimState:PlayAnimation("pickaxe_pst")
			inst.AnimState:PushAnimation("pickaxe_lag", false)
            inst.sg:GoToState("idle", true) 
			inst.f_attack = false
			end
			end),
			
            EventHandler("animover", function(inst)
			local rider = inst.replica.rider
			if not rider:IsRiding() then
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("attacking")
					inst.sg:SetTimeout(cooldown)
                end
			end	
            end),
			
			EventHandler("animqueueover", function(inst)
			local rider = inst.replica.rider
			if rider:IsRiding() then
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
			end	
            end),
			
        },
		
		onexit = function(inst)
		local rider = inst.replica.rider
		if rider:IsRiding() then
            if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
                inst.replica.combat:CancelAttack()
            end
		end	
        end,
		
    }
	)
AddStategraphState("wilson_client", attack_frosthammer_c)

local attack_frosthammer2_c = GLOBAL.State(

{name = "attacking",
        tags = { "prehammer", "attack", "notalking", "abouttoattack", "autopredict", "doing" },

        onenter = function(inst)
		
            local cooldown = inst.replica.combat:MinAttackPeriod() + .5 * FRAMES
            if inst.replica.combat ~= nil then
                inst.replica.combat:StartAttack()
                --cooldown = inst.replica.combat:MinAttackPeriod() + .5 * FRAMES
            end
            inst.components.locomotor:Stop()
            local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            local rider = inst.replica.rider
            if rider ~= nil and rider:IsRiding() then
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk", false)
                DoMountSound(inst, rider:GetMount(), "angry")
                if cooldown > 0 then
                    cooldown = math.max(cooldown, 16 * FRAMES)
                end
             elseif equip ~= nil --[[and equip:HasTag("frost_hammer")]] then
                inst.AnimState:PlayAnimation("pickaxe_loop")
				--inst.AnimState:PushAnimation("atk", false)
                local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                if weapon and weapon:HasTag("phoenix_axe") then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_firestaff", nil, nil, true)
				else
				inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_icestaff", nil, nil, true)
				end
                if cooldown > 0 then
                    cooldown = math.max(cooldown, 13 * FRAMES)
                end
				if inst.components.playercontroller then
				inst.components.playercontroller:Enable(false)
				end
            else
                inst.AnimState:PlayAnimation("punch")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, nil, true)
                if cooldown > 0 then
                    cooldown = math.max(cooldown, 24 * FRAMES)
                end
            end
			
				--inst.sg:SetTimeout(cooldown)
			    inst:PerformPreviewBufferedAction()
							
            local buffaction = inst:GetBufferedAction()
            if buffaction ~= nil then
                inst:PerformPreviewBufferedAction()
				--inst.sg:SetTimeout(TIMEOUT)
                if buffaction.target ~= nil and buffaction.target:IsValid() then
                    inst:FacePoint(buffaction.target:GetPosition())
                    inst.sg.statemem.attacktarget = buffaction.target
                end
            end

            if cooldown > 0 then
                inst.sg:SetTimeout(cooldown)
            end
			
        end,

        timeline =
        {
            TimeEvent(10 * FRAMES, function(inst)
			inst.sg:RemoveStateTag("prehammer")
                    inst:ClearBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
            end),
            
        },

        ontimeout = function(inst)
		inst:ClearBufferedAction()
		inst.sg:RemoveStateTag("prehammer")
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
			inst.f_attack = false
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.AnimState:PlayAnimation("pickaxe_pst")
					--inst.AnimState:PushAnimation("pickaxe_lag", false)
					inst.sg:GoToState("idle", true)
					inst.f_attack = false
                end
            end),
        },

        onexit = function(inst)
            if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
                inst.replica.combat:CancelAttack()
				inst.f_attack = false
            end
        end,
    }
	
	)
AddStategraphState("wilson_client", attack_frosthammer2_c)


--------------------------------------



--addaction

 AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.EAT,
        function(inst, action)
            if inst.sg:HasStateTag("busy") then
                return
            end
            local obj = action.target or action.invobject
            if obj == nil then
                return
            elseif obj.components.edible ~= nil then
                if not inst.components.eater:PrefersToEat(obj) then
                    inst:PushEvent("wonteatfood", { food = obj })
                    return
                end
            elseif obj.components.soul ~= nil then
                if inst.components.souleater == nil then
                    inst:PushEvent("wonteatfood", { food = obj })
                    return
                end
            else
                return
            end
            return (obj.components.soul ~= nil and "eat")
                or (obj.components.edible.foodtype == FOODTYPE.MEAT and "eat")
				or (inst:HasTag("musha") and (inst.dis_veggie_taste or inst.dis_meat_taste or inst.veggie_taste or inst.meat_taste) and obj.components.edible.foodtype == "VEGGIE" and obj.components.edible.hungervalue >= 25 and "eat")
                or "quickeat"
        end)
		)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.ATTACK,
        function(inst, action)
            inst.sg.mem.localchainattack = not action.forced or nil
            if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or inst.components.health:IsDead()) then
                local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon() or nil
                return (weapon == nil and "attack")
                    or (weapon:HasTag("blowdart") and "blowdart")
					or (weapon:HasTag("slingshot") and "slingshot_shoot")
                    or (weapon:HasTag("thrown") and "throw")
                    or (weapon:HasTag("propweapon") and "attack_prop_pre")
                    or (weapon:HasTag("multithruster") and "multithrust_pre")
                    or (weapon:HasTag("helmsplitter") and "helmsplitter_pre")
					or (weapon:HasTag("frost_hammer") and "attack2")
					or (weapon:HasTag("phoenix_axe") and "attack2")
					or (weapon:HasTag("frost_spear") and "attack2")
					--or inst.sneaka and (weapon == nil and "attack2")
                    or "attack"
            end
        end)
		)
		

AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.ATTACK,
        function(inst, action)
            if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or IsEntityDead(inst)) then
                local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                if equip == nil then
                    return "attack"
                end
                local inventoryitem = equip.replica.inventoryitem
				--local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                return (not (inventoryitem ~= nil and inventoryitem:IsWeapon()) and "attack")
                     or (equip:HasTag("blowdart") and "blowdart")
					or (equip:HasTag("slingshot") and "slingshot_shoot")
                    or (equip:HasTag("thrown") and "throw")
                    or (equip:HasTag("propweapon") and "attack_prop_pre")
					or (equip:HasTag("frost_hammer") and "attack2")
					or (equip:HasTag("phoenix_axe") and "attack2")
					or (equip:HasTag("frost_spear") and "attack2")
					--or inst.sneaka and (equip == nil and "attack2")
                    or "attack"
            end
        end)
		)

		
local function DoHurtSound(inst)
    if inst.hurtsoundoverride ~= nil then
        inst.SoundEmitter:PlaySound(inst.hurtsoundoverride, nil, inst.hurtsoundvolume)
    elseif not inst:HasTag("mime") then
        inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/hurt", nil, inst.hurtsoundvolume)
    end
end


AddStategraphEvent("wilson", EventHandler("attacked", 
		function(inst, data)
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("drowning") then
			if inst.on_sparkshield or inst.f_attack or inst.light_shield or inst.pet_shield or inst.forcefields then
			inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/spark")
			else
		
            if data.weapon ~= nil and data.weapon:HasTag("tranquilizer") and (inst.sg:HasStateTag("bedroll") or inst.sg:HasStateTag("knockout")) then
                return 
            elseif inst.sg:HasStateTag("transform") or inst.sg:HasStateTag("dismounting") then
                
                inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")
                DoHurtSound(inst)
            elseif inst.sg:HasStateTag("sleeping") then
                inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")
                DoHurtSound(inst)
                if inst.sleepingbag ~= nil then
                    inst.sleepingbag.components.sleepingbag:DoWakeUp()
                    inst.sleepingbag = nil
                else
                    inst.sg.statemem.iswaking = true
                    inst.sg:GoToState("wakeup")
                end
            elseif inst.sg:HasStateTag("parrying") and data.redirected then
                if not inst.sg:HasStateTag("parryhit") then
                    inst.sg.statemem.parrying = true
                    inst.sg:GoToState("parry_hit", {
                        timeleft = inst.sg.statemem.task ~= nil and GetTaskRemaining(inst.sg.statemem.task) or inst.sg.statemem.parrytime,
                        pushing = data.attacker ~= nil and data.attacker.sg ~= nil and data.attacker.sg:HasStateTag("pushing"),
                    })
                end
            elseif data.attacker ~= nil
                and data.attacker:HasTag("groundspike")
                and not inst.components.rider:IsRiding()
                and not inst:HasTag("wereplayer") then
                inst.sg:GoToState("hit_spike", data.attacker)
            elseif data.attacker ~= nil
                and data.attacker.sg ~= nil
                and data.attacker.sg:HasStateTag("pushing") then
                inst.sg:GoToState("hit_push")
            elseif inst.sg:HasStateTag("shell") then
                inst.sg:GoToState("shell_hit")
            elseif inst.components.pinnable ~= nil and inst.components.pinnable:IsStuck() then
                inst.sg:GoToState("pinned_hit")
            elseif data.stimuli == "darkness" then
                inst.sg:GoToState("hit_darkness")
            elseif data.stimuli == "electric" and not inst.components.inventory:IsInsulated() then
                inst.sg:GoToState("electrocute")
            elseif inst.sg:HasStateTag("nointerrupt") then
                inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")
                DoHurtSound(inst)
            else
                local t = GetTime()
                local stunlock =
                    data.stimuli ~= "stun" and
                    data.attacker ~= nil and
                    
                    not (inst.sg:HasStateTag("idle") and inst.sg.timeinstate > 0) and
                    data.attacker.components.combat ~= nil and
                    data.attacker.components.combat.playerstunlock or
                    nil
                if stunlock ~= nil and
                    t - (inst.sg.mem.laststuntime or 0) <
                    (   (stunlock == PLAYERSTUNLOCK.NEVER and math.huge) or
                        (stunlock == PLAYERSTUNLOCK.RARELY and TUNING.STUNLOCK_TIMES.RARELY) or
                        (stunlock == PLAYERSTUNLOCK.SOMETIMES and TUNING.STUNLOCK_TIMES.SOMETIMES) or
                        (stunlock == PLAYERSTUNLOCK.OFTEN and TUNING.STUNLOCK_TIMES.OFTEN) or
                        0 
                    ) then
                   
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")
                    DoHurtSound(inst)
                else
                    inst.sg.mem.laststuntime = t
                    inst.sg:GoToState("hit", data.noimpactsound and "noimpactsound" or nil)
                end
            end
			end
        end
    end)
	)