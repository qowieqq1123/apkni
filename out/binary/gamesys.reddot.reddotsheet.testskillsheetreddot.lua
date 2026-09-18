





testSkillSheetReddot=reddotSheetBase.new({classname='testSkillSheetReddot'})

testSkillSheetReddot.reddot_type=REDDIT_TYPE.eSkill

testSkillSheetReddot.isDynamic=true


function testSkillSheetReddot:onAppStart()

end

function testSkillSheetReddot:onPlayerCreate()
self:initConfig()
end

function testSkillSheetReddot:onLeaveState()
self:resetConfig()
end



function testSkillSheetReddot.getSkillKey(skillid)
return reddotConfig.get_base_val()*REDDIT_SUB_TYPE.sSkillBase+skillid
end

function testSkillSheetReddot.isSkillSubtype(subType)
local baseVal=reddotConfig.get_base_val()
local baseType=REDDIT_SUB_TYPE.sSkillBase
return subType>baseVal*baseType and subType<baseVal*(baseType+1)
end

function testSkillSheetReddot.getSkillid(subType)
local baseVal=reddotConfig.get_base_val()
local baseType=REDDIT_SUB_TYPE.sSkillBase
return subType%(baseVal*baseType)
end

function testSkillSheetReddot:initConfig()

self.reddot_config={}
local job=playerControl.player:get_vocation()
local skill_list=cfg_vocationconfig_get(job).skill_list
for _,v in ipairs(skill_list)do
local key=testSkillSheetReddot.getSkillKey(v)
self.reddot_config[key]=
{
catch={
CATCH_TYPE.eActorLevel,

CATCH_TYPE.eMoney,

CATCH_TYPE.eItem,

},

func=function(catchType,...)

end,
}
end

reddotClassManager.init_class(self)

self:init_data()
end

function testSkillSheetReddot:getSubTypeList()
return self.subTypeList
end

function testSkillSheetReddot:resetConfig()

reddotClassManager.reset_class(self)

self:reset_data()
self.reddot_config=nil
end
