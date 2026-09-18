







activitiesHandle_lianqidahui=new_activitiesHandle('activitiesHandle_lianqidahui',activitiesHandle)

function activitiesHandle_lianqidahui:onInit(actId,subId)

end

function activitiesHandle_lianqidahui:onDelete()

end

function activitiesHandle_lianqidahui:reqStartGame(actId,subId)
local rankData
local _actId,_subType,_subId=activitiesHandle_lianqidahui.getRankActInfo()
if _actId then
rankData=activitiesModel:getSubActInfoData(_actId,_subType,_subId)
end
local rank=rankData and rankData.myRank or 0
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local jstr=jsonHelper.encode({1,rank})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end


function activitiesHandle_lianqidahui:reqPlayGame(actId,subId,dragType)
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local jstr=jsonHelper.encode({2,dragType})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_lianqidahui:reqEndGame(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local jstr=jsonHelper.encode({3})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_lianqidahui:reqDestroy(actId,subId,index)
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local jstr=jsonHelper.encode({4,index})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_lianqidahui:reqExchange(actId,subId,indexA,indexB)
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local jstr=jsonHelper.encode({5,indexA,indexB})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_lianqidahui:reqLevelUp(actId,subId,index)
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local jstr=jsonHelper.encode({6,index})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_lianqidahui:reqReceive(actId,subId,idList)
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local jstr=jsonHelper.encode({7,idList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_lianqidahui.recv_247_63(datas)
local actId=datas[1]
local subId=datas[2]
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local data={}
data.gridList=datas[4]
data.gameScore=datas[5]
data.totalScore=datas[6]
data.roundNum=datas[7]
local taskData={}
local cfg=cfgHelper.get1(cfg_artifactrefineconfig_get,subId)
local tasks=cfg.tasks
for k,v in pairs(tasks)do
taskData[k]={
taskId=k,
progress=0,
flag=1
}
end
if datas[8]>0 then
for i,v in ipairs(datas[9])do
local taskId=v.param_1
taskData[taskId]={
taskId=taskId,
progress=v.param_2,
flag=v.param_3
}
end
end
data.taskData=taskData
activitiesModel:setSubActInfoData(actId,subType,subId,data)

UIManager:callWindowFunc('UILianQiMG','refresh')
UIManager:callWindowFunc('UILianQiMGCJ','refresh')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_lianqidahui.recv_247_64(datas)
local actId=datas[1]
local subId=datas[2]
local result=datas[3]
if result==0 then
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local isNewGame=data.gridList==nil
data.gridList=datas[5]
data.gameScore=datas[8]
data.roundNum=datas[9]

local newItemList=datas[7]
UIManager:callWindowFunc('UILianQiMG','handlePlayResult',newItemList)

if isNewGame then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
else
UIManager.error('操作失败')
if result==-1 then
logErr('炼器大会操作失败：错误的滑动方向')
elseif result==-2 then
logErr('炼器大会操作失败：没找到配置')
elseif result==-3 then
logErr('炼器大会操作失败：消耗检测失败')
elseif result==-4 then
logErr('炼器大会操作失败：无可生成新格子（不能滑动）')
elseif result==-5 then
logErr('炼器大会操作失败：消耗失败')
elseif result==-6 then
logErr('炼器大会操作失败：游戏进行中')
elseif result==-7 then
logErr('炼器大会操作失败：辅助功能参数错误')
elseif result==-8 then
logErr('炼器大会操作失败：已到排行榜结算时间')
end
UIManager:callWindowFunc('UILianQiMG','handlePlayResult')
end
end

function activitiesHandle_lianqidahui.getRankActInfo()
local sub_actList=activitiesModel:getActSubList_subType_doing(SUB_ACTIVITY_TYPE.eRankActCross)
for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()then
local actInfo=activitiesModel:getActInfo(sub_actInfo.act_id)
if actInfo and actInfo:checkSubUnlock_first(true)then
local _actId,_subType,_subId=sub_actInfo:getBaseData2()
if _actId then
local config=activitiesModel:getSubActivityConfig(_subType,_subId)
if config.ranking_type==10 then
return _actId,_subType,_subId
end
end
end
end
end
end

function activitiesHandle_lianqidahui.recv_247_65(actId,subId,gameScore,totalScore,startMyRank)
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.gridList=nil
data.resultScore=data.gameScore
data.gameScore=gameScore
data.totalScore=totalScore
data.startMyRank=startMyRank

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

local waitRandk=false
local _actId,_subType,_subId=activitiesHandle_lianqidahui.getRankActInfo()
if _actId then
activitiesController:sendProtocol(actSendType.eComonReqInfo,_actId,_subType,_subId)
waitRandk=true
end
if not waitRandk then
UIManager:callWindowFunc('UILianQiMG','handleEndGame')
end
end

function activitiesHandle_lianqidahui.recv_247_66(actId,subId,len,arr)
local subType=SUB_ACTIVITY_TYPE.eLianQiDaHui
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if len>0 then
for i,v in ipairs(arr)do
local taskId=v.param_1
data.taskData[taskId]={
taskId=taskId,
progress=v.param_2,
flag=v.param_3
}
end
end
UIManager:callWindowFunc('UILianQiMG','setChengJiuReddot')
UIManager:callWindowFunc('UILianQiMGCJ','refresh')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end