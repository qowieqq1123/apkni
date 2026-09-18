airRecoverHPSkillAction=simple_class(airSkillAction)

function airRecoverHPSkillAction:__init(...)

end

function airRecoverHPSkillAction:initalize()
self:start()
end

function airRecoverHPSkillAction:start()
self:executeBehavour()
end

function airRecoverHPSkillAction:onDelete()
self._base:onDelete()
end

function airRecoverHPSkillAction:onPause()
self._base:onPause()
end

function airRecoverHPSkillAction:onContinue()
self._base:onContinue()
end

function airRecoverHPSkillAction:onUpdate()
self._base:onUpdate()
end

function airRecoverHPSkillAction:onFastUpdate()
self._base:onFastUpdate()
end

function airRecoverHPSkillAction:isDeleteSelf()
return self.isDelete==true
end

function airRecoverHPSkillAction:executeBehavour()
self:executeSingleDamage(self.target)
end