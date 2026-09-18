deadSkill=simple_class(replaceEntity)


function deadSkill:initialize(args)
deadSkill._base.initialize(self,args)
self:castSkill(args.skillid,args.target,args.args)
end

function deadSkill:onDelete()
if self==nil or self:isDeleteSelf()then return end

if self.skillCommand then
self.skillCommand:onDelete()
end
deadSkill._base.onDelete(self)
end

function deadSkill:onUpdate()
if self.skillCommand then
self.skillCommand:onUpdate()
end
end

function deadSkill:onPause()
if self.skillCommand then
self.skillCommand:onPause()
end

end

function deadSkill:onContinue()
if self.skillCommand then
self.skillCommand:onContinue()
end
end

function deadSkill:onFastUpdate()
if self.skillCommand then
self.skillCommand:onFastUpdate()
else
self:onDelete()
end
end

function deadSkill:onCommandDelete(guid)
self.skillCommand=nil
end

function deadSkill:castSkill(skillid,target,args)
local skillCfg=cfg_airskillconfig_get(skillid)
local command=airSkillSystem:createSkillCommmand(skillCfg,self,self,target,args)
if not command.isDelete and not self:isDeleteSelf()then
self.skillCommand=command
end
end
