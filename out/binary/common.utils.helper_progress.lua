







progressAnimationType={
eCommon=1,
}


function helper.playProgressAnim(progress,rate,lvChange,bFunc,eFunc,oldrate,speed)
if oldrate==nil then
oldrate=progress:getChildIconFillAmount()
else
progress:setChildIconFillAmount(oldrate)
end

if lvChange==0 and oldrate==rate then return end

speed=speed or 0.3
if bFunc then
bFunc()
end
local do_eFunc=function()
if eFunc then
eFunc()
end
end

if lvChange~=0 then
if lvChange>0 then
if oldrate<1 then
local func=function()
progress:setChildIconFillAmount(0)
local t=rate*speed
progress:setChildImageDOFillAmount(rate,t,do_eFunc)
end
local time=math.abs(1-oldrate)*speed
progress:setChildImageDOFillAmount(1,time,func)
else
progress:setChildIconFillAmount(0)
local t=rate*speed
progress:setChildImageDOFillAmount(rate,t,do_eFunc)
end
else
if oldrate>0 then
local func=function()
progress:setChildIconFillAmount(1)
local t=math.abs(1-rate)*speed
progress:setChildImageDOFillAmount(rate,t,do_eFunc)
end
local time=oldrate*speed
progress:setChildImageDOFillAmount(0,time,func)
else
progress:setChildIconFillAmount(1)
local t=math.abs(1-rate)*speed
progress:setChildImageDOFillAmount(rate,t,do_eFunc)
end
end
else
if rate~=oldrate then
local time=math.abs(rate-oldrate)*speed
progress:setChildImageDOFillAmount(rate,time,do_eFunc)
else
do_eFunc()
progress:setChildIconFillAmount(rate)
end
end
end

local progresDataLookup={}
local clearProgress=function(typo,progressID)
local list=progresDataLookup[typo]
if list~=nil then
local c=#list
if c>0 then
local id=list[1].id
if id==nil or id~=progressID then
progresDataLookup[typo]=nil
end
end
end
end
local hasDoingProgress=function(typo)
local c=0
if progresDataLookup[typo]~=nil then
c=#progresDataLookup[typo]
end
return c>0
end
local insertProgress=function(typo,data)
local list=progresDataLookup[typo]
if list==nil then
list={}
progresDataLookup[typo]=list
end
local c=#list
if c==0 then
list[1]=data
else
local d=list[2]
if d~=nil then

data.args[3]=data.args[3]+d.args[3]
end
list[2]=data
end
end
local removeProgress=function(typo)
local list=progresDataLookup[typo]
if list~=nil then
local c=#list
if c>0 then
table.remove(list,1)
end
if#list<=0 then
progresDataLookup[typo]=nil
end
end
end
local excuteProgress=function(typo)
local list=progresDataLookup[typo]
if list~=nil then
local c=#list
if c>0 then
local data=list[1]
helper.excutePlayProgressAnim2(unpack(data.args))
end
end
end

function helper.playProgressAnim2(typo,progress,rate,lvChange,bFunc,eFunc,oldrate,speed)
local id=progress.__instanceID
clearProgress(typo,id)
local do_eFunc=function()
if eFunc then
eFunc()
end
removeProgress(typo)
excuteProgress(typo)
end
local data={}
data.id=id
data.args={progress,rate,lvChange,bFunc,do_eFunc,oldrate,speed}
if not hasDoingProgress(typo)then
insertProgress(typo,data)
helper.excutePlayProgressAnim2(progress,rate,lvChange,bFunc,do_eFunc,oldrate,speed)
else
insertProgress(typo,data)
end
end


function helper.excutePlayProgressAnim2(progress,rate,lvChange,bFunc,eFunc,oldrate,speed)
if oldrate==nil then
oldrate=progress:getChildIconFillAmount()
else
progress:setChildIconFillAmount(oldrate)
end

if bFunc then
bFunc()
end
local do_eFunc=function()
if eFunc then
eFunc()
end
end
if lvChange==0 and oldrate==rate then
do_eFunc()
return
end

speed=speed or 0.3
if lvChange~=0 then
if lvChange>0 then
if oldrate<1 then
local func=function()
if progress:checkRelease()then return end
progress:setChildIconFillAmount(0)
local t=rate*speed
progress:setChildImageDOFillAmount(rate,t,do_eFunc)
end
local time=math.abs(1-oldrate)*speed
progress:setChildImageDOFillAmount(1,time,func)
else
progress:setChildIconFillAmount(0)
local t=rate*speed
progress:setChildImageDOFillAmount(rate,t,do_eFunc)
end
else
do_eFunc()
progress:setChildIconFillAmount(rate)
end
else
if rate>oldrate then
local time=math.abs(rate-oldrate)*speed
progress:setChildImageDOFillAmount(rate,time,do_eFunc)
else
do_eFunc()
progress:setChildIconFillAmount(rate)
end
end
end