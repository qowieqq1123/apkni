


registry_pool_class(fBTNodeTypo.Bubble,'fBTBubbleNode',fBTBaseNode)

function fBTBubbleNode:__init(guid)
self.typo=fBTNodeTypo.Bubble
end

function fBTBubbleNode:parser(rawData)
self.bubbleTypo=rawData[1]
self.strPara=rawData[2]
self.nunPara=rawData[3]
self.stayTime=rawData[4]
self.removeOnComplete=rawData[5]
self.tipType=rawData[6]
self.size=rawData[7]
self.offset=fBTHelper.vector3(rawData,8)
end



function fBTBubbleNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTBubbleNode:start()
if self.bubbleTypo==flowObjTypo.tip then
self.id=self.entity:flowText(self.bubbleTypo,{strPara=self.strPara,nunPara=self.tipType,stayTime=self.stayTime,scale=self.size~=-1 and self.size or nil,offset=self.offset})
elseif self.bubbleTypo==flowObjTypo.randomTip then
self.id=self.entity:flowText(self.bubbleTypo,{strPara=self.nunPara,nunPara=self.tipType,stayTime=self.stayTime,scale=self.size~=-1 and self.size or nil,offset=self.offset})
else
self.id=self.entity:flowText(self.bubbleTypo,{strPara=self.strPara,nunPara=self.nunPara,stayTime=self.stayTime,offset=self.offset})
end
self.state=fBTNodeState.success
end

function fBTBubbleNode:update(delta)
return self.state
end

function fBTBubbleNode:onComplete()

if self.removeOnComplete and self.id~=nil then
self.entity:stopText(self.id)
end

end

function fBTBubbleNode:onDespawn()
self.entity=nil
self.id=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end


