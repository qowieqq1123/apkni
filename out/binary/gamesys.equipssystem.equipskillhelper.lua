equipSkillHelper={}

function equipsHelper.getFabaoEffect(diziguid,effectType)
local fabao=fabaoModel.getFabaoByDizi(diziguid)
if fabao==nil then return end
return fabaoCizuiHelper.getFabaoEffect(fabao.itemguid,effectType)
end


function equipsHelper.getSuitSkill(diziguid)
local suit=equipsModel.getAllEquipSuit(diziguid)
local list=nil
for _,v in ipairs(suit)do
local list1=equipsHelper.getSingleSuitSkill(v[1])
list=attrListHelper.concatList(list,list1)
end
return list
end

function equipsHelper.getSingleSuitSkill(suitid)
local suitConfig=equipsConfig.getSuitConfig(suitid)
local skill2=suitConfig.skill2
local skill3=suitConfig.skill3
local temp={}
for i,v in ipairs(skill2 or{})do
temp[v[1]]=v[2]
end

for i,v in ipairs(skill3 or{})do
local skillid=v[1]
local val=v[2]
if temp[skillid]then
temp[skillid]=math.max(temp[skillid]or 0,val)
else
temp[skillid]=val
end
end
return attrListHelper.transformToList(temp)
end