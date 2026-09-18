







systemZongMenModel={}

local _camp_icon={
[systemZongMenCampType.eZhengDao]="icon_sebiaoshi_1",
[systemZongMenCampType.eZhongLi]="icon_sebiaoshi_3",
[systemZongMenCampType.eXieDao]="icon_sebiaoshi_2",
}
local _camp_ab="ui/windows/home/sharedtextures/zminfo.ab"


local _tempRewards=nil
local _tempRewards2=nil
local _taskLines={}

local _visitPrivilegeCheck={
[systemZongMenVisitPrivilegeType.eTaskFinish]={
check=function(param)
return taskModel:checkTaskFinish(param)
end,
tips=function(param)
local taskName=cfgHelper.get2(cfg_taskconfig_get,param,"name")
return FMT.fmt("需要完成\"{0}\"任务",taskName)
end,
}
}

function systemZongMenModel:initData()
self.data={}
end

function systemZongMenModel:clearData()
self.data=nil
end

function systemZongMenModel:initConfig()
local config=cfg_syssectconfig()
for i,v in pairs(config)do
local taskcfg=taskModel:getTaskConfig(v.firstTaskId)
_taskLines[taskcfg.tasklineid]=i
end
end




function systemZongMenModel:initInfoList(num,infoList_)
local infoList={}
self:clearOutgoerData()
self:clearFightFlagLookup()

local posList={}
local outgoerList={}
for i,v in ipairs(infoList_ or{})do
v.guid=mathHelper.concatToInt64(worldPositionLibrary.eSelfIncreasingType.eSystemZongMen,v.serial)
table.insert(posList,v.guid)
end
worldPositionLibrary:checkData(eWorldUnitTpye.SYSTEMZM,posList)
worldPositionLibrary:checkDataEx(eWorldUnitTpye.SYSTEMZM_OUTGOER,outgoerList)
if num>0 then
for i,v in ipairs(infoList_)do
systemZongMenModel:handleInfoData(v)
table.insert(infoList,v)
end
end
local infoLookup={}
for i,v in ipairs(infoList)do
infoLookup[v.serial_str]=v
end
self.data.infoList=infoList
self.data.infoLookup=infoLookup
end

function systemZongMenModel:addInfoData(infoData)
if self.data==nil then return end
if self.data.infoList then
infoData.guid=mathHelper.concatToInt64(worldPositionLibrary.eSelfIncreasingType.eSystemZongMen,infoData.serial)
systemZongMenModel:handleInfoData(infoData)
table.insert(self.data.infoList,infoData)
self.data.infoLookup[infoData.serial_str]=infoData
end
end

function systemZongMenModel:checkNextTask(serial,taskId)
if taskId>0 then
local taskCfg=cfgHelper.get1(cfg_taskconfig_get,taskId)
if taskCfg.nextid and not taskModel:hasTask(taskCfg.nextid)then
taskModel:addNewTask(taskCfg.nextid)
end
else
local infoData=self:getInfoData(serial)
local config=cfgHelper.get1(cfg_syssectconfig_get,infoData.id)
if config.firstTaskId then
local taskcfg=taskModel:getTaskConfig(config.firstTaskId)
local taskdata=taskModel:getTaskByLine(taskcfg.tasklineid)
if taskdata==nil then
taskModel:addNewTask(config.firstTaskId)
end
end
end
end


function systemZongMenModel:handleInfoData(infoData)
local serial_str=tostring(infoData.serial)

infoData.moneyLookup={}
if infoData.money_num>0 then
for i,v in ipairs(infoData.moneyList)do
infoData.moneyLookup[v.param_1]=v.param_2
end
else
infoData.moneyList={}
end
for i,v in pairs(systemZongMenInfoMoneyType)do
if not infoData.moneyLookup[v]then
infoData.moneyLookup[v]=0
table.insert(infoData.moneyList,{param_1=v,param_2=0})
end
end

infoData.serial_str=serial_str
infoData.disciple_guid=infoData.disciple_guid or int64.zero
infoData.end_time=self:getFightFlagEndTime(infoData)

if infoData.start_time<0 and infoData.flag==systemZongMenFightFlagType.eVassal then
infoData.relation_num=systemZongMenRelationType.eFuYong
end

self:placeInfoData(infoData)

self:setOutgoerDatas(infoData)

self:checkTaskInit(infoData)

self:checkAddFightFlagLookup(infoData)
end

