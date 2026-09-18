






local levelConditionTypeEnum={
ZMLevel=1,
ServerOpenDay=2,
OpenSysDay=3,
}
local levelConditionFunc={
[levelConditionTypeEnum.ZMLevel]={
checkCondition=function(params)
local zmNeedLv=params[2]

local zmlv=zongmenModel:getLevel()
return zmlv>=zmNeedLv
end,
getDesc=function(params)
local zmNeedLv=params[2]
return FMT.fmt("宗门{0}级",zmNeedLv)
end
},
[levelConditionTypeEnum.ServerOpenDay]={
checkCondition=function(params)
local needOpenDay=params[2]
local openDay=timeHelper.getServerOpenDay()
return openDay>=needOpenDay
end,
getDesc=function(params)
local needOpenDay=params[2]
return FMT.fmt("开服第{0}天",needOpenDay)
end
},
[levelConditionTypeEnum.OpenSysDay]={
checkCondition=function(params)
local needOpenDay=params[2]
local openTime=airGameEnterModel:getOpenSec()
if openTime==0 then
local date=airGameEnterConfig.getFbConstConfig('open_time')
openTime=timeHelper.convertShortStamp(timeHelper.getDateStamp(date))
end
local now=airController:getRealServerTime_short()
local openDay=(now-openTime)/86400
return openDay>=needOpenDay
end,
getDesc=function(params)
local needOpenDay=params[2]
local openTime=airGameEnterModel:getOpenSec()
if openTime==0 then
local date=airGameEnterConfig.getFbConstConfig('open_time')
openTime=timeHelper.convertShortStamp(timeHelper.getDateStamp(date))
end
local now=airController:getRealServerTime_short()
local openDay=math.floor((now-openTime)/86400)
return FMT.fmt("{0}天后",needOpenDay-openDay)
end
},
}


airGameEnterConfig={}


airGameEnterConfig.stageStateEnum={
FreeTimes=1,
BuyTimes=2,
LockCondition=3,
FinishStage=4,
FinishAllStage=5,
FirstFree=6,
}



function airGameEnterConfig.getLevelConfig(groupId,levelId,name)
local val=cfgHelper.get3(cfg_airgamepushmaplevelconfig_get,groupId,levelId,name)
return val
end

function airGameEnterConfig.getFbConfig(fbId,name)
local fbCfg=cfgHelper.get2(cfg_airfubenconfig_get,fbId,name)
return fbCfg
end

function airGameEnterConfig.getFbConfigEx(groupId,levelId,name)
local fbId=airGameEnterConfig.getLevelConfig(groupId,levelId,'fbid')
if fbId then
return airGameEnterConfig.getFbConfig(fbId,name)
end
end

function airGameEnterConfig.getFbConstConfig(name)
return cfgHelper.getdef1(cfg_airfubenconfig,name)
end

