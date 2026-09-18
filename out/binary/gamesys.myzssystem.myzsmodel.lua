






local _MODULENAME="myzsModel"


def_table(_MODULENAME)
myzsModel.name=_MODULENAME
myzsModel.data={}

function myzsModel:onAppStart()

end


function myzsModel:onEnterState(isReconnect)
self.discipleLookUp={}
end


function myzsModel:onProtocolReq()

end

function myzsModel:onProtocolReqKF()

end


function myzsModel:onLeaveState(isReconnect)

self={}
end



function myzsModel:initGroupData(pass_idx)
self:parseGroupLevel(pass_idx)
self:initLevelLookUp()
end

function myzsModel:parseGroupLevel(pass_idx)
local group=self.group
local list=cfgHelper.get1(cfg_mingyuanzhushagroupconfig_get,group)
local total=#list

self.passIdx=Mathf.Min(pass_idx,total)

self.gameIdx=Mathf.Min(pass_idx+1,total)
local levelInfo=list[self.gameIdx]

self.isFinish=self.passIdx>=total

self:updateLevelType()

self.targetId=levelInfo.obj_id
end

function myzsModel:updateLevelType()
local state=self:getSettlementState()
if state==MYZSSettlementStateEnum.eFinish or state==MYZSSettlementStateEnum.eStop and self:isFinishCurOpenGroup()then
self.levelType=MYZSStageType.eFinish
elseif state==MYZSSettlementStateEnum.eWait and self:isFinishCurOpenGroup()then
self.levelType=MYZSStageType.eWait
else
local showGameIdx=self:getShowGameIdx()
local levelInfo=myzsModel:getlevelConf(showGameIdx)
self.levelType=MYZSStageType:transStageType(levelInfo.obj_id)
end
end


function myzsModel:setGroup(group)
self.group=group
end

function myzsModel:getGroup()
local group=self.group
if group==nil then



return
end
return group
end


function myzsModel:getPassIdx()
if self==nil or self.passIdx==nil then
logErr("关卡索引缺失")
end
return self.passIdx
end


function myzsModel:getGameIdx()
if self==nil or self.gameIdx==nil then
logErr("关卡索引缺失")
end
return self.gameIdx
end

function myzsModel:getShowGameIdx()
local idx=1
local state=self:getSettlementState()
if state==MYZSSettlementStateEnum.eDoing then
idx=self.gameIdx
else
idx=self.passIdx
end

return Mathf.Max(idx,1)
end


function myzsModel:getCurrentLayer()
local level=myzsModel:getShowGameIdx()
local levelInfo=self:getlevelConf(level)
return levelInfo.layer
end


function myzsModel:getCurrentLevel()
local level=myzsModel:getShowGameIdx()
local levelInfo=self:getlevelConf(level)
return levelInfo.level
end


function myzsModel:setDiffLevel(level)
self.diffLevel=level
end

function myzsModel:getDiffLevel()
return self.diffLevel
end


function myzsModel:setDiffPassCount(count)
self.diffPassCount=count
end

function myzsModel:getDiffPassCount()
return self.diffPassCount or 0
end

function myzsModel:getLayerMonsterPassCount(layer)
if self==nil or self.levelExtraInfo==nil then return 0 end

local passIdx=self:getPassIdx()

local passLen=0
for index,levelIdx in ipairs(self.levelExtraInfo[layer].monsterIdxList)do
if levelIdx>passIdx then
break
end
passLen=index
end

return passLen
end

function myzsModel:getCurrentTargetObjectID()
return self.targetId
end

function myzsModel:getCurrentMonsterGroupID()
local targetId=myzsModel:getCurrentTargetObjectID()
local monster_group_id=cfgHelper.get2(cfg_mingyuanzhushamonsterconfig_get,targetId,'monster_group_id')
return monster_group_id
end

function myzsModel:getCurrentFaZeList()
local level=myzsModel:getGameIdx()
local levelInfo=myzsModel:getlevelConf(level)

local targetId=levelInfo.obj_id
local faZeData=cfgHelper.get2(cfg_mingyuanzhushamonsterconfig_get,targetId,'faze')
return faZeData
end

