






local _MODULENAME="catEntrustModel"


def_table(_MODULENAME)
catEntrustModel.name=_MODULENAME
catEntrustModel.data={}

function catEntrustModel:onAppStart()

end


function catEntrustModel:onEnterState(isReconnect)
self.data.catEntrustSlotDataList={}
self.data.catEntrustSlotDataLookup={}
self.data.catEntrustMiscDataLookup={}
self.data.catEntrustLockSlotList={}
self.data.catEntrustLocalizeSlotList={}
self.data.exSlotUnlockFlag=0
self.data.workList={}
catEntrustModel:initEntrustSlotDataList()
end


function catEntrustModel:onProtocolReq(isReconnect)
if isReconnect then return end
catEntrustModel:readLocalRecordCatEntrustDataList()
end


function catEntrustModel:onLeaveState(isReconnect)

self.data={}
end


function catEntrustModel:initEntrustSlotDataList()
local pos_num=catEntrustConfig.getBaseInfo('pos_num')
local ex_pos_config=catEntrustConfig.getBaseInfo('ex_pos_config')


for index=1,pos_num do
local temp=catEntrustConfig.getEmptyEntrustSlotData()

temp.id=index
temp.isUnlock=true
temp.stamp=timeHelper.getServerShortTime()
temp.state=Cat_Entrust_State_Type.Stand
self.data.catEntrustSlotDataLookup[temp.id]=temp
table.insert(self.data.catEntrustSlotDataList,temp)
end


for index=1,#ex_pos_config do
local temp=catEntrustConfig.getEmptyEntrustSlotData()

temp.id=index+pos_num
temp.isUnlock=true
temp.stamp=timeHelper.getServerShortTime()
temp.unlockCost=ex_pos_config[index]

self.data.catEntrustLockSlotList[index]=temp
self.data.catEntrustSlotDataLookup[temp.id]=temp
table.insert(self.data.catEntrustSlotDataList,temp)
end
end


function catEntrustModel:setServerData(len,entrustDataList)
for index=1,len do
local catEntrustData=entrustDataList[index]
local wtSlotId=catEntrustData.pos_id
local wtSlotType=catEntrustData.entrust_id
local dispatchCatGuid=catEntrustData.cat_guid
local dispatchArgs=catEntrustData.param_list

local funcs=catEntrustConfig.getEntrustFuncObj(wtSlotType)

local wtSlotData=self.data.catEntrustSlotDataLookup[wtSlotId]
wtSlotData.data.entrustType=wtSlotType
wtSlotData.data.dispatchCatGuid=dispatchCatGuid

wtSlotData.data.rewardUpRate=funcs.getCatEntrustRewardUpRate(wtSlotData,dispatchCatGuid)

wtSlotData.data.isFinish=true

wtSlotData.state=Cat_Entrust_State_Type.End

self:addWorkingCat(wtSlotData.data.dispatchCatGuid,wtSlotData.id)


local funcObj=catEntrustConfig.getEntrustFuncObj(wtSlotData.data.entrustType)
funcObj.restockWtArgs(wtSlotData,dispatchArgs)

end

for index,wtSlotData in ipairs(self.data.catEntrustLockSlotList)do
wtSlotData.isUnlock=self:checkEnstrustSlotIsUnlock(index)
if wtSlotData.isUnlock then
if wtSlotData.state==Cat_Entrust_State_Type.Lock then
wtSlotData.state=Cat_Entrust_State_Type.Stand
end
else
wtSlotData.state=Cat_Entrust_State_Type.Lock
end
end

end

function catEntrustModel:updateServerData(len,entrustDataList)
local wtSlotDataList={}

for index=1,len do
local catEntrustData=entrustDataList[index]
local wtSlotId=catEntrustData.pos_id
local wtSlotType=catEntrustData.entrust_id
local dispatchCatGuid=catEntrustData.cat_guid
local dispatchArgs=catEntrustData.param_list

local wtSlotData=self.data.catEntrustSlotDataLookup[wtSlotId]

wtSlotData.data.entrustType=wtSlotType
wtSlotData.data.dispatchCatGuid=dispatchCatGuid
wtSlotData.data.isFinish=true

