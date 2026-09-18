







xjCloudSearchType={
eBegin=1,
eGoto=2,
eBack=3,
eEvent=4,
eQiYuEvent=5,
eUnlock=6,
}

xjCloudPlotType={
eMonster=1,
eQiYuEvent=2,
eTask=3,
}

xjCloudPlotStateType={
eFinishBack=-1,
eFinish=0,
eNone=1,
eGoto=2,
eBattle=3,
eFailBack=4,
eRetract=5,

checkDoing=function(self_,v)
return v~=self_.eFinish and v~=self_.eNone
end,
getDesc=function(self_,v)
if v==self_.eGoto then
return'前往中'
elseif v==self_.eBattle then
return'战斗中'
elseif v==self_.eFailBack or v==self_.eFinishBack then
return'返程中'
end
end,
}

local _mapSize
local _battleTime=5
local _uselessCloudsLookup
local _baseCloudLookup

function xianjieModel:initData_plot(x,y,list)
local sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,xianjienSceneType.eXianJie)
local sceneidxcfg=cfgHelper.get1(cfg_fairylandsceneidxconfig_get,sceneCfg.mapIndex)
_mapSize=sceneidxcfg.mapSize
_uselessCloudsLookup={}
local useless=cfgHelper.get2(cfg_fairylandcloudbaseconfig_get,1,'useless')
for i,cloudid in ipairs(useless)do
_uselessCloudsLookup[cloudid]=true
end
_baseCloudLookup={}
local cfgs=cfg_fairylandcloudconfig()
for cloudid,cfg in pairs(cfgs)do
for i,cloudid_ in ipairs(cfg.ids)do
_baseCloudLookup[cloudid_]=cloudid
end
end


xianjieModel:clearAllCloudData()

local data={}
self.mPlotData=data
local cloudLookup={}
data.cloudLookup=cloudLookup
if list then
for i,v in ipairs(list)do
local cloudData=xianjieController:createXJClass(xjDataType.eCloud,v)
cloudLookup[cloudData.cloudid]=cloudData
cloudData:initData()
end
end

local sceneIndex=xianjieModel:getSceneIndex(xianjienSceneType.eXianJie)
xianjieModel:initMyZongMenData(x,y,sceneIndex)
xianjieModel:refreshAllCloudUnlock()
xianjieModel:initCloudEntity()
end

function xianjieModel:clearData_plot()
xianjieModel:clearAllCloudData()
self.mPlotData=nil
self.enterPlotMark=nil
_mapSize=nil
_uselessCloudsLookup=nil
_baseCloudLookup=nil
end

function xianjieModel:clearData_plotBehavior()
if self.mPlotData then
local cloudLookup=self.mPlotData.cloudLookup
if cloudLookup then
for cloudid,cloudData in pairs(cloudLookup)do
cloudData:clearBehaviorEx()
local cloudPlotlp=cloudData.cloudPlotlp
for plotIdx,cloudPlotData in pairs(cloudPlotlp)do
cloudPlotData:clearBehaviorEx()
end
end
end
end
end

function xianjieModel:clearAllCloudData()
if self.mPlotData then
local cloudLookup=self.mPlotData.cloudLookup
if cloudLookup then
for cloudid,cloudData in pairs(cloudLookup)do
xianjieController:removeXJClass(cloudData)
end
self.mPlotData.cloudLookup=nil
end
local cloudEntityLookup=self.mPlotData.cloudEntityLookup
if cloudEntityLookup then
for cloudid,cloudEntData in pairs(cloudEntityLookup)do
xianjieController:removeXJClass(cloudEntData)
end
self.mPlotData.cloudEntityLookup=nil
end
end
end


function xianjieModel:createCloudUnLockEntity()
local lp=xianjieModel:getCloudLookup()
if lp then
for cloudid,cloudData in pairs(lp)do
cloudData:createCloudUnLockEntity()
cloudData:initQiYuEntity()
end
end
end

function xianjieModel:ClearCloudUnLockEntity()
local lp=xianjieModel:getCloudLookup()
if lp then
for cloudid,cloudData in pairs(lp)do
cloudData:clearQiYuEventEntity()
cloudData:clearCloudUnLockEntity()
end
end
end

function xianjieModel:setEnterPlotMark(flag)
self.enterPlotMark=flag
end

function xianjieModel:checkEnterPlotMark()
return self.enterPlotMark==true
end

