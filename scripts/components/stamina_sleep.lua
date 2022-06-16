local function onmax(self, max)
	self.inst._stamina_sleepmax:set(max)
end

local function oncurrent(self, current)
	self.inst._currentstamina_sleepperc:set(current/self.max)
end

local function OnTaskTick(inst, self, period)
	self:DoRegen(period)
end

local Stamina_sleep = Class(function(self, inst)
	self.inst = inst
	self.max = 100
	self.current = 100

	local period = 1
	self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
	self.inst:DoPeriodicTask(2, function() self:Spelllevels() end)

end,
nil,
{
	max = onmax,
	current = oncurrent
}
)

function Stamina_sleep:OnSave()
	return {

		max = self.max,
		current = self.current or nil
	}
end

function Stamina_sleep:OnLoad(data)
	if data ~= nil then
		self.max = data.max
		self.current = data.current
		self:DoDelta(0)
	end
end

function Stamina_sleep:LongUpdate(dt)
	self:DoRegen(dt)
end

function Stamina_sleep:GetPercent()
    return self.current / self.max
end

function Stamina_sleep:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max)
end

function Stamina_sleep:SetMax(amount)
	self.inst._stamina_sleepmax:set(amount)
    self.max = amount
    self.current = amount
end

function Stamina_sleep:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and (self.inst.components.health.invincible == true and not self.inst.sg:HasStateTag("tent")) or self.inst.is_teleporting == true then
        return
    end 

    local old = self.current
	local new = math.clamp(self.current + delta, 0, self.max)
	
	self.current = new
	self.inst:PushEvent("stamina_sleepdelta", { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime })
end

function Stamina_sleep:SetPercent(p, overtime)
    local old = self.current
    self.current  = p * self.max
    self.inst:PushEvent("stamina_sleepdelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })
end


local function Sleep_on(inst)
	return inst.sleep_on
end
local function Tiny_sleep(inst)
	return inst.tiny_sleep 
end
local function Sleeping(inst)
	return inst:HasTag("sleeping") or inst.sleep_on or inst.tiny_sleep
end

local function Lightaura(inst)
	return inst.lightaura 
end

local function vlow_tired(inst)
	return inst.dsleep_veasy
end		
local function low_tired(inst)
	return inst.dsleep_easy
end	
local function med_tired(inst)
	return	inst.dsleep_normal
end	
local function high_tired(inst)
	return	inst.dsleep_hard
end	
local function vhigh_tired(inst)
	return	inst.dsleep_hardcore
end

function Stamina_sleep:DoRegen(dt)
    local old = self.current
	
	local regen = 0
if self.current < 100 then 
	if Lightaura(self.inst) then
		regen = 0.5
	else
		if Sleep_on(self.inst) then
			if vlow_tired(self.inst) then
		regen = 4
			elseif low_tired(self.inst) then
		regen = 2.5
			elseif med_tired(self.inst) then
		regen = 1.5
			elseif high_tired(self.inst) then
		regen = 1
			elseif vhigh_tired(self.inst) then
		regen = 0.5
			end
		elseif Tiny_sleep(self.inst) then
			if vlow_tired(self.inst) then
		regen = 2
			elseif low_tired(self.inst) then
		regen = 1.5
			elseif med_tired(self.inst) then
		regen = 1
			elseif high_tired(self.inst) then
		regen = 0.5
			elseif vhigh_tired(self.inst) then
		regen = 0.25
			end
		end
	end
end	
	self:DoDelta((dt * regen), true)

end


function Stamina_sleep:Spelllevels()

			
			if self.current < 5 then
			self.inst.lowest_sleep = true
			else
			self.inst.lowest_sleep = false
			end
			
			if self.current >= 5 and self.current < 15 then
			self.inst.vlow_sleep = true
			else
			self.inst.vlow_sleep = false
			end
	
			if self.current >= 15 and self.current < 42 then 
			self.inst.low_sleep = true
			else
			self.inst.low_sleep = false
			end
			
			if self.current >= 42 and self.current < 73 then 
			self.inst.med_sleep = true
			else
			self.inst.med_sleep = false
			end
			
			if self.current >= 73 then 
			self.inst.high_sleep = true
			else
			self.inst.high_sleep = false
			end
			
			if self.current >= 95 then 
			self.inst.full_sleep = true
			else
			self.inst.full_sleep = false
			end
	
end

return Stamina_sleep