function systemZongMenModel:checkTaskInit(infoData)
if initProControl.isDone()then
local taskLookup=taskModel:filterCurTaskLine()
local firstTaskId=cfgHelper.get2(cfg_syssectconfig_get,infoData.id,"firstTaskId")
local taskCfg=taskModel:getTaskConfig(firstTaskId)
if not taskLookup[taskCfg.tasklineid]then
taskModel:addNewTask(firstTaskId)
end
end
end

function systemZongMenModel:getInfoData(serial)
if self.data==nil then return end
local infoLookup=self.data.infoLookup
if infoLookup then
local serial_str=tostring(serial)
return infoLookup[serial_str]
end
return nil
end

function systemZongMenModel:setGlobalNum(funcType,num)
if self.data==nil then return end
if self.data.global==nil then
self.data.global={}
end
self.data.global[funcType]=num
end

function systemZongMenModel:getGlobalNum(funcType)
if self.data==nil then return end
if self.data.global then
return self.data.global[funcType]
end
end

function systemZongMenModel:checkTanYinTips()
if self.data==nil then return false end
local infoList=self:getInfoList()
if#infoList<=0 then return false end
local curr=self:getGlobalNum(systemZongMenFuncType.eTaYin)
local maxNum=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"tayin","day_num")
return curr<maxNum
end

function systemZongMenModel:getReddot_Renown(serial)
local infoData=systemZongMenModel:getInfoData(serial)
local reputationValue=infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local reputationIndex=systemZongMenModel:getRenownIndex(infoData.id,reputationValue)
local rewardList=cfgHelper.get2(cfg_syssectconfig_get,infoData.id,"renownRewards")
for i=1,reputationIndex do
local list=rewardList[i]
for ii,v in ipairs(list)do
if v[1]==systemZongMenRenownRewardType.eReward and i>infoData.sw_reward then
return true
end
end
end
return false
end

function systemZongMenModel:getReddot_FightFlag(serial)
local infoData=systemZongMenModel:getInfoData(serial)
return infoData.flag==systemZongMenFightFlagType.eSurrender
end

function systemZongMenModel:getReddot(serial)
return self:getReddot_Renown(serial)or self:getReddot_FightFlag(serial)
end

function systemZongMenModel:getWorldReddot(world)
local infoList=self:getInfoList()
for i,v in ipairs(infoList)do
if world==v.worldId and self:getReddot(v.serial)then
return true
end
end
return false
end

function systemZongMenModel:getAllReddot()
local infoList=self:getInfoList()
for i,v in ipairs(infoList)do
if self:getReddot(v.serial)then
return true
end
end
return false
end


function systemZongMenModel:haveSGReward()
local infoList=systemZongMenModel:getInfoList()
for index,infoData in ipairs(infoList)do
if infoData.sg_reward_num>0 then
return true
end
end
return false
end




function systemZongMenModel:initDetailInfo(partType,data)
local detailList=self.data.detailList
if detailList==nil then
detailList={}
self.data.detailList=detailList
end
systemZongMenModel:handelDetailData(data)
local serial_str=data.serial_str
if detailList[serial_str]==nil then
detailList[serial_str]={}
end
detailList[serial_str][partType]=data
end

function systemZongMenModel:handelDetailData(data)
local serial_str=tostring(data.serial)
data.serial_str=serial_str
end

function systemZongMenModel:getDetailInfo(serial)
local detailList=self.data.detailList
if detailList then
local serial_str=tostring(serial)
return detailList[serial_str]
end
return nil
end

function systemZongMenModel:getDetailPartInfo(serial,partType)
local detailList=self.data.detailList
if detailList then
local serial_str=tostring(serial)
if detailList[serial_str]then
return detailList[serial_str][partType]
end
end
return nil
end

function systemZongMenModel:clearDetailInfo(serial)
if self.data==nil then return end
local detailList=self.data.detailList
if detailList then
local serial_str=tostring(serial)
if detailList[serial_str]then
detailList[serial_str]=nil
end
end
end

function systemZongMenModel:clearDetailPartInfo(serial,partType)
if self.data==nil then return end
local detailList=self.data.detailList
if detailList then
local serial_str=tostring(serial)
if detailList[serial_str]then
detailList[serial_str][partType]=nil
end
end
end

function systemZongMenModel:checkDetailPartInfo(serial,partType)
local detailList=self.data.detailList
if detailList then
local serial_str=tostring(serial)
if detailList[serial_str]then
return detailList[serial_str][partType]~=nil
end
end
return false
end

function systemZongMenModel:getAllDetailPartInfo()
return self.data.detailList
end




