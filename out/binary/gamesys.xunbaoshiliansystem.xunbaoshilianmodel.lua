









xunBaoShiLianModel={}


xunBaoShiLianModel.data={}
XBSL_DIFFICULTY_MODE={
Normal=1,
Hard=2,
}

function xunBaoShiLianModel:onAppStart()

end


function xunBaoShiLianModel:onEnterState(isReconnect)

end


function xunBaoShiLianModel:onProtocolReq()

end


function xunBaoShiLianModel:onLeaveState(isReconnect)

self.data={}
end



function xunBaoShiLianModel:setShiLianData(openTime,normalChapterId,normalLevelIdx,hardChapterId,hardLevelIdx)
self.data.shiLianData={}
self.data.shiLianData.openTime=openTime
self.data.shiLianData[XBSL_DIFFICULTY_MODE.Normal]={}
self.data.shiLianData[XBSL_DIFFICULTY_MODE.Normal].chapterId=normalChapterId
self.data.shiLianData[XBSL_DIFFICULTY_MODE.Normal].levelIdx=normalLevelIdx
self.data.shiLianData[XBSL_DIFFICULTY_MODE.Hard]={}
self.data.shiLianData[XBSL_DIFFICULTY_MODE.Hard].chapterId=hardChapterId
self.data.shiLianData[XBSL_DIFFICULTY_MODE.Hard].levelIdx=hardLevelIdx
end

function xunBaoShiLianModel:setShiLianOpenTime(openTime)
if not self.data.shiLianData then
self.data.shiLianData={}
end
self.data.shiLianData.openTime=openTime
end


function xunBaoShiLianModel:getShiLianOpenTime()
if not self.data or not self.data.shiLianData then
return nil
end

return self.data.shiLianData.openTime
end


function xunBaoShiLianModel:setShiLianDataByModeId(modeId,chapterId,levelIdx)
if not self.data.shiLianData then
self.data.shiLianData={}
end

if not self.data.shiLianData[modeId]then
self.data.shiLianData[modeId]={}
end
self.data.shiLianData[modeId].chapterId=chapterId
self.data.shiLianData[modeId].levelIdx=levelIdx
end


function xunBaoShiLianModel:setTargetData(normalTargetLen,normalTargetDataList,hardTargetLen,hardTargetDataList)
self.data.targetData={}

if normalTargetLen>0 then
for i,v in ipairs(normalTargetDataList)do
local chapterId=v.param_1
local gotRewardIdx=v.param_2
self.data.targetData[XBSL_DIFFICULTY_MODE.Normal]={chapterId,gotRewardIdx}
end
end

if hardTargetLen>0 then
for i,v in ipairs(hardTargetDataList)do
local chapterId=v.param_1
local gotRewardIdx=v.param_2
self.data.targetData[XBSL_DIFFICULTY_MODE.Hard]={chapterId,gotRewardIdx}
end
end
end


function xunBaoShiLianModel:setTargetDataByModeId(modeId,chapterId,rewardIdx)
if not self.data.targetData then
self.data.targetData={}
end

if not self.data.targetData[modeId]then
self.data.targetData[modeId]={chapterId,rewardIdx}
else
local nowGotChapterId=self.data.targetData[modeId][1]
local nowGotRewardIdx=self.data.targetData[modeId][2]
if chapterId>nowGotChapterId then
self.data.targetData[modeId]={chapterId,rewardIdx}
elseif chapterId==nowGotChapterId then
if rewardIdx>nowGotRewardIdx then
self.data.targetData[modeId]={chapterId,rewardIdx}
end
end
end
end

function xunBaoShiLianModel:getTargetGotRewardIdx(modeId,chapterId)
if not self.data or not self.data.targetData then
return nil
end

if not self.data.targetData[modeId]then
return nil
end

return self.data.targetData[modeId][chapterId]
end

function xunBaoShiLianModel:checkTargetIsGot(modeId,chapterId,rewardIdx)
if not self.data or not self.data.targetData then
return false
end

