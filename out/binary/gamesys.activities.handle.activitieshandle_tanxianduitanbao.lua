





activitiesHandle_tanxianduitanbao=new_activitiesHandle('activitiesHandle_tanxianduitanbao',activitiesHandle)

function activitiesHandle_tanxianduitanbao:onInit()

end

function activitiesHandle_tanxianduitanbao.recv_249_108(...)




local args={...}

local subType=SUB_ACTIVITY_TYPE.eTanXianLiBao
local actID=args[1]
local subID=args[2]

local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

local len=args[3]
data.arry={}
if len>0 then
data.arry=args[4]
end

activitiesModel:setSubActInfoData(actID,subType,subID,data)
UIManager:invokeUIMethod('UISubAct_TXDLB_mainWin','refreshScrollerView',actID,subType,subID)

UIManager:invokeUIMethod('UISubAct_GTLB_mainWin','refreshScrollerView',actID,subType,subID)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_tanxianduitanbao.checkreddot(actid,act2id)
local mydata=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eTanXianLiBao,act2id)
local reddot=false
if mydata then
local cfg=cfg_buyact4config_get(act2id).rewards
local bugdata=mydata.arry

for i,j in ipairs(cfg)do
local temp1=j[3]
local temp2=j[4]
if#temp1==0 and#temp2==0 then
reddot=true
break
end
end

for k,v in ipairs(bugdata)do
local cfg_reward=cfg[v.param_1]
if cfg_reward and#cfg_reward[3]==0 and#cfg_reward[4]==0 then
local xiangounum=cfg_reward[1]
local buynum=v.param_2
if buynum>=xiangounum then
reddot=false
break
end
end
end
end
return reddot
end