function systemZongMenModel:deleteZongMen(serial)
if self.data==nil then return end
local serial_str=tostring(serial)
local infoLookup=self.data.infoLookup
local guid=nil
if infoLookup then
local lookup=infoLookup[serial_str]
guid=lookup.guid
infoLookup[serial_str]=nil
end
local infoList=self.data.infoList
if infoList then
for i,v in ipairs(infoList)do
if v.serial_str==serial_str then
table.remove(infoList,i)
break
end
end
end
local detailList=self.data.detailList
if detailList~=nil then
detailList[serial_str]=nil
end
if guid then
self:unplaceInfoData(guid)
end

self:deleteFightFlagLookup(serial)
end


function systemZongMenModel:getQianRuLevel(serial)
local infoData=systemZongMenModel:getInfoData(serial)
local level=infoData.level
local cfg=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"qianru_need_jingjie")
local r=0
for i,v in ipairs(cfg)do
if level<v[1]then
break
else
r=v[2]
end
end
return r
end

function systemZongMenModel:getInfoDataRelation(serial)
local infoData=self:getInfoData(serial)
if infoData then
return infoData.relation_num
end
end

function systemZongMenModel:getInfoDataName(serial)
local infoData=self:getInfoData(serial)
if infoData then
return self:getNameStr(infoData.id,infoData.nameIdx)
end
end

function systemZongMenModel:getRenownIndex(id,renownValue)
local type=cfgHelper.get2(cfg_syssectconfig_get,id,"type")
local cfg=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"renown_list",type)
for i,v in ipairs(cfg)do
if renownValue<v then
return i
end
end
return#cfg+1
end

function systemZongMenModel:getRenownName(renownIndex)
return cfgHelper.get3(cfg_syssectbaseconfig_get,1,"renown_name",renownIndex)
end

function systemZongMenModel:getRenownIcon(renownIndex)
return cfgHelper.get3(cfg_syssectbaseconfig_get,1,"renown_icon",renownIndex)
end

function systemZongMenModel:getRenownValue(id,renownIndex)
local type=cfgHelper.get2(cfg_syssectconfig_get,id,"type")
local list=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"renown_list",type)
return renownIndex>1 and list[renownIndex-1]or 0
end

function systemZongMenModel:checkVisitPrivilege(id,warning)
local config=cfgHelper.get2(cfg_syssectconfig_get,id,"openParam")
if config then
local type=config[1]
local param=config[2]
local handle=_visitPrivilegeCheck[type]
if not handle.check(param)then
if warning then
UIManager.error(handle.tips(param))
end
return false
end
end
return true
end

function systemZongMenModel:calculateZaoYaoRate(zmId,sDiscipleData,tDiscipleData)
local zmCfg=cfgHelper.get2(cfg_syssectconfig_get,zmId,"zaoyaoMod")
local part1=zmCfg[1]/10000
local part2=(sDiscipleData.jingjielv-tDiscipleData.jingjielv)*zmCfg[2]/10000
local part3=sDiscipleData.attrList[DISCIPLE_BASE_ATTR_TYPE.eMeiLi]*zmCfg[3]/10000
return math.min(part1+part2+part3,1)
end

function systemZongMenModel:calculateTaYinRate(zmId,sDiscipleData)
local zmCfg=cfgHelper.get2(cfg_syssectconfig_get,zmId,"tayinMod")
local part1=zmCfg[1]/10000
local part2=sDiscipleData.jingjielv*zmCfg[2]/10000
local part3=sDiscipleData.attrList[DISCIPLE_BASE_ATTR_TYPE.eCongHui]*zmCfg[3]/10000
return math.min(part1+part2+part3,1)
end

