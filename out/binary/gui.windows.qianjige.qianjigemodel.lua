







QianJiGeModel={}



function QianJiGeModel:get_all_skill_unlock_config()
return cfg_probeskillunlockconfig()
end

function QianJiGeModel:get_skill_unlock_config(unlockId)
return cfg_probeskillunlockconfig_get(unlockId)
end

function QianJiGeModel:get_skill_id(unlockId)
return QianJiGeModel:get_skill_unlock_config(unlockId).skillid
end

function QianJiGeModel:get_skill_config(unlockId)
local skillid=QianJiGeModel:get_skill_unlock_config(unlockId).skillid
return cfg_ssprobeskillconfig_get(skillid)
end

function QianJiGeModel:get_skill_name_by_unlockId(unlockId)
local skillid=QianJiGeModel:get_skill_unlock_config(unlockId).skillid
return cfg_ssprobeskillconfig_get(skillid).name
end

function QianJiGeModel:get_before_skill(unlockId)
local config=QianJiGeModel:get_skill_unlock_config(unlockId)
return config.beforeskill
end

function QianJiGeModel:get_unlockId(skillId)
if not self.data.skillIdLookUp then
self.data.skillIdLookUp={}
local allUnlockConfig=self:get_all_skill_unlock_config()
for i,v in ipairs(allUnlockConfig)do
self.data.skillIdLookUp[v.skillid]=v.id
end
end
return self.data.skillIdLookUp[skillId]
end




function QianJiGeModel:init_data()
self.data={}
self.data.unlockSkillList={}
end


function QianJiGeModel:set_unlock_skill_list_data(len,data)
self.data.unlockSkillList={}
if len>0 then
for i,v in ipairs(data)do
self.data.unlockSkillList[v]=true
end
end
end

function QianJiGeModel:set_skill_unlock(unlockId)
local skillId=QianJiGeModel:get_skill_id(unlockId)
self.data.unlockSkillList[skillId]=true
end

function QianJiGeModel:get_skill_unlock_data()
return self.data.unlockSkillList
end


function QianJiGeModel:get_data()
return self.data
end


function QianJiGeModel:get_sys_data()
return self.data.sys
end

function QianJiGeModel:get_unlock_skill_num()
local list=QianJiGeModel:get_skill_unlock_data()
local num=0
if list then
for k,v in pairs(list)do
if v==true then
num=num+1
end
end
end
return num
end



function QianJiGeModel:is_skill_unlockId_unlock(unlockId)
local skillId=self:get_skill_id(unlockId)
return self.data.unlockSkillList[skillId]or false
end

function QianJiGeModel:is_skill_unlock(skillId)
return self.data.unlockSkillList[skillId]or false
end

function QianJiGeModel:is_beforeskill_unlock(unlockId)
local beforeskill=QianJiGeModel:get_before_skill(unlockId)
if beforeskill then
for i,v in ipairs(beforeskill)do
if not QianJiGeModel:is_skill_unlock(v)then
return false,v
end
end
end
return true
end

function QianJiGeModel:check_unlock_condition(unlockId)
local cfg=self:get_skill_unlock_config(unlockId)
if cfg.jzlevel then
local mountainId=zongmenModel:getMountainId()
local buildingList=zongmenModel:getBuildingDataByBdType(mountainId,SLG_SYSTEM_TYPE.eQianJiGe)
local check=false
for i,building in ipairs(buildingList)do
if building.level>=cfg.jzlevel then
check=true
break
end
end
if not check then
return false,1,cfg.jzlevel
end
end
if cfg.items then
for i,item in ipairs(cfg.items)do
if itemsConfig.isMoney(item[1])then
if not moneyModel.checkEnoughMoney(item[1],item[2])then
return false,2,{item[1],item[2]}
end
else
local itemCount=bagControl.invokeFuncByItemId(item[1],'getItemCountByItemID',item[1])
if itemCount<item[2]then
return false,2,{item[1],item[2]}
end
end
end
end
return true
end

function QianJiGeModel:check_skill_unlock()
local config=QianJiGeModel:get_all_skill_unlock_config()
for i,v in pairs(config)do
local unlock=QianJiGeModel:is_skill_unlockId_unlock(i)
local check,flag,value=QianJiGeModel:check_unlock_condition(i)
if not unlock and check then
return true
end
end
return false
end