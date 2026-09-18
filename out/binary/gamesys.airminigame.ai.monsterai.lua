monsterAI=simple_class()

function monsterAI:__init(owner,aiId,args)
self.owner=owner
self.aiId=aiId
self.aiCfg=cfg_airemonsteraiconfig_get(aiId)
self.isStart=false
self.isIdleStatus=true
self.args=args
self.isPause=false
self:stepAI(args)
end

function monsterAI:stepAI(args)

end

function monsterAI:start()
self.isStart=true
end

function monsterAI:bindTarget(target)

end

function monsterAI:unbindTarget()

end

function monsterAI:getSpeed()
return self.owner.moveSpeed
end

function monsterAI:getLastTarget()
return self.lastTarget
end

function monsterAI:stopStackTarget()
if self.target then
self.lastTarget=self.target
self.owner.entity:UnBindEntity()
end
end

function monsterAI:remsumeStackTarget()
local target=self.lastTarget or self.target
if target and not target:isDeleteSelf()then
self.owner.entity:BindEntity(target.handle)
self.target=target
self.lastTarget=nil
end
end


function monsterAI:onUpdate()

end

function monsterAI:onFastUpdate()

end

function monsterAI:onPause()
self.isPause=true
end

function monsterAI:onContinue()
self.isPause=false
end

function monsterAI:onDelete()
self.owner=nil
self.aiId=nil
self.isStart=nil
self.aiCfg=nil
self.isIdleStatus=nil
self.isPause=nil
end

function monsterAI:setIdle(flag)
self.isIdleStatus=flag
self.owner:setIdle(flag)
end

function monsterAI:isIdle(flag)
return self.isIdleStatus==true
end

function monsterAI:refreshFlipX()
if self.target then
local roleX=self.target:getPosition().x
local x=self.owner:getPosition().x
local flipX=roleX>x
self.owner:setFlipX(flipX)
end
end