







MysteryEventCnd={}


function MysteryEventCnd:bind_data()
self.bindCondition=
{
[MysteryEventCndType.attr]={
check=MysteryEventCnd.cdn_attr,
getTips=function(guid,value,colorStr)
if type(value[1])=="table"then
local list={}
for i,v in ipairs(value)do
local attrid=v[1]
local compareValue=v[2]
local cur=eSpecialAttrFunc:getValue(attrid,guid)
local curStr=eSpecialAttrFunc:getValueStr(attrid,guid)
local name
if attrid==eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_LIANTI then
name='炼体'
else
name=eSpecialAttrName:getName(attrid)
end
table.insert(list,FMT.fmt("<color={0}>{1}:{2}</color>",cur>=compareValue and(colorStr~=nil and colorStr[1]or"#76d81e")or(colorStr~=nil and colorStr[2]or"#FF4343"),name,curStr))
end
return list
else
local attrid=value[1]
local compareValue=value[2]
local cur=eSpecialAttrFunc:getValue(attrid,guid)
local curStr=eSpecialAttrFunc:getValueStr(attrid,guid)
local name
if attrid==eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_LIANTI then
name='炼体'
else
name=eSpecialAttrName:getName(attrid)
end
return FMT.fmt("<color={0}>{1}:{2}</color>",cur>=compareValue and(colorStr~=nil and colorStr[1]or"#76d81e")or(colorStr~=nil and colorStr[2]or"#FF4343"),name,curStr)
end
end,
},
[MysteryEventCndType.item]=
{
check=MysteryEventCnd.cdn_item
},
[MysteryEventCndType.jobLevel]=
{
check=MysteryEventCnd.cdn_jobLevel,
getTips=function(guid,value,colorStr)
if type(value[1])=="table"then
local list={}
for i,v in ipairs(value)do
local jobType=v[1]
local level=UIDiscipleModel:getDiscipleJobLevel(guid,jobType)
table.insert(list,UIDiscipleModel:getDiscipleJobLevelDesc(jobType,level,"{0}:{1}级"))
end
return list
else
local jobType=value[1]
local jobLevel=value[2]
local level=UIDiscipleModel:getDiscipleJobLevel(guid,jobType)
local name=UIDiscipleModel:getDiscipleJobName(jobType)
return FMT.fmt("<color={0}>{1}:{2}级</color>",level>=jobLevel and(colorStr~=nil and colorStr[1]or"#76d81e")or(colorStr~=nil and colorStr[2]or"#FF4343"),name,level)
end
end,
},
[MysteryEventCndType.gongfa]=
{
check=MysteryEventCnd.cdn_gongfa,
getTips=function(guid,value)
if type(value[1])=="table"then
local list={}
for i,v in ipairs(value)do
local GFType=v[1]
local GFLevel=0
local GFData=UIDiscipleModel:getDiscipleGFData(guid,GFType)
if GFData then
GFLevel=GFData.param_2
end
table.insert(list,FMT.fmt("{0}:{1}级",cfgHelper.get2(cfg_disciplegongfaconfig_get,GFType,'name'),GFLevel))
end
return list
else
local GFType=value[1]
local GFLevel=0
local GFData=UIDiscipleModel:getDiscipleGFData(guid,GFType)
if GFData then
GFLevel=GFData.param_2
end
return FMT.fmt("{0}:{1}级",cfgHelper.get2(cfg_disciplegongfaconfig_get,GFType,'name'),GFLevel)
end
end,
},
[MysteryEventCndType.speciality]=
{
check=MysteryEventCnd.cdn_speciality,
},
[MysteryEventCndType.job]=
{
check=MysteryEventCnd.cdn_job,
getTips=function(guid,value,colorStr)
local job=UIDiscipleModel:getDiscipleJob(guid)
local cdn=false
if type(value)=="table"then
local jobList=value
for i,v in ipairs(jobList)do
if job==v then
cdn=true
break
end
end
else
cdn=job==value
end

return FMT.fmt("<color={0}>{1}</color>",cdn and(colorStr~=nil and colorStr[1]or"#76d81e")or(colorStr~=nil and colorStr[2]or"#FF4343"),UIDiscipleModel:getJobName(job))
end,
},
[MysteryEventCndType.shanEValue]=
{
check=MysteryEventCnd.cdn_shanevalue,
getTips=function(guid,value)
local myvalue=UISectPalaceModel:getShanEValue()
return FMT.fmt("善恶值:{0}",myvalue)
end,
},
}
end


function MysteryEventCnd:can_match_condition(conditionType,guid,value,warring)
local fun=MysteryEventCnd.bindCondition[conditionType]
if fun and fun.check then
return fun.check(guid,value,warring)
end

return true
end

function MysteryEventCnd:getTips(conditionType,guid,value,colorStr)
local fun=MysteryEventCnd.bindCondition[conditionType]
if fun and fun.getTips then
return fun.getTips(guid,value,colorStr)
end
end


