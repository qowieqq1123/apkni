








local xjBehaviorTree={}

function xjBehaviorTree:__init(data,initData,finishCB)
self.data=data or{}
self:initShareValues(initData)
self.finishCB=finishCB

self.nodeRoot=new_xjBehaviorNode(data[1],data[2],self)
if data[3]then
self.nodeRoot:setWaitFunc(data[3])
end
end

function xjBehaviorTree:getKey()
return self.m_key
end

function xjBehaviorTree:compareKey(key)
return self:getKey()==key
end

function xjBehaviorTree:initShareValues(initData)
self.shareValues=initData or{}
end

function xjBehaviorTree:copyShareValues()
if self.shareValues then
return table.weakCopy(self.shareValues)
end
end

function xjBehaviorTree:getShareValue(k)
return self.shareValues[k]
end

function xjBehaviorTree:setShareValue(k,v)
self.shareValues[k]=v
end


function xjBehaviorTree:doStart()
if self.nodeRoot then
self.nodeRoot:doStart()
end
end

function xjBehaviorTree:tick(interval)
return self.nodeRoot:tick(interval)
end


function xjBehaviorTree:doEnd()
if self.nodeRoot then
self.nodeRoot:doEnd()
release_xjBehaviorNode(self.nodeRoot)
self.nodeRoot=nil
end
if self.finishCB then
self.finishCB(self)
self.finishCB=nil
end
end


function xjBehaviorTree:doBreak()
if self.nodeRoot then
self.nodeRoot:doBreak()
release_xjBehaviorNode(self.nodeRoot)
self.nodeRoot=nil
end
self.finishCB=nil
end


function xjBehaviorTree:skip()
if self.nodeRoot then
self.nodeRoot:skip()
release_xjBehaviorNode(self.nodeRoot)
self.nodeRoot=nil
end
if self.finishCB then
self.finishCB(self)
self.finishCB=nil
end
end


function xjBehaviorTree:__delete()
if self.nodeRoot~=nil then



end
end



local eKey=0
local get_Key=function()
eKey=eKey+1
return eKey
end

local num=10
local pool={}

function new_xjBehaviorTree(data,initData,finishCB)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={
__index=xjBehaviorTree,
}
setmetatable(newT,mT)
end
local key=get_Key()
newT.m_key=key
newT:__init(data,initData,finishCB)
return newT
end

function release_xjBehaviorTree(class_)
if class_==nil then return end
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
