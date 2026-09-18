meleeAI=simple_class(monsterAI)

function meleeAI:__init(...)

end

function meleeAI:stepAI(args)
self.target=args.target
end

function meleeAI:start()
local target=self.target
if target and not target:isDeleteSelf()then
self.owner.entity:BindEntity(target.handle)
self.isStart=true
return true
end
return false
end

function meleeAI:unbindTarget()
if self.target then
self.target=nil
self.owner.entity:UnBindEntity()
self.isStart=nil
end
end

function meleeAI:bindTarget(target)
self:unbindTarget()
self.target=target
end




function meleeAI:onUpdate()
if not self.isStart then return end
if self.isPause then return end
self._base.onUpdate(self)
self:refreshFlipX()
end

function meleeAI:onFastUpdate()
if not self.isStart then return end
if self.isPause then return end
self._base.onFastUpdate(self)
end

function meleeAI:onPause()
self._base.onPause(self)
end

function meleeAI:onContinue()
self._base.onContinue(self)
end

function meleeAI:onDelete()
self._base.onDelete(self)
self.target=nil
end