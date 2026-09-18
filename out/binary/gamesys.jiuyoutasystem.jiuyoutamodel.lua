






local _MODULENAME="JiuYouTaModel"

JIUYOUTA_RANK_TYPE=
{
eLocal=1,
eCross=2,
eXianJie=3,
}


def_table(_MODULENAME)
JiuYouTaModel.name=_MODULENAME
JiuYouTaModel.data={}

function JiuYouTaModel:onAppStart()

end


function JiuYouTaModel:onEnterState(isReconnect)
self.data.selectRewardData={}
self.data.recordList={}
end


function JiuYouTaModel:onProtocolReq()

end


function JiuYouTaModel:onLeaveState(isReconnect)

self.data={}
end


function JiuYouTaModel:getRankConfig(rankType)
local config=cfg_jiuyoutalayerconfig()
rankType=rankType or JiuYouTaModel:getJiuYouTaRankType()or 1
return config[rankType]
end







function JiuYouTaModel:setJiuYouTaRankType(rType)
self.data.rankType=rType
end

function JiuYouTaModel:setJiuYouTaRating(rating)
self.data.rating=mathHelper.int64_to_number(rating)
end

function JiuYouTaModel:getJiuYouTaRating()
return self.data.rating or 1
end


function JiuYouTaModel:initJiuYouTaClearNumber()
local rankDataList=rankListModel:getRankList(JiuYouTaModel:getJiuYouTaRankListType(self.data.rankType))or defaultT
local number=0
local layer
local topLayer=JiuYouTaModel:getTopLayer()
for i,v in ipairs(rankDataList)do
layer=mathHelper.int64_to_number(v.zmFight)
if layer>=topLayer then
number=number+1
end
end
self.data.clearNumber=number

return number
end

function JiuYouTaModel:getJiuYouTaClearNumber()
if not self.data.clearNumber then
return JiuYouTaModel:initJiuYouTaClearNumber()
else
return self.data.clearNumber
end
end

function JiuYouTaModel:getMonsterFightVal(layer,index)
local config=cfg_jiuyoutalayerconfig()
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local cfg=config[rankType][layer]
local powerList=cfg.mon_power
local rating=JiuYouTaModel:getJiuYouTaRating()
return powerList[rating][index]or powerList[rating][#powerList[rating]]
end

function JiuYouTaModel:set_first_reddot()
local now=gameUtilityModel.getServerLongTime()
userActorSetting.set('jiu_you_ta_red',now)
userActorSetting.flush()
end

function JiuYouTaModel:get_first_reddot()
local stamp=userActorSetting.get('jiu_you_ta_red',nil)
if stamp then
local y,m,d=timeHelper.getServerStampData(stamp)
local oy,om,od=timeHelper.getServerData()
return m~=om
end
return true
end

function JiuYouTaModel:setDayChallengeReddot()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eJiuYouTaTiaoZhanReddot)
if not flag then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eJiuYouTaTiaoZhanReddot,true)
end
end

function JiuYouTaModel:getDayChallengeReddot()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eJiuYouTaTiaoZhanReddot)
if flag then
return false
end
local isBanPlay,banPlayTime=JiuYouTaModel:isInBanPlayTime()
if JiuYouTaModel:isJiuYouTaUnlock()and not isBanPlay and not JiuYouTaModel:isClearAll()then
return true
end
return false
end

function JiuYouTaModel:getJiuYouTaRankType()
return self.data.rankType
end

local rankTypeLookup=
{
[JIUYOUTA_RANK_TYPE.eLocal]=eRankListType.eJiuYouTa1,
[JIUYOUTA_RANK_TYPE.eCross]=eRankListType.eJiuYouTa2,
[JIUYOUTA_RANK_TYPE.eXianJie]=eRankListType.eJiuYouTa3,
}

function JiuYouTaModel:getJiuYouTaRankListType(rankType)
return rankTypeLookup[rankType]or eRankListType.eJiuYouTa1
end

