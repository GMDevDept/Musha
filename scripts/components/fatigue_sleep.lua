local function onmax(self, max)
	self.inst._fatigue_sleepmax:set(max)
end

local function oncurrent(self, current)
	self.inst._currentfatigue_sleepperc:set(current/self.max)
end

local function OnTaskTick(inst, self, period)
	self:DoRegen(period)
end

local Fatigue_sleep = Class(function(self, inst)
	self.inst = inst
	self.max = 100
	self.current = 0

	local period = 1
	self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
	--self.inst:DoPeriodicTask(1, function() self:Tiredlevels() end)

end,
nil,
{
	max = onmax,
	current = oncurrent
}
)

function Fatigue_sleep:OnSave()
	return {

		max = self.max,
		current = self.current or nil
	}
end

function Fatigue_sleep:OnLoad(data)
	if data ~= nil then
		self.max = data.max
		self.current = data.current
		self:DoDelta(0)
	end
end

function Fatigue_sleep:LongUpdate(dt)
	self:DoRegen(dt)
end

function Fatigue_sleep:GetPercent()
    return self.current / self.max
end

function Fatigue_sleep:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max)
end

function Fatigue_sleep:SetMax(amount)
	self.inst._fatigue_sleepmax:set(amount)
    self.max = amount
    self.current = amount
end

function Fatigue_sleep:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and (self.inst.components.health.invincible == true and not self.inst.sg:HasStateTag("tent")) or self.inst.is_teleporting == true then
        return
    end 

    local old = self.current
	local new = math.clamp(self.current + delta, 0, self.max)
	
	self.current = new
	self.inst:PushEvent("fatigue_sleepdelta", { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime })
end

function Fatigue_sleep:SetPercent(p, overtime)
    local old = self.current
    self.current  = p * self.max
    self.inst:PushEvent("fatigue_sleepdelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })
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

function Fatigue_sleep:DoRegen(dt)
    local old = self.current
	
	local regen = 0
if self.current >= 0 then 
	if Lightaura(self.inst) then
		regen = -2
	else
		if Sleeping(self.inst) then
		regen = -2
		else
		regen = 0
		end
	end
end	
	self:DoDelta((dt * regen), true)

end


function Fatigue_sleep:Tiredlevels()

		
			if self.current < 15 then
			self.inst.vlow_tired = true
			else
			self.inst.vlow_tired = false
			end
	
			if self.current >= 15 and self.current < 42 then 
			self.inst.low_tired = true
			else
			self.inst.low_tired = false
			end
			
			if self.current >= 42 and self.current < 73 then 
			self.inst.med_tired = true
			else
			self.inst.med_tired = false
			end
			
			if self.current >= 73 and self.current < 100 then 
			self.inst.high_tired = true
			else
			self.inst.high_tired = false
			end
			
			if self.current >= 100 then 
			self.inst.vhigh_tired = true
			else
			self.inst.vhigh_tired = false
			end
		
	
end

return Fatigue_sleep