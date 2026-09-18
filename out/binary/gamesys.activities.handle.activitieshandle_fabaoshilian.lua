







activitiesHandle_fabaoshilian=new_activitiesHandle('activitiesHandle_fabaoshilian',activitiesHandle)




function activitiesHandle_fabaoshilian:onInit()

end


function activitiesHandle_fabaoshilian.recv_249_162(actid,act2id,monidx,len,list)








local subType=SUB_ACTIVITY_TYPE.eFaBaoShiLian
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.monidx=monidx
local lp={}
if len>0 then
for i,v in ipairs(list)do
lp[v.param_1]=v.param_2
end
end
data.monidx_lp=lp
activitiesModel:setSubActInfoData(actID,subType,subid,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_fabaoshilian.recv_249_163(actid,act2id,monidx,times)





local subType=SUB_ACTIVITY_TYPE.eFaBaoShiLian
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.monidx_lp[monidx]=times
activitiesModel:setSubActInfoData(actID,subType,subid,data)
UIManager:invokeUIMethod('UISubAct_fabaoshilian_win','rec_refresh',monidx)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end