local scoreRankTypeLookup=
{
[JIUYOUTA_RANK_TYPE.eLocal]=eRankListType.eJiuYouTaJiFen1,
[JIUYOUTA_RANK_TYPE.eCross]=eRankListType.eJiuYouTaJiFen2,
[JIUYOUTA_RANK_TYPE.eXianJie]=eRankListType.eJiuYouTaJiFen3,
}

local _logTypeLookup=
{
[JIUYOUTA_RANK_TYPE.eLocal]=eRankListType.eLocal,
[JIUYOUTA_RANK_TYPE.eCross]=eFightLogReqType.eCross,
[JIUYOUTA_RANK_TYPE.eXianJie]=eRankListType.eBigCrossAndLocal,
}

function JiuYouTaModel:getJiuYouTaScoreRankListType(rankType)
return scoreRankTypeLookup[rankType]or eRankListType.eJiuYouTaJiFen1
end

function JiuYouTaModel:getJiuYouTaLogType(rankType)
return _logTypeLookup[rankType]or eRankListType.eLocal
end

function JiuYouTaModel:isJiuYouTaUnlock()
local cfg=cfgHelper.get1(cfg_jiuyoutabasicconfig_get,1)
local need_syt_layer=cfg.need_syt_layer
local shiliantaLayer=shiLianTaModel:getCurLayer()

local rType=self:getJiuYouTaRankType()
if not rType or rType==0 then
return false,4
end

local versionId=pfwindowslController:getGameVersion()
local checkDay=cfg.rank_type[versionId][1]
local day_=timeHelper.getServerOpenDay()
if day_<checkDay then
return false,1
end


if need_syt_layer[rType]>shiliantaLayer then
return false,3
end

return true
end


function JiuYouTaModel:getResultTime()
local cfg=cfgHelper.get1(cfg_jiuyoutabasicconfig_get,1)
local reward_time=cfg.reward_time
local y,m,d=timeHelper.getServerData()
if d<=reward_time[1]then
return timeHelper.timeServer(y,m,reward_time[1],reward_time[2],reward_time[3],reward_time[4])
else
if m==12 then
return timeHelper.timeServer(y+1,1,reward_time[1],reward_time[2],reward_time[3],reward_time[4])
else
return timeHelper.timeServer(y,m+1,reward_time[1],reward_time[2],reward_time[3],reward_time[4])
end
end
end

function JiuYouTaModel:setBeginTime(beginTime)
self.data.beginTime=beginTime
end


function JiuYouTaModel:getBeginTime()
return self.data.beginTime
end

function JiuYouTaModel:getStartMonth()
local beginTime=JiuYouTaModel:getBeginTime()
local y,m,d=timeHelper.getServerStampData(timeHelper.convertLongStamp(beginTime))
return m
end


function JiuYouTaModel:isInBanPlayTime()
local cfg=cfgHelper.get1(cfg_jiuyoutabasicconfig_get,1)
local top_time=cfg.top_time
local start_time=cfg.start_time
local y,m=timeHelper.getServerData()
local top_stamp=timeHelper.timeServer(y,m,top_time[1],top_time[2],top_time[3],top_time[4])-30
local start_stamp=timeHelper.timeServer(y,m,start_time[1],start_time[2],start_time[3],start_time[4])
local now=timeHelper.getServerLongTime()
return now>=top_stamp and now<start_stamp,start_stamp
end




