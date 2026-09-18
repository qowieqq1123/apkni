







eChiSeJinDiRoundType={
Reward=1,
Disciple=2,
Weapon=3,
FaZe=4,
Fight=5,
Hidden=6,
Monster=7,
}
eChiSeJinDiGuideType={
FightTrigger=1,
}

activitiesHandle_chisejindi=new_activitiesHandle('activitiesHandle_chisejindi',activitiesHandle)

function activitiesHandle_chisejindi:onInit()

end





function activitiesHandle_chisejindi:reqRankData(actId,subId)
self:reqServerHandle(actId,subId,2)
end





function activitiesHandle_chisejindi:reqGetStageReward(actId,subId,stageIdx)
self:reqServerHandle(actId,subId,3,stageIdx)
end




function activitiesHandle_chisejindi:reqGetDailyReward(actId,subId)
self:reqServerHandle(actId,subId,4)
end





function activitiesHandle_chisejindi:reqGetTargetReward(actId,subId,targets)
self:reqServerHandle(actId,subId,5,unpack(targets))
end




function activitiesHandle_chisejindi:reqEnterCopy(actId,subId)
self:reqServerHandle(actId,subId,6)
end




function activitiesHandle_chisejindi:reqNextCopyRound(actId,subId)
self:reqServerHandle(actId,subId,7)
end





function activitiesHandle_chisejindi:reqSelectCopyItem(actId,subId,selectIdx)
self:reqServerHandle(actId,subId,8,selectIdx)
end




function activitiesHandle_chisejindi:reqRefreshCopyItem(actId,subId)
self:reqServerHandle(actId,subId,9)
end






function activitiesHandle_chisejindi:reqCopyFight(actId,subId,disciple1,weapon1,disciple2,weapon2,disciple3,weapon3,disciple4,weapon4,disciple5,weapon5)
self:reqServerHandle(actId,subId,10,disciple1,weapon1,disciple2,weapon2,disciple3,weapon3,disciple4,weapon4,disciple5,weapon5)
end





function activitiesHandle_chisejindi:reqSellCopyItem(actId,subId,roundType,ids)
self:reqServerHandle(actId,subId,11,roundType,unpack(ids))
end




function activitiesHandle_chisejindi:reqResultCopy(actId,subId)
self:reqServerHandle(actId,subId,12)
end




function activitiesHandle_chisejindi:reqGetRoundMoney(actId,subId)
self:reqServerHandle(actId,subId,13)
end

