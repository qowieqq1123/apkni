






local _MODULENAME="airGameEnterModel"


def_table(_MODULENAME)
airGameEnterModel.name=_MODULENAME
airGameEnterModel.data={}

function airGameEnterModel:onAppStart()

end


function airGameEnterModel:onEnterState(isReconnect)
self.data.baoWuLevelData={}
self.data.chengJiuData={}

self.data.baoWuLevelLookup={}
self.data.baoWuAttrLookUp={}

self.data.usedTimes=0

self.data.localizeInfo={}
self.data.unlockVocLookup={}
self.data.filterVocId=0


self.data.group=1
self.data.level=0

self:initChengJiuData()

self:initXianBaoData()




end


function airGameEnterModel:onProtocolReq()

end


function airGameEnterModel:onLeaveState(isReconnect)

self.data={}
end



function airGameEnterModel:initChengJiuData()
local allChengJiuCfg=cfg_airchengjiuconfig()

self.data.chengJiuDataLookup={}

self.data.chengJiuGroupLoopUp={}

for index,cjCfg in ipairs(allChengJiuCfg)do
local temp={}

temp.id=cjCfg.id
temp.stState=0
temp.reachState=0
temp.params={0}

local tab=cjCfg.tab
local group=cjCfg.group
local idx=cjCfg.idx

if self.data.chengJiuGroupLoopUp[tab]==nil then
self.data.chengJiuGroupLoopUp[tab]={}
end

local tabT=self.data.chengJiuGroupLoopUp[tab]

if tabT[group]==nil then
tabT[group]={curidx=1,list={}}
end

local groupT=tabT[group]

groupT.list[idx]=temp
groupT.totalNum=groupT.totalNum and groupT.totalNum+1 or 1

self.data.chengJiuDataLookup[cjCfg.id]=temp
end
end

function airGameEnterModel:initXianBaoData()
local bwAllCfg=cfg_airxianbaoconfig()

for index,bwCfg in ipairs(bwAllCfg)do
self.data.baoWuLevelLookup[bwCfg.id]=0





end
end

function airGameEnterModel:initUnlockVoc()
local allVocCfg=cfg_airvocationconfig()
self.data.unlockVocLookup={}
for index,vocCfg in pairs(allVocCfg)do
if airGameEnterConfig.checkVocationUnLock(vocCfg.id)then
self.data.unlockVocLookup[vocCfg.id]=vocCfg
end
end
end

function airGameEnterModel:recvInitServerData(dayCount,progressInfoLen,progressInfoList,curFbId,xbNum,xbList,cjNum,cjList,levelFirst,dzguid,mountguid,buyCount)

self.data.usedTimes=dayCount
self.data.progressInfoLen=progressInfoLen
self.data.progressInfoList=progressInfoList
self.data.curFbId=curFbId
self.data.xbNum=xbNum
self.data.xbList=xbList
self.data.cjNum=cjNum
self.data.cjList=cjList
self.data.levelFirst=levelFirst and levelFirst==0 or false
self.data.serverDzGuid=dzguid
self.data.serverMountGuid=mountguid
self.data.buyCount=buyCount

if mathHelper.compareInt64(mountguid,Int64_0)then
self.data.selectMount=nil
else
self.data.selectMount=mountguid
end

if mathHelper.compareInt64(dzguid,Int64_0)then
self.data.selectDisciple=nil
else
self.data.selectDisciple=dzguid
end






self:parseGroupLevel(progressInfoLen,progressInfoList,curFbId)

self:setBaoWuServerData(xbNum,xbList)


self:setChengJiuServerData(cjNum,cjList)

self:updateBaoWuAttrLookup()

self:readLocalizeData()
end


function airGameEnterModel:setBaoWuServerData(xbNum,xbList)

if xbNum>0 then
for index,levelData in ipairs(xbList)do
local id=levelData.param_1
local level=levelData.param_2
self.data.baoWuLevelLookup[id]=level
end
end
end



function airGameEnterModel:setChengJiuServerData(cjNum,data)
if cjNum>0 and data~=nil then
for index,cjData in ipairs(data)do
local id=cjData.param_1
local state=cjData.param_2
local param=cjData.param_3

local cjCfg=cfgHelper.get1(cfg_airchengjiuconfig_get,id)
local tab=cjCfg.tab
local group=cjCfg.group
local idx=cjCfg.idx

