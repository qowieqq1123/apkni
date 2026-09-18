def_class('fightSkillShowAction',fightBaseAction)

function fightSkillShowAction:__init()
self.typo=fightActionType.SKILL_SHOW
end

function fightSkillShowAction:getTypo()
return self.typo
end


local SkillShowType=
{
shouhu=1,
fenliu=2,
lianjie=3,
fanji=4,
copyskill=5,
}

local skillShowData=
{
[SkillShowType.shouhu]={name="守护",},
[SkillShowType.fenliu]={name="生命分流",},
[SkillShowType.lianjie]={name="生命链接",},
[SkillShowType.fanji]={name="反击",imageID=20},
[SkillShowType.copyskill]={name="复制技能",exe=function(self,srcEnt)
self.isPlayBehavior=2
srcEnt:runBehavior("skill_copyskill",nil)
end},
}


function fightSkillShowAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()
self.skillTypo=_rawData[2]
self.srcID=_rawData[3]
self.dstID=_rawData[4]
end


function fightSkillShowAction:exe(immediately)
self.isPlayBehavior=0
local srcEnt=self.battle:getEntity(self.srcID)
if srcEnt~=nil then
local cfg=skillShowData[self.skillTypo]
if cfg==nil then
logErr(FMT.fmt("为配置 技能特殊表现 {0}",self.skillTypo))
else
if self.battle.isShowWindow then
if cfg.imageID then
srcEnt:flowText(flowObjTypo.skillEffect,{nunPara=cfg.imageID})
end
if cfg.exe then
cfg.exe(self,srcEnt)
end
end
end

end

self.isComplete=true
end

function fightSkillShowAction:logExe(logContent)
local srcEnt=self.battle:getEntity(self.srcID)
local dstEnt=self.battle:getEntity(self.dstID)

local srcName=srcEnt and srcEnt:logName()or'[未定义源]'
local dstName=dstEnt and dstEnt:logName()or'[未定义目标]'
local tag=skillShowData[self.skillTypo]and skillShowData[self.skillTypo].name or'未定义'
logContent(FMT.fmt("{0}对{1} [{2}]",srcName,dstName,tag))
self.isComplete=true
end

function fightSkillShowAction:update(deltaTime)
if self.isPlayBehavior and self.isPlayBehavior>0 then
self.isPlayBehavior=self.isPlayBehavior-deltaTime
return false
end

return self.isComplete
end


function fightSkillShowAction:onDespwan()
fightActionMrg:recycleAction(self)
end

