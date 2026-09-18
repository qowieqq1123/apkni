







xjJjJieBaseType={
eMonster=1,
eWar=2,
eMoJie=3,
}

xjJiJieTeamStateType={
eNone=-1,
eWaitJijie=0,
eWaitStart=1,
eBattle=2,

getDesc=function(self_,v)
if v==self_.eWaitJijie then
return'集结中'
elseif v==self_.eWaitStart then
return'等待出击'
elseif v==self_.eBattle then
return'战斗中'
end
end,
}


local serverEnityType2JjJieBaseTypeList={
[xjServerEnityType.eActor]=xjJjJieBaseType.eWar,
[xjServerEnityType.eGuild]=xjJjJieBaseType.eWar,
[xjServerEnityType.eMonster]=xjJjJieBaseType.eMonster,
[xjServerEnityType.eBossMonster]=xjJjJieBaseType.eMonster,
[xjServerEnityType.eStation]=xjJjJieBaseType.eWar,
[xjServerEnityType.eMonsterHouse]=xjJjJieBaseType.eMonster,
[xjServerEnityType.eMoJieMoZong_Small]=xjJjJieBaseType.eMoJie,
[xjServerEnityType.eMoJieMoZong_Big]=xjJjJieBaseType.eMoJie,
[xjServerEnityType.eMoJieShangGuMoster]=xjJjJieBaseType.eMoJie,
[xjServerEnityType.eMoJieZhenYan_Big]=xjJjJieBaseType.eMoJie,
[xjServerEnityType.eLingShou]=xjJjJieBaseType.eWar,
[xjServerEnityType.eLingShouGroup]=xjJjJieBaseType.eWar,
}


local clientBuildType2JjJieBaseTypeList={
[xjClientBuildType.flcbLeiTai1]=xjJjJieBaseType.eWar,
[xjClientBuildType.flcbLeiTai2]=xjJjJieBaseType.eWar,
[xjClientBuildType.flcbLeiTai3]=xjJjJieBaseType.eWar,
[xjClientBuildType.flcbLeiTai4]=xjJjJieBaseType.eWar,
[xjClientBuildType.flcbLeiTai5]=xjJjJieBaseType.eWar,
[xjClientBuildType.flcbLeiTai6]=xjJjJieBaseType.eWar,
[xjClientBuildType.flcbLeiTai7]=xjJjJieBaseType.eWar,
[xjClientBuildType.flcbLeiTai8]=xjJjJieBaseType.eWar,
[xjClientBuildType.flcbMoGong1]=xjJjJieBaseType.eMoJie,
[xjClientBuildType.flcbMoJun1]=xjJjJieBaseType.eMoJie,
[xjClientBuildType.flcbMoJun2]=xjJjJieBaseType.eMoJie,
[xjClientBuildType.flcbMoJun3]=xjJjJieBaseType.eMoJie,
}

local clientBuildType2YBDType={
[xjClientBuildType.flcbLeiTai1]=eYbdType.ZhanZhengYbd,
[xjClientBuildType.flcbLeiTai2]=eYbdType.ZhanZhengYbd,
[xjClientBuildType.flcbLeiTai3]=eYbdType.ZhanZhengYbd,
[xjClientBuildType.flcbLeiTai4]=eYbdType.ZhanZhengYbd,
[xjClientBuildType.flcbLeiTai5]=eYbdType.ZhanZhengYbd,
[xjClientBuildType.flcbLeiTai6]=eYbdType.ZhanZhengYbd,
[xjClientBuildType.flcbLeiTai7]=eYbdType.ZhanZhengYbd,
[xjClientBuildType.flcbLeiTai8]=eYbdType.ZhanZhengYbd,
[xjClientBuildType.flcbMoGong1]=eYbdType.MoJieYbd,
}

function xianjieModel:getClientBdYBDTypeByBuildId(buildId)
buildId=mathHelper.int64_to_number(buildId)
return clientBuildType2YBDType[buildId]
end



