







activitiesHandle_xianguyiji=new_activitiesHandle('activitiesHandle_xianguyiji',activitiesHandle)

function activitiesHandle_xianguyiji:onInit()

end

function activitiesHandle_xianguyiji:reqExchange(actId,subId,gift,num)

local subType=SUB_ACTIVITY_TYPE.eXianGuYiJi
local idxList={}
for i=1,num do
table.insert(idxList,gift)
end
local jstr=jsonHelper.encode({2,idxList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_xianguyiji.recv_249_27(args)
local subType=SUB_ACTIVITY_TYPE.eXianGuYiJi
local actId=args[1]
local subId=args[2]
local free=args[3]
local star=args[4]
local great=args[5]
local good=args[6]
local bad=args[7]
local len=args[8]or 0
local array=args[9]

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end
local exchanges={}
for i=1,len do
local v=array[i]
exchanges[v.param_1]=v.param_2
end
local config=activitiesModel:getSubActivityConfig(subType,subId)
for i,v in ipairs(config.gift)do
if not exchanges[i]then
exchanges[i]=0
end
end
local fullValue=nil
local fullReddot=nil
for i,v in ipairs(config.gift)do
fullValue=fullValue and math.min(fullValue,v[3])or v[3]
fullReddot=fullReddot and math.max(fullReddot,v[3])or v[3]
end
if info:hasData()then
info.data.free=free
info.data.star=star
info.data.great=great
info.data.good=good
info.data.bad=bad
info.data.exchanges=exchanges
info.data.fullValue=fullValue
info.data.fullReddot=fullReddot

else
local data={
free=free,
star=star,
great=great,
good=good,
bad=bad,
exchanges=exchanges,
fullValue=fullValue,
fullReddot=fullReddot,

}
info:setData(data)
end
UIManager:invokeUIMethod("UISubAct_xianguyijiWin","refreshView",actId,subType,subId)
UIManager:invokeUIMethod("UISubAct_xianguyijiWin_TanSuoReward","refreshView",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_xianguyiji.recv_249_28(actId,subId,len,array)
local subType=SUB_ACTIVITY_TYPE.eXianGuYiJi
local subActInfo=activitiesModel:getSubActInfo(actId,subType,subId)
subActInfo:setCommentData(array or{})
UIManager:invokeUIMethod("UISubAct_xianguyijiWin","checkLuckReddot",actId,subType,subId)
UIManager:invokeUIMethod("UISubAct_xianguyijiWin_RenPin","refreshView",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_xianguyiji.recv_249_29(args)
local actId=args[1]
local subId=args[2]
local star=args[3]
local len=args[4]
local array=args[5]
local code=args[6]
if code==1 then
local subType=SUB_ACTIVITY_TYPE.eXianGuYiJi
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData then
infoData.data.star=star
if len>0 then
for i,v in ipairs(array)do
infoData.data.exchanges[v.param_1]=v.param_2
end
end
UIManager:invokeUIMethod("UISubAct_xianguyijiWin","refreshView_OnlyExplore",actId,subType,subId)
UIManager:invokeUIMethod("UISubAct_xianguyijiWin_TanSuoReward","refreshView",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
elseif code==2 then
UIManager.error("兑换次数不足")
return
elseif code==3 then
UIManager.error("探索值不足")
return
end
end


function activitiesHandle_xianguyiji:autoReceiveFreeLottery(checkReddot)
local subType=SUB_ACTIVITY_TYPE.eXianGuYiJi
local actList=activitiesModel:getActSubList_subType_open_doing(subType)
local protocolData={}
if actList then
for _,sub_actInfo in ipairs(actList)do
local act_id=sub_actInfo.act_id
local sub_act_id=sub_actInfo.sub_act_id
if sub_actInfo:checkFree()then
if checkReddot then
return true
end
local num=1
local is_assistant=1
local jsonStr=jsonHelper.encode({1,num,is_assistant})
table.insert(protocolData,{act_id,sub_act_id,jsonStr})
end
end
end
if#protocolData>0 then
for i,v in ipairs(protocolData)do
local act_id=v[1]
local sub_act_id=v[2]
local jsonStr=v[3]
activitiesController:sendProtocol(actSendType.eComonReqHandle,act_id,subType,sub_act_id,jsonStr)
end
end
end