if not self.data.targetData[modeId]then
return false
end
local nowGotChapterId=self.data.targetData[modeId][1]
local nowGotRewardIdx=self.data.targetData[modeId][2]
if chapterId<nowGotChapterId then
return true
elseif chapterId==nowGotChapterId then
if rewardIdx<=nowGotRewardIdx then
return true
end
end

return false
end


function xunBaoShiLianModel:setXuanShangData(xuanShangLen,xuanShangDataList)
self.data.xuanShangData={}
if xuanShangLen>0 then
for i,v in ipairs(xuanShangDataList)do
local bountyId=v.bounty_id
self.data.xuanShangData[bountyId]=v
end
end
end


function xunBaoShiLianModel:setXuanShangIdxByBountyId(bountyId,freeIdx,investIdx)
if not self.data.xuanShangData then
self.data.xuanShangData={}
end

if self.data.xuanShangData[bountyId]then
self.data.xuanShangData[bountyId].free_idx=freeIdx
self.data.xuanShangData[bountyId].invest_idx=investIdx
else
local data={
bounty_id=bountyId,
free_idx=freeIdx,
invest_idx=investIdx,
recharge_id=0,
}
self.data.xuanShangData[bountyId]=data
end
end


function xunBaoShiLianModel:getXuanShangData(bountyId)
if not self.data or not self.data.xuanShangData then
return nil
end
return self.data.xuanShangData[bountyId]
end


function xunBaoShiLianModel:getChapterIdByModeId(modeId)
if not self.data or not self.data.shiLianData then
return 0
end

if self.data.shiLianData[modeId]then
return self.data.shiLianData[modeId].chapterId
end

return 0
end


function xunBaoShiLianModel:getLevelIdxByModeId(modeId)
if not self.data or not self.data.shiLianData then
return 0
end

if self.data.shiLianData[modeId]then
return self.data.shiLianData[modeId].levelIdx
end

return 0
end


function xunBaoShiLianModel:getTargetCfgByModeId(modeId)
if not self.data.targetCfgList then
self.data.targetCfgList={}
end

if self.data.targetCfgList[modeId]then
return self.data.targetCfgList[modeId]
else
local modeStr=""
local allChapterCfg
if modeId==XBSL_DIFFICULTY_MODE.Normal then
modeStr="simple"
allChapterCfg=cfg_treasuretrainningsimplechapterconfig()
elseif modeId==XBSL_DIFFICULTY_MODE.Hard then
modeStr="difficulty"
allChapterCfg=cfg_treasuretrainningdifficultychapterconfig()
end

local targetList={}
local specialShowList={}
local rewardCfgName=FMT.fmt("{0}_target_reward",modeStr)
local specialCfgName=FMT.fmt("{0}SpecialReward",modeStr)
local guanqiaCfgName=FMT.fmt("{0}_ids",modeStr)
for _,chapterCfg in ipairs(allChapterCfg)do
local targetRewardCfg=chapterCfg[rewardCfgName]
local specialRewardCfg=chapterCfg[specialCfgName]
local chapterId=chapterCfg.id
local targetCount=0
local finalIdx=#targetRewardCfg
for i,v in ipairs(targetRewardCfg)do
local levelIdx=v[1]
local rewardList=v[2]
local targetItem={
chapterId=chapterId,
levelIdx=levelIdx,
rewardList=rewardList,
rewardIdx=i,
}
table.insert(targetList,targetItem)
targetCount=targetCount+1
end

local guanqiaCfg=chapterCfg[guanqiaCfgName]or{}
local guanqiaCount=#guanqiaCfg
specialShowList[chapterId]={
finalIdx=finalIdx,
targetCount=targetCount,
guanqiaCount=guanqiaCount,
modelParam=specialRewardCfg.modelParam,
rewardList=specialRewardCfg.list or{},
}
end
self.data.targetCfgList[modeId]={}
self.data.targetCfgList[modeId].targetList=targetList
self.data.targetCfgList[modeId].specialShowList=specialShowList
return self.data.targetCfgList[modeId]
end
end


