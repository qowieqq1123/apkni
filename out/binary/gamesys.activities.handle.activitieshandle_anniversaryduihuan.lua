







activitiesHandle_anniversaryduihuan=new_activitiesHandle('activitiesHandle_anniversaryduihuan',activitiesHandle)






function activitiesHandle_anniversaryduihuan:onInit()

end


function activitiesHandle_anniversaryduihuan.recv_247_42(args)
local actID=args[1]
local subid=args[2]
local exchange_list_len=args[3]
local exchange_list=args[4]
local share_times=args[5]
local share_list_len=args[6]
local share_list=args[7]

local subType=SUB_ACTIVITY_TYPE.eExchangeAct3config
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

local goodLookup={}
if exchange_list_len>0 then
for i,v in ipairs(exchange_list)do
goodLookup[v.param_1]=v
end
end
data.goodLookup=goodLookup

data.share_times=share_times

local shareLookup={}
if share_list_len>0 then
for i,v in ipairs(share_list)do
shareLookup[v.share_id]=v
end
end
data.shareLookup=shareLookup
data.share_list_len=share_list_len
data.hasShareChange=true

activitiesModel:setSubActInfoData(actID,subType,subid,data)
UIManager:invokeUIMethod('UISubAct_AnniversaryDuiHuanWin','rec_refresh')
UIManager:invokeUIMethod('UISubAct_AnniversaryDuiHuan_HuHuanWin','rec_shareList')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_anniversaryduihuan.recv_247_43(actid,act2id,exchange_idx,num)
local subType=SUB_ACTIVITY_TYPE.eExchangeAct3config
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil or data.goodLookup==nil then return end

local d=data.goodLookup[exchange_idx]
if d==nil then
d={param_1=exchange_idx}
data.goodLookup[exchange_idx]=d
end
d.param_2=num

activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_AnniversaryDuiHuanWin','rec_buy',exchange_idx)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_anniversaryduihuan.recv_247_44(args)
local actID=args[1]
local subid=args[2]
local rank_len=args[3]
local rank=args[4]
local m_rank=args[5]
local m_score=args[6]
local subType=SUB_ACTIVITY_TYPE.eExchangeAct3config
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.rank=rank or{}
data.m_rank=m_rank or 0
data.m_score=m_score or 0

activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_AnniversaryDuiHuanWin','rec_myRank')
UIManager:invokeUIMethod('UISubAct_AnniversaryDuiHuanRankWin','refreshRankList',rank or{})
end


function activitiesHandle_anniversaryduihuan.recv_247_45(actid,act2id,len,share_list)
local subType=SUB_ACTIVITY_TYPE.eExchangeAct3config
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil or data.shareLookup==nil then return end

for i,v in ipairs(share_list)do
local share_id=v.param_1
local item_num=v.param_2
local can_share_num=v.param_3
local actorId=data.shareLookup[share_id].actor_id
if playerModel:checkActorId(actorId)and can_share_num>0 then
data.share_times=can_share_num
end
if item_num==0 then
data.shareLookup[share_id]=nil
else
data.shareLookup[share_id].item_num=item_num
data.shareLookup[share_id].can_share_num=can_share_num
end
end
data.hasShareChange=true

activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_AnniversaryDuiHuan_HuHuanWin','rec_shareList')
end


function activitiesHandle_anniversaryduihuan.recv_247_46(actid,act2id,share_struct)
local subType=SUB_ACTIVITY_TYPE.eExchangeAct3config
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)

if data==nil or data.shareLookup==nil then return end
data.shareLookup[share_struct.share_id]=share_struct
data.hasShareChange=true

activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_AnniversaryDuiHuan_HuHuanWin','rec_shareList')
end


function activitiesHandle_anniversaryduihuan.recv_247_47(actid,act2id,m_rank,m_score)
local subType=SUB_ACTIVITY_TYPE.eExchangeAct3config
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)

if data==nil then return end

data.m_rank=m_rank or 0
data.m_score=m_score or 0

activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_AnniversaryDuiHuanWin','rec_myRank')
end