function JiuYouTaModel:getTopLayer()
if not self.data.topLayer then
local config=cfg_jiuyoutalayerconfig()
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local cfg=config[rankType]
self.data.topLayer=cfg[#cfg].layer_id
return self.data.topLayer
else
return self.data.topLayer
end

end

function JiuYouTaModel:setClearLayer(curLayer)
self.data.curLayer=curLayer
end

function JiuYouTaModel:getClearLayer()
return self.data.curLayer or 0
end



function JiuYouTaModel:isClearAll(layer)
layer=layer or self:getClearLayer()
return layer==JiuYouTaModel:getTopLayer()
end


function JiuYouTaModel:getCurLayer()
local clearLayer=self:getClearLayer()
return clearLayer==JiuYouTaModel:getTopLayer()and clearLayer or clearLayer+1
end


function JiuYouTaModel.getLayerMonsterGroupList(layer)
local config=cfg_jiuyoutalayerconfig()
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local cfg=config[rankType][layer]
if cfg then
local month=JiuYouTaModel:getStartMonth()
local length=#cfg.monster_groub_list
if length==1 then
return cfg.monster_groub_list[1]
else
return cfg.monster_groub_list[month]
end
end
end


function JiuYouTaModel:setSectionRewardData(len,layerList)
local selectRewardData={}
local scoreData={}
if len>0 then
for i,v in ipairs(layerList)do
selectRewardData[v.param_1]=v.param_2
scoreData[v.param_1]=v.param_3
end
end
self.data.selectRewardData=selectRewardData
self.data.allScore=nil
self.data.scoreData=scoreData
end

function JiuYouTaModel:setSectionRewardGot(layer_id,len,idxList)
if len>0 then
local selectReward=self.data.selectRewardData[layer_id]or 0
for i,v in ipairs(idxList)do
selectReward=bitHelper.set_1(selectReward,v-1)
end
self.data.selectRewardData[layer_id]=selectReward
end
end


function JiuYouTaModel:getSectionRewardData()
return self.data.selectRewardData or{}
end

function JiuYouTaModel:isSectionRewardGot(layer_id,idx)
return bitHelper.check_pos(self.data.selectRewardData[layer_id]or 0,idx-1)
end

function JiuYouTaModel:setScore(layer_id,score)
self.data.allScore=nil
self.data.scoreData[layer_id]=score
end

function JiuYouTaModel:getScore(layer_id)
return self.data.scoreData[layer_id]or 0
end

function JiuYouTaModel:getAllScore()
if self.data.allScore then
return self.data.allScore
end
local score=0
for i,v in pairs(self.data.scoreData)do
score=score+v
end
self.data.allScore=score
return score
end

function JiuYouTaModel:initSectionRewardConfig()
local sectionRewardConfig={}
local cfg=cfg_jiuyoutalayerconfig()
for rankType,v in ipairs(cfg)do
sectionRewardConfig[rankType]=sectionRewardConfig[rankType]or{}
local index=0
for _,cfg in ipairs(v)do
if cfg.stage_reward then
index=index+1
for _,layer in ipairs(cfg.stage_range)do
sectionRewardConfig[rankType][layer]={index=index,stage_reward=cfg.stage_reward}
end
end
end
end
self.SectionRewardConfig=sectionRewardConfig
end


function JiuYouTaModel:getLayerSection(layer)
if not self.SectionRewardConfig then
self:initSectionRewardConfig()
end
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
return self.SectionRewardConfig[rankType][layer]
end

function JiuYouTaModel:getExLayer(layer)
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local config=cfg_jiuyoutalayerconfig()
local cfg=config[rankType][layer]
if cfg then
return cfg.ex_layer==1
end
end

function JiuYouTaModel:getAimLayer(layer)
if not self.SectionRewardConfig then
self:initSectionRewardConfig()
end
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
if not self.SectionRewardConfig[rankType][layer]then
local l
for k,v in pairs(self.SectionRewardConfig[rankType])do
if layer<k then
if not l then
l=k
end
if l>=k then
l=k
end
end
end
if l then
return l,2
end
return layer,3
else
return layer,1
end
end


function JiuYouTaModel:getCurAimLayer()
local clearLayer=self:getClearLayer()
local layer,reType=self:getAimLayer(clearLayer)
return layer,reType
end

function JiuYouTaModel:setSectionRewardState()
local clearLayer=JiuYouTaModel:getClearLayer()
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local config=JiuYouTaModel:getRankConfig(rankType)
self.data.SelectLayer=nil
for i,v in ipairs(config)do
local layer=v.layer_id
if v.stage_reward and clearLayer>=layer then
local clearTimes,gotTimes=0,0
for i,v in ipairs(v.stage_range)do
if clearLayer>=v then
clearTimes=clearTimes+1
end
if JiuYouTaModel:isSectionRewardGot(layer,i)then
gotTimes=gotTimes+1
end
end
if v.stage_range[gotTimes+1]then
self.data.SelectLayer=v.stage_range[gotTimes+1]
end
if clearTimes>gotTimes then
self.data.selectRewardState=true
return
end
end
end
self.data.selectRewardState=false
end

function JiuYouTaModel:getSectionRewardState()
return self.data.selectRewardState
end

function JiuYouTaModel:getSectionSelectLayer()
return self.data.SelectLayer
end

function JiuYouTaModel:setRecordList(layer_id,maxFightInfo,minFightInfo,recordList,req_time,maxScoreInfo)
self.data.recordList[layer_id]=self.data.recordList[layer_id]or{}
self.data.recordList[layer_id].reqTime=req_time
self.data.recordList[layer_id].maxFightInfo=maxFightInfo
self.data.recordList[layer_id].minFightInfo=minFightInfo
self.data.recordList[layer_id].maxScoreInfo=maxScoreInfo
self.data.recordList[layer_id].list=recordList or{}
end

function JiuYouTaModel:getRecord(layer_id)
if self.data.recordList[layer_id]then
return self.data.recordList[layer_id]
end
end

function JiuYouTaModel:getRecordReqTime(layer_id)
if self.data.recordList[layer_id]then
return self.data.recordList[layer_id].reqTime
end
end

function JiuYouTaModel:dealScoreRankData(rankType)
local list=rankListModel.data[rankType]or{}
local temp={}
for i,v in ipairs(list)do
local data={}
for kk,vv in pairs(v)do
data[kk]=vv
end
data.data={''}
data.playerName=v.name
data.score=v.zmFight
data.rankNum=v.rank
data.zmName=loginModel:getServerName(data.serverId)
table.insert(temp,data)
end
return temp
end



function JiuYouTaModel:setSelectZhenFa(zhenFaId)
self.data.selectZhenFa=zhenFaId
end

function JiuYouTaModel:getSelectZhenFa()
return self.data.selectZhenFa or 0
end


function JiuYouTaModel:setPlayingBattle(battleId)
self.data.battleId=battleId
end

function JiuYouTaModel:getPlayingBattle()
return self.data.battleId
end

function JiuYouTaModel:insertGuaJIReward(list)
if not self.data.guaJIReward then
self.data.guaJIReward={}
end
for i,v in ipairs(list)do
table.insert(self.data.guaJIReward,v)
end
end
function JiuYouTaModel:getGuaJIReward()
return self.data.guaJIReward or{}
end
function JiuYouTaModel:clearGuaJIReward()
self.data.guaJIReward={}
end

function JiuYouTaModel:setGuaJILayer(layer)
self.data.guaJILayer=layer
end
function JiuYouTaModel:getGuaJILayer()
return self.data.guaJILayer
end

function JiuYouTaModel:setGuaJILoseLayer(layer)
self.data.guaJILoseLayer=layer
end

function JiuYouTaModel:getGuaJILoseLayer()
return self.data.guaJILoseLayer
end


function JiuYouTaModel:setFightingLayer(layer)
self.data.fightingLayer=layer
end

function JiuYouTaModel:getFightingLayer()
return self.data.fightingLayer
end

function JiuYouTaModel:setGuaJILoseArgs(atgs)
self.data.guaJILoseArgs=atgs
end
function JiuYouTaModel:getGuaJILoseArgs()
return self.data.guaJILoseArgs
end


function JiuYouTaModel:addHUD(hudid)
self.hudid=hudid
end

function JiuYouTaModel:getHUD()
return self.hudid
end