function xunBaoShiLianModel:checkModelChapter(modeId,chapterId)
local cfg
if modeId==XBSL_DIFFICULTY_MODE.Normal then
cfg=cfgHelper.get(cfg_treasuretrainningsimplechapterconfig_get,chapterId)
elseif modeId==XBSL_DIFFICULTY_MODE.Hard then
cfg=cfgHelper.get(cfg_treasuretrainningdifficultychapterconfig_get,chapterId)
end
return cfg
end


function xunBaoShiLianModel:checkTargetChapterIsAllGot(modeId,chapterId)
local targetCfg=xunBaoShiLianModel:getTargetCfgByModeId(modeId)
local specialRewardCfg=targetCfg.specialShowList or{}
local finalIdx=specialRewardCfg[chapterId]and specialRewardCfg[chapterId].finalIdx or nil






local isGot=xunBaoShiLianModel:checkTargetIsGot(modeId,chapterId,finalIdx)
if isGot then
return true
end

return false
end


function xunBaoShiLianModel:checkXuanShangIsAllGotByBountyId(bountyId)
local cfg=cfgHelper.get(cfg_treasuretrainningbountyconfig_get,bountyId)
local data=xunBaoShiLianModel:getXuanShangData(bountyId)
if cfg and data then

local investIdx=data.invest_idx
local maxInvestCount=#cfg.bounty_invest_reward
if investIdx>=maxInvestCount then
return true
end
end
return false
end


function xunBaoShiLianModel:checkXuanShangIsUnlockByBountyId(bountyId)
local cfg=cfgHelper.get(cfg_treasuretrainningbountyconfig_get,bountyId)
if cfg then
local conditions=cfg.conditions
local lockType=conditions[1]
if lockType==1 then

local chapterId=conditions[2]
local isUnlock=xunBaoShiLianModel:checkChapterIsUnlock(chapterId,XBSL_DIFFICULTY_MODE.Normal)
if isUnlock then
return true
end
end
end
return false
end



function xunBaoShiLianModel:checkChapterIsUnlock(chapterId,modeId)
local cfg
if modeId==XBSL_DIFFICULTY_MODE.Normal then
cfg=cfgHelper.get(cfg_treasuretrainningsimplechapterconfig_get,chapterId)
elseif modeId==XBSL_DIFFICULTY_MODE.Hard then
cfg=cfgHelper.get(cfg_treasuretrainningdifficultychapterconfig_get,chapterId)
end
if not cfg then

return false
end

if modeId==XBSL_DIFFICULTY_MODE.Hard then

local unlockParam=cfg.unlock_difficulty
if unlockParam then
local unlockChapterId=unlockParam[1]
local unlockChapterLevelIdx=unlockParam[2]
local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(XBSL_DIFFICULTY_MODE.Normal)
local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(XBSL_DIFFICULTY_MODE.Normal)
if clearChapterId<unlockChapterId then
return false,false,{unlockChapterId,unlockChapterLevelIdx}
elseif clearChapterId==unlockChapterId and clearLevelIdx<unlockChapterLevelIdx then
return false,false,{unlockChapterId,unlockChapterLevelIdx}
end
end
end

if cfg.condition and next(cfg.condition)then
for _,cndParam in ipairs(cfg.condition)do
local cndType=cndParam[1]
if cndType==1 then

local firstOpenTime=xunBaoShiLianModel:getShiLianOpenTime()
if firstOpenTime and firstOpenTime>0 then




local unlockOpenDay=cndParam[2]
local chapterOpenTime=firstOpenTime+unlockOpenDay*86400
local nowTime=timeHelper.getServerShortTime()
if nowTime<chapterOpenTime then
return false,true,{chapterOpenTime}
end
end
end
end
end

return true
end



function xunBaoShiLianModel:checkGuanQiaIsUnlock(guanqiaId)
local cfg=cfgHelper.get1(cfg_treasuretrainninggqconfig_get,guanqiaId)
if cfg and cfg.conditions then
local cndParam=cfg.conditions
if cndParam[1]==1 then
local zmLevel=zongmenModel:getLevel()
if zmLevel<cndParam[2]then
local tips=FMT.fmt('宗门达到{0}级可挑战',cndParam[2])
return false,tips
end
end
end
return true
end


