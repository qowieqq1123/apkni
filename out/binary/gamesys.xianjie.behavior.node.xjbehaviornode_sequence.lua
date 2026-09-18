









local xjBehaviorNode_sequence={}


function xjBehaviorNode_sequence:onInit()

end


function xjBehaviorNode_sequence:onStart()
local class_=self.childlist[1]
if class_ then
class_:doStart()
end
end

function xjBehaviorNode_sequence:tick(interval)
local class_=self.childlist[1]
if class_ then


local isNode=xjBehaviorManager.isNodeType(class_.typo)
if class_:tick(interval)then
table.remove(self.childlist,1)
class_:doEnd()
if isNode then
release_xjBehaviorNode(class_)
else
release_xjBehaviorJob(class_)
end
else
if not isNode and not class_:checkActive()and class_:checkActiveCond()then
class_:doStart()
end
end
end
if self.waitFunc then
return#self.childlist<=0 and self.waitFunc()
else
return#self.childlist<=0
end
end


function xjBehaviorNode_sequence:onEnd()

end


function xjBehaviorNode_sequence:onBreak()

end


function xjBehaviorNode_sequence:onSkip()

end


function xjBehaviorNode_sequence:onDelete()

end

return xjBehaviorNode_sequence