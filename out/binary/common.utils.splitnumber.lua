
splitNumber=simple_class()

function splitNumber:__init(num)
self:setValue(num)
end

function splitNumber:__delete()

end

function splitNumber:setValue(num)
if num==0 then
self.valA=0
self.valB=0
return
end
local time=gameUtilityModel.getServerShortTime()
local check=time%2==0
local cv=num>0 and num or-num
local count=math.floor(math.log(cv)/math.log(2))+1
local mv=time%count
local v1=bit.rshift(num,mv)
v1=check and v1 or-v1
local v2=num-v1
self.valA=v1
self.valB=v2
end

function splitNumber:getValue()
return self.valA+self.valB
end

function splitNumber:add(num)
local val=self:getValue()
val=val+num
self:setValue(val)
end

function splitNumber:sub(num)
local val=self:getValue()
val=val-num
self:setValue(val)
end
