

def_class('fightDelBuffEffectAction',fightBaseAction)


function fightDelBuffEffectAction:__init()
self.typo=fightActionType.DEL_BUFF_EFFECT
end

function fightDelBuffEffectAction:init(_round,_rawData,_srcID)

self.round=_round
self.rawData=_rawData
self.subSkillData=self.rawData[3]
self.skillObj=nil
self:initSubSkill()

self.isComplete=false
end

function fightDelBuffEffectAction:initSubSkill()
if self.subSkillData then
self.skillObj=fightActionMrg:getAction(fightActionType.CAST_SKILL)
if self.skillObj~=nil then
self.skillObj:init(self.round,self.subSkillData,self.srcID)
end
end
end

function fightDelBuffEffectAction:exe()


if self.skillObj then
self.skillObj:exe()
self.isExeAction=true
self.isComplete=false
else
self.isComplete=true
end
end

function fightDelBuffEffectAction:logExe(logContent)

logContent(FMT.fmt('buff{0}删除时作用',self.rawData[2]))
if self.skillObj~=nil then
self.skillObj:logExe(logContent)
end
self.isComplete=true
end

function fightDelBuffEffectAction:update(deltaTime)

if self.isExeAction then
local t=self.skillObj:update(deltaTime)
self.isComplete=t
end

return self.isComplete
end

function fightDelBuffEffectAction:onDespwan()
self.round=nil
self.isComplete=false
fightActionMrg:recycleAction(self)
end
