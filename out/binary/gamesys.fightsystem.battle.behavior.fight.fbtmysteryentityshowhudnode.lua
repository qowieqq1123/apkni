


registry_pool_class(fBTNodeTypo.MysteryEntityShowHUD,'fBTMysteryEntityShowHUDNode',fBTBaseNode)

function fBTMysteryEntityShowHUDNode:__init(guid)
self.typo=fBTNodeTypo.MysteryEntityShowHUD
end

function fBTMysteryEntityShowHUDNode:parser(rawData)
self.hudType=rawData[1]
self.strParam=rawData[2]
self.idParam=rawData[3]
self.showTime=rawData[4]
end



local hudType=
{
talk=0,
gantan=1,
randomTalk=2,
}







function fBTMysteryEntityShowHUDNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.time=0
end


function fBTMysteryEntityShowHUDNode:start()

self.time=0
if self.showTime<=0 then
self.state=fBTNodeState.success
else
self.state=fBTNodeState.running
end













local guid=self.entity.guid
local entity=mysteryEntityBase:get_entity_all(guid)


if entity then
if self.hudType==hudType.talk then
mysteryTriggerRoleTalk.resultRoleTalkStr(self.strParam,entity.entityType,entity.guid,self.showTime>0 and self.showTime or nil,function()
self.state=fBTNodeState.success
end)
elseif self.hudType==hudType.gantan then
UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD","UIMysteryTalkHUD",{ganhanhao=true,filpX=self.entity.entObj:GetFlipX(),bindType=entity.entityType,bindguid=entity.guid,delay=self.showTime>0 and self.showTime or nil,callback=function()
self.state=fBTNodeState.success
end})
elseif self.hudType==hudType.randomTalk then
UIManager:invokeUIMethod("UIMysteryHUDWin","addUIHUD","UIMysteryTalkHUD",{randomId=self.idParam,bindType=entity.entityType,bindguid=entity.guid,delay=self.showTime>0 and self.showTime or nil,callback=function()
self.state=fBTNodeState.success
end})
end
end

end


function fBTMysteryEntityShowHUDNode:update(delta)

self.time=self.time+delta
if self.time>=self.showTime+5 then
self.state=fBTNodeState.success
end
return self.state
end

function fBTMysteryEntityShowHUDNode:onComplete()
self.state=fBTNodeState.success
end


function fBTMysteryEntityShowHUDNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

