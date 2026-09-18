







activitiesHandle_xianmengtequan=new_activitiesHandle('activitiesHandle_xianmengtequan',activitiesHandle)

function activitiesHandle_xianmengtequan:onInit()

end


function activitiesHandle_xianmengtequan.recv_249_164(actid,act2id,len,list)
local subType=SUB_ACTIVITY_TYPE.eXianMengTeQuan

local tequanData={}
if list then
for i,v in ipairs(list)do
tequanData[v.param_1]=v.param_2
end
end
local data=
{
list=tequanData
}
activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIXianShuControl:onInitTQ()
taskController:onInitTQ()

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_xianmengtequan.recv_249_165(actid,act2id,info)
local subType=SUB_ACTIVITY_TYPE.eXianMengTeQuan
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
if data then
data.list=data.list or{}
data.list[info.param_1]=info.param_2
end

if info.param_1==1 then
UIManager.info("加入仙盟的冷却时间已清除")
local func=xianmengController:getAfterUseTimeFunc()
if func then
func()
end
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