function myzsModel:getKillMonsterFightVal()
local showGameIdx=self:getShowGameIdx()
local levelConf=self:getlevelConf(showGameIdx)
local diffLevel=myzsModel:getDiffLevel()
if levelConf.quick_fight then
return levelConf.quick_fight[diffLevel]
end
end

function myzsModel:getCurrentLevelType()
return self.levelType
end

function myzsModel:checkCanFightMonster()
local discipleList=self:getDiscipleTeamList()
if discipleList==nil or next(discipleList)==nil then return false,'未安排弟子'end

return true
end

function myzsModel:getLingLiFightDefEffectDesc(discount,tfmt,color)
tfmt=tfmt or"{0},{1}"
if self.lingliFightDefEffectList==nil then
self.lingliFightDefEffectList={}

local energy_effect=myzsModel:getBaseConfig('energy_effect')

for index,effect in ipairs(energy_effect)do
local defVal=effect[2]
























self.lingliFightDefEffectList[defVal]=effect.desc
end
end

local odesc=self.lingliFightDefEffectList[discount]
if odesc then
local desc=string.gsub(odesc,'【COLOR】',color)
return desc
end
end

function myzsModel:checkNoRecvFirstLevelReward(level)
local list=self:getLevelScoreList()

return list[level]==nil
end


function myzsModel:initLevelLookUp()
local group=myzsModel:getGroup()
local list=cfgHelper.get1(cfg_mingyuanzhushagroupconfig_get,group)

self.levelLookUp={}
self.levelExtraInfo={}
self.monsterInfoList={}

for index,levelInfo in ipairs(list)do
local layer=levelInfo.layer

if self.levelLookUp[layer]==nil then
self.levelLookUp[layer]={}
end
table.insert(self.levelLookUp[layer],levelInfo)

if self.levelExtraInfo[layer]==nil then
self.levelExtraInfo[layer]={
marchantidxList={},
treasureIdxList={},
monsterIdxList={},
smallMonsterIdxlist={},
bossMonsterIdxList={},
}
end

local objectId=levelInfo.obj_id
local objectType=MYZSStageType:transStageType(objectId)
local tlist
if objectType==MYZSStageType.eMerchant then
tlist=self.levelExtraInfo[layer].marchantidxList
elseif objectType==MYZSStageType.eTreasure then
tlist=self.levelExtraInfo[layer].treasureIdxList
elseif objectType==MYZSStageType.eMonster then
tlist=self.levelExtraInfo[layer].monsterIdxList

if levelInfo.isBoss then
table.insert(self.levelExtraInfo[layer].bossMonsterIdxList,index)
else
table.insert(self.levelExtraInfo[layer].smallMonsterIdxlist,index)
end

table.insert(self.monsterInfoList,levelInfo)
end