function xianjieModel:clearData_jijieSimpleData()
self.jiJieSimpleDataList=nil
self.jiJieSimpleDataList_lookup=nil
end

function xianjieModel:initAllJiJieData()


self:initSelfJiJieTeamDatas()
self:initJiJieTeamDetail()
self:initJiJieYBDListData()
self:initJiJieSelfMassYBDCdStamp()
end

function xianjieModel:getJiJieSimpleDataList()
return self.jiJieSimpleDataList
end

function xianjieModel:getJiJieSimpleDataListByJJType(jjType)
if not self.jiJieSimpleDataList then
return
end

return self.jiJieSimpleDataList[jjType]
end

function xianjieModel:setJiJieSimpleDataList(len,massTeamList,isInit)
if isInit or not self.jiJieSimpleDataList then
self.jiJieSimpleDataList={}
end

if isInit or not self.jiJieSimpleDataList_lookup then
self.jiJieSimpleDataList_lookup={}
end
if len>0 then
for i,v in ipairs(massTeamList)do
local guid=v.guid
local massguid=v.massguid
local isMoJieMass=false
if v.sceneidx then
isMoJieMass=xianjienSceneIndexType:isMoJie(v.sceneidx)or xianjienSceneIndexType:isMoGongZhengDuo(v.sceneidx)
end
v.isMoJieMass=isMoJieMass
local jjType
if v.isMoJieMass then
jjType=xjJjJieBaseType.eMoJie
elseif v.entitytype then
jjType=xianjieModel:getJiJieTypeByEntityTypeAndGuid(v.entitytype,guid)
else
jjType=xianjieModel:getJiJieTypeByGuid(guid,v.sceneidx)
end
if jjType then
if not self.jiJieSimpleDataList[jjType]then
self.jiJieSimpleDataList[jjType]={}
end

