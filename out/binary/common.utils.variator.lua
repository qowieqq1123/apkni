







Variator=simple_class()

function Variator:__init(triggerCallBack,cancelCallBack,pars)
self.__name="variator"
self.pars=pars
self.triggerCallBack=triggerCallBack
self.cancelCallBack=cancelCallBack
self.variator=timer.new()
self:InitData()
end

function Variator:__delete()
if self.variator then
self.variator:cancel()
self.variator=nil
end


self.__name=nil
self.pass=nil
self.passTotal=nil
self.trigger=nil
self.isTick=nil
self.pars=nil
self.triggerCallBack=nil
self.cancelCallBack=nil
end

function Variator:InitData()
self.pass=0
self.passTotal=0
self.trigger=0.1
self.isTick=false
end


function Variator:SetTriggerBase(t)
self.trigger=(0>=t)and 0.1 or t
end


function Variator:IsTick()
return self.isTick
end

function Variator:StarVariator(base,a,t)
end


function Variator:CancelVariator()
if self.variator then
self.variator:cancel()
end

if self.cancelCallBack then
self.cancelCallBack()
end

self:InitData()
end