wtSlotData.state=Cat_Entrust_State_Type.Doing

local funcObj=catEntrustConfig.getEntrustFuncObj(wtSlotData.data.entrustType)
funcObj.restockWtArgs(wtSlotData,dispatchArgs)


funcObj.finishCallBack(wtSlotData)


wtSlotDataList[#wtSlotDataList+1]=wtSlotData


end



UIManager:invokeUIMethod('UICatEntrustWin','preparePlayDoingAnimation',wtSlotDataList)
end


function catEntrustModel:setMiscDataList(len,miscDatalist)
for index=1,len do
local data=miscDatalist[index]
local wtType=data.entrust_id
self.data.catEntrustMiscDataLookup[wtType]=data
end
end

function catEntrustModel:getMiscDataList(wtType)
return self.data.catEntrustMiscDataLookup[wtType]
end

function catEntrustModel:updateMiscData(miscData)
local wtType=miscData.entrust_id
self.data.catEntrustMiscDataLookup[wtType]=miscData
end

function catEntrustModel:unlockSlot(posID)
local wtSlotData=self.data.catEntrustSlotDataLookup[posID]

wtSlotData.isUnlock=true
wtSlotData.state=Cat_Entrust_State_Type.Stand

UIManager:invokeUIMethod("UICatEntrustWin","refreshAll")
end

function catEntrustModel:resetData()
self:resetFinishData()
end

function catEntrustModel:resetFinishData()
for index,wtSlotData in ipairs(self.data.catEntrustSlotDataList)do
if wtSlotData.state==Cat_Entrust_State_Type.Finish or wtSlotData.state==Cat_Entrust_State_Type.End then
self:resetWtSlotData(wtSlotData)
end
end
end

function catEntrustModel:resetWtSlotData(wtSlotData)

wtSlotData.stamp=timeHelper.getServerShortTime()
wtSlotData.state=Cat_Entrust_State_Type.Stand

self:removeWorkingCat(wtSlotData.data.dispatchCatGuid)

wtSlotData.sortWight=0
wtSlotData.data={
entrustType=0,
dispatchCatGuid=0,
exclusiveData={},
dispatchCount=0,
rewardUpRate=0,
titleName="",
}

self:updateCatEntrustCostList()
end

function catEntrustModel:resetAllWtSlotDataByEntrustType(entrustType)
for index,wtSlotData in ipairs(self.data.catEntrustSlotDataList)do
if wtSlotData.state==Cat_Entrust_State_Type.Prepare then
if wtSlotData.data.entrustType==entrustType then
self:resetWtSlotData(wtSlotData)
end
end
end
end



function catEntrustModel:getReqStartWtArgsTable()
local temp={}
for k,slotWtData in ipairs(self.data.catEntrustSlotDataList)do
if slotWtData.state==Cat_Entrust_State_Type.Prepare then
local subtemp={}
subtemp[1]=slotWtData.id
subtemp[2]=slotWtData.data.entrustType
subtemp[3]=tonumber(slotWtData.data.dispatchCatGuid)

local funcObj=catEntrustConfig.getEntrustFuncObj(slotWtData.data.entrustType)
subtemp[4]=funcObj.getToServerArgs(slotWtData.data.exclusiveData)
subtemp[5]=0





temp[#temp+1]=subtemp
end
end

return temp
end



function catEntrustModel:getEntrustSlotDataList()
return self.data.catEntrustSlotDataList
end

function catEntrustModel:getWtSlotDataById(id)
return self.data.catEntrustSlotDataLookup[id]
end

function catEntrustModel:setExSlotUnLockFlag(exSlotUnlockFlag)
self.data.exSlotUnlockFlag=exSlotUnlockFlag
end


function catEntrustModel:getSortEntrustSlotDataList()

local sortRule=catEntrustConfig.sortStateList

for k,v in ipairs(self.data.catEntrustSlotDataList)do
v.sortWight=sortRule[v.state]*100
end

table.sort(self.data.catEntrustSlotDataList,function(a,b)
if a.sortWight==b.sortWight then
return a.id<b.id
else
return a.sortWight>b.sortWight
end
end)

return self.data.catEntrustSlotDataList
end

function catEntrustModel:updateCatEntrustListTOPrepareState()
for index,wtSlotData in ipairs(self.data.catEntrustSlotDataList)do
if wtSlotData.state==Cat_Entrust_State_Type.Prepare then
local type=wtSlotData.data.entrustType
local funcs=catEntrustConfig.getEntrustFuncObj(type)


if funcs.checkPrepareNoOpenPass(wtSlotData)then
self:resetWtSlotData(wtSlotData)
else
funcs.checkPrepareNoCountPass(wtSlotData)
end
end
end
end


function catEntrustModel:setFillWtSlotData(wtSlotData,type,data)
wtSlotData.state=Cat_Entrust_State_Type.Prepare
wtSlotData.stamp=timeHelper.getServerShortTime()
wtSlotData.data.entrustType=type
wtSlotData.data.isFinish=false
wtSlotData.data.exclusiveData=data
end


function catEntrustModel:setWtSlotCatGuid(wtSlotData,guid)

if wtSlotData.data.dispatchCatGuid>0 then
self:removeWorkingCat(wtSlotData.data.dispatchCatGuid)
end

local funcs=catEntrustConfig.getEntrustFuncObj(wtSlotData.data.entrustType)
local upRate=funcs.getCatEntrustRewardUpRate(wtSlotData,guid)

wtSlotData.data.dispatchCatGuid=guid
wtSlotData.data.rewardUpRate=upRate


self:addWorkingCat(wtSlotData.data.dispatchCatGuid,wtSlotData.id)


UIManager:invokeUIMethod('UICatEntrustWin','refreshAll')
end

function catEntrustModel:setRewardInfo(rewardInfo)
self.data.rewardInfo=rewardInfo
end

function catEntrustModel:getRewardInfo(rewardInfo)
local info=self.data.rewardInfo
self.data.rewardInfo=nil
return info
end

function catEntrustModel:setLingShouInfo(lingShoulist)
lingShoulist=MysteryLingshouModel:sortlingshoulist(lingShoulist)
self.data.lingShoulist=lingShoulist
end

function catEntrustModel:getLingShouInfo()

local info=self.data.lingShoulist
self.data.lingShoulist=nil
return info
end


function catEntrustModel:getResourceMiJingData()
local endList={}

if not catEntrustConfig.checkCatEntrustTypeOpen(Entrust_Type.ZMMJ)then return endList end


local list=mysteryZiYuanFuBenModel:getFbData()


for tagId,fbData in pairs(list)do


local isNoSelect=true

local canMaxDiff,curDiff=mysteryZiYuanFuBenModel:getCurMaxLayer({tagId=tagId,curId=fbData.curId})
local mjid
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,tagId,fbData.curId)
if curDiff>0 then
mjid=config.mjGroup[curDiff]
end
if config.tagId==6 then

for k,slotWtData in ipairs(self.data.catEntrustSlotDataList)do
if slotWtData.state==Cat_Entrust_State_Type.Prepare then
local data=slotWtData.data
local exclusiveData=data.exclusiveData

if exclusiveData then

local id=exclusiveData.mjid

if mjid==id then
isNoSelect=false
end
end
end
end
end
if isNoSelect then
local type=Entrust_Type.ZMMJ
if config.mjShowType==5 then
type=Entrust_Type.EZMJ
end
if config.tagId==6 then
type=Entrust_Type.LSMJ
end
local isCanMultiple=curDiff~=0

local configflag=true
if config.sysId and not systemModel.isOpen(config.sysId)then
configflag=false
end

curDiff=Mathf.Max(1,curDiff)
if configflag then
endList[#endList+1]={
type=type,
data={
tagId=tagId,
curId=fbData.curId,
isCanMultiple=isCanMultiple,
mjid=mjid,
count=1,
diff=curDiff,
canMaxDiff=canMaxDiff,
},
isLock=not isCanMultiple,
unlockTip='挑战通关后解锁'
}
end


end
end

return endList
end


function catEntrustModel:getYYHYListData()
local endList={}

if not catEntrustConfig.checkCatEntrustTypeOpen(Entrust_Type.YYHY)then return endList end

local list=YiYuHuiYouModel:getNPCIdlist()
local miscData=self:getMiscDataList(Entrust_Type.YYHY)
local canSTNpcList=miscData and(miscData.misc_data_list or{})or{}


if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eYiYuHuiYou)then
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eYiYuHuiYou)then
local residueCount=YiYuHuiYouModel:getTiaoZhanResidueCount()