local groupCjData=self.data.chengJiuGroupLoopUp[tab][group]
local tempCjData=groupCjData.list[idx]
if state==2 then
if cjCfg.idx>=groupCjData.curidx then
local toIdx=cjCfg.idx+1
if groupCjData.totalNum>=toIdx then
groupCjData.curidx=toIdx

end
end
end
tempCjData.reachState=state
tempCjData.params={param}
end
end
end

function airGameEnterModel:parseGroupLevel(len,data,curFbId)

if len>0 then
for index,info in ipairs(data)do
local group=info.param_1
local level=info.param_2

self.data.group=group
self.data.level=level
end
end

if self.data.localizeInfo.curGroup==self.data.group+1 then
self.data.group=self.data.localizeInfo.curGroup
self.data.level=0
end








end

function airGameEnterModel:activeXianBao(bwId)
if self.data.baoWuLevelLookup[bwId]==nil then
self.data.xbNum=self.data.xbNum+1
self.data.xbList[self.data.xbNum]={bwId,1}
end
self.data.baoWuLevelLookup[bwId]=1

UIManager.info("激活成功")

self:updateBaoWuAttrLookup()


UIManager:invokeUIMethod("UIAirGameBaoWuWin",'refreshAll')
end

function airGameEnterModel:levelUpXianBao(bwId,level)
self.data.baoWuLevelLookup[bwId]=level

UIManager.info("升级成功")

self:updateBaoWuAttrLookup()


UIManager:invokeUIMethod("UIAirGameBaoWuWin",'refreshAll')
end

function airGameEnterModel:resetXianBaoLevel(bwId,level)
self.data.baoWuLevelLookup[bwId]=level

UIManager.info("重置成功")

self:updateBaoWuAttrLookup()


UIManager:invokeUIMethod("UIAirGameBaoWuWin",'refreshAll')
end

function airGameEnterModel:updateStateChengJiuData(len,achieveDataList)
for index=1,len do
local data=achieveDataList[index]
local id=data.param_1
local state=data.param_2
local param=data.param_3

local cjCfg=cfgHelper.get1(cfg_airchengjiuconfig_get,id)
local tab=cjCfg.tab
local group=cjCfg.group
local idx=cjCfg.idx

local tempCjData=self.data.chengJiuGroupLoopUp[tab][group].list[idx]
tempCjData.reachState=state
tempCjData.params={param}
end
end

function airGameEnterModel:updateFinishChengJiuData(len,achieveIdList)
for index=1,len do
local id=achieveIdList[index]

local cjCfg=cfgHelper.get1(cfg_airchengjiuconfig_get,id)
local tab=cjCfg.tab
local group=cjCfg.group
local idx=cjCfg.idx

local groupCjData=self.data.chengJiuGroupLoopUp[tab][group]
local toIdx=groupCjData.curidx+1
if groupCjData.totalNum>=toIdx then
groupCjData.curidx=toIdx
end
local tempCjData=groupCjData.list[idx]

tempCjData.reachState=2
end
end

function airGameEnterModel:updateFirstReachChengJiuData(len,airAchieveList)
for index=1,len do
local data=airAchieveList[index]
local id=data.achieve_id
local acotrid=data.actor_id
local name=data.actor_name
local iconInfo=data.iconInfo

local cjCfg=cfgHelper.get1(cfg_airchengjiuconfig_get,id)
local tab=cjCfg.tab
local group=cjCfg.group
local idx=cjCfg.idx

local tempCjData=self.data.chengJiuGroupLoopUp[tab][group].list[idx]

tempCjData.acotrid=acotrid
tempCjData.iconInfo=iconInfo
tempCjData.name=name
end
end

function airGameEnterModel:updateBaoWuAttrLookup()
self.data.baoWuAttrLookUp={}
for bwId,level in pairs(self.data.baoWuLevelLookup)do
if level>0 then
local attrs=cfgHelper.get3(cfg_airxianbaolevelconfig_get,bwId,level,'attrs')
local atype=attrs[1]
local aval=attrs[2]
self.data.baoWuAttrLookUp[atype]=self.data.baoWuAttrLookUp[atype]==nil and aval or self.data.baoWuAttrLookUp[atype]+aval
end
end
end


function airGameEnterModel:startGame(fbId)
self.data.curFbId=fbId
local idx=cfgHelper.get2(cfg_airfubenconfig_get,fbId,'idx')
self:addUsedTimes(idx)

self:setLevelFirstFlag(fbId)

airGameEnterModel:setCancelContinueFlag(false)
end

function airGameEnterModel:endGame(fbId,resultFlag)

