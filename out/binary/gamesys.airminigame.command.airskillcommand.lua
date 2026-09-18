airSkillCommand=simple_class({})
local guid=0

function airSkillCommand:__init(skillCfg,owner,caster,target,args)
guid=guid+1
self.guid=guid

self.skillCfg=skillCfg
self.owner=owner
self.target=target
self.caster=caster
self.args=args or{}
self.actions={}
self.args.command=self
self.isDelete=false
self:step()
local isTriggerCast=args and args.isTriggerCast or false
airBuffSystem:onCastSkill(owner,skillCfg.id,isTriggerCast)
end

function airSkillCommand:recycleSelf()
local guid=self.guid
if not self:isCaseterDelete()then
self.caster:onCommandDelete(guid)
end
self:onDelete()
end

function airSkillCommand:onDelete()
if self.actions then
for i,v in pairs(self.actions)do
v:onDelete()
end
end
self.caster=nil
self.skillCfg=nil
self.owner=nil
self.target=nil
self.actions=nil
self.isDelete=true
end

function airSkillCommand:onPause()
for i,v in pairs(self.actions)do
v:onPause()
end
end

function airSkillCommand:onContinue()
for i,v in pairs(self.actions)do
v:onContinue()
end
end

function airSkillCommand:onUpdate()
for i,v in pairs(self.actions)do
v:onUpdate()
end
end

function airSkillCommand:onFastUpdate()
for i,v in pairs(self.actions)do
v:onFastUpdate()
end
end

function airSkillCommand:onActionDelete(guid)
self.actions[guid]=nil
end

function airSkillCommand:checkRecycleSelf()
if not self.actions or next(self.actions)==nil then
self:recycleSelf()
end
end

function airSkillCommand:isDeleteSelf()
return self.isDelete==true
end

function airSkillCommand:step()

if self:isCaseterDelete()then
self:recycleSelf()
return
end

local skillCfg=self.skillCfg
local actionid=skillCfg.mActionId
local actionValue=skillCfg.mActionvalue
local behaviourvalue=skillCfg.mBehaviourvalue
local action=airSkillSystem.createSkillAction(skillCfg,actionid,actionValue,behaviourvalue,self.owner,self.caster,self.target,self.args)

if self.actions==nil then
return
end

if not action:isDeleteSelf()then
self.actions[action.guid]=action
end
for i=1,6 do
local actionid=skillCfg[string.format('mActionId_%d',i)]
if actionid then
local actionValue=skillCfg[string.format('mActionvalue_%d',i)]
local behaviourvalue=skillCfg[string.format('mBehaviourvalue_%d',i)]
local action=airSkillSystem.createSkillAction(skillCfg,actionid,actionValue,behaviourvalue,self.owner,self.caster,self.target,self.args)
if not action:isDeleteSelf()then
self.actions[action.guid]=action
end
end
end
end

function airSkillCommand:isCaseterDelete()
return self.caster==nil or self.caster:isDeleteSelf()
end