function xianjieModel:getCloudSearchSpeed()
local searchSpeed=cfgHelper.get2(cfg_fairylandcloudbaseconfig_get,1,'searchSpeed')
return searchSpeed
end

function xianjieModel:getPlotBattleTime()
return _battleTime
end

function xianjieModel:getDZState_plot(disguid_str,showDesc)
local lp=xianjieModel:getCloudLookup()
if lp then
for cloudid,cloudData in pairs(lp)do
if cloudData.hasDZ and not cloudData:isSearchBack()then
if cloudData:checkDZIn(disguid_str)then
local desc
if showDesc then
desc='探索中'
end
return 1,desc
end
end
for plotIdx,cloudPlotData in pairs(cloudData.cloudPlotlp)do
local state=cloudData:checkCloudPlotState(plotIdx)
if xjCloudPlotStateType:checkDoing(state)then
if cloudData:checkDZIn_plot(plotIdx,disguid_str)then
local desc
if showDesc then
desc='讨伐中'
end
return 2,desc
end
end
end
end
end
return nil,nil
end

function xianjieModel:changeCloudRewardRecvIdx(recv_idx,is_recv_queue)
self.cloudRewardRecvIdx=recv_idx
self.is_recv_queue=is_recv_queue
end

function xianjieModel:changeCloudRecvQueue()
self.is_recv_queue=1
end

function xianjieModel:getCloudRewardRecvIdx()
return self.cloudRewardRecvIdx or 0
end

function xianjieModel:getCloudIsRecvQueue()
return self.is_recv_queue==1
end

function xianjieModel:getCJXYIsRecvQueue()
local recordNum=gameUtilityModel:getData_counter(gameCounterType.eXJCJXYTeamActity)
if recordNum and recordNum>0 then
return true
end
return false
end


function xianjieModel:getCloudUnlockCount()
local lp=xianjieModel:getCloudLookup()
if lp then
local count=0
local cfgs=cfg_fairylandcloudconfig()
local cloudIdLockup=xianjieModel:getInitUnlockCloudByCloudidLockup()
for cloudid,cfg in pairs(cfgs)do
if type(cloudid)=='number'then
local cloudData=lp[cloudid]
if cloudData~=nil and not cloudIdLockup[cloudid]and cloudData:isUnlock()then
count=count+1
end
end
end
return count
end
return 0
end


function xianjieModel:getInitUnlockCloudByCloudidLockup()
if not self.cloudLockup then
self.cloudLockup={}
local clouds=cfgHelper.get2(cfg_fairylandcloudbaseconfig_get,1,'clouds')
for _,cloudId in ipairs(clouds)do
self.cloudLockup[cloudId]=true
end
end
return self.cloudLockup
end



function xianjieModel:checkGridInMap_plot(gridX,gridZ)
return gridX>=0 and gridX<_mapSize[1]and gridZ>=0 and gridZ<_mapSize[2]
end

function xianjieModel:caculationCloudID(gridX,gridZ)
if xianjieModel:checkGridInMap_plot(gridX,gridZ)then
local cloudSize=cfgHelper.get2(cfg_fairylandcloudbaseconfig_get,1,'cloudSize')
local col=math.ceil(_mapSize[2]/cloudSize[2])
local c=math.ceil(gridX/cloudSize[2])
if c==0 then c=1 end
local r=math.ceil(gridZ/cloudSize[1])
if r==0 then r=1 end
local b_cloudid=(r-1)*col+c
if _uselessCloudsLookup[b_cloudid]==nil then
local cloudid=_baseCloudLookup[b_cloudid]
if cloudid then
return cloudid
end
end
end
return nil
end


function xianjieModel:caculationBaseCloudSize(b_cloudid)
local cloudSize=cfgHelper.get2(cfg_fairylandcloudbaseconfig_get,1,'cloudSize')
local col=math.ceil(_mapSize[2]/cloudSize[2])
local c=b_cloudid%col
if c==0 then c=col end
local r=math.ceil(b_cloudid/col)

local pos={(c-1)*cloudSize[1],(r-1)*cloudSize[2]}

local pos_c={pos[1]+cloudSize[1]/2,pos[2]+cloudSize[2]/2}
return pos_c,pos,{cloudSize[1],cloudSize[2]}
end

