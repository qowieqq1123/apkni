










UIMoveToPosition3DNode=simple_class(UIMoveToPositionNode)

function UIMoveToPosition3DNode:getUsePos(widget,index,tpos)
local rcpos=widget:GetChildAnchoredPosition3D(index)
local rtpos=Vector3.New(tpos[1],tpos[2],tpos[3])
return rcpos,rtpos
end

function UIMoveToPosition3DNode:countDistance(currPos,nextPos)
return Vector3.Distance(currPos,nextPos)
end

function UIMoveToPosition3DNode:doMove(widget,index,pos,time,callback)
return widget:SetChildDOAnchorPos3D(index,pos,time,callback)
end