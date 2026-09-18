





function lingshouModel:onEnterState_skill(isReconnect)

end

function lingshouModel:onProtocolReq_skill()

end


function lingshouModel:onLeaveState_skill(isReconnect)

end




function lingshouModel:getSkillConfig(skillID)
local cfg=cfgHelper.get(cfg_lingshouskillconfig_get,skillID)
return cfg
end




function lingshouModel:getSkillMaxLevel(skillID)
local cfg=lingshouModel:getSkillConfig(skillID)
return cfg and#cfg.up_level_conf+1 or 0
end





function lingshouModel:checkSkillLevelMax(skillID,skillLV)
local maxLevel=lingshouModel:getSkillMaxLevel(skillID)
return skillLV>=maxLevel
end




function lingshouModel:checkSkillLevelMaxByGuid(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
local skillLV=lsData.skill_level
local mainSkill=lingshouModel:getLingShouConfig(lsData.id,'skill')
local maxLevel=lingshouModel:getSkillMaxLevel(mainSkill)
return skillLV>=maxLevel
end






function lingshouModel:checkUpSkillLevelCondition(lsGuid,skillID,skillLV)
local lock_sys_id=cfgHelper.get(cfg_lingshoubasicconfig_get,1,'skill_open_sys_id')
local isOpen=systemModel.isOpen(lock_sys_id)
if not isOpen then
return false,{0,lock_sys_id}
end

local cfg=lingshouModel:getSkillConfig(skillID)
local conditions=cfg and cfg.up_level_cnd and cfg.up_level_cnd[skillLV]

if conditions==nil then return true end

local isPass=true
local noPassArgs
for index,condition in ipairs(conditions)do
local ctype=condition[1]
if ctype==1 then

local lsData=lingshouModel:getLingShouData2(lsGuid)
local needJlLevel=condition[2]
if lsData.jj_lvl<needJlLevel then
isPass=false
noPassArgs={ctype,needJlLevel}
break
end
end
end

return isPass,noPassArgs
end




function lingshouModel:getUpLevelConditionNoPassDesc(noPassArgs)
local ctype=noPassArgs[1]
if ctype==0 then



local str=cfgHelper.get1(cfg_lang_get,'lingshou_mainskill_locksys_desc')
return toColorString(FONT_COLOR.eRedColor,str)
end

if ctype==1 then
local jjlv=noPassArgs[2]
local jjname=lingshouModel.getJJNameEx(jjlv,2)
return toColorString(FONT_COLOR.eRedColor,FMT.fmt("境界：{0}({1})",jjname,jjlv))
end
end






function lingshouModel:checkSkillCanUpLevelCostEnough(lsGuid,skillID,skillLV)
local cfg=lingshouModel:getSkillConfig(skillID)
local costs=cfg and cfg.up_level_conf and cfg.up_level_conf[skillLV]

if costs==nil then return true end

local isEnough=true
local noCost
for index,cost in ipairs(costs)do
if not itemsModel.checkItemEnough(cost[1],cost[2])then
isEnough=false
noCost=cost
break
end
end
return isEnough,noCost
end





function lingshouModel:checkIsMainSkill(lsGuid,skillID)
local lsData=lingshouModel:getLingShouData2(lsGuid)
local mainSkillID=lingshouModel:getLingShouConfig(lsData.id,'skill')
return mainSkillID==skillID
end

function lingshouModel:checkIsPassiveSkill(lsGuid,skillID)
local lsData=lingshouModel:getLingShouData2(lsGuid)
local passive_skill=lingshouModel:getLingShouConfig(lsData.id,'passive_skill')
return passive_skill and passive_skill[1]==skillID
end




function lingshouModel:getMainSkillReddot(lsGuid)

local isMaxLevel=lingshouModel:checkSkillLevelMaxByGuid(lsGuid)
if not isMaxLevel then
local lsData=lingshouModel:getLingShouData2(lsGuid)
local skillLV=lsData.skill_level
local mainSkillID=lingshouModel:getLingShouConfig(lsData.id,'skill')
local isPassCondition=lingshouModel:checkUpSkillLevelCondition(lsGuid,mainSkillID,skillLV)
if isPassCondition then
local isCostEnough=lingshouModel:checkSkillCanUpLevelCostEnough(lsGuid,mainSkillID,skillLV)
if isCostEnough then
return true
end
end
end

return false
end



function lingshouModel:getTop5MainSkillReddot()
local lsFightTop5List=lingshouModel:getFightTop5EquipLingShouGuidList()
for index,data in ipairs(lsFightTop5List)do
local lsGuid=data.lsGuid
if lingshouModel:getMainSkillReddot(lsGuid)then
return true
end
end

return false
end

function lingshouModel:getPassiveSkillLevel(lsData,pskillindex)
pskillindex=pskillindex or 1
local lsCfg=self:getLingShouConfig(lsData.id)
local jjlv=lsData.jj_lvl
local xmlv=lsData.xuemai_val

local skillLv=0
local xueMaiLv=xmlv or 1
local passiveSkillList=lsCfg.passive_skill
if passiveSkillList then
local skillId=passiveSkillList[pskillindex]
local skillLevelUpCfg=cfgHelper.get(cfg_lingshoupassiveskillconfig_get,skillId)
if skillLevelUpCfg then
local lvCfg=skillLevelUpCfg.up_level_conf
for level,cnd in ipairs(lvCfg)do
local needXmLv=cnd[1]
local needJJLv=cnd[2]
if xueMaiLv>=needXmLv and jjlv>=needJJLv then
skillLv=level
else
break
end
end
end
end

return skillLv
end

function lingshouModel:getPassiveSkillLevelEx(lsGuid,pskillindex)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData then
return self:getPassiveSkillLevel(lsData,pskillindex)
end
end

function lingshouModel:getTraitAddSkillLookUp(dzGuid)
local lsGuid=lingshouModel:getLingShouByDizi(dzGuid)
if lsGuid==nil then return end
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData==nil then return end
local lookup={}
local skillList=UIDiscipleModel:getDiscipleUsingGFSkillList2(dzGuid)
for index,skillInfo in ipairs(skillList)do
local gfID=skillInfo[1]
local skillID=skillInfo[2]

local lsEAdd=lingshouModel.getLingShouPropertyValEx(lsGuid,lingshouPropertyType.DISCIPLE_GONGFA_SKILL_LEVEL,gfID,skillID)or 0
lookup[skillID]=lsEAdd
end
return lookup
end