function xianjieModel:caculationCloudSize(cloudid)
local cfg=cfgHelper.get1(cfg_fairylandcloudconfig_get,cloudid)
local ids=cfg.ids
local n=#ids
local pos_c,pos,cloudSize=xianjieModel:caculationBaseCloudSize(ids[1])
if cfg.center then
pos_c=cfg.center
end
if n>1 then
for i=2,n do
local pos_c_,pos_,cloudSize_=xianjieModel:caculationBaseCloudSize(ids[i])
if pos_[1]~=pos[1]then
cloudSize[1]=cloudSize[1]+cloudSize_[1]
end
if pos_[2]~=pos[2]then
cloudSize[2]=cloudSize[2]+cloudSize_[2]
end
end
end
return pos_c,pos,cloudSize
end

function xianjieModel:getCloudLookup()
if self.mPlotData then
return self.mPlotData.cloudLookup
end
end

function xianjieModel:newCloudData(cloudid,discipleList)
if self.mPlotData==nil then return end
local cloudData_=self.mPlotData.cloudLookup[cloudid]
if cloudData_~=nil then return end
local data={}
data.cloudid=cloudid
data.idx=xjCloudSearchType.eBegin
data.disciplelistlen=#discipleList
data.discipleList=discipleList

data.beginsec=gameUtilityModel.getServerShortTime()


data.len=0
data.list=nil
data.march=nil
local cloudData=xianjieController:createXJClass(xjDataType.eCloud,data)
self.mPlotData.cloudLookup[cloudid]=cloudData
cloudData:initData()

local teamHandle=cloudData:getTeamHandle()
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eAdd,teamHandle)
end

function xianjieModel:getCloudData(cloudid)
if self.mPlotData then
return self.mPlotData.cloudLookup[cloudid]
end
end

function xianjieModel:clearCloudBehavior(cloudid,tree)
local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then
cloudData:clearBehavior(tree)
end
end

function xianjieModel:checkAllCloudUnlock()
local lp=xianjieModel:getCloudLookup()
if lp then
local cfgs=cfg_fairylandcloudconfig()
for cloudid,cfg in pairs(cfgs)do
if type(cloudid)=='number'then
local cloudData=lp[cloudid]
if cloudData==nil or not cloudData:isUnlock()then
return false
end
end
end
return true
end
return false
end

function xianjieModel:checkHasCloudSeardCloudOpen()
local clouds=cfgHelper.get2(cfg_fairylandcloudbaseconfig_get,1,'clouds')
for _,cloudId in ipairs(clouds)do
if xianjieController:checkSeardCloudOpen(cloudId)then
return true
end
end
return false
end

function xianjieModel:checkCloudUnlockReward()
local unlock_queue=cfgHelper.get2(cfg_fairylandexplorebaseconfig_get,1,"unlock_queue")
local maxCount=unlock_queue[1]
local total=xianjieModel:getCloudUnlockCount()
local recvIdx=xianjieModel:getCloudRewardRecvIdx()
local isRecvQueue=xianjieModel:getCloudIsRecvQueue()
local target_conf=cfgHelper.get2(cfg_fairylandexplorebaseconfig_get,1,"target_conf")
for i=recvIdx+1,#target_conf do
local num=target_conf[i][1]
if total>=num then
return true
end
end
return total>=maxCount and not isRecvQueue
end

function xianjieModel:refreshAllCloudUnlock()
self.allCloudUnlock=xianjieModel:checkAllCloudUnlock()
end

function xianjieModel:checkAllCloudUnlockEx()
return self.allCloudUnlock
end

function xianjieModel:getCloudLockList()
local lp=xianjieModel:getCloudLookup()
if lp then
local list={}
local cfgs=cfg_fairylandcloudconfig()
for cloudid,cfg in pairs(cfgs)do
if type(cloudid)=='number'then
local cloudData=lp[cloudid]
if cloudData==nil or not cloudData:isUnlock()then
for i,cloudid_ in ipairs(cfg.ids)do
table.insert(list,cloudid_-1)
end
end
end
end
if#list>0 then
return list
end
end
return nil
end

function xianjieModel:getCloudLockList2(cloudid)
local list={}
local ids=cfgHelper.get2(cfg_fairylandcloudconfig_get,cloudid,'ids')
for i,cloudid_ in ipairs(ids)do
table.insert(list,cloudid_-1)
end
return list
end

function xianjieModel:getCloudMsgList()
local list={}
local lp=xianjieModel:getCloudLookup()
if lp then
for cloudid,cloudData in pairs(lp)do
if cloudData:hasMsg()then
table.insert(list,cloudid)
end
end
end
return list
end