local fbCfg=cfgHelper.get1(cfg_airfubenconfig_get,fbId)
if fbCfg.groupid and fbCfg.idx then
if resultFlag==1 then
local playLevel=self:getPlayLevel()
if fbCfg.idx==playLevel then
self:setLevelFirstFlag(fbId,resultFlag==1)
end

self.data.group=fbCfg.groupid
self.data.level=fbCfg.idx

self.data.curFbId=-1
self:addProgressInfo(self.data.group,self.data.level)

taskController.onAirLevelChange()
end
end

airGameEnterModel:setCancelContinueFlag(true)
end

function airGameEnterModel:toNextStage()
self.data.curFbId=-1

self.data.group=self.data.group+1
self.data.level=0


self.data.localizeInfo.curGroup=self.data.group
self:writeLocalizeData()
end

function airGameEnterModel:getGroup()
return self.data.group
end

function airGameEnterModel:getLevel()
return self.data.level
end

function airGameEnterModel:getPlayLevel()
local group=self:getGroup()
if self:checkStageFinish(group,self.data.level)then
return self.data.level
else
return self.data.level+1
end
end

function airGameEnterModel:getCurGameIdx()
return self:getCurPlayIdx()or self:getPlayLevel()
end


function airGameEnterModel:getStageState()
local group=self:getGroup()
local plevel=self:getPlayLevel()
local level=self:getLevel()



if self:checkFinishAll(group,level)then
return airGameEnterConfig.stageStateEnum.FinishAllStage
end

if self:checkStageFinish(group,level)then
return airGameEnterConfig.stageStateEnum.FinishStage
end


if(not self:checkLevelCondition(group,plevel))then
return airGameEnterConfig.stageStateEnum.LockCondition
end

if self:checkNeedCostStart(plevel)then
return airGameEnterConfig.stageStateEnum.BuyTimes
end

if self:getLevelFirstFlag(plevel)then
return airGameEnterConfig.stageStateEnum.FirstFree
end

return airGameEnterConfig.stageStateEnum.FreeTimes
end

function airGameEnterModel:getCostInfo(group,curLevel)
if self:getLevelFirstFlag(curLevel)then
return"本次免费"
end
if self:checkNeedCostStart(curLevel)then
local cost=airGameEnterConfig.getFbConstConfig('challenge_consume')
local itemId=cost[1]
local itemCount=cost[2]
local iconname=iconHelper.getIconName(itemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)
local costStr=FMT.fmt('{0} {1}',iconStr,itemCount)
return costStr
end
end

function airGameEnterModel:getCountInfo(fmt)
local freeTimes=airGameEnterConfig.getFbConstConfig('free_times')
local residueTimes=Mathf.Max(0,freeTimes+self.data.buyCount-self.data.usedTimes)
local color=residueTimes==0 and"#f36666"or'#aae252'
local countInfo=FMT.fmt(fmt,residueTimes,freeTimes,color)
return countInfo
end

function airGameEnterModel:getSelectDisciple()
if self.data.selectDisciple==nil then
return
end
if UIDiscipleModel:getDiscipleData(self.data.selectDisciple)then
return self.data.selectDisciple
else
self.data.selectDisciple=nil
airController:clearActorDataAndProcessData()
end
end

function airGameEnterModel:setSelectDisciple(guid)
self.data.selectDisciple=guid
self.data.localizeInfo.selectDisciple=tostring(guid)


self:writeLocalizeData()


UIManager:invokeUIMethod("UIAirGamePrepareWin",'refreshLeft')
end

function airGameEnterModel:getLevelState(group,level)

return self:checkLevelCondition(group,level)
end

function airGameEnterModel:getUsedFreeCount()
local freeTimes=airGameEnterConfig.getFbConstConfig('free_times')
return self.data.usedTimes,freeTimes
end

function airGameEnterModel:getBaoWuAttrTotalInfoByType(attrType)
return self.data.baoWuAttrLookUp[attrType]
end

function airGameEnterModel:getServerDiscipleGuid()
return self.data.serverDzGuid
end

function airGameEnterModel:getServerMountGuid()
return self.data.serverMountGuid
end

function airGameEnterModel:setCancelContinueFlag(state)
self.data.isCancelContinueFlag=state
end

function airGameEnterModel:getCancelContinueFlag()
return self.data.isCancelContinueFlag
end


function airGameEnterModel:getGameInitAttrShowList(discipleGuid,mainShowAttrCfgList)
local initShowList={}

local netData=UIDiscipleModel:getDiscipleData(discipleGuid)
local sixBaseAttrList=netData.attrList

