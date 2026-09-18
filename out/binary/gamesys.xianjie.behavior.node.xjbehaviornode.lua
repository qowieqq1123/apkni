









local xjBehaviorNode={}

function xjBehaviorNode:__init(typo,data,tree)
self.tree=tree
self.typo=typo
self.data=data or{}
self.childlist={}
for i,v in ipairs(self.data)do
local typo_=v[1]
if xjBehaviorManager.isNodeType(typo_)then
local node=new_xjBehaviorNode(typo_,v[2],tree)
if v[3]then
node:setWaitFunc(v[3])
end
table.insert(self.childlist,node)
else
local job=new_xjBehaviorJob(typo_,v[2],tree)
if job~=nil then
table.insert(self.childlist,job)
end
end
end
self:onInit()
end


function xjBehaviorNode:onInit()

end

function xjBehaviorNode:setWaitFunc(func)
self.waitFunc=func
end


function xjBehaviorNode:doStart()
self:onStart()
end


function xjBehaviorNode:onStart()

end

function xjBehaviorNode:tick(interval)
return self.childlist<=0
end


function xjBehaviorNode:doEnd()
self:onEnd()
end


function xjBehaviorNode:onEnd()

end


function xjBehaviorNode:doBreak()
if self.childlist and#self.childlist>0 then
for i,class_ in ipairs(self.childlist)do
class_:doBreak()
if xjBehaviorManager.isNodeType(class_.typo)then
release_xjBehaviorNode(class_)
else
release_xjBehaviorJob(class_)
end
end
self.childlist=nil
end
self:onBreak()
end


function xjBehaviorNode:onBreak()

end


function xjBehaviorNode:skip()
if self.childlist and#self.childlist>0 then
for i,class_ in ipairs(self.childlist)do
class_:skip()
if xjBehaviorManager.isNodeType(class_.typo)then
release_xjBehaviorNode(class_)
else
release_xjBehaviorJob(class_)
end
end
self.childlist=nil
end
self:onSkip()
end


function xjBehaviorNode:onSkip()

end


function xjBehaviorNode:__delete()
if self.childlist and#self.childlist>0 then



end
self:onDelete()
end


function xjBehaviorNode:onDelete()

end



local eKey=0
local get_Key=function()
eKey=eKey+1
return eKey
end
local num=50
local pool={}
local fileLookup={}

function new_xjBehaviorNode(typo,data,tree)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={




__index=xjBehaviorNode,
}
setmetatable(newT,mT)







end
local childname=xjBehaviorNodeCfg[typo]
if childname then
local child=fileLookup[typo]
local filename=FMT.fmt('lua.gamesys.xianjie.behavior.node.{0}',childname)
if child==nil then
child=require(filename)
fileLookup[typo]=child
end
if child==nil then



return
end
for k,v in pairs(child)do
newT[k]=v
end
end
local key=get_Key()
newT.m_key=key
newT:__init(typo,data,tree)
return newT
end

function release_xjBehaviorNode(class_)
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