function xianjieModel:checkCloudMsg()
if not xianjieController:checkXianJieSystemOpen()then
return false
end
if not xianjieModel:checkHasCloudSeardCloudOpen()then
return false
end
return not xianjieModel:checkAllCloudUnlock()or xianjieModel:checkCloudUnlockReward()or not xianjieModel:getCloudIsRecvQueue()
end

function xianjieModel:checkCloudMsgReddot()
if not xianjieController:checkXianJieSystemOpen()then
return false
end
if xianjieModel:checkCloudUnlockReward()then
return true
end
local hasWaiPaiTeamNum=xianjieModel:checkWaiPaiTeamNum(false)
local lp=xianjieModel:getCloudLookup()
if lp then
for cloudid,cloudData in pairs(lp)do
local hasDisciple=xianjieModel:getIsHasDisciple(cloudid)
if cloudData:canUnlock()then
return true
end
if hasWaiPaiTeamNum and hasDisciple and cloudData:hasMsg()then
return true
end

local border=cfgHelper.get2(cfg_fairylandcloudconfig_get,cloudid,'border')
for i,cloudid_ in ipairs(border)do
local canSearch=xianjieModel:checkCloudCanSearch(cloudid_)
if not lp[cloudid_]and hasWaiPaiTeamNum and hasDisciple and canSearch then
return true
end
end
end
end
return false
end


function xianjieModel:getIsHasDisciple(cloudid)
local list=UIDiscipleModel:getSortList()
for i,data in pairs(list)do
local guid=data.discipleguid
local check=xianjieController:checkSeardCloudSelectDZ(cloudid,guid)
local checkFlag=not UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
local stateType,stateName=xianjieModel:getDZState(guid,true)
if check and checkFlag and stateName==nil then
return true
end
end
return false
end


function xianjieModel:checkCloudCanSearch(cloudid,isWarning)
local lp=xianjieModel:getCloudLookup()
if lp~=nil and lp[cloudid]==nil then
local border=cfgHelper.get2(cfg_fairylandcloudconfig_get,cloudid,'border')
local cloudData
for i,cloudid_ in ipairs(border)do
cloudData=lp[cloudid_]
if cloudData and cloudData:isUnlock()then
return true
end
end
if isWarning then
UIManager.error('查探迷雾必须是连通的')
end
return false
end
return false
end





function xianjieModel:getCloudQiYuData(cloudid,idx)
local cloudData=xianjieModel:getCloudData(cloudid)
return cloudData:getQiYuData(idx)
end





function xianjieModel:initCloudEntity()
local cloudEntityLookup={}
local lp=xianjieModel:getCloudLookup()or{}
local cfgs=cfg_fairylandcloudconfig()
for cloudid,cfg in pairs(cfgs)do
if type(cloudid)=='number'then
local cloudData=lp[cloudid]
if cloudData==nil or not cloudData:isUnlock()then
local data={cloudid=cloudid}
local cloudEntData=xianjieController:createXJClass(xjDataType.eCloudLock,data)
cloudEntityLookup[cloudid]=cloudEntData
end
end
end
self.mPlotData.cloudEntityLookup=cloudEntityLookup
end

function xianjieModel:getCloudEntityData(cloudid)
if cloudid==nil then return end
if self.mPlotData==nil then return end
local cloudEntityLookup=self.mPlotData.cloudEntityLookup
if cloudEntityLookup==nil then return end
return cloudEntityLookup[cloudid]
end

function xianjieModel:createAllCloudEntity(needRefreshAOI)
if self.mPlotData==nil then return end
local cloudEntityLookup=self.mPlotData.cloudEntityLookup
if cloudEntityLookup==nil then return end
for cloudid,cloudEntData in pairs(cloudEntityLookup)do
cloudEntData:createEntity()
end
end

function xianjieModel:removeAllCloudEntity()
if self.mPlotData==nil then return end
local cloudEntityLookup=self.mPlotData.cloudEntityLookup
if cloudEntityLookup==nil then return end
for cloudid,cloudEntData in pairs(cloudEntityLookup)do
cloudEntData:removeEntity()
end
end

function xianjieModel:removeCloudEntity(cloudid)
if self.mPlotData==nil then return end
local cloudEntityLookup=self.mPlotData.cloudEntityLookup
if cloudEntityLookup==nil then return end
local cloudEntData=cloudEntityLookup[cloudid]
if cloudEntData then
xianjieController:removeXJClass(cloudEntData)
cloudEntityLookup[cloudid]=nil
end
end