tlist[#tlist+1]=index
end
end

function myzsModel:getFirstPassReward()
local showGameIdx=self:getShowGameIdx()
local conf=self:getlevelConf(showGameIdx)

if conf.rewards~=nil then return conf.rewards end

local lookup=self.levelExtraInfo[conf.layer]
local monsterList=lookup.monsterIdxList

local reward=defaultT
for index,level in ipairs(monsterList)do
local data=self:getlevelConf(level)
if data.idx<=showGameIdx then
reward=data.rewards
else
break
end
end



return reward
end

function myzsModel:checkLayerHasSmallMonster(layer)
return next(self.levelExtraInfo[layer].smallMonsterIdxlist)~=nil
end

function myzsModel:checkLayerHasBossMonster(layer)
return next(self.levelExtraInfo[layer].bossMonsterIdxList)~=nil
end

function myzsModel:getLayerTotalSmallMonsterCount(layer)
return#self.levelExtraInfo[layer].smallMonsterIdxlist
end

function myzsModel:getLayerTotalMonsterCount(layer)
return#self.levelExtraInfo[layer].monsterIdxList
end


function myzsModel:initLevelScoreData(level_score_len,level_score)
self.level_score_len=level_score_len
self.level_score=level_score or{}
self.level_score_valid={}

local group=self:getGroup()

self.totalScore=0
if self.level_score_len>0 then
for index,score in ipairs(self.level_score)do
self.totalScore=self.totalScore+score

if score>0 then
local cfg=cfgHelper.get(cfg_mingyuanzhushagroupconfig_get,group,index)
self.level_score_valid[#self.level_score_valid+1]={layer=cfg.layer,level=cfg.level,score=score}
end
end
end
end

function myzsModel:getChallengeScore()
return self.totalScore
end

function myzsModel:insertLevelScore(level,score)
local oldVal=self.level_score[level]
self.level_score[level]=score
if score>0 then
if oldVal==nil then
self.totalScore=self.totalScore+score
local cfg=self:getlevelConf(level)
self.level_score_valid[#self.level_score_valid+1]={layer=cfg.layer,level=cfg.level,score=score}
else
if score>oldVal then
self.totalScore=self.totalScore+score-oldVal

for index,info in ipairs(self.level_score_valid)do
if info.level==level then
info.score=score
break
end
end
end
end
end
self.level_score_len=#self.level_score
end

function myzsModel:getLevelScoreList()
return self.level_score,self.level_score_len
end

function myzsModel:getChallengeScoreLogList()
return self.level_score_valid
end

function myzsModel:getHistoryPassIdx()
return self.level_score_len
end

function myzsModel:willGetDefeatReward()
local hPassIdx=self:getHistoryPassIdx()
local maxOpenLayer=self:getCurOpenMaxLayer()

local isPass,showIdx,rewards,difficulty_rewards
local monsterList=self.monsterInfoList
for index,levelInfo in ipairs(monsterList)do
if maxOpenLayer>=levelInfo.layer then
showIdx=levelInfo.idx
rewards=table.weakCopy(levelInfo.rewards)
isPass=hPassIdx>=levelInfo.idx
difficulty_rewards=levelInfo.difficulty_rewards
if showIdx>hPassIdx then
break
end
end
end


if difficulty_rewards then
local diffLevel=myzsModel:getDiffLevel()
local diffReward=difficulty_rewards[diffLevel]
if diffReward then
for index,reward in ipairs(diffReward)do
rewards[#rewards+1]={reward[1],reward[2],isDiff=true}
end
end
end

return isPass,showIdx,rewards
end

function myzsModel:checkPassOpenAllLayer()
local hPassIdx=self:getHistoryPassIdx()
local openMaxLayer=myzsModel:getCurOpenMaxLayer()
local layerCfg=self.levelLookUp[openMaxLayer]
local levelConf=layerCfg[#layerCfg]

return hPassIdx>=levelConf.idx
end








function myzsModel:initDiscipleListData(disciple_list_len,disciple_list)

self.disciple_list_len=disciple_list_len
self.disciple_list=disciple_list or{}

if self.disciple_list_len>0 then
for index,data in ipairs(self.disciple_list)do

data.llPercent=data.param_1
data.hpPercent=data.param_2
data.discipleGuid=data.param_3
data.discipleGuidStr=mathHelper.int64_to_string(data.param_3)

self.discipleLookUp[data.discipleGuidStr]=data
end
end

if initProControl.isDone()then
self:exportDiscipleList()
end
end

function myzsModel:exportDiscipleList()
self.disciple_list={}
self.disciple_list_len=0

local llPercentMax=myzsModel:getBaseConfig('energy_init')

local myzsDiscipleDataLookup=myzsModel:getDiscipleLookup()
local allDiscipleList=UIDiscipleModel:getDiscipleList()
for _,data in pairs(allDiscipleList)do
local net=data.netData.net
local discipleGuidStr=net.discipleguidStr
local myzsDiscipleData=myzsDiscipleDataLookup[discipleGuidStr]
if myzsDiscipleData==nil then
myzsDiscipleData={}
myzsDiscipleData.discipleGuid=net.discipleguid
myzsDiscipleData.llPercent=llPercentMax
myzsDiscipleData.hpPercent=100
myzsDiscipleData.discipleGuidStr=discipleGuidStr
end
myzsDiscipleData.fightVal=UIDiscipleModel:getDiscipleFightValue(myzsDiscipleData.discipleGuid)
myzsDiscipleData.fightVal=myzsModel:getDiscipleFightValForLingLi2(myzsDiscipleData.fightVal,myzsDiscipleData.llPercent)

self.discipleLookUp[discipleGuidStr]=myzsDiscipleData
self.disciple_list[#self.disciple_list+1]=myzsDiscipleData
self.disciple_list_len=self.disciple_list_len+1
end

myzsModel:updateTeamDiscipleData()

for _,myzsDiscipleData in ipairs(self.disciple_list)do
myzsDiscipleData.sortWidget=myzsModel:getDiscipleSortWidget(myzsDiscipleData)
end
end

function myzsModel:getDiscipleSortWidget(myzsDiscipleData)
if myzsDiscipleData.hpPercent<=0 then
return-1000+myzsDiscipleData.fightVal/100000000
elseif myzsDiscipleData.llPercent<=0 then
return-100+myzsDiscipleData.fightVal/100000000
elseif self.teamDiscipleLookup[myzsDiscipleData.discipleGuidStr]then
return 100000+myzsDiscipleData.fightVal/100000000
else
return 10000+myzsDiscipleData.fightVal/100000000
end
end

function myzsModel:updateDiscipleData(len,discipleDataList)
if len<=0 then return end
for index=1,len do
local data=discipleDataList[index]

local discipleGuid=data.param_3
local discipleData=myzsModel:getDiscipleDataByGuid(discipleGuid)

if discipleData==nil then
logErr("未快查到对应弟子数据")
return
end

discipleData.llPercent=data.param_1
discipleData.hpPercent=data.param_2
discipleData.discipleGuid=data.param_3
discipleData.fightVal=UIDiscipleModel:getDiscipleFightValue(discipleData.discipleGuid)
discipleData.fightVal=myzsModel:getDiscipleFightValForLingLi2(discipleData.fightVal,discipleData.llPercent)
discipleData.sortWidget=myzsModel:getDiscipleSortWidget(discipleData)

if discipleData.hpPercent<=0 or discipleData.llPercent<=0 then
myzsModel:checkRemoveTeamDisciple(discipleData.discipleGuid)
end
end
myzsModel:setDiscipleTeamFightValDirty()
end

function myzsModel:getDiscipleDataByGuid(guid)
local guidStr=mathHelper.int64_to_string(guid)
return self.discipleLookUp[guidStr]
end

function myzsModel:getDiscipleDataByGuidStr(guidStr)
return self.discipleLookUp[guidStr]
end

function myzsModel:getDiscipleList()
return self.disciple_list
end

function myzsModel:getFightDiscountForLingLi(llval)
local energy_effect=self:getBaseConfig('energy_effect')

local discountVal=0

for index,effect in ipairs(energy_effect)do
if effect[1]>=llval then
discountVal=effect[2]
else
break
end
end
return discountVal
end

function myzsModel:getDiscipleFightValForLingLi(guid)
local guidStr=tostring(guid)
local discipleData=self.discipleLookUp[guidStr]
if discipleData==nil then
logErr("传递未被处理的弟子id")
return
end
local discount=myzsModel:getFightDiscountForLingLi(discipleData.llPercent)
local fight=UIDiscipleModel:getDiscipleFightValue(guid)
return mathHelper.safe_floor(fight*((100-discount)/100))
end

function myzsModel:getDiscipleFightValForLingLi2(fightVal,llPercent)
local discount=myzsModel:getFightDiscountForLingLi(llPercent)
return mathHelper.safe_floor(fightVal*((100-discount)/100))
end

function myzsModel:getDiscipleFightValForLingLi3(guid,fightVal)
local discipleData=myzsModel:getDiscipleDataByGuid(guid)
local discount=myzsModel:getFightDiscountForLingLi(discipleData.llPercent)
return mathHelper.safe_floor(fightVal*((100-discount)/100))
end


function myzsModel:setDiscipleTeamFightValDirty()
self.discipleFightValDirty=true
end

function myzsModel:getDiscipleTeamFightVal()
if self.discipleFightVal==nil or self.discipleFightValDirty then
local fightVal=0

local teamDisicpleList=self:getDiscipleTeamList()
for index,data in ipairs(teamDisicpleList)do
local dval=myzsModel:getDiscipleFightValForLingLi(data.discipleGuid)
fightVal=fightVal+dval
end

self.discipleFightVal=fightVal
self.discipleFightValDirty=false
end

return self.discipleFightVal
end

function myzsModel:getDiscipleLookup()
return self.discipleLookUp
end

function myzsModel:clearDiscipleData()
self.discipleLookUp={}
self.disciple_list={}
self.disciple_list_len=0
end

function myzsModel:getDiscipleTeamList()
if self.discipleTeamList==nil then
myzsModel:readDiscipleTeamList()
end

return self.discipleTeamList
end

function myzsModel:getTeamDiscipleDataByIndex(index)
if self.discipleTeamList==nil then
myzsModel:readDiscipleTeamList()
end

return self.discipleTeamList[index]
end

function myzsModel:getDiscipleTeamGuidList()
if self.discipleTeamGuidList==nil then
myzsModel:readDiscipleTeamList()
end

return self.discipleTeamGuidList
end

function myzsModel:getTeamDiscipleLookup()
if self.teamDiscipleLookup==nil then
myzsModel:readDiscipleTeamList()
end
return self.teamDiscipleLookup
end

function myzsModel:getServerDiscipeDataByGuid(guid)
local guidStr=tostring(guid)
return self.discipleLookUp[guidStr]
end

function myzsModel:getDiscipleDataAttr(guid,key)
local data=self:getDiscipleDataByGuid(guid)
if data==nil then return end
return data[key]
end

function myzsModel:updateDiscipleFightVal(guid)
if guid==nil then return end
local discipleData=self:getDiscipleDataByGuid(guid)
if discipleData==nil then return end
discipleData.fightVal=UIDiscipleModel:getDiscipleFightValue(discipleData.discipleGuid)
discipleData.fightVal=myzsModel:getDiscipleFightValForLingLi2(discipleData.fightVal,discipleData.llPercent)
myzsModel:setDiscipleTeamFightValDirty()
end

local _discipleTeamListLey="MYZS_DiscipleTeamList"
function myzsModel:readDiscipleTeamList()
local discipleTeamList=userActorSetting.get(_discipleTeamListLey,{})
self.discipleTeamList={}
self.teamDiscipleLookup={}
self.discipleTeamGuidList={}

if next(discipleTeamList)==nil then return end

for index,discipleGuidStr in ipairs(discipleTeamList)do
local guid=int64.new(discipleGuidStr)
if UIDiscipleModel:getDiscipleData(guid)~=nil then
local data=self:getDiscipleDataByGuid(guid)
if data~=nil and data.hpPercent>0 and data.llPercent>0 then
table.insert(self.discipleTeamList,data)
self.teamDiscipleLookup[data.discipleGuidStr]=1
table.insert(self.discipleTeamGuidList,guid)
end
else



end
end
end

function myzsModel:recordDiscipleTeamList(tempList)
if next(tempList)==nil then return end

userActorSetting.set(_discipleTeamListLey,tempList)
userActorSetting.flush()
end

function myzsModel:setDiscipleTeamList(teamList)
local oldDiscipleTeamList=self.discipleTeamList
self.discipleTeamList=teamList
self.teamDiscipleLookup={}
self.discipleTeamGuidList={}

local tempList={}

for index,data in ipairs(teamList)do
tempList[index]=data.discipleGuidStr
self.teamDiscipleLookup[data.discipleGuidStr]=index
table.insert(self.discipleTeamGuidList,data.discipleGuid)
end

myzsModel:setDiscipleTeamFightValDirty()
myzsModel:recordDiscipleTeamList(tempList)
myzsModel:updateDiscipleSortWidget(oldDiscipleTeamList)
myzsModel:updateDiscipleSortWidget(teamList)
UIManager:invokeUIMethod("UIMingYuanZhuSha_MainWin","refreshFightOperationPart")
end

function myzsModel:updateDiscipleSortWidget(teamList)
for index,data in ipairs(teamList)do
data.sortWidget=self:getDiscipleSortWidget(data)
end
end

function myzsModel:checkRemoveTeamDisciple(discipleGuid)
if self==nil or self.teamDiscipleLookup==nil then return end

local guidStr=tostring(discipleGuid)

local index=self.teamDiscipleLookup[guidStr]

if index==nil then return end

table.remove(self.discipleTeamList,index)
table.remove(self.discipleTeamGuidList,index)
self.teamDiscipleLookup[guidStr]=nil

for index,data in ipairs(self.discipleTeamList)do
self.teamDiscipleLookup[data.discipleGuidStr]=index
end
end

function myzsModel:updateTeamDiscipleData()
if self.discipleTeamList==nil then
myzsModel:readDiscipleTeamList()
end

local teamDiscipleList=self.discipleTeamList
self.discipleTeamList={}
self.teamDiscipleLookup={}

for index,data in ipairs(teamDiscipleList)do
local discipleGuidStr=data.discipleGuidStr

local newData=self.discipleLookUp[discipleGuidStr]
self.teamDiscipleLookup[discipleGuidStr]=index
table.insert(self.discipleTeamList,newData)
end
end








function myzsModel:initBWList(total_bw_list_len,total_bw_list)
self.total_bw_list_len=total_bw_list_len
self.total_bw_list=total_bw_list or{}
end

function myzsModel:getTotalBwList()
return self.total_bw_list,self.total_bw_list_len
end

function myzsModel:selectBw(level,bwId)
self.total_bw_list_len=self.total_bw_list_len+1
table.insert(self.total_bw_list,1,{param_1=bwId,param_2=level})
end

function myzsModel:getCurrentGroupBWList()
local totalBwList=self:getTotalBwList()
local groupList={}
local layer=myzsModel:getCurrentLayer()

for index,data in ipairs(totalBwList)do
if data.param_2==layer then
groupList[#groupList+1]=data
end
end

return groupList
end


function myzsModel:onSelectBW(idx)
local layer=self:getCurrentLayer()
local info=self.cur_Level_Item_List[idx]
local bwIdx=info.param_2
self:selectBw(layer,bwIdx)
end


function myzsModel:onBuyItem(itemIdx)

local itemList=self.cur_Level_Item_List

local itemData=itemList[itemIdx]
if not itemData then
logErr("购买商品索引错误:",itemIdx)
return
end
itemData.param_4=1

local itemType=itemData.param_2

if itemType==MYZSMerchantShopType.eWeapon then
local layer=self:getCurrentLayer()
local bwIdx=itemData.param_3
self:selectBw(layer,bwIdx)
UIManager.info("购买成功")
elseif itemType==MYZSMerchantShopType.eRecovery then
UIManager.info("恢复成功")
elseif itemType==MYZSMerchantShopType.eRevival then
UIManager.info("复活成功")
end
end








function myzsModel:setCurLevelItemList(cur_Level_Item_List_Len,cur_Level_Item_List)
self.cur_Level_Item_List_Len=cur_Level_Item_List_Len
self.cur_Level_Item_List=cur_Level_Item_List or{}
end

function myzsModel:getCurLevelItemList()
return self.cur_Level_Item_List,self.cur_Level_Item_List_Len
end




function myzsModel:getBaseConfig(key)
return cfgHelper.get2(cfg_mingyuanzhushabaseconfig_get,1,key)
end

function myzsModel:getGroupConfig(idx)
local group=myzsModel:getGroup()
local cfg=cfgHelper.get1(cfg_mingyuanzhushagroupconfig_get,group)
if idx==nil then return cfg end
return cfg[idx]
end

function myzsModel:getGroupUnlockLayer()
local unlock_layer=cfgHelper.getdef(cfg_mingyuanzhushagroupconfig,'unlock_layer')
local group=self:getGroup()
return unlock_layer[group]or unlock_layer[0]
end

function myzsModel:getMaxGroupCount()
local level_conf=myzsModel:getGroupConfig()
local len=#level_conf
local maxGroupIndex=level_conf[len].layer
return maxGroupIndex
end

function myzsModel:getlevelConf(level)
local levelInfo=myzsModel:getGroupConfig(level)
if levelInfo==nil then
local group=myzsModel:getGroup()
logErr("冥渊诛煞 关卡 配置缺失:",group,'level_conf',level)
return
end
return levelInfo
end

function myzsModel:getLayerFirstLevelConf(layer)
return self.levelLookUp[layer][1]
end



function myzsModel:getActMoneyCount()
local money_type=myzsModel:getBaseConfig('money_type')
return itemsModel.getCount(money_type)
end




function myzsModel:getSettlementState()
if not myzsController.recved_13_31 then return MYZSSettlementStateEnum.eStop end

local curTime=timeHelper.getServerShortTime()
local settlementTime=myzsModel:getSettlementTime()
local seasonOpenTime=myzsModel:getSeasonOpenStamp()
if seasonOpenTime>curTime or curTime>settlementTime then
return MYZSSettlementStateEnum.eStop
end

if self.isFinish then
return MYZSSettlementStateEnum.eFinish
end

local isFinishCurOpenGroup=myzsModel:isFinishCurOpenGroup()

if isFinishCurOpenGroup then
return MYZSSettlementStateEnum.eWait
end

return MYZSSettlementStateEnum.eDoing
end

function myzsModel:isFinishCurOpenGroup()
if self.isFinish then return true end
if self.passIdx<=0 then return false end

local levelInfo=self:getlevelConf(self.passIdx)
local nextLevlInfo=self:getlevelConf(self.gameIdx)
if nextLevlInfo==nil then return true end

local curOpenMaxLayer=myzsModel:getCurOpenMaxLayer()
local layer=levelInfo.layer
local nextLayer=nextLevlInfo.layer

if curOpenMaxLayer>layer then return false end
if nextLayer==curOpenMaxLayer then return false end
return true
end




function myzsModel:getTxzID()
local group=myzsModel:getGroup()
if group==nil then
return
end

local passport=cfgHelper.getdef(cfg_mingyuanzhushagroupconfig,'passport')

local txzid=passport[group]or passport[0]

return txzid
end

function myzsModel:getTxzGuid()


local txzId=myzsModel:getTxzID()
if txzId==nil then
return
end
return UITYTongXingZhengModel:findGuidByTXZId(txzId,true)
end

function myzsModel:checkOpenTxz()
local guid=myzsModel:getTxzGuid()

return guid~=nil
end

function myzsModel:getTxzLeftTime()
local curStamp=timeHelper.getServerShortTime()
local guid=myzsModel:getTxzGuid()
if guid==nil then
local endStamp=myzsModel:getNextSeasonOpenStamp()
if endStamp==nil then return 0 end
return endStamp-curStamp
end
local endStamp=UITYTongXingZhengModel:getEndTime(guid)
if endStamp==nil then return 0 end
return endStamp-curStamp
end

function myzsModel:getTxzReddot()
if not self:checkOpen()then return false end
local guid=myzsModel:getTxzGuid()
return UITYTongXingZhengModel:getReddot(guid)
end

function myzsModel:checkTxzInStop()
local guid=myzsModel:getTxzGuid()
if guid==nil then return true end

local curStamp=timeHelper.getServerShortTime()
local endStamp=UITYTongXingZhengModel:getEndTime(guid)

return curStamp>=endStamp
end



function myzsModel:checkOpen()
local isSysOpen=systemModel.isOpen(SYSTEM_DEFINE.eMingYuanZhuSha)
if not isSysOpen then return false end

local isInit=myzsModel:getInitFinishFlag()
if not isInit then return false end

local openDay_conf=myzsModel:getBaseConfig('server_open_day')
local openDay_server=timeHelper.getServerOpenDay_kf()
return openDay_server>=openDay_conf
end


function myzsModel:setInitFinishFlag(flag)
self.initFinishFlag=flag==1
end

function myzsModel:getInitFinishFlag()
return self.initFinishFlag or false
end


function myzsModel:setSeasonType(isBigCross)
self.isBigCross=isBigCross==1 and 2 or 1
end

function myzsModel:getSeasonType()
return self.isBigCross
end