if residueCount>0 then

for index,data in pairs(list)do
local isOpen=worldBlockModel:checkBlockState(data.world,data.block,eWorldBlockState.OPEN)
local npcId=data.npcid

local yujulevel=cfg_yiyuhuiyounpcconfig_get(npcId).yuju_level
local now_yujulevel=YiYuHuiYouController:getYuJuAllLevel()
local upState=now_yujulevel>=yujulevel
local isLock=not upState
if isOpen then
local coordinateNum=self:getCoordinateResidueCount(Entrust_Type.YYHY)
local isCanSelect=coordinateNum>0

local unlockTip='通关后解锁'
if not upState then
local chavalue=yujulevel-now_yujulevel
unlockTip=FMT.fmt("升级任意渔具{0}次后解锁",chavalue)
end

if isCanSelect then
endList[#endList+1]={type=Entrust_Type.YYHY,data={
npcid=data.npcid,
count=1,
guid=tostring(data.guid),
},
isLock=isLock,
unlockTip=unlockTip,
}
end
end
end
end
end
end

return endList
end


function catEntrustModel:getZMAffairListData()
local list={}


if catEntrustConfig.checkCatEntrustTypeOpen(Entrust_Type.WDLT)then
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eWenDouLeiTai)then
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eWenDouLeiTai)then
local data=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eWenDouLeiTai)
local unitList=poetryArenaModel:getUnitDataList()
if data and#unitList>0 then
local isNoSelect=true