function xianjieModel:findNearlyCloudEntity()
if self.mPlotData==nil then return end
local cloudEntityLookup=self.mPlotData.cloudEntityLookup
if cloudEntityLookup==nil then return end
local cloudEntData_,wTime
for cloudid,cloudEntData in pairs(cloudEntityLookup)do
local canSearch=xianjieModel:checkCloudCanSearch(cloudid)
if canSearch then
local wayTime=cloudEntData:getBaseWayTime()
if cloudEntData_==nil or wTime>wayTime then
cloudEntData_=cloudEntData
wTime=wayTime
end
end
end
return cloudEntData_
end




function xianjieModel:getCloudPlotData(cloudid,plotIdx)
local cloudData=xianjieModel:getCloudData(cloudid)
local cloudPlotData=cloudData:getCloudPlotData(plotIdx)
return cloudPlotData
end

function xianjieModel:clearCloudPlotBehavior(cloudid,plotIdx,tree)
local cloudPlotData=xianjieModel:getCloudPlotData(cloudid,plotIdx)
if cloudPlotData then
cloudPlotData:clearBehavior(tree)
end
end

function xianjieModel:encodeCloudPlotParams(cloudData,plotIdx,d)
if d then
local plotIdx_str=tostring(plotIdx)
local lp=cloudData.cloudPlotParamslp
lp[plotIdx_str]=d

local dels={}
for plotIdx_str_,plotParams in pairs(lp)do
local plotIdx_=tonumber(plotIdx_str_)
if plotIdx_~=plotIdx then
local cloudPlotData=cloudData.cloudPlotlp[plotIdx_]
if cloudPlotData==nil then
dels[plotIdx_]=true
end
end
end
if next(dels)then
for plotIdx_,v in pairs(dels)do
local plotIdx_str_=tostring(plotIdx_str_)
cloudData.cloudPlotParamslp[plotIdx_]=nil
cloudData:initCloudPlotDZ(plotIdx_)
end
end
local march=jsonHelper.encode(lp)
cloudData.march=march
return march
else
return cloudData.march
end
end

function xianjieModel:createAllCloudPlotEntity(cloudData,needRefreshAOI)
local cloudPlotlp=cloudData.cloudPlotlp
for plotIdx,cloudPlotData in pairs(cloudPlotlp)do
local state=cloudData:checkCloudPlotState(plotIdx)
if state~=xjCloudPlotStateType.eFinish then
cloudPlotData:createEntity(needRefreshAOI)
end
end
end

function xianjieModel:removeAllCloudPlotEntity()
local lp=xianjieModel:getCloudLookup()
if lp then
for cloudid,cloudData in pairs(lp)do
local cloudPlotlp=cloudData.cloudPlotlp
if cloudPlotlp~=nil then
for plotIdx,cloudPlotData in pairs(cloudPlotlp)do
cloudPlotData:removeEntity()
end
end
end
end
end





function xianjieModel:isCloudLockbyPos(gridX,gridZ)
local islock=false
local cloudid=xianjieModel:caculationCloudID(gridX,gridZ)
if cloudid then
local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then
islock=cloudData:isUnlock()
end
end
if not islock then
UIManager.info("该区域未解锁，请先解锁该区域。")
end
return islock
end

function xianjieModel:isCloudLockbyid(cloudid)
local islock=false
local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then
islock=cloudData:isUnlock()
end
return islock
end

function xianjieModel:CloudhandleZhiyin(config,cloudid,idx,qyData,guideCall)

local explore=config.explore
if explore and explore[1]and explore[1]==5 or explore[1]==6 then
if config.weakGuideThinking~=nil then
if guideCall then
guideCall()
end
weakGuideThinkingController:doThinkingLine(config.weakGuideThinking)
elseif config.weakGuide~=nil then
if guideCall then
guideCall()
end
local pos=qyData:getWorldPos()
if pos then
weakGuideController:beginGuide(config.weakGuide,pos)
end
else
logErr(FMT.fmt('云雾解锁-缺少配置弱指引,cloudid={0},idx={1}',cloudid,idx))
end
else
logErr(FMT.fmt('云雾解锁-缺少配置explore,cloudid={0},idx={1}',cloudid,idx))
end
end

function xianjieModel:CloudjumpqiyuZY(cloudid,idx,qyData,guideCall)
local config=cfg_fairylandcloudunlockconfig_get(cloudid)[idx]
xianjieModel:CloudhandleZhiyin(config,cloudid,idx,qyData,guideCall)
end

