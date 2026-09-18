









local xjBehaviorNode_parallel={}


function xjBehaviorNode_parallel:onInit()
self.delList={}
end


function xjBehaviorNode_parallel:onStart()
for i,class_ in ipairs(self.childlist)do
class_:doStart()
end
end

function xjBehaviorNode_parallel:tick(interval)


for i,class_ in ipairs(self.childlist)do
if class_:tick(interval)then
table.insert(self.delList,i)
else
local isNode=xjBehaviorManager.isNodeType(class_.typo)
if not isNode and not class_:checkActive()and class_:checkActiveCond()then
class_:doStart()
end
end
end
local num=#self.delList
if num>0 then
for i=num,1,-1 do
local idx=self.delList[i]
local class_=table.remove(self.childlist,idx)
if class_ then
class_:doEnd()
if xjBehaviorManager.isNodeType(class_.typo)then
release_xjBehaviorNode(class_)
else
release_xjBehaviorJob(class_)
end
end
table.remove(self.delList,i)
end
end
if self.waitFunc then
return#self.childlist<=0 and self.waitFunc()
else
return#self.childlist<=0
end
end


function xjBehaviorNode_parallel:onEnd()

end


function xjBehaviorNode_parallel:onBreak()

end


function xjBehaviorNode_parallel:onSkip()

end


function xjBehaviorNode_parallel:onDelete()

end

return xjBehaviorNode_parallel