function xunBaoShiLianModel:setXuanShangBuyStateByBountyId(bountyId)
if not self.data.xuanShangData then
self.data.xuanShangData={}
end

local cfg=cfgHelper.get(cfg_treasuretrainningbountyconfig_get,bountyId)
local rechargeId=cfg.invest_recharge_id
if not self.data.xuanShangData[bountyId]then
self.data.xuanShangData[bountyId]={
bounty_id=bountyId,
free_idx=0,
invest_idx=0,
recharge_id=rechargeId,
}
else
self.data.xuanShangData[bountyId].recharge_id=rechargeId
end
end


function xunBaoShiLianModel:checkXuanShangIsBoughtByBountyId(bountyId)
if not self.data or not self.data.xuanShangData then
return false
end

if self.data.xuanShangData[bountyId]then
local rechargeId=self.data.xuanShangData[bountyId].recharge_id
if rechargeId and rechargeId~=0 then
return true
end
end
return false
end


function xunBaoShiLianModel:checkXuanShangHasBounty()
local allCfg=cfg_treasuretrainningbountyconfig()
for i,v in ipairs(allCfg)do
local bountyId=v.id

local isUnlock=xunBaoShiLianModel:checkXuanShangIsUnlockByBountyId(bountyId)
if isUnlock then

local isAllGot=xunBaoShiLianModel:checkXuanShangIsAllGotByBountyId(bountyId)
if not isAllGot then
return true
end
end
end

return false
end

function xunBaoShiLianModel:setCurrentLevelAllNum()
if not self.data then
self.data={}
end
local allNum=0
local normalCurLevelNum=0
local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(XBSL_DIFFICULTY_MODE.Normal)
local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(XBSL_DIFFICULTY_MODE.Normal)
if clearChapterId>0 then
for i=1,clearChapterId do
if i==clearChapterId then

normalCurLevelNum=normalCurLevelNum+clearLevelIdx
else
local cfg=cfgHelper.get(cfg_treasuretrainningsimplechapterconfig_get,i)
local len=cfg and#cfg.simple_ids or 0

normalCurLevelNum=normalCurLevelNum+len
end
end
else

normalCurLevelNum=normalCurLevelNum+clearLevelIdx
end

local hardCurLevelNum=0
local hardChapterId=xunBaoShiLianModel:getChapterIdByModeId(XBSL_DIFFICULTY_MODE.Hard)
local hardLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(XBSL_DIFFICULTY_MODE.Hard)
if hardChapterId>0 then
for i=1,hardChapterId do
if i==hardChapterId then

hardCurLevelNum=hardCurLevelNum+hardLevelIdx
else
local cfg=cfgHelper.get(cfg_treasuretrainningdifficultychapterconfig_get,i)
local len=cfg and#cfg.difficulty_ids or 0

hardCurLevelNum=hardCurLevelNum+len
end

end
else

hardCurLevelNum=hardCurLevelNum+hardLevelIdx
end

allNum=normalCurLevelNum+hardCurLevelNum
self.data.normalCurLevelNum=normalCurLevelNum
self.data.hardCurLevelNum=hardCurLevelNum
self.data.currentLevelAllNum=allNum
end



function xunBaoShiLianModel:getCurrentLevelAllNum()
if not self.data or not self.data.currentLevelAllNum then
return 0
end
return self.data.currentLevelAllNum
end


function xunBaoShiLianModel:getCurrentLevelNumByModeId(modeId)
if modeId==0 then

return xunBaoShiLianModel:getCurrentLevelAllNum()
elseif modeId==XBSL_DIFFICULTY_MODE.Normal then

if not self.data or not self.data.normalCurLevelNum then
return 0
end
return self.data.normalCurLevelNum
elseif modeId==XBSL_DIFFICULTY_MODE.Hard then

if not self.data or not self.data.hardCurLevelNum then
return 0
end
return self.data.hardCurLevelNum
end
end


function xunBaoShiLianModel:checkXuanShangReddotByBountyId(bountyId)
local cfg=cfgHelper.get(cfg_treasuretrainningbountyconfig_get,bountyId)
if not cfg then
return false
end

local isBought=xunBaoShiLianModel:checkXuanShangIsBoughtByBountyId(bountyId)

