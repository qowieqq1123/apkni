









UniformVariableVariator=simple_class(Variator)

function UniformVariableVariator:__init()
self.__name="UniformVariableVariator"
end

function UniformVariableVariator:__delete()
end




function UniformVariableVariator:StarVariator(base,a,t)
if self.variator and self.variator:isDead()then
local function CallBack()
self:LinearMotionFix(base,a,t)
end

self.isTick=true
self.variator:start(base,CallBack)
end
end


function UniformVariableVariator:LinearMotionFix(base,a,t)
t=(0>=t)and 1 or t

self.pass=self.pass+base
self.passTotal=self.passTotal+base

if self.trigger<=self.pass then
if self.triggerCallBack then
self.triggerCallBack(self.pars)
end

self.pass=0
end

if t<=self.passTotal then
self.trigger=self.trigger+a*t
self.trigger=(base>self.trigger)and base or self.trigger
self.passTotal=0
end
end


function UniformVariableVariator:LinearMotionUnFix(base,a)
self.pass=self.pass+base

if self.trigger<=self.pass then
if self.triggerCallBack then
self.triggerCallBack(self.pars)
end

self.trigger=self.trigger+a*self.pass
self.trigger=(base>self.trigger)and base or self.trigger
self.pass=0
end
end




UniformVariator=simple_class(UniformVariableVariator)

function UniformVariator:__init()
self.__name="UniformVariator"
end

function UniformVariator:__delete()
end