function MysteryEventCnd.cdn_attr(guid,value,warring)
if not guid then
return false
end
if type(value[1])=="table"then
for i,v in ipairs(value)do
if MysteryEventCnd.cdn_attr(guid,v,warring)then
return true
end
end
return false
else
local attrid=value[1]
local compareValue=value[2]
local AttrList=eSpecialAttrFunc:getValue(attrid,guid)
local check=AttrList>=compareValue
if not check and warring then
UIManager.error(FMT.fmt("{0}不足",eSpecialAttrName:getName(attrid)))
end
return check
end
end

function MysteryEventCnd.cdn_item(guid,value,warring)
if type(value[1])=="table"then
for i,v in ipairs(value)do
if MysteryEventCnd.cdn_item(guid,v,warring)then
return true
end
end
return false
else
local itemid=value[1]
local compareValue=value[2]
if itemsConfig.isMoney(itemid)then
local check=moneyModel.checkEnoughMoney(itemid,compareValue)
if not check and warring then
UIManager.error(FMT.fmt("{0}数量不足",itemsConfig.getItemName(itemid)))
gainControl:showGainWin(itemid)
end
return check
else
local itemCount=bagModel.getItemCountById(itemid)
local check=itemCount>=compareValue
if not check and warring then
UIManager.error(FMT.fmt("{0}数量不足",itemsConfig.getItemName(itemid)))
gainControl:showGainWin(itemid)
end
return check
end
end

end


function MysteryEventCnd.cdn_jobLevel(guid,value,warring)
if not value then
return false
end
if type(value[1])=="table"then
local valueList=value
for i,v in ipairs(valueList)do
if MysteryEventCnd.cdn_jobLevel(guid,v,warring)then
return true
end
end
return false
else
local jobType=value[1]
local jobLevel=value[2]
local level=UIDiscipleModel:getDiscipleJobLevel(guid,jobType)
local check=level>=jobLevel
if not check and warring then
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,jobType,'name')
UIManager.error(FMT.fmt("{0}等级不足",name))
end
return check
end
end

function MysteryEventCnd.cdn_gongfa(guid,gongfaValue,warring)
if not gongfaValue then
return false
end
if type(gongfaValue[1])=="table"then
local valueList=gongfaValue
for i,v in ipairs(valueList)do
if MysteryEventCnd.cdn_gongfa(guid,v,warring)then
return true
end
end
return false
else
local GFType=gongfaValue[1]
local GFLevel=gongfaValue[2]or 0
local GFData=UIDiscipleModel:getDiscipleGFData(guid,GFType)
if not GFData then
if warring then
local gfname=cfgHelper.get2(cfg_disciplegongfaconfig_get,GFType,'name')
UIManager.error(FMT.fmt("尚未学习{0}",gfname))
end
return false
end

local check=GFData.param_2>=GFLevel

if not check and warring then
local gfname=cfgHelper.get2(cfg_disciplegongfaconfig_get,GFType,'name')
UIManager.error(FMT.fmt("{0}等级不足",gfname))
end

return check
end
end

function MysteryEventCnd.cdn_speciality(guid,specialityValue,warring)
if not specialityValue then
return false
end
if type(specialityValue[1])=="table"then
local valueList=specialityValue
for i,v in ipairs(valueList)do
if MysteryEventCnd.cdn_speciality(guid,v,warring)then
return true
end
end
return false
else
local specialityData=UIDiscipleModel:getDiscipleSpecialityConfig(guid)
for _,v in ipairs(specialityData)do
if v.specialitytype==specialityValue[1]and v.id==specialityValue[2]then
return true
end
end
if warring then
local cfg=UIDiscipleModel:getSpecialityConfig(specialityValue[1],specialityValue[2],'name')
UIManager.error(FMT.fmt("弟子未拥有{0}",cfg))
end
return false
end
end


function MysteryEventCnd.cdn_job(guid,jobValue,warring)
if not jobValue then
return false
end
if type(jobValue)=="table"then
local jobList=jobValue
for i,v in ipairs(jobList)do
if MysteryEventCnd.cdn_job(guid,v,warring)then
return true
end
end
return false
else
local job=UIDiscipleModel:getDiscipleJob(guid)
if jobValue==job then
return true
end
if warring then
UIManager.error("所选弟子职业不符合要求")
end
return false
end

end


function MysteryEventCnd.cdn_shanevalue(guid,shaneValue,warring)
if not shaneValue then
return false
end

local myvalue=UISectPalaceModel:getShanEValue()

if(type(shaneValue)=="table")then

local min=shaneValue[1]
local max=shaneValue[2]
local check=myvalue>=min and myvalue<=max

if warring and not check then
UIManager.error(FMT.fmt("当前善恶值为{0},不满足",myvalue))
end

return check
end
return false

end