function activitiesHandle_chisejindi:reqRefreshActivityData(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local actInfo={actId,subType,subId}
activitiesController:sendProtocol(actSendType.eReqInfoList,activitiesServerType.eKuafu,{actInfo})
end

function activitiesHandle_chisejindi:reqServerHandle(actId,subId,reqType,...)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local jstr=jsonHelper.encode({reqType,...})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_chisejindi:GMCopyRoundData(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info then
local copyData=info:getCopy()
if copyData then
local roundData=copyData.roundData

else
UIManager.error("没有副本数据")
end
else
UIManage.error("活动不存在")
end
end


function activitiesHandle_chisejindi.recv_249_230(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end
info:addCopyRoundMoney()
end


function activitiesHandle_chisejindi.recv_249_231(args)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local actId=args[1]
local subId=args[2]
local dailyEnterCnt=args[3]
local dailyScoreNum=args[4]
local dailyScoreFlag=args[5]
local stageScoreNum=args[6]
local stageRewardFlag=args[7]
local targetFlagLen=args[8]
local targetFlagList=args[9]
local continue=args[10]

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

local data=info:getData()
local stage,stageNext=info:calculateStageEx(stageScoreNum)

if data then
data.dailyScore=dailyScoreNum
data.dailyFlag=dailyScoreFlag
data.stageScore=stageScoreNum
data.stage=stage
data.stageNext=stageNext
data.stageFlag=stageRewardFlag
data.copyTimes=dailyEnterCnt
data.continue=continue
table.clear(data.targetFlagLookup)
for i=1,targetFlagLen do
local v=targetFlagList[i]
data.targetFlagLookup[v.param_1]=v.param_2
end
else
local lookup={}
for i=1,targetFlagLen do
local v=targetFlagList[i]
lookup[v.param_1]=v.param_2
end
data={
dailyScore=dailyScoreNum,
dailyFlag=dailyScoreFlag,
stageScore=stageScoreNum,
stage=stage,
stageNext=stageNext,
stageFlag=stageRewardFlag,
targetFlagLookup=lookup,
copyTimes=dailyEnterCnt,
continue=continue,
}
info:setData(data)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eChiSeJinDi,info.start_time,info.end_time)
local limitInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eChiSeJinDi)
limitInfo:bindData(actId,subType,subId)
end







function activitiesHandle_chisejindi.recv_249_232(actId,subId,rankLen,rankList,myRank)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

local rankData=info:getRank()
if rankData then
rankData.rankList=rankList or{}
rankData.myRank=myRank
else
rankData={
rankList=rankList or{},
myRank=myRank,
}
info:setRank(rankData)
end
end





function activitiesHandle_chisejindi.recv_249_233(actId,subId,stageIdx)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

local data=info:getData()
if data==nil then return end

data.stageFlag=stageIdx

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end




function activitiesHandle_chisejindi.recv_249_234(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

local data=info:getData()
if data==nil then return end

data.dailyFlag=1

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end





function activitiesHandle_chisejindi.recv_249_235(actId,subId,len,targetList)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

local data=info:getData()
if data==nil then return end

if targetList then
for idx,targetIdx in ipairs(targetList)do
data.targetFlagLookup[targetIdx]=1
end
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_chisejindi.recv_249_236(args)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local actId=args[1]
local subId=args[2]
local template=args[3]
local round=args[4]
local money=args[5]
local level=args[6]
local plusHP=args[7]
local discipleLen=args[8]
local discipleList=args[9]
local weaponLen=args[10]
local weaponList=args[11]
local fazeLen=args[12]
local fazeList=args[13]
local roundData=args[14]

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

local data=info:getData()
if data==nil then return end
if data.continue==0 then
data.continue=1
data.copyTimes=data.copyTimes+1
end

local copyData=info:getCopy()
local maxHP=info:getSubActConfig("times")
if copyData then
copyData.template=template
copyData.money=money
copyData.round=round
copyData.level=level
copyData.hp=math.max(maxHP-plusHP,0)
copyData.discipleList=discipleList or{}
copyData.weaponList=weaponList or{}
copyData.fazeList=fazeList or{}
copyData.roundData=roundData
else
copyData={
template=template,
round=round,
money=money,
level=level,
hp=math.max(maxHP-plusHP,0),
discipleList=discipleList or{},
weaponList=weaponList or{},
fazeList=fazeList or{},
roundData=roundData,
}
info:setCopy(copyData)
end
info:setResult()

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end





function activitiesHandle_chisejindi.recv_249_237(actId,subId,roundData)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

local copyData=info:getCopy()
if copyData==nil then return end

info:nextCopyRound(roundData)
end







function activitiesHandle_chisejindi.recv_249_238(actId,subId,selectIdx,roundLen,roundList)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

local copyData=info:getCopy()
if copyData==nil then return end

info:selectCopyItem(selectIdx)

if roundLen>0 then
local roundData=roundList[1]
info:nextCopyRound(roundData)
end
end





function activitiesHandle_chisejindi.recv_249_239(actId,subId,roundData)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end


local copyData=info:getCopy()
if copyData==nil then return end

info:refreshRoundData(roundData)
end







function activitiesHandle_chisejindi.recv_249_240(actId,subId,targetLen,targetList)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

local copyData=info:getCopy()
if copyData==nil then return end

local data=info:getData()
if data==nil then return end
data.continue=0

info:resultCopy()
info:addTargetFlagLookup(targetList)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end







function activitiesHandle_chisejindi.recv_249_241(actId,subId,roundType,len,ids)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info==nil then return end

local copyData=info:getCopy()
if copyData==nil then return end

if ids then
info:sellCopyItem(roundType,ids)
end
end