for index,mainAttrCfg in ipairs(mainShowAttrCfgList)do
local ival,sixAttrType=airGameEnterConfig.transToInitAttrVal(sixBaseAttrList,mainAttrCfg)
ival=Mathf.Floor(ival)
local temp={}
temp[1]=mainAttrCfg.attrname
local tIVal=mathHelper.formatNumber8(ival,2,nil)
local sixAttrTypeName=""
local sixAttrTypeVal=""
local desc=""
local tIvalStr=airController:getAttrStr(mainAttrCfg.id,tIVal)
if sixAttrType>0 then
sixAttrTypeName=UIDiscipleModel:getDiscipleBaseAttrName(sixAttrType)
sixAttrTypeVal=sixBaseAttrList[sixAttrType]
desc=FMT.fmt("<color=#65615f>({0}{1})</color>",sixAttrTypeName,sixAttrTypeVal)
else
desc=tIvalStr
end
temp[2]=tIvalStr
temp[3]=desc

initShowList[#initShowList+1]=temp
end

return initShowList
end

function airGameEnterModel:getGameInitAttrList(discipleGuid)
local attrAllCfg=cfg_airattributesconfig()
local initList={}

local netData=UIDiscipleModel:getDiscipleData(discipleGuid)
local sixBaseAttrList=netData.attrList

for index,mainAttrCfg in ipairs(attrAllCfg)do
local ival,sixAttrType=airGameEnterConfig.transToInitAttrVal(sixBaseAttrList,mainAttrCfg)


local bwAttrVal=airGameEnterModel:getBaoWuAttrTotalInfoByType(mainAttrCfg.id)

if bwAttrVal then
ival=ival+bwAttrVal
end

local temp={}
temp[1]=mainAttrCfg.id
temp[2]=ival

initList[#initList+1]=temp

end

return initList
end

function airGameEnterModel:getGameBaseRoleInfo(discipleGuid)
local baseRoleInfo={}

local vocId=UIDiscipleModel:getDiscipleJob(discipleGuid)
local airVocCfg=cfg_airvocationconfig_get(vocId)

baseRoleInfo.equipItemId=airVocCfg.weapon
baseRoleInfo.vocSkillId=airVocCfg.skill

if airVocCfg.items then
baseRoleInfo.bwitemid=airVocCfg.items[1]
end

if self.data.selectMount then
baseRoleInfo.mountItemGuid=self:getMount()
local mountData=mountModel:getMount(self.data.selectMount)
mountData=mountData or itemsModel.getItem(self.data.selectMount)

if mountData then
local mountSkillCfg=itemsConfig.getConfig(mountData.itemid)
if mountSkillCfg and mountSkillCfg.airgameMountSkillid then
baseRoleInfo.mountSkillId=mountSkillCfg.airgameMountSkillid
else
logErr(FMT.fmt("空战 坐骑缺少技能配置,mountid{0}",mountData.itemid))
end
end
end

return baseRoleInfo
end


function airGameEnterModel:getBaoWuData()
local xianBaoAllCfg=cfg_airxianbaoconfig()
local xianBaoDataList={}

for index,xianBaoCfg in ipairs(xianBaoAllCfg)do
local temp={}

local level=self.data.baoWuLevelLookup[xianBaoCfg.id]or 0
local levelAllCfg=cfgHelper.get1(cfg_airxianbaolevelconfig_get,xianBaoCfg.id)
local levelCfg=levelAllCfg[level]
local totalLv=#levelAllCfg
local limitMaxLv=cfgHelper.get2(cfg_airxianbaoconfig_get,xianBaoCfg.id,'limit_max_level')
temp.cfg=xianBaoCfg
temp.level=level
temp.name=xianBaoCfg.name
temp.modelParam={xianBaoCfg.model_params,0.5}
temp.isFullLevel=#levelAllCfg==level
temp.isActive=level>0
temp.costList={}
temp.condition={}
temp.attrParam=levelCfg and levelCfg.attrs or levelAllCfg[1].attrs
temp.totalLv=totalLv
temp.isFullLv=totalLv==level or limitMaxLv==level
if not temp.isFullLevel then
if levelCfg then
temp.costList=levelCfg.up_costs
temp.condition=levelCfg.condition
temp.costTypeName="升级\n消耗"
temp.isCanActive=true
else
temp.costList=xianBaoCfg.active_cost
temp.condition=xianBaoCfg.group
temp.costTypeName="激活\n消耗"
temp.isCanActive=airGameEnterConfig.checkXianBaoOpenCondition(xianBaoCfg.group)
end
end

xianBaoDataList[#xianBaoDataList+1]=temp
end
return xianBaoDataList
end

function airGameEnterModel:getBaoWuAttrInfo(attrParam)
local type=attrParam[1]
local addVal=attrParam[2]

local addValStr=airController:getAttrStr(type,addVal)

local attrName=cfgHelper.get2(cfg_airattributesconfig_get,type,'attrname')
return FMT.fmt("{0}+{1}",attrName,addValStr)
end


function airGameEnterModel:getGroupTaskDataList(tabId)
local taskGroupDataList=self.data.chengJiuGroupLoopUp[tabId]

local groupTaskDataList={}

local dataFunc=function(cjData)
local temp={}
local taskCfg=cfgHelper.get1(cfg_airchengjiuconfig_get,cjData.id)

temp.taskDesc=airGameEnterConfig.getChengJiuDesc(cjData)
temp.isShowFinish=cjData and(cjData.reachState==1)or false
temp.isShowReceive=cjData and(cjData.reachState==2)or false
temp.isShowRewardList=cjData and(cjData.reachState~=2)or true
temp.rewardList=taskCfg.rewards
temp.isShowReddot=cjData and(cjData.reachState==1)or false
temp.cjData=cjData
temp.taskCfg=taskCfg
temp.sortwidget=taskCfg.sortwidget

if cjData.reachState==1 then
temp.sortwidget=temp.sortwidget+10000000
elseif cjData.reachState==2 then
temp.sortwidget=temp.sortwidget-10000000
end

groupTaskDataList[#groupTaskDataList+1]=temp


end

for index,taskGroupData in pairs(taskGroupDataList)do



local idx=taskGroupData.curidx
local list=taskGroupData.list

for cindex=1,idx do
dataFunc(list[cindex])
end
end

table.sort(groupTaskDataList,function(a,b)
return a.sortwidget>b.sortwidget
end)

return groupTaskDataList
end

function airGameEnterModel:getTabCanReceiveRewardTaskIdList(tabid)
local idlist={}

local groupTaskList=self.data.chengJiuGroupLoopUp[tabid]
if groupTaskList then
for index,taskGroupInfo in pairs(groupTaskList)do
local taskData=taskGroupInfo.list[taskGroupInfo.curidx]
if taskData.reachState==1 then
idlist[#idlist+1]=taskData.id
end
end
end

return idlist
end


function airGameEnterModel:removeMount(itemData)
self.data.selectMount=nil
self.data.localizeInfo.selectMount=nil


self:writeLocalizeData()

UIManager:invokeUIMethod('UIAirGamePrepareWin','refreshLeft')
end

function airGameEnterModel:setMount(itemData)
self.data.selectMount=itemData.itemguid
self.data.localizeInfo.selectMount=tostring(itemData.itemguid)


self:writeLocalizeData()

UIManager:invokeUIMethod('UIAirGamePrepareWin','refreshLeft')
end

function airGameEnterModel:getMount()
if self.data.selectMount==nil then

end
if itemsModel.getItem(self.data.selectMount)then
return self.data.selectMount
end
end



function airGameEnterModel:setVocFilterInfo(vocid,state)
self.data.vocFilterList[vocid]=state
end

function airGameEnterModel:getVocFilterInfo(vocid)
if self.data.vocFilterList[vocid]==nil then
return 1
end
return self.data.vocFilterList[vocid]
end

function airGameEnterModel:getVocFilterDiscipleList(dzlist)

local filterDzList={}
for index,data in ipairs(dzlist)do
local voc=UIDiscipleModel:getDiscipleJob(data.discipleguid)
local vocState=self:checkFilterVocId(voc,true)
if vocState then
filterDzList[#filterDzList+1]=data
end
end

return filterDzList
end

function airGameEnterModel:setFilterVocId(vocId)
self.data.filterVocId=vocId
end

function airGameEnterModel:getFilterVocId()
return self.data.filterVocId
end

function airGameEnterModel:getProgressNum()
local totalLevel=self.data.level or 0

for index=1,self.data.group do
local mapGroup=cfgHelper.get1(cfg_airgamepushmaplevelconfig_get,index)
local total=#mapGroup
if self.data.group>index then
totalLevel=totalLevel+total
end
end

return totalLevel
end

function airGameEnterModel:addProgressInfo(group,level)
self.data.progressInfoLen=self.data.progressInfoLen+1
self.data.progressInfoList=self.data.progressInfoList or{}
self.data.progressInfoList[self.data.progressInfoLen]={param_1=group,param_2=level}
end

function airGameEnterModel:setLevelFirstFlag(fbid,state)
local idx=cfgHelper.get2(cfg_airfubenconfig_get,fbid,'idx')
local level=self:getPlayLevel()
if idx==level then
self.data.levelFirst=state
end
end

function airGameEnterModel:getLevelFirstFlag(level)
level=level or self:getPlayLevel()
local curLevel=self:getLevel()
return self.data.levelFirst and level>curLevel
end

function airGameEnterModel:addUsedTimes(idx)
if not self:getLevelFirstFlag(idx)then
local freeTimes=airGameEnterConfig.getFbConstConfig('free_times')
if self.data.usedTimes<freeTimes then
self.data.usedTimes=self.data.usedTimes+1
elseif self.data.buyCount>0 then
self.data.buyCount=0
else
logErr("次数扣除错误")
end
end
end

function airGameEnterModel:getNowUnlockVocList()
local allVocCfg=cfg_airvocationconfig()
local temp={}
for index,vocCfg in pairs(allVocCfg)do
if not self.data.unlockVocLookup[vocCfg.id]then
if airGameEnterConfig.checkVocationUnLock(vocCfg.id)then
temp[#temp+1]=vocCfg
self.data.unlockVocLookup[vocCfg.id]=vocCfg
end
end
end

return temp
end

function airGameEnterModel:setCachePrepareEnterInfo(group,level,dzguid)
self.data.cachePrepareEnterInfo={}
self.data.cachePrepareEnterInfo.group=group
self.data.cachePrepareEnterInfo.level=level
self.data.cachePrepareEnterInfo.dzGuid=dzguid
end

function airGameEnterModel:getCachePrepareEnterInfo()
return self.data.cachePrepareEnterInfo
end

function airGameEnterModel:clearCachePrepareEnterInfo()
self.data.cachePrepareEnterInfo=nil
end

function airGameEnterModel:setBuyCount(times)
self.data.buyCount=times
end

function airGameEnterModel:getCurPlayIdx()
local curFbId=self:getCurFbId()
if curFbId>0 then
local idx=cfgHelper.get2(cfg_airfubenconfig_get,curFbId,'idx')
return idx
end
end

function airGameEnterModel:resetUsedTimes()
self.data.usedTimes=0
self.data.buyCount=0
end

function airGameEnterModel:setOpenSec(open_sec)
self.data.open_sec=open_sec
end

function airGameEnterModel:getOpenSec()
return self.data.open_sec or 0
end


function airGameEnterModel:checkNeedCostStart(level)
if self:getLevelFirstFlag(level)then
return false
else

local freeTimes=airGameEnterConfig.getFbConstConfig('free_times')
local isUseUp=self.data.usedTimes>=(freeTimes+self.data.buyCount)
return isUseUp
end
end

function airGameEnterModel:checkFirstChallenge(group,level)
return self.data.levelFirst
end

function airGameEnterModel:checkFinishAll(group,level)
local nextGroup=group+1

local allGroupCfg=cfg_airgamepushmapgroupconfig()
local allGroupLevelCfg=cfg_airgamepushmaplevelconfig()
local totalGroupLen=#allGroupCfg

if allGroupCfg[nextGroup]~=nil then
if allGroupCfg[nextGroup].isShield and allGroupCfg[nextGroup].isShield==1 then
if level>=#allGroupLevelCfg[group]then
return true
end
end
end

if group==totalGroupLen then
local finalGroupAllLevelCfg=allGroupLevelCfg[totalGroupLen]
if level>=#finalGroupAllLevelCfg then
return true
end
end

return false
end

function airGameEnterModel:checkStageFinish(group,level)
if group>0 and level>0 then
local allLevelCfg=cfg_airgamepushmaplevelconfig_get(group)
local totalLevelLen=#allLevelCfg
local curGroup=self:getGroup()
if group==curGroup then
return level>=totalLevelLen
end
end
return false
end

function airGameEnterModel:checkLevelState(group,level)
local tgroup=self:getGroup()
local tlevel=self:getPlayLevel()

return group>=tgroup and(level==tlevel or level==tlevel-1)
end

function airGameEnterModel:checkLevelCondition(group,level)
local openCond=airGameEnterConfig.getFbConfigEx(group,level,'openCond')
if openCond then
return airGameEnterConfig.checkOpenCondition(openCond)
end
return true
end

function airGameEnterModel:checkCostEnoughStartGame(isShowGain)
local cost=airGameEnterConfig.getFbConstConfig('challenge_consume')
local itemId=cost[1]
local itemCount=cost[2]
local state=itemsModel.checkItemEnough(itemId,itemCount)
if not state and isShowGain then
gainControl:showGainWin(itemId,itemCount)
end
return state
end

function airGameEnterModel:checkBaoWuAddLevelCostEnough(bwId,isShowGainWin)
local bwCfg=cfg_airxianbaoconfig_get(bwId)
local bwLevel=self.data.baoWuLevelLookup[bwCfg.id]

local levelUpCost=cfgHelper.get3(cfg_airxianbaolevelconfig_get,bwId,bwLevel,'up_costs')
if levelUpCost then
local state=true
for index,costInfo in ipairs(levelUpCost)do
if not itemsModel.checkItemEnough(costInfo[1],costInfo[2])then
if isShowGainWin then
gainControl:showGainWin(costInfo[1],costInfo[2])
end
return false
end
end
return state
end
return false
end

function airGameEnterModel:checkBaoWuActiveCostEnough(bwId,isShowGainWin)
local bwCfg=cfg_airxianbaoconfig_get(bwId)

local activeCost=bwCfg.active_cost
if activeCost then
local state=true
for index,costInfo in ipairs(activeCost)do
if not itemsModel.checkItemEnough(costInfo[1],costInfo[2])then
if isShowGainWin then
gainControl:showGainWin(costInfo[1],costInfo[2])
end
return false
end
end
return state
end
return false
end

function airGameEnterModel:checkGameContitnue()

end


function airGameEnterModel:checkShowChangeInfoDialouge()
if not airGameEnterModel:getCancelContinueFlag()then
if airModel:checkIsCanContinueLevel()then
return true
else
if airGameEnterModel:checkInEmptyFuBen()then
return true
end
end
end
return false
end

function airGameEnterModel:checkFilterVocId(vocId,toDz)
if airGameEnterConfig.checkVocationUnLock(vocId)then
if self.data.filterVocId==0 and toDz then
return true
else
return self.data.filterVocId==vocId
end
end
end

function airGameEnterModel:checkFinishNotCanChallenge(group,level)
local curgroup=self:getGroup()
local curlevel=self:getLevel()

if curgroup>=group then
if level<curlevel-1 then
return true
end
end
return false
end

function airGameEnterModel:checkChallenge(group,level)
local curgroup=self:getGroup()
local curlevel=self:getLevel()
local curplevel=self:getPlayLevel()

if curgroup==group then
if curplevel==level or curlevel==level then
if airGameEnterModel:checkLevelCondition(group,level)then
return true
else
local unlockTip=airGameEnterConfig.checkOpenConditionDescEx(group,level)
return false,unlockTip
end
else
if level>curplevel then
return false,"需通关前置关卡"
end

if level<curlevel then
return false,"已通关"
end
end
else
return false,'章节已通关'
end
end

function airGameEnterModel:checkLevelFinish(group,level)
local curgroup=self:getGroup()
local curlevel=self:getLevel()

return curgroup>=group and curlevel>=level
end

function airGameEnterModel:checkNextChallenge()
local curgroup=self:getGroup()
local curlevel=self:getLevel()

return not self:checkStageFinish(curgroup,curlevel)
end

function airGameEnterModel:checkFirstLevel()
local group=self:getGroup()
local level=self:getPlayLevel()

return group==1 and level==1
end

function airGameEnterModel:checkInEmptyFuBen()
return self.data.curFbId>0 and(not airModel:checkIsCanContinueLevel())
end

function airGameEnterModel:checkHasMount()
local voc=UIDiscipleModel:getDiscipleJob(self.selectDisciple)
local mountDataList=equipListManager.getMountFilterFunc(self.selectDisciple,nil,ITEM_MAIN_TYPE.eMount,voc,nil)or{}
return#mountDataList>0
end


function airGameEnterModel:checkReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eAirGame)then return false end
local state=self:checkChengJiuReddot()or self:checkTXZReddot()
return state
end

function airGameEnterModel:checkRewardReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eAirGame)then return false end
local state=self:checkBaoWuoActiveReddot()or self:checkChengJiuReddot()or self:checkTXZReddot()
return state
end

function airGameEnterModel:checkBaoWuoReddot()
local bwAllCfg=cfg_airxianbaoconfig()

for index,bwCfg in ipairs(bwAllCfg)do
if self:checkSingleBaowuReddot(bwCfg.id)then
return true
end
end

return false
end

function airGameEnterModel:checkBaoWuoActiveReddot()
local bwAllCfg=cfg_airxianbaoconfig()

for index,bwCfg in ipairs(bwAllCfg)do
local bwLevel=self.data.baoWuLevelLookup[bwCfg.id]
if bwLevel==0 then
local state=true
if bwCfg.group then
state=state and airGameEnterConfig.checkXianBaoOpenCondition(bwCfg.group)
end

state=state and airGameEnterModel:checkBaoWuActiveCostEnough(bwCfg.id,false)
if state then
return true
end
end
end

return false
end

function airGameEnterModel:checkSingleBaowuReddot(bwId)
local bwCfg=cfg_airxianbaoconfig_get(bwId)
local bwLevel=self.data.baoWuLevelLookup[bwCfg.id]
if bwLevel==0 then

local state=true
if bwCfg.group then
state=state and airGameEnterConfig.checkXianBaoOpenCondition(bwCfg.group)
end

state=state and airGameEnterModel:checkBaoWuActiveCostEnough(bwId,false)
return state
else

local limitMaxLv=cfgHelper.get2(cfg_airxianbaoconfig_get,bwId,'limit_max_level')
if limitMaxLv>bwLevel then
local condition=cfgHelper.get3(cfg_airxianbaolevelconfig_get,bwId,bwLevel,'condition')
return airGameEnterConfig.checkXianBaoOpenCondition(condition)and self:checkBaoWuAddLevelCostEnough(bwId,false)
end
end
return false
end


function airGameEnterModel:checkChengJiuReddot()
local cjTabAllCfg=cfg_airchengjiutabconfig()
for index,cjTabCfg in ipairs(cjTabAllCfg)do
if self:checkChengJiuTabReddot(cjTabCfg.id)then
return true
end
end
return false
end

function airGameEnterModel:checkChengJiuTabReddot(tabId)
local cjTabData=self.data.chengJiuGroupLoopUp[tabId]
if cjTabData then
for index,taskGroupData in pairs(cjTabData)do
if self:checkSingleTaskGroupReddot(tabId,index)then
return true
end
end
end
return false
end

function airGameEnterModel:checkSingleTaskGroupReddot(tabId,taskGroupId)
local taskGroupData=self.data.chengJiuGroupLoopUp[tabId][taskGroupId]
if taskGroupData then
local idx=taskGroupData.curidx
local list=taskGroupData.list
local cjData=list[idx]
if cjData.reachState==1 then
return true
end
end
return false
end


function airGameEnterModel:checkResidueFreeCountReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eAirGame)then return false end
if self.data.buyCount and self.data.usedTimes then
local freeTimes=airGameEnterConfig.getFbConstConfig('free_times')
return freeTimes+self.data.buyCount>(self.data.usedTimes or 99)
end
end


function airGameEnterModel:checkTXZReddot()
local configs=cfg_airgamepushmapgroupconfig()
local group=self:getGroup()
local level=self:getLevel()
for id,cfg in ipairs(configs)do
local condition=cfg.passport_condition
if condition==nil or group>condition[1]or(group==condition[1]and level>=condition[2])then
local txzGuid=UITYTongXingZhengModel:getGuidBySysID(txzType.sys,SYSTEM_DEFINE.eAirGame,id)
if UITYTongXingZhengController:checkReddot(txzGuid)then
return true
end
end
end
return false
end


function airGameEnterModel:getCurFbId()
return self.data.curFbId
end


local _airGameEnterlocalizeInfo='AirGameEnterlocalizeInfo'
function airGameEnterModel:readLocalizeData()
local localData=userActorSetting.get(_airGameEnterlocalizeInfo,{})
self.data.localizeInfo=localData


























if self:checkStageFinish(self.data.group,self.data.level)then
self.data.localizeInfo.curGroup=self.data.localizeInfo.curGroup or 1
if self.data.localizeInfo.curGroup>self.data.group then
self.data.group=self.data.localizeInfo.curGroup
self.data.level=0
end
end
end

function airGameEnterModel:writeLocalizeData()
if self.data.localizeInfo then
userActorSetting.set(_airGameEnterlocalizeInfo,self.data.localizeInfo)
userActorSetting.flush()
end
end

function airGameEnterModel:clearLocalizeData()
self.data.localizeInfo={}
if self.data.localizeInfo then
userActorSetting.set(_airGameEnterlocalizeInfo,self.data.localizeInfo)
userActorSetting.flush()
end
end


function airGameEnterModel:printGroupAndLevel()
local group=self:getGroup()
local level=self:getLevel()


end