function systemZongMenModel:calculateZaoYaoCost(discipleLv)
local costCfg=cfgHelper.get3(cfg_syssectconfig,1,"zaoyao","consume")
local cost=nil
local level=discipleLv
for i,v in ipairs(costCfg)do
if level<=v[1]then
cost=v[2]
break
end
end
if cost==nil then
cost=costCfg[#costCfg][2]
end
return cost
end


function systemZongMenModel:calculateTaYinCost(zmLv)













end

function systemZongMenModel:getCampIcon(eType)
return _camp_icon[eType],_camp_ab
end

function systemZongMenModel:findInfoDataByDisciple(discipleGuid)
for i,v in ipairs(self.data.infoList)do
if mathHelper.compareInt64(v.disciple_guid,discipleGuid)then
return v
end
end
end

function systemZongMenModel:getInfoList()
return self.data and self.data.infoList or{}
end

function systemZongMenModel:calculateShopDiscount(infoData)
local renown=infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local renownIdx=systemZongMenModel:getRenownIndex(infoData.id,renown)
local config=cfgHelper.get1(cfg_syssectconfig_get,infoData.id)
local discount=10000
for i,v in ipairs(config.renownRewards)do
for j,w in ipairs(v)do
if renownIdx>=i and w[1]==systemZongMenRenownRewardType.eShopDiscount then
discount=math.min(discount,w[2])
end
end
end
return discount
end

function systemZongMenModel:getShopGoodsSupplyTime(goodsLimitType)
if goodsLimitType==systemZongMenShopGoodsLimitType.eDay then
return timeHelper.getServerNewDayFiveLeftTime()+timeHelper.getServerLongTime()
elseif goodsLimitType==systemZongMenShopGoodsLimitType.eWeek then
return timeHelper.getNextWeekStampEx(1,5*3600)
elseif goodsLimitType==systemZongMenShopGoodsLimitType.eMonth then
return timeHelper.getNextMonthDateStamp(1,5,0,0)
end
end

function systemZongMenModel:getShopGoodsLimitContent(goodsLimitType)
if goodsLimitType==systemZongMenShopGoodsLimitType.eDay then
return"每日限购:{0}/{1}"
elseif goodsLimitType==systemZongMenShopGoodsLimitType.eWeek then
return"每周限购:{0}/{1}"
elseif goodsLimitType==systemZongMenShopGoodsLimitType.eMonth then
return"每月限购:{0}/{1}"
elseif goodsLimitType==systemZongMenShopGoodsLimitType.eForever then
return"永久限购:{0}/{1}"
end
end

function systemZongMenModel:setTempRewards(rewards,rewards2)
_tempRewards=rewards
_tempRewards2=rewards2
end

function systemZongMenModel:getTempRewards()
return _tempRewards
end

function systemZongMenModel:getTempRewards2()
return _tempRewards2
end

function systemZongMenModel:clearTempRewards()
_tempRewards=nil
_tempRewards2=nil
end

function systemZongMenModel:getTaskBelong(taskid)
local taskdata=taskModel:getTask(taskid)
return self:getTaskBelongEx(taskdata)
end

function systemZongMenModel:getTaskBelongEx(taskdata)
return self:getTaskBelongImp(taskdata.taskline)
end

function systemZongMenModel:getTaskBelongImp(taskline)
return _taskLines[taskline]
end

function systemZongMenModel:findInfoDataById(id)
local infoList=self:getInfoList()
for i,v in ipairs(infoList)do
if v.id==id then
return v
end
end
end

function systemZongMenModel:findInfoDataByWorldAndID(world,id)
local infoList=self:getInfoList()
for i,v in ipairs(infoList)do
if v.id==id and v.worldId==world then
return v
end
end
end

function systemZongMenModel:checkTaskOperate(serial,taskId,warning)
local infoData=self:getInfoData(serial)
if not infoData then
if warning then
UIManager.error("对应宗门不存在")
end
return false
end

return self:checkTaskOperateImp(infoData,taskId,warning)
end

function systemZongMenModel:checkTaskOperateImp(infoData,taskId,warning)
local nameStr=self:getNameStr(infoData.id,infoData.nameIdx)
if infoData.relation_num==systemZongMenRelationType.eDiDui then
if warning then
UIManager.error(FMT.fmt("目前与{0}宗门处于敌对关系",nameStr))
end
return false
end

local renown=infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local renownIdx=systemZongMenModel:getRenownIndex(infoData.id,renown)
local renownRewards=cfgHelper.get2(cfg_syssectconfig_get,infoData.id,"renownRewards")

for i=#renownRewards,renownIdx+1,-1 do
local renownRewardList=renownRewards[i]
for index,renownRewardInfo in ipairs(renownRewardList)do
local type=renownRewardInfo[1]
local param=renownRewardInfo[2]
if type==systemZongMenRenownRewardType.eTask then
if taskId>=param then
if warning then
UIManager.error(FMT.fmt("需要和{0}宗门声望达到{1}",nameStr,systemZongMenInfoShengWangName[i]))
end
return false
end
end
end
end

return true
end

function systemZongMenModel:resetShopNum(serial,itemId)
local detailData=self:getDetailPartInfo(serial,systemZongMenDetailDataPart.eShop)
if detailData then
detailData.list[itemId]=0
end
end