function airGameEnterConfig.getPrepareShowAttrCfgList()
local attrAllCfg=cfg_airattributesconfig()
local mainAtrrList={}
for index,attrCfg in ipairs(attrAllCfg)do
if attrCfg.isPrepareShow then
mainAtrrList[#mainAtrrList+1]=attrCfg
end
end

if#mainAtrrList>0 then
table.sort(mainAtrrList,function(a,b)
return a.showSortId<b.showSortId
end)
end

return mainAtrrList
end

function airGameEnterConfig.transToInitAttrVal(dSixValList,iTypeCfg)
local ival=0
local sixAttrType=0

local all=cfg_dizisixattrtransformconfig()
local iTypeId=iTypeCfg.id
local attrTransConfig=all[iTypeId]
if attrTransConfig and attrTransConfig.sixAttrId and dSixValList[attrTransConfig.sixAttrId]then
sixAttrType=attrTransConfig.sixAttrId
local baseVal=dSixValList[attrTransConfig.sixAttrId]


ival=baseVal*attrTransConfig.val

local iAttrCfg=cfgHelper.get(cfg_airattributesconfig_get,iTypeId)
if iAttrCfg.flag==1 then

ival=math.floor(ival)
end
end




return ival,sixAttrType
end

function airGameEnterConfig.getLevelShowReward(group,level)
local fbid=airGameEnterConfig.getLevelConfig(group,level,"fbid")
local showList=airGameEnterConfig.getFbConfig(fbid,"succRewards")
return showList
end

function airGameEnterConfig.checkOpenCondition(condition)
if condition and next(condition)then
for index,params in ipairs(condition)do
local type=params[1]
if levelConditionFunc[type]and levelConditionFunc[type].checkCondition then
if not levelConditionFunc[type].checkCondition(params)then
return false
end
end
end
end
return true
end

function airGameEnterConfig.checkOpenConditionDesc(condition)
local desc
for index,params in ipairs(condition)do
local type=params[1]
if levelConditionFunc[type]and levelConditionFunc[type].getDesc and not levelConditionFunc[type].checkCondition(params)then
local tDesc=levelConditionFunc[type].getDesc(params)
if desc then
desc=FMT.fmt("{0}且{1}",desc,tDesc)
else
desc=tDesc
end
end
end
desc=desc and FMT.fmt("{0}{1}",desc,'开启')or""
return desc
end

function airGameEnterConfig.checkOpenConditionDescEx(group,curLevel)
local openCond=airGameEnterConfig.getFbConfigEx(group,curLevel,'openCond')
local desc=""
if openCond then
desc=airGameEnterConfig.checkOpenConditionDesc(openCond)
end
return desc
end

function airGameEnterConfig.getEquipProp(curLevelState)

end

function airGameEnterConfig.checkXianBaoOpenCondition(condition)
if condition then
local group=airGameEnterModel:getGroup()
local level=airGameEnterModel:getLevel()


local needGroup=condition[1]
local needLevel=condition[2]

if group>needGroup then return true end
return group>=needGroup and level>=needLevel
end
return true
end

function airGameEnterConfig.checkXianBaoOpenConditionDesc(condition)
if condition then
local needGroup=condition[1]
local needLevel=condition[2]
local groupCfg=cfgHelper.get1(cfg_airgamepushmapgroupconfig_get,needGroup)
if groupCfg then
local groupName=groupCfg.name
local info=FMT.fmt("需通关{0}第{1}关",groupName,needLevel)
return info
end
end
return""
end

function airGameEnterConfig.getChengJiuDesc(cjData)
local cjId=cjData.id
local cjCfg=cfgHelper.get1(cfg_airchengjiuconfig_get,cjId)

local params={}
if cjCfg.desc_fmt_params~=nil and next(cjCfg.desc_fmt_params)then
for index,paramData in ipairs(cjCfg.desc_fmt_params)do
local paramType=paramData[1]
local val=cjData.params and cjData.params[1]or 0
local aim=cjCfg.aim
if paramType==1 then
params[#params+1]=Mathf.Min(val,aim)
elseif paramType==2 then
local result=val>=aim
local colorStr=result and"#549327"or"#c82c2c"
params[#params+1]=colorStr
elseif paramType==3 then
params[#params+1]=aim
end
end
end

local desc=FMT.fmt(cjCfg.desc_fmt,unpack(params))
return desc
end

function airGameEnterConfig.getChenJiuTabList()

return cfg_airchengjiutabconfig()
end

function airGameEnterConfig.checkVocationUnLock(voc)
if voc==0 then return true end

local vocUnlockCondition=cfgHelper.get2(cfg_airvocationconfig_get,voc,'unlock_condition')


if vocUnlockCondition then
for index,condition in ipairs(vocUnlockCondition)do
local type=condition[1]
if type==1 then
local group=airGameEnterModel:getGroup()
local level=airGameEnterModel:getLevel()
local needGroup=condition[2]
local needLevel=condition[3]

if needGroup>group then
return false
else
if needLevel>level then
return false
end
end
end
end
end

return true
end

function airGameEnterConfig:getVocationUnLockTips(voc)
local vocUnlockCondition=cfgHelper.get2(cfg_airvocationconfig_get,voc,'unlock_condition')

local str


if vocUnlockCondition then
for index,condition in ipairs(vocUnlockCondition)do
local type=condition[1]
if type==1 then
local needGroup=condition[2]
local needLevel=condition[3]

local info=FMT.fmt("通关{0}卷第{1}关",needGroup,needLevel)
str=str and FMT.fmt("{0}并且{1}",str,info)or info
end
end
end

return str
end

function airGameEnterConfig.getOpenVocCfgList()
local allCfg=cfg_disciplevocationconfig()

local tempCfgList={}

local zmlv=zongmenModel:getLevel()

for index,vocCfg in pairs(allCfg)do
if airGameEnterConfig.checkVocationUnLock(index)then
if zmlv>=vocCfg.level then
if vocCfg.system then
if systemModel.isOpen(vocCfg.system)then
tempCfgList[#tempCfgList+1]=vocCfg
end
else
tempCfgList[#tempCfgList+1]=vocCfg
end
end
end
end

table.sort(tempCfgList,function(a,b)
return a.id<b.id
end)

return tempCfgList
end

function airGameEnterConfig.getAirItemCfg(itemid)
local itemCfg=cfgHelper.get1(cfg_airitemconfig_get,itemid)
if itemCfg then
return itemCfg,2
end

local equipCfg=cfgHelper.get1(cfg_airweaponconfig_get,itemid)
if equipCfg then
return equipCfg,1
end
end
