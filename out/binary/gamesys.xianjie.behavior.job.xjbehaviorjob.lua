









local xjBehaviorJob={}

function xjBehaviorJob:__init(typo,data,tree)
self.tree=tree
self.typo=typo
self.data=data or{}
self:onInit()
end


function xjBehaviorJob:onInit()

end


function xjBehaviorJob:checkActiveCond()
return true
end


function xjBehaviorJob:checkActive()
return self.isActive==true
end


function xjBehaviorJob:doStart()

if not self.isActive then
local flag=self:onStart()
if flag then
self.isActive=true
end
end
end


function xjBehaviorJob:onStart()
return true
end


function xjBehaviorJob:doDispose()
if self:checkActive()then
self:onDispose()
end
end


function xjBehaviorJob:onDispose()

end

function xjBehaviorJob:tick(interval)
return true
end


function xjBehaviorJob:doEnd()
self:doDispose()
self:onEnd()
end


function xjBehaviorJob:onEnd()

end


function xjBehaviorJob:doBreak()
self:doDispose()
self:onBreak()
end


function xjBehaviorJob:onBreak()

end


function xjBehaviorJob:skip()
self:doDispose()
self:onSkip()
end


function xjBehaviorJob:onSkip()

end

function xjBehaviorJob:__delete()
self:onDelete()
end


function xjBehaviorJob:onDelete()

end



local eKey=0
local get_Key=function()
eKey=eKey+1
return eKey
end

local num=50
local pool={}
local fileLookup={}

function new_xjBehaviorJob(typo,data,tree)
local childname=xjBehaviorJobCfg[typo]
local child
if childname then
child=fileLookup[typo]
local filename=FMT.fmt('lua.gamesys.xianjie.behavior.job.{0}',childname)
if child==nil then
child=require(filename)
fileLookup[typo]=child
end
if child==nil then



return
end

if child.checkState~=nil then
if not child.checkState(tree)then
return
end
end
end

local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={




__index=xjBehaviorJob,
}
setmetatable(newT,mT)







end
for k,v in pairs(child)do
newT[k]=v
end
local key=get_Key()
newT.m_key=key
newT:__init(typo,data,tree)
return newT
end

function release_xjBehaviorJob(class_)
if class_==nil then return end
local key=class_.m_key
class_:__delete()
local temp={}

for k,v in pairs(class_)do
temp[k]=true
end
for k,v in pairs(temp)do
class_[k]=nil
end
if#pool>=num then
return
end
table.insert(pool,class_)
end
