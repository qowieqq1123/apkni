







activitiesHandle_tianxuyishi=new_activitiesHandle('activitiesHandle_tianxuyishi',activitiesHandle)






function activitiesHandle_tianxuyishi:onInit()

end


function activitiesHandle_tianxuyishi.recv_247_111(actid,act2id,len,list)





local subType=SUB_ACTIVITY_TYPE.eTianXuYiShi
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

local goodLookup={}
if len>0 then
for i,v in ipairs(list)do
goodLookup[v.param_1]=v.param_2
end
end
data.goodLookup=goodLookup
activitiesModel:setSubActInfoData(actID,subType,subid,data)
UIManager:invokeUIMethod('UISubAct_tianxuyishiWin','rec_refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_tianxuyishi.recv_247_112(actid,act2id,dhId,times)





local subType=SUB_ACTIVITY_TYPE.eTianXuYiShi
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil or data.goodLookup==nil then return end

if data.goodLookup==nil then
data.goodLookup={}
end
data.goodLookup[dhId]=times
activitiesModel:setSubActInfoData(actID,subType,subid,data)

timeEventController.delayDo(0.1,function()
UIManager:invokeUIMethod('UISubAct_tianxuyishiWin','rec_buy',dhId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end)
end