local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(XBSL_DIFFICULTY_MODE.Normal)
local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(XBSL_DIFFICULTY_MODE.Normal)


local data=xunBaoShiLianModel:getXuanShangData(bountyId)
local startIdx=data and data.free_idx or 0
if isBought then
startIdx=data and data.invest_idx or 0
end

local levelRewardCfg_free=cfg.bounty_free_reward
local levelRewardCfg_invest=cfg.bounty_invest_reward

for i=startIdx+1,#levelRewardCfg_free do
local freeCfg=levelRewardCfg_free[i]
local investCfg=levelRewardCfg_invest[i]

local chapterId=freeCfg[1]
local levelIdx=freeCfg[2]

local isFinish=false
if clearChapterId>chapterId or(clearChapterId==chapterId and clearLevelIdx>=levelIdx)then
isFinish=true
end

local isGot_free=data and data.free_idx and data.free_idx>=i or false
local isGot_invest=data and data.invest_idx and data.invest_idx>=i or false
if isFinish and(not isGot_free or not isGot_invest)then

return true
end
end

return false
end


function xunBaoShiLianModel:checkXuanShangEnterReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eTreasureTrainning)then

return false
end
local allCfg=cfg_treasuretrainningbountyconfig()
for i,v in ipairs(allCfg)do
local bountyId=v.id

local isUnlock=xunBaoShiLianModel:checkXuanShangIsUnlockByBountyId(bountyId)
if isUnlock then

local isAllGot=xunBaoShiLianModel:checkXuanShangIsAllGotByBountyId(bountyId)
if not isAllGot then

local reddot=xunBaoShiLianModel:checkXuanShangReddotByBountyId(bountyId)
if reddot then
return true
end
end
end
end
return false
end


function xunBaoShiLianModel:checkTargetReddotByModeId(modeId)
local targetCfg=xunBaoShiLianModel:getTargetCfgByModeId(modeId)
local targetList=targetCfg.targetList or{}
local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(modeId)
local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(modeId)

for i,cfg in ipairs(targetList)do
local chapterId=cfg.chapterId
local levelIdx=cfg.levelIdx
local rewardIdx=cfg.rewardIdx

local isFinish=false
if clearChapterId>chapterId or(clearChapterId==chapterId and clearLevelIdx>=levelIdx)then
isFinish=true
end


local isGot=xunBaoShiLianModel:checkTargetIsGot(modeId,chapterId,rewardIdx)
if isFinish and not isGot then

return true
end
end

return false
end


function xunBaoShiLianModel:checkTargetEnterReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eTreasureTrainning)then

return false
end

local modeMenuList={XBSL_DIFFICULTY_MODE.Normal,XBSL_DIFFICULTY_MODE.Hard}
for _,modeId in ipairs(modeMenuList)do
local reddot=xunBaoShiLianModel:checkTargetReddotByModeId(modeId)
if reddot then
return true
end
end

return false
end


function xunBaoShiLianModel:checkCanTiaoZhanReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eTreasureTrainning)then

return false
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXBSL_TiaoZhanReddot)
if flag then
return false
end

local modeMenuList={XBSL_DIFFICULTY_MODE.Normal,XBSL_DIFFICULTY_MODE.Hard}
for _,modeId in ipairs(modeMenuList)do
if xunBaoShiLianModel:isCanTiaoZhanByModeId(modeId)then
return true
end
end
return false
end

function xunBaoShiLianModel:isCanTiaoZhanByModeId(modeId)
local chapterId=xunBaoShiLianModel:getChapterIdByModeId(modeId)
if not chapterId or chapterId==0 then
chapterId=1
end
local isChapterUnlock,isTimeType,lockParam=xunBaoShiLianModel:checkChapterIsUnlock(chapterId,modeId)
if isChapterUnlock then
return true
end
return false
end


function xunBaoShiLianModel:checkXBSLEnterReddot()
return xunBaoShiLianModel:checkXuanShangEnterReddot()or xunBaoShiLianModel:checkTargetEnterReddot()or xunBaoShiLianModel:checkCanTiaoZhanReddot()
end