for k,wtSlotData in ipairs(self.data.catEntrustSlotDataList)do
if wtSlotData.data.entrustType==Entrust_Type.WDLT then
isNoSelect=false
break
end
end

if isNoSelect then
list[#list+1]={type=Entrust_Type.WDLT,data={count=1}}
end
end
else
local leftTime=limitActivitiesModel:getActStartLeftTime(LIMIT_ACT_TYPE.eWenDouLeiTai)
local unlockTip=catEntrustConfig.getWeakAndHourInfoToLeftTime(leftTime)
list[#list+1]={type=Entrust_Type.WDLT,data={count=1},isLock=true,unlockTip=unlockTip}
end
end
end




if catEntrustConfig.checkCatEntrustTypeOpen(Entrust_Type.ZMTY)then
if systemModel.isOpen(SYSTEM_DEFINE.eSystemZongMenTaYin)then
local maxNum=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"tayin","day_num")
local usedNum=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eTaYin)
if maxNum>usedNum then

local coordinateNum=self:getCoordinateResidueCount(Entrust_Type.ZMTY)
local isCanSelect=coordinateNum>0

local tyZmList=catEntrustModel:getTYSystemZmList()
local hasTyZm=#tyZmList>0

if isCanSelect and hasTyZm then
list[#list+1]={type=Entrust_Type.ZMTY,data={
count=1,
}}
end
end
end
end

return list
end


function catEntrustModel:getSGXD_Data()
local endList={}
if not catEntrustConfig.checkCatEntrustTypeOpen(Entrust_Type.SGXD)then return endList end


local list=mysteryWeekActivityModel:getMysteryUnitWinList()

for tagId,fbData in pairs(list)do

local isNoSelect=true
local mjid=fbData.id
for k,slotWtData in ipairs(self.data.catEntrustSlotDataList)do
if slotWtData.state==Cat_Entrust_State_Type.Prepare then
local data=slotWtData.data
local exclusiveData=data.exclusiveData
local fbData_=exclusiveData.fbData
if fbData_ then