local list=self.jiJieSimpleDataList[jjType]
self.jiJieSimpleDataList[jjType][#list+1]=v

local massguidStr=tostring(massguid)
self.jiJieSimpleDataList_lookup[massguidStr]=v
else



end
end
end
end

function xianjieModel:removeJiJieSimpleData(actorId,guid)
if self.jiJieSimpleDataList and next(self.jiJieSimpleDataList)then
local removeIndex
local removeJJType
for jjType,dataList in pairs(self.jiJieSimpleDataList)do
if next(dataList)then
for i,data in ipairs(dataList)do
if mathHelper.compareInt64(actorId,data.actorid)and mathHelper.compareInt64(guid,data.guid)then
removeIndex=i
break
end
end
end

if removeIndex then
removeJJType=jjType
break
end
end

local guidStr=tostring(guid)
if self.jiJieSimpleDataList_lookup and self.jiJieSimpleDataList_lookup[guidStr]then
self.jiJieSimpleDataList_lookup[guidStr]=nil
end

if removeIndex and removeJJType and self.jiJieSimpleDataList[removeJJType]then
table.remove(self.jiJieSimpleDataList[removeJJType],removeIndex)
end
end
end

function xianjieModel:getJiJieSimpleDataByMassGuid(guid)
local guidStr=tostring(guid)
if self.jiJieSimpleDataList_lookup then
return self.jiJieSimpleDataList_lookup[guidStr]
end
return nil
end

function xianjieModel:checkJiJieIsMoJieByMassGuid(guid)
local data=xianjieModel:getJiJieSimpleDataByMassGuid(guid)
if data then
return data.isMoJieMass or false
end
return nil
end


function xianjieModel:clearData_jiJieDirtyDataList()
self.jiJieDirtyDataList=nil
end

function xianjieModel:initJiJieDirtyDataList()
local allList={}

local teamDataList=self:getJiJieSimpleDataList()or{}
for jjType,list in pairs(teamDataList)do
local lookup={}
local typeNum=0
if list and next(list)then
for i,data in ipairs(list)do
local actorId=data.actorid
local guid=data.massguid
local actorIdStr=tostring(actorId)
local guidStr=tostring(guid)
if not lookup[guidStr]then
lookup[guidStr]={}
end

if not lookup[guidStr][actorIdStr]then
lookup[guidStr][actorIdStr]=true
typeNum=typeNum+1
end
end
end

allList[jjType]={
typeNum=typeNum,
lookup=lookup,
}
end
self.jiJieDirtyDataList=allList
end

function xianjieModel:setJiJieDirtyData(actorId,massguid,infoguid,flag)
local isRemove=flag==3
local isAdd=flag==1
local actorIdStr=tostring(actorId)
local guidStr=tostring(massguid)

local jjType
local jiJieData=xianjieModel:getJiJieSimpleDataByMassGuid(massguid)
if jiJieData and jiJieData.entitytype then
jjType=xianjieModel:getJiJieTypeByEntityTypeAndGuid(jiJieData.entitytype,infoguid)
else
local sceneIdx=jiJieData and jiJieData.sceneidx
jjType=self:getJiJieTypeByGuid(infoguid,sceneIdx)
end

if jjType then

if isRemove then

if not self.jiJieDirtyDataList then
return
end
local data=self.jiJieDirtyDataList[jjType]
if data then
local lookup=data.lookup
if lookup[guidStr]and lookup[guidStr][actorIdStr]then
lookup[guidStr][actorIdStr]=nil
data.typeNum=data.typeNum-1
end
local data=self.jiJieDirtyDataList[jjType]
if data then
local lookup=data.lookup
if lookup[guidStr]and lookup[guidStr][actorIdStr]then
lookup[guidStr][actorIdStr]=nil
data.typeNum=data.typeNum-1
end
end
end
elseif isAdd then

if not self.jiJieDirtyDataList then
self:initJiJieDirtyDataList()
end

if not self.jiJieDirtyDataList[jjType]then
self.jiJieDirtyDataList[jjType]={
typeNum=0,
lookup={},
}
end

local data=self.jiJieDirtyDataList[jjType]
local lookup=data.lookup
if not lookup[guidStr]then
lookup[guidStr]={}
end

if not lookup[guidStr][actorIdStr]then
lookup[guidStr][actorIdStr]=true
data.typeNum=data.typeNum+1
end
end
end
end

function xianjieModel:getJiJieDirtyDataAllNum()
if not self.jiJieDirtyDataList then
self:initJiJieDirtyDataList()
end

local allNum=0
for jjType,data in pairs(self.jiJieDirtyDataList)do
allNum=allNum+data.typeNum
end

return allNum
end

function xianjieModel:getJiJieDirtyDataTypeNum(jjType)
if not self.jiJieDirtyDataList then
self:initJiJieDirtyDataList()
end

if not self.jiJieDirtyDataList[jjType]then
return 0
end

return self.jiJieDirtyDataList[jjType].typeNum or 0
end

function xianjieModel:getJiJieDirtyData(actorId,guid,infoguid,sceneidx)
if not self.jiJieDirtyDataList then
self:initJiJieDirtyDataList()
end

local actorIdStr=tostring(actorId)
local guidStr=tostring(guid)

local jjType
local jiJieData=xianjieModel:getJiJieSimpleDataByMassGuid(guid)
if jiJieData and jiJieData.entitytype then
jjType=xianjieModel:getJiJieTypeByEntityTypeAndGuid(jiJieData.entitytype,infoguid)
else
jjType=self:getJiJieTypeByGuid(infoguid,sceneidx)
end
if jjType then
if not self.jiJieDirtyDataList[jjType]then
return nil
end

local data=self.jiJieDirtyDataList[jjType]
local lookup=data.lookup
if lookup[guidStr]then
return lookup[guidStr][actorIdStr]
end
end

return nil
end


function xianjieModel:clearJiJieDirtyDataByGuid(guid,sceneidx)
local guidStr=tostring(guid)
local jjType=self:getJiJieTypeByGuid(guid,sceneidx)
if not self.jiJieDirtyDataList then
return
end
if jjType then
local data=self.jiJieDirtyDataList[jjType]
if data then
local lookup=data.lookup
if lookup and lookup[guidStr]then
local removeNum=0
for actorIdStr,v in pairs(lookup[guidStr])do
removeNum=removeNum+1
end
lookup[guidStr]=nil
data.typeNum=data.typeNum-removeNum
end
end
end
end



function xianjieModel:clearData_selfJiJieTeam()
if self.selfJiJieTeamDatas and next(self.selfJiJieTeamDatas)then
for i,v in pairs(self.selfJiJieTeamDatas)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.selfJiJieTeamDatas=nil
end

function xianjieModel:initSelfJiJieTeamDatas()
xianjieModel:clearData_selfJiJieTeam()
self.selfJiJieTeamDatas={}
end

function xianjieModel:refreshSelfJiJieTeamData(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eJiJieWait
if not self.selfJiJieTeamDatas then

return
end

local sceneidx=v.sceneidx
if isInit then

self.selfJiJieTeamDatas[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.selfJiJieTeamDatas[guid_str].teamHandleId=teamHandleID
else
local teamData=self.selfJiJieTeamDatas[guid_str]
if teamData==nil then

self.selfJiJieTeamDatas[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.selfJiJieTeamDatas[guid_str].teamHandleId=teamHandleID
else


self.selfJiJieTeamDatas[guid_str].data=v
self.selfJiJieTeamDatas[guid_str].sceneidx=sceneidx
end
end
end

function xianjieModel:removeSelfJiJieTeamData(guid)
local guid_str=tostring(guid)
local teamData=self.selfJiJieTeamDatas[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.selfJiJieTeamDatas[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eJiJIe,guid,teamHandleID,boatid,true)
else



end
end

function xianjieModel:getSelfJiJieTeamData(guid)
if self.selfJiJieTeamDatas then
local guid_str=tostring(guid)
return self.selfJiJieTeamDatas[guid_str]
end
end

function xianjieModel:getAllSelfJiJieTeamData()
return self.selfJiJieTeamDatas
end

function xianjieModel:getSelfJiJieTeamDataByInfoguid(infoguid)
if self.selfJiJieTeamDatas then
for guid_str,teamData in pairs(self.selfJiJieTeamDatas)do
local paramList=teamData.data.paramList
if paramList and next(paramList)then
local teamInfoguid=paramList[3]
if mathHelper.compareInt64(infoguid,teamInfoguid)then
return teamData
end
end
end
end
end


function xianjieModel:getSelfInitiatedJiJieTeamDataByInfoguid(infoguid)
if self.selfJiJieTeamDatas then
for guid_str,teamData in pairs(self.selfJiJieTeamDatas)do
local paramList=teamData.data.paramList
if paramList and next(paramList)then
local actorId=paramList[2]
local teamInfoguid=paramList[3]
if mathHelper.compareInt64(infoguid,teamInfoguid)and playerModel:checkActorId(actorId)then
return teamData
end
end
end
end
end


function xianjieModel:clearData_jiJieTeamDetail()
if self.jiJieTeamDetail and next(self.jiJieTeamDetail)then
for i,v in pairs(self.jiJieTeamDetail)do
local teamHandleId=v.jiJieTeamDetail
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.jiJieTeamDetail=nil
end

function xianjieModel:initJiJieTeamDetail()

if not self.jiJieTeamDetail then
self.jiJieTeamDetail={}
end
end

function xianjieModel:refreshJiJieTeamDetail(actorId,guid,sec,autoGo,memberLen,memberList,maxSoldierCount,endGo,infoguid,isMoJieMass)
if memberLen<=0 then

return self:removeJiJieTeamDetail(actorId,guid)
end
local actorIdStr=tostring(actorId)
local guidStr=tostring(guid)

if not self.jiJieTeamDetail[actorIdStr]then
self.jiJieTeamDetail[actorIdStr]={}
end

local sceneidx
if isMoJieMass then
sceneidx=xianjieModel:getCurrentMoJieSceneIndex()
end
self.jiJieTeamDetail[actorIdStr][guidStr]={
initiatorActorId=actorId,
guid=guid,
sec=sec,
autoGo=autoGo,
memberCount=memberLen,
memberList=memberList,
maxSoldierCount=maxSoldierCount,
endGo=endGo,
infoguid=infoguid,
isMoJieMass=isMoJieMass,
sceneidx=sceneidx,
}
end

function xianjieModel:removeJiJieTeamDetail(actorId,guid)
local guid_str=tostring(guid)
local actorIdStr=tostring(actorId)
local teamData=self.jiJieTeamDetail[actorIdStr]and self.jiJieTeamDetail[actorIdStr][guid_str]
if teamData~=nil then
self.jiJieTeamDetail[actorIdStr][guid_str]=nil
end
end

function xianjieModel:getJiJieTeamDetail(actorId,guid)
local guid_str=tostring(guid)
local actorIdStr=tostring(actorId)
if self.jiJieTeamDetail and self.jiJieTeamDetail[actorIdStr]then
return self.jiJieTeamDetail[actorIdStr][guid_str]
end
end


function xianjieModel:setJiJieTeamDetail_autoFlag(actorId,guid,autoFlag)
local guid_str=tostring(guid)
local actorIdStr=tostring(actorId)
if self.jiJieTeamDetail and self.jiJieTeamDetail[actorIdStr]and self.jiJieTeamDetail[actorIdStr][guid_str]then
self.jiJieTeamDetail[actorIdStr][guid_str].autoGo=autoFlag
end
end

function xianjieModel:setJiJieTeamDetail_endGoFlag(actorId,guid,endGoFlag)
local guid_str=tostring(guid)
local actorIdStr=tostring(actorId)
if self.jiJieTeamDetail and self.jiJieTeamDetail[actorIdStr]and self.jiJieTeamDetail[actorIdStr][guid_str]then
self.jiJieTeamDetail[actorIdStr][guid_str].endGo=endGoFlag
end
end


function xianjieModel:clearData_jiJieYBDData()
self.jiJieYBDData=nil
end

function xianjieModel:initJiJieYBDData()
xianjieModel:clearData_jiJieYBDData()
self.jiJieYBDData={}
end

function xianjieModel:getJiJieYBDData()
return self.jiJieYBDData
end


function xianjieModel:setJiJieYBDData_pveCndStage(stage)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end

if not self.jiJieYBDData.pveCnd then
self.jiJieYBDData.pveCnd={}
end
self.jiJieYBDData.pveCnd.monsterStage=stage
end


function xianjieModel:getJiJieYBDData_yzIdLookup()
if not self.jiJieYBDData or not self.jiJieYBDData.teamData then
return nil
end

local lookup={}
for ybdType,teamData in pairs(self.jiJieYBDData.teamData)do
local yzId=teamData.yzId
lookup[yzId]=true
end
end


function xianjieModel:setJiJieYBDData_teamData(ybdType,teamData)
if not teamData then
return
end

if not self.jiJieYBDData then
self.jiJieYBDData={}
end

if not self.jiJieYBDData.teamData then
self.jiJieYBDData.teamData={}
end

local dzList=teamData.guidList
local dzListLen=teamData.guidlistlen

local moneyList={}
if teamData.moneylistlen and teamData.moneylistlen>0 then
for i,v in ipairs(teamData.moneyList)do
local moneyType=v.param_1
local moneyCount=v.param_2
moneyList[#moneyList+1]={moneyType,moneyCount}
end
end
self.jiJieYBDData.teamData[ybdType]={
yzId=teamData.boatid,
dzList=dzList,
soldierList=moneyList,
}

if not self.jiJieYBDData.teamDataDzList_lookup then
self.jiJieYBDData.teamDataDzList_lookup={}
end

local lookup={}
if dzListLen>0 then
for posIdx,dzGuid in pairs(dzList)do
if not mathHelper.compareInt64(dzGuid,Int64_0)then
local dzGuidStr=tostring(dzGuid)
lookup[dzGuidStr]=true
end
end
end
self.jiJieYBDData.teamDataDzList_lookup[ybdType]=lookup
end


function xianjieModel:getJiJieYBDData_teamDataByYBDType(ybdType)
if not self.jiJieYBDData or not self.jiJieYBDData.teamData then
return nil
end

return self.jiJieYBDData.teamData[ybdType]
end

function xianjieModel:checkJiJieYBDData_dzIsInYBD(dzGuid)
if not self.jiJieYBDData or not self.jiJieYBDData.teamDataDzList_lookup then
return false
end

if mathHelper.compareInt64(dzGuid,Int64_0)then
return false
end

local dzGuidStr=tostring(dzGuid)
for ybdType,lookup in pairs(self.jiJieYBDData.teamDataDzList_lookup)do
if lookup[dzGuidStr]then
return true
end
end

return false
end


function xianjieModel:setJiJieYBDData_openFlag(openFlag)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end
self.jiJieYBDData.openFlag=openFlag
end


function xianjieModel:setJiJieYBDData_moneyNum(moneyNum)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end

self.jiJieYBDData.moneyNum=moneyNum
end


function xianjieModel:setJiJieYBDData_moling(num)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end
self.jiJieYBDData.molingCnt=num
end


function xianjieModel:setJiJieYBDData_soldierList(len,soldierList)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end

local list={}
if len>0 then
for i,v in ipairs(soldierList)do
local moneyType=v.param_1
local moneyCount=v.param_2
list[#list+1]={moneyType,moneyCount}
end
end
self.jiJieYBDData.soldierList=list
end


function xianjieModel:setJiJieYBDData_singleSoldierNum(singleSoldierNum)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end

self.jiJieYBDData.singleSoldierNum=singleSoldierNum
end


function xianjieModel:setJiJieYBDData_postLimitList(rtType,len,postList)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end

local list={}
if len>0 then
for i,postId in ipairs(postList)do
list[postId]=true
end
end
if not self.jiJieYBDData.postList then
self.jiJieYBDData.postList={}
end
self.jiJieYBDData.postList[rtType]=list
end


function xianjieModel:setJiJieYBDData_rewardJoinFlag(rewardJoinFlag)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end

self.jiJieYBDData.rewardJoinFlag=rewardJoinFlag
end


function xianjieModel:setJiJieYBDData_lsRewardJoinFlag(lsRewardJoinFlag)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end

self.jiJieYBDData.lsRewardJoinFlag=lsRewardJoinFlag
end


function xianjieModel:setJiJieYBDData_rejectedXmXXList(len,xmList)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end

local list={}
if len>0 then
for i,xmFlag in ipairs(xmList)do
list[xmFlag]=true
end
end
self.jiJieYBDData.rejectedXmXXList=list
end


function xianjieModel:setJiJieYBDData_rejectedXgXXList(len,xgList)
if not self.jiJieYBDData then
self.jiJieYBDData={}
end

local list={}
if len>0 then
for i,xgtType in ipairs(xgList)do
list[xgtType]=true
end
end
self.jiJieYBDData.rejectedXgXXList=list
end



function xianjieModel:checkHasJiJieYBDIsOpen(jjType)
local checkPosIndex
if jjType==xjJjJieBaseType.eMonster then
checkPosIndex=0
elseif jjType==xjJjJieBaseType.eWar then
checkPosIndex=1
end

local ybdData=self:getJiJieYBDData()
if ybdData then
local openFlag=ybdData and ybdData.openFlag or 0
local isOpen=bitHelper.check_pos(openFlag,checkPosIndex)
return isOpen
end

return false
end


function xianjieModel:checkJiJieYBDSysIsOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eXianJieYuBeiDui)
end


function xianjieModel:clearData_jiJieYBDListData()
self.jiJieYBDListData=nil
end

function xianjieModel:initJiJieYBDListData()

if not self.jiJieYBDListData then
self.jiJieYBDListData={}
end
end

function xianjieModel:setJiJieYBDListData(len,list)
if len>0 then
self.jiJieYBDListData=list
else
self.jiJieYBDListData={}
end
end

function xianjieModel:getJiJieYBDListData()
return self.jiJieYBDListData
end

function xianjieModel:getJiJieYBDListDataByActorId(actorId)
if not self.jiJieYBDListData then
return nil
end

for i,v in ipairs(self.jiJieYBDListData)do
if mathHelper.compareInt64(v.actorid,actorId)then
return v
end
end

return nil
end


function xianjieModel:getJiJieSelfMassYBDCd()
local cdTime=5
return cdTime
end

function xianjieModel:clearData_jiJieSelfMassYBDCdStamp()
self.jiJieSelfMassYBDCdStamp=nil
end

function xianjieModel:initJiJieSelfMassYBDCdStamp()

if not self.jiJieSelfMassYBDCdStamp then
self.jiJieSelfMassYBDCdStamp={}
end
end

function xianjieModel:setJiJieSelfMassYBDCdStamp(massGuid,targetActorId)
if not self.jiJieSelfMassYBDCdStamp then
self.jiJieSelfMassYBDCdStamp={}
end
local massGuidStr=tostring(massGuid)
if not self.jiJieSelfMassYBDCdStamp[massGuidStr]then
self.jiJieSelfMassYBDCdStamp[massGuidStr]={}
end
local actorIdStr=tostring(targetActorId)
local nowTime=timeHelper.getServerShortTime()
self.jiJieSelfMassYBDCdStamp[massGuidStr][actorIdStr]=nowTime
end

function xianjieModel:clearJiJieSelfMassYBDCdStampByMassGuid(massGuid)
if not self.jiJieSelfMassYBDCdStamp then
return
end

local massGuidStr=tostring(massGuid)
self.jiJieSelfMassYBDCdStamp[massGuidStr]=nil
end

function xianjieModel:getJiJieSelfMassYBDCdStamp(massGuid,targetActorId)
if not self.jiJieSelfMassYBDCdStamp then
return nil
end
local massGuidStr=tostring(massGuid)
if not self.jiJieSelfMassYBDCdStamp[massGuidStr]then
return nil
end
local actorIdStr=tostring(targetActorId)
return self.jiJieSelfMassYBDCdStamp[massGuidStr][actorIdStr]
end


function xianjieModel:clearData_jiJieLocalData()
self.jiJieLocalData=nil
end

function xianjieModel:getJiJieLocalData()
if not self.jiJieLocalData then
self:loadJiJieLocalData()
end
return self.jiJieLocalData
end

function xianjieModel:setJiJieLocalData_lastSelectJJIndex(lastSelectJJIndex)
if not self.jiJieLocalData then
self.jiJieLocalData={}
end
self.jiJieLocalData.lastSelectJJIndex=lastSelectJJIndex
end

function xianjieModel:setJiJieLocalData_lastSelectAutoFlag(lastSelectAutoFlag)
if not self.jiJieLocalData then
self.jiJieLocalData={}
end
self.jiJieLocalData.lastSelectAutoFlag=lastSelectAutoFlag
end

function xianjieModel:setJiJieLocalData_lastSelectEndGoFlag(lastSelectEndGoFlag)
if not self.jiJieLocalData then
self.jiJieLocalData={}
end
self.jiJieLocalData.lastSelectEndGoFlag=lastSelectEndGoFlag
end

function xianjieModel:saveJiJieLocalData()
local saveData={}
if self.jiJieLocalData and next(self.jiJieLocalData)then
saveData.lastSelectJJIndex=self.jiJieLocalData.lastSelectJJIndex
saveData.lastSelectAutoFlag=self.jiJieLocalData.lastSelectAutoFlag
saveData.lastSelectEndGoFlag=self.jiJieLocalData.lastSelectEndGoFlag

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXJJiJieLocal,'xjJiJieLocalData',saveData)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXJJiJieLocal)
end
end

function xianjieModel:loadJiJieLocalData()
local saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXJJiJieLocal,'xjJiJieLocalData',{})
local jiJieLocalData={}
jiJieLocalData.lastSelectJJIndex=saveData.lastSelectJJIndex
jiJieLocalData.lastSelectAutoFlag=saveData.lastSelectAutoFlag
jiJieLocalData.lastSelectEndGoFlag=saveData.lastSelectEndGoFlag
self.jiJieLocalData=jiJieLocalData
end


function xianjieModel:getJiJieTypeByGuid(guid,sceneIdx)
local entityType=xianjieModel:getEntityTypeByGuid(guid,sceneIdx)
if entityType then
return xianjieModel:getJiJieTypeByEntityTypeAndGuid(entityType,guid)
end
return nil
end

function xianjieModel:getJiJieTypeByEntityTypeAndGuid(entityType,guid)
if entityType==xjServerEnityType.eClientBuild then

local clientBdId=mathHelper.int64_to_number(guid)
return clientBuildType2JjJieBaseTypeList[clientBdId]
else
return serverEnityType2JjJieBaseTypeList[entityType]
end
end

function xianjieModel:checkCanJiJie()

local hasXM=xianmengModel:hasXM()
if not hasXM then
local err="未加入仙盟，无法发起集结"
return false,err
end


local chapter_idx=6
local season_id=0
local isStart=seasonController:checkSeasonStageBegined(season_id,chapter_idx)


if not isStart then
local seasonName=seasonModel:getHandleConfig(season_id,'name')
local chapter_idx_str=mathHelper.numberToChinese(chapter_idx)
local chapterName=seasonModel:getStageConfigEx(season_id,chapter_idx,"name")
local err=FMT.fmt("开启【{0}-第{1}章·{2}】后解锁集结",seasonName,chapter_idx_str,chapterName)
return false,err
end

return true
end


function xianjieModel:checkHasSelfInitiatorJiJie(sceneIdx)
if not sceneIdx then
sceneIdx=xianjieModel:getSceneIndex()
end
local isInMoJie=xianjienSceneIndexType:isMoJie(sceneIdx)
local teamDataList=self:getAllSelfJiJieTeamData()or{}
for guidStr,teamData in pairs(teamDataList)do
if teamData and next(teamData)then
local massSceneIdx=teamData.sceneidx
local isMoJieMass=xianjienSceneIndexType:isMoJie(massSceneIdx)
if isInMoJie==isMoJieMass then

local paramList=teamData.data.paramList
if paramList and next(paramList)then
local actorId=paramList[2]
local isSelfInitiator=playerModel:checkActorId(actorId)
if isSelfInitiator then
return true
end
end
end
end
end
return false
end





function xianjieModel:getJiJieAddCount()
local tsd_max_cnt=tianShuDianController:getChuZhengXiuShiMaxCount()


local prsent=(xianjieModel:getJZAttrLookup(eAttributeType.eJZ_CNT)or 0)
if prsent then
tsd_max_cnt=tsd_max_cnt*(1+prsent/10000)
end

local value=(xianjieModel:getJZAttrLookup(eAttributeType.eJZ_CNT_VALUE)or 0)
if value then
tsd_max_cnt=tsd_max_cnt+value
end

return tsd_max_cnt
end


function xianjieModel:getOtherJiJieAddCount(tsd_max_cnt,attrList)
attrList=attrList or{}
local prsent=attrList[eAttributeType.eJZ_CNT]or 0
if prsent then
tsd_max_cnt=tsd_max_cnt*(1+prsent/10000)
end

local value=attrList[eAttributeType.eJZ_CNT_VALUE]or 0
if value then
tsd_max_cnt=tsd_max_cnt+value
end

return tsd_max_cnt
end


