







local taskStateChangeFlag=nil

local taskPrefixName=
{
[taskModel.lineMain]='主',

lineElse='支',
lineXianJie='仙',
lineSystemZongMen='宗门',
}

local filter={}
local temp={}


local taskTypeClientCheckState={

[taskTypeClientCheckType.eDiscpleTotalNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local num=UIDiscipleModel:checkDiscipleCount()
local aimnum=taskdata.cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscpleColorNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIDiscipleModel:getDiscipleColorCount(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscpleJJLevelNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleJJLevelChange,
clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIDiscipleModel:getDiscipleJJCount(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eScrDiscpleJJLevelNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleJJLevelChange,
clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local d=string.split(cfg.params[1],'_')
local scrType=tonumber(d[1])
local jjlv=tonumber(d[2])
local netData=UIDiscipleModel:findSrcTypeDisciple(scrType)
local num=0
if netData then
if netData.jingjielv>=jjlv then
num=1
end
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscpleLTLevelNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleLTLevelChange,
clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIDiscipleModel:getDiscipleLTCount(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscpleJobNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIDiscipleModel:getDiscipleJobCount(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eZongMenLevel]={
events={clientCheckTaskTypeEventType.eZongMenLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local lv=zongmenModel:getLevel()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if lv>=aimnum then
state=taskModel.taskRewardState
end
return state,lv,aimnum
end,
},

[taskTypeClientCheckType.eBuildLevelNum]={
events={clientCheckTaskTypeEventType.eMountain,clientCheckTaskTypeEventType.eBuildLevelChange,
clientCheckTaskTypeEventType.eBuildComplete,clientCheckTaskTypeEventType.eBuildRemove,
clientCheckTaskTypeEventType.eBuildStart},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
local num=0
for i,v in ipairs(cfg.params)do

local d=string.split(v,'_')
local buildid=tonumber(d[1])
local buildlv=tonumber(d[2])
for j,w in pairs(mapIdType)do
local n=zongmenModel:getBuildNumEx(buildid,buildlv,w)
num=num+n
end
end
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eTalk]={
check=function(taskdata)
local state=taskModel.taskRewardState
return state,aimnum,aimnum
end,
},

[taskTypeClientCheckType.eDiscipleEquipNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove,
clientCheckTaskTypeEventType.eDiscipleEquipChange},
check=function(taskdata)
local cfg=taskdata.cfg
local check=false
local aimnum=cfg.aimnum
local num=0
for i,v in ipairs(cfg.params)do
local n=UIDiscipleModel:getDiscipleEquipCount(v)
if n>=aimnum then
check=true
break
end
end
local state=taskModel.taskDoingState
if check then
num=1
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eMoneyNum]={
events={clientCheckTaskTypeEventType.eMoneyChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=moneyModel.getMoney(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eCostGoodNum]={
events={clientCheckTaskTypeEventType.eItemChange,clientCheckTaskTypeEventType.eMoneyChange},
check=function(taskdata)
local cfg=taskdata.cfg
local itemid=cfg.params[1]
local num=itemsModel.getCount(itemid)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eWorldBlock]={
events={clientCheckTaskTypeEventType.eWorldBlockStateChange},
check=function(taskdata)
local cfg=taskdata.cfg
local param1=cfg.params[1]
local d=string.split(param1,'_')
local worldid=tonumber(d[1])
local blockid=tonumber(d[2])
local flag=worldBlockModel:checkBlockState(worldid,blockid,eWorldBlockState.OPEN)
local state=taskModel.taskDoingState
local num=0
local aimnum=cfg.aimnum
if flag then
state=taskModel.taskRewardState
num=aimnum
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eZongMenArea]={
events={clientCheckTaskTypeEventType.eMountain,clientCheckTaskTypeEventType.eZongMenAreaStateChange},
check=function(taskdata)
local cfg=taskdata.cfg
local param1=cfg.params[1]
local d=string.split(param1,'_')

local areaID=tonumber(d[2])
local flag=zongmenModel:isAreaUnlock(areaID)
local state=taskModel.taskDoingState
local num=0
local aimnum=cfg.aimnum
if flag then
state=taskModel.taskRewardState
num=aimnum
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eGuBaoColorNum]={
events={clientCheckTaskTypeEventType.eGuBaoNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=gubaoModel:getGuBaoColorNum(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eGuBaoActive]={
events={clientCheckTaskTypeEventType.eGuBaoNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local flag=gubaoModel:checkActive(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
local num=0
if flag then
num=1
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eShiLianTaLayer]={
events={clientCheckTaskTypeEventType.eShiLianTaInit,clientCheckTaskTypeEventType.eShiLianTaLayerChange},
check=function(taskdata)
local cfg=taskdata.cfg
local layer=shiLianTaModel:getClearLayer()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if layer>=aimnum then
state=taskModel.taskRewardState
end
return state,layer,aimnum
end,
},

[taskTypeClientCheckType.eSelfFamily]={
events={clientCheckTaskTypeEventType.eFamilyInit,clientCheckTaskTypeEventType.eFamilyStateChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=worldXiuZhenJiaZuModel:getAllSelfFamilyDataCount()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscipleManager]={
events={clientCheckTaskTypeEventType.eDiscipleManagerChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=0
for i,v in ipairs(cfg.params)do
local bdDatas=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,v)
if bdDatas then
for _,vv in pairs(bdDatas)do
if tostring(vv.dizi_id)~='0'then
num=num+1
end
end
end
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXianZhanRoom]={
events={clientCheckTaskTypeEventType.eXianZhanRoomChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=xianzhanModel:getRoomCount()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscipleGongFaNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove,
clientCheckTaskTypeEventType.eDiscipleGongFaChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIDiscipleModel:getHasGongFaDZNum(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscipleNumGongFaNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove,
clientCheckTaskTypeEventType.eDiscipleGongFaChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIDiscipleModel:getHasGongFaNumDZNum(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eQianJiGeActiveSkillNum]={
events={clientCheckTaskTypeEventType.eQianJiGeUnlockSkill},
check=function(taskdata)
local cfg=taskdata.cfg
local num=QianJiGeModel:get_unlock_skill_num()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eZongMenFight]={
events={clientCheckTaskTypeEventType.eZongMenFightChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=playerModel:getActorFightValue()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscipleGongFaLevelNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove,
clientCheckTaskTypeEventType.eDiscipleGongFaChange,clientCheckTaskTypeEventType.eDiscipleGongFaLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local param1=cfg.params[1]
local d=string.split(param1,'_')
local gfID=tonumber(d[1])
local gfLv=tonumber(d[2])
local num=UIDiscipleModel:getHasGongFaLevelDZNum(gfID,gfLv)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eZheXianLingProgress]={
events={clientCheckTaskTypeEventType.eZheXianLingProgressChange},
check=function(taskdata)
local cfg=taskdata.cfg
local param1=cfg.params[1]
local d=string.split(param1,'_')
local book_id=tonumber(d[1])
local index=tonumber(d[2])
local flag=zheXianLingModel:checkFinish(book_id,index)
local num=flag==true and 1 or 0
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscipleFaBaoColorNum]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove,
clientCheckTaskTypeEventType.eDiscipleFaBaoChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIDiscipleModel:getDiscipleCount_FaBaoColor(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eHouShanShiLianNum]={
events={clientCheckTaskTypeEventType.eHouShanShiLianChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIHuanJingControl:getCurrentLevel()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eGuildOrderNum]={
events={clientCheckTaskTypeEventType.eGuildOrderChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=guildOrderModel:getOrderActiveNum(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.ePlotDZJingJieLevel]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleJJLevelChange,
clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local scrType=cfg.params[1]
local netData=UIDiscipleModel:findSrcTypeDisciple(scrType)
local num=0
if netData then
num=netData.jingjielv
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.ePlotDZLianTiLevel]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleLTLevelChange,
clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local scrType=cfg.params[1]
local netData=UIDiscipleModel:findSrcTypeDisciple(scrType)
local num=0
if netData then
num=netData.liantilv
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eInXianMeng]={
events={clientCheckTaskTypeEventType.eXianMengChange},
check=function(taskdata)
local cfg=taskdata.cfg
local flag=xianmengModel:hasXM()
local num=flag==true and 1 or 0
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eZongMenXianTuTimes]={
events={clientCheckTaskTypeEventType.eZongMenXianTuReward,clientCheckTaskTypeEventType.eXianTuChengJiuSystemInit},
check=function(taskdata)
local cfg=taskdata.cfg
local id=cfg.params[1]
local num=xiantuchengjiuModel:getZMXTTimes(id)or 0
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscipleTianMingNum]={
events={clientCheckTaskTypeEventType.eDiscipleTianMingChange,clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local tmLv=cfg.params[1]
local disciples=UIDiscipleModel:getAllDiscipleData()
local num=0
for i,v in pairs(disciples)do
local lv=UIDiscipleModel:getTianMingLevelEx(v.netData.net)
if lv>=tmLv then
num=num+1
end
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscipleSixAttrNum]={
events={clientCheckTaskTypeEventType.eDiscipleSixAttrChange,clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local params=string.split(cfg.params[1],'_')
local sixAttrId=tonumber(params[1])
local sixAttrValue=tonumber(params[2])
local num=0

local disciples=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(disciples)do
local value=v.netData.net.attrList[sixAttrId]
if value>=sixAttrValue then
num=num+1
end
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eGongFaColorNum]={
events={clientCheckTaskTypeEventType.eGongFaActive,clientCheckTaskTypeEventType.eCangJingGeBuildComplete},
check=function(taskdata)
local cfg=taskdata.cfg
local color=cfg.params[1]
local num=0

local init=false
if zongmenModel:findStorageCountByID(SLG_SYSTEM_TYPE.eCangJingGe)>0 then
init=true
else
for i,v in pairs(mapIdType)do
local count=zongmenModel:findBuildingCountByID(v,SLG_SYSTEM_TYPE.eCangJingGe)
if count>0 then
init=true
break
end
end
end

if init then
if color>0 then
num=UIGongFaModel:getAllCompletePageCountByColor(color,true)
else
num=UIGongFaModel:getAllCompletePageCountByColor(color,false)
end
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eGongFaYuanSuNum]={
events={clientCheckTaskTypeEventType.eGongFaActive,clientCheckTaskTypeEventType.eCangJingGeBuildComplete},
check=function(taskdata)
local cfg=taskdata.cfg
local yuansu=cfg.params[1]
local num=0

local init=false
if zongmenModel:findStorageCountByID(SLG_SYSTEM_TYPE.eCangJingGe)>0 then
init=true
else
for i,v in pairs(mapIdType)do
local count=zongmenModel:findBuildingCountByID(v,SLG_SYSTEM_TYPE.eCangJingGe)
if count>0 then
init=true
break
end
end
end
if init then
num=UIGongFaModel:getAllCompletePageCountByElements(yuansu)
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eGongFaStudyLevelNum]={
events={clientCheckTaskTypeEventType.eGongFaStudyLevelChange,clientCheckTaskTypeEventType.eGongFaSystemOpen},
check=function(taskdata)
local cfg=taskdata.cfg
local level=cfg.params[1]
local num=0
if systemModel.isOpen(SYSTEM_DEFINE.eCangJingGe)then
local gfList=UIGongFaModel:getAcitveGFList()
for gfId,gfData in pairs(gfList)do
local studyLv=UIGongFaModel:getStudyLevel(gfId)
if studyLv>=level then
num=num+1
end
end
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiscipleJobSkillLevelNum]={
events={clientCheckTaskTypeEventType.eDiscipleProSkillLevelChange,clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local params=string.split(cfg.params[1],'_')
local proSkillId=tonumber(params[1])
local proSkillValue=tonumber(params[2])
local num=0
local disciples=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(disciples)do
local value=UIDiscipleModel:getDiscipleJobLevelEx(v.netData.net,proSkillId)
if value>=proSkillValue then
num=num+1
end
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eEquipJingLianLevelNum]={
events={clientCheckTaskTypeEventType.eEquipNumChange,clientCheckTaskTypeEventType.eEquipJingLianLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local jinglian=cfg.params[1]


















local num=0
if jinglian==nil then
loggerUtil.logFMT('任务{0}的参数精炼等级未配置',cfg.id)
else
num=bagEquipControl:getJlCount(jinglian)
end

local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eFaBaoJingLianLevelNum]={
events={clientCheckTaskTypeEventType.eFaBaoNumChange,clientCheckTaskTypeEventType.eFabaoJilianLevelChange,clientCheckTaskTypeEventType.eFaBaoTuPo},
check=function(taskdata)
local cfg=taskdata.cfg
local jilian=cfg.params[1]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eFabaoJinglian]={ITEM_FILTER_COMPARE.eGreaterEquals,jilian}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabao


table.clear(temp)
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter,false,true)
for i,v in ipairs(baglist)do
table.insert(temp,v.itemguid)
end
local equiplist=fabaoModel.getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do

table.insert(temp,v.itemguid)

end

local num=#temp
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eBenMingFaBaoLingXingLevelNum]={
events={clientCheckTaskTypeEventType.eFaBaoNumChange,clientCheckTaskTypeEventType.eFabaoLingXingLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local lingxingLv=cfg.params[1]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eFabaoLingXingLv]={ITEM_FILTER_COMPARE.eGreaterEquals,lingxingLv}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabao
filter[ITEM_FILTER_TYPE.eItemType1]=FABAO_TYPE.eBenMing


table.clear(temp)
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter,false,true)
for i,v in ipairs(baglist)do
table.insert(temp,v.itemguid)
end
local equiplist=fabaoModel.getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do

table.insert(temp,v.itemguid)

end

local num=#temp
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDaoBingJingLianNum]={
events={clientCheckTaskTypeEventType.eDaoBingNumChange,clientCheckTaskTypeEventType.eDaoBingJingLianChange},
check=function(taskdata)
local cfg=taskdata.cfg
local jinglian=cfg.params[1]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eJinglianLv]={ITEM_FILTER_COMPARE.eGreaterEquals,jinglian}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eDaoBing


table.clear(temp)
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eDaoBingBag,filter,false,true)
for i,v in ipairs(baglist)do
table.insert(temp,v.itemguid)
end
local equiplist=daobingModel:getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do

table.insert(temp,v.itemguid)

end

local num=#temp
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDaoBingStarNum]={
events={clientCheckTaskTypeEventType.eDaoBingNumChange,clientCheckTaskTypeEventType.eDaoBingStarChange},
check=function(taskdata)
local cfg=taskdata.cfg
local star=cfg.params[1]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eStarLv]={ITEM_FILTER_COMPARE.eGreaterEquals,star}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eDaoBing


table.clear(temp)
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eDaoBingBag,filter,false,true)
for i,v in ipairs(baglist)do
table.insert(temp,v.itemguid)
end
local equiplist=daobingModel:getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do

table.insert(temp,v.itemguid)

end

local num=#temp
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eNPCRelationshipNum]={
events={clientCheckTaskTypeEventType.eNPCIntimacyChange},
check=function(taskdata)
local cfg=taskdata.cfg
local line=cfg.params[1]
local num=0
local list=npcModel:getAllNPCDataLookup()
for i,v in pairs(list)do
if(v.intimacy or 0)>=line then
num=num+1
end
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eWorldLeadMaxHurt]={
events={clientCheckTaskTypeEventType.eWorldLeaderMaxHurtChange},
check=function(taskdata)
local cfg=taskdata.cfg
local line=cfg.params[1]
local temp=worldLeaderModel:getTotalDamage()
local num=temp and mathHelper.int64_to_number(temp)or 0
local fmNum=XianJieFuMoModel:getTotaldamage()or 0
num=math.max(num,fmNum)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDouFaTaiWenDaoNum]={
events={clientCheckTaskTypeEventType.eWenDaoChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=douFaTaiModel:get_doufatai_wendao()or 0
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},


















[taskTypeClientCheckType.eYueLongChiLingYunNum]={
events={clientCheckTaskTypeEventType.eYueLongChiLingYunChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIAquariumControl:countTotalLingyun()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eExpeditionCatLevelNum]={
events={clientCheckTaskTypeEventType.eExpeditionCatLevelNumChange,clientCheckTaskTypeEventType.eExpeditionCatInit},
check=function(taskdata)
local cfg=taskdata.cfg
local level=cfg.params[1]
local num=wanBaoXunBaoDuiModel:caculationEmployeeLevelCatCount(level)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eExpeditionLevelEquipNum]={
events={clientCheckTaskTypeEventType.eExpeditionLevelEquipNumChange,clientCheckTaskTypeEventType.eExpeditionLevelEquipLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local jinglian=cfg.params[1]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eJinglianLv]={ITEM_FILTER_COMPARE.eGreaterEquals,jinglian}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eMaoMao


table.clear(temp)
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eMaoMaoBag,filter,false,true)
for i,v in ipairs(baglist)do
table.insert(temp,v.itemguid)
end
local equiplist=wanBaoXunBaoDuiModel:getMaomaoEquipedLookup()
equiplist=itemsFilterHelper.filterLookItems(equiplist,filter,true)
for i,v in ipairs(equiplist)do

table.insert(temp,v.itemguid)

end

local num=#temp
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eBenMingFaBaoLingXingTopLevel]={
events={clientCheckTaskTypeEventType.eFaBaoNumChange,clientCheckTaskTypeEventType.eFabaoLingXingLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
table.clear(filter)
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabao
filter[ITEM_FILTER_TYPE.eItemType1]=FABAO_TYPE.eBenMing
local num=0

local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter,false,true)
for i,v in ipairs(baglist)do
if v.itemData.lingxinglv>num then
num=v.itemData.lingxinglv
end
end
local equiplist=fabaoModel.getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do
if v.itemData.lingxinglv>num then
num=v.itemData.lingxinglv
end
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eHunrMonsterTeamStart]={
events={clientCheckTaskTypeEventType.eHuntMonsterTeamStart,clientCheckTaskTypeEventType.eHuntMonsterTeamStartClear},
check=function(taskdata)
local cfg=taskdata.cfg
local num=userActorArraySetting.get(ACTOR_SETTING_TYPE.eTaskNum,"HuntMonsterTeamStartCount",0)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDiZiSpiritRootLevelNum]={
events={clientCheckTaskTypeEventType.eDiZiLingGenLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local lglevel=cfg.params[1]
local num=UIDiscipleModel:getDiscipleCount_linggenLevel(lglevel)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eWuXingTaStarNum]={
events={clientCheckTaskTypeEventType.eWuXingTaInit,clientCheckTaskTypeEventType.eWuXingTaLayerChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=wuXingDianModel:getAllStar()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eWuXingTaLowestLayerNum]={
events={clientCheckTaskTypeEventType.eWuXingTaInit,clientCheckTaskTypeEventType.eWuXingTaLayerChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=wuXingDianModel:getWXMinLayer()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},


[taskTypeClientCheckType.eChengJiuDianShu]={
events={clientCheckTaskTypeEventType.eMoneyChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=moneyModel.getMoney(eMoneyType.mtXianTuAchieve)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},


[taskTypeClientCheckType.eWXDTongGuanLayer]={
events={clientCheckTaskTypeEventType.eWuXingTaLayerChange},
check=function(taskdata)
local cfg=taskdata.cfg
local wxdId=cfg.params[1]
local num=wuXingDianModel:getFinishLayer(wxdId)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},


[taskTypeClientCheckType.eEquipedXColorYStageFabao]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleRemove,
clientCheckTaskTypeEventType.eDiscipleEquipChange},
check=function(taskdata)
local cfg=taskdata.cfg
local needColor=cfg.params[1]
local needStage=cfg.params[2]
local aimnum=cfg.aimnum
local num=0
local dilist=UIDiscipleModel:getAllDiscipleDataX()

if dilist==nil then return taskModel.taskDoingState,num,aimnum end

for i,v in ipairs(dilist)do
local dzguid=v.netData.net.discipleguid
for _,equipType in pairs(EQUIP_SUIT_TYPES)do
local equip=equipsModel.getEquipByDizi(dzguid,equipType)
if equip then
local itemCfg=itemsConfig.getConfig(equip.itemid)
if needColor==itemCfg.color and needStage==itemCfg.stage then
num=num+1
end
end
end
end
local state=taskModel.taskDoingState
if num>=aimnum then
num=1
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},


[taskTypeClientCheckType.eZMFanRongDu]={
events={clientCheckTaskTypeEventType.eFanRongDuValueChange},
check=function(taskdata)
local num=prosperityModel:getTotalFRValue()
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eWuXingShengDianXLayer]={
events={clientCheckTaskTypeEventType.eWuXingTaLayerChange},
check=function(taskdata)
local cfg=taskdata.cfg
local wxdId=wuXingDianConfig.getSDType()
local num=wuXingDianModel:getFinishLayer(wxdId)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eZMFanRongDuLv]={
events={clientCheckTaskTypeEventType.eFanRongDuChange},
check=function(taskdata)
local num=prosperityModel:getProsperityLevel()
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},


[taskTypeClientCheckType.eYFLZnum_lv]={
events={clientCheckTaskTypeEventType.eYFLZnumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local lv=cfg.params[1]
local num=UIYuFuLingZhenControl:getLingZhenEquipedLevelNum(lv)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eZhenTuStudy]={
events={clientCheckTaskTypeEventType.eZhenTuStudyChange},
check=function(taskdata)
local cfg=taskdata.cfg
local ztId=cfg.params[1]
local flag=UIYuFuLingZhenControl:isZhenTuResearched(ztId)
local num=0
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if flag then
state=taskModel.taskRewardState
num=1
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eCoupleNum]={
events={clientCheckTaskTypeEventType.eCoupleNumChange},
check=function(taskdata)
local num=DiscipleCoupleModel:getDiscipleCoupleNum()
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eZhenTuYanJiuNum]={
events={clientCheckTaskTypeEventType.eZhenTuStudyChange},
check=function(taskdata)
local num=UIYuFuLingZhenControl:getZhenTuResearchedNum()
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDaZhenHasDzTeamNum]={
events={clientCheckTaskTypeEventType.eDaZhenTeamChange,clientCheckTaskTypeEventType.eShanMenDaZhenInitData},
check=function(taskdata)
local num=shanMenDaZhenModel:getDaZhenHasDzTeamNum()
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eZMDaoShiNum]={
events={clientCheckTaskTypeEventType.eZMDaoShiChange},
check=function(taskdata)
local num=ZongMenDaoShiModel:getZMDaoShiNum()
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eSFPYtgNum]={
events={clientCheckTaskTypeEventType.eSFPYtgNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local ygId=cfg.params[1]
local num=SiFangPingYaoModel:getSiFangPingYaoTgNum(ygId)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
local isopen=systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)
if isopen then
num=aimnum
end
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eYFLTGridNum]={
events={clientCheckTaskTypeEventType.eYFLTNumChange},
check=function(taskdata)
local num=YiFangLingTianModel:getPlantedGridNum()
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eYFLTUnlockGridNum]={
events={clientCheckTaskTypeEventType.eYFLTUnlockNumChange},
check=function(taskdata)
local num=YiFangLingTianModel:GetUnlockGridNum()
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDuJieXianDan]={
events={clientCheckTaskTypeEventType.eDuJieXianDanChange},
check=function(taskdata)
local num=jctjDuJieXianDanModel:getLianZhiJieDuanServerStartId()
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDJZBlhNum]={
events={clientCheckTaskTypeEventType.eDJZBlhNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local buildid=cfg.params[1]
local num=DuJieZhiBaoController:getDJZBlhNum(buildid)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDJZBwcNum]={
events={clientCheckTaskTypeEventType.eDJZBwcNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=DuJieZhiBaoController:getDJZBAllFinishNum()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.efeishengtaiNum]={
events={clientCheckTaskTypeEventType.eFeiShengTaiNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=FeiShengTaiModel:GetFSTRepair()
local aimnum=cfg.aimnum
local params=cfg.params[1]
local state=taskModel.taskDoingState
local flag=0
if num>=params then
state=taskModel.taskRewardState
flag=1
end
return state,flag,aimnum
end,
},

[taskTypeClientCheckType.eAirLevel]={
events={clientCheckTaskTypeEventType.eAirLevel},
check=function(taskdata)
local cfg=taskdata.cfg
local num=airGameEnterModel:getProgressNum()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eAccumulatedNum]={
events={clientCheckTaskTypeEventType.eAccumulatedNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local accutype=cfg.params[1]
local num=gameUtilityModel:getData_counter(accutype)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXFWDRankLevel]={
events={clientCheckTaskTypeEventType.eXFWDRankLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIXianFaWenDaoControl:countOrderLevel()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXFWDMostRankLevel]={
events={clientCheckTaskTypeEventType.eXFWDRankLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local lv=cfg.params[1]
local num=UIXianFaWenDaoControl:checkOrderRewardReceive(lv)and 1 or 0
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eTianMoJiejifen]={
events={clientCheckTaskTypeEventType.eTianMoJiejifenChange,clientCheckTaskTypeEventType.eTianMoJieInit},
check=function(taskdata)
local cfg=taskdata.cfg
local num=tianMoJieModel:getScore()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXunBaoShiLianLevel]={
events={clientCheckTaskTypeEventType.eXBSLLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local modeId=cfg.params[1]
local num=xunBaoShiLianModel:getCurrentLevelNumByModeId(modeId)
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eTianMoJieStage]={
events={clientCheckTaskTypeEventType.eTianMoJieStageChange,clientCheckTaskTypeEventType.eTianMoJieInit},
check=function(taskdata)
local cfg=taskdata.cfg
local num=tianMoJieModel:getStage()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eWenXinGuanNum]={
events={clientCheckTaskTypeEventType.eWenXinGuanChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=WenXinGuanModel:getAccuCount()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eHouShanLingZhenLevel]={
events={clientCheckTaskTypeEventType.eHouShanLingZhenLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num
local aimnum=cfg.aimnum
local typeId=cfg.params[1]
if not typeId or typeId<=0 then

num=UIHuanJingControl:getZLAllStMaxLayer()
else

num=UIHuanJingControl:getZLStMaxLayerByType(typeId)
end
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eTaskNpcTalk]={
events={clientCheckTaskTypeEventType.eTaskNpcTalk,},
check=function(taskdata)
local cfg=taskdata.cfg
local params=string.split(cfg.params[1],'_')
local NPCid=tonumber(params[1])
local treeid=tonumber(params[2])
local flag=taskModel:GetFinishTask(cfg.id)
local state=taskModel.taskDoingState
local num,aimnum=0,1
if flag then
state=taskModel.taskRewardState
num=1
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXJBLTechnologyLv]={
events={clientCheckTaskTypeEventType.eXJBLTechnologyLvChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num
local aimnum=cfg.aimnum
local tId=cfg.params[1]
if not tId or tId==0 then

local list=yandaotaiModel:getTechnologyList()or{}
local allLv=0
for id,lv in pairs(list)do
allLv=allLv+lv
end
num=allLv
else

num=yandaotaiModel:getTechnologyListLevel(tId)or 0
end
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},


[taskTypeClientCheckType.eXJCloudChange]={
events={clientCheckTaskTypeEventType.eXianJieCloudChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=xianjieModel:getCloudUnlockCount()
local aimnum=cfg.aimnum

local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eLYToJiuYuan]={
events={clientCheckTaskTypeEventType.eLaoYunToJiuYuan},
check=function(taskdata)
local cfg=taskdata.cfg
local num=UIPrisonModel:getJyCount()
local aimnum=cfg.aimnum

local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eCJXYStageEnd]={
events={clientCheckTaskTypeEventType.eCJXYStageInit,clientCheckTaskTypeEventType.eCJXYStageDataChange,clientCheckTaskTypeEventType.eCJXYStageChange,clientCheckTaskTypeEventType.eCJXYConditionChange},
check=function(taskdata)
local cfg=taskdata.cfg

local num=cfg.aimnum
local aimnum=cfg.aimnum

local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXianMoDiscipleNum]={
events={clientCheckTaskTypeEventType.eXianMoDiscipleNumChange},
check=function(taskdata)
local xianNum,moNum=UIDiscipleModel:getXianMoDiscipleCount()
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local type=cfg.params[1]
local state=taskModel.taskDoingState
local num=0
if type==0 then
num=xianNum+moNum
elseif type==1 then
num=xianNum
else
num=moNum
end
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXianYuEnterScene]={
events={clientCheckTaskTypeEventType.eXianYuEnterJoinFlagChange,clientCheckTaskTypeEventType.eXianJieCloudChange},
check=function(taskdata)
local cfg=taskdata.cfg
local num=xianjieController:checkInPlotScene2()and 0 or 1
local aimnum=cfg.aimnum

local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXJCloudIDIsUnlock]={
events={clientCheckTaskTypeEventType.eXianJieCloudChange},
check=function(taskdata)
local cfg=taskdata.cfg
local cloudid=cfg.params[1]
local cloudData=xianjieModel:getCloudData(cloudid)
local num=0
if cloudData then
local flag=cloudData:isUnlock()
if flag then
num=1
end
end
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDanFangUnlock]={
events={clientCheckTaskTypeEventType.eDanFangUnlockChange},
check=function(taskdata)
local cfg=taskdata.cfg
local dfid=cfg.params[1]
local aimnum=cfg.aimnum
local flag=UIDanYaoModel:isUnLock(dfid)
local num=0
local state=taskModel.taskDoingState
if flag then
num=1
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eCJXYStageBegin]={
events={clientCheckTaskTypeEventType.eCJXYStageInit,clientCheckTaskTypeEventType.eCJXYStageDataChange,clientCheckTaskTypeEventType.eCJXYStageChange,clientCheckTaskTypeEventType.eCJXYConditionChange},
check=function(taskdata)
local cfg=taskdata.cfg
local chapter_idx=cfg.params[1]
local check=seasonController:checkSeasonStageBegined(0,chapter_idx)
local num=check and 1 or 0
local aimnum=cfg.aimnum

local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eShouMoNum]={
events={clientCheckTaskTypeEventType.eShouMoNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local num=xianjieModel:GetShouMonum()
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eCJXYStageStory]={
events={clientCheckTaskTypeEventType.eCJXYStageStoryChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local chapter_idx=cfg.params[1]
local state=seasonModel:readOpenAnimRecord(0,chapter_idx)
local num=state==2 and 1 or 0
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eLittleWorldLv]={
events={clientCheckTaskTypeEventType.eLittleWorldLvChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local num=LittleWorldModel:getLittleWorldLevel()
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},


[taskTypeClientCheckType.eMYUnlock]={
events={clientCheckTaskTypeEventType.eLaoYuMoYuJieSuo},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local num=0
local state=taskModel.taskDoingState

if UIPrisonModel:getMoYuLockState()then
num=1
state=taskModel.taskRewardState
end

return state,num,aimnum
end,
},


[taskTypeClientCheckType.eMYUnlockRoomNum]={
events={clientCheckTaskTypeEventType.eLaoYuMoYuRoomNum},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local rooms=UIPrisonModel:getAllPrisonData()
local num=0
for lfId,lfData in pairs(rooms)do
local lytype=cfgHelper.get2(cfg_laofangconfig_get,lfData.lfConfId,"lytype")
if lytype==ePrisonRoomType.eMonster then
num=num+1
end
end




local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end

return state,num,aimnum
end,
},

[taskTypeClientCheckType.eGuBaoSuitActive]={
events={clientCheckTaskTypeEventType.eGuBaoNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local flag,num=gubaoModel:checkSuitActiveEx(cfg.params[1])
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if flag then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXianJunYanZhenLayer]={
events={clientCheckTaskTypeEventType.eXianJunYanZhenLayer},
check=function(taskdata)
local cfg=taskdata.cfg
local num=XianJunYanZhenModel:getMaxLayer()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eJiuYouTaLayer]={
events={clientCheckTaskTypeEventType.eJiuYouTaLayer},
check=function(taskdata)
local cfg=taskdata.cfg
local num=JiuYouTaModel:getClearLayer()
local aimnum=cfg.aimnum
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eYunZhouZhenQiStar]={
events={clientCheckTaskTypeEventType.eYunZhouZhenQiPosChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local color=tonumber(params[1])
local star=tonumber(params[2])
local num=XianYunGangModel:GetAllYunZhouZhenQiStar(color,star)
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eYunZhouZhenQiLv]={
events={clientCheckTaskTypeEventType.eYunZhouZhenQiPosChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local lv=cfg.params[1]
local num=XianYunGangModel:GetAllYunZhouZhenQiLv(lv)
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXSJZhenWuNum]={
events={clientCheckTaskTypeEventType.eXSJZhenWuChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local star=cfg.params[1]
local num=LittleWorldModel:getStarZhenWuNum(star)
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXSJXingChenNum]={
events={clientCheckTaskTypeEventType.eXSJXingChen},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local color=params[1]
local israre=params[2]
local num=xingChenHelper.getAllZhenXiNum(tonumber(color),tonumber(israre))
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXSJXingGuiWearXingChen]={
events={clientCheckTaskTypeEventType.eXSJXingChen},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local type=tonumber(params[1])
local israre=tonumber(params[2])
local num=xingChenHelper.getXingGuiWear(type,israre)
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXSJWearCiZhui]={
events={clientCheckTaskTypeEventType.eXSJXingChen},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local num=xingChenHelper.getXingGuiWearCiZhui(params)
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eXSJXingGuiLv]={
events={clientCheckTaskTypeEventType.eXSJXingGuiLv},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local id=tonumber(params[1])
local lv=tonumber(params[2])
local num=xingChenHelper.getXingGuitoLv(id,lv)
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eBagEquipFilterNum]={
events={clientCheckTaskTypeEventType.eBagEquipFilterNum},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local num=bagModel.getBagEquipFilterCount()
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eWanLingTaLevel]={
events={clientCheckTaskTypeEventType.eWanLingTaLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local num=wanLingTaModel:getTaLingLevel()
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},


[taskTypeClientCheckType.eDisciple_AttrValue]={
events={clientCheckTaskTypeEventType.eDiscipleAdd,clientCheckTaskTypeEventType.eDiscipleJJLevelChange,clientCheckTaskTypeEventType.eDiscipleLTLevelChange,clientCheckTaskTypeEventType.eDiscipleCuiTiChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local diziid=tonumber(params[1])
local attrType=tonumber(params[2])
local attrValue=-1
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
if attrType==14 then
attrValue=UIDiscipleModel:getDiscipleJJLevelEx(netData)or 0
elseif attrType==15 then
attrValue=netData.liantilv or 0
elseif attrType==36 then
attrValue=netData.qzctlv or 0
end
end
local state=taskModel.taskDoingState
if attrValue>=aimnum then
state=taskModel.taskRewardState
end
return state,attrValue,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_have]={
events={clientCheckTaskTypeEventType.eDiscipleAdd},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local diziid=cfg.params[1]
local dizinum=-1
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
dizinum=1
end
local state=taskModel.taskDoingState
if dizinum>=aimnum then
state=taskModel.taskRewardState
end
return state,dizinum,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_GongFaId]={
events={clientCheckTaskTypeEventType.eDiscipleGongFaChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local diziid=tonumber(params[1])
local gongfaid=tonumber(params[2])
local gfnum=0
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local gongfaidList=netData.gongfaidList or{}
for _,gfID in ipairs(gongfaidList)do
if gongfaid==gfID then
gfnum=1
end
end
end
local state=taskModel.taskDoingState
if gfnum>=aimnum then
state=taskModel.taskRewardState
end
return state,gfnum,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_FaBaoLvl]={
events={clientCheckTaskTypeEventType.eDiscipleFaBaoChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local diziid=cfg.params[1]
local fbstage=0
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local discipleguid=netData.discipleguid
local equip=fabaoModel.getFabaoByDizi(discipleguid)
if equip then
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
fbstage=itemConfig.stage or 0
end
end
local state=taskModel.taskDoingState
if fbstage>=aimnum then
state=taskModel.taskRewardState
end
return state,fbstage,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_FByuanyangLvl]={
events={clientCheckTaskTypeEventType.eFabaoLingXingLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local diziid=cfg.params[1]
local lxlv=-1
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local discipleguid=netData.discipleguid
local equip=fabaoModel.getFabaoByDizi(discipleguid)
if equip then
local itemguid=equip.itemguid
lxlv=fabaoModel.getLingXingLv(itemguid)or 0
end
end
local state=taskModel.taskDoingState
if lxlv>=aimnum then
state=taskModel.taskRewardState
end
return state,lxlv,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_TianmingLvl]={
events={clientCheckTaskTypeEventType.eDiscipleTianMingChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local diziid=cfg.params[1]
local tmlv=-1
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local discipleguid=netData.discipleguid
tmlv=UIDiscipleModel:getTianMingLevel(discipleguid)or 0
end
local state=taskModel.taskDoingState
if tmlv>=aimnum then
state=taskModel.taskRewardState
end
return state,tmlv,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_LinggenLvl]={
events={clientCheckTaskTypeEventType.eDiZiLingGenLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local diziid=cfg.params[1]
local lglv=-1
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local discipleguid=netData.discipleguid
lglv=UIDiscipleModel:getDiscipleTotalLinggenLevel(discipleguid)or 0
end
local state=taskModel.taskDoingState
if lglv>=aimnum then
state=taskModel.taskRewardState
end
return state,lglv,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_BYLinggenId]={
events={clientCheckTaskTypeEventType.eDiscipleLingGenChangeVary,clientCheckTaskTypeEventType.eDiscipleLingGenVary},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local diziid=tonumber(params[1])
local linggenid=tonumber(params[2])
local lgnum=-1
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local varysrid=netData.varysrid or 0
if linggenid==varysrid then
lgnum=1
end
end
local state=taskModel.taskDoingState
if lgnum>=aimnum then
state=taskModel.taskRewardState
end
return state,lgnum,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_LinggenMZ]={
events={clientCheckTaskTypeEventType.eDiscipleLingGenEquipBoard},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local diziid=tonumber(params[1])
local mzbkcolor=tonumber(params[2])
local mzbknum=0
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local discipleguid=netData.discipleguid
local hoardDatas=UIDiscipleModel:getDiscipleHoard(discipleguid)
for k,v in pairs(hoardDatas)do
if v.activelistlen>0 and v.activeList[1]then
local data=v.activeList[1]
local color=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,data.hoardid,'color')
if mzbkcolor==color then
mzbknum=mzbknum+1
end
end
end
end
local state=taskModel.taskDoingState
if mzbknum>=aimnum then
state=taskModel.taskRewardState
end
return state,mzbknum,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_haveEquipTZId]={
events={clientCheckTaskTypeEventType.eDiscipleEquipChange,clientCheckTaskTypeEventType.eEquipChongZhu},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local diziid=tonumber(params[1])
local _suitid=tonumber(params[2])
local suitnum=0
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local discipleguid=netData.discipleguid
for equipType=1,4 do
local equip=equipsHelper.getEquipByDizi(discipleguid,equipType)
if equip and equip.itemData and equip.itemData.suitid then
if _suitid==equip.itemData.suitid then
suitnum=suitnum+1
end
end
end
end
local state=taskModel.taskDoingState
if suitnum>=aimnum then
state=taskModel.taskRewardState
end
return state,suitnum,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_haveEquipLvl]={
events={clientCheckTaskTypeEventType.eDiscipleEquipChange,clientCheckTaskTypeEventType.eEquipJingLianLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local diziid=tonumber(params[1])
local equiplvl=tonumber(params[2])
local num=0
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local discipleguid=netData.discipleguid
for equipType=1,4 do
local equip=equipsHelper.getEquipByDizi(discipleguid,equipType)
if equip and equip.itemData and equip.itemData.jinglianlv then
if equip.itemData.jinglianlv>=equiplvl then
num=num+1
end
end
end
end
local state=taskModel.taskDoingState
if num>=aimnum then
state=taskModel.taskRewardState
end
return state,num,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_GongFaId_Layer]={
events={clientCheckTaskTypeEventType.eDiscipleGongFaLevelChange,clientCheckTaskTypeEventType.eDiscipleGongFaChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')
local diziid=tonumber(params[1])
local gongfaid=tonumber(params[2])
local gflv=0
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local gongfaList=netData.gongfaList or{}
for i1,v1 in ipairs(gongfaList)do
if gongfaid==v1.param_1 then
gflv=v1.param_2
end
end
end
local state=taskModel.taskDoingState
if gflv>=aimnum then
state=taskModel.taskRewardState
end
return state,gflv,aimnum
end,
},

[taskTypeClientCheckType.eGongFaId_Lvl]={
events={clientCheckTaskTypeEventType.eDiscipleGongFaLevelChange,clientCheckTaskTypeEventType.eGongFaStudyLevelChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local gongfaid=cfg.params[1]
local studylv=0
if UIGongFaModel:isGongFaActive(gongfaid)then
studylv=UIGongFaModel:getStudyLevel(gongfaid)
end
local state=taskModel.taskDoingState
if studylv>=aimnum then
state=taskModel.taskRewardState
end
return state,studylv,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_FaBao_LianHuaNum]={
events={clientCheckTaskTypeEventType.eDiscipleFaBaoChange,clientCheckTaskTypeEventType.eFabaoLianHuaChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local diziid=cfg.params[1]
local lhnum=-1
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local discipleguid=netData.discipleguid
local equip=fabaoModel.getFabaoByDizi(discipleguid)
if equip then
local leftNum,tNum=fabaoHelper.getLianhuaLeftNum(equip.itemguid)
lhnum=tNum-leftNum
end
end
local state=taskModel.taskDoingState
if lhnum>=aimnum then
state=taskModel.taskRewardState
end
return state,lhnum,aimnum
end,
},

[taskTypeClientCheckType.eFaBao_Color_JingLianLvl]={
events={clientCheckTaskTypeEventType.eFabaoJilianLevelChange,clientCheckTaskTypeEventType.eFaBaoTuPo},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')


local fbtype=tonumber(params[1])
local fbcolor=tonumber(params[2])
local jilianlv=0

table.clear(filter)
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,fbcolor}

filter[ITEM_FILTER_TYPE.eFaBaoMaterialsType]={ITEM_FILTER_COMPARE.eEquals,{fbtype}}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabao


table.clear(temp)
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter,false,true)
for i,v in ipairs(baglist)do
if v.itemData.jilianlv>jilianlv then
jilianlv=v.itemData.jilianlv
end
end
local equiplist=fabaoModel.getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do
if v.itemData.jilianlv>jilianlv then
jilianlv=v.itemData.jilianlv
end
end
local state=taskModel.taskDoingState
if jilianlv>=aimnum then
state=taskModel.taskRewardState
end
return state,jilianlv,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_DaoYan_lv]={
events={clientCheckTaskTypeEventType.eDiscipleDaoYanLvChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local diziid=cfg.params[1]
local lv=-1
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local discipleguid=netData.discipleguid
lv=UIDiscipleModel:getDaoYanLevel(discipleguid)or 0
end
local state=taskModel.taskDoingState
if lv>=aimnum then
state=taskModel.taskRewardState
end
return state,lv,aimnum
end,
},

[taskTypeClientCheckType.eDisciple_FaBaoid_fbcolor]={
events={clientCheckTaskTypeEventType.eDiscipleFaBaoChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local params=string.split(cfg.params[1],'_')


local diziid=tonumber(params[1])
local yptype=tonumber(params[2])
local fbcolor=tonumber(params[3])
local _num=0

local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziid)
if netData then
local discipleguid=netData.discipleguid
local fabao=fabaoModel.getFabaoByDizi(discipleguid)
if fabao then
local itemConfig=itemsConfig.getConfig(fabao.itemid)
if itemConfig.color>=fbcolor then
local isBenMingFabao=fabaoConfig.isBenMingFabao(fabao.itemid)
if isBenMingFabao then
local mainid=fabaoHelper.getMainId(fabao)
local _cfg=itemsConfig.getConfig(mainid)
if _cfg and _cfg.type1 and _cfg.type1==yptype then
_num=1
end
end
end
end
end
local state=taskModel.taskDoingState
if _num>=aimnum then
state=taskModel.taskRewardState
end
return state,_num,aimnum
end,
},

[taskTypeClientCheckType.eLingShouCount]={
events={clientCheckTaskTypeEventType.eLingShouNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local lsCount=lingshouModel:getLSCount()
local state=taskModel.taskDoingState
if lsCount>=aimnum then
state=taskModel.taskRewardState
end
return state,lsCount,aimnum
end,
},

[taskTypeClientCheckType.eEquipLingShouDiscipleCount]={
events={clientCheckTaskTypeEventType.eDiscipleChangeEquipLingShou,clientCheckTaskTypeEventType.eDiscipleRemove},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local equipLsDzCount=lingshouModel:getEquipLsDiscipleCount()
local state=taskModel.taskDoingState
if equipLsDzCount>=aimnum then
state=taskModel.taskRewardState
end
return state,equipLsDzCount,aimnum
end,
},

[taskTypeClientCheckType.eLingShouCount_JingJieLvl]={
events={clientCheckTaskTypeEventType.eLingShouJingJieChange,clientCheckTaskTypeEventType.eLingShouNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local jjLv=cfg.params[1]
local lsCount_jjLv=lingshouModel:getLingShouJJCount(jjLv)
local state=taskModel.taskDoingState
if lsCount_jjLv>=aimnum then
state=taskModel.taskRewardState
end
return state,lsCount_jjLv,aimnum
end,
},

[taskTypeClientCheckType.eShouLanLsCount]={
events={clientCheckTaskTypeEventType.eShouLanLsChange,},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local count=UIShouLanModel:getShouLanHasLsCount()
local state=taskModel.taskDoingState
if count>=aimnum then
state=taskModel.taskRewardState
end
return state,count,aimnum
end,
},

[taskTypeClientCheckType.eShouLanDzCount]={
events={clientCheckTaskTypeEventType.eDiscipleManagerChange,},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local count=UIShouLanModel:getShouLanHasDzCount()
local state=taskModel.taskDoingState
if count>=aimnum then
state=taskModel.taskRewardState
end
return state,count,aimnum
end,
},

[taskTypeClientCheckType.eLingShouCount_XueMaiLvl]={
events={clientCheckTaskTypeEventType.eLingShouXueMaiChange,clientCheckTaskTypeEventType.eLingShouNumChange},
check=function(taskdata)
local cfg=taskdata.cfg
local aimnum=cfg.aimnum
local lv=cfg.params[1]
local lsCount_xmLv=lingshouModel:findLingShouXueMaiLv(lv)
local state=taskModel.taskDoingState
if lsCount_xmLv>=aimnum then
state=taskModel.taskRewardState
end
return state,lsCount_xmLv,aimnum
end,
},
}


function taskModel:disposeClientCheckTaskTypeEvent(eventType)

local tasklist=taskModel:getTaskList()
for i,v in ipairs(tasklist)do
if v.taskstate==taskModel.taskDoingState or v.taskstate==taskModel.taskRewardState then
local tasktype=v.cfg.tasktype
local clientCheck=taskModel:checkClientCheckTask(tasktype)
if clientCheck~=nil and taskModel:checkClientCheckTaskEvent(tasktype,eventType)then
local old_taskstateResult=taskModel:getTaskState(v)
local old_state=old_taskstateResult.state
taskModel:setTaskStateChangeFlag(v.taskid,true)
local new_taskstateResult=taskModel:getTaskState(v)
local new_state=new_taskstateResult.state
local cur_num=new_taskstateResult.curnum
local old_num=old_taskstateResult.curnum
if old_state~=new_state then

notifySystem:postNotify(notifyConfig.onTaskChange,v.taskid,new_state)
elseif old_num~=cur_num then

notifySystem:postNotify(notifyConfig.onTaskChange,v.taskid,new_state,cur_num,old_num)
end
end
end
end


xiantuchengjiuController:triggerClientCheckTaskTypeEvent(eventType)
taskController:triggerRecalculateTaskCount(eventType)
notifySystem:postNotify(notifyConfig.onDisposeClientCheckTaskTypeEvent,eventType)
end
function taskModel:disposeAllClientCheckTaskTypeEvent()

local tasklist=taskModel:getTaskList()
for i,v in ipairs(tasklist)do
if v.taskstate==taskModel.taskDoingState or v.taskstate==taskModel.taskRewardState then
local tasktype=v.cfg.tasktype
local clientCheck=taskModel:checkClientCheckTask(tasktype)
if clientCheck~=nil then
local old_taskstateResult=taskModel:getTaskState(v)
local old_state=old_taskstateResult.state
taskModel:setTaskStateChangeFlag(v.taskid,true)
local new_taskstateResult=taskModel:getTaskState(v)
local new_state=new_taskstateResult.state
local cur_num=new_taskstateResult.curnum
local old_num=old_taskstateResult.curnum
if old_state~=new_state then

notifySystem:postNotify(notifyConfig.onTaskChange,v.taskid,new_state)
elseif old_num~=cur_num then

notifySystem:postNotify(notifyConfig.onTaskChange,v.taskid,new_state,cur_num,old_num)
end
end
end
end
end

function taskModel:initTaskStateChangeFlag()
taskStateChangeFlag={}
end

function taskModel:setTaskStateChangeFlag(taskid,flag)
taskStateChangeFlag[taskid]=flag
end

function taskModel:getTaskStateChangeFlag(taskid)
return taskStateChangeFlag[taskid]
end

function taskModel:getClientCheckHandle(tasktype)
local checkClass=taskTypeClientCheckState[tasktype]
if checkClass then
return checkClass.check
else
loggerUtil.logErrFMT("没有对应任务类型的前端计数处理：{0}",tasktype)
end
end

function taskModel:findTaskTypeByTaskEvent(eventType)
local list={}
for tasktype,checkClass in pairs(taskTypeClientCheckState)do
if checkClass.events and table.containsValue(checkClass.events,eventType)then
table.insert(list,tasktype)
end
end
return list
end

function taskModel:checkClientCheckTaskEvent(tasktype,eventType)
local checkClass=taskTypeClientCheckState[tasktype]
if checkClass then
local events=checkClass.events
if events then
for i,v in ipairs(events)do
if v==eventType then
return true
end
end
end
end
return false
end

function taskModel:checkClientCheckTask(tasktype)
return cfgHelper.get3(cfg_taskbaseconfig_get,1,'task_check_flag',tasktype)
end

function taskModel:setTaskState(taskdata,taskstate)
taskdata.taskstate=taskstate
if taskdata.oldStateData~=nil then
taskdata.oldStateData.state=taskstate
end
if taskstate==taskModel.taskDoingState then
taskModel:setTaskStateChangeFlag(taskdata.taskid,true)
end
end



function taskModel:getTaskState(taskdata)
local taskcfg=taskdata.cfg
local result
local replace=false
if taskdata.taskstate==taskModel.taskDoingState or taskdata.taskstate==taskModel.taskRewardState then
local checkClass=nil
local clientCheck=taskModel:checkClientCheckTask(taskcfg.tasktype)
if clientCheck~=nil then
checkClass=taskTypeClientCheckState[taskcfg.tasktype]





end
if checkClass~=nil then
local checkFlag=taskModel:getTaskStateChangeFlag(taskdata.taskid)
if checkFlag==nil or checkFlag==true or taskdata.oldStateData==nil then
local state,curnum,maxnum=checkClass.check(taskdata)
result={state=state,curnum=curnum,maxnum=maxnum}
taskdata.oldStateData=result
taskModel:setTaskStateChangeFlag(taskdata.taskid,false)
else
result=taskdata.oldStateData
end
replace=true
end
end

if not replace then
result={state=taskdata.taskstate,curnum=taskdata.taskprogress,maxnum=taskcfg.aimnum}
end
result.aimparams=taskcfg.params
return result
end
function taskModel:getTaskState_transfromstate(taskdata)
local taskstateResult=taskModel:getTaskState(taskdata)
return taskstateResult.state
end















function taskModel:getTaskPrefixName(taskline)
local systemZM_ID=systemZongMenModel:getTaskBelongImp(taskline)

local name=""
if systemZM_ID then
name=taskPrefixName.lineSystemZongMen
elseif taskline==1 then
name=taskPrefixName[taskline]
elseif taskModel:isXianJieTask(taskline)then
name=taskPrefixName.lineXianJie
else
name=taskPrefixName.lineElse
end
if pfwindowslController:checkIsGameVersion_oumei()then
name=string.format('[%s]',name)
else
name=string.format('【%s】',name)
end
return name
end

function taskModel:getTaskPrefixAndName(taskcfg)
local prefix=taskModel:getTaskPrefixName(taskcfg.tasklineid)
local name=taskcfg.name
return prefix..name
end