local id=fbData_.id
if mjid==id then
isNoSelect=false
end
end
end
end
if isNoSelect then
local type=Entrust_Type.SGXD
endList[#endList+1]={
type=type,
data={
fbData={id=fbData.id,icon=fbData.icon,name=fbData.name},
count=1,
},

}

end
end

return endList
end



function catEntrustModel:getTYSystemZmList()
local systemZmInfoList=systemZongMenModel:getInfoList()
local temp={}
local tempLookup={}
for k,data in pairs(systemZmInfoList)do
if data.flag~=systemZongMenFightFlagType.eExpel then
if tempLookup[data.worldId]==nil then
local t={worldId=data.worldId,zmlist={}}
tempLookup[data.worldId]=t
temp[#temp+1]=t
end

local wTemp=tempLookup[data.worldId]
local list=wTemp.zmlist
list[#list+1]=data
end
end

table.sort(temp,function(a,b)
return a.worldId<b.worldId
end)


for k,v in ipairs(temp)do
table.sort(v.zmlist,function(a,b)
return a.id<b.id
end)
end

return temp,tempLookup
end


function catEntrustModel:setWtSlotExclusiveData(slotData,name,val)
if slotData then
slotData.data.exclusiveData[name]=val
end
end

function catEntrustModel:autoSetCat(id)
local wtSlotData=self.data.catEntrustSlotDataLookup[id]
local wtType=wtSlotData.data.entrustType
local ex_reward_config=cfgHelper.get2(cfg_catentrusttypeconfig_get,wtType,'ex_reward_config')
local attrid=ex_reward_config[1]
local catList=wanBaoXunBaoDuiModel:getCatSortListBySingleAttr(attrid)

if#catList>0 then
local catGuid=catList[1].guid
self:setWtSlotCatGuid(wtSlotData,catGuid)
else
UIManager.error("没有猫猫可以派遣")
end
end

function catEntrustModel:getCatEntrustTypePreateToalSelectCount(entrustType)
local total=0
for index,wtSlotData in ipairs(self.data.catEntrustSlotDataList)do
if wtSlotData.state==Cat_Entrust_State_Type.Prepare then
if wtSlotData.data.entrustType==entrustType then
total=total+wtSlotData.data.exclusiveData.count
end
end
end
return total
end

function catEntrustModel:addWorkingCat(guid,id)
self.data.workList[guid]=id
end

function catEntrustModel:removeWorkingCat(guid)
self.data.workList[guid]=nil
end

function catEntrustModel:isWorking(guid)
return self.data.workList[guid]~=nil
end



function catEntrustModel:updateWtSameTypeCountCoordinate(type,id)
local updateWtSlotIndexList={}

for index,wtSlotData in ipairs(self.data.catEntrustSlotDataList)do
if wtSlotData.data.entrustType==type then
if wtSlotData.id~=id then
updateWtSlotIndexList[#updateWtSlotIndexList+1]=index
end
end
end

UIManager:invokeUIMethod('UICatEntrustWin','updateItemsSlider',updateWtSlotIndexList)
end

function catEntrustModel:getCoordinateResidueCount(type,id)
local count=0

for k,wtSlotData in ipairs(self.data.catEntrustSlotDataList)do
if wtSlotData.data.entrustType==type
and wtSlotData.id~=id
and wtSlotData.state==Cat_Entrust_State_Type.Prepare then
count=count+(wtSlotData.data.exclusiveData.count or 0)
end
end

if type==Entrust_Type.YYHY then
local maxCount=YiYuHuiYouModel:getTiaoZhanResidueCount()
return maxCount-count
elseif type==Entrust_Type.ZMTY then
local maxNum=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"tayin","day_num")
local usedNum=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eTaYin)
return maxNum-usedNum-count
end
end


function catEntrustModel:checkEnstrustSlotIsUnlock(idx)
return bitHelper.check_pos(self.data.exSlotUnlockFlag,idx-1)
end

function catEntrustModel:checkHasReceiveSlot()
for k,v in ipairs(self.data.catEntrustSlotDataList)do
if v.state==Cat_Entrust_State_Type.Finish then
return true
end
end
return false
end

function catEntrustModel:checkWtListCondition()
local prepareCount=0

for k,wtSlotData in ipairs(self.data.catEntrustSlotDataList)do
if wtSlotData.state==Cat_Entrust_State_Type.Prepare then
prepareCount=prepareCount+1


if wtSlotData.data.dispatchCatGuid==0 then
self:showWtStartErrTip(Cat_Entrust_Condition_Error_Type.noDispatchCat)
return false
end

local state,errType,errArgs=self:checkWtCondition(wtSlotData)
if not state then
self:showWtStartErrTip(errType,errArgs)
return false
end
end
end

local tiliState,tiliErr,tiliErrArgs=self:checkWtCatTiliCondition()
if not tiliState then
self:showWtStartErrTip(tiliErr,tiliErrArgs)
return false
end

if prepareCount==0 then
UIManager.error('未选择委托')
return false
end

return true
end

function catEntrustModel:checkWtCondition(wtSlotData)
local wtType=wtSlotData.data.entrustType
if wtType>0 then

local funcs=catEntrustConfig.getEntrustFuncObj(wtType)
local state,errType,errArgs=funcs.checkWtCondition(wtSlotData)
if not state then
return state,errType,errArgs
end
else
logErr('猫猫委托 闲置状态不应该进入这个接口进行检查')
end

return true
end

function catEntrustModel:checkWtCatTiliCondition()
local restoreTiliCatGuidList={}
local lessMaxTiliCatGuidList={}

for k,wtSlotData in ipairs(self.data.catEntrustSlotDataList)do
if wtSlotData.state==Cat_Entrust_State_Type.Prepare then
local catGuid=wtSlotData.data.dispatchCatGuid

local wtType=wtSlotData.data.entrustType
if wtType>0 then
local exclusiveData=wtSlotData.data.exclusiveData

if catGuid>0 then
local catTili=wanBaoXunBaoDuiModel:getCatCurTili(catGuid)
local catData=wanBaoXunBaoDuiModel:getCatData(catGuid)
local catMaxTili=wanBaoXunBaoDuiModel:caculationMaxTili(catData)
local count=exclusiveData.count
local needTili=cfgHelper.get2(cfg_catentrusttypeconfig_get,wtType,'need_tili')
local totalNeedTili=needTili*count
local state=catTili>=totalNeedTili

if totalNeedTili>catMaxTili then
lessMaxTiliCatGuidList[#lessMaxTiliCatGuidList+1]=catGuid
end

if not state and totalNeedTili<=catMaxTili then
restoreTiliCatGuidList[#restoreTiliCatGuidList+1]=catGuid
end
end
end
end

if#restoreTiliCatGuidList>0 then
return false,Cat_Entrust_Condition_Error_Type.catTiliLess,restoreTiliCatGuidList
end

if#lessMaxTiliCatGuidList>0 then
local funcs=catEntrustConfig.getEntrustFuncObj(wtSlotData.data.entrustType)
local name=funcs.getName(wtSlotData.data.exclusiveData)
UIManager.error(FMT.fmt('扫荡{0}次{1}秘境所需体力不足',wtSlotData.data.exclusiveData.count,name))
return false,Cat_Entrust_Condition_Error_Type.catTiliMaxLess
end
end
return true
end

function catEntrustModel:showWtStartErrTip(type,args)
if type==Cat_Entrust_Condition_Error_Type.catTiliLess then
UIManager.error('猫猫体力不足')


self:restoreCatTili(args)
elseif type==Cat_Entrust_Condition_Error_Type.catTiliMaxLess then

elseif type==Cat_Entrust_Condition_Error_Type.itemLess then
gainControl:showGainWin(args.itemid)
elseif type==Cat_Entrust_Condition_Error_Type.noDispatchCat then
UIManager.error('未派遣猫猫')
elseif type==Cat_Entrust_Condition_Error_Type.noSelectZM then
UIManager.error('未选择拓印宗门')
elseif type==Cat_Entrust_Condition_Error_Type.yyhyCountLess then
UIManager.error('以渔会友 挑战次数不足')
elseif type==Cat_Entrust_Condition_Error_Type.limitActivityFinish then
UIManager.error(args)
end
end

function catEntrustModel:checkSystemOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eCatEntrust)
end



function catEntrustModel:getReddot()
if self:checkSystemOpen()then
for k,v in ipairs(self.data.catEntrustSlotDataList)do
if v.state==Cat_Entrust_State_Type.Stand or v.state==Cat_Entrust_State_Type.Prepare then
return true
end
end
end
return false
end


function catEntrustModel:getReddotStateNum()
local num=0
if self:checkSystemOpen()then
for k,v in ipairs(self.data.catEntrustSlotDataList)do
if v.state==Cat_Entrust_State_Type.Stand or v.state==Cat_Entrust_State_Type.Prepare then
num=num+1
end
end
end
return num
end


function catEntrustModel:refreshStorageWin()
UIManager:invokeUIMethod('UIFuncStorageWin','refreshFastManagerBtn')
end


function catEntrustModel:restoreCatTili(catGuidList)

local huifuList={}
local needConsumeNum=0
local moneyid

for index,catguid in pairs(catGuidList)do
local catdata=wanBaoXunBaoDuiModel:getCatData(catguid)

local const_def=wanBaoXunBaoDuiModel:getConstDef()
local maxTili=wanBaoXunBaoDuiModel:caculationMaxTili(catdata)
moneyid=const_def.add_tili_need[1]
local rate=const_def.add_tili_need[2]
local least=maxTili-catdata.tili
local needNum=rate*least

needConsumeNum=needConsumeNum+needNum

table.insert(huifuList,{catguid,least})
end

if#huifuList>0 then
wanBaoXunBaoDuiModel:showRestoreTiliDialog(moneyid,huifuList,needConsumeNum)
end
end


function catEntrustModel:startSelectWtProcess(id)
self.tempWt=catEntrustConfig.getEmptyEntrustSlotData()
self.tempWt.id=id
self.tempWt.state=Cat_Entrust_State_Type.Stand
end

function catEntrustModel:getTempWt()
return self.tempWt
end

function catEntrustModel:tempFillToWt()
local id=self.tempWt.id

local wtSlotData=self.data.catEntrustSlotDataLookup[id]

if self.tempWt.data.dispatchCatGuid~=wtSlotData.data.dispatchCatGuid then
if wtSlotData.data.dispatchCatGuid>0 then
self:removeWorkingCat(wtSlotData.data.dispatchCatGuid)
end
end

wtSlotData.state=Cat_Entrust_State_Type.Prepare
wtSlotData.data=self.tempWt.data

self:updateCatEntrustCostList()
end











local _localizeRecordCatEntrustDataKey="localizeRecordCatEntrustDataKey"
function catEntrustModel:writeFinishCatEntrustList(len,entrustServerDataList)
if len>0 then
for index=1,len do
local wtServerSlotData=entrustServerDataList[index]
local id=wtServerSlotData.pos_id
local wtSlotData=self.data.catEntrustSlotDataLookup[id]

local id=wtSlotData.id
local strId=tostring(id)

local originalData=self:encodeCatEntrustData(wtSlotData)
self.data.catEntrustLocalizeSlotList[strId]=originalData
end

userActorSetting.set(_localizeRecordCatEntrustDataKey,self.data.catEntrustLocalizeSlotList)
userActorSetting.flush()
end
end

function catEntrustModel:readLocalRecordCatEntrustDataList()
if not next(self.data.catEntrustLocalizeSlotList)then
local localizeOriginalDataList=userActorSetting.get(_localizeRecordCatEntrustDataKey,{})
if next(localizeOriginalDataList)then
for strId,originalData in pairs(localizeOriginalDataList)do
self.data.catEntrustLocalizeSlotList[strId]=originalData
end
end
end
end

function catEntrustModel:checkLocalRecordCatEntrust(originalData)
local id=originalData.id
local entrustType=originalData.entrustType
local dispatchCatGuid=originalData.dispatchCatGuid
local catData=wanBaoXunBaoDuiModel:getCatData(dispatchCatGuid)

local wtSlotData=self.data.catEntrustSlotDataLookup[id]
local catIsWorking=self:isWorking(dispatchCatGuid)
if wtSlotData.data.entrustType==0 and(not catIsWorking)and wtSlotData.state==Cat_Entrust_State_Type.Stand and catData~=nil then
local catEntrustTypeFuncs=catEntrustConfig.getEntrustFuncObj(entrustType)
if catEntrustTypeFuncs.checkLocalizeOriginalData then
local result=catEntrustTypeFuncs.checkLocalizeOriginalData(originalData.exclusiveData)
if result then

wtSlotData.data.entrustType=entrustType
wtSlotData.data.exclusiveData=originalData.exclusiveData
wtSlotData.data.dispatchCatGuid=originalData.dispatchCatGuid
wtSlotData.data.rewardUpRate=catEntrustTypeFuncs.getCatEntrustRewardUpRate(wtSlotData,originalData.dispatchCatGuid)

wtSlotData.state=Cat_Entrust_State_Type.Prepare

self:addWorkingCat(wtSlotData.data.dispatchCatGuid,wtSlotData.id)

self:updateCatEntrustCostList()
end
end
end
end

function catEntrustModel:encodeCatEntrustData(catEntrustData)
local temp={}

temp.id=catEntrustData.id
temp.entrustType=catEntrustData.data.entrustType
temp.exclusiveData=catEntrustData.data.exclusiveData
temp.dispatchCatGuid=catEntrustData.data.dispatchCatGuid

return temp
end

function catEntrustModel:decodeCatEntrustData(originalData)
local temp=catEntrustConfig.getEmptyEntrustSlotData()

temp.id=originalData.id
temp.data.entrustType=originalData.entrustType
temp.data.exclusiveData=originalData.exclusiveData
temp.data.dispatchCatGuid=originalData.dispatchCatGuid

return temp
end

function catEntrustModel:refreshLocalizeCatEntrustDataListToCurrent()
if catEntrustModel:GetToCurrentFlag()then
return
end
catEntrustModel:SetToCurrentFlag(true)
if next(self.data.catEntrustLocalizeSlotList)then
for strId,originalData in pairs(self.data.catEntrustLocalizeSlotList)do
self:checkLocalRecordCatEntrust(originalData)
end
end
end

function catEntrustModel:SetToCurrentFlag(flag)
self.data.ToCurrent=flag
end
function catEntrustModel:GetToCurrentFlag()
return self.data.ToCurrent
end

function catEntrustModel:delLocalizeRecord(id)
local idStr=tostring(id)
self.data.catEntrustLocalizeSlotList[idStr]=nil

userActorSetting.set(_localizeRecordCatEntrustDataKey,self.data.catEntrustLocalizeSlotList)
userActorSetting.flush()
end


function catEntrustModel:clearCatEntrustCostList()
self.data.catEntrustCostLoopup={}
end

function catEntrustModel:updateCatEntrustCostList()
self.data.catEntrustCostLoopup={}

for index,wtSlotData in ipairs(self.data.catEntrustSlotDataList)do
if wtSlotData.state==Cat_Entrust_State_Type.Prepare then
local type=wtSlotData.data.entrustType
local funcs=catEntrustConfig.getEntrustFuncObj(type)
local costlist=funcs.getEntrustCost(wtSlotData)
if costlist then
for cIndex,cost in ipairs(costlist)do
local itemid=cost[1]
local itemcount=cost[2]

if self.data.catEntrustCostLoopup[itemid]==nil then
self.data.catEntrustCostLoopup[itemid]=0
end

self.data.catEntrustCostLoopup[itemid]=self.data.catEntrustCostLoopup[itemid]+itemcount
end
end
end
end
end

function catEntrustModel:checkCatEntrustCostEnough(type,num)
num=num or 0

if self.data.catEntrustCostLoopup then
local hasNum=itemsModel.getCount(type)

local saveNum=self.data.catEntrustCostLoopup[type]or 0

return hasNum>=(saveNum+num)
else
logErr("出现未初始化货币消耗统计列表")
end
return false
end


function catEntrustModel:printWorkingList()

end
