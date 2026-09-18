







activitiesHandle_longhudaodan=new_activitiesHandle('activitiesHandle_longhudaodan',activitiesHandle)

function activitiesHandle_longhudaodan:onInit()

end


function activitiesHandle_longhudaodan.recv_249_191(args)
local actType=SUB_ACTIVITY_TYPE.eLongHuMountain
local actid=args[1]
local act2id=args[2]
local excute_id=args[3]
local excute_len=args[4]
local excuteList=args[5]
local has_recv=args[6]
local progress=args[7]

local data={
excute_id=excute_id,
excute_len=excute_len,
excuteList=excuteList,
has_recv=has_recv,
progress=progress
}
activitiesModel:setSubActInfoData(actid,actType,act2id,data)
end


function activitiesHandle_longhudaodan.recv_249_192(actid,act2id,excute_id,excute_time)
local actType=SUB_ACTIVITY_TYPE.eLongHuMountain

local data=activitiesModel:getSubActInfoData(actid,actType,act2id)or{}
data.excute_id=excute_id
data.excute_len=1
data.excuteList={{param_1=0,param_2=excute_time}}

activitiesModel:setSubActInfoData(actid,actType,act2id,data)

UIManager:invokeUIMethod("UISubAct_LongHuDaoDan_Win","updateState")
end


function activitiesHandle_longhudaodan.recv_249_193(actid,act2id,times,score,next_excute_time)
local actType=SUB_ACTIVITY_TYPE.eLongHuMountain

local data=activitiesModel:getSubActInfoData(actid,actType,act2id)
data.excuteList[times].param_1=score
data.excuteList[times+1]={param_1=0,param_2=next_excute_time}
data.excute_len=#data.excuteList
activitiesModel:setSubActInfoData(actid,actType,act2id,data)

UIManager:invokeUIMethod("UISubAct_LongHuDaoDan_Win","updateState")
end


function activitiesHandle_longhudaodan.recv_249_202(actid,act2id)
local actType=SUB_ACTIVITY_TYPE.eLongHuMountain

local data=activitiesModel:getSubActInfoData(actid,actType,act2id)
data.has_recv=1
activitiesModel:setSubActInfoData(actid,actType,act2id,data)

UIManager:invokeUIMethod("UISubAct_LongHuDaoDan_Win","refreshProgressReward")
end


function activitiesHandle_longhudaodan.recv_249_204(actid,act2id,progress)
local actType=SUB_ACTIVITY_TYPE.eLongHuMountain

local data=activitiesModel:getSubActInfoData(actid,actType,act2id)
data.progress=progress
activitiesModel:setSubActInfoData(actid,actType,act2id,data)

UIManager:invokeUIMethod("UISubAct_LongHuDaoDan_Win","refreshProgressReward")
UIManager:invokeUIMethod("UISubAct_LongHuDaoDan_Win","refreshCost")
end

function activitiesHandle_longhudaodan.sendBeginLianDan(actid,act2id,type)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eLongHuMountain,act2id,jsonHelper.encode({1,type}))
end

function activitiesHandle_longhudaodan.sendControlFireGame(actid,act2id,lv)
UIManager:invokeUIMethod("UISubAct_LongHuDaoDan_Win","showOverEffect",lv)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eLongHuMountain,act2id,jsonHelper.encode({2,lv}))
end

function activitiesHandle_longhudaodan.sendEndLianDan(actid,act2id)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eLongHuMountain,act2id,jsonHelper.encode({3}))
end

function activitiesHandle_longhudaodan.sendGetProgressReward(actid,act2id)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eLongHuMountain,act2id,jsonHelper.encode({4}))
end

function activitiesHandle_longhudaodan:checkLianDanReddot(subid,subType,type,isTips)
local config=activitiesModel:getSubActivityConfig(subType,subid)

local isRed=true
local costs=config.costs[type]
for i,v in ipairs(costs)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
if isTips then
UIManager.error('材料不足')
gainControl:showGainWin(v[1])
end
isRed=false
break
end
end

return isRed
end

function activitiesHandle_longhudaodan:checkProgressRewardReddot(actid,subType,subid)
local config=activitiesModel:getSubActivityConfig(subType,subid)
local data=activitiesModel:getSubActInfoData(actid,subType,subid)
local cur=data.progress or 0
local need=config.progress_reward[1]
local has_recv=data.has_recv==1
return not has